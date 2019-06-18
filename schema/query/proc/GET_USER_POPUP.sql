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

-- 프로시저 REDSPUSH.GET_USER_POPUP 구조 내보내기
DELIMITER //
CREATE DEFINER=`redspush`@`%` PROCEDURE `GET_USER_POPUP`(
  IN `P_PROC_ID` VARCHAR(30)     ,
  IN `P_USER_NM` VARCHAR(50)     ,
  IN `P_START_NO` INT            ,
  IN `P_PAGE_NO` INT             ,  
  OUT `P_USER_CNT` INT             ,
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

    IF  P_PROC_ID = 'GET_USER_LIST' THEN       

        SET @EXEC_ST  = P_START_NO;
        SET @EXEC_CNT  = P_PAGE_NO;            
        SET @ROWNUM = P_START_NO;
        
        SET CNTSTRING = CONCAT(CNTSTRING, "SELECT COUNT(USER_ID) \n");      
        SET CNTSTRING = CONCAT(CNTSTRING, "  INTO    @P_CNT \n");     
        SET CNTSTRING = CONCAT(CNTSTRING, "  FROM SN_USER \n");     
        SET CNTSTRING = CONCAT(CNTSTRING, "  WHERE 1=1 \n");
        
                
        IF P_USER_NM != '' THEN
            SET @EXEC_KEYWORD  = P_USER_NM;
            SET CNTSTRING = CONCAT(CNTSTRING, "AND   USER_NM LIKE CONCAT('%', @EXEC_KEYWORD , '%') \n");
        END IF;

        SET @EXEC_CNT_SQL   = CNTSTRING;
        PREPARE STMT_CNT FROM  @EXEC_CNT_SQL; 
        EXECUTE STMT_CNT;
        DEALLOCATE PREPARE STMT_CNT;
        SET P_USER_CNT = @P_CNT;
        
        SET SQLSTRING = CONCAT(SQLSTRING, "  SELECT @ROWNUM := @ROWNUM+1 RM, \n");
        SET SQLSTRING = CONCAT(SQLSTRING, "          A.USER_ID, \n");
        SET SQLSTRING = CONCAT(SQLSTRING, "  		 A.USER_NO, \n");
        SET SQLSTRING = CONCAT(SQLSTRING, "  		 A.USER_NM, \n");
        SET SQLSTRING = CONCAT(SQLSTRING, "  		 A.USER_BIRDT, \n");
        SET SQLSTRING = CONCAT(SQLSTRING, "  		 A.USER_SEX, \n");
        SET SQLSTRING = CONCAT(SQLSTRING, "  		 A.DPT_CD, \n");
        SET SQLSTRING = CONCAT(SQLSTRING, "  		 A.DPT_CD_NM, \n");
        SET SQLSTRING = CONCAT(SQLSTRING, "  		 A.ROL_CD, \n");
        SET SQLSTRING = CONCAT(SQLSTRING, "  		 A.ROL_CD_NM, \n");
        SET SQLSTRING = CONCAT(SQLSTRING, "  		 A.POS_CD, \n");
        SET SQLSTRING = CONCAT(SQLSTRING, "  		 A.POS_CD_NM, \n");
        SET SQLSTRING = CONCAT(SQLSTRING, "  		 A.CHARGE_TSK, \n");
        SET SQLSTRING = CONCAT(SQLSTRING, "  		 A.TEL_NO, \n");
        SET SQLSTRING = CONCAT(SQLSTRING, "  		 A.CELL_NO, \n");
        SET SQLSTRING = CONCAT(SQLSTRING, "  		 A.STE_CD, \n");
        SET SQLSTRING = CONCAT(SQLSTRING, "  		 A.ID_IMG_PATH, \n");
        SET SQLSTRING = CONCAT(SQLSTRING, "  		 A.USE_YN, \n");
        SET SQLSTRING = CONCAT(SQLSTRING, "  		 A.APVL_YN, \n");
        SET SQLSTRING = CONCAT(SQLSTRING, "  		 A.SYS_YN, \n");
        SET SQLSTRING = CONCAT(SQLSTRING, "  		 A.REG_TS, \n");
        SET SQLSTRING = CONCAT(SQLSTRING, "  		 A.UPD_TS \n");        
        SET SQLSTRING = CONCAT(SQLSTRING, "  FROM ( \n");
        SET SQLSTRING = CONCAT(SQLSTRING, "  	SELECT B.USER_ID, \n");
        SET SQLSTRING = CONCAT(SQLSTRING, "  	       B.USER_NO, \n");
        SET SQLSTRING = CONCAT(SQLSTRING, "  	       B.USER_NM, \n");
        SET SQLSTRING = CONCAT(SQLSTRING, "  	       B.USER_BIRDT, \n");
        SET SQLSTRING = CONCAT(SQLSTRING, "  	       B.USER_SEX, \n");
        SET SQLSTRING = CONCAT(SQLSTRING, "  	       B.DPT_CD, \n");
        SET SQLSTRING = CONCAT(SQLSTRING, "  		   (SELECT D.DPT_NM FROM SN_DPT D WHERE D.DPT_CD = B.DPT_CD) AS DPT_CD_NM, \n");
        SET SQLSTRING = CONCAT(SQLSTRING, "  	       B.ROL_CD, \n");
        SET SQLSTRING = CONCAT(SQLSTRING, "  	       (SELECT C.CMN_CD_NM FROM SN_CODE C WHERE C.CD_CLS = 'CPO' AND C.CMN_CD = B.ROL_CD) AS ROL_CD_NM, \n");
        SET SQLSTRING = CONCAT(SQLSTRING, "  	       B.POS_CD, \n");
        SET SQLSTRING = CONCAT(SQLSTRING, "  		   (SELECT C.CMN_CD_NM FROM SN_CODE C WHERE C.CD_CLS = 'OPO' AND C.CMN_CD = B.POS_CD) AS POS_CD_NM, \n");
        SET SQLSTRING = CONCAT(SQLSTRING, "  	       B.CHARGE_TSK, \n");
        SET SQLSTRING = CONCAT(SQLSTRING, "  	       B.TEL_NO, \n");
        SET SQLSTRING = CONCAT(SQLSTRING, "  	       B.CELL_NO, \n");
        SET SQLSTRING = CONCAT(SQLSTRING, "  	       B.STE_CD, \n");
        SET SQLSTRING = CONCAT(SQLSTRING, "  	       B.ID_IMG_PATH, \n");
        SET SQLSTRING = CONCAT(SQLSTRING, "  	       B.USE_YN, \n");
        SET SQLSTRING = CONCAT(SQLSTRING, "  	       B.APVL_YN, \n");
        SET SQLSTRING = CONCAT(SQLSTRING, "  	       B.SYS_YN, \n");
        SET SQLSTRING = CONCAT(SQLSTRING, "  	       B.REG_TS, \n");
        SET SQLSTRING = CONCAT(SQLSTRING, "  	       B.UPD_TS \n");
        SET SQLSTRING = CONCAT(SQLSTRING, "  	  FROM SN_USER B \n");
        SET SQLSTRING = CONCAT(SQLSTRING, "     WHERE 1=1 \n");
        

        IF P_USER_NM != '' THEN
            SET @EXEC_KEYWORD  = P_USER_NM;
            SET SQLSTRING = CONCAT(SQLSTRING, "AND   USER_NM LIKE CONCAT('%', @EXEC_KEYWORD , '%') \n");
        END IF;

        SET SQLSTRING = CONCAT(SQLSTRING, "   ORDER BY USER_NM ASC \n");
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
