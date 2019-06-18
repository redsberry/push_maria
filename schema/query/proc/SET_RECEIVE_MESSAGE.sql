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

-- 프로시저 REDSPUSH.SET_RECEIVE_MESSAGE 구조 내보내기
DELIMITER //
CREATE DEFINER=`redspush`@`%` PROCEDURE `SET_RECEIVE_MESSAGE`(   P_PROC_ID       VARCHAR(50)	,
                                        P_USR_ID        VARCHAR(50)	,
                                        P_TRNS_NO		INT         ,
                                        OUT P_RCVMSG_NO INTEGER     ,
    							        OUT P_RESULT_ID INTEGER     ,
    								    OUT P_MESSAGE   VARCHAR(500)
							       	)
BEGIN
    DECLARE V_RCV_TS        DATETIME    DEFAULT NOW();
    DECLARE V_READING_YN    CHAR(1)     DEFAULT "N";
    DECLARE V_SNDMSG_NO     INT         DEFAULT 0;
    DECLARE V_CODE          VARCHAR(10) DEFAULT '00000';
	
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
        BEGIN
            GET DIAGNOSTICS CONDITION 1
                V_CODE = RETURNED_SQLSTATE, P_MESSAGE = MESSAGE_TEXT;
        END;
    
    SET P_RESULT_ID	= 0;
    SET P_MESSAGE	= "정상적으로 처리되었습니다.";
	
    IF P_PROC_ID = "SET_MSGRECV" THEN
        
        /**
         * 발신내역에서 메세지번호를 가져온다.
         */
        IF EXISTS ( SELECT  SNDMSG_NO
                    FROM    PM_MSGSEND
                    WHERE   TRNS_NO = P_TRNS_NO) THEN
            SELECT  SNDMSG_NO
            INTO    V_SNDMSG_NO
            FROM    PM_MSGSEND
            WHERE   TRNS_NO = P_TRNS_NO;
            
            IF NOT EXISTS ( SELECT  RCVMSG_NO
                            FROM    PM_MSGRECV
                            WHERE   USR_ID  = P_USR_ID
                            AND     TRNS_NO = P_TRNS_NO) THEN
                /**
                 * 메시지수신
                 */
                INSERT  INTO    PM_MSGRECV
                        (
                        RCV_TS          ,
                        USR_ID          ,
                        TRNS_NO         ,
                        READING_YN      ,
                        SNDMSG_NO       
                        )
                VALUES  (
                        V_RCV_TS        ,
                        P_USR_ID        ,
                        P_TRNS_NO       ,
                        V_READING_YN    ,
                        V_SNDMSG_NO     
                        );
                
                SELECT  AUTO_INCREMENT - 1  
                INTO    P_RCVMSG_NO           
                FROM 	information_schema.TABLES 
                WHERE   TABLE_SCHEMA	= "REDSPUSH"
                AND     TABLE_NAME 		= "PM_MSGRECV";
        		
        	    IF V_CODE != '00000' THEN
                    SET P_RESULT_ID	= -1;
        	    END IF;
            END IF;
        ELSE
            SET P_RESULT_ID	= -2;
            SET P_MESSAGE	= "발신내역이 없습니다.";
        END IF;
		
    END IF;

END//
DELIMITER ;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
