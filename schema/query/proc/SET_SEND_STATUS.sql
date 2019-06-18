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

-- 프로시저 REDSPUSH.SET_SEND_STATUS 구조 내보내기
DELIMITER //
CREATE DEFINER=`redspush`@`%` PROCEDURE `SET_SEND_STATUS`(  P_PROC_ID           VARCHAR(50)	,
                                    P_TRNS_NO		    INT         ,
                                    P_TRNS_STE          CHAR(1)     ,
                                    P_TRNS_CMPT_YN      CHAR(1)     ,
							        OUT 	P_RESULT_ID INTEGER     ,
								    OUT 	P_MESSAGE   VARCHAR(500)
							       	)
BEGIN
    DECLARE V_CODE          VARCHAR(10) DEFAULT '00000';
	
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
        BEGIN
            GET DIAGNOSTICS CONDITION 1
                V_CODE = RETURNED_SQLSTATE, P_MESSAGE = MESSAGE_TEXT;
        END;
    
    SET P_RESULT_ID	= 0;
    SET P_MESSAGE	= "정상적으로 처리되었습니다.";
	
    IF P_PROC_ID = "SET_STATUS_SEND" THEN
        
        UPDATE  PM_MSGPLAN
        SET     TRNS_STE        = P_TRNS_STE    ,
                TRNS_CMPT_YN    = P_TRNS_CMPT_YN
        WHERE   TRNS_NO         = P_TRNS_NO;
		
    END IF;
    
    IF V_CODE != '00000' THEN
        SET P_RESULT_ID	= -1;
    END IF;

END//
DELIMITER ;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
