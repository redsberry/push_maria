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

-- 프로시저 REDSPUSH.SET_BOARD_INFO 구조 내보내기
DELIMITER //
CREATE DEFINER=`redspush`@`%` PROCEDURE `SET_BOARD_INFO`(
	IN `P_PROC_ID` VARCHAR(30),
	IN `P_CNTS_ORD` INT,
	IN `P_CNTS_DEPTH` INT,
  IN `P_CNTS_KIND_CD` VARCHAR(1),
	IN `P_CNTS_TYPE` VARCHAR(40),
  IN `P_CNTS_SUBJ` VARCHAR(100),
	IN `P_CNTS_MSG` LONGTEXT,
	IN `P_ATTFILE_YN` CHAR(1),
	IN `P_REA_CNT` INT,
	IN `P_WTR_ID` VARCHAR(12),
	IN `P_WTR_NM` VARCHAR(100),
  IN `P_CNTS_WR_DPT` VARCHAR(15),
	INOUT `P_BRD_CD` VARCHAR(5),
	INOUT `P_CNTS_SEQ_NO` INT,
	OUT `P_RESULT_ID` INT,
	OUT `P_MESSAGE` VARCHAR(500)        
 
)
BEGIN
	  DECLARE V_EXISTS            CHAR(1)    		DEFAULT 'N';
		DECLARE V_BRD_CD      	VARCHAR(5)    DEFAULT NULL; 
    DECLARE V_CNTS_SEQ_NO      	INTEGER     	DEFAULT 0; 
    DECLARE V_CNTS_ORD          	INTEGER 			DEFAULT 0;
    DECLARE V_CNTS_DEPTH         		INTEGER    		DEFAULT 0;
    DECLARE V_CNTS_TYPE         	VARCHAR(40)    		DEFAULT NULL;
    DECLARE V_CNTS_KIND_CD         	VARCHAR(1)    		DEFAULT NULL;
    DECLARE V_CNTS_SUBJ       	VARCHAR(100) 	DEFAULT NULL;
    DECLARE V_CNTS_MSG       		LONGTEXT DEFAULT NULL;
    DECLARE V_ATTFILE_YN      	CHAR(1)	    	DEFAULT NULL;
    DECLARE V_REA_CNT    			INTEGER    		DEFAULT 0;
    DECLARE V_WTR_ID       			VARCHAR(12) 	DEFAULT NULL;
    DECLARE V_WTR_NM      			VARCHAR(100)	DEFAULT NULL;

    SET P_RESULT_ID= -1;
    SET P_MESSAGE= "처리중 오류가 발생했습니다.";

    IF  P_PROC_ID = 'BOARD_INSERT' THEN
        
						SET P_CNTS_ORD = 0;
            SET P_CNTS_DEPTH = 1;
            SET P_REA_CNT = 0;
         		
            UPDATE BD_BOARD
               SET CNTS_ORD = CNTS_ORD + 1
              WHERE BRD_CD = P_BRD_CD
              AND CNTS_ORD >= 0;		
              
            INSERT INTO BD_BOARD (BRD_CD,
                                  CNTS_ORD,
                                  CNTS_DEPTH,
                                  CNTS_TYPE,
                                  CNTS_KIND_CD,
                                  CNTS_WR_DPT,
						                      CNTS_SUBJ,
						                      CNTS_MSG,
						                      ATTFILE_YN,
						                      REA_CNT,
						                      WTR_ID,
						                      WTR_NM,
                                  REG_TS)
						     VALUES (P_BRD_CD,
                         P_CNTS_ORD,
                         P_CNTS_DEPTH,
                         P_CNTS_TYPE,
                         P_CNTS_KIND_CD,
                         P_CNTS_WR_DPT,
						             P_CNTS_SUBJ,
						             P_CNTS_MSG,
						             P_ATTFILE_YN,
						             P_REA_CNT,
						             P_WTR_ID,
						             P_WTR_NM,
                         NOW());
                         
            SELECT  AUTO_INCREMENT - 1
            INTO    P_CNTS_SEQ_NO
            FROM information_schema.TABLES 
            WHERE   TABLE_SCHEMA= "REDSPUSH"
            AND     TABLE_NAME = "BD_BOARD";                           
                
            SET P_RESULT_ID= 0;
            SET P_MESSAGE= "정상적으로 처리되었습니다.";
    
    ELSEIF  P_PROC_ID = 'BOARD_UPDATE' THEN
        IF EXISTS ( SELECT  CNTS_SEQ_NO
                    FROM    BD_BOARD
                    WHERE   BRD_CD    = P_BRD_CD
                    AND     CNTS_SEQ_NO   = P_CNTS_SEQ_NO) THEN
										SELECT BRD_CD,
										       CNTS_SEQ_NO,
										       CNTS_SUBJ,
										       CNTS_MSG,
										       ATTFILE_YN,
										       REA_CNT,
										       WTR_ID,
										       WTR_NM
										  INTO V_BRD_CD,
										       V_CNTS_SEQ_NO,
										       V_CNTS_SUBJ,
										       V_CNTS_MSG,
										       V_ATTFILE_YN,
										       V_REA_CNT,
										       V_WTR_ID,
										       V_WTR_NM
										  FROM BD_BOARD
										  WHERE BRD_CD = P_BRD_CD
										    AND CNTS_SEQ_NO = P_CNTS_SEQ_NO ;

				            UPDATE  BD_BOARD
				            SET     CNTS_SUBJ      = P_CNTS_SUBJ,
				                    CNTS_MSG       = P_CNTS_MSG,
				                    ATTFILE_YN     = P_ATTFILE_YN,
                            UPD_TS         = NOW()
										  WHERE BRD_CD = P_BRD_CD
										    AND CNTS_SEQ_NO = P_CNTS_SEQ_NO ;
				            
				            SET P_RESULT_ID= 0;
				            SET P_MESSAGE= "정상적으로 처리되었습니다.";

		      ELSE
		          SET P_RESULT_ID= -2;
		          SET P_MESSAGE= "해당 게시물이 존재하지 않습니다.";
		
		      END IF;
        
    ELSEIF  P_PROC_ID = 'BOARD_DELETE' THEN
        IF EXISTS ( SELECT COUNT(ATTFILE_SEQ_NO)
										  FROM BD_ATTACH
										 WHERE CNTS_SEQ_NO = P_CNTS_SEQ_NO) THEN                   
										DELETE FROM  BD_ATTACH
										WHERE CNTS_SEQ_NO = P_CNTS_SEQ_NO;
        END IF;
        
        IF EXISTS ( SELECT COUNT(RPY_SEQ_NO)
										  FROM BD_REPLY
										 WHERE CNTS_SEQ_NO = P_CNTS_SEQ_NO) THEN                   
										DELETE FROM  BD_REPLY
										WHERE CNTS_SEQ_NO = P_CNTS_SEQ_NO;
        END IF;
        
        DELETE FROM BD_BOARD WHERE BRD_CD = P_BRD_CD AND CNTS_SEQ_NO = P_CNTS_SEQ_NO;
        
        SET P_RESULT_ID= 0;
        SET P_MESSAGE= "정상적으로 처리되었습니다.";                  

    ELSEIF  P_PROC_ID = 'BOARD_REPLY_INSERT' THEN
        IF EXISTS ( SELECT  CNTS_SEQ_NO
                    FROM    BD_BOARD
                    WHERE   BRD_CD    = P_BRD_CD
                    AND     CNTS_SEQ_NO   = P_CNTS_SEQ_NO) THEN
										SELECT BRD_CD,
										       CNTS_SEQ_NO,
										       CNTS_ORD,
										       CNTS_DEPTH,
                           CNTS_TYPE,
                           CNTS_KIND_CD,
										       CNTS_SUBJ,
										       CNTS_MSG,
										       ATTFILE_YN,
										       REA_CNT,
										       WTR_ID,
										       WTR_NM
										  INTO V_BRD_CD,
										       V_CNTS_SEQ_NO,
										       V_CNTS_ORD,
										       V_CNTS_DEPTH,
                           V_CNTS_TYPE,
                           V_CNTS_KIND_CD,
										       V_CNTS_SUBJ,
										       V_CNTS_MSG,
										       V_ATTFILE_YN,
										       V_REA_CNT,
										       V_WTR_ID,
										       V_WTR_NM
										  FROM BD_BOARD
										  WHERE BRD_CD = P_BRD_CD
										    AND CNTS_SEQ_NO = P_CNTS_SEQ_NO ;
										    
            SET V_EXISTS = 'Y';
        END IF;										    
										            
       IF V_EXISTS = 'Y' THEN
        
 					SELECT  CASE COALESCE(CNTS_SEQ_NO, '') WHEN '' THEN 1 ELSE MAX(CNTS_SEQ_NO) + 1 END
							INTO V_CNTS_SEQ_NO
						  FROM BD_BOARD
						 WHERE BRD_CD = P_BRD_CD ;

            SET P_CNTS_SEQ_NO = V_CNTS_SEQ_NO;

            UPDATE BD_BOARD
               SET CNTS_ORD = CNTS_ORD + 1
              WHERE BRD_CD = P_BRD_CD
              AND CNTS_ORD > P_CNTS_ORD;										            
										       
            INSERT INTO BD_BOARD (BRD_CD,
						                      /*CNTS_SEQ_NO,*/
														      CNTS_ORD,
														      CNTS_DEPTH,	
                                  CNTS_TYPE,
                                  CNTS_KIND_CD,
                                  CNTS_WR_DPT,
						                      CNTS_SUBJ,
						                      CNTS_MSG,
						                      ATTFILE_YN,
						                      REA_CNT,
						                      WTR_ID,
						                      WTR_NM)
						     VALUES (P_BRD_CD,
						            /* P_CNTS_SEQ_NO,*/
						             V_CNTS_ORD + 1,
						             V_CNTS_DEPTH + 1,
                         P_CNTS_TYPE,
                         P_CNTS_KIND_CD,
                         P_CNTS_WR_DPT,
						             P_CNTS_SUBJ,
						             P_CNTS_MSG,
						             P_ATTFILE_YN,
						             P_REA_CNT,
						             P_WTR_ID,
						             P_WTR_NM);
						             										            
        SET P_RESULT_ID= 0;
        SET P_MESSAGE= "정상적으로 처리되었습니다.";                  
             
      END IF;
    ELSEIF  P_PROC_ID = 'SYSTEM_REPLY_INSERT' THEN
        IF EXISTS ( SELECT  CNTS_SEQ_NO
                    FROM    BD_BOARD
                    WHERE   BRD_CD    = P_BRD_CD
                    AND     CNTS_SEQ_NO   = P_CNTS_SEQ_NO) THEN
										SELECT BRD_CD,
										       CNTS_SEQ_NO,
										       CNTS_ORD,
										       CNTS_DEPTH,
                           CNTS_TYPE,
                           CNTS_KIND_CD,
										       CNTS_SUBJ,
										       CNTS_MSG,
										       ATTFILE_YN,
										       REA_CNT,
										       WTR_ID,
										       WTR_NM
										  INTO V_BRD_CD,
										       V_CNTS_SEQ_NO,
										       V_CNTS_ORD,
										       V_CNTS_DEPTH,
                           V_CNTS_TYPE,
                           V_CNTS_KIND_CD,
										       V_CNTS_SUBJ,
										       V_CNTS_MSG,
										       V_ATTFILE_YN,
										       V_REA_CNT,
										       V_WTR_ID,
										       V_WTR_NM
										  FROM BD_BOARD
										  WHERE BRD_CD = P_BRD_CD
										    AND CNTS_SEQ_NO = P_CNTS_SEQ_NO ;
										    
            SET V_EXISTS = 'Y';
        END IF;										    
										            
       IF V_EXISTS = 'Y' THEN
        
 					SELECT  CASE COALESCE(CNTS_SEQ_NO, '') WHEN '' THEN 1 ELSE MAX(CNTS_SEQ_NO) + 1 END
							INTO V_CNTS_SEQ_NO
						  FROM BD_BOARD
						 WHERE BRD_CD = P_BRD_CD ;

            SET P_CNTS_SEQ_NO = V_CNTS_SEQ_NO;

            UPDATE BD_BOARD
               SET CNTS_ORD = CNTS_ORD + 1
              WHERE BRD_CD = P_BRD_CD
              AND CNTS_ORD > P_CNTS_ORD;		
              
            UPDATE BD_BOARD
               SET CNTS_TYPE = "답변완료"
              WHERE BRD_CD = P_BRD_CD
              AND CNTS_ORD = P_CNTS_ORD;
										       
            INSERT INTO BD_BOARD (BRD_CD,
						                     /* CNTS_SEQ_NO,*/
														      CNTS_ORD,
														      CNTS_DEPTH,	
                                  CNTS_TYPE,
                                  CNTS_KIND_CD,
                                  CNTS_WR_DPT,
						                      CNTS_SUBJ,
						                      CNTS_MSG,
						                      ATTFILE_YN,
						                      REA_CNT,
						                      WTR_ID,
						                      WTR_NM)
						     VALUES (P_BRD_CD,
						             /*P_CNTS_SEQ_NO,*/
						             V_CNTS_ORD + 1,
						             V_CNTS_DEPTH + 1,
                         P_CNTS_TYPE,
                         P_CNTS_KIND_CD,
                         P_CNTS_WR_DPT,
						             P_CNTS_SUBJ,
						             P_CNTS_MSG,
						             P_ATTFILE_YN,
						             P_REA_CNT,
						             P_WTR_ID,
						             P_WTR_NM);
						             										            
        SET P_RESULT_ID= 0;
        SET P_MESSAGE= "정상적으로 처리되었습니다.";                  
             
      END IF;  
    END IF;
END//
DELIMITER ;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
