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

-- 프로시저 REDSPUSH.GET_DPT_INFO 구조 내보내기
DELIMITER //
CREATE DEFINER=`redspush`@`%` PROCEDURE `GET_DPT_INFO`(
    IN `P_DPT_NO`                INT(10),
    IN `P_CPNY_NO`         				INT(10),
    OUT `P_DPT_NM`         				VARCHAR(50),
    OUT `P_DPT_TEL_NO`         		VARCHAR(50),
    OUT `P_DPT_FAX_NO`         		VARCHAR(8),
    OUT `P_RESULT_ID`      INT ,	
    OUT `P_MESSAGE`        TINYTEXT
)
BEGIN    	
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET P_RESULT_ID = -1;
    SET P_RESULT_ID = 0; 
    SET P_MESSAGE = "정상적으로 처리되었습니다.";
    
      SELECT IFNULL(DPT_NM,''),
             IFNULL(DPT_TEL_NO,''),
             IFNULL(DPT_FAX_NO,'')
        INTO P_DPT_NM,
             P_DPT_TEL_NO,
             P_DPT_FAX_NO
        FROM SN_DPT
        WHERE DPT_NO = P_DPT_NO
          AND CPNY_NO = P_CPNY_NO;		
    
    IF P_RESULT_ID < 0 THEN
        SET P_MESSAGE ="매개변수를 확인해주시기 바랍니다.";
    END IF;

END//
DELIMITER ;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
