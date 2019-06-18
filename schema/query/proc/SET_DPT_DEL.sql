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

-- 프로시저 REDSPUSH.SET_DPT_DEL 구조 내보내기
DELIMITER //
CREATE DEFINER=`redspush`@`%` PROCEDURE `SET_DPT_DEL`(
	IN `P_PROC_ID`    VARCHAR(30),
  IN `P_DPT_NO`     INT,
  IN `P_CPNY_NO`     INT,
  OUT `P_DPT_NM`    VARCHAR(50),
	OUT `P_RESULT_ID` INT,
	OUT `P_MESSAGE`   VARCHAR(500)        
 
)
BEGIN

    SET P_RESULT_ID= -1;
    SET P_MESSAGE= "처리중 오류가 발생했습니다.";

    IF  P_PROC_ID = 'DELETE_DPT_INFO' THEN
      SELECT DPT_NM INTO P_DPT_NM FROM SN_DPT WHERE DPT_NO = P_DPT_NO;
    
      IF (SELECT COUNT(USR_ID) FROM SN_USR A WHERE A.CPNY_NO = P_CPNY_NO AND A.DPT_NO = P_DPT_NO) > 0 THEN
        SET P_RESULT_ID= -1;
        SET P_MESSAGE= "소속된 인원이 있는 부서는 삭제할 수 없습니다.";
      ELSE
        DELETE FROM SN_DPT
        WHERE DPT_NO = P_DPT_NO
          AND CPNY_NO = P_CPNY_NO;
          
        SET P_RESULT_ID= 0;
        SET P_MESSAGE= "정상적으로 처리되었습니다."; 
      END IF;
    END IF;
 
END//
DELIMITER ;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
