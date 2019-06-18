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

-- 프로시저 REDSPUSH.SET_MENUGRP_INFO 구조 내보내기
DELIMITER //
CREATE DEFINER=`redspush`@`%` PROCEDURE `SET_MENUGRP_INFO`(
	IN `P_PROC_ID` VARCHAR(30)     ,
	IN `P_MNU_CD` VARCHAR(30)     ,
	IN `P_REA_RIG_YN` VARCHAR(1)     ,
  IN `P_UPD_RIG_YN` VARCHAR(1)     ,
  IN `P_CRE_RIG_YN` VARCHAR(1)     ,
  IN `P_DEL_RIG_YN` VARCHAR(1)     ,
  IN `P_PRT_RIG_YN` VARCHAR(1)     ,
	IN `P_USER_ID` VARCHAR(30)     ,
	INOUT `P_RIG_GRP_CD` VARCHAR(100)     ,
	OUT `P_RESULT_ID` INT             ,
	OUT `P_MESSAGE` TINYTEXT        

)
BEGIN
    
    SET P_RESULT_ID    = 0;
    SET P_MESSAGE    = "정상적으로 처리되었습니다.";

    IF  P_PROC_ID = 'RIGHT_MENU_UPDATE' THEN

        UPDATE SN_MENUGRP
           SET REA_RIG_YN = P_REA_RIG_YN,
               UPD_RIG_YN = P_UPD_RIG_YN,
               CRE_RIG_YN = P_CRE_RIG_YN,
               DEL_RIG_YN = P_DEL_RIG_YN,
               PRT_RIG_YN = P_PRT_RIG_YN,
               UPR_ID = P_USER_ID,
               UPD_TS = NOW()
         WHERE RIG_GRP_CD = P_RIG_GRP_CD
           AND MNU_CD = P_MNU_CD;

    ELSE
        SET P_RESULT_ID= -1;
        SET P_MESSAGE= "매개변수를 확인해주시기 바랍니다.";
    END IF;    
END//
DELIMITER ;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
