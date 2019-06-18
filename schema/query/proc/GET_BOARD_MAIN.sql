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

-- 프로시저 REDSPUSH.GET_BOARD_MAIN 구조 내보내기
DELIMITER //
CREATE DEFINER=`redspush`@`%` PROCEDURE `GET_BOARD_MAIN`(
    IN  `P_BBS_ID` VARCHAR(5),
    OUT `P_RESULT_ID` INT,
    OUT `P_MESSAGE` TINYTEXT        
 
)
BEGIN

    SET P_RESULT_ID= 0;
    SET P_MESSAGE= "정상적으로 처리되었습니다.";
    
     SELECT BRD_CD,
             CNTS_SEQ_NO,
             CNTS_DEPTH,
             CNTS_ORD,
             CNTS_SUBJ,
             CNTS_MSG,
             ATTFILE_YN,
             REA_CNT,
             WTR_ID,
             WTR_NM,
             DATE_FORMAT(REG_TS,'%Y-%m-%d') AS REG_TS
        FROM BD_BOARD
       WHERE CNTS_DEPTH = 1 
         AND BRD_CD = P_BBS_ID
    ORDER BY CNTS_ORD ASC
    LIMIT 0, 3;
     
END//
DELIMITER ;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
