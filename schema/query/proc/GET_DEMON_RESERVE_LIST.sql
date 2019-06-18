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

-- 프로시저 REDSPUSH.GET_DEMON_RESERVE_LIST 구조 내보내기
DELIMITER //
CREATE DEFINER=`redspush`@`%` PROCEDURE `GET_DEMON_RESERVE_LIST`(
  OUT `P_RESULT_ID` INT             ,
  OUT `P_MESSAGE` TINYTEXT        
 
)
BEGIN
    SET P_RESULT_ID= 0;
    SET P_MESSAGE= "정상적으로 처리되었습니다.";

    SELECT  A.MNG_NO,  
            A.MSGPLN_NO,  
            A.TRNS_START_TS,  
            A.TRNS_CAT_CD,  
            A.SND_USR_ID,  
            A.RCV_USR_ID_LIST,  
            A.MSG_CAT,  
            A.TRNS_MTHD_TYPE,  
            A.RPT_TRNS_RULE,  
            A.RESE_TRNS_TS,  
            B.MSG_SUBJ, 
            B.MSG_CTNTS, 
            B.ATT_CAT_EXT, 
            B.ATT_FILE_PATH, 
            DATE_FORMAT(NOW(), '%Y%m%d%H%i') TODATE, 
            DATE_FORMAT(NOW(), '%W') TODAY 
      FROM PM_RESERVE A, PM_RESERVECNT B 
     WHERE A.MNG_NO = B.MNG_NO  
       AND (A.TRNS_MTHD_TYPE = 'R' AND DATE_FORMAT(A.RESE_TRNS_TS, '%Y%m%d%H%i') = DATE_FORMAT(NOW(), '%Y%m%d%H%i'))
  UNION ALL       
    SELECT  A.MNG_NO,  
            A.MSGPLN_NO,  
            A.TRNS_START_TS,  
            A.TRNS_CAT_CD,  
            A.SND_USR_ID,  
            A.RCV_USR_ID_LIST,  
            A.MSG_CAT,  
            A.TRNS_MTHD_TYPE,  
            A.RPT_TRNS_RULE,  
            A.RESE_TRNS_TS,  
            B.MSG_SUBJ, 
            B.MSG_CTNTS, 
            B.ATT_CAT_EXT, 
            B.ATT_FILE_PATH, 
            DATE_FORMAT(NOW(), '%Y%m%d%H%i') TODATE, 
            DATE_FORMAT(NOW(), '%W') TODAY 
      FROM PM_RESERVE A, PM_RESERVECNT B 
     WHERE A.MNG_NO = B.MNG_NO  
       AND A.TRNS_MTHD_TYPE = 'P';
       

END//
DELIMITER ;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
