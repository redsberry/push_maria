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

-- 프로시저 REDSPUSH.SET_RIGHT_GRP_INFO 구조 내보내기
DELIMITER //
CREATE DEFINER=`redspush`@`%` PROCEDURE `SET_RIGHT_GRP_INFO`(
	IN `P_PROC_ID` VARCHAR(30)     ,
	IN `P_RIG_GRP_NM` VARCHAR(30)     ,
	IN `P_RIG_GRP_DESC` VARCHAR(30)     ,
  IN `P_USE_GRP_CD` VARCHAR(1)     ,
	IN `P_USE_YN` VARCHAR(1)     ,
	IN `P_USER_ID` VARCHAR(80)     ,
	INOUT `P_RIGHT_CD` VARCHAR(100)     ,
	OUT `P_RESULT_ID` INT             ,
	OUT `P_MESSAGE` TINYTEXT        

)
BEGIN
    
    SET P_RESULT_ID    = 0;
    SET P_MESSAGE    = "정상적으로 처리되었습니다.";

    IF  P_PROC_ID = 'RIGHT_INSERT' THEN

      SELECT  CONCAT('RG', (CASE COALESCE(RIG_GRP_CD, '')
                  WHEN '' THEN '1'
                  ELSE SUBSTRING(MAX(RIG_GRP_CD), -1) + 1
               END))
        INTO  P_RIGHT_CD
        FROM SN_RIGHTGRP;
              
      INSERT INTO SN_RIGHTGRP (RIG_GRP_CD,
                             RIG_GRP_NM,
                             RIG_GRP_DESC,
                             USE_GRP_CD,
                             USE_YN,
                             SYS_YN,
                             UPR_ID,
                             UPD_TS)
           VALUES (P_RIGHT_CD,
                   P_RIG_GRP_NM,
                   P_RIG_GRP_DESC,
                   P_USE_GRP_CD,
                   P_USE_YN,
                   'N',
                   P_USER_ID,
                   NOW());


      INSERT INTO SN_MENUGRP (RIG_GRP_CD,
                              MNU_CD,
                              REA_RIG_YN,
                              UPD_RIG_YN,
                              CRE_RIG_YN,
                              DEL_RIG_YN,
                              PRT_RIG_YN,
                              UPR_ID,
                              UPD_TS)
             SELECT P_RIGHT_CD,
                    B.MNU_CD,
                    IFNULL(A.REA_RIG_YN, 'N'),
                    IFNULL(A.UPD_RIG_YN, 'N'),
                    IFNULL(A.CRE_RIG_YN, 'N'),
                    IFNULL(A.DEL_RIG_YN, 'N'),
                    IFNULL(A.PRT_RIG_YN, 'N'),
                    P_USER_ID,
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
                AND EXISTS (SELECT 1 FROM SN_RIGHTGRP WHERE RIG_GRP_CD = P_RIGHT_CD)
                AND B.MNU_CD NOT IN (SELECT MNU_CD FROM SN_MENUGRP WHERE RIG_GRP_CD = P_RIGHT_CD)
        UNION ALL
             SELECT RIG_GRP_CD,
                    MNU_CD,
                    REA_RIG_YN, 
                    UPD_RIG_YN,
                    CRE_RIG_YN, 
                    DEL_RIG_YN, 
                    PRT_RIG_YN,
                    UPR_ID,
                    UPD_TS
                FROM SN_MENUGRP
              WHERE RIG_GRP_CD = P_RIGHT_CD;
            

    ELSEIF  P_PROC_ID = 'RIGHT_UPDATE' THEN
    
        UPDATE SN_RIGHTGRP
           SET RIG_GRP_NM = P_RIG_GRP_NM,
               RIG_GRP_DESC = P_RIG_GRP_DESC,
               USE_GRP_CD = P_USE_GRP_CD,
               USE_YN = P_USE_YN,
               UPR_ID = P_USER_ID,
               UPD_TS = NOW()
         WHERE RIG_GRP_CD = P_RIGHT_CD;    
         
    ELSEIF  P_PROC_ID = 'RIGHT_DELETE' THEN
    
        DELETE FROM SN_RIGHTGRP
         WHERE FIND_IN_SET(RIG_GRP_CD, P_RIGHT_CD);
         
        DELETE FROM SN_MENUGRP
         WHERE FIND_IN_SET(RIG_GRP_CD, P_RIGHT_CD);         
         
    ELSE
        SET P_RESULT_ID= -1;
        SET P_MESSAGE= "매개변수를 확인해주시기 바랍니다.";
    END IF;    
END//
DELIMITER ;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
