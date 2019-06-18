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

-- 프로시저 REDSPUSH.GET_MESSAGE_INFO 구조 내보내기
DELIMITER //
CREATE DEFINER=`redspush`@`%` PROCEDURE `GET_MESSAGE_INFO`(  P_PROC_ID		    VARCHAR(50)	,
							       	P_REQ_NO            INT         ,
							        OUT 	P_RESULT_ID INTEGER     ,
								    OUT 	P_MESSAGE   VARCHAR(500)
							       	)
BEGIN
    SET P_RESULT_ID	= 0;
    SET P_MESSAGE	= "정상적으로 처리되었습니다.";
	
    IF P_PROC_ID = "GET_SEND_MESSAGE" THEN
        
        SELECT  A.SNDMSG_NO         , 
                A.TRNS_NO           , 
                B.TRNS_CAT_CD       , 
                B.RCV_USR_ID_LIST   ,
                C.MSG_SUBJ          ,
                C.MSG_CTNTS         ,
                C.ATT_CAT_EXT       ,
                C.ATT_FILE_PATH     ,
                DATE_FORMAT(A.SND_TS, '%Y-%m-%d %H:%i')  SND_TS
          FROM  PM_MSGSEND A, PM_MSGPLAN B, PM_MSGCNTS C
         WHERE  A.SNDMSG_NO = P_REQ_NO
           AND  B.TRNS_NO   = A.TRNS_NO
           AND  C.TRNS_NO   = B.TRNS_NO;
		
    ELSEIF P_PROC_ID = "GET_RECEIVE_MESSAGE" THEN
        
        SELECT  A.RCVMSG_NO         , 
                A.TRNS_NO           , 
                A.READING_YN        ,
                A.SNDMSG_NO         ,
                B.SND_USR_ID        ,
                B.TRNS_CAT_CD       , 
                B.RCV_USR_ID_LIST   ,
                C.MSG_SUBJ          ,
                C.MSG_CTNTS         ,
                C.ATT_CAT_EXT       ,
                C.ATT_FILE_PATH     ,
                DATE_FORMAT(A.RCV_TS, '%Y-%m-%d %H:%i')  RCV_TS
          FROM  PM_MSGRECV A, PM_MSGPLAN B, PM_MSGCNTS C
         WHERE  A.RCVMSG_NO = P_REQ_NO
           AND  B.TRNS_NO   = A.TRNS_NO
           AND  C.TRNS_NO   = B.TRNS_NO;
    
    END IF;

END//
DELIMITER ;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
