-- --------------------------------------------------------
-- 호스트:                          eberry.co.kr
-- 서버 버전:                        10.3.11-MariaDB - MariaDB Server
-- 서버 OS:                        Linux
-- HeidiSQL 버전:                  10.2.0.5599
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- 프로시저 REDSPUSH.SET_BBS_INFO 구조 내보내기
DELIMITER //
CREATE DEFINER=`redspush`@`%` PROCEDURE `SET_BBS_INFO`(
	IN `P_PROC_ID` VARCHAR(30)     ,
  IN `P_BRD_TYPE_CD` VARCHAR(1)             ,
	IN `P_BRD_DESC` VARCHAR(500)             ,
  IN `P_BRD_NM` VARCHAR(100)             ,
  IN `P_ANS_ENA_YN` VARCHAR(1)             ,
  IN `P_RPY_ENA_YN` VARCHAR(1)             ,
  IN `P_USE_YN` VARCHAR(1)             ,
  IN `P_RER_ID` VARCHAR(12)             ,
  INOUT `P_BRD_CD` VARCHAR(100)             ,
	OUT `P_RESULT_ID` INT             ,
	OUT `P_MESSAGE` TINYTEXT        
)
BEGIN
    DECLARE V_RIG_GRP_CD      VARCHAR(3);
    DECLARE DONE INT DEFAULT FALSE;
    DECLARE CURSOR_I CURSOR FOR SELECT RIG_GRP_CD FROM SN_MENUGRP GROUP BY RIG_GRP_CD;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET DONE = TRUE;
        
    SET P_RESULT_ID= -1;
    SET P_MESSAGE= "처리중 오류가 발생했습니다.";

    IF  P_PROC_ID = 'BBS_INSERT' THEN       
      SELECT CONCAT('BBS', (LPAD((CASE COALESCE(BRD_CD, '') WHEN '' THEN '1'
                       ELSE SUBSTRING(MAX(BRD_CD), -2) + 1
                       END), 2, '0'))) 
        INTO P_BRD_CD           
        FROM BD_MANAGE;
                    

      INSERT INTO BD_MANAGE (BRD_CD,
                            BRD_TYPE_CD,
                           BRD_DESC,
                           BRD_NM,
                           ANS_ENA_YN,
                           RPY_ENA_YN,
                           USE_YN,
                           RER_ID)
           VALUES (P_BRD_CD,
                   P_BRD_TYPE_CD,
                   P_BRD_DESC,
                   P_BRD_NM,
                   P_ANS_ENA_YN,
                   P_RPY_ENA_YN,
                   P_USE_YN,
                   P_RER_ID);
                   
        INSERT INTO SN_MENU (MNU_CD,
                           MNU_NM,
                           MNU_PATH,
                           MNU_ORD,
                           MNU_DEPTH,
                           MNU_GRP_YN,
                           UP_MNU_CD,
                           USE_YN)
             VALUES (P_BRD_CD,
                     P_BRD_NM,
                     '#',
                     (SELECT MAX(B.MNU_ORD)+1 FROM SN_MENU B WHERE B.UP_MNU_CD = 'BBS00') ,
                     2,
                     'N',
                     'BBS00',
                     'N');
                             
        OPEN CURSOR_I;
        READ_LOOP : LOOP
          FETCH CURSOR_I INTO V_RIG_GRP_CD;
          IF DONE THEN 
            LEAVE READ_LOOP;
          END IF;
          
          INSERT INTO SN_MENUGRP (RIG_GRP_CD,
                                  MNU_CD,
                                  REA_RIG_YN,
                                  UPD_RIG_YN,
                                  CRE_RIG_YN,
                                  DEL_RIG_YN,
                                  PRT_RIG_YN,
                                  UPR_ID,
                                  UPD_TS)
                 SELECT V_RIG_GRP_CD,
                        B.MNU_CD,
                        IFNULL(A.REA_RIG_YN, 'N'),
                        IFNULL(A.UPD_RIG_YN, 'N'),
                        IFNULL(A.CRE_RIG_YN, 'N'),
                        IFNULL(A.DEL_RIG_YN, 'N'),
                        IFNULL(A.PRT_RIG_YN, 'N'),
                        P_RER_ID,
                        NOW()
                   FROM (SELECT NULL AS RIG_GRP_CD, 
                                NULL AS MNU_CD, 
                                NULL AS REA_RIG_YN, 
                                NULL AS UPD_RIG_YN, 
                                NULL AS CRE_RIG_YN, 
                                NULL AS DEL_RIG_YN, 
                                NULL AS PRT_RIG_YN) A RIGHT OUTER JOIN SN_MENU B ON A.MNU_CD = B.MNU_CD
                  WHERE B.MNU_GRP_YN = 'N'
                    AND A.RIG_GRP_CD IS NULL
                    AND EXISTS (SELECT 1 FROM SN_RIGHTGRP WHERE RIG_GRP_CD = V_RIG_GRP_CD)
                    AND B.MNU_CD NOT IN (SELECT MNU_CD FROM SN_MENUGRP WHERE RIG_GRP_CD = V_RIG_GRP_CD);
        END LOOP;
        CLOSE CURSOR_I;
                      
              
        SET P_RESULT_ID= 0;
        SET P_MESSAGE= "정상적으로 처리되었습니다.";                  
        
    ELSEIF  P_PROC_ID = 'BBS_UPDATE' THEN
        START TRANSACTION;
        UPDATE BD_MANAGE
           SET BRD_TYPE_CD = P_BRD_TYPE_CD,
               BRD_DESC = P_BRD_DESC,
               BRD_NM = P_BRD_NM,
               ANS_ENA_YN = P_ANS_ENA_YN,
               RPY_ENA_YN = P_RPY_ENA_YN,               
               USE_YN = P_USE_YN
         WHERE BRD_CD = P_BRD_CD;        
         COMMIT;
         
        SET P_RESULT_ID= 0;
        SET P_MESSAGE= "정상적으로 처리되었습니다.";    
        
    ELSEIF  P_PROC_ID = 'BBS_DELETE' THEN
    
        DELETE FROM BD_MANAGE     
         WHERE FIND_IN_SET(BRD_CD, P_BRD_CD);
         
        DELETE FROM SN_MENU
        WHERE FIND_IN_SET(MNU_CD, P_BRD_CD);

        OPEN CURSOR_I;
        READ_LOOP : LOOP
          FETCH CURSOR_I INTO V_RIG_GRP_CD;
          IF DONE THEN 
            LEAVE READ_LOOP;
          END IF;
          
          INSERT INTO SN_MENUGRP (RIG_GRP_CD,
                                  MNU_CD,
                                  REA_RIG_YN,
                                  UPD_RIG_YN,
                                  CRE_RIG_YN,
                                  DEL_RIG_YN,
                                  PRT_RIG_YN,
                                  UPR_ID,
                                  UPD_TS)
                 SELECT V_RIG_GRP_CD,
                        B.MNU_CD,
                        IFNULL(A.REA_RIG_YN, 'N'),
                        IFNULL(A.UPD_RIG_YN, 'N'),
                        IFNULL(A.CRE_RIG_YN, 'N'),
                        IFNULL(A.DEL_RIG_YN, 'N'),
                        IFNULL(A.PRT_RIG_YN, 'N'),
                        P_RER_ID,
                        NOW()
                   FROM (SELECT NULL AS RIG_GRP_CD, 
                                NULL AS MNU_CD, 
                                NULL AS REA_RIG_YN, 
                                NULL AS UPD_RIG_YN, 
                                NULL AS CRE_RIG_YN, 
                                NULL AS DEL_RIG_YN, 
                                NULL AS PRT_RIG_YN) A RIGHT OUTER JOIN SN_MENU B ON A.MNU_CD = B.MNU_CD
                  WHERE B.MNU_GRP_YN = 'N'
                    AND A.RIG_GRP_CD IS NULL
                    AND EXISTS (SELECT 1 FROM SN_RIGHTGRP WHERE RIG_GRP_CD = V_RIG_GRP_CD)
                    AND B.MNU_CD NOT IN (SELECT MNU_CD FROM SN_MENUGRP WHERE RIG_GRP_CD = V_RIG_GRP_CD);
        END LOOP;
        CLOSE CURSOR_I;
                      
        SET P_RESULT_ID= 0;
        SET P_MESSAGE= "정상적으로 처리되었습니다.";             
    END IF;

END//
DELIMITER ;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
