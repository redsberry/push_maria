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

-- 프로시저 REDSPUSH.GET_BBS_LIST 구조 내보내기
DELIMITER //
CREATE DEFINER=`redspush`@`%` PROCEDURE `GET_BBS_LIST`(
  IN `P_PROC_ID` VARCHAR(30)     ,
  IN `P_BBS_ID`  VARCHAR(5)     ,
  IN `P_START_NO` INT             ,
  IN `P_LIMIT_NO` INT             ,
  IN `P_SORT_NM` VARCHAR(30)     ,
  IN `P_SORT_ORD` VARCHAR(30)     ,
  IN `P_PAGING_YN` VARCHAR(1) ,
	OUT `P_BBS_CNT` INT             ,
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

    IF  P_PROC_ID = 'GET_BBS_LIST' THEN       
        SET @EXEC_ST  = P_START_NO;
        SET @EXEC_CNT  = P_LIMIT_NO;              
        SET @ROWNUM =P_START_NO;

        SET CNTSTRING = CONCAT(CNTSTRING, "SELECT COUNT(BRD_CD) \n");	    
        SET CNTSTRING = CONCAT(CNTSTRING, "  INTO @P_CNT \n");	    
        SET CNTSTRING = CONCAT(CNTSTRING, "  FROM BD_MANAGE A \n");	      

        SET @EXEC_CNT_SQL = CNTSTRING;
        PREPARE STMT_CNT FROM  @EXEC_CNT_SQL;
        EXECUTE STMT_CNT;
        DEALLOCATE PREPARE STMT_CNT;
        SET P_BBS_CNT = @P_CNT;
        
        SET SQLSTRING = CONCAT(SQLSTRING, "SELECT @ROWNUM := @ROWNUM+1 RM, \n");
        SET SQLSTRING = CONCAT(SQLSTRING, "       '/images/common/menu3.png' AS EDIT,      \n");
        SET SQLSTRING = CONCAT(SQLSTRING, "       false AS SEL,      \n");
        SET SQLSTRING = CONCAT(SQLSTRING, "       BRD_CD,      \n");
        SET SQLSTRING = CONCAT(SQLSTRING, "       BRD_TYPE_CD,  \n");
        SET SQLSTRING = CONCAT(SQLSTRING, "       BRD_DESC, \n");
        SET SQLSTRING = CONCAT(SQLSTRING, "       BRD_NM,    \n");
        SET SQLSTRING = CONCAT(SQLSTRING, "       IFNULL(ANS_ENA_YN, 'N') ANS_ENA_YN,  \n");
        SET SQLSTRING = CONCAT(SQLSTRING, "       IFNULL(RPY_ENA_YN, 'N') AS RPY_ENA_YN,  \n");
        SET SQLSTRING = CONCAT(SQLSTRING, "       USE_YN,  \n");
        SET SQLSTRING = CONCAT(SQLSTRING, "       RER_ID,   \n");
        SET SQLSTRING = CONCAT(SQLSTRING, "       REG_TS,    \n");
        SET SQLSTRING = CONCAT(SQLSTRING, "       UPD_TS  \n");
        SET SQLSTRING = CONCAT(SQLSTRING, "  FROM BD_MANAGE \n");
        
    		IF P_SORT_NM != '' THEN           
            SET SQLSTRING = CONCAT(SQLSTRING, " ORDER BY ");
            SET SQLSTRING = CONCAT(SQLSTRING, P_SORT_NM);
            SET SQLSTRING = CONCAT(SQLSTRING, " ");
            SET SQLSTRING = CONCAT(SQLSTRING, P_SORT_ORD);
        END IF;
        
        IF P_PAGING_YN != 'Y' THEN
          SET SQLSTRING = CONCAT(SQLSTRING, "   LIMIT  ?, ?  \n");
        END IF;        

        SET @EXEC_SQL = SQLSTRING;
        PREPARE STMT FROM  @EXEC_SQL;
        IF P_PAGING_YN != 'Y' THEN
          EXECUTE STMT USING @EXEC_ST, @EXEC_CNT;
        ELSE
          EXECUTE STMT;
        END IF;
        DEALLOCATE PREPARE STMT;
      
      ELSEIF  P_PROC_ID = 'GET_BBS_INFO' THEN    
        SELECT BRD_CD,
               BRD_TYPE_CD,
               BRD_DESC,
               BRD_NM,
               ANS_ENA_YN,
               RPY_ENA_YN,
               USE_YN,
               RER_ID,
               REG_TS,
               UPD_TS
          FROM BD_MANAGE
          WHERE BRD_CD = P_BBS_ID;
    END IF;

 END//
DELIMITER ;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
