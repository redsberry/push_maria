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

-- 프로시저 REDSPUSH.GET_CPN_LIST 구조 내보내기
DELIMITER //
CREATE DEFINER=`redspush`@`%` PROCEDURE `GET_CPN_LIST`(
	IN `P_PROC_ID` VARCHAR(30)     ,
  IN `P_CPNY_NO` INT             ,
  IN `P_START_NO` INT             ,
  IN `P_PAGE_NO` INT             ,
	OUT `P_CPN_CNT` INT             ,
	OUT `P_RESULT_ID` INT             ,
	OUT `P_MESSAGE` TINYTEXT        
)
BEGIN
    DECLARE SQLSTRING   TEXT;
    DECLARE CNTSTRING   TEXT;
    DECLARE O_COUNT      INT;

    SET SQLSTRING = "";  
    SET CNTSTRING = "";
    SET O_COUNT = 0;
    
    SET P_RESULT_ID= 0;
    SET P_MESSAGE= "정상적으로 처리되었습니다.";

    IF  P_PROC_ID = 'GET_CPN_LIST' THEN  
      SET @EXEC_ST  = P_START_NO;
      SET @EXEC_CNT  = P_PAGE_NO;            
      SET @ROWNUM =P_START_NO;

      SELECT  COUNT(CPNY_NO)
        INTO  P_CPN_CNT
        FROM SN_COMPANY A;

      SELECT  IFNULL(CPNY_NO,'')                    CPNY_NO,
              IFNULL(CPNY_NM,'')                    CPNY_NM,
              IFNULL(CPNY_LOG_IMG_PATH,'')          CPNY_LOG_IMG_PATH,
              IFNULL(CPNY_ADDR,'')                  CPNY_ADDR,
              IFNULL(CEO_NM,'')                     CEO_NM,
              IFNULL(BZREG_NO,'')                   BZREG_NO,
              IFNULL(MSTR_TEL_NO,'')                MSTR_TEL_NO,
              IFNULL(MSTR_FAX_NO,'')                MSTR_FAX_NO,
              IFNULL(POST_NO,'')                    POST_NO,
              (SELECT COUNT(USR_ID) FROM SN_USR A WHERE A.CPNY_NO = B.CPNY_NO) AS CPN_USER_CNT
      FROM SN_COMPANY B;

    END IF;

END//
DELIMITER ;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
