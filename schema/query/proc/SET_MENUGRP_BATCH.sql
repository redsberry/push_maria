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

-- 프로시저 REDSPUSH.SET_MENUGRP_BATCH 구조 내보내기
DELIMITER //
CREATE DEFINER=`redspush`@`%` PROCEDURE `SET_MENUGRP_BATCH`(
  IN `P_PROC_ID` VARCHAR(30)     ,
  IN `P_USER_ID` VARCHAR(30)     ,
  IN `P_MENU_CD` VARCHAR(100)     ,
  OUT `P_RESULT_ID` INT          ,
  OUT `P_MESSAGE` TINYTEXT        

)
BEGIN
	  DECLARE V_RIG_GRP_CD      VARCHAR(3);
    DECLARE DONE INT DEFAULT FALSE;
    DECLARE CURSOR_I CURSOR FOR SELECT RIG_GRP_CD FROM SN_MENUGRP GROUP BY RIG_GRP_CD;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET DONE = TRUE;
    
    IF P_PROC_ID = 'SET_MENUGRP_INFO' THEN
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
                  AND EXISTS (SELECT 1 FROM SN_RIGHTGRP WHERE RIG_GRP_CD = V_RIG_GRP_CD)
                  AND B.MNU_CD NOT IN (SELECT MNU_CD FROM SN_MENUGRP WHERE RIG_GRP_CD = V_RIG_GRP_CD);
      END LOOP;
      CLOSE CURSOR_I;
      
      SET P_RESULT_ID    = 0;
      SET P_MESSAGE    = "정상적으로 처리되었습니다.";
     
    ELSEIF P_PROC_ID = 'DEL_MENUGRP_INFO' THEN
    
        DELETE FROM SN_MENUGRP
         WHERE FIND_IN_SET(MNU_CD, P_MENU_CD);
      
      SET P_RESULT_ID    = 0;
      SET P_MESSAGE    = "정상적으로 처리되었습니다.";
      
    END IF;  
END//
DELIMITER ;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
