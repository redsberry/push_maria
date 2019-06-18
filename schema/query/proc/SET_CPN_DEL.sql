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

-- 프로시저 REDSPUSH.SET_CPN_DEL 구조 내보내기
DELIMITER //
CREATE DEFINER=`redspush`@`%` PROCEDURE `SET_CPN_DEL`(
	IN `P_PROC_ID`      VARCHAR(30),
  IN `P_CPNY_NO`      INT,
  OUT `P_CPNY_NM`     VARCHAR(50),
	OUT `P_RESULT_ID`   INT,
	OUT `P_MESSAGE`     VARCHAR(500)        
 
)
BEGIN

    SET P_RESULT_ID= -1;
    SET P_MESSAGE= "처리중 오류가 발생했습니다.";

    IF  P_PROC_ID = 'DELETE_CPN_INFO' THEN
      SELECT CPNY_NM INTO P_CPNY_NM FROM SN_COMPANY WHERE CPNY_NO = P_CPNY_NO;
    
      IF (SELECT COUNT(DPT_NO) FROM SN_DPT WHERE CPNY_NO = P_CPNY_NO) > 0 THEN
        SET P_RESULT_ID= -1;
        SET P_MESSAGE= "소속된 부서가 있는 회사는 삭제할 수 없습니다.";
      ELSE
        DELETE FROM SN_COMPANY
        WHERE CPNY_NO = P_CPNY_NO;
          
        SET P_RESULT_ID= 0;
        SET P_MESSAGE= "정상적으로 처리되었습니다."; 
      END IF;
    END IF;
 
END//
DELIMITER ;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
