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

-- 프로시저 REDSPUSH.GET_SEND_HISTORY_INFO 구조 내보내기
DELIMITER //
CREATE DEFINER=`redspush`@`%` PROCEDURE `GET_SEND_HISTORY_INFO`(
	IN `P_TRNS_NO` INT(10),
	OUT `P_RESULT_ID` INTEGER,
	OUT `P_MESSAGE` VARCHAR(500)
)
    COMMENT '[oslee97] 발송이력 상세 조회.'
BEGIN

    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET P_RESULT_ID = -1;
    SET P_RESULT_ID = 0; 
    SET P_MESSAGE = "정상적으로 처리되었습니다.";
    
      SELECT A.TRNS_NO, 
             IFNULL(A.MSGPLN_NO, '') AS MSGPLN_NO, 
             DATE_FORMAT(A.TRNS_REQ_TS, '%Y-%m-%d %H:%i:%s') AS TRNS_REQ_TS, 
             IFNULL(A.TRNS_CAT_CD, '') AS TRNS_CAT_CD, 
             (CASE WHEN A.TRNS_CAT_CD = 'P' THEN 'PUSH' 
                  WHEN A.TRNS_CAT_CD = 'S' THEN 'SMS' 
                  WHEN A.TRNS_CAT_CD = 'M' THEN 'MMS' 
                  ELSE '' 
              END) AS TRNS_CAT_NM, 
             IFNULL(A.TRNS_STE, '') AS TRNS_STE, 
             (CASE WHEN A.TRNS_STE = 'S' THEN '성공' 
                  WHEN A.TRNS_STE = 'F' THEN '실패' 
                  WHEN A.TRNS_STE = 'N' THEN '발송대기' 
                  ELSE '' 
             END) AS TRNS_STE_NM, 
             IFNULL(B.MSG_SUBJ, '') AS MSG_SUBJ, 
             IFNULL(B.MSG_CTNTS, '') AS MSG_CTNTS, 
             IFNULL(B.ATT_CAT_EXT, '') AS ATT_CAT_EXT, 
             IFNULL(B.ATT_FILE_PATH, '') AS ATT_FILE_PATH, 
             IFNULL(A.SND_USR_ID, '') AS SND_USR_ID, 
             IFNULL(A.RCV_USR_ID_LIST, '') AS RCV_USR_ID_LIST, 
             IFNULL(A.RETRY_SEQ, '') AS RETRY_SEQ, 
             IFNULL(A.TRNS_CMPT_YN, '') AS TRNS_CMPT_YN, 
             IFNULL(A.TRNS_MTHD_TYPE, '') AS TRNS_MTHD_TYPE, 
             IFNULL(A.MSG_CAT, '') AS MSG_CAT, 
             (CASE WHEN A.MSG_CAT = 'A' THEN '광고' 
                  WHEN A.MSG_CAT = 'B' THEN '업무' 
                  WHEN A.MSG_CAT = 'C' THEN '일정' 
                  WHEN A.MSG_CAT = 'E' THEN '기타' 
                  ELSE '' 
             END) AS MSG_CAT_NM,             
             IFNULL(A.RPT_TRNS_RULE, '') AS RPT_TRNS_RULE, 
             IFNULL(A.RESE_TRNS_TS, '') AS RESE_TRNS_TS, 
             IFNULL(A.PUSH_TRNS_YN, '') AS PUSH_TRNS_YN, 
             IFNULL(A.SMS_TRNS_YN, '') AS SMS_TRNS_YN, 
             DATE_FORMAT(C.SND_TS, '%Y-%m-%d %H:%i:%s') AS SND_TS 
        FROM PM_MSGPLAN A, PM_MSGCNTS B, PM_MSGSEND C 
        WHERE A.TRNS_NO = B.TRNS_NO 
          AND A.TRNS_NO = C.TRNS_NO 
          AND A.TRNS_NO = P_TRNS_NO;

    IF P_RESULT_ID < 0 THEN
        SET P_MESSAGE = "조회중 오류가 발생하였습니다.";
    END IF;
    
 END//
DELIMITER ;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
