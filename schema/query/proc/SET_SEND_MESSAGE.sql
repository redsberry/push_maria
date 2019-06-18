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

-- 프로시저 REDSPUSH.SET_SEND_MESSAGE 구조 내보내기
DELIMITER //
CREATE DEFINER=`redspush`@`%` PROCEDURE `SET_SEND_MESSAGE`(  P_PROC_ID		    VARCHAR(50)	,
                                    P_MSGPLN_NO         INT         ,
                                    P_SND_USR_ID        VARCHAR(50)	,
                                    P_RCV_USR_ID_LIST   TEXT	    ,
							       	P_RETRY_SEQ		    INT         ,
                    		        P_MSG_SUBJ          VARCHAR(100),
                    		        P_MSG_CTNTS         TEXT        ,
                    		        P_ATT_CAT_EXT       VARCHAR(5)  ,
                    		        P_ATT_FILE_PATH     VARCHAR(200),
                    		        P_TRNS_CMPT_YN      CHAR(1)     ,
                    		        OUT     P_TRNS_NO   INT         ,
                    		        OUT     P_SNDMSG_NO INT         ,
							        OUT 	P_RESULT_ID INTEGER     ,
								    OUT 	P_MESSAGE   VARCHAR(500)
							       	)
BEGIN
    DECLARE V_TRNS_REQ_TS   DATETIME    DEFAULT NOW();
    DECLARE V_TRNS_CAT_CD   CHAR(1)     DEFAULT "P";
    DECLARE V_TRNS_STE      CHAR(1)     DEFAULT "N";
    DECLARE V_CODE          VARCHAR(10) DEFAULT '00000';
	
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
        BEGIN
            GET DIAGNOSTICS CONDITION 1
                V_CODE = RETURNED_SQLSTATE, P_MESSAGE = MESSAGE_TEXT;
        END;
    
    SET P_RESULT_ID	= 0;
    SET P_MESSAGE	= "정상적으로 처리되었습니다.";
	
    IF P_PROC_ID = "SET_MSGPLAN" THEN
    			
        START   TRANSACTION;
        
        /**
         * 메시지전송
         */
        INSERT  INTO    PM_MSGPLAN
                (
                MSGPLN_NO           ,
                TRNS_REQ_TS         ,
                TRNS_CAT_CD         ,
                TRNS_STE            ,
                SND_USR_ID          ,
                RCV_USR_ID_LIST     ,
                RETRY_SEQ           ,
                TRNS_CMPT_YN        
                )
        VALUES  (
                P_MSGPLN_NO         ,
                V_TRNS_REQ_TS       ,
                V_TRNS_CAT_CD       ,
                V_TRNS_STE          ,
                P_SND_USR_ID        ,
                P_RCV_USR_ID_LIST   ,
                P_RETRY_SEQ         ,
                P_TRNS_CMPT_YN      
                );
        
        SELECT  AUTO_INCREMENT - 1  
        INTO    P_TRNS_NO           
        FROM 	information_schema.TABLES 
        WHERE   TABLE_SCHEMA	= "REDSPUSH"
        AND     TABLE_NAME 		= "PM_MSGPLAN";
		
        /**
         * 전송메시지내용
         */
		INSERT  INTO    PM_MSGCNTS
		        (
		        TRNS_NO         ,
		        MSG_SUBJ        ,
		        MSG_CTNTS       ,
		        ATT_CAT_EXT     ,
		        ATT_FILE_PATH   
		        )
		VALUES  (
		        P_TRNS_NO       ,
		        P_MSG_SUBJ      ,
		        P_MSG_CTNTS     ,
		        P_ATT_CAT_EXT   ,
		        P_ATT_FILE_PATH 
		        );
		
        /**
         * 송신메시지
         */
		INSERT  INTO    PM_MSGSEND
		        (
		        SND_TS          ,
		        USR_ID          ,
		        TRNS_NO         
		        )
		VALUES  (
		        V_TRNS_REQ_TS   ,
		        P_SND_USR_ID    ,
		        P_TRNS_NO       
		        );
        
        SELECT  AUTO_INCREMENT - 1  
        INTO    P_SNDMSG_NO           
        FROM 	information_schema.TABLES 
        WHERE   TABLE_SCHEMA	= "REDSPUSH"
        AND     TABLE_NAME 		= "PM_MSGSEND";
		
	    IF V_CODE = '00000' THEN
		    COMMIT;
	    ELSE
			ROLLBACK;
            SET P_RESULT_ID	= -1;
	    END IF;
		
    END IF;

END//
DELIMITER ;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
