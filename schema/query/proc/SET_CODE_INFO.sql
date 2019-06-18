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

-- 프로시저 REDSPUSH.SET_CODE_INFO 구조 내보내기
DELIMITER //
CREATE DEFINER=`redspush`@`%` PROCEDURE `SET_CODE_INFO`(
	IN `P_PROC_ID` VARCHAR(30)    ,
  IN `P_CMN_CD_NM` VARCHAR(200)     ,
  IN `P_CMN_CD_ABB` VARCHAR(200)     ,
  IN `P_CMN_CD_ANO` VARCHAR(200)     ,
  IN `P_CMN_REL_CD` VARCHAR(30)     ,
	IN `P_USE_YN` VARCHAR(1)      ,
  IN `P_REMARK` VARCHAR(200)    ,
  IN `P_UPR_ID` VARCHAR(12)     ,
  IN `P_CD_CLS` VARCHAR(3)      ,
  INOUT `P_CMN_CD` VARCHAR(200)     ,
	OUT `P_RESULT_ID` INT         ,
	OUT `P_MESSAGE` TINYTEXT        
)
BEGIN
    SET P_RESULT_ID= -1;
    SET P_MESSAGE= "처리중 오류가 발생했습니다.";

    IF  P_PROC_ID = 'CODE_INSERT' THEN
    
      INSERT INTO SN_CODE (CD_CLS,
                           CMN_CD,
                           CMN_CD_NM,
                           CMN_CD_ABB,
                           CMN_CD_ANO,
                           CMN_REL_CD,
                           USE_YN,
                           REMARK,
                           UPR_ID)
           VALUES (P_CD_CLS,
                  (select (CASE COALESCE(CMN_CD, '')
                    WHEN '' THEN LPAD('1', 5,'0')
                    ELSE LPAD( MAX(CMN_CD) + 1, 5, '0')
                    END) from SN_CODE ALIAS_FOR_SUBQUERY WHERE CD_CLS = P_CD_CLS),
                  P_CMN_CD_NM,
                  P_CMN_CD_ABB,
                  P_CMN_CD_ANO,
                  P_CMN_REL_CD,
                  P_USE_YN,
                  P_REMARK,
                  P_UPR_ID); 
              
            SET P_RESULT_ID= 0;
            SET P_MESSAGE= "정상적으로 처리되었습니다.";   
            
    ELSEIF  P_PROC_ID = 'CODE_UPDATE' THEN
        UPDATE SN_CODE
           SET CMN_CD_NM = P_CMN_CD_NM,
               CMN_CD_ABB = P_CMN_CD_ABB,
               CMN_CD_ANO = P_CMN_CD_ANO,
               CMN_REL_CD = P_CMN_REL_CD,           
               USE_YN = P_USE_YN,
               REMARK = P_REMARK
         WHERE CMN_CD = P_CMN_CD;        
         
        SET P_RESULT_ID= 0;
        SET P_MESSAGE= "정상적으로 처리되었습니다.";    
        
    ELSEIF  P_PROC_ID = 'CODE_DELETE' THEN
        DELETE FROM SN_CODE
         WHERE FIND_IN_SET(CMN_CD, P_CMN_CD);

        SET P_RESULT_ID= 0;
        SET P_MESSAGE= "정상적으로 처리되었습니다.";             
    END IF;

END//
DELIMITER ;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
