CREATE DEFINER=`root`@`localhost` PROCEDURE `SEND_AIRTIME`( 
  IN vAgentID    VARCHAR(20),  
  vAmount     int,    
   vToNumber   VARCHAR(15),  
   vCNI VARCHAR(255),
   vNetwork VARCHAR(20),
	vPIN VARCHAR(5)
   )
BEGIN

   DECLARE vRandomID VARCHAR(10); -- id aléatoire
   DECLARE vClosingBalance DOUBLE; -- pour le compte
   DECLARE vMerchantID  VARCHAR(20); -- id du marchant 
   DECLARE vAgentRate DECIMAL(4,3); -- pourcentage à retirer pour l agent
   DECLARE vSuperAgentRate DECIMAL(4,3); -- pourcentage à retirer pour le delegue
   DECLARE vAgentName VARCHAR(45); -- nom de la boite
   DECLARE vReceiptTicker TEXT; -- ????
   DECLARE vTrxID VARCHAR(10); -- ???? 
   DECLARE TempAmount int;
   DECLARE vTop VARCHAR(45);
   DECLARE vTopRate DECIMAL(4,3);
	 DECLARE vAllianceRate DECIMAL(4,3);
 -- SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED ; -- début de la transaction pour le stockage des frais envoyés
  -- le marchant est différent de l agent
  
  SELECT MerchantID INTO vMerchantID FROM AGENTS WHERE Agent_ID = vAgentID;  -- on prend l id du marchant donc le call boxeur 
  -- le Top delegue du delegue
  select Marketer into vTop From merchants where MerchantID = vMerchantID ;
  
  IF (SELECT NOT EXISTS (SELECT * FROM airtime_commissions WHERE UserType = vAgentID )) THEN
		-- il n'esxste pas comme agent spécial
	BEGIN
			
			SET vAgentRate = (SELECT Rate FROM airtime_commissions WHERE UserType =  'Agent' AND Network = vNetwork ) ;
	
  -- oon vérifie à présent si son merchant existe comme agent spécial
			
            if (select not exists (select * from airtime_commissions where UserType = vMerchantID) ) then
				begin
							SELECT Rate INTO vSuperAgentRate FROM airtime_commissions WHERE UserType =  'Super agent' AND Network = vNetwork; 
  
				end;
				else
					begin
							SELECT Rate INTO vSuperAgentRate FROM airtime_commissions WHERE UserType =  vMerchantID AND Network = vNetwork; 
  
					end;
            end if;
			
    END;
    
    ELSE
		BEGIN
			SET vAgentRate = (SELECT Rate FROM airtime_commissions WHERE UserType = vAgentID AND Network = vNetwork ) ;
			SELECT Rate INTO vSuperAgentRate FROM airtime_commissions WHERE UserType = vAgentID AND Network = vNetwork; 
  
		END;
END IF;
  
  SELECT Rate INTO vTopRate FROM airtime_commissions WHERE UserType =  'Top Super agent' AND Network = vNetwork; 
 
 SELECT Valeur INTO vAllianceRate FROM comalliance WHERE Reseau =  vNetwork ; 
 -- COMMIT;

   SET  vTrxID = floor(rand() * 100000000); -- id de la transaction

     /*GENERATE RANDOM NUMBER */
   
   SET vRandomID =  UPPER(SUBSTRING(UUID(),1,7));
   
   
   -- 1- verification de l'existance de l'agent
   IF (SELECT NOT EXISTS(SELECT * FROM agents where Agent_ID = vAgentID and Password = vPin )) then
    BEGIN
        
     SELECT 'Agent inexistant',vTrxID, vClosingBalance, vAmount, vToNumber,now();

    
    END;
    ELSE
		BEGIN
        
        -- 4- get the balance of agent
        SELECT amount INTO vClosingBalance FROM callboxagentsaccounts Where callBoxAgentsID = vAgentID;
       
            -- 5 check if that the last taked balance is suffisent for transfert
          if(vCNI='Success' or vCNI='PENDING')then
				
                 IF(  vClosingBalance > vAmount ) then
            
            BEGIN
				-- on peut faire le transfert
				
				-- décrémente son compte
              
                UPDATE callboxagentsaccounts 
                SET amount = IFNULL(amount,0) - IFNULL(vAmount,0), Commission = (vAmount * (vAgentRate/100))
                WHERE callBoxAgentsID = vAgentID;
     
             --  UPDATE callboxagentsaccounts SET amount = (amount -  TempAmount) WHERE callBoxAgentsID = vAgentID;
     
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
				 (vAgentID,'Airtime',vAmount,vTrxID,'Success',NOW(),Concat('AIRTIME XFER ', vNetwork),vRandomID,'0',vToNumber,vCNI,vAgentRate*(vAmount/100),vPIN); -- remplacer le 0 par le numero du call box si cela est nécéssaire

				-- appliqué la commission de son merchant
    
				-- UPDATE Merchants SET ClearBalance = (ClearBalance) + ((vAmount) * (vSuperAgentRate/100)) WHERE MerchantID = vMerchantID;
			    
              --  UPDATE Merchants SET ClearBalance = IFNULL(ClearBalance,0) + ((IFNULL(vAmount,0) * IFNULL(vSuperAgentRate/100,0))) WHERE MerchantID = ;
                -- amount = IFNULL(amount,0) + IFNULL(((vAmount * (vSuperAgentRate/100))),0),
                UPDATE callboxagentsaccounts 
                SET Commission= vAmount * (vSuperAgentRate/100)
                WHERE callBoxAgentsID = vMerchantID;
				
                -- top delegue amount = IFNULL(amount,0) + IFNULL(((vAmount * (vTopRate/100))),0),
                UPDATE callboxagentsaccounts 
                SET  Commission = vAmount * (vTopRate/100) 
                WHERE callBoxAgentsID = vTop;
     
				-- appliqué la commission de l'agent
               
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
					 vMerchantID,
					 vTrxID,
					 vAmount,
					Concat('Airtime Sent','(',vAgentID,')'), 
					'DR',
					 NOW(),
					 vAgentID);
					 
					 /* insertion 3 gestion du compte: confirmationde la transaction ajout de pourcentage
					 le montant ici est le pourcentage passé en parametre*/
		

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
				vSuperAgentRate * (vAmount/100),
				Concat('Super agent Airtime Commission Earned','(',vAgentID,')'), 
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
				vAgentRate * (vAmount/100),
				Concat('Agent Airtime Commission Earned','(',vAgentID,')'), 
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
				vTop,
				vTrxID,
				vTopRate * (vAmount/100),
				Concat('Top Airtime Commission Earned','(',vAgentID,')'), 
				'CR',
				NOW(),
				vAgentID
				 );
                 
                 

INSERT INTO commissions
				(
				MerchantID,
				TrxID,
				Amount,
				Narrations,
				TrxType,
				CreatedOn,
				CreatedBy)
				VALUES
				(
				vTop,
				vTrxID,
				vAllianceRate*(vAmount/100),
				Concat('Alliance Airtime Commission Earned','(',vAgentID,')'), 
				'CR',
				NOW(),
				vAgentID
				 );
				
                SELECT 'Success',vTrxID, vClosingBalance, vAmount, vToNumber,now();
           
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
							(vAgentID,'Airtime',vAmount,vTrxID,'Failed: Solde infuffisant',NOW(),'AIRTIME XFER FAILED',vRandomID,'0',vToNumber,vCNI,vAgentRate,vPIN); -- remplacer le 0 par le numero du call box si cela est nécéssaire
						
                    SELECT 'Votre compte est insuffisant pour effectuer cette transanction \n Merci de recharger votre compte ',vTrxID, vClosingBalance, vAmount, vToNumber,now();

                END;
                
			END if;
                
                else
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
							(vAgentID,'Airtime',vAmount,vTrxID,'Failed',NOW(),'AIRTIME XFER FAILED',vRandomID,'0',vToNumber,vCNI,vAgentRate,vPIN); -- remplacer le 0 par le numero du call box si cela est nécéssaire
						
                    SELECT 'Failed',vTrxID, vClosingBalance, vAmount, vToNumber,now();

          end if;
          
		END;
	end if;

END