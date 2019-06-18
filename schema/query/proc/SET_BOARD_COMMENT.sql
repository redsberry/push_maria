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

-- 프로시저 REDSPUSH.SET_BOARD_COMMENT 구조 내보내기
DELIMITER //
CREATE DEFINER=`redspush`@`%` PROCEDURE `SET_BOARD_COMMENT`(
	IN `P_PROC_ID` VARCHAR(30),
	IN `P_RPY_ORD` INT,
	IN `P_RPY_DEPTH` INT,
	IN `P_RPY_MSG` VARCHAR(4000),
	IN `P_WTR_ID` VARCHAR(12),
	IN `P_WTR_NM` VARCHAR(100),
	INOUT `P_BRD_CD` VARCHAR(5),
	INOUT `P_CNTS_SEQ_NO` INT,
	INOUT `P_RPY_SEQ_NO` INT,
	OUT `P_RESULT_ID` INT,
	OUT `P_MESSAGE` VARCHAR(500)        
 
)
BEGIN
    DECLARE V_EXISTS       CHAR(1)    	  DEFAULT 'N';
    DECLARE V_BRD_CD       VARCHAR(5)     DEFAULT NULL; 
    DECLARE V_CNTS_SEQ_NO  INTEGER     	  DEFAULT 0; 
    DECLARE V_RPY_SEQ_NO   INTEGER     	  DEFAULT 0; 
    DECLARE V_RPY_ORD      INTEGER 		  DEFAULT 0;
    DECLARE V_RPY_DEPTH    INTEGER    	  DEFAULT 0;
    DECLARE V_RPY_MSG      VARCHAR(4000)  DEFAULT NULL;
    DECLARE V_WTR_ID       VARCHAR(12) 	  DEFAULT NULL;
    DECLARE V_WTR_NM       VARCHAR(100)	  DEFAULT NULL;

    SET P_RESULT_ID = -1;
    SET P_MESSAGE = "처리중 오류가 발생했습니다.";
                        
    IF  P_PROC_ID = 'BOARD_COMMENT_INSERT' THEN
        IF EXISTS ( SELECT CNTS_SEQ_NO
                      FROM BD_BOARD
                     WHERE BRD_CD    = P_BRD_CD
                       AND CNTS_SEQ_NO   = P_CNTS_SEQ_NO) THEN
                  SELECT CNTS_SEQ_NO,
                         RPY_SEQ_NO, 
                         RPY_ORD,    
                         RPY_DEPTH,  
                         RPY_MSG,    
                         WTR_ID,     
                         WTR_NM
                    INTO V_CNTS_SEQ_NO,
                         V_RPY_SEQ_NO,
                         V_RPY_ORD,
                         V_RPY_DEPTH,
                         V_RPY_MSG,
                         V_WTR_ID,
                         V_WTR_NM
                    FROM BD_REPLY
                   WHERE CNTS_SEQ_NO = P_CNTS_SEQ_NO
                     AND RPY_SEQ_NO = P_RPY_SEQ_NO;
            
            SET V_EXISTS = 'Y';
        END IF;
        
      /*  IF V_EXISTS = 'Y' THEN */
    			SELECT CASE COALESCE(RPY_SEQ_NO, '') WHEN '' THEN 1 ELSE MAX(RPY_SEQ_NO) + 1 END
    			  INTO V_RPY_SEQ_NO
    			  FROM BD_REPLY;
          
          SET P_RPY_SEQ_NO = V_RPY_SEQ_NO;
                            
    			SELECT CASE COALESCE(RPY_DEPTH, '') WHEN '' THEN 1 ELSE MAX(RPY_DEPTH) + 1 END
    			  INTO V_RPY_DEPTH
    			  FROM BD_REPLY
           WHERE CNTS_SEQ_NO = P_CNTS_SEQ_NO;
                  
    			SET V_RPY_ORD = 0;             
                  
          UPDATE BD_REPLY
             SET RPY_ORD = RPY_ORD + 1
            WHERE CNTS_SEQ_NO = P_CNTS_SEQ_NO
             AND RPY_ORD >= 0;
             
          INSERT INTO BD_REPLY (CNTS_SEQ_NO,
                              RPY_SEQ_NO,
                              RPY_ORD,
                              RPY_DEPTH,
                              RPY_MSG,
                              WTR_ID,
                              WTR_NM)
               VALUES (P_CNTS_SEQ_NO,
                       P_RPY_SEQ_NO,
                       V_RPY_ORD,
                       1, /*V_RPY_DEPTH,*/
                       P_RPY_MSG,
                       P_WTR_ID,
                       P_WTR_NM);
                              
              SET P_RESULT_ID= 0;
              SET P_MESSAGE= "정상적으로 처리되었습니다.";

      /*  ELSE
            SET P_RESULT_ID= -2;
            SET P_MESSAGE= "게시물이 존재합니다.";

        END IF;*/
    ELSEIF  P_PROC_ID = 'BOARD_COMMENT_UPDATE' THEN
        IF EXISTS ( SELECT  RPY_SEQ_NO
                    FROM    BD_REPLY
                    WHERE   CNTS_SEQ_NO   = P_CNTS_SEQ_NO
                    AND     RPY_SEQ_NO   = P_RPY_SEQ_NO) THEN
				            UPDATE  BD_REPLY
				            SET     RPY_MSG       = P_RPY_MSG
										  WHERE CNTS_SEQ_NO = P_CNTS_SEQ_NO 
                        AND RPY_SEQ_NO   = P_RPY_SEQ_NO;
				            
				            SET P_RESULT_ID= 0;
				            SET P_MESSAGE= "정상적으로 처리되었습니다.";

		      ELSE
		          SET P_RESULT_ID= -2;
		          SET P_MESSAGE= "해당 게시물이 존재하지 않습니다.";
		
		      END IF;
        
    ELSEIF  P_PROC_ID = 'BOARD_COMMENT_DELETE' THEN
        IF EXISTS ( SELECT  RPY_SEQ_NO
                    FROM    BD_REPLY
                    WHERE   CNTS_SEQ_NO   = P_CNTS_SEQ_NO
                    AND     RPY_SEQ_NO   = P_RPY_SEQ_NO) THEN                 
										DELETE FROM  BD_REPLY
                    WHERE   CNTS_SEQ_NO   = P_CNTS_SEQ_NO
                    AND     RPY_SEQ_NO   = P_RPY_SEQ_NO;
        END IF;
        
        SET P_RESULT_ID= 0;
        SET P_MESSAGE= "정상적으로 처리되었습니다.";   
        
    END IF;

END//
DELIMITER ;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
