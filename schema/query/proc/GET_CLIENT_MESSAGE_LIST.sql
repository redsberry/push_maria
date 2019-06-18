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

-- 프로시저 REDSPUSH.GET_CLIENT_MESSAGE_LIST 구조 내보내기
DELIMITER //
CREATE DEFINER=`redspush`@`%` PROCEDURE `GET_CLIENT_MESSAGE_LIST`( 
    IN    P_PROC_ID		      VARCHAR(50)	 ,
		IN    P_USR_ID          VARCHAR(50)	 ,
    IN    P_SEARCH          VARCHAR(100) ,
    IN    P_START_NO        INTEGER      ,    
    IN    P_PAGE_NO         INTEGER      ,
    OUT   P_RESULT_COUNT    INTEGER      ,
		OUT 	P_RESULT_ID       INTEGER      ,
		OUT 	P_MESSAGE         VARCHAR(500)
)
BEGIN
    DECLARE V_TOTAL_COUNT        INTEGER;
    DECLARE C_PAGE_RECORD_GAP    INTEGER;
    DECLARE V_PAGE_TOTAL_NUM     INTEGER;
    DECLARE V_PAGE_START         INTEGER;
    DECLARE V_PAGE_END           INTEGER;
    
    SET P_RESULT_ID	= 0;
    SET P_MESSAGE	= "정상적으로 처리되었습니다.";
	  SET C_PAGE_RECORD_GAP = P_PAGE_NO;
    
    IF P_PROC_ID = "GET_SEND_MESSAGE" THEN
        # 전체 메세지 수 읽어 오기
        SET V_TOTAL_COUNT = (SELECT COUNT(*) FROM PM_MSGSEND A, PM_MSGCNTS B 
                             WHERE A.USR_ID = P_USR_ID 
                             AND B.TRNS_NO = A.TRNS_NO
                             AND B.MSG_SUBJ LIKE CONCAT("%",P_SEARCH,"%"));        
        
        # 총 페이징 수
        SET V_PAGE_TOTAL_NUM = CEILING(V_TOTAL_COUNT / C_PAGE_RECORD_GAP);
        
        # 페이징 범위 선정
        SET V_PAGE_START = P_START_NO * C_PAGE_RECORD_GAP;
        SET V_PAGE_END = C_PAGE_RECORD_GAP; 
        
        # 조회 결과수
        IF (V_TOTAL_COUNT - (V_PAGE_START + C_PAGE_RECORD_GAP)) > 0 THEN
          SET P_RESULT_COUNT = C_PAGE_RECORD_GAP;
        ELSE 
          SET P_RESULT_COUNT = (V_TOTAL_COUNT - V_PAGE_START);
        END IF;
        
        SELECT  
                V_TOTAL_COUNT as MSG_TOTAL_COUNT
                , V_PAGE_TOTAL_NUM as PAGE_TOTAL_NUM
                , P_START_NO as PAGE_NUM
                , A.SNDMSG_NO as SNDMSG_NO 
                , A.TRNS_NO as TRANS_NO
                , B.TRNS_CAT_CD as TRANS_CAT_CD
                , B.RCV_USR_ID_LIST as RCV_USR_ID_LIST
                , '' as RCV_USR_NM_LIST
                , C.MSG_SUBJ as MSG_SUBJ
                , C.MSG_CTNTS as MSG_CTNTS
                , C.ATT_CAT_EXT as ATT_CAT_EXT
                , C.ATT_FILE_PATH as ATT_FILE_PATH
                , DATE_FORMAT(A.SND_TS, '%Y-%m-%d %H:%i') as SND_TS
                , 0 as READ_COUNT
                , 1 as TOTAL_COUNT                                
        FROM  PM_MSGSEND A, PM_MSGPLAN B, PM_MSGCNTS C
        WHERE  A.USR_ID    = P_USR_ID           
        AND  B.TRNS_NO   = A.TRNS_NO
        AND  C.TRNS_NO   = A.TRNS_NO   
        AND  C.MSG_SUBJ LIKE CONCAT("%",P_SEARCH,"%") 
        ORDER BY A.TRNS_NO DESC
        LIMIT V_PAGE_START, V_PAGE_END;
        
    ELSEIF P_PROC_ID = "GET_RECEIVE_MESSAGE" THEN
        SET P_RESULT_ID = 0;
    END IF;

END//
DELIMITER ;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
