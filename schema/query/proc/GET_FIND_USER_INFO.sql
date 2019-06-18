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

-- 프로시저 REDSPUSH.GET_FIND_USER_INFO 구조 내보내기
DELIMITER //
CREATE DEFINER=`redspush`@`%` PROCEDURE `GET_FIND_USER_INFO`(
    IN  P_PROC_ID   VARCHAR(30)         ,
    IN  P_USER_NM  VARCHAR(50)          ,
    IN  P_DPT_CD  VARCHAR(15)       ,
    IN  P_USER_ID  VARCHAR(12)          ,
    OUT P_RESULT_ID INT                 ,
    OUT P_MESSAGE   TINYTEXT    
)
BEGIN
    DECLARE SQLSTRING   TEXT;
    DECLARE CNTSTRING   TEXT;
    DECLARE O_COUNT      INT;

    SET SQLSTRING = "";  
    SET CNTSTRING = "";
    SET O_COUNT = 0;
    
    SET P_RESULT_ID= -1;
    SET P_MESSAGE= "처리중 오류가 발생했습니다.";

    IF  P_PROC_ID = 'GET_USER_ID' THEN                
   
        SELECT USER_ID
        FROM SN_USER 
        WHERE USER_NM = P_USER_NM 
        AND DPT_CD = P_DPT_CD;

        SET P_RESULT_ID= 0;
        SET P_MESSAGE= "정상적으로 처리되었습니다.";

    ELSEIF P_PROC_ID = 'GET_USER_PW' THEN     

        SELECT USER_PW
        FROM SN_USER 
        WHERE USER_ID = P_USER_ID 
        AND USER_NM = P_USER_NM;

        SET P_RESULT_ID= 0;
        SET P_MESSAGE= "정상적으로 처리되었습니다.";

    END IF;

END//
DELIMITER ;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
