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

-- 프로시저 REDSPUSH.SET_RIGHT_INFO 구조 내보내기
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `SET_RIGHT_INFO`(
	IN `P_PROC_ID` VARCHAR(30)     ,
	IN `P_USR_ID` VARCHAR(80)     ,
  IN `P_RIGHT_ID` VARCHAR(3)     ,
  IN `P_USE_YN`   VARCHAR(1)     ,
  IN `P_UPR_ID`   VARCHAR(80)     ,
	OUT `P_RESULT_ID` INT             ,
	OUT `P_MESSAGE` TINYTEXT        

)
BEGIN
    
    SET P_RESULT_ID    = 0;
    SET P_MESSAGE    = "정상적으로 처리되었습니다.";

    IF  P_PROC_ID = 'USER_RIGHT_UPDATE' THEN
    
      IF P_USE_YN = 'Y' THEN
        INSERT INTO SN_RIGHT (USR_ID, RIG_GRP_CD, USE_YN, UPR_ID, REG_TS, UPD_TS )
             VALUES (P_USR_ID, P_RIGHT_ID, P_USE_YN,P_UPR_ID, NOW(), NOW() )
        ON DUPLICATE KEY UPDATE USR_ID= P_USR_ID, RIG_GRP_CD=P_RIGHT_ID, USE_YN=P_USE_YN, UPR_ID=P_UPR_ID, REG_TS=NOW(), UPD_TS=NOW() ;
      
      ELSE
        DELETE FROM SN_RIGHT
        WHERE RIG_GRP_CD = P_RIGHT_ID
          AND USR_ID = P_USR_ID;
          
      END IF;
    ELSE
        SET P_RESULT_ID= -1;
        SET P_MESSAGE= "매개변수를 확인해주시기 바랍니다.";
    END IF;    
END//
DELIMITER ;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
