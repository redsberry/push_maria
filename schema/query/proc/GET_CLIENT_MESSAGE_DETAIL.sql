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

-- 프로시저 REDSPUSH.GET_CLIENT_MESSAGE_DETAIL 구조 내보내기
DELIMITER //
CREATE DEFINER=`redspush`@`%` PROCEDURE `GET_CLIENT_MESSAGE_DETAIL`( 
    IN    P_PROC_ID		    VARCHAR(50)	 ,
		IN    P_USR_ID        VARCHAR(50)	 ,
    IN    P_SELECT_ID     LONGTEXT     ,
    IN    P_TRNS_NO       INT          ,
    IN    P_SEARCH        VARCHAR(100) ,
    IN    P_START_NO      INT				   ,
	  IN    P_PAGE_NO       INT				   ,  
    OUT   P_RESULT_COUNT  INTEGER      ,
    OUT 	P_RESULT_ID     INTEGER      ,
    OUT 	P_MESSAGE       VARCHAR(500)
)
BEGIN
    DECLARE TOTAL_COUNT INT;
    DECLARE V_START_NO INT;
    
    SET P_RESULT_ID	= 0;
    SET P_MESSAGE	= "정상적으로 처리되었습니다.";
    SET TOTAL_COUNT = 0;
    SET V_START_NO = P_START_NO * P_PAGE_NO;
	
    IF P_PROC_ID = "GET_SEND_MESSAGE_DETAIL" THEN
        # 조회 결과 수
        SET P_RESULT_COUNT = (
            SELECT COUNT(*) FROM  PM_MSGSEND A, PM_MSGPLAN B, PM_MSGCNTS C
            WHERE  A.USR_ID    = P_USR_ID
            AND  A.TRNS_NO   = P_TRNS_NO
            AND  B.TRNS_NO   = A.TRNS_NO
            AND  C.TRNS_NO   = B.TRNS_NO
        );
        
        # 조회
        SELECT  1 AS TOTAL_COUNT    ,
                A.SNDMSG_NO         , 
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
           AND  A.TRNS_NO   = P_TRNS_NO
           AND  B.TRNS_NO   = A.TRNS_NO
           AND  C.TRNS_NO   = B.TRNS_NO           
           ;
           
		
    ELSEIF P_PROC_ID = "GET_RECEIVE_MESSAGE_DETAIL" THEN
        # 조회 결과 수
        SET P_RESULT_COUNT = (
              SELECT COUNT(A.RCVMSG_NO)
              FROM  PM_MSGRECV A, PM_MSGPLAN B, PM_MSGCNTS C
              WHERE  A.USR_ID     = P_USR_ID
              AND  B.SND_USR_ID = P_SELECT_ID 
              AND  B.TRNS_NO    = A.TRNS_NO
              AND  C.TRNS_NO    = B.TRNS_NO
        );
        
        # 총 페이지 수 
        SELECT  CEILING(COUNT(A.RCVMSG_NO)/P_PAGE_NO) 
          INTO  TOTAL_COUNT 
          FROM  PM_MSGRECV A, PM_MSGPLAN B, PM_MSGCNTS C
         WHERE  A.USR_ID     = P_USR_ID
           AND  B.SND_USR_ID = P_SELECT_ID 
           AND  B.TRNS_NO    = A.TRNS_NO
           AND  C.TRNS_NO    = B.TRNS_NO;
        
        # 조회
        SELECT R1.* FROM ( 
          SELECT TOTAL_COUNT        ,  
                A.RCVMSG_NO         , 
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
             AND  B.SND_USR_ID = P_SELECT_ID 
             AND  B.TRNS_NO   = A.TRNS_NO
             AND  C.TRNS_NO   = B.TRNS_NO
             ORDER BY A.RCV_TS ASC
        ) R1 
        LIMIT V_START_NO , P_PAGE_NO;
           
    END IF;

END//
DELIMITER ;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
