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

-- 프로시저 REDSPUSH.SET_RESERVE_INFO 구조 내보내기
DELIMITER //
CREATE DEFINER=`redspush`@`%` PROCEDURE `SET_RESERVE_INFO`(
	IN `P_MNG_NO` INT(11),
	OUT `P_RESULT_ID` INTEGER,
	OUT `P_MESSAGE` VARCHAR(500)
)
    COMMENT '[oslee97] 예약,반복 발송 정보 삭제.'
BEGIN

    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET P_RESULT_ID = -1;
    SET P_RESULT_ID = 0; 
    SET P_MESSAGE = "정상적으로 처리되었습니다.";
    
    DELETE FROM PM_RESERVE 
    WHERE MNG_NO = P_MNG_NO;

    DELETE FROM PM_RESERVECNT 
    WHERE MNG_NO = P_MNG_NO;

    IF P_RESULT_ID < 0 THEN
        SET P_MESSAGE = "삭제중 오류가 발생하였습니다.";
    END IF;
    
 END//
DELIMITER ;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
