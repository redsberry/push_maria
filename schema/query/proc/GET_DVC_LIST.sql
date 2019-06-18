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

-- 프로시저 REDSPUSH.GET_DVC_LIST 구조 내보내기
DELIMITER //
CREATE DEFINER=`redspush`@`%` PROCEDURE `GET_DVC_LIST`(
	IN `P_PROC_ID` VARCHAR(30)     ,
  IN `P_CONF_YN` VARCHAR(1)     ,
  IN `P_USE_YN` VARCHAR(1)     ,
  IN `P_START_NO` INT             ,
  IN `P_PAGE_NO` INT             ,
  IN `P_RIGHT_CD` VARCHAR(3)     ,
  IN `P_USR_ID` VARCHAR(80)     ,
	OUT `P_DVC_CNT` INT             ,
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

    IF  P_PROC_ID = 'GET_DVC_LIST' THEN       

        SET @EXEC_ST  = P_START_NO;
        SET @EXEC_CNT  = P_PAGE_NO;            
        SET @ROWNUM = P_START_NO;
        
        SET CNTSTRING = CONCAT(CNTSTRING, "SELECT COUNT(DVC_NO) \n");      
        SET CNTSTRING = CONCAT(CNTSTRING, "  INTO    @P_CNT \n");     
        SET CNTSTRING = CONCAT(CNTSTRING, "  FROM SN_DEVICE \n");     
        SET CNTSTRING = CONCAT(CNTSTRING, "  WHERE 1=1  \n");
                
        IF P_CONF_YN != '' THEN
            SET @EXEC_CONF_YN  = P_CONF_YN;
            SET CNTSTRING = CONCAT(CNTSTRING, "AND DVC_CONF_YN = @EXEC_CONF_YN \n");
        END IF;

        IF P_USE_YN != '' THEN
            SET @EXEC_USE_YN  = P_USE_YN;
            SET CNTSTRING = CONCAT(CNTSTRING, "AND   DVC_USE_YN = @EXEC_USE_YN \n");
        END IF;
        
        IF P_RIGHT_CD = 'RG2' THEN
          SET @EXEC_USR_ID  = P_USR_ID;
          SET CNTSTRING = CONCAT(CNTSTRING, "AND   USR_ID IN (SELECT USR_ID FROM SN_USR WHERE CPNY_NO = (SELECT CPNY_NO FROM SN_USR WHERE USR_ID = @EXEC_USR_ID))  \n");          
        ELSEIF P_RIGHT_CD = 'RG3' THEN
          SET @EXEC_USR_ID  = P_USR_ID;
          SET CNTSTRING = CONCAT(CNTSTRING, "AND    USR_ID IN (SELECT USR_ID FROM SN_USR WHERE CPNY_NO = (SELECT CPNY_NO FROM SN_USR WHERE USR_ID = @EXEC_USR_ID) AND DPT_NO = (SELECT DPT_NO FROM SN_USR WHERE USR_ID = @EXEC_USR_ID))\n");          
        ELSEIF P_RIGHT_CD = 'RG4' THEN
          SET @EXEC_USR_ID  = P_USR_ID;
          SET CNTSTRING = CONCAT(CNTSTRING, "AND   USR_ID = @EXEC_USR_ID \n");
        END IF;

        SET @EXEC_CNT_SQL   = CNTSTRING;
        PREPARE STMT_CNT FROM  @EXEC_CNT_SQL; 
        EXECUTE STMT_CNT;
        DEALLOCATE PREPARE STMT_CNT;
        SET P_DVC_CNT = @P_CNT;
        
        SET SQLSTRING = CONCAT(SQLSTRING, "SELECT  IFNULL(DVC_NO,'')                DVC_NO, \n");
        SET SQLSTRING = CONCAT(SQLSTRING, "        IFNULL(USR_ID,'')                USR_ID, \n");
        SET SQLSTRING = CONCAT(SQLSTRING, "        IFNULL(DVC_KIND,'')              DVC_KIND, \n");
        SET SQLSTRING = CONCAT(SQLSTRING, "        IFNULL(DVC_UID,'')               DVC_UID, \n");
        SET SQLSTRING = CONCAT(SQLSTRING, "        IFNULL(DVC_MNG_NM,'')            DVC_MNG_NM, \n");
        SET SQLSTRING = CONCAT(SQLSTRING, "        IFNULL(DVC_OS_CAT,'')            DVC_OS_CAT, \n");
        SET SQLSTRING = CONCAT(SQLSTRING, "        IFNULL(DVC_OS_VER,'')            DVC_OS_VER, \n");
        SET SQLSTRING = CONCAT(SQLSTRING, "        IFNULL(DVC_CONF_YN,'')           DVC_CONF_YN, \n");
        SET SQLSTRING = CONCAT(SQLSTRING, "        IFNULL(DVC_USE_YN,'')            DVC_USE_YN, \n");
        SET SQLSTRING = CONCAT(SQLSTRING, "        IFNULL(REG_TS,'')                REG_TS \n");
        SET SQLSTRING = CONCAT(SQLSTRING, "FROM SN_DEVICE \n");
        SET SQLSTRING = CONCAT(SQLSTRING, "WHERE 1=1  \n");

        IF P_CONF_YN != '' THEN
            SET @EXEC_CONF_YN  = P_CONF_YN;
            SET SQLSTRING = CONCAT(SQLSTRING, "AND DVC_CONF_YN = @EXEC_CONF_YN \n");
        END IF;

        IF P_USE_YN != '' THEN
            SET @EXEC_USE_YN  = P_USE_YN;
            SET SQLSTRING = CONCAT(SQLSTRING, "AND DVC_USE_YN = @EXEC_USE_YN \n");
        END IF;
                
        IF P_RIGHT_CD = 'RG2' THEN
          SET @EXEC_USR_ID  = P_USR_ID;
          SET SQLSTRING = CONCAT(SQLSTRING, "AND   USR_ID IN (SELECT USR_ID FROM SN_USR WHERE CPNY_NO = (SELECT CPNY_NO FROM SN_USR WHERE USR_ID = @EXEC_USR_ID))  \n");          
        ELSEIF P_RIGHT_CD = 'RG3' THEN
          SET @EXEC_USR_ID  = P_USR_ID;
          SET SQLSTRING = CONCAT(SQLSTRING, "AND    USR_ID IN (SELECT USR_ID FROM SN_USR WHERE CPNY_NO = (SELECT CPNY_NO FROM SN_USR WHERE USR_ID = @EXEC_USR_ID) AND DPT_NO = (SELECT DPT_NO FROM SN_USR WHERE USR_ID = @EXEC_USR_ID))\n");          
        ELSEIF P_RIGHT_CD = 'RG4' THEN
          SET @EXEC_USR_ID  = P_USR_ID;
          SET SQLSTRING = CONCAT(SQLSTRING, "AND   USR_ID = @EXEC_USR_ID \n");
        END IF;
        
        SET @EXEC_SQL   = SQLSTRING;
        PREPARE STMT FROM  @EXEC_SQL; 
        EXECUTE STMT;
        DEALLOCATE PREPARE STMT;

    END IF;
    
 END//
DELIMITER ;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
