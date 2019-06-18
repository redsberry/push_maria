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

-- 프로시저 REDSPUSH.GET_MOBILE_BOARDLIST 구조 내보내기
DELIMITER //
CREATE DEFINER=`redspush`@`%` PROCEDURE `GET_MOBILE_BOARDLIST`(
    IN  `P_PROC_ID`     VARCHAR(30),
    IN  `P_BRD_CD`      VARCHAR(5),
    IN  `P_USER_ID`     VARCHAR(80),
  	IN  `P_START_NO`    INT,
  	IN  `P_PAGE_NO`     INT,   
    OUT `P_BOARD_CNT`   INT,
    OUT P_RESULT_ID     INT,
    OUT P_MESSAGE       TINYTEXT        
)
BEGIN
    SET P_RESULT_ID = 0;
    SET P_MESSAGE   = "정상적으로 처리되었습니다.";
    SET @ROWNUM = P_START_NO;
    
    IF  P_PROC_ID = 'GET_MOBILE_BOARDLIST' THEN
    
      SELECT COUNT(A.CNTS_SEQ_NO)
            INTO P_BOARD_CNT
        FROM BD_BOARD A
       WHERE BRD_CD = P_BRD_CD;       
    
      SELECT @ROWNUM := @ROWNUM+1 RM,
             A.CNTS_SEQ_NO,
             A.BRD_CD,
             A.CNTS_ORD,
             A.CNTS_DEPTH,
             A.CNTS_TYPE,
             A.CNTS_KIND_CD,
             A.CNTS_WR_DPT,
             A.CNTS_SUBJ,
             A.CNTS_MSG,
             A.ATTFILE_YN,
             A.REA_CNT,
             A.WTR_ID,
             A.WTR_NM,
             A.REG_TS,
             A.UPD_TS,
             (SELECT 1 FROM BD_READLOG WHERE BD_READLOG.CNTS_SEQ_NO = A.CNTS_SEQ_NO AND BD_READLOG.USR_ID = P_USER_ID) AS READ_YN
        FROM BD_BOARD A
       WHERE BRD_CD = P_BRD_CD
       ORDER BY A.CNTS_SEQ_NO DESC 
       LIMIT P_START_NO, P_PAGE_NO;
      
    ELSE
          SET P_RESULT_ID= -1;
          SET P_MESSAGE= "매개변수를 확인해주시기 바랍니다.";
  END IF;    
    
END//
DELIMITER ;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
