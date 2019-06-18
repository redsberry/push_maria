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

-- 프로시저 REDSPUSH.SET_RESEND_MESSAGE 구조 내보내기
DELIMITER //
CREATE DEFINER=`redspush`@`%` PROCEDURE `SET_RESEND_MESSAGE`(  
        IN `P_PROC_ID`		        VARCHAR(50)	,
        IN `P_TRANS_NO`		        INT(10)	,
        IN `P_SND_USR_ID`         VARCHAR(80)	,
        IN `P_RCV_USR_ID_LIST`    TEXT	    ,
	      OUT 	`P_RESULT_ID`       INTEGER     ,
		    OUT 	`P_MESSAGE`         VARCHAR(500)
)
    COMMENT '[oslee] 메세지 재전송'
BEGIN
    DECLARE V_TRNS_NO       INT         DEFAULT 0;
    DECLARE V_TRNS_REQ_TS   DATE        DEFAULT NOW();
    DECLARE V_TRNS_CAT_CD   CHAR(1)     DEFAULT "P";
    DECLARE V_TRNS_STE      CHAR(1)     DEFAULT "N";
    DECLARE V_TRNS_CMPT_YN  CHAR(1)     DEFAULT "N";
    DECLARE V_CODE          VARCHAR(10) DEFAULT '00000';
	
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
        BEGIN
            GET DIAGNOSTICS CONDITION 1
                V_CODE = RETURNED_SQLSTATE, P_MESSAGE = MESSAGE_TEXT;
        END;
    
    SET P_RESULT_ID	= 0;
    SET P_MESSAGE	= "정상적으로 처리되었습니다.";
	
    IF P_PROC_ID = "SET_RESEND_MESSAGE" THEN
    			
      START   TRANSACTION;

      INSERT INTO PM_MSGPLAN (MSGPLN_NO,
                               TRNS_REQ_TS,
                               TRNS_CAT_CD,
                               TRNS_STE,
                               SND_USR_ID,
                               RCV_USR_ID_LIST,
                               TRNS_CMPT_YN,
                               TRNS_MTHD_TYPE,
                               MSG_CAT,
                               RPT_TRNS_RULE,
                               RETRY_SEQ,
                               RESE_TRNS_TS,
                               PUSH_TRNS_YN,
                               SMS_TRNS_YN)
                        SELECT
                             MSGPLN_NO,
                             NOW(),
                             TRNS_CAT_CD,
                             V_TRNS_STE,
                             P_SND_USR_ID,
                             P_RCV_USR_ID_LIST,
                             V_TRNS_CMPT_YN,
                             TRNS_MTHD_TYPE,
                             MSG_CAT,
                             RPT_TRNS_RULE,
                             RETRY_SEQ,
                             RESE_TRNS_TS,
                             PUSH_TRNS_YN,
                             SMS_TRNS_YN
                         FROM PM_MSGPLAN
                         WHERE TRNS_NO = P_TRANS_NO ;
                   

              SELECT  AUTO_INCREMENT - 1  
              INTO    V_TRNS_NO           
              FROM 	information_schema.TABLES 
              WHERE   TABLE_SCHEMA	= "REDSPUSH"
              AND     TABLE_NAME 		= "PM_MSGPLAN";
      		
              
                   
      INSERT INTO PM_MSGCNTS (TRNS_NO,
                               MSG_SUBJ,
                               MSG_CTNTS,
                               ATT_CAT_EXT,
                               ATT_FILE_PATH)
                   SELECT V_TRNS_NO,
                          MSG_SUBJ,
                          MSG_CTNTS,
                          ATT_CAT_EXT,
                          ATT_FILE_PATH
                   FROM PM_MSGCNTS
                   WHERE TRNS_NO = P_TRANS_NO;
                   
                   
      INSERT INTO PM_MSGSEND (SND_TS, USR_ID, TRNS_NO)
           VALUES (NOW(), P_SND_USR_ID, V_TRNS_NO); 
		
	    IF V_CODE = '00000' THEN
		    COMMIT;
	    ELSE
			ROLLBACK;
            SET P_RESULT_ID	= -1;
	    END IF;             
    END IF;

END//
DELIMITER ;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
