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

-- 프로시저 REDSPUSH.GET_USER_INFO 구조 내보내기
DELIMITER //
CREATE DEFINER=`redspush`@`%` PROCEDURE `GET_USER_INFO`(
    IN `P_USR_ID`                VARCHAR(80),
    OUT `P_USR_PW`         				VARCHAR(512),
    OUT `P_USR_NM`         				VARCHAR(50),
    OUT `P_USR_NCKNM`         		VARCHAR(50),
    OUT `P_USR_BIRDT`         		VARCHAR(8),
    OUT `P_USR_SEX`         			VARCHAR(1),
    OUT `P_EMAIL_ADDR`         		VARCHAR(80),
    OUT `P_CELL_NO`         			VARCHAR(20),
    OUT `P_TEL_NO`         				VARCHAR(20),
    OUT `P_POS_NM`         				VARCHAR(20),
    OUT `P_DUTY_NM`         			VARCHAR(20),
    OUT `P_AVT_IMG_PATH`         	VARCHAR(256),
    OUT `P_CPNY_NO`         			INT(10),
    OUT `P_CPNY_MGR_YN`         	VARCHAR(1) ,
    OUT `P_DPT_NO`         				INT(10) ,
    OUT `P_DPT_MGR_YN`         		VARCHAR(1) ,
    OUT `P_ACNT_KAKAO_LINK_YN`    VARCHAR(1) ,
    OUT `P_ACNT_GOOGLE_LINK_YN`   VARCHAR(1) ,
    OUT `P_PP_AGR_YN`         		VARCHAR(1) ,
    OUT `P_TOS_AGR_YN`         		VARCHAR(1) ,
    OUT `P_DVC_AUTH_YN`         	VARCHAR(1) ,
    OUT `P_EMAIL_AUTH_YN`         VARCHAR(1) ,
    OUT `P_JOIN_STE_CD`         	VARCHAR(1) ,
    OUT `P_PRE_REG_YN`         		VARCHAR(1) ,
    OUT `P_LATELY_CONN_TS`        VARCHAR(20) ,
    OUT `P_REG_TS`         				VARCHAR(20),
    OUT `P_RESULT_ID`      INT ,	
    OUT `P_MESSAGE`        TINYTEXT
)
BEGIN    	
     
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET P_RESULT_ID = -1;
    SET P_RESULT_ID = 0; 
    SET P_MESSAGE = "정상적으로 처리되었습니다.";
    
      SELECT USR_PW,
             USR_NM,
             USR_NCKNM,
             USR_BIRDT,
             USR_SEX,
             EMAIL_ADDR,
             CELL_NO,
             TEL_NO,
             POS_NM,
             DUTY_NM,
             AVT_IMG_PATH,
             CPNY_NO,
             CPNY_MGR_YN,
             DPT_NO,
             DPT_MGR_YN,
             ACNT_KAKAO_LINK_YN,
             ACNT_GOOGLE_LINK_YN,
             PP_AGR_YN,
             TOS_AGR_YN,
             DVC_AUTH_YN,
             EMAIL_AUTH_YN,
             JOIN_STE_CD,
             PRE_REG_YN,
             DATE_FORMAT(LATELY_CONN_TS, '%Y-%m-%d') AS LATELY_CONN_TS,
             DATE_FORMAT(REG_TS, '%Y-%m-%d') AS REG_TS
        INTO P_USR_PW,
            P_USR_NM,
            P_USR_NCKNM,
            P_USR_BIRDT,
            P_USR_SEX,
            P_EMAIL_ADDR,
            P_CELL_NO,
            P_TEL_NO,
            P_POS_NM,
            P_DUTY_NM,
            P_AVT_IMG_PATH,
            P_CPNY_NO,
            P_CPNY_MGR_YN,
            P_DPT_NO,
            P_DPT_MGR_YN,
            P_ACNT_KAKAO_LINK_YN,
            P_ACNT_GOOGLE_LINK_YN,
            P_PP_AGR_YN,
            P_TOS_AGR_YN,
            P_DVC_AUTH_YN,
            P_EMAIL_AUTH_YN,
            P_JOIN_STE_CD,
            P_PRE_REG_YN,
            P_LATELY_CONN_TS,
            P_REG_TS
        FROM SN_USR
        WHERE USR_ID = P_USR_ID;		
    
    IF P_RESULT_ID < 0 THEN
        SET P_MESSAGE ="매개변수를 확인해주시기 바랍니다.";
    END IF;

END//
DELIMITER ;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
