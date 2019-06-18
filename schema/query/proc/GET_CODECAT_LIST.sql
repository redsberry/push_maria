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

-- 프로시저 REDSPUSH.GET_CODECAT_LIST 구조 내보내기
DELIMITER //
CREATE DEFINER=`redspush`@`%` PROCEDURE `GET_CODECAT_LIST`(
	IN `P_PROC_ID` VARCHAR(30)     ,
  IN `P_START_NO` INT             ,
  IN `P_LIMIT_NO` INT             ,
  IN `P_PAGING_YN` VARCHAR(1) ,
	OUT `P_CODECAT_CNT` INT             ,
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

    IF  P_PROC_ID = 'GET_CODECAT_LIST' THEN  
        SET @EXEC_ST  = P_START_NO;
        SET @EXEC_CNT  = P_LIMIT_NO;              
        SET @ROWNUM =P_START_NO;
    
        SET CNTSTRING = CONCAT(CNTSTRING, "SELECT COUNT(CD_CLS) \n");
        SET CNTSTRING = CONCAT(CNTSTRING, "INTO @P_CNT \n");
        SET CNTSTRING = CONCAT(CNTSTRING, "FROM SN_CODECAT \n");
        
        SET @EXEC_CNT_SQL = CNTSTRING;
        PREPARE STMT_CNT FROM  @EXEC_CNT_SQL;
        EXECUTE STMT_CNT;
        DEALLOCATE PREPARE STMT_CNT;
        SET P_CODECAT_CNT = @P_CNT;        
        
        SET SQLSTRING = CONCAT(SQLSTRING, "SELECT @ROWNUM := @ROWNUM+1 RM, \n");
        SET SQLSTRING = CONCAT(SQLSTRING, "       '/images/common/menu3.png' AS EDIT, \n");
        SET SQLSTRING = CONCAT(SQLSTRING, "       CD_CLS, \n");
        SET SQLSTRING = CONCAT(SQLSTRING, "       CD_CLS_NM, \n");
        SET SQLSTRING = CONCAT(SQLSTRING, "       USE_YN, \n");
        SET SQLSTRING = CONCAT(SQLSTRING, "       REMARK, \n");
        SET SQLSTRING = CONCAT(SQLSTRING, "       UPR_ID, \n");
        SET SQLSTRING = CONCAT(SQLSTRING, "       UPD_TS \n");
        SET SQLSTRING = CONCAT(SQLSTRING, "FROM SN_CODECAT  \n");
        SET SQLSTRING = CONCAT(SQLSTRING, "ORDER BY CD_CLS \n");
        
        IF P_PAGING_YN != 'Y' THEN
          SET SQLSTRING = CONCAT(SQLSTRING, "LIMIT ?, ? \n");
        END IF;

        SET @EXEC_SQL = SQLSTRING;
        PREPARE STMT FROM  @EXEC_SQL;
        IF P_PAGING_YN != 'Y' THEN
          EXECUTE STMT USING @EXEC_ST, @EXEC_CNT;
        ELSE
          EXECUTE STMT;
        END IF;
        DEALLOCATE PREPARE STMT;
        
    END IF;

 END//
DELIMITER ;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
