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

-- 프로시저 REDSPUSH.MGET_DOCKER_MEMBER_LOGIN 구조 내보내기
DELIMITER //
CREATE DEFINER=`redspush`@`%` PROCEDURE `MGET_DOCKER_MEMBER_LOGIN`( P_PROC_ID		    VARCHAR(50)	,
							       	        P_DVC_UID           VARCHAR(50)	,
                                            P_USR_ID            VARCHAR(50)	,
							       	        P_USR_PW		    VARCHAR(200),
                                            P_DVC_KIND	        VARCHAR(1)  ,
                                            P_DVC_OS_CAT	    VARCHAR(1)  ,
							                OUT P_RESULT_ID     INTEGER     ,
								            OUT P_MESSAGE       VARCHAR(500)
							       	        )
BEGIN
    DECLARE V_USR_PW    VARCHAR(200);
    DECLARE V_USR_ID    VARCHAR(50);
    
    SET P_RESULT_ID	= 0;
    SET P_MESSAGE	= "정상적으로 처리되었습니다.";
	
    IF P_PROC_ID = "GET_MEMBER_LOGIN" THEN
        /**
         * 사용자 존재유무 확인 후 패스워드를 비교한다.
         * 디바이스에 존재하지 않으면 디바이스에 등록한다.
         */
        IF EXISTS ( SELECT  USR_ID
                    FROM    SN_USR
                    WHERE   USR_ID  = P_USR_ID) THEN
            
            SELECT  USR_PW
            INTO    V_USR_PW
            FROM    SN_USR
            WHERE   USR_ID  = P_USR_ID;
            
            IF P_USR_PW = V_USR_PW THEN
                
                /**
                 * 최근 접속시간 업데이트
                 */
                UPDATE  SN_USR
                SET     LATELY_CONN_TS  = NOW()
                WHERE   USR_ID  = P_USR_ID;
                
                IF EXISTS ( SELECT  DVC_NO
                            FROM    SN_DEVICE
                            WHERE   DVC_UID  = P_DVC_UID) THEN
                    SELECT  USR_ID
                    INTO    V_USR_ID
                    FROM    SN_DEVICE
                    WHERE   DVC_UID  = P_DVC_UID;
                    
                    IF V_USR_ID != P_USR_ID THEN
                        UPDATE  SN_DEVICE
                        SET     USR_ID  = P_USR_ID
                        WHERE   DVC_UID = P_DVC_UID;
                    END IF;
                ELSE
                    INSERT  INTO    SN_DEVICE
                            (
                            USR_ID      ,
                            DVC_KIND    ,
                            DVC_UID     ,
                            DVC_OS_CAT  
                            )
                    VALUES  (
                            P_USR_ID    ,
                            P_DVC_KIND  ,
                            P_DVC_UID   ,
                            P_DVC_OS_CAT
                            );
                END IF;
                
            ELSE
                SET P_RESULT_ID	= -2;
    		    SET P_MESSAGE	= "패스워드가 맞지 않습니다.";
            END IF;
            
        ELSE
            SET P_RESULT_ID	= -1;
		    SET P_MESSAGE	= "회원아이디가 없습니다.";
        END IF;
        
        /**
         * 사용자정보 리턴
         */
        SELECT  A.USR_NM MEMBER_NAME, 
                A.USR_NCKNM NIC_NAME, 
                A.CELL_NO MOBILE    , 
                A.TEL_NO PHONE      , 
                A.EMAIL_ADDR EMAIL  ,
                A.USR_BIRDT BIRTHDAY,
                A.USR_SEX GENDER    ,
                A.AVT_IMG_PATH      ,
                A.CPNY_NO           ,
                A.DPT_NO            ,
                A.POS_NM            ,
                A.DUTY_NM           
          FROM  SN_USR A
         WHERE  A.USR_ID = P_USR_ID;
		
    END IF;

END//
DELIMITER ;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
