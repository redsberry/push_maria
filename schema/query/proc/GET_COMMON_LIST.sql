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

-- 프로시저 REDSPUSH.GET_COMMON_LIST 구조 내보내기
DELIMITER //
CREATE DEFINER=`redspush`@`%` PROCEDURE `GET_COMMON_LIST`(   P_PROC_ID		    VARCHAR(50)	,
    						       	P_CPNY_NO           INT	        ,
    						       	P_PARAM1            VARCHAR(50)	,
    						       	P_PARAM2            VARCHAR(50)	,
    						       	P_PARAM3            VARCHAR(50)	,
    						       	P_PARAM4            INT	        ,
    						       	P_PARAM5            INT	        ,
    						        OUT 	P_RESULT_ID INTEGER     ,
    							    OUT 	P_MESSAGE   VARCHAR(500)
    						       	)
BEGIN
    SET P_RESULT_ID	= 0;
    SET P_MESSAGE	= "정상적으로 처리되었습니다.";
	
    IF P_PROC_ID = "GET_CPNY_DEPT" THEN
        
        SELECT  A.DPT_NO        ,
                A.DPT_NM        ,
                A.DPT_TEL_NO    ,
                A.DPT_FAX_NO    
          FROM  SN_DPT A
         WHERE  A.CPNY_NO   = P_CPNY_NO;
	
    ELSEIF P_PROC_ID = "GET_CPNY_USR" THEN
        
        SELECT  A.USR_ID      ,
                A.USR_NM      ,
                A.USR_NCKNM   ,
                A.USR_BIRDT   ,
                A.USR_SEX     ,
                A.EMAIL_ADDR  ,
                A.CELL_NO     ,
                A.TEL_NO      ,
                A.POS_NM      ,
                A.DUTY_NM     ,
                A.AVT_IMG_PATH,
                A.CPNY_MGR_YN ,
                A.DPT_MGR_YN  ,
                A.DPT_NO      ,
                GET_DEVICE_EXISTS(A.USR_ID) DEVICE_REGST_YN
          FROM  SN_USR A
         WHERE  A.CPNY_NO   = P_CPNY_NO;
        /*
          FROM  SN_USR A, V_DEVICE_USR_ID B
         WHERE  A.CPNY_NO   = P_CPNY_NO
           AND  B.USR_ID    = A.USR_ID;
	    */
    ELSEIF P_PROC_ID = "GET_CPNY_ALL" THEN
        
        SELECT  A.DPT_NO      ,
                A.DPT_NM      ,
                A.DPT_TEL_NO  ,
                A.DPT_FAX_NO  
          FROM  SN_DPT A
         WHERE  A.CPNY_NO = P_CPNY_NO;
        
        SELECT  A.USR_ID      ,
                A.USR_NM      ,
                A.USR_NCKNM   ,
                A.USR_BIRDT   ,
                A.USR_SEX     ,
                A.EMAIL_ADDR  ,
                A.CELL_NO     ,
                A.TEL_NO      ,
                A.POS_NM      ,
                A.DUTY_NM     ,
                A.AVT_IMG_PATH,
                A.CPNY_MGR_YN ,
                A.DPT_MGR_YN  ,
                A.DPT_NO      ,
                GET_DEVICE_EXISTS(A.USR_ID) DEVICE_REGST_YN
          FROM  SN_USR A
         WHERE  A.CPNY_NO   = P_CPNY_NO;
        /*
          FROM  SN_USR A, V_DEVICE_USR_ID B
         WHERE  A.CPNY_NO   = P_CPNY_NO
           AND  B.USR_ID    = A.USR_ID;
	    */
    
    END IF;

END//
DELIMITER ;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
