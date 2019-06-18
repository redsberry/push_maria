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

-- 프로시저 REDSPUSH.MSET_MEMBER_REGIST 구조 내보내기
DELIMITER //
CREATE DEFINER=`redspush`@`%` PROCEDURE `MSET_MEMBER_REGIST`(P_PROC_ID           VARCHAR(50)	,
							       	P_DVC_UID           VARCHAR(50)	,
							       	P_CNPY_NM           VARCHAR(80) ,
							       	P_USR_ID            VARCHAR(50)	,
							       	P_USR_PW            VARCHAR(200),
							       	P_USR_NM            VARCHAR(50) ,
							       	P_USR_NCKNM		    VARCHAR(50) ,
							       	P_USR_BIRDT		    VARCHAR(8)  ,
							       	P_USR_SEX	        VARCHAR(1)  ,/* M or F */
							       	P_EMAIL_ADDR        VARCHAR(50) ,
							       	P_CELL_NO	        VARCHAR(20) ,
							       	P_TEL_NO	        VARCHAR(20) ,
							        OUT 	P_RESULT_ID INTEGER     ,
								    OUT 	P_MESSAGE   VARCHAR(500)
							       	)
BEGIN
    DECLARE V_CPNY_NO       INT     DEFAULT 0;
    DECLARE V_DPT_NO        TINYINT DEFAULT 0;
    DECLARE V_SUCCESS       CHAR(1) DEFAULT 'Y';
    DECLARE V_CPNY_MGR_YN   CHAR(1) DEFAULT 'N';
    DECLARE V_CODE          VARCHAR(10) DEFAULT '00000';
	
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
        BEGIN
            GET DIAGNOSTICS CONDITION 1
                V_CODE = RETURNED_SQLSTATE, P_MESSAGE = MESSAGE_TEXT;
        END;
    
    SET P_RESULT_ID	= 0;
    SET P_MESSAGE	= "정상적으로 처리되었습니다.";
	
    IF P_PROC_ID = "INSERT_MEMBER" THEN
        
        /**
             * 사용자가 존재하고 회사가 존재하지 않는다면 오류라 인정하고 리턴
         */
        IF EXISTS ( SELECT  USR_ID
				    FROM    SN_USR
				    WHERE   USR_ID	= P_USR_ID) THEN
            IF NOT EXISTS ( SELECT  CPNY_NO
                            FROM    SN_COMPANY
                            WHERE   REPLACE(CPNY_NM,' ','') = REPLACE(P_CNPY_NM,' ','')) THEN
                SET V_SUCCESS   = 'N';
                SET P_RESULT_ID	= -1;
                SET P_MESSAGE	= "이미 등록된 사용자입니다.";
            END IF;
        END IF;
        
        IF (V_SUCCESS = 'Y') THEN
        			
            START   TRANSACTION;
            
            /**
             * 회사가 존재하지 않는경우 등록
             * 회사번호를 가져온다
             */
            IF EXISTS ( SELECT  CPNY_NO
                        FROM    SN_COMPANY
                        WHERE   REPLACE(CPNY_NM,' ','') = REPLACE(P_CNPY_NM,' ','')) THEN
                SELECT  CPNY_NO
                INTO    V_CPNY_NO
                FROM    SN_COMPANY
                WHERE   REPLACE(CPNY_NM,' ','') = REPLACE(P_CNPY_NM,' ','');
            ELSE
                INSERT  INTO    SN_COMPANY
                        (
                        CPNY_NM
                        )
                VALUES  (
                        P_CNPY_NM
                        );
                
                SELECT  AUTO_INCREMENT - 1  ,
                        'Y'                 
                INTO    V_CPNY_NO           ,
                        V_CPNY_MGR_YN       
                FROM 	information_schema.TABLES 
                WHERE   TABLE_SCHEMA	= "REDSPUSH"
                AND     TABLE_NAME 		= "SN_COMPANY";
            END IF;
            
            IF LENGTH(P_USR_NCKNM) = 0 THEN
                SET P_USR_NCKNM = NULL;
            END IF;
            IF LENGTH(P_TEL_NO) = 0 THEN
                SET P_TEL_NO = NULL;
            END IF;
            
            /**
             * 기존 사용자 존재유무에 따라서 INSERT/UPDATE
             */
            IF EXISTS ( SELECT  USR_ID
    				    FROM    SN_USR
    				    WHERE   USR_ID	= P_USR_ID) THEN
                UPDATE  SN_USR
                SET     USR_PW          = P_USR_PW      ,
                        USR_NM          = P_USR_NM      ,
                        USR_NCKNM       = P_USR_NCKNM   ,
                        USR_BIRDT       = P_USR_BIRDT   ,
                        USR_SEX         = P_USR_SEX     ,
                        EMAIL_ADDR      = P_EMAIL_ADDR  ,
                        CELL_NO         = P_CELL_NO     ,
                        TEL_NO          = P_TEL_NO      ,
                        LATELY_CONN_TS   = NOW()         
                WHERE   USR_ID	    = P_USR_ID;     
            ELSE
                INSERT  INTO    SN_USR
                        (
                        USR_ID          ,
                        USR_PW          ,
                        USR_NM          ,
                        USR_NCKNM       ,
                        USR_BIRDT       ,
                        USR_SEX         ,
                        EMAIL_ADDR      ,
                        CELL_NO         ,
                        TEL_NO          ,
                        CPNY_NO         ,
                        DPT_NO          ,
                        CPNY_MGR_YN     ,
                        PP_AGR_YN       ,
                        TOS_AGR_YN      ,
                        EMAIL_AUTH_YN   ,
                        REG_TS    
                        )
                VALUES  (
                        P_USR_ID        ,
                        P_USR_PW        ,
                        P_USR_NM        ,
                        P_USR_NCKNM     ,
                        P_USR_BIRDT     ,
                        P_USR_SEX       ,
                        P_EMAIL_ADDR    ,
                        P_CELL_NO       ,
                        P_TEL_NO        ,
                        V_CPNY_NO       ,
                        V_DPT_NO        ,
                        V_CPNY_MGR_YN   ,
                        'Y'             ,
                        'Y'             ,
                        'Y'             ,
                        NOW()           
                        );
            END IF;
            
            /**
             * 중복데이타 삭제
             */
            IF EXISTS ( SELECT  DVC_NO
                        FROM    SN_DEVICE
                        WHERE   DVC_UID = P_DVC_UID
                        AND     USR_ID  = P_USR_ID) THEN
                DELETE  
                FROM    SN_DEVICE
                WHERE   DVC_UID = P_DVC_UID
                AND     USR_ID  = P_USR_ID;
                
                INSERT  INTO    SN_DEVICE
                        (
                        USR_ID      ,
                        DVC_UID     ,
                        DVC_KIND    
                        )
                VALUES  (
                        P_USR_ID    ,
                        P_DVC_UID   ,
                        'M'         
                        );
            ELSE
                /**
                 * 디바이스 존재하지 않는경우 INSERT
                 */
                IF NOT EXISTS ( SELECT  DVC_NO
                                FROM    SN_DEVICE
                                WHERE   DVC_UID  = P_DVC_UID) THEN
                    INSERT  INTO    SN_DEVICE
                            (
                            USR_ID      ,
                            DVC_UID     ,
                            DVC_KIND    
                            )
                    VALUES  (
                            P_USR_ID    ,
                            P_DVC_UID   ,
                            'M'         
                            );
                END IF;
            END IF;
            
    	    IF V_CODE = '00000' THEN
    		    COMMIT;
    	    ELSE
    			ROLLBACK;
                SET P_RESULT_ID	= -1;
    	    END IF;
            
        END IF;
        
    END IF;

END//
DELIMITER ;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
