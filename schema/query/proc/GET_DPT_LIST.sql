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

-- 프로시저 REDSPUSH.GET_DPT_LIST 구조 내보내기
DELIMITER //
CREATE DEFINER=`redspush`@`%` PROCEDURE `GET_DPT_LIST`(
	IN `P_PROC_ID` VARCHAR(30)     ,
  IN `P_CPNY_NO` INT             ,
  IN `P_START_NO` INT             ,
  IN `P_PAGE_NO` INT             ,
	OUT `P_DPT_CNT` INT             ,
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

    IF  P_PROC_ID = 'GET_DPT_LIST' THEN  
      SET @EXEC_ST  = P_START_NO;
      SET @EXEC_CNT  = P_PAGE_NO;            
      SET @ROWNUM =P_START_NO;

      SELECT  COUNT(DPT_NO)
        INTO  P_DPT_CNT
        FROM SN_DPT A
       WHERE A.CPNY_NO = P_CPNY_NO;

      SELECT  IFNULL(DPT_NM,'')DPT_NM,
              IFNULL(DPT_TEL_NO,'')DPT_TEL_NO,
              IFNULL(DPT_FAX_NO,'')DPT_FAX_NO,
              IFNULL((SELECT USR_NM FROM SN_USR A WHERE A.CPNY_NO = P_CPNY_NO AND A.DPT_NO = B.DPT_NO AND A.DPT_MGR_YN = 'Y' AND A.JOIN_STE_CD = 'A'),' ') AS DPT_MGR_NM,
              IFNULL((SELECT USR_NCKNM FROM SN_USR A WHERE A.CPNY_NO = P_CPNY_NO AND A.DPT_NO = B.DPT_NO AND A.DPT_MGR_YN = 'Y' AND A.JOIN_STE_CD = 'A'),' ') AS DPT_MGR_NCKNM,
              (SELECT COUNT(USR_ID) FROM SN_USR A WHERE A.CPNY_NO = P_CPNY_NO AND A.DPT_NO = B.DPT_NO) AS DPT_USER_CNT,
              DPT_NO
      FROM SN_DPT B
      WHERE CPNY_NO = P_CPNY_NO;

    END IF;

END//
DELIMITER ;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
