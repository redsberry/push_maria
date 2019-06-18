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

-- 프로시저 REDSPUSH.GET_STAT_LOGIN 구조 내보내기
DELIMITER //
CREATE DEFINER=`redspush`@`%` PROCEDURE `GET_STAT_LOGIN`(
	IN `P_PROC_ID` VARCHAR(30),
  IN `P_TYPE` VARCHAR(1),
  IN `P_FROM_DT` VARCHAR(20),
  IN `P_TO_DT` VARCHAR(20),
  OUT `P_LIST_CNT` INTEGER,
	OUT `P_RESULT_ID` INTEGER,
	OUT `P_MESSAGE` VARCHAR(500)
)
    COMMENT '[oslee97] 로그인 이력 통계.'
BEGIN

    DECLARE SQLSTRING   TEXT;
    DECLARE CNTSTRING   TEXT;
    
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
      BEGIN
        SET P_RESULT_ID	= -1;
        SET P_MESSAGE	= "조회중 오류가 발생하였습니다.";
    END;    
        
    SET SQLSTRING = "";  
    SET CNTSTRING = "";
        
    SET P_RESULT_ID= 0;
    SET P_MESSAGE= "정상적으로 처리되었습니다.";

		SET @EXEC_FROM  = P_FROM_DT;
		SET @EXEC_TO  = P_TO_DT;            
    
    IF P_PROC_ID = 'STAT_DAY' THEN
                
  		IF P_TYPE = 'A' THEN
        SET SQLSTRING = CONCAT(SQLSTRING, "		SELECT SUBSTRING(DATE_FORMAT(LOGIN_DATE, '%Y-%m-%d'), 1, 10) AS LOG_DT, COUNT(1) AS COUNT \n");
  		ELSEIF P_TYPE = 'B' THEN
        SET SQLSTRING = CONCAT(SQLSTRING, "		SELECT SUBSTRING(DATE_FORMAT(LOGIN_DATE, '%Y-%m'), 1, 10) AS LOG_DT, COUNT(1) AS COUNT \n");
  		ELSEIF P_TYPE = 'C' THEN
        SET SQLSTRING = CONCAT(SQLSTRING, "		SELECT SUBSTRING(DATE_FORMAT(LOGIN_DATE, '%Y'), 1, 10) AS LOG_DT, COUNT(1) AS COUNT \n");
      ELSE
        SET SQLSTRING = CONCAT(SQLSTRING, "		SELECT SUBSTRING(DATE_FORMAT(LOGIN_DATE, '%Y-%m-%d'), 1, 10) AS LOG_DT, COUNT(1) AS COUNT \n");      
  		END IF;
    
      SET SQLSTRING = CONCAT(SQLSTRING, "		  FROM SN_LOGIN \n");
      SET SQLSTRING = CONCAT(SQLSTRING, "		  WHERE DATE_FORMAT(LOGIN_DATE, '%Y%m%d') BETWEEN ? AND ? \n");
            
  		IF P_TYPE = 'A' THEN
        SET SQLSTRING = CONCAT(SQLSTRING, "		  GROUP BY SUBSTRING(DATE_FORMAT(LOGIN_DATE, '%Y-%m-%d'), 1, 10) \n");
  		ELSEIF P_TYPE = 'B' THEN
        SET SQLSTRING = CONCAT(SQLSTRING, "		  GROUP BY SUBSTRING(DATE_FORMAT(LOGIN_DATE, '%Y-%m'), 1, 10) \n");
  		ELSEIF P_TYPE = 'C' THEN
        SET SQLSTRING = CONCAT(SQLSTRING, "		  GROUP BY SUBSTRING(DATE_FORMAT(LOGIN_DATE, '%Y'), 1, 10) \n");
      ELSE
        SET SQLSTRING = CONCAT(SQLSTRING, "		  GROUP BY SUBSTRING(DATE_FORMAT(LOGIN_DATE, '%Y-%m-%d'), 1, 10) \n");
  		END IF;
      
      SET SQLSTRING = CONCAT(SQLSTRING, "		  ORDER BY LOGIN_DATE ASC \n");

  		SET @EXEC_SQL 	= SQLSTRING;
  		PREPARE STMT FROM  @EXEC_SQL;		
      EXECUTE STMT USING @EXEC_FROM, @EXEC_TO;
  		DEALLOCATE PREPARE STMT;
    
    ELSE
    
  		IF P_TYPE = 'A' THEN
        SET SQLSTRING = CONCAT(SQLSTRING, "		SELECT SUBSTRING(DATE_FORMAT(LOGIN_DATE, '%Y-%m-%d'), 1, 10) AS LOG_DT, LOGIN_ID, LOGIN_NM, LOGIN_DPT_NM, COUNT(1) AS COUNT \n");
  		ELSEIF P_TYPE = 'B' THEN
        SET SQLSTRING = CONCAT(SQLSTRING, "		SELECT SUBSTRING(DATE_FORMAT(LOGIN_DATE, '%Y-%m'), 1, 10) AS LOG_DT, LOGIN_ID, LOGIN_NM, LOGIN_DPT_NM, COUNT(1) AS COUNT \n");
  		ELSEIF P_TYPE = 'C' THEN
        SET SQLSTRING = CONCAT(SQLSTRING, "		SELECT SUBSTRING(DATE_FORMAT(LOGIN_DATE, '%Y'), 1, 10) AS LOG_DT,LOGIN_ID, LOGIN_NM, LOGIN_DPT_NM,  COUNT(1) AS COUNT \n");
      ELSE
        SET SQLSTRING = CONCAT(SQLSTRING, "		SELECT SUBSTRING(DATE_FORMAT(LOGIN_DATE, '%Y-%m-%d'), 1, 10) AS LOG_DT, LOGIN_ID, LOGIN_NM, LOGIN_DPT_NM, COUNT(1) AS COUNT \n");      
  		END IF;    
      
      SET SQLSTRING = CONCAT(SQLSTRING, "		  FROM SN_LOGIN \n");
      SET SQLSTRING = CONCAT(SQLSTRING, "		  WHERE DATE_FORMAT(LOGIN_DATE, '%Y%m%d') BETWEEN ? AND ? \n");
  		IF P_TYPE = 'A' THEN
        SET SQLSTRING = CONCAT(SQLSTRING, "		  GROUP BY SUBSTRING(DATE_FORMAT(LOGIN_DATE, '%Y-%m-%d'), 1, 10) \n");
  		ELSEIF P_TYPE = 'B' THEN
        SET SQLSTRING = CONCAT(SQLSTRING, "		  GROUP BY SUBSTRING(DATE_FORMAT(LOGIN_DATE, '%Y-%m'), 1, 10) \n");
  		ELSEIF P_TYPE = 'C' THEN
        SET SQLSTRING = CONCAT(SQLSTRING, "		  GROUP BY SUBSTRING(DATE_FORMAT(LOGIN_DATE, '%Y'), 1, 10) \n");
      ELSE
        SET SQLSTRING = CONCAT(SQLSTRING, "		  GROUP BY SUBSTRING(DATE_FORMAT(LOGIN_DATE, '%Y-%m-%d'), 1, 10) \n");
  		END IF;
      SET SQLSTRING = CONCAT(SQLSTRING, "		  ORDER BY LOGIN_DATE ASC \n");      

  		SET @EXEC_SQL 	= SQLSTRING;
  		PREPARE STMT FROM  @EXEC_SQL;		
      EXECUTE STMT USING @EXEC_FROM, @EXEC_TO;
  		DEALLOCATE PREPARE STMT;
      
    END IF;    
 END//
DELIMITER ;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
