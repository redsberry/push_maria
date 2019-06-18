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

-- 프로시저 REDSPUSH.SET_BOARD_ATTACH 구조 내보내기
DELIMITER //
CREATE DEFINER=`redspush`@`%` PROCEDURE `SET_BOARD_ATTACH`(  
              P_PROC_ID          VARCHAR(30),
              P_ORG_NM					 VARCHAR(100),
              P_SAVE_SVR				 VARCHAR(100),
              P_SAVE_PATH				 VARCHAR(100),
              P_SAVE_NM					 VARCHAR(100),
              P_FILE_SZ          INT, 
              INOUT P_CNTS_SEQ_NO  INT,
              INOUT P_ATTFILE_SEQ_NO INT,
              OUT   P_RESULT_ID   	INT,
              OUT   P_MESSAGE     VARCHAR(500)      
 )
BEGIN
	  DECLARE V_EXISTS            CHAR(1)    		DEFAULT 'N'; 
    DECLARE V_CNTS_SEQ_NO      	INTEGER     	DEFAULT 0; 
    DECLARE V_ATTFILE_SEQ_NO    INTEGER     	DEFAULT 0;
    DECLARE V_ORG_FILE_NM          	VARCHAR(100) 	DEFAULT NULL;
    DECLARE V_SAVE_SVR         	VARCHAR(100) 	DEFAULT NULL;
    DECLARE V_SAVE_SVR_PATH         VARCHAR(100) 	DEFAULT NULL;
    DECLARE V_SAVE_FILE_NM       	  VARCHAR(100) 	DEFAULT NULL;
    DECLARE V_FILE_SZ       	  INTEGER 			DEFAULT 0;

    SET P_RESULT_ID= -1;
    SET P_MESSAGE= "처리중 오류가 발생했습니다.";

    IF  P_PROC_ID = 'ATTACH_INSERT' THEN

        IF EXISTS ( SELECT  ATTFILE_SEQ_NO
                    FROM    BD_ATTACH
                    WHERE   CNTS_SEQ_NO   = P_CNTS_SEQ_NO
                    AND     ATTFILE_SEQ_NO = P_ATTFILE_SEQ_NO) THEN
                    SELECT CNTS_SEQ_NO,
                           ATTFILE_SEQ_NO,
                           ORG_FILE_NM,
                           SAVE_SVR,
                           SAVE_SVR_PATH,
                           SAVE_FILE_NM,
                           SAVE_FILE_SZ
										  INTO  V_CNTS_SEQ_NO,
                            V_ATTFILE_SEQ_NO,
                            V_ORG_FILE_NM,
                            V_SAVE_SVR,
                            V_SAVE_SVR_PATH,
                            V_SAVE_FILE_NM,
                            V_FILE_SZ
                    FROM    BD_ATTACH
                    WHERE  CNTS_SEQ_NO   = P_CNTS_SEQ_NO
                    AND     ATTFILE_SEQ_NO = P_ATTFILE_SEQ_NO;
            
            SET V_EXISTS = 'Y';
        END IF;
        
        IF V_EXISTS = 'N' THEN
        
         		
        INSERT INTO BD_ATTACH (CNTS_SEQ_NO,
                               ORG_FILE_NM,
                               SAVE_SVR,
                               SAVE_SVR_PATH,
                               SAVE_FILE_NM,
                               SAVE_FILE_SZ)
             VALUES (P_CNTS_SEQ_NO,
                     P_ORG_NM,
                     P_SAVE_SVR,
                     P_SAVE_PATH,
                     P_SAVE_NM,
                     P_FILE_SZ);
                
            SELECT  AUTO_INCREMENT - 1
            INTO    P_ATTFILE_SEQ_NO
            FROM information_schema.TABLES 
            WHERE   TABLE_SCHEMA= "REDSPUSH"
            AND     TABLE_NAME = "BD_ATTACH";  
        
            SET P_RESULT_ID= 0;
            SET P_MESSAGE= "정상적으로 처리되었습니다.";

        ELSE
            SET P_RESULT_ID= -2;
            SET P_MESSAGE= "게시물이 존재합니다.";

        END IF;
    
    ELSEIF  P_PROC_ID = 'ATTACH_UPDATE' THEN
        IF EXISTS ( SELECT  ATTFILE_SEQ_NO
                    FROM    BD_ATTACH
                    WHERE   CNTS_SEQ_NO   = P_CNTS_SEQ_NO
                    AND     ATTFILE_SEQ_NO = P_ATTFILE_SEQ_NO) THEN
                    SELECT CNTS_SEQ_NO,
                           ATTFILE_SEQ_NO,
                           ORG_FILE_NM,
                           SAVE_SVR,
                           SAVE_SVR_PATH,
                           SAVE_FILE_NM,
                           SAVE_FILE_SZ
										  INTO  V_CNTS_SEQ_NO,
                            V_ATTFILE_SEQ_NO,
                            V_ORG_FILE_NM,
                            V_SAVE_SVR,
                            V_SAVE_SVR_PATH,
                            V_SAVE_FILE_NM,
                            V_FILE_SZ
                    FROM    BD_ATTACH
                    WHERE   CNTS_SEQ_NO   = P_CNTS_SEQ_NO
                    AND     ATTFILE_SEQ_NO = P_ATTFILE_SEQ_NO;

				            UPDATE  BD_ATTACH
				            SET     ORG_FILE_NM      = P_ORG_NM,
				                    SAVE_SVR    = P_SAVE_SVR,
				                    SAVE_SVR_PATH   = P_SAVE_PATH,
				                    SAVE_FILE_NM     = P_SAVE_NM
										  WHERE CNTS_SEQ_NO = P_CNTS_SEQ_NO 
                        AND ATTFILE_SEQ_NO = P_ATTFILE_SEQ_NO;
				            
				            SET P_RESULT_ID= 0;
				            SET P_MESSAGE= "정상적으로 처리되었습니다.";

		      ELSE
		          SET P_RESULT_ID= -2;
		          SET P_MESSAGE= "해당 게시물이 존재하지 않습니다.";
		
		      END IF;
        
    ELSEIF  P_PROC_ID = 'ATTACH_DELETE' THEN
        IF EXISTS ( SELECT COUNT(ATTFILE_SEQ_NO)
										  FROM BD_ATTACH
										 WHERE ATTFILE_SEQ_NO = P_ATTFILE_SEQ_NO) THEN 
                    SELECT CNTS_SEQ_NO,
                           ATTFILE_SEQ_NO,
                           ORG_FILE_NM,
                           SAVE_SVR,
                           SAVE_SVR_PATH,
                           SAVE_FILE_NM,
                           SAVE_FILE_SZ
										  INTO  V_CNTS_SEQ_NO,
                            V_ATTFILE_SEQ_NO,
                            V_ORG_FILE_NM,
                            V_SAVE_SVR,
                            V_SAVE_SVR_PATH,
                            V_SAVE_FILE_NM,
                            V_FILE_SZ
                    FROM    BD_ATTACH
                   WHERE ATTFILE_SEQ_NO = P_ATTFILE_SEQ_NO;
                    
                    SET P_CNTS_SEQ_NO = V_CNTS_SEQ_NO;
                    
										DELETE FROM  BD_ATTACH
										WHERE ATTFILE_SEQ_NO = P_ATTFILE_SEQ_NO;
        END IF;
                
        SET P_RESULT_ID= 0;
        SET P_MESSAGE= "정상적으로 처리되었습니다.";                  
                            
    END IF;

END//
DELIMITER ;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
