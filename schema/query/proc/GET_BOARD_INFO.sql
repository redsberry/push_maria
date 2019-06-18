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

-- 프로시저 REDSPUSH.GET_BOARD_INFO 구조 내보내기
DELIMITER //
CREATE DEFINER=`redspush`@`%` PROCEDURE `GET_BOARD_INFO`(
    IN  P_PROC_ID       VARCHAR(30)     ,
    IN  P_BRD_CD        VARCHAR(5)   		,
    IN  P_CNTS_SEQ_NO   INT             ,
    IN  P_USER_ID       VARCHAR(80)     ,
    OUT P_BRD_NM        VARCHAR(100)	,
    OUT P_BRD_ORD       SMALLINT(6),
    OUT P_BRD_NO        VARCHAR(5)  		,
    OUT P_CNTS_NO       INT        		,
    OUT P_CNTS_ORD      INT        		,
    OUT P_CNTS_DEPTH    INT        		,
    OUT P_CNTS_TYPE   VARCHAR(40)     ,
    OUT P_CNTS_KIND_CD  VARCHAR(1)      ,
    OUT P_CNTS_SUBJ     VARCHAR(50)     ,
    OUT P_CNTS_MSG      LONGTEXT   ,
    OUT P_ATTFILE_YN    CHAR(1)         ,
    OUT P_REA_CNT       INT             ,
    OUT P_WTR_ID        VARCHAR(12)	    ,
    OUT P_WTR_NM        VARCHAR(50)     ,
    OUT P_REG_TS        TINYTEXT        ,
    OUT P_REPLY_CNT     INT             ,
    OUT P_FILE_CNT      INT             ,
    OUT P_RESULT_ID     INT             ,
    OUT P_MESSAGE       TINYTEXT        
)
BEGIN
    SET P_RESULT_ID = 0;
    SET P_MESSAGE   = "정상적으로 처리되었습니다.";
    
    IF  P_PROC_ID = 'GET_BOARD_ALL_INFO' THEN
        IF EXISTS(SELECT CNTS_SEQ_NO
                    FROM BD_BOARD
                   WHERE BRD_CD     = P_BRD_CD
                     AND CNTS_SEQ_NO    = P_CNTS_SEQ_NO) THEN
            SELECT (SELECT BRD_NM 
                      FROM BD_MANAGE 
                     WHERE BRD_CD   = P_BRD_CD) AS BRD_NM,
                    (SELECT MNU_ORD 
                      FROM SN_MENU 
                     WHERE MNU_CD   = P_BRD_CD) AS BRD_ORD,                     
                   BRD_CD,
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
                   WTR_NM,
                   DATE_FORMAT(REG_TS,'%Y-%m-%d %H:%i') AS REG_TS
              INTO P_BRD_NM,
                   P_BRD_ORD,
                   P_BRD_NO,
                   P_CNTS_NO,
                   P_CNTS_ORD,
                   P_CNTS_DEPTH,
                   P_CNTS_TYPE,
                   P_CNTS_KIND_CD,
                   P_CNTS_SUBJ,
                   P_CNTS_MSG,
                   P_ATTFILE_YN,
                   P_REA_CNT,
                   P_WTR_ID,
                   P_WTR_NM,
                   P_REG_TS
              FROM BD_BOARD
             WHERE BRD_CD   = P_BRD_CD
               AND CNTS_SEQ_NO  = P_CNTS_SEQ_NO;    
        END IF; 
        
        SELECT COUNT(RPY_SEQ_NO)
          INTO P_REPLY_CNT
          FROM BD_REPLY
         WHERE CNTS_SEQ_NO  = P_CNTS_SEQ_NO;            
        
        SELECT COUNT(ATTFILE_SEQ_NO) 
          INTO P_FILE_CNT
          FROM BD_ATTACH
         WHERE CNTS_SEQ_NO  = P_CNTS_SEQ_NO;
        
        SELECT CNTS_SEQ_NO,
               RPY_SEQ_NO,
               RPY_ORD,
               RPY_DEPTH,
               RPY_MSG,
               WTR_ID,
               WTR_NM,
               DATE_FORMAT(REG_TS,'%Y-%m-%d') AS REG_TS,
               (SELECT COUNT(1) FROM BD_REPLY R WHERE R.CNTS_SEQ_NO  = 12 AND R.RPY_DEPTH = RPY_DEPTH AND R.RPY_DEPTH > 1) AS REPLY_REPLY_COUNT
          FROM BD_REPLY
         WHERE CNTS_SEQ_NO  = P_CNTS_SEQ_NO
         ORDER BY RPY_ORD ASC;
        
        SELECT ATTFILE_SEQ_NO,
               SAVE_SVR,
               ORG_FILE_NM,
               SAVE_SVR_PATH,
               SAVE_FILE_NM,
               SAVE_FILE_SZ
          FROM BD_ATTACH
         WHERE CNTS_SEQ_NO  = P_CNTS_SEQ_NO;
        
        SELECT BRD_CD, CNTS_SEQ_NO, CNTS_SUBJ
          FROM BD_BOARD 
         WHERE BRD_CD   = P_BRD_CD 
           AND CNTS_SEQ_NO  < P_CNTS_SEQ_NO
         ORDER BY CNTS_SEQ_NO DESC LIMIT 1;
        
        SELECT BRD_CD, CNTS_SEQ_NO, CNTS_SUBJ
          FROM BD_BOARD 
         WHERE BRD_CD   = P_BRD_CD
           AND CNTS_SEQ_NO  > P_CNTS_SEQ_NO
         ORDER BY CNTS_SEQ_NO LIMIT 1;
        
        UPDATE BD_BOARD
           SET REA_CNT      = REA_CNT + 1
         WHERE BRD_CD   = P_BRD_CD
           AND CNTS_SEQ_NO  = P_CNTS_SEQ_NO;
           
        /*사용자별 열람 확인 및 안 읽은 갯수 업데이트*/
        IF P_USER_ID != '' THEN
          INSERT INTO BD_READLOG (CNTS_SEQ_NO, USR_ID, BRD_CD, READ_TS) VALUES (P_CNTS_SEQ_NO, P_USER_ID, P_BRD_CD, NOW()) ON DUPLICATE KEY UPDATE READ_TS=NOW();
          
          INSERT INTO BD_READCOUNT (BRD_CD, USR_ID, UNREAD_CNT) 
                VALUES (P_BRD_CD, P_USER_ID, 
                        (
                          SELECT ABS(A.TOTAL-A.REA)
                            FROM (
                              SELECT 
                               (SELECT COUNT(1) FROM BD_BOARD WHERE BRD_CD = 'BBS01' ) AS TOTAL,
                               (SELECT COUNT(1) FROM BD_READLOG WHERE BRD_CD = 'BBS01' AND USR_ID = 'oslee97') AS REA
                               FROM DUAL
                             ) A                        
                        )
                ) 
                ON DUPLICATE KEY UPDATE UNREAD_CNT= (
                          SELECT ABS(A.TOTAL-A.REA)
                            FROM (
                              SELECT 
                               (SELECT COUNT(1) FROM BD_BOARD WHERE BRD_CD = 'BBS01' ) AS TOTAL,
                               (SELECT COUNT(1) FROM BD_READLOG WHERE BRD_CD = 'BBS01' AND USR_ID = 'oslee97') AS REA
                               FROM DUAL
                             ) A                        
                        );
          
        END IF;

    ELSEIF  P_PROC_ID = 'GET_BOARD_INFO' THEN
        IF EXISTS(SELECT CNTS_SEQ_NO
                    FROM BD_BOARD
                   WHERE BRD_CD     = P_BRD_CD
                     AND CNTS_SEQ_NO    = P_CNTS_SEQ_NO) THEN
            SELECT (SELECT BRD_NM 
                      FROM BD_MANAGE 
                     WHERE BRD_CD   = P_BRD_CD) AS BRD_NM,
                    (SELECT MNU_ORD 
                      FROM SN_MENU 
                     WHERE MNU_CD   = P_BRD_CD) AS BRD_ORD,                        
                     BRD_CD,
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
                     WTR_NM,
                     DATE_FORMAT(REG_TS,'%Y-%m-%d') AS REG_TS
                INTO P_BRD_NM,
                     P_BRD_ORD,
                     P_BRD_NO,
                     P_CNTS_NO,
                     P_CNTS_ORD,
                     P_CNTS_DEPTH,
                     P_CNTS_TYPE,
                     P_CNTS_KIND_CD,
                     P_CNTS_SUBJ,
                     P_CNTS_MSG,
                     P_ATTFILE_YN,
                     P_REA_CNT,
                     P_WTR_ID,
                     P_WTR_NM,
                     P_REG_TS
                FROM BD_BOARD
               WHERE BRD_CD   = P_BRD_CD
                 AND CNTS_SEQ_NO  = P_CNTS_SEQ_NO;

            SELECT ATTFILE_SEQ_NO,
                   SAVE_SVR,
                   ORG_FILE_NM,
                   SAVE_SVR_PATH,
                   SAVE_FILE_NM,
                   SAVE_FILE_SZ
              FROM BD_ATTACH
             WHERE CNTS_SEQ_NO  = P_CNTS_SEQ_NO;     
               
            SELECT COUNT(RPY_SEQ_NO)
              INTO P_REPLY_CNT
              FROM BD_REPLY
             WHERE CNTS_SEQ_NO  = P_CNTS_SEQ_NO;            

            SELECT COUNT(ATTFILE_SEQ_NO) 
              INTO P_FILE_CNT
              FROM BD_ATTACH
             WHERE CNTS_SEQ_NO  = P_CNTS_SEQ_NO;
           
        END IF; 
    ELSE
        SET P_RESULT_ID= -1;
        SET P_MESSAGE= "매개변수를 확인해주시기 바랍니다.";
    END IF;    
    
END//
DELIMITER ;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
