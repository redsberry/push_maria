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

-- 프로시저 REDSPUSH.SET_CODECAT_INFO 구조 내보내기
DELIMITER //
CREATE DEFINER=`redspush`@`%` PROCEDURE `SET_CODECAT_INFO`(
	IN `P_PROC_ID` VARCHAR(30)     ,
  IN `P_CD_CLS_NM` VARCHAR(60)     ,
	IN `P_USE_YN` VARCHAR(1)             ,
  IN `P_REMARK` VARCHAR(200)             ,
  IN `P_UPR_ID` VARCHAR(12)     ,
  INOUT `P_CD_CLS` VARCHAR(200)             ,
	OUT `P_RESULT_ID` INT             ,
	OUT `P_MESSAGE` TINYTEXT        
)
BEGIN
    SET P_RESULT_ID= -1;
    SET P_MESSAGE= "처리중 오류가 발생했습니다.";

    IF  P_PROC_ID = 'CODECAT_INSERT' THEN
    
      IF NOT EXISTS ( SELECT  CD_CLS
					    FROM    SN_CODECAT
					    WHERE   CD_CLS	= P_CD_CLS) THEN

        INSERT INTO SN_CODECAT (CD_CLS,
                                CD_CLS_NM,
                                USE_YN,
                                REMARK,
                                UPR_ID)
             VALUES (P_CD_CLS,
                     P_CD_CLS_NM,
                     P_USE_YN,
                     P_REMARK,
                     P_UPR_ID); 
                
              SET P_RESULT_ID= 0;
              SET P_MESSAGE= "정상적으로 처리되었습니다.";   
              
      ELSE
      	SET P_RESULT_ID	= -2;
		    SET P_MESSAGE	= "동일한 코드명이 존재합니다.";
      END IF;
            
    ELSEIF  P_PROC_ID = 'CODECAT_UPDATE' THEN
        UPDATE SN_CODECAT
           SET CD_CLS = P_CD_CLS,
               CD_CLS_NM = P_CD_CLS_NM,
               USE_YN = P_USE_YN,
               REMARK = P_REMARK
         WHERE CD_CLS = P_CD_CLS;        
         
        SET P_RESULT_ID= 0;
        SET P_MESSAGE= "정상적으로 처리되었습니다.";    
        
    ELSEIF  P_PROC_ID = 'CODECAT_DELETE' THEN
        DELETE FROM SN_CODECAT
         WHERE FIND_IN_SET(CD_CLS, P_CD_CLS);
        
        DELETE FROM SN_CODE
         WHERE CD_CLS = P_CD_CLS;

        SET P_RESULT_ID= 0;
        SET P_MESSAGE= "정상적으로 처리되었습니다.";             
    END IF;

END//
DELIMITER ;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
