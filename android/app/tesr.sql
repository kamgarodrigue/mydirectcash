CREATE DEFINER=`root`@`localhost` PROCEDURE `SEND_CASH`( 
  IN vAgentID    VARCHAR(20),  
  IN vAmount     DECIMAL,  
  IN vRate BIGINT,
  IN vFromNumber VARCHAR(15),  
  IN vToNumber   VARCHAR(15),  
  IN vCNI VARCHAR(15),
    IN vPIN VARCHAR(4)
   )
BEGIN
    
   DECLARE vTax DOUBLE;
   DECLARE vRandomID VARCHAR(10);
   DECLARE vClosingBalance DOUBLE;
   DECLARE vMerchantID  VARCHAR(20);
   DECLARE vSendRate double;
   DECLARE vDirectCashRate double;
   DECLARE vAgentName VARCHAR(45);
   DECLARE vReceiptTicker TEXT;
   DECLARE vTrxID VARCHAR(10);
   DECLARE vMerchantSendRate double;
    DECLARE vTop VARCHAR(45);
   DECLARE vTopRate double;
   DECLARE vNormalRate DOUBLE;

  SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED ;
  SELECT MerchantID INTO vMerchantID FROM AGENTS WHERE Agent_ID = vAgentID; 
  SELECT Sending into vMerchantSendRate FROM COMMISSIONSHARING where MerchantID = 'Merchant Default';
	select Tax into vTax from commissionsharing where MerchantID='Default';
	
     SELECT COALESCE(NORMALRATE,0) INTO vNormalRate FROM RATES WHERE TO_AMOUNT >= vAmount AND TARRIF IN 
 (SELECT TarrifName FROM TARRIFS WHERE ACTIVE = TRUE) LIMIT 1;
  COMMIT;

   SET  vTrxID = floor(rand() * 100000000);

     /*GENERATE RANDOM NUMBER */
   
   SET vRandomID =  UPPER(SUBSTRING(UUID(),1,7));
   
    INSERT INTO transactions  
      (Agent_ID, 
      TRX_Type,
      Amount,  
      TRXID,
      TRX_Status,  
      TRX_DATE,  
      TRX_Description,  
      Direct_Code,  
      From_Number,  
      To_Number,  
      IdentityID,  
      COMMISSION,
      PIN)  
     VALUES  
     (vAgentID,'P',vAmount,vTrxID,'P',NOW(),'MONEY XFER',vRandomID,vFromNumber,vToNumber,vCNI,vRate,vPIN);


  -- INSERT INTO AGENTS ACCOUNTS
    INSERT INTO `agentsaccounts`
		(
		`MerchantID`,
		`TrxID`,
		`Amount`,
		`Narrations`,
		`TrxType`,
		`CreatedOn`,
		`CreatedBy`)
		VALUES
		(
		 vAgentID,
		 vTrxID,
		 vAmount,
		Concat('Cash Sent','(',vAgentID,')'), 
		'DR',
		 NOW(),
		 vAgentID);

  -- INSERT INTO AGENTS ACCOUNTS
    INSERT INTO `agentsaccounts`
		(
		`MerchantID`,
		`TrxID`,
		`Amount`,
		`Narrations`,
		`TrxType`,
		`CreatedOn`,
		`CreatedBy`)
		VALUES
		(
		 vAgentID,
		 vTrxID,
		 vRate,
		 'Commission Received',
	     'DR',
		 NOW(),
		 vAgentID);



   SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED ;
    IF (SELECT NOT EXISTS(SELECT Sending FROM COMMISSIONSHARING where MerchantID = vAgentID)) then
    BEGIN
        
		SELECT Sending into vSendRate FROM COMMISSIONSHARING where MerchantID = 'Default';
       
       SELECT DirectCash into vDirectCashRate  FROM COMMISSIONSHARING where MerchantID = 'Default';
    END;
 
    ELSE
     BEGIN
       SELECT Sending into vSendRate FROM COMMISSIONSHARING where MerchantID = vAgentID;
	   SELECT DirectCash into vDirectCashRate  FROM COMMISSIONSHARING where MerchantID = vAgentID;
    END;
    END IF;  
  COMMIT;
    
  -- INSERT INTO AGENTS ACCOUNTS
    INSERT INTO `agentsaccounts`
		(
		`MerchantID`,
		`TrxID`,
		`Amount`,
		`Narrations`,
		`TrxType`,
		`CreatedOn`,
		`CreatedBy`)
		VALUES
		(
		 vAgentID,
		 vTrxID,
		 vNormalRate * (vSendRate/100),
		'Agent Commission Earned',
		'CR',
		 NOW(),
		 vAgentID);
         
         INSERT INTO `agentsaccounts`
		(
		`MerchantID`,
		`TrxID`,
		`Amount`,
		`Narrations`,
		`TrxType`,
		`CreatedOn`,
		`CreatedBy`)
		VALUES
		(
		 vMerchantID,
		 vTrxID,
		 vNormalRate * (vMerchantSendRate/100),
		'Merchant Commission Earned',
		'CR',
		 NOW(),
		 vAgentID);



	INSERT INTO `commissions`
	(
	`MerchantID`,
	`TrxID`,
	`Amount`,
    `Narrations`,
	`TrxType`,
	`CreatedOn`,
	`CreatedBy`)
	VALUES
	(
	vMerchantID,
	vTrxID,
	vNormalRate * (vMerchantSendRate/100),
    Concat('Merchant commission','(',vAgentID,')'), 
	'CR',
	NOW(),
	vAgentID
	 );
     
     INSERT INTO `commissions`
	(
	`MerchantID`,
	`TrxID`,
	`Amount`,
    `Narrations`,
	`TrxType`,
	`CreatedOn`,
	`CreatedBy`)
	VALUES
	(
	vAgentID,
	vTrxID,
	vNormalRate * (vSendRate/100),
    Concat('Cash Sent','(',vAgentID,')'), 
	'CR',
	NOW(),
	vAgentID
	 );

	INSERT INTO `commissions`
	(
	`MerchantID`,
	`TrxID`,
	`Amount`,
    `Narrations`,
	`TrxType`,
	`CreatedOn`,
	`CreatedBy`)
	VALUES
	(
	'DirectCash',
	 vTrxID,
	 vNormalRate * (vDirectCashRate/100),
     ('Commission Earned'),
	 'CR',
	 NOW(),
	 vAgentID
	 );

       -- amount = IFNULL(amount,0) - IFNULL(( (vAmount+vRate) - (vRate * (vSendRate/100))),0)
        UPDATE directcash_live.callboxagentsaccounts 
        SET amount = IFNULL(amount,0) - IFNULL((vAmount+vNormalRate),0) , Commission = vNormalRate * (vSendRate/100)
        WHERE callBoxAgentsID = vAgentID;
		
        --  amount = (IFNULL(amount,0) + IFNULL((vRate * (vMerchantSendRate/100)),0)) 
        
    	UPDATE directcash_live.callboxagentsaccounts 
        SET Commission = IFNULL((vNormalRate * (vMerchantSendRate/100)),0)
        WHERE  callBoxAgentsID = vMerchantID;

     
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED ; 
    SELECT SUBSTRING_INDEX( `agentname` , ' ', 1 ) into vAgentName  FROM `agents` Where Agent_ID = vAgentID;
	COMMIT;
	select Narration into vReceiptTicker from receiptticker;


	select Marketer into vTop from merchants where MerchantID = vMerchantID;
        SELECT Sending into vTopRate FROM COMMISSIONSHARING where MerchantID = 'Top Default';
      
      --  amount = (IFNULL(amount,0) + IFNULL((vRate * (vTopRate/100)),0)) 
       UPDATE directcash_live.callboxagentsaccounts 
       SET Commission = IFNULL((vNormalRate * (vTopRate/100)),0)
       WHERE  callBoxAgentsID = vTop;
       
	SELECT amount INTO vClosingBalance FROM directcash_live.callboxagentsaccounts WHERE callBoxAgentsID = vAgentID;
    
        INSERT INTO `commissions`
	(
	`MerchantID`,
	`TrxID`,
	`Amount`,
    `Narrations`,
	`TrxType`,
	`CreatedOn`,
	`CreatedBy`)
	VALUES
	(
	vMerchantID,
	vTrxID,
	vNormalRate * (vTopRate/100),
    Concat('Top Merchant commission','(',vTop,')'), 
	'CR',
	NOW(),
	vAgentID
	 );
     
     INSERT INTO `commissions`
	(
	`MerchantID`,
	`TrxID`,
	`Amount`,
    `Narrations`,
	`TrxType`,
	`CreatedOn`,
	`CreatedBy`)
	VALUES
	(
	vAgentID,
	vTrxID,
	vAmount * vTax,
    'Taxe Transfert Argent', 
	'CR',
	NOW(),
	vAgentID
	 );
    
    SELECT 'Success',vTrxID,IFNULL(vClosingBalance,0),vRandomID,vMerchantID,vAgentName,now(),vReceiptTicker;


END