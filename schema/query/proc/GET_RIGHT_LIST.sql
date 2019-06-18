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

-- 프로시저 REDSPUSH.GET_RIGHT_LIST 구조 내보내기
DELIMITER //
CREATE DEFINER=`redspush`@`%` PROCEDURE `GET_RIGHT_LIST`(
	IN `P_PROC_ID` VARCHAR(30)     ,
  IN `P_USR_ID` VARCHAR(30)     ,
  IN `P_USER_RIGHT` VARCHAR(5)     ,
	OUT `P_RIGHT_CNT` INT             ,
	OUT `P_RESULT_ID` INT             ,
	OUT `P_MESSAGE` TINYTEXT        
)
BEGIN        
    DECLARE SQLSTRING   TEXT;
    DECLARE CNTSTRING   TEXT;
            
    SET SQLSTRING = "";  
    SET CNTSTRING = "";
        
    SET P_RESULT_ID= 0;
    SET P_MESSAGE= "정상적으로 처리되었습니다.";

    IF  P_PROC_ID = 'GET_RIGHT_LIST' THEN

      SELECT COUNT(1)
        INTO P_RIGHT_CNT
        FROM SN_RIGHTGRP; 
            
      SELECT '/images/common/menu3.png' AS EDIT,
             FALSE AS SEL,
             RIG_GRP_CD,
             RIG_GRP_NM,
             RIG_GRP_DESC,
             USE_GRP_CD,
             USE_YN,
             SYS_YN,
             UPR_ID,
             UPD_TS
        FROM SN_RIGHTGRP
        ORDER BY RIG_GRP_CD ASC;
    ELSEIF P_PROC_ID = 'GET_USER_RIGHT_LIST' THEN
         
    
      SET @EXEC_USR_ID  = P_USR_ID;
      
      SET CNTSTRING = CONCAT(CNTSTRING, "      SELECT COUNT(1) \n");
      SET CNTSTRING = CONCAT(CNTSTRING, "        INTO @P_CNT \n");
      SET CNTSTRING = CONCAT(CNTSTRING, "        FROM SN_RIGHTGRP \n");
      SET CNTSTRING = CONCAT(CNTSTRING, "       WHERE IFNULL(USE_YN, 'Y') != 'N' \n");

      IF P_USER_RIGHT = 'B' THEN
          SET CNTSTRING = CONCAT(CNTSTRING, "AND USE_GRP_CD IN ('B','C','D') \n");
      ELSEIF P_USER_RIGHT = 'C' THEN
          SET CNTSTRING = CONCAT(CNTSTRING, "AND USE_GRP_CD IN ('C','D') \n");
			ELSEIF P_USER_RIGHT = 'D' THEN
          SET CNTSTRING = CONCAT(CNTSTRING, "AND USE_GRP_CD = 'D' \n");          
      END IF;

      SET @EXEC_CNT_SQL 	= CNTSTRING;
      PREPARE STMT_CNT FROM  @EXEC_CNT_SQL;		
      EXECUTE STMT_CNT;
      DEALLOCATE PREPARE STMT_CNT;
      SET P_RIGHT_CNT = @P_CNT;

      SET SQLSTRING = CONCAT(SQLSTRING, "      SELECT USR_ID, \n");
      SET SQLSTRING = CONCAT(SQLSTRING, "             RIG_GRP_CD, \n");
      SET SQLSTRING = CONCAT(SQLSTRING, "             RIG_GRP_NM, \n");
      SET SQLSTRING = CONCAT(SQLSTRING, "             RIG_GRP_DESC,     \n");        
      SET SQLSTRING = CONCAT(SQLSTRING, "             USE_GRP_CD,     \n");
      SET SQLSTRING = CONCAT(SQLSTRING, "             CASE WHEN USE_YN = 'Y' THEN true ELSE false END USE_YN,  \n");
      SET SQLSTRING = CONCAT(SQLSTRING, "             UPR_ID, \n");
      SET SQLSTRING = CONCAT(SQLSTRING, "             REG_TS,  \n");
      SET SQLSTRING = CONCAT(SQLSTRING, "             UPD_TS \n");
      SET SQLSTRING = CONCAT(SQLSTRING, "        FROM (  SELECT ? AS USR_ID, \n");
      SET SQLSTRING = CONCAT(SQLSTRING, "                      B.RIG_GRP_CD,  \n");
      SET SQLSTRING = CONCAT(SQLSTRING, "                      B.RIG_GRP_NM, \n");
      SET SQLSTRING = CONCAT(SQLSTRING, "                      B.RIG_GRP_DESC, \n");
      SET SQLSTRING = CONCAT(SQLSTRING, "                      B.USE_GRP_CD,     \n");
      SET SQLSTRING = CONCAT(SQLSTRING, "                      IFNULL(A.USE_YN, 'N') AS USE_YN, \n");
      SET SQLSTRING = CONCAT(SQLSTRING, "                      ? AS UPR_ID,  \n");
      SET SQLSTRING = CONCAT(SQLSTRING, "                      NOW() AS REG_TS, \n");
      SET SQLSTRING = CONCAT(SQLSTRING, "                      NOW() AS UPD_TS \n");
      SET SQLSTRING = CONCAT(SQLSTRING, "                 FROM (SELECT NULL AS USR_ID,  \n");
      SET SQLSTRING = CONCAT(SQLSTRING, "                              NULL AS RIG_GRP_CD, \n");
      SET SQLSTRING = CONCAT(SQLSTRING, "                              NULL AS RIG_GRP_NM, \n");
      SET SQLSTRING = CONCAT(SQLSTRING, "                              NULL AS RIG_GRP_DESC, \n");
      SET SQLSTRING = CONCAT(SQLSTRING, "                              NULL AS USE_YN,  \n");
      SET SQLSTRING = CONCAT(SQLSTRING, "                              NULL AS UPR_ID) A RIGHT OUTER JOIN SN_RIGHTGRP B ON A.RIG_GRP_CD = B.RIG_GRP_CD \n");
      SET SQLSTRING = CONCAT(SQLSTRING, "                WHERE A.USR_ID IS NULL \n");
      SET SQLSTRING = CONCAT(SQLSTRING, "                  AND EXISTS (SELECT 1 FROM SN_USR WHERE USR_ID = ?) \n");
      SET SQLSTRING = CONCAT(SQLSTRING, "                  AND B.RIG_GRP_CD NOT IN (SELECT RIG_GRP_CD FROM SN_RIGHT WHERE USR_ID = ?) \n");
      SET SQLSTRING = CONCAT(SQLSTRING, "                  AND B.USE_YN = 'Y' \n");
      
      IF P_USER_RIGHT = 'B' THEN
          SET SQLSTRING = CONCAT(SQLSTRING, "AND B.USE_GRP_CD IN ('B','C','D') \n");
      ELSEIF P_USER_RIGHT = 'C' THEN
          SET SQLSTRING = CONCAT(SQLSTRING, "AND B.USE_GRP_CD IN ('C','D') \n");
			ELSEIF P_USER_RIGHT = 'D' THEN
          SET SQLSTRING = CONCAT(SQLSTRING, "AND B.USE_GRP_CD = 'D' \n");          
      END IF;
      
      SET SQLSTRING = CONCAT(SQLSTRING, "          UNION ALL \n");
      SET SQLSTRING = CONCAT(SQLSTRING, "               SELECT USR_ID, \n");
      SET SQLSTRING = CONCAT(SQLSTRING, "                      A.RIG_GRP_CD, \n");
      SET SQLSTRING = CONCAT(SQLSTRING, "                      B.RIG_GRP_NM, \n");
      SET SQLSTRING = CONCAT(SQLSTRING, "                      B.RIG_GRP_DESC,     \n");                       
      SET SQLSTRING = CONCAT(SQLSTRING, "                      B.USE_GRP_CD,     \n");
      SET SQLSTRING = CONCAT(SQLSTRING, "                      A.USE_YN,  \n");
      SET SQLSTRING = CONCAT(SQLSTRING, "                      A.UPR_ID, \n");
      SET SQLSTRING = CONCAT(SQLSTRING, "                      A.REG_TS,  \n");
      SET SQLSTRING = CONCAT(SQLSTRING, "                      A.UPD_TS \n");
      SET SQLSTRING = CONCAT(SQLSTRING, "                  FROM SN_RIGHT A, SN_RIGHTGRP B  \n");
      SET SQLSTRING = CONCAT(SQLSTRING, "                 WHERE A.RIG_GRP_CD = B.RIG_GRP_CD \n");
      
      IF P_USER_RIGHT = 'B' THEN
          SET SQLSTRING = CONCAT(SQLSTRING, "AND B.USE_GRP_CD IN ('B','C','D') \n");
      ELSEIF P_USER_RIGHT = 'C' THEN
          SET SQLSTRING = CONCAT(SQLSTRING, "AND B.USE_GRP_CD IN ('C','D') \n");
			ELSEIF P_USER_RIGHT = 'D' THEN
          SET SQLSTRING = CONCAT(SQLSTRING, "AND B.USE_GRP_CD = 'D' \n");          
      END IF;
      
      SET SQLSTRING = CONCAT(SQLSTRING, "                   AND USR_ID = ?) RIG \n");
      SET SQLSTRING = CONCAT(SQLSTRING, "       ORDER BY 1, 2 \n");

      SET @EXEC_SQL 	= SQLSTRING;
      PREPARE STMT FROM  @EXEC_SQL;		
      EXECUTE STMT USING @EXEC_USR_ID, @EXEC_USR_ID, @EXEC_USR_ID, @EXEC_USR_ID, @EXEC_USR_ID;
      DEALLOCATE PREPARE STMT;       

    
    ELSE
        SET P_RESULT_ID= -1;
        SET P_MESSAGE= "매개변수를 확인해주시기 바랍니다.";
    END IF;    
END//
DELIMITER ;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
