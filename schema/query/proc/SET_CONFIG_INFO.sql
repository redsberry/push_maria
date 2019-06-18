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

-- 프로시저 REDSPUSH.SET_CONFIG_INFO 구조 내보내기
DELIMITER //
CREATE DEFINER=`redspush`@`%` PROCEDURE `SET_CONFIG_INFO`(
  IN `P_PROC_ID`       VARCHAR(30)     ,
  IN `P_CNF_CD`        VARCHAR(5)      ,
  IN `P_CNF_NM`        VARCHAR(60)     ,
  IN `P_CNF_VALUE`     TEXT            ,
  OUT `P_RESULT_ID`    INT             ,
  OUT `P_MESSAGE`      VARCHAR(500)
)
BEGIN
    SET P_RESULT_ID= -1;
    SET P_MESSAGE= "처리중 오류가 발생했습니다.";

    IF  P_PROC_ID = 'CONFIG_INSERT' THEN  
      INSERT INTO SN_CONFIG (CNF_CD,
                          CNF_NM,
                          CNF_VALUE)
          VALUES (P_CNF_CD,
                  P_CNF_NM,
                  P_CNF_VALUE);
        SET P_RESULT_ID= 0;
        SET P_MESSAGE= "정상적으로 처리되었습니다."; 
    
    ELSEIF  P_PROC_ID = 'CONFIG_UPDATE' THEN
      UPDATE  SN_CONFIG
      SET     CNF_VALUE            = IFNULL(P_CNF_VALUE,'') 
			  WHERE CNF_NM = P_CNF_NM;
        SET P_RESULT_ID= 0;
        SET P_MESSAGE= "정상적으로 처리되었습니다.";  
    
    END IF;
 END//
DELIMITER ;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;