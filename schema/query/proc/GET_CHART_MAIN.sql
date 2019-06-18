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

-- 프로시저 REDSPUSH.GET_CHART_MAIN 구조 내보내기
DELIMITER //
CREATE DEFINER=`redspush`@`%` PROCEDURE `GET_CHART_MAIN`(
    IN  `P_PROC_ID`    VARCHAR(30),
    OUT P_RESULT_ID     INT,
    OUT P_MESSAGE       TINYTEXT        
)
BEGIN
    SET P_RESULT_ID = 0;
    SET P_MESSAGE   = "정상적으로 처리되었습니다.";
    
    IF  P_PROC_ID = 'GET_MAIN_STAT' THEN
    
        SELECT COUNT(1) AS COMPLETE_CNT
          FROM PM_MSGPLAN
         WHERE TRNS_CMPT_YN = 'Y';
          
       SELECT COUNT(1) AS WAIT_CNT
        FROM PM_MSGPLAN
       WHERE TRNS_CMPT_YN = 'N';
       
        SELECT COUNT(1) AS RESERVE_CNT
        FROM PM_RESERVE
        WHERE (TRNS_MTHD_TYPE = 'R' AND RESE_TRNS_TS > NOW() ) OR TRNS_MTHD_TYPE = 'P';
    
       SELECT COUNT(1) AS SMS_CNT
        FROM PM_MSGPLAN
       WHERE TRNS_CAT_CD = 'S';
      
    ELSE
          SET P_RESULT_ID= -1;
          SET P_MESSAGE= "매개변수를 확인해주시기 바랍니다.";
  END IF;    
    
END//
DELIMITER ;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
