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

-- 프로시저 REDSPUSH.MGET_MEMBER_SERCH 구조 내보내기
DELIMITER //
CREATE DEFINER=`redspush`@`%` PROCEDURE `MGET_MEMBER_SERCH`( P_PROC_ID		    VARCHAR(50)	,
							       	P_CPNY_NO           VARCHAR(50)	,
							       	P_SEARCH            VARCHAR(50)	,
							        OUT 	P_RESULT_ID INTEGER     ,
								    OUT 	P_MESSAGE   VARCHAR(500)
							       	)
BEGIN
    SET P_RESULT_ID	= 0;
    SET P_MESSAGE	= "정상적으로 처리되었습니다.";
	
    IF P_PROC_ID = "GET_NAME" THEN
        
        SELECT  A.USR_ID        , 
                A.USR_NM        , 
                A.USR_NCKNM     ,
                A.EMAIL_ADDR    ,
                A.CELL_NO       ,
                A.TEL_NO        ,
                A.POS_NM        ,
                A.DUTY_NM       ,
                A.DPT_NO        ,
                A.AVT_IMG_PATH  ,
                GET_DEPT_NAME(A.DPT_NO) DPT_NM
          FROM  SN_USR A, SN_DEVICE B
         WHERE  A.CPNY_NO   = P_CPNY_NO
           AND  A.USR_NM LIKE CONCAT(P_SEARCH,"%")
           AND  B.USR_ID    = A.USR_ID;
    
    END IF;

END//
DELIMITER ;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
