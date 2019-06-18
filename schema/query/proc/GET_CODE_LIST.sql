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

-- 프로시저 REDSPUSH.GET_CODE_LIST 구조 내보내기
DELIMITER //
CREATE DEFINER=`redspush`@`%` PROCEDURE `GET_CODE_LIST`(
  IN `P_PROC_ID` VARCHAR(30)     ,
  IN `P_CD_CLS` VARCHAR(3)     ,
  IN `P_CMN_CD` VARCHAR(15)     ,
  IN `P_CMN_NM` VARCHAR(100)     ,
  IN `P_START_NO` INT            ,
  IN `P_PAGE_NO` INT             ,  
  IN `P_PAGING_YN` VARCHAR(1) ,
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

    IF  P_PROC_ID = 'GET_CODE_LIST' THEN       

        SET @EXEC_ST  = P_START_NO;
        SET @EXEC_CNT  = P_PAGE_NO;            
        SET @ROWNUM = P_START_NO;
        
        SET CNTSTRING = CONCAT(CNTSTRING, "SELECT COUNT(CMN_CD) \n");      
        SET CNTSTRING = CONCAT(CNTSTRING, "  INTO    @P_CNT \n");     
        SET CNTSTRING = CONCAT(CNTSTRING, "  FROM SN_CODE \n");     
        SET CNTSTRING = CONCAT(CNTSTRING, "  WHERE USE_YN = 'Y' \n");
                
        IF P_CD_CLS != '' THEN
            SET @EXEC_CD_CLS  = P_CD_CLS;
            SET CNTSTRING = CONCAT(CNTSTRING, "AND   CD_CLS = @EXEC_CD_CLS \n");
        END IF;

        IF P_CMN_CD != '' THEN
            SET @EXEC_CMN_CD  = P_CMN_CD;
            SET CNTSTRING = CONCAT(CNTSTRING, "AND   CMN_CD = @EXEC_CMN_CD \n");
        END IF;

        IF P_CMN_NM != '' THEN
            SET @EXEC_CMN_NM  = P_CMN_NM;
            SET CNTSTRING = CONCAT(CNTSTRING, "AND   CMN_CD_NM LIKE CONCAT('%', @EXEC_CMN_NM, '%') \n");
        END IF;
        
        SET @EXEC_CNT_SQL   = CNTSTRING;
        PREPARE STMT_CNT FROM  @EXEC_CNT_SQL; 
        EXECUTE STMT_CNT;
        DEALLOCATE PREPARE STMT_CNT;
        SET P_CODE_CNT = @P_CNT;
        
        SET SQLSTRING = CONCAT(SQLSTRING, "  SELECT @ROWNUM := @ROWNUM+1 RM, \n");
        SET SQLSTRING = CONCAT(SQLSTRING, "  '/images/common/menu3.png' AS EDIT, \n");
        SET SQLSTRING = CONCAT(SQLSTRING, "  		 A.CD_CLS, \n");
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
        SET SQLSTRING = CONCAT(SQLSTRING, "  	SELECT CD_CLS, \n");
        SET SQLSTRING = CONCAT(SQLSTRING, "  	'/images/common/menu3.png' AS EDIT, \n");
        SET SQLSTRING = CONCAT(SQLSTRING, "  	       CMN_CD, \n");
        SET SQLSTRING = CONCAT(SQLSTRING, "  	       CMN_CD_NM, \n");
        SET SQLSTRING = CONCAT(SQLSTRING, "  		     CMN_CD_ABB, \n");
        SET SQLSTRING = CONCAT(SQLSTRING, "  		     CMN_CD_ANO, \n");
        SET SQLSTRING = CONCAT(SQLSTRING, "  		     CMN_REL_CD, \n");        
        SET SQLSTRING = CONCAT(SQLSTRING, "  	       USE_YN, \n");
        SET SQLSTRING = CONCAT(SQLSTRING, "  	       SYS_YN, \n");
        SET SQLSTRING = CONCAT(SQLSTRING, "  	       REMARK, \n");
        SET SQLSTRING = CONCAT(SQLSTRING, "  	       UPR_ID, \n");
        SET SQLSTRING = CONCAT(SQLSTRING, "  	       UPD_TS \n");
        SET SQLSTRING = CONCAT(SQLSTRING, "  	  FROM SN_CODE \n");
        SET SQLSTRING = CONCAT(SQLSTRING, "     WHERE USE_YN = 'Y' \n");

        IF P_CD_CLS != '' THEN
            SET @EXEC_CD_CLS  = P_CD_CLS;
            SET SQLSTRING = CONCAT(SQLSTRING, "AND   CD_CLS = @EXEC_CD_CLS \n");
        END IF;

        IF P_CMN_CD != '' THEN
            SET @EXEC_CMN_CD  = P_CMN_CD;
            SET SQLSTRING = CONCAT(SQLSTRING, "AND   CMN_CD = @EXEC_CMN_CD \n");
        END IF;

        IF P_CMN_NM != '' THEN
            SET @EXEC_CMN_NM  = P_CMN_NM;
            SET SQLSTRING = CONCAT(SQLSTRING, "AND   CMN_CD_NM LIKE CONCAT('%', @EXEC_CMN_NM, '%') \n");
        END IF;

        SET SQLSTRING = CONCAT(SQLSTRING, "   ORDER BY CMN_CD_NM ASC \n");
        IF P_PAGING_YN != 'Y' THEN
          SET SQLSTRING = CONCAT(SQLSTRING, "   LIMIT  ?, ?  \n");
        END IF;
        
        SET SQLSTRING = CONCAT(SQLSTRING, "  ) A  \n");
                
        SET @EXEC_SQL   = SQLSTRING;
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
