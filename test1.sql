CREATE DEFINER=`root`@`localhost` PROCEDURE `SEND_AIRTIME`( 
  IN vAgentID    VARCHAR(20),  
  vAmount     int,    
   vToNumber   VARCHAR(15),  
   vCNI VARCHAR(255),
	vPIN VARCHAR(5),
    vTRX_Type int,
    vTRX_Description VARCHAR(255)
   )
BEGIN

   DECLARE vRandomID VARCHAR(10); -- id aléatoire
   DECLARE vClosingBalance DOUBLE; -- pour le compte
   DECLARE vTax DOUBLE;
 DECLARE vTax DOUBLE;
DECLARE vCommRate DOUBLE;
   DECLARE vAgentName VARCHAR(45); -- nom de la boite
 
   DECLARE vTrxID VARCHAR(10); -- ???? 

   

 
   
   -- 1- verification de l'existance de l'agent
   IF (SELECT NOT EXISTS(SELECT * FROM agents where Agent_ID = vAgentID and Password = vPin )) then
    BEGIN
        
     SELECT 'Agent inexistant',vTrxID, vClosingBalance, vAmount, vToNumber,now();

    
    END;
    ELSE
		BEGIN

          SET  vTrxID = floor(rand() * 100000000); -- id de la transaction

     /*GENERATE RANDOM NUMBER */
   
   SET vRandomID =  UPPER(SUBSTRING(UUID(),1,7));
   select Tax into vTax from commissionsharing where MerchantID='Default';

        
        -- 4- get the balance of agent
        SELECT amount INTO vClosingBalance FROM callboxagentsaccounts Where callBoxAgentsID = vAgentID;
       
           
	   IF(  vClosingBalance > vAmount ) then
            
            BEGIN
				-- on peut faire le transfert
				
				-- décrémente son compte
              
                UPDATE callboxagentsaccounts 
                SET amount = IFNULL(amount,0) - IFNULL(vAmount,0)
                WHERE callBoxAgentsID = vAgentID;

 SELECT 
            CASE vTRX_Type
                
                WHEN 3 THEN CAMTELRATE
                WHEN 4 THEN MTNRATE
                WHEN 5 THEN NEXTELRATE
                 WHEN 6 THEN ORANGERATE
                  WHEN 7 THEN YOOMEERATE
                ELSE 3
            END INTO vCommRate
        FROM commission_rate_from_maviance
        WHERE FROM_AMOUNT <= 1
        LIMIT 1;


       -- Calcul des commissions et TVA pour l'agent et ses parents
CALL sp_commissionREPARTI_TVA(vCommRate, vAgentID, vTax, vTrxID,vTRX_Type);
 -- Calcul des commissions et TVA pour AFN et ses partenaire
call directcash_live.sp_repartitionCommissionTVA_Alliance_Partenaire(vCommRate, vAgentID,vTax, vTrxID,vTRX_Type);
 


				-- save the trx
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
				 (vAgentID,vTRX_Type,vAmount,vTrxID,1,NOW(),vTRX_Description,0,'0',vToNumber,vCNI,0,vPIN); -- remplacer le 0 par le numero du call box si cela est nécéssaire

				
            END;
            
            ELSE
				BEGIN
                    -- transfert impossible
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
							(vAgentID,vTRX_Type,vAmount,vTrxID,0,NOW(),vTRX_Description,0,'0',vToNumber,vCNI,vAgentRate,vPIN); -- remplacer le 0 par le numero du call box si cela est nécéssaire
						
                    SELECT 'Votre compte est insuffisant pour effectuer cette transanction \n Merci de recharger votre compte ',vTrxID, vClosingBalance, vAmount, vToNumber,now();

                END;
                
			END if;
              
		END;
	end if;

END