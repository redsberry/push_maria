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

-- 프로시저 REDSPUSH.SET_USR_INFO 구조 내보내기
DELIMITER //
CREATE DEFINER=`redspush`@`%` PROCEDURE `SET_USR_INFO`(
	IN `P_PROC_ID` VARCHAR(30),
  IN `P_USR_ID` VARCHAR(80),
  IN `P_USR_PW` VARCHAR(512),
  IN `P_USR_NM` VARCHAR(50),
  IN `P_USR_NCKNM` VARCHAR(50),
  IN `P_USR_BIRDT` VARCHAR(8),
  IN `P_USR_SEX` VARCHAR(1),
  IN `P_EMAIL_ADDR` VARCHAR(80),
  IN `P_CELL_NO` VARCHAR(20),
  IN `P_TEL_NO` VARCHAR(20),
  IN `P_POS_NM` VARCHAR(20),
  IN `P_DUTY_NM` VARCHAR(20),
  IN `P_AVT_IMG_PATH` VARCHAR(256),
  IN `P_CPNY_NM` VARCHAR(80),
  IN `P_CPNY_NO` INT(10),
  IN `P_CPNY_MGR_YN` VARCHAR(1),
  IN `P_DPT_NM` VARCHAR(80),
  IN `P_DPT_NO` INT(10),
  IN `P_DPT_MGR_YN` VARCHAR(1),
  IN `P_ACNT_KAKAO_LINK_YN` VARCHAR(1),
  IN `P_ACNT_GOOGLE_LINK_YN` VARCHAR(1),
  IN `P_PP_AGR_YN` VARCHAR(1),
  IN `P_TOS_AGR_YN` VARCHAR(1),
  IN `P_DVC_AUTH_YN` VARCHAR(1),
  IN `P_EMAIL_AUTH_YN` VARCHAR(1),
  IN `P_JOIN_STE_CD` VARCHAR(1),
  IN `P_PRE_REG_YN` VARCHAR(1),
  IN `P_SYS_YN` VARCHAR(1),
	OUT `P_RESULT_ID` INT,
	OUT `P_MESSAGE` VARCHAR(500)        
 
)
BEGIN

    SET P_RESULT_ID= -1;
    SET P_MESSAGE= "처리중 오류가 발생했습니다.";

    IF  P_PROC_ID = 'INSERT_USER_INFO' THEN
      
      # 이메일이 중복되는지 확인
      IF NOT EXISTS ( SELECT USR_ID 
                        FROM SN_USR 
                       WHERE USR_ID = P_USR_ID) THEN
       
        # 회사 정보가 있는지 체크
        IF P_CPNY_NO = '0' THEN
          IF EXISTS (SELECT CPNY_NO
                            FROM SN_COMPANY 
                           WHERE CPNY_NM = P_CPNY_NM ) THEN
            SELECT CPNY_NO
              INTO P_CPNY_NO
              FROM SN_COMPANY 
             WHERE CPNY_NM = P_CPNY_NM;
                        
          ELSE
            INSERT INTO SN_COMPANY (CPNY_NM,
                                     REG_TS)
                 VALUES (P_CPNY_NM,
                         NOW());
                         
            SELECT  AUTO_INCREMENT - 1
              INTO    P_CPNY_NO
              FROM information_schema.TABLES 
             WHERE   TABLE_SCHEMA= "REDSPUSH"
               AND     TABLE_NAME = "SN_COMPANY";     
                   
            SET P_CPNY_MGR_YN = 'Y';          

          END IF;
        END IF;
        
        # 부서 정보가 있는지 체크
        IF P_DPT_NO = '0' THEN
          IF NOT EXISTS (SELECT DPT_NO
                            FROM SN_DPT 
                           WHERE CPNY_NO = P_CPNY_NO
                             AND DPT_NM = P_DPT_NM) THEN        
             
              INSERT INTO SN_DPT (CPNY_NO,
                                   DPT_NM,
                                   REG_TS)
                   VALUES (P_CPNY_NO,
                           P_DPT_NM,
                           NOW());
                             
              SELECT  AUTO_INCREMENT - 1
                INTO    P_DPT_NO
                FROM information_schema.TABLES 
               WHERE   TABLE_SCHEMA= "REDSPUSH"
                 AND     TABLE_NAME = "SN_DPT";
                 
              SET P_DPT_MGR_YN = 'Y';
              
          ELSE
            SELECT DPT_NO
              INTO P_DPT_NO
              FROM SN_DPT 
             WHERE CPNY_NO = P_CPNY_NO
               AND DPT_NM = P_DPT_NM;
               
          END IF;
        END IF;
           
        INSERT INTO SN_USR (USR_ID,
                           USR_PW,
                           USR_NM,
                           USR_NCKNM,
                           USR_BIRDT,
                           USR_SEX,
                           EMAIL_ADDR,
                           CELL_NO,
                           CPNY_NO,
                           CPNY_MGR_YN,
                           DPT_NO,
                           DPT_MGR_YN,
                           PP_AGR_YN,
                           TOS_AGR_YN,
                           EMAIL_AUTH_YN,
                           JOIN_STE_CD,
                           PRE_REG_YN,
                           SYS_YN,
                           REG_TS)
             VALUES (P_USR_ID,
                     P_USR_PW,
                     P_USR_NM,
                     P_USR_NCKNM,
                     P_USR_BIRDT,
                     P_USR_SEX,
                     P_EMAIL_ADDR,
                     P_CELL_NO,
                     P_CPNY_NO,
                     P_CPNY_MGR_YN,
                     P_DPT_NO,
                     P_DPT_MGR_YN,
                     P_PP_AGR_YN,
                     P_TOS_AGR_YN,
                     P_EMAIL_AUTH_YN,
                     P_JOIN_STE_CD,
                     P_PRE_REG_YN,
                     P_SYS_YN,
                     NOW());           
                  
              SET P_RESULT_ID= 0;
              SET P_MESSAGE= "정상적으로 처리되었습니다.";       
            
      ELSE
        # IP 중복자가 사전 등록된 사용자라면 업데이트 함.
        IF EXISTS ( SELECT USR_ID 
                      FROM SN_USR 
                     WHERE USR_ID = P_USR_ID
                       AND USR_NM = P_USR_NM
                       AND CELL_NO = P_CELL_NO
                       AND PRE_REG_YN = 'Y') THEN
                         
                         
          # 회사 정보가 있는지 체크
          IF P_CPNY_NO = '0' THEN
            IF NOT EXISTS (SELECT CPNY_NO
                              FROM SN_COMPANY 
                             WHERE CPNY_NM = P_CPNY_NM ) THEN
            
              INSERT INTO SN_COMPANY (CPNY_NM,
                                       REG_TS)
                   VALUES (P_CPNY_NM,
                           NOW());
                           
              SELECT  AUTO_INCREMENT - 1
                INTO    P_CPNY_NO
                FROM information_schema.TABLES 
               WHERE   TABLE_SCHEMA= "REDSPUSH"
                 AND     TABLE_NAME = "SN_COMPANY";     
                     
              SET P_CPNY_MGR_YN = 'Y';
              
            ELSE
            
              SELECT CPNY_NO
                INTO P_CPNY_NO
                FROM SN_COMPANY 
               WHERE CPNY_NM = P_CPNY_NM;
               
            END IF;
          END IF;
          
          # 부서 정보가 있는지 체크
          IF P_DPT_NO = '0' THEN
            IF NOT EXISTS (SELECT DPT_NO
                              FROM SN_DPT 
                             WHERE CPNY_NO = P_CPNY_NO
                               AND DPT_NM = P_DPT_NM) THEN        
               
                INSERT INTO SN_DPT (CPNY_NO,
                                     DPT_NM,
                                     REG_TS)
                     VALUES (P_CPNY_NO,
                             P_DPT_NM,
                             NOW());
                               
                SELECT  AUTO_INCREMENT - 1
                  INTO    P_DPT_NO
                  FROM information_schema.TABLES 
                 WHERE   TABLE_SCHEMA= "REDSPUSH"
                   AND     TABLE_NAME = "SN_DPT";
                   
                SET P_DPT_MGR_YN = 'Y';
                
            ELSE
              SELECT DPT_NO
                INTO P_DPT_NO
                FROM SN_DPT 
               WHERE CPNY_NO = P_CPNY_NO
                 AND DPT_NM = P_DPT_NM;
                 
            END IF;
          END IF;
          
          UPDATE SN_USR 
             SET USR_PW = P_USR_PW,
                 USR_NM = P_USR_NM,
                 USR_NCKNM = P_USR_NCKNM,
                 USR_BIRDT = P_USR_BIRDT,
                 USR_SEX = P_USR_SEX,
                 EMAIL_ADDR = P_EMAIL_ADDR,
                 CELL_NO = P_CELL_NO,
                 CPNY_NO = P_CPNY_NO,
                 CPNY_MGR_YN = P_CPNY_MGR_YN,
                 DPT_NO = P_DPT_NO,
                 DPT_MGR_YN = P_DPT_MGR_YN,
                 PP_AGR_YN = P_PP_AGR_YN,
                 TOS_AGR_YN = P_TOS_AGR_YN,
                 EMAIL_AUTH_YN = P_EMAIL_AUTH_YN,
                 JOIN_STE_CD = P_JOIN_STE_CD,
                 PRE_REG_YN = P_PRE_REG_YN,
                 SYS_YN = P_SYS_YN,
                 UPD_TS = NOW()
          WHERE USR_ID = P_USR_ID;
          
          SET P_RESULT_ID= -3;
          SET P_MESSAGE= "사전등록된 사용자로 정상적으로 처리되었습니다.";
          
        ELSE
                       
              SET P_RESULT_ID = -2;
              SET P_MESSAGE= "이미 존재하는 이메일입니다.";
        END IF;
        
      END IF;
      
    ELSEIF  P_PROC_ID = 'UPDATE_USER_INFO' THEN
    
      IF P_USR_PW != NULL OR P_USR_PW != '' THEN
      
        UPDATE SN_USR 
        SET  USR_PW = P_USR_PW, 
             USR_NM = P_USR_NM, 
             USR_NCKNM = P_USR_NCKNM, 
             USR_BIRDT = P_USR_BIRDT, 
             USR_SEX = P_USR_SEX, 
             EMAIL_ADDR = P_EMAIL_ADDR, 
             CELL_NO = P_CELL_NO, 
             TEL_NO = P_TEL_NO, 
             POS_NM = P_POS_NM, 
             DUTY_NM = P_DUTY_NM, 
             CPNY_NO = P_CPNY_NO, 
             CPNY_MGR_YN = P_CPNY_MGR_YN, 
             DPT_NO = P_DPT_NO, 
             DPT_MGR_YN = P_DPT_MGR_YN,
             JOIN_STE_CD = P_JOIN_STE_CD,
             UPD_TS = NOW()
        WHERE USR_ID = P_USR_ID;

        SET P_RESULT_ID= 0;
        SET P_MESSAGE= "정상적으로 처리되었습니다."; 
        
      ELSE
      
        UPDATE SN_USR 
        SET  USR_NM = P_USR_NM, 
             USR_NCKNM = P_USR_NCKNM, 
             USR_BIRDT = P_USR_BIRDT, 
             USR_SEX = P_USR_SEX, 
             EMAIL_ADDR = P_EMAIL_ADDR, 
             CELL_NO = P_CELL_NO, 
             TEL_NO = P_TEL_NO, 
             POS_NM = P_POS_NM, 
             DUTY_NM = P_DUTY_NM, 
             CPNY_NO = P_CPNY_NO, 
             CPNY_MGR_YN = P_CPNY_MGR_YN, 
             DPT_NO = P_DPT_NO, 
             DPT_MGR_YN = P_DPT_MGR_YN,
             JOIN_STE_CD = P_JOIN_STE_CD,
             UPD_TS = NOW()
        WHERE USR_ID = P_USR_ID;
      
        SET P_RESULT_ID= 0;
        SET P_MESSAGE= "정상적으로 처리되었습니다."; 
      END IF;
      
      /* 사용자 상태가 탈퇴일경우 디바이스의 사용여부도 'N'으로 수정*/
      IF P_JOIN_STE_CD = 'D' THEN      
        UPDATE SN_DEVICE
           SET DVC_USE_YN = 'N'
         WHERE USR_ID = P_USR_ID;
      END IF;
      
    END IF;  
END//
DELIMITER ;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
