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

-- 프로시저 REDSPUSH.GET_RESERVE_INFO 구조 내보내기
DELIMITER //
CREATE DEFINER=`redspush`@`%` PROCEDURE `GET_RESERVE_INFO`(
	IN `P_MNG_NO` INT(11),
	OUT `P_RESULT_ID` INTEGER,
	OUT `P_MESSAGE` VARCHAR(500)
)
    COMMENT '[oslee97] 발송이력 상세 조회.'
BEGIN

    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET P_RESULT_ID = -1;
    SET P_RESULT_ID = 0; 
    SET P_MESSAGE = "정상적으로 처리되었습니다.";
    
      SELECT T.MNG_NO, 
             IFNULL(T.MSGPLN_NO, '') AS MSGPLN_NO, 
             IFNULL(T.TRNS_START_TS, '') AS TRNS_START_TS, 
             IFNULL(T.TRNS_CAT_CD, '') AS TRNS_CAT_CD, 
             IFNULL(T.TRNS_CAT_NM, '') AS TRNS_CAT_NM, 
             IFNULL(T.MSG_CTNTS, '') AS MSG_CTNTS, 
             IFNULL(T.MSG_SUBJ, '') AS MSG_SUBJ, 
             IFNULL(T.ATT_CAT_EXT, '') AS ATT_CAT_EXT, 
             IFNULL(T.ATT_FILE_PATH, '') AS ATT_FILE_PATH, 
             IFNULL(T.SND_USR_ID, '') AS SND_USR_ID, 
             IFNULL(T.RCV_USR_ID_LIST, '') AS RCV_USR_ID_LIST, 
             T.RCV_USR_NM, 
             IFNULL(T.TRNS_MTHD_TYPE, '') AS TRNS_MTHD_TYPE, 
             IFNULL(T.TRNS_MTHD_TYPE_NM, '') AS TRNS_MTHD_TYPE_NM, 
             IFNULL(T.MSG_CAT, '') AS MSG_CAT, 
             T.MSG_CAT_NM, 
             IFNULL(T.RPT_TRNS_RULE, '') AS RPT_TRNS_RULE, 
             IFNULL(T.RESE_TRNS_TS, '') AS RESE_TRNS_TS 
        FROM ( 
      		SELECT A.MNG_NO, 
      		       A.MSGPLN_NO, 
      		       DATE_FORMAT(A.TRNS_START_TS, '%Y-%m-%d %H:%i:%s') AS TRNS_START_TS, 
      		       A.TRNS_CAT_CD, 
      		       (CASE WHEN A.TRNS_CAT_CD = 'P' THEN 'PUSH' 
      		            WHEN A.TRNS_CAT_CD = 'S' THEN 'SMS' 
      		            WHEN A.TRNS_CAT_CD = 'M' THEN 'MMS' 
      		            ELSE '' 
      		        END) AS TRNS_CAT_NM, 
      		       B.MSG_SUBJ, 
      		       B.MSG_CTNTS, 
      		       B.ATT_CAT_EXT, 
      		       B.ATT_FILE_PATH, 
      		       A.SND_USR_ID, 
      		       A.RCV_USR_ID_LIST, 
      		       (SELECT U.USR_NM FROM SN_USR U WHERE U.USR_ID = SUBSTRING_INDEX(A.RCV_USR_ID_LIST, ';', 1)) AS RCV_USR_NM, 
      		       A.TRNS_MTHD_TYPE, 
      		     (CASE WHEN A.TRNS_MTHD_TYPE = 'P' THEN '반복발송' 
      		           WHEN A.TRNS_MTHD_TYPE = 'R' THEN '예약발송' 
      		           ELSE '' 
      		      END) AS TRNS_MTHD_TYPE_NM,  
      		       A.MSG_CAT, 
      		     (CASE WHEN A.MSG_CAT = 'A' THEN '광고' 
      		           WHEN A.MSG_CAT = 'B' THEN '업무' 
      		           WHEN A.MSG_CAT = 'C' THEN '일정' 
      		           WHEN A.MSG_CAT = 'E' THEN '기타' 
      		           ELSE '' 
      		      END) AS MSG_CAT_NM,     
      		       A.RPT_TRNS_RULE, 
      		       DATE_FORMAT(A.RESE_TRNS_TS, '%Y-%m-%d %H:%i:%s') AS RESE_TRNS_TS 
      		  FROM PM_RESERVE A, PM_RESERVECNT B 
      		  WHERE A.MNG_NO = B.MNG_NO 
      		    AND A.MNG_NO = P_MNG_NO 
      	) T ;


    IF P_RESULT_ID < 0 THEN
        SET P_MESSAGE = "조회중 오류가 발생하였습니다.";
    END IF;
    
 END//
DELIMITER ;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
