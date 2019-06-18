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

-- 프로시저 REDSPUSH.MSET_MEMBER_UPDATE 구조 내보내기
DELIMITER //
CREATE DEFINER=`redspush`@`%` PROCEDURE `MSET_MEMBER_UPDATE`(P_PROC_ID			    VARCHAR(50)	,
                                    P_USR_ID			    VARCHAR(50)	,/* ??(???)ID	*/
							       	P_VALUE			        VARCHAR(100),
							        OUT 	P_RESULT_ID     INTEGER     ,
								    OUT 	P_MESSAGE	    VARCHAR(500)
							       	)
BEGIN
    SET P_RESULT_ID	= 0;
    SET P_MESSAGE	= "????? ???????.";
	
    IF P_PROC_ID = "SET_MEMBER_NICNAME" THEN
		
        IF EXISTS ( SELECT  USR_ID
				    FROM    SN_USR
				    WHERE   USR_ID	= P_USR_ID) THEN
            UPDATE  SN_USR
		    SET     USR_NCKNM	= P_VALUE
		    WHERE   USR_ID	    = P_USR_ID;
        ELSE
		    SET P_RESULT_ID	= -1;
		    SET P_MESSAGE	= "?????? ????.";
        END IF;
	
    ELSEIF P_PROC_ID = "SET_MEMBER_PASSWORD" THEN
		
        IF EXISTS ( SELECT  USR_ID
				    FROM    SN_USR
				    WHERE   USR_ID	= P_USR_ID) THEN
		    UPDATE  SN_USR
		    SET     USR_PW	    = P_VALUE
		    WHERE   USR_ID	    = P_USR_ID;
        ELSE
			SET	P_RESULT_ID	= -1;
			SET	P_MESSAGE	= "?????? ????.";
        END IF;
	
    ELSEIF P_PROC_ID = "SET_MEMBER_MOBILE" THEN
		
        IF EXISTS ( SELECT  USR_ID
				    FROM    SN_USR
				    WHERE   USR_ID	= P_USR_ID) THEN
		    UPDATE  SN_USR
		    SET     CELL_NO	= P_VALUE
		    WHERE   USR_ID	= P_USR_ID;
        ELSE
		    SET P_RESULT_ID	= -1;
		    SET P_MESSAGE	= "?????? ????.";
        END IF;
	
    ELSEIF P_PROC_ID = "SET_MEMBER_PHONE" THEN
		
        IF EXISTS ( SELECT  USR_ID
				    FROM    SN_USR
				    WHERE   USR_ID	= P_USR_ID) THEN
		    UPDATE  SN_USR
		    SET     TEL_NO	= P_VALUE
		    WHERE   USR_ID	= P_USR_ID;
	    ELSE
		    SET P_RESULT_ID	= -1;
		    SET P_MESSAGE	= "?????? ????.";
	    END IF;
	
    ELSEIF P_PROC_ID = "SET_MEMBER_EMAIL" THEN
		
	    IF EXISTS ( SELECT  USR_ID
				    FROM    SN_USR
				    WHERE   USR_ID	= P_USR_ID) THEN
		    UPDATE  SN_USR
		    SET     EMAIL_ADDR	= P_VALUE
		    WHERE   USR_ID	    = P_USR_ID;
	    ELSE
		    SET P_RESULT_ID	= -1;
		    SET P_MESSAGE	= "?????? ????.";
	    END IF;
		
    END IF;

END//
DELIMITER ;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
