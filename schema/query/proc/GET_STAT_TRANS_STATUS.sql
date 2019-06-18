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

-- 프로시저 REDSPUSH.GET_STAT_TRANS_STATUS 구조 내보내기
DELIMITER //
CREATE DEFINER=`redspush`@`%` PROCEDURE `GET_STAT_TRANS_STATUS`(
    IN `P_PROC_ID`    VARCHAR(30),
    IN `P_FROM_DT`    VARCHAR(8),
    IN `P_TO_DT`      VARCHAR(8),
    OUT P_RESULT_ID     INT,
    OUT P_MESSAGE       TINYTEXT
)
    COMMENT '[oslee] 일별/주별/월별/년도별로 발송상태 통계 조회'
BEGIN

    DECLARE SQLSTRING   TEXT;
    DECLARE CNTSTRING   TEXT;
    DECLARE O_COUNT      INT;
        
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
      BEGIN
        SET P_RESULT_ID	= -1;
        SET P_MESSAGE	= "조회중 오류가 발생하였습니다.";
    END;    
    
    SET SQLSTRING = "";  
    SET CNTSTRING = "";
    SET O_COUNT = 0;
    
    SET P_RESULT_ID= 0;
    SET P_MESSAGE= "정상적으로 처리되었습니다.";
    
    SET @EXEC_FROM = P_FROM_DT;
    SET @EXEC_TO = P_TO_DT;

    IF  P_PROC_ID != 'STAT_STATUS_WEEK' THEN

      SET SQLSTRING = CONCAT(SQLSTRING, "SELECT (CASE GB WHEN 'B' THEN '계' ELSE C.DATE END) AS '날짜', \n");
      SET SQLSTRING = CONCAT(SQLSTRING, "        COALESCE(SUM(C.TOT), 0) AS '계', \n");
      SET SQLSTRING = CONCAT(SQLSTRING, "        COALESCE(SUM(C.COMPLETE), 0) AS '발송', \n");
      SET SQLSTRING = CONCAT(SQLSTRING, "        COALESCE(SUM(C.WAIT), 0) AS '미발송' \n");
      SET SQLSTRING = CONCAT(SQLSTRING, "FROM (   \n");
      SET SQLSTRING = CONCAT(SQLSTRING, "  SELECT DATE,  \n");
      SET SQLSTRING = CONCAT(SQLSTRING, "         (A.COMPLETE +A.WAIT) AS TOT, \n");
      SET SQLSTRING = CONCAT(SQLSTRING, "         A.COMPLETE,A.WAIT \n");
      SET SQLSTRING = CONCAT(SQLSTRING, "  FROM( \n");
      
      IF  P_PROC_ID = 'STAT_STATUS_YEAR' THEN
        SET SQLSTRING = CONCAT(SQLSTRING, "  SELECT DATE_FORMAT(TRNS_REQ_TS,'%Y') AS DATE,  \n");
      ELSEIF  P_PROC_ID = 'STAT_STATUS_MONTH' THEN
        SET SQLSTRING = CONCAT(SQLSTRING, "  SELECT DATE_FORMAT(TRNS_REQ_TS,'%Y-%m') AS DATE,  \n");
      ELSEIF  P_PROC_ID = 'STAT_STATUS_DAY' THEN
        SET SQLSTRING = CONCAT(SQLSTRING, "  SELECT DATE_FORMAT(TRNS_REQ_TS,'%Y-%m-%d') AS DATE,  \n");
      END IF;
      
      SET SQLSTRING = CONCAT(SQLSTRING, "           SUM(CASE WHEN IFNULL(TRNS_CMPT_YN, '') = 'Y' THEN 1 ELSE 0 END) AS COMPLETE, \n");
      SET SQLSTRING = CONCAT(SQLSTRING, "           SUM(CASE WHEN IFNULL(TRNS_CMPT_YN, '') = 'N' THEN 1 ELSE 0 END) AS WAIT \n");
      SET SQLSTRING = CONCAT(SQLSTRING, "    FROM PM_MSGPLAN  \n");
      SET SQLSTRING = CONCAT(SQLSTRING, "    WHERE DATE_FORMAT(TRNS_REQ_TS,'%Y%m%d') BETWEEN @EXEC_FROM AND @EXEC_TO \n");
      
      IF  P_PROC_ID = 'STAT_STATUS_YEAR' THEN
        SET SQLSTRING = CONCAT(SQLSTRING, "  GROUP BY DATE_FORMAT(TRNS_REQ_TS,'%Y')  \n");
      ELSEIF  P_PROC_ID = 'STAT_STATUS_MONTH' THEN
        SET SQLSTRING = CONCAT(SQLSTRING, "  GROUP BY  DATE_FORMAT(TRNS_REQ_TS,'%Y-%m')  \n");
      ELSEIF  P_PROC_ID = 'STAT_STATUS_DAY' THEN
        SET SQLSTRING = CONCAT(SQLSTRING, "  GROUP BY DATE_FORMAT(TRNS_REQ_TS,'%Y-%m-%d') \n");        
      END IF;
      
      SET SQLSTRING = CONCAT(SQLSTRING, "  ) A  \n");
      SET SQLSTRING = CONCAT(SQLSTRING, ") C, \n");
      SET SQLSTRING = CONCAT(SQLSTRING, "  (SELECT 'A' GB FROM DUAL \n");
      SET SQLSTRING = CONCAT(SQLSTRING, "    UNION ALL SELECT 'B' GB FROM DUAL ) B \n");
      SET SQLSTRING = CONCAT(SQLSTRING, "    GROUP BY (CASE B.GB WHEN 'A' THEN C.DATE END) \n");

  		SET @EXEC_SQL 	= SQLSTRING;
  		PREPARE STMT FROM  @EXEC_SQL;		
      EXECUTE STMT;
  		DEALLOCATE PREPARE STMT;

    ELSE
      -- 주별통계
      SET SQLSTRING = CONCAT(SQLSTRING, "SELECT (CASE GB WHEN 'B' THEN '계' ELSE C.START END) AS '시작일시', \n"); 
      SET SQLSTRING = CONCAT(SQLSTRING, "        (CASE GB WHEN 'B' THEN '계' ELSE C.END END) AS '종료일시', \n"); 
      SET SQLSTRING = CONCAT(SQLSTRING, "        COALESCE(SUM(C.TOT), 0) AS '계', \n");
      SET SQLSTRING = CONCAT(SQLSTRING, "        COALESCE(SUM(C.COMPLETE), 0) AS '발송', \n");
      SET SQLSTRING = CONCAT(SQLSTRING, "        COALESCE(SUM(C.WAIT), 0) AS '미발송' \n");
      SET SQLSTRING = CONCAT(SQLSTRING, "FROM (   \n"); 
      SET SQLSTRING = CONCAT(SQLSTRING, "  SELECT START, \n");  
      SET SQLSTRING = CONCAT(SQLSTRING, "         END,  \n"); 
      SET SQLSTRING = CONCAT(SQLSTRING, "         (A.COMPLETE +A.WAIT) AS TOT, \n");
      SET SQLSTRING = CONCAT(SQLSTRING, "         A.COMPLETE,A.WAIT \n");
      SET SQLSTRING = CONCAT(SQLSTRING, "  FROM( \n"); 
      SET SQLSTRING = CONCAT(SQLSTRING, "  SELECT DATE_FORMAT(DATE_SUB(TRNS_REQ_TS, INTERVAL (DAYOFWEEK(TRNS_REQ_TS)-1) DAY), '%Y-%m-%d') AS START,  \n"); 
      SET SQLSTRING = CONCAT(SQLSTRING, "         DATE_FORMAT(DATE_SUB(TRNS_REQ_TS, INTERVAL (DAYOFWEEK(TRNS_REQ_TS)-7) DAY), '%Y-%m-%d') AS END,  \n"); 
      SET SQLSTRING = CONCAT(SQLSTRING, "         DATE_FORMAT(TRNS_REQ_TS, '%Y%U') AS TT, \n"); 
      SET SQLSTRING = CONCAT(SQLSTRING, "         SUM(CASE WHEN IFNULL(TRNS_CMPT_YN, '') = 'Y' THEN 1 ELSE 0 END) AS COMPLETE, \n");
      SET SQLSTRING = CONCAT(SQLSTRING, "         SUM(CASE WHEN IFNULL(TRNS_CMPT_YN, '') = 'N' THEN 1 ELSE 0 END) AS WAIT \n");
      SET SQLSTRING = CONCAT(SQLSTRING, "  FROM PM_MSGPLAN  \n"); 
      SET SQLSTRING = CONCAT(SQLSTRING, "  WHERE DATE_FORMAT(TRNS_REQ_TS,'%Y%m%d') BETWEEN @EXEC_FROM AND @EXEC_TO \n");
--       SET SQLSTRING = CONCAT(SQLSTRING, "    AND TRNS_CMPT_YN = 'Y' \n"); 
      SET SQLSTRING = CONCAT(SQLSTRING, "  GROUP BY TT \n"); 
      SET SQLSTRING = CONCAT(SQLSTRING, "  ) A        \n"); 
      SET SQLSTRING = CONCAT(SQLSTRING, ") C, \n"); 
      SET SQLSTRING = CONCAT(SQLSTRING, "  (SELECT 'A' GB FROM DUAL \n"); 
      SET SQLSTRING = CONCAT(SQLSTRING, "    UNION ALL SELECT 'B' GB FROM DUAL ) B \n"); 
      SET SQLSTRING = CONCAT(SQLSTRING, "    GROUP BY (CASE B.GB WHEN 'A' THEN C.START END)  \n");       
      
  		SET @EXEC_SQL 	= SQLSTRING;
  		PREPARE STMT FROM  @EXEC_SQL;		
      EXECUTE STMT;
  		DEALLOCATE PREPARE STM;     
  
    END IF;
    
 END//
DELIMITER ;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
