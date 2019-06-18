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

-- 프로시저 REDSPUSH.GET_CODE_POPUP_LIST 구조 내보내기
DELIMITER //
CREATE DEFINER=`redspush`@`%` PROCEDURE `GET_CODE_POPUP_LIST`(
  IN `P_PROC_ID` VARCHAR(30)     ,
  IN `P_CMN_CD_NM` VARCHAR(200)     ,
  IN `P_START_NO` INT            ,
  IN `P_PAGE_NO` INT             ,  
  OUT `P_CODE_CNT` INT             ,
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

    IF  P_PROC_ID = 'GET_CODE_POPUP_LIST' THEN       

        SET @EXEC_ST  = P_START_NO;
        SET @EXEC_CNT  = P_PAGE_NO;            
        SET @ROWNUM = P_START_NO;
        
        SET CNTSTRING = CONCAT(CNTSTRING, "SELECT COUNT(CMN_CD) \n");      
        SET CNTSTRING = CONCAT(CNTSTRING, "  INTO    @P_CNT \n");     
        SET CNTSTRING = CONCAT(CNTSTRING, "  FROM SN_CODE \n");     
        SET CNTSTRING = CONCAT(CNTSTRING, "  WHERE USE_YN = 'Y' \n");
                
        IF P_CMN_CD_NM != '' THEN
            SET @EXEC_KEYWORD  = P_CMN_CD_NM;
            SET CNTSTRING = CONCAT(CNTSTRING, "AND   CMN_CD_NM LIKE CONCAT('%', @EXEC_KEYWORD , '%') \n");
        END IF;

        SET @EXEC_CNT_SQL   = CNTSTRING;
        PREPARE STMT_CNT FROM  @EXEC_CNT_SQL; 
        EXECUTE STMT_CNT;
        DEALLOCATE PREPARE STMT_CNT;
        SET P_CODE_CNT = @P_CNT;
        
        SET SQLSTRING = CONCAT(SQLSTRING, "  SELECT @ROWNUM := @ROWNUM+1 RM, \n");
        SET SQLSTRING = CONCAT(SQLSTRING, "  		 (SELECT C.CD_CLS FROM SN_CODECAT C WHERE C.CD_CLS = A.CD_CLS) AS CD_CLS, \n");
        SET SQLSTRING = CONCAT(SQLSTRING, "  		 (SELECT C.CD_CLS_NM FROM SN_CODECAT C WHERE C.CD_CLS = A.CD_CLS) AS CD_CLS_NM, \n");
        SET SQLSTRING = CONCAT(SQLSTRING, "  		 A.CMN_CD, \n");
        SET SQLSTRING = CONCAT(SQLSTRING, "  		 A.CMN_CD_NM, \n");
        SET SQLSTRING = CONCAT(SQLSTRING, "  		 A.CMN_CD_ABB, \n");
        SET SQLSTRING = CONCAT(SQLSTRING, "  		 A.CMN_CD_ANO, \n");
        SET SQLSTRING = CONCAT(SQLSTRING, "  		 A.CMN_REL_CD, \n");        
        SET SQLSTRING = CONCAT(SQLSTRING, "  		 A.USE_YN, \n");
        SET SQLSTRING = CONCAT(SQLSTRING, "  		 A.SYS_YN, \n");
        SET SQLSTRING = CONCAT(SQLSTRING, "  		 A.REMARK, \n");
        SET SQLSTRING = CONCAT(SQLSTRING, "  		 A.UPR_ID, \n");
        SET SQLSTRING = CONCAT(SQLSTRING, "  		 A.UPD_TS \n");        
        SET SQLSTRING = CONCAT(SQLSTRING, "  FROM ( \n");
        SET SQLSTRING = CONCAT(SQLSTRING, "  	SELECT B.CD_CLS, \n");
        SET SQLSTRING = CONCAT(SQLSTRING, "  		     (SELECT C.CD_CLS_NM FROM SN_CODECAT C WHERE C.CD_CLS = B.CD_CLS) AS CD_CLS_NM, \n");
        SET SQLSTRING = CONCAT(SQLSTRING, "  	       B.CMN_CD, \n");
        SET SQLSTRING = CONCAT(SQLSTRING, "  	       B.CMN_CD_NM, \n");
        SET SQLSTRING = CONCAT(SQLSTRING, "  		     B.CMN_CD_ABB, \n");
        SET SQLSTRING = CONCAT(SQLSTRING, "  		     B.CMN_CD_ANO, \n");
        SET SQLSTRING = CONCAT(SQLSTRING, "  		     B.CMN_REL_CD, \n");         
        SET SQLSTRING = CONCAT(SQLSTRING, "  	       B.USE_YN, \n");
        SET SQLSTRING = CONCAT(SQLSTRING, "  	       B.SYS_YN, \n");
        SET SQLSTRING = CONCAT(SQLSTRING, "  	       B.REMARK, \n");
        SET SQLSTRING = CONCAT(SQLSTRING, "  	       B.UPR_ID, \n");
        SET SQLSTRING = CONCAT(SQLSTRING, "  	       B.UPD_TS \n");
        SET SQLSTRING = CONCAT(SQLSTRING, "  	  FROM SN_CODE B \n");
        SET SQLSTRING = CONCAT(SQLSTRING, "     WHERE USE_YN = 'Y' \n");

        IF P_CMN_CD_NM != '' THEN
            SET @EXEC_KEYWORD  = P_CMN_CD_NM;
            SET SQLSTRING = CONCAT(SQLSTRING, "AND   CMN_CD_NM LIKE CONCAT('%', @EXEC_KEYWORD , '%') \n");
        END IF;

        SET SQLSTRING = CONCAT(SQLSTRING, "   ORDER BY CMN_CD_NM ASC \n");
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
