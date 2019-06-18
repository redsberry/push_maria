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

-- 프로시저 REDSPUSH.GET_TMPLATE_INFO 구조 내보내기
DELIMITER //
CREATE DEFINER=`redspush`@`%` PROCEDURE `GET_TMPLATE_INFO`(
    IN `P_MSGPLN_NO`         INT(10),
    OUT `P_RESULT_ID`      INT ,	
    OUT `P_MESSAGE`        TINYTEXT
)
    COMMENT '[oslee97] 템플릿 상세 조회.'
BEGIN    	
     
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET P_RESULT_ID = -1;
    SET P_RESULT_ID = 0; 
    SET P_MESSAGE = "정상적으로 처리되었습니다.";
    
      SELECT T.MSGPLN_NO,
             T.WTR_ID,
             IFNULL(T.RCVGRP_NO, '') AS RCVGRP_NO,
             IFNULL(Y.RCV_USR_ID_LIST, '') AS RCV_USR_ID_LIST,
             IFNULL(T.TMPLAT_NM, '') AS TMPLAT_NM,
             IFNULL(T.MSG_CTNTS_CAT, '') AS MSG_CTNTS_CAT,
             IFNULL(T.TRNS_MTHD_TYPE, '') AS TRNS_MTHD_TYPE,
             IFNULL(T.RPT_TRNS_RULE, '') AS RPT_TRNS_RULE,
             IFNULL(T.RESE_TRNS_TS, '') AS RESE_TRNS_TS,
             DATE_FORMAT(T.RESE_TRNS_TS, '%Y-%m-%d') AS RESE_TRNS_DATE,
             DATE_FORMAT(T.RESE_TRNS_TS, '%H') AS RESE_TRNS_TIME,
             DATE_FORMAT(T.RESE_TRNS_TS, '%i') AS RESE_TRNS_MINUTE,             
             IFNULL(T.PUSH_TRNS_YN, '') AS PUSH_TRNS_YN,
             IFNULL(T.SMS_TRNS_YN, '') AS SMS_TRNS_YN,
             IFNULL(T.MSG_SUBJ, '') AS MSG_SUBJ,
             IFNULL(T.MSG_CTNTS, '') AS MSG_CTNTS,
             IFNULL(T.ATT_CAT_EXT, '') AS ATT_CAT_EXT,
             IFNULL(T.ATT_FILE_PATH, '') AS ATT_FILE_PATH,
             IFNULL(T.MSG_CTNTS_ATTR, '') AS MSG_CTNTS_ATTR,
             T.REG_TS,
             T.UPD_TS
        FROM PM_TMPLATMSG T, PM_TMPLATRCV Y
        WHERE T.RCVGRP_NO = Y.RCVGRP_NO
          AND T.MSGPLN_NO = P_MSGPLN_NO;
          
          
    IF P_RESULT_ID < 0 THEN
        SET P_MESSAGE ="매개변수를 확인해주시기 바랍니다.";
    END IF;

END//
DELIMITER ;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
