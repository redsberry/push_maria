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

-- 프로시저 REDSPUSH.GET_SEND_HISTORY_LIST 구조 내보내기
DELIMITER //
CREATE DEFINER=`redspush`@`%` PROCEDURE `GET_SEND_HISTORY_LIST`(
	IN `P_USR_ID` VARCHAR(80),
  IN `P_STE` VARCHAR(1),  
  IN `P_CAT_CD` VARCHAR(1),
  IN `P_FROM_DT` VARCHAR(20),
  IN `P_TO_DT` VARCHAR(20),
  IN `P_START_NO` INTEGER,
  IN `P_PAGE_NO` INTEGER,  
  OUT `P_LIST_CNT` INTEGER,
	OUT `P_RESULT_ID` INTEGER,
	OUT `P_MESSAGE` VARCHAR(500)
)
    COMMENT '[oslee97] 발송이력 목록 조회.'
BEGIN

    DECLARE SQLSTRING   TEXT;
    DECLARE CNTSTRING   TEXT;
    
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
      BEGIN
        SET P_RESULT_ID	= -1;
        SET P_MESSAGE	= "조회중 오류가 발생하였습니다.";
    END;    
        
    SET SQLSTRING = "";  
    SET CNTSTRING = "";
        
    SET P_RESULT_ID= 0;
    SET P_MESSAGE= "정상적으로 처리되었습니다.";

		SET @EXEC_USR_ID  = P_USR_ID;
		SET @EXEC_ST  = P_START_NO;
		SET @EXEC_CNT  = P_PAGE_NO;            
    SET @ROWNUM =P_START_NO;
    
    SET CNTSTRING = CONCAT(CNTSTRING, "		SELECT COUNT(A.TRNS_NO) AS CNT \n");
    SET CNTSTRING = CONCAT(CNTSTRING, "     INTO @P_CNT \n");
    SET CNTSTRING = CONCAT(CNTSTRING, "		  FROM PM_MSGPLAN A, PM_MSGCNTS B, PM_MSGSEND C \n");
    SET CNTSTRING = CONCAT(CNTSTRING, "		  WHERE A.TRNS_NO = B.TRNS_NO \n");
    SET CNTSTRING = CONCAT(CNTSTRING, "		    AND A.TRNS_NO = C.TRNS_NO \n");
    SET CNTSTRING = CONCAT(CNTSTRING, "		    AND A.SND_USR_ID = ? \n");
    
		IF P_STE != '' THEN
		    SET @EXEC_STE  = P_STE;
		    SET CNTSTRING = CONCAT(CNTSTRING, "AND    A.TRNS_STE = @EXEC_STE \n");
    END IF;    
		IF P_CAT_CD != '' THEN
		    SET @EXEC_CAT_CD  = P_CAT_CD;
		    SET CNTSTRING = CONCAT(CNTSTRING, "AND    A.MSG_CAT = @EXEC_CAT_CD \n");
    END IF;
		IF P_FROM_DT != '' THEN
		    SET @EXEC_FROM_DT  = P_FROM_DT;
        SET @EXEC_TO_DT  = P_TO_DT;
		    SET CNTSTRING = CONCAT(CNTSTRING, "AND   DATE_FORMAT(A.TRNS_REQ_TS, '%Y-%m-%d') BETWEEN @EXEC_FROM_DT AND @EXEC_TO_DT \n");	   
		END IF;
                    
		SET @EXEC_CNT_SQL 	= CNTSTRING;
		PREPARE STMT_CNT FROM  @EXEC_CNT_SQL;		
    EXECUTE STMT_CNT USING @EXEC_USR_ID;
    DEALLOCATE PREPARE STMT_CNT;
    SET P_LIST_CNT = @P_CNT;
    
    SET SQLSTRING = CONCAT(SQLSTRING, "SELECT @ROWNUM := @ROWNUM+1 RM, \n");
    SET SQLSTRING = CONCAT(SQLSTRING, "			  T.TRNS_NO, \n");
    SET SQLSTRING = CONCAT(SQLSTRING, "       IFNULL(T.MSGPLN_NO, '') AS MSGPLN_NO, \n");
    SET SQLSTRING = CONCAT(SQLSTRING, "       IFNULL(T.TRNS_REQ_TS, '') AS TRNS_REQ_TS, \n");
    SET SQLSTRING = CONCAT(SQLSTRING, "       IFNULL(T.TRNS_CAT_CD, '') AS TRNS_CAT_CD, \n");
    SET SQLSTRING = CONCAT(SQLSTRING, "       IFNULL(T.TRNS_CAT_NM, '') AS TRNS_CAT_NM, \n");
    SET SQLSTRING = CONCAT(SQLSTRING, "       IFNULL(T.TRNS_STE, '') AS TRNS_STE, \n");
    SET SQLSTRING = CONCAT(SQLSTRING, "       IFNULL(T.TRNS_STE_NM, '') AS TRNS_STE_NM, \n");
    SET SQLSTRING = CONCAT(SQLSTRING, "       IFNULL(T.MSG_CTNTS, '') AS MSG_CTNTS, \n");
    SET SQLSTRING = CONCAT(SQLSTRING, "       IFNULL(T.MSG_SUBJ, '') AS MSG_SUBJ, \n");
    SET SQLSTRING = CONCAT(SQLSTRING, "       IFNULL(T.ATT_CAT_EXT, '') AS ATT_CAT_EXT, \n");
    SET SQLSTRING = CONCAT(SQLSTRING, "       IFNULL(T.ATT_FILE_PATH, '') AS ATT_FILE_PATH, \n");
    SET SQLSTRING = CONCAT(SQLSTRING, "       IFNULL(T.SND_USR_ID, '') AS SND_USR_ID, \n");
    SET SQLSTRING = CONCAT(SQLSTRING, "       IFNULL(T.RCV_USR_ID_LIST, '') AS RCV_USR_ID_LIST, \n");
    SET SQLSTRING = CONCAT(SQLSTRING, "       RCV_USR_NM, \n");
    SET SQLSTRING = CONCAT(SQLSTRING, "       IFNULL(T.RETRY_SEQ, '') AS RETRY_SEQ, \n");
    SET SQLSTRING = CONCAT(SQLSTRING, "       IFNULL(T.TRNS_CMPT_YN, '') AS TRNS_CMPT_YN, \n");
    SET SQLSTRING = CONCAT(SQLSTRING, "       IFNULL(T.TRNS_MTHD_TYPE, '') AS TRNS_MTHD_TYPE, \n");
    SET SQLSTRING = CONCAT(SQLSTRING, "       IFNULL(T.MSG_CAT, '') AS MSG_CAT, \n");
    SET SQLSTRING = CONCAT(SQLSTRING, "       T.MSG_CAT_NM, \n");
    SET SQLSTRING = CONCAT(SQLSTRING, "       IFNULL(T.RPT_TRNS_RULE, '') AS RPT_TRNS_RULE, \n");
    SET SQLSTRING = CONCAT(SQLSTRING, "       IFNULL(T.RESE_TRNS_TS, '') AS RESE_TRNS_TS, \n");
    SET SQLSTRING = CONCAT(SQLSTRING, "       IFNULL(T.PUSH_TRNS_YN, '') AS PUSH_TRNS_YN, \n");
    SET SQLSTRING = CONCAT(SQLSTRING, "       IFNULL(T.SMS_TRNS_YN, '') AS SMS_TRNS_YN, \n");
    SET SQLSTRING = CONCAT(SQLSTRING, "       IFNULL(T.SND_TS, '') AS SND_TS \n");
    SET SQLSTRING = CONCAT(SQLSTRING, "  FROM ( \n");
    SET SQLSTRING = CONCAT(SQLSTRING, "		SELECT A.TRNS_NO, \n");
    SET SQLSTRING = CONCAT(SQLSTRING, "		       A.MSGPLN_NO, \n");
    SET SQLSTRING = CONCAT(SQLSTRING, "		       DATE_FORMAT(A.TRNS_REQ_TS, '%Y-%m-%d %H:%i:%s') AS TRNS_REQ_TS, \n");
    SET SQLSTRING = CONCAT(SQLSTRING, "		       A.TRNS_CAT_CD, \n");
    SET SQLSTRING = CONCAT(SQLSTRING, "		       (CASE WHEN A.TRNS_CAT_CD = 'P' THEN 'PUSH' \n");
    SET SQLSTRING = CONCAT(SQLSTRING, "		            WHEN A.TRNS_CAT_CD = 'S' THEN 'SMS' \n");
    SET SQLSTRING = CONCAT(SQLSTRING, "		            WHEN A.TRNS_CAT_CD = 'M' THEN 'MMS' \n");
    SET SQLSTRING = CONCAT(SQLSTRING, "		            ELSE '' \n");
    SET SQLSTRING = CONCAT(SQLSTRING, "		        END) AS TRNS_CAT_NM, \n");
    SET SQLSTRING = CONCAT(SQLSTRING, "		       A.TRNS_STE, \n");
    SET SQLSTRING = CONCAT(SQLSTRING, "		       (CASE WHEN A.TRNS_STE = 'S' THEN '성공' \n");
    SET SQLSTRING = CONCAT(SQLSTRING, "		            WHEN A.TRNS_STE = 'F' THEN '실패' \n");
    SET SQLSTRING = CONCAT(SQLSTRING, "		            WHEN A.TRNS_STE = 'N' THEN '발송대기' \n");
    SET SQLSTRING = CONCAT(SQLSTRING, "		            ELSE '' \n");
    SET SQLSTRING = CONCAT(SQLSTRING, "		       END) AS TRNS_STE_NM, \n");
    SET SQLSTRING = CONCAT(SQLSTRING, "		       B.MSG_SUBJ, \n");
    SET SQLSTRING = CONCAT(SQLSTRING, "		       B.MSG_CTNTS, \n");
    SET SQLSTRING = CONCAT(SQLSTRING, "		       B.ATT_CAT_EXT, \n");
    SET SQLSTRING = CONCAT(SQLSTRING, "		       B.ATT_FILE_PATH, \n");
    SET SQLSTRING = CONCAT(SQLSTRING, "		       A.SND_USR_ID, \n");
    SET SQLSTRING = CONCAT(SQLSTRING, "		       A.RCV_USR_ID_LIST, \n");
    SET SQLSTRING = CONCAT(SQLSTRING, "		       (SELECT U.USR_NM FROM SN_USR U WHERE U.USR_ID = SUBSTRING_INDEX(A.RCV_USR_ID_LIST, ';', 1)) AS RCV_USR_NM, \n");
    SET SQLSTRING = CONCAT(SQLSTRING, "		       A.RETRY_SEQ, \n");
    SET SQLSTRING = CONCAT(SQLSTRING, "		       A.TRNS_CMPT_YN, \n");
    SET SQLSTRING = CONCAT(SQLSTRING, "		       A.TRNS_MTHD_TYPE, \n");
    SET SQLSTRING = CONCAT(SQLSTRING, "		       A.MSG_CAT, \n");
    SET SQLSTRING = CONCAT(SQLSTRING, "		     (CASE WHEN A.MSG_CAT = 'A' THEN '광고' \n");
    SET SQLSTRING = CONCAT(SQLSTRING, "		           WHEN A.MSG_CAT = 'B' THEN '업무' \n");
    SET SQLSTRING = CONCAT(SQLSTRING, "		           WHEN A.MSG_CAT = 'C' THEN '일정' \n");
    SET SQLSTRING = CONCAT(SQLSTRING, "		           WHEN A.MSG_CAT = 'E' THEN '기타' \n");
    SET SQLSTRING = CONCAT(SQLSTRING, "		           ELSE '' \n");
    SET SQLSTRING = CONCAT(SQLSTRING, "		      END) AS MSG_CAT_NM, \n");    
    SET SQLSTRING = CONCAT(SQLSTRING, "		       A.RPT_TRNS_RULE, \n");
    SET SQLSTRING = CONCAT(SQLSTRING, "		       A.RESE_TRNS_TS, \n");
    SET SQLSTRING = CONCAT(SQLSTRING, "		       A.PUSH_TRNS_YN, \n");
    SET SQLSTRING = CONCAT(SQLSTRING, "		       A.SMS_TRNS_YN, \n");
    SET SQLSTRING = CONCAT(SQLSTRING, "		       DATE_FORMAT(C.SND_TS, '%Y-%m-%d %H:%i:%s') AS SND_TS \n");
    SET SQLSTRING = CONCAT(SQLSTRING, "		  FROM PM_MSGPLAN A, PM_MSGCNTS B, PM_MSGSEND C \n");
    SET SQLSTRING = CONCAT(SQLSTRING, "		  WHERE A.TRNS_NO = B.TRNS_NO \n");
    SET SQLSTRING = CONCAT(SQLSTRING, "		    AND A.TRNS_NO = C.TRNS_NO \n");
    SET SQLSTRING = CONCAT(SQLSTRING, "		    AND A.SND_USR_ID = ? \n");
    SET SQLSTRING = CONCAT(SQLSTRING, "	) T \n");
    SET SQLSTRING = CONCAT(SQLSTRING, "	WHERE 1=1 \n");

		IF P_STE != '' THEN
		    SET @EXEC_STE  = P_STE;
		    SET SQLSTRING = CONCAT(SQLSTRING, "AND    T.TRNS_STE = @EXEC_STE \n");
    END IF;
		IF P_CAT_CD != '' THEN
		    SET @EXEC_CAT_CD  = P_CAT_CD;
		    SET SQLSTRING = CONCAT(SQLSTRING, "AND    T.MSG_CAT = @EXEC_CAT_CD \n");
    END IF;
		IF P_FROM_DT != '' THEN
		    SET @EXEC_FROM_DT  = P_FROM_DT;
        SET @EXEC_TO_DT  = P_TO_DT;
		    SET SQLSTRING = CONCAT(SQLSTRING, "AND   DATE_FORMAT(T.TRNS_REQ_TS, '%Y-%m-%d') BETWEEN @EXEC_FROM_DT AND @EXEC_TO_DT \n");	   
		END IF;

    SET SQLSTRING = CONCAT(SQLSTRING, "ORDER BY T.TRNS_NO DESC \n");
    SET SQLSTRING = CONCAT(SQLSTRING, "LIMIT ?, ? \n");

		SET @EXEC_SQL 	= SQLSTRING;
		PREPARE STMT FROM  @EXEC_SQL;		
    EXECUTE STMT USING @EXEC_USR_ID, @EXEC_ST, @EXEC_CNT;
		DEALLOCATE PREPARE STMT;
    
 END//
DELIMITER ;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
