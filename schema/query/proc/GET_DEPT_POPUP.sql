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

-- 프로시저 REDSPUSH.GET_DEPT_POPUP 구조 내보내기
DELIMITER //
CREATE DEFINER=`redspush`@`%` PROCEDURE `GET_DEPT_POPUP`(
  IN `P_PROC_ID` VARCHAR(30)     ,
  IN `P_DEPT_NM` VARCHAR(50)     ,
  IN `P_DEPT_CD` VARCHAR(50)     ,
  IN `P_START_NO` INT            ,
  IN `P_PAGE_NO` INT             ,  
  OUT `P_DEPT_CNT` INT             ,
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

    IF  P_PROC_ID = 'GET_DEPT_LIST' THEN       

        SET @EXEC_ST  = P_START_NO;
        SET @EXEC_CNT  = P_PAGE_NO;            
        SET @ROWNUM =P_START_NO;
        
        SET CNTSTRING = CONCAT(CNTSTRING, "SELECT COUNT(DPT_CD) \n");      
        SET CNTSTRING = CONCAT(CNTSTRING, "  INTO    @P_CNT \n");     
        SET CNTSTRING = CONCAT(CNTSTRING, "  FROM SN_DPT \n");     
        SET CNTSTRING = CONCAT(CNTSTRING, "  WHERE USE_YN = 'Y' \n");
        IF P_DEPT_CD != '' THEN        
          SET @EXEC_KEYWORD  = P_DEPT_CD;
          SET CNTSTRING = CONCAT(CNTSTRING, "AND  UP_DPT_CD =  @EXEC_KEYWORD  \n");        
        END IF;
                
        IF P_DEPT_NM != '' THEN
            SET @EXEC_KEYWORD  = P_DEPT_NM;
            SET CNTSTRING = CONCAT(CNTSTRING, "AND   DPT_ALL_NM LIKE CONCAT('%', @EXEC_KEYWORD , '%') \n");
        END IF;

        SET @EXEC_CNT_SQL   = CNTSTRING;
        PREPARE STMT_CNT FROM  @EXEC_CNT_SQL; 
        EXECUTE STMT_CNT;
        DEALLOCATE PREPARE STMT_CNT;
        SET P_DEPT_CNT = @P_CNT;
        
        SET SQLSTRING = CONCAT(SQLSTRING, "  SELECT @ROWNUM := @ROWNUM+1 RM, \n");
        SET SQLSTRING = CONCAT(SQLSTRING, "         A.DPT_CD, \n");
        SET SQLSTRING = CONCAT(SQLSTRING, "  			 A.DPT_NM, \n");
        SET SQLSTRING = CONCAT(SQLSTRING, "  			 A.DPT_ALL_NM, \n");
        SET SQLSTRING = CONCAT(SQLSTRING, "  			 A.DPT_ORDER, \n");
        SET SQLSTRING = CONCAT(SQLSTRING, "  			 A.PANS_DIRBL_TYPE, \n");
        SET SQLSTRING = CONCAT(SQLSTRING, "  			 A.UP_DPT_CD, \n");
        SET SQLSTRING = CONCAT(SQLSTRING, "  			 A.BLG_PA_CD, \n");
        SET SQLSTRING = CONCAT(SQLSTRING, "  			 A.BLG_PS_CD \n");        
        SET SQLSTRING = CONCAT(SQLSTRING, "  FROM ( \n");
        SET SQLSTRING = CONCAT(SQLSTRING, "  	SELECT DPT_CD, \n");
        SET SQLSTRING = CONCAT(SQLSTRING, "  	       DPT_NM, \n");
        SET SQLSTRING = CONCAT(SQLSTRING, "  	       DPT_ALL_NM, \n");
        SET SQLSTRING = CONCAT(SQLSTRING, "  	       DPT_ORDER, \n");
        SET SQLSTRING = CONCAT(SQLSTRING, "  	       PANS_DIRBL_TYPE, \n");
        SET SQLSTRING = CONCAT(SQLSTRING, "  	       UP_DPT_CD, \n");
        SET SQLSTRING = CONCAT(SQLSTRING, "  	       BLG_PA_CD, \n");
        SET SQLSTRING = CONCAT(SQLSTRING, "  	       BLG_PS_CD \n");
        SET SQLSTRING = CONCAT(SQLSTRING, "  	  FROM SN_DPT \n");
        SET SQLSTRING = CONCAT(SQLSTRING, "     WHERE USE_YN = 'Y' \n");
        IF P_DEPT_CD != '' THEN                
          SET @EXEC_KEYWORD  = P_DEPT_CD;
          SET SQLSTRING = CONCAT(SQLSTRING, "AND  UP_DPT_CD =  @EXEC_KEYWORD  \n");
        END IF;
            
        IF P_DEPT_NM != '' THEN
            SET @EXEC_KEYWORD  = P_DEPT_NM;
            SET SQLSTRING = CONCAT(SQLSTRING, "AND   DPT_ALL_NM LIKE CONCAT('%', @EXEC_KEYWORD , '%') \n");
        END IF;

        SET SQLSTRING = CONCAT(SQLSTRING, "   ORDER BY DPT_ORDER ASC \n");
        SET SQLSTRING = CONCAT(SQLSTRING, "   LIMIT  ?, ?  \n");
        SET SQLSTRING = CONCAT(SQLSTRING, "  ) A  \n");
                
        SET @EXEC_SQL   = SQLSTRING;
        PREPARE STMT FROM  @EXEC_SQL;   
        EXECUTE STMT USING @EXEC_ST, @EXEC_CNT;
        DEALLOCATE PREPARE STMT;

    END IF;
    
 END//
DELIMITER ;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
