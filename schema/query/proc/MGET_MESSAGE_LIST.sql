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

-- 프로시저 REDSPUSH.MGET_MESSAGE_LIST 구조 내보내기
DELIMITER //
CREATE DEFINER=`redspush`@`%` PROCEDURE `MGET_MESSAGE_LIST`( 
    IN    P_PROC_ID		              VARCHAR(50)	,
    IN    P_USR_ID                  VARCHAR(50)	,
    IN    P_TRNS_NO                 INT         ,
    IN    P_LIMIT_DATE              VARCHAR(30) ,
    OUT   P_MESSAGE_TOTAL_COUNT     INTEGER   ,
    OUT   P_RESULT_COUNT            INTEGER   ,
    OUT 	P_RESULT_ID               INTEGER   ,
    OUT 	P_MESSAGE                 VARCHAR(500)
)
BEGIN
    DECLARE C_LIMIT_DATE VARCHAR(30);
    SET P_RESULT_ID	= 0;
    SET P_MESSAGE	= "정상적으로 처리되었습니다.";
	  SET P_MESSAGE_TOTAL_COUNT = 0;    
        
    IF P_LIMIT_DATE = '' THEN
      SET C_LIMIT_DATE = '1900-01-01 00:00:00';
    ELSE 
      SET C_LIMIT_DATE = P_LIMIT_DATE;
    END IF;
    
    IF P_PROC_ID = "GET_NEW_SEND_MESSAGE" THEN
        
        SELECT  COUNT(A.SNDMSG_NO)
          INTO  P_RESULT_COUNT
          FROM  PM_MSGSEND A, PM_MSGPLAN B, PM_MSGCNTS C
         WHERE  A.USR_ID    = P_USR_ID
           AND  A.TRNS_NO   > P_TRNS_NO
           AND  B.TRNS_NO   = A.TRNS_NO
           AND  C.TRNS_NO   = B.TRNS_NO
           AND  A.SND_TS    >= C_LIMIT_DATE;
           
        SELECT COUNT(SNDMSG_NO)
          INTO P_MESSAGE_TOTAL_COUNT
          FROM PM_MSGSEND
         WHERE USR_ID = P_USR_ID
           AND SND_TS >= C_LIMIT_DATE;
        
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
         WHERE  A.USR_ID    = P_USR_ID
           AND  A.TRNS_NO   > P_TRNS_NO
           AND  B.TRNS_NO   = A.TRNS_NO
           AND  C.TRNS_NO   = B.TRNS_NO
           AND  A.SND_TS    >= C_LIMIT_DATE;
		
    ELSEIF P_PROC_ID = "GET_NEW_RECEIVE_MESSAGE" THEN
        
        SELECT  COUNT(A.RCVMSG_NO)
          INTO  P_RESULT_COUNT
          FROM  PM_MSGRECV A, PM_MSGPLAN B, PM_MSGCNTS C
         WHERE  A.USR_ID    = P_USR_ID
           AND  A.RCVMSG_NO > P_TRNS_NO
           AND  B.TRNS_NO   = A.TRNS_NO
           AND  C.TRNS_NO   = B.TRNS_NO
           AND  A.RCV_TS    >= C_LIMIT_DATE;
           
        SELECT COUNT(RCVMSG_NO)
          INTO P_MESSAGE_TOTAL_COUNT
          FROM PM_MSGRECV
         WHERE USR_ID = P_USR_ID
           AND RCV_TS >= C_LIMIT_DATE;
        
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
         WHERE  A.USR_ID    = P_USR_ID
           AND  A.TRNS_NO   > P_TRNS_NO
           AND  B.TRNS_NO   = A.TRNS_NO
           AND  C.TRNS_NO   = B.TRNS_NO
           AND  A.RCV_TS    >= C_LIMIT_DATE;
		
    ELSEIF P_PROC_ID = "GET_ALL_NEW_MESSAGE" THEN
        
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
         WHERE  A.USR_ID    = P_USR_ID
           AND  A.TRNS_NO   > P_TRNS_NO
           AND  B.TRNS_NO   = A.TRNS_NO
           AND  C.TRNS_NO   = B.TRNS_NO;
        
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
         WHERE  A.USR_ID    = P_USR_ID
           AND  A.RCVMSG_NO > P_TRNS_NO
           AND  B.TRNS_NO   = A.TRNS_NO
           AND  C.TRNS_NO   = B.TRNS_NO;
		
    ELSEIF P_PROC_ID = "GET_TARGET_SEND_MESSAGE" THEN
        
        SELECT  COUNT(A.TRNS_NO)
          INTO  P_RESULT_COUNT
          FROM  PM_MSGPLAN A, PM_MSGCNTS B
         WHERE  A.TRNS_CAT_CD   = "P"
           AND  A.TRNS_CMPT_YN  = "N"
           AND  B.TRNS_NO       = A.TRNS_NO
         LIMIT  0, 100; 
        
        SELECT  A.TRNS_NO           , 
                A.MSGPLN_NO         ,
                A.SND_USR_ID        ,
                A.RCV_USR_ID_LIST   ,
                B.MSG_SUBJ          ,
                B.MSG_CTNTS         ,
                B.ATT_CAT_EXT       ,
                B.ATT_FILE_PATH     ,
                C.SNDMSG_NO         ,
                DATE_FORMAT(A.TRNS_REQ_TS, '%Y-%m-%d %H:%i')  TRNS_REQ_TS
          FROM  PM_MSGPLAN A, PM_MSGCNTS B, PM_MSGSEND C
         WHERE  A.TRNS_CAT_CD   = "P"
           AND  A.TRNS_CMPT_YN  = "N"
           AND  B.TRNS_NO       = A.TRNS_NO
           AND  C.TRNS_NO       = A.TRNS_NO
         LIMIT  0, 100; 
		
    ELSEIF P_PROC_ID = "GET_TARGET_SEND_MESSAGE_COUNT" THEN
        
        SELECT  COUNT(A.TRNS_NO)
          INTO  P_RESULT_COUNT
          FROM  PM_MSGPLAN A, PM_MSGCNTS B
         WHERE  A.TRNS_CAT_CD   = "P"
           AND  A.TRNS_CMPT_YN  = "N"
           AND  B.TRNS_NO       = A.TRNS_NO;
    
    END IF;

END//
DELIMITER ;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
