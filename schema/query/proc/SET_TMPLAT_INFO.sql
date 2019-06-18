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

-- 프로시저 REDSPUSH.SET_TMPLAT_INFO 구조 내보내기
DELIMITER //
CREATE DEFINER=`redspush`@`%` PROCEDURE `SET_TMPLAT_INFO`(
	IN `P_PROC_ID` VARCHAR(100),
  IN `P_USR_ID` VARCHAR(80),
  IN `P_RCVGRP_NM` VARCHAR(20),
  IN `P_RCV_USR_ID_LIST` TEXT,
  IN `P_RCVGRP_NO` INT(10),
  IN `P_MSGPLN_NO` INT(10),
  IN `P_TMPLAT_NM` VARCHAR(50),
  IN `P_MSG_CTNTS_CAT` VARCHAR(1),
  IN `P_TRNS_MTHD_TYPE` VARCHAR(1),
  IN `P_RPT_TRNS_RULE` VARCHAR(20),
  IN `P_RESE_TRNS_TS` VARCHAR(40),
  IN `P_PUSH_TRNS_YN` VARCHAR(1),
  IN `P_SMS_TRNS_YN` VARCHAR(1),
  IN `P_MSG_SUBJ` VARCHAR(100),
  IN `P_MSG_CTNTS` LONGTEXT,
  IN `P_ATT_CAT_EXT` VARCHAR(5),
  IN `P_ATT_FILE_PATH` VARCHAR(256),
  IN `P_MSG_CTNTS_ATTR` VARCHAR(1),
	OUT `P_RESULT_ID` INT,
	OUT `P_MESSAGE` VARCHAR(500)        
 
)
    COMMENT '[oslee] 푸시 템플릿 설정'
BEGIN

    SET P_RESULT_ID= -1;
    SET P_MESSAGE= "처리중 오류가 발생했습니다.";

    IF  P_PROC_ID = 'INSERT_TMPLAT_INFO' THEN
      # 수신 템플릿 저장
      INSERT INTO PM_TMPLATRCV (WTR_ID,
                                 RCVGRP_NM,
                                 RCV_USR_ID_LIST,
                                 REG_TS
                                 )
           VALUES (P_USR_ID,
                   P_RCVGRP_NM,
                   P_RCV_USR_ID_LIST,
                   NOW());

      SELECT  AUTO_INCREMENT - 1
        INTO    P_RCVGRP_NO
        FROM information_schema.TABLES 
       WHERE   TABLE_SCHEMA= "REDSPUSH"
         AND     TABLE_NAME = "PM_TMPLATRCV"; 
           
      # 메세지 템플릿 저장
      INSERT INTO PM_TMPLATMSG (WTR_ID,
                                 RCVGRP_NO,
                                 TMPLAT_NM,
                                 MSG_CTNTS_CAT,
                                 TRNS_MTHD_TYPE,
                                 RPT_TRNS_RULE,
                                 RESE_TRNS_TS,
                                 PUSH_TRNS_YN,
                                 SMS_TRNS_YN,
                                 MSG_SUBJ,
                                 MSG_CTNTS,
                                 ATT_CAT_EXT,
                                 ATT_FILE_PATH,
                                 MSG_CTNTS_ATTR,
                                 REG_TS)
           VALUES (P_USR_ID,
                   P_RCVGRP_NO,
                   P_TMPLAT_NM,
                   P_MSG_CTNTS_CAT,
                   P_TRNS_MTHD_TYPE,
                   P_RPT_TRNS_RULE,
                   P_RESE_TRNS_TS,
                   P_PUSH_TRNS_YN,
                   P_SMS_TRNS_YN,
                   P_MSG_SUBJ,
                   P_MSG_CTNTS,
                   P_ATT_CAT_EXT,
                   P_ATT_FILE_PATH,
                   P_MSG_CTNTS_ATTR,
                   NOW());
      
        SET P_RESULT_ID= 0;
        SET P_MESSAGE= "정상적으로 처리되었습니다."; 
        
    ELSEIF  P_PROC_ID = 'UPDATE_TMPLAT_INFO' THEN
    
      UPDATE PM_TMPLATRCV
         SET RCVGRP_NM = P_RCVGRP_NM,
             RCV_USR_ID_LIST = P_RCV_USR_ID_LIST,
             UPD_TS = NOW()
       WHERE RCVGRP_NO = P_RCVGRP_NO;
       
       
      UPDATE PM_TMPLATMSG
         SET TMPLAT_NM = P_TMPLAT_NM,
             MSG_CTNTS_CAT = P_MSG_CTNTS_CAT,
             TRNS_MTHD_TYPE = P_TRNS_MTHD_TYPE,
             RPT_TRNS_RULE = P_RPT_TRNS_RULE,
             RESE_TRNS_TS = P_RESE_TRNS_TS,
             PUSH_TRNS_YN = P_PUSH_TRNS_YN,
             SMS_TRNS_YN = P_SMS_TRNS_YN,
             MSG_SUBJ = P_MSG_SUBJ,
             MSG_CTNTS = P_MSG_CTNTS,
             ATT_CAT_EXT = P_ATT_CAT_EXT,
             ATT_FILE_PATH = P_ATT_FILE_PATH,
             MSG_CTNTS_ATTR = P_MSG_CTNTS_ATTR,
             UPD_TS = NOW()
       WHERE MSGPLN_NO = P_MSGPLN_NO;
       
        SET P_RESULT_ID= 0;
        SET P_MESSAGE= "정상적으로 처리되었습니다.";        
        
    ELSEIF  P_PROC_ID = 'DELETE_ATTACH_INFO' THEN
      
      UPDATE PM_TMPLATMSG
         SET ATT_CAT_EXT = null,
             ATT_FILE_PATH = null,
             UPD_TS = NOW()
       WHERE MSGPLN_NO = P_MSGPLN_NO;
       
        SET P_RESULT_ID= 0;
        SET P_MESSAGE= "정상적으로 처리되었습니다.";             
       
    END IF;  
END//
DELIMITER ;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
