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

-- 프로시저 REDSPUSH.GET_SEND_READ_LIST 구조 내보내기
DELIMITER //
CREATE DEFINER=`redspush`@`%` PROCEDURE `GET_SEND_READ_LIST`( 
    IN    P_PROC_ID		              VARCHAR(50)	,
    IN    P_TRNS_NO                 INT         ,
    OUT   P_MESSAGE_TOTAL_COUNT     INTEGER     ,
    OUT   P_MESSAGE_READ_COUNT      INTEGER     ,
    OUT 	P_RESULT_ID               INTEGER     ,
    OUT 	P_MESSAGE                 VARCHAR(500)
)
BEGIN
    SET P_RESULT_ID	= 0;
    SET P_MESSAGE	= "정상적으로 처리되었습니다.";
	  SET P_MESSAGE_TOTAL_COUNT = 0;   
    SET P_MESSAGE_READ_COUNT = 0;   
    
    IF P_PROC_ID = "GET_SEND_MESSAGE_READ_LIST" THEN 
    
        SELECT  COUNT(READING_YN) 
          INTO  P_MESSAGE_TOTAL_COUNT 
          FROM  PM_MSGRECV  
          WHERE  TRNS_NO    = P_TRNS_NO;
        
        SELECT  COUNT(READING_YN) 
          INTO  P_MESSAGE_READ_COUNT 
          FROM  PM_MSGRECV 
          WHERE TRNS_NO    = P_TRNS_NO 
          AND   READING_YN = "Y";
          
        SELECT  A.USR_ID            , 
                A.TRNS_NO           , 
                A.READING_YN       ,
                B.USR_NM    , 
                B.AVT_IMG_PATH  
          FROM  SN_USR AS B 
          JOIN PM_MSGRECV AS A 
          ON (B.USR_ID = A.USR_ID)
          WHERE TRNS_NO    = P_TRNS_NO;
          
    END IF;
    
END//
DELIMITER ;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
