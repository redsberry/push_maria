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

-- 프로시저 REDSPUSH.SET_RECEIVE_STATUS 구조 내보내기
DELIMITER //
CREATE DEFINER=`redspush`@`%` PROCEDURE `SET_RECEIVE_STATUS`(P_PROC_ID           VARCHAR(50)	,
                                    P_TRNS_NO		    INT         ,
                                    P_DVC_ID            VARCHAR(50) ,
                                    P_USR_ID            VARCHAR(50)	,
							        OUT 	P_RESULT_ID INTEGER     ,
								    OUT 	P_MESSAGE   VARCHAR(500)
							       	)
BEGIN
    DECLARE V_SENDER_ID     VARCHAR(50);
    DECLARE V_DVC_NO        INT         DEFAULT 0;
    DECLARE V_RCVMSG_NO     INT         DEFAULT 0;
    DECLARE V_CODE          VARCHAR(10) DEFAULT '00000';
	
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
        BEGIN
            GET DIAGNOSTICS CONDITION 1
                V_CODE = RETURNED_SQLSTATE, P_MESSAGE = MESSAGE_TEXT;
        END;
    
    SET P_RESULT_ID	= 0;
    SET P_MESSAGE	= "정상적으로 처리되었습니다.";
	
    IF P_PROC_ID = "SET_STATUS_READ" THEN
        
        SELECT  SND_USR_ID
        INTO    V_SENDER_ID
        FROM    PM_MSGPLAN
        WHERE   TRNS_NO = P_TRNS_NO;
        
        IF EXISTS ( SELECT  A.TRNS_NO
                    FROM    PM_MSGPLAN A, PM_MSGRECV B
                    WHERE   A.SND_USR_ID    = V_SENDER_ID
                    AND     B.TRNS_NO       = A.TRNS_NO
                    AND     B.USR_ID        = P_USR_ID
                    AND     B.READING_YN    = 'N') THEN
            UPDATE  PM_MSGRECV
            SET     READING_YN  = "Y"
            WHERE   TRNS_NO    IN  (SELECT  A.TRNS_NO
                                    FROM    PM_MSGPLAN A, PM_MSGRECV B
                                    WHERE   A.SND_USR_ID    = V_SENDER_ID
                                    AND     B.TRNS_NO       = A.TRNS_NO
                                    AND     B.USR_ID        = P_USR_ID
                                    AND     B.READING_YN    = 'N');
        END IF;
        
        IF EXISTS ( SELECT  DVC_NO
                    FROM    SN_DEVICE 
                    WHERE   USR_ID  = P_USR_ID
                    AND     DVC_UID = P_DVC_ID) THEN
            SELECT  DVC_NO
            INTO    V_DVC_NO
            FROM    SN_DEVICE 
            WHERE   USR_ID  = P_USR_ID
            AND     DVC_UID = P_DVC_ID;
            
            IF EXISTS ( SELECT  RCVMSG_NO
                        FROM    PM_MSGREADING
                        WHERE   DVC_NO  = V_DVC_NO) THEN
                SELECT  MAX(RCVMSG_NO)
                INTO    V_RCVMSG_NO
                FROM    PM_MSGREADING
                WHERE   DVC_NO  = V_DVC_NO;
            END IF;
            
            IF EXISTS ( SELECT  RCVMSG_NO
                        FROM    PM_MSGRECV
                        WHERE   RCVMSG_NO   > V_RCVMSG_NO
                        AND     USR_ID      = P_USR_ID
                        AND     READING_YN  = "Y") THEN
                INSERT  INTO    PM_MSGREADING
                        (
                        RCVMSG_NO   ,
                        DVC_NO      ,
                        READING_TS  
                        )
                SELECT  RCVMSG_NO   ,
                        V_DVC_NO    ,
                        RCV_TS      
                FROM    PM_MSGRECV
                WHERE   RCVMSG_NO   > V_RCVMSG_NO
                AND     USR_ID      = P_USR_ID
                AND     READING_YN  = "Y";
            END IF;
        ELSE
            SET P_RESULT_ID	= -2;
            SET P_MESSAGE	= "등록된 디바이스가 없습니다.";
        END IF;
        
	    IF V_CODE != '00000' THEN
            SET P_RESULT_ID	= -1;
	    END IF;
		
    END IF;

END//
DELIMITER ;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
