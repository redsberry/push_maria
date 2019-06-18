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

-- 프로시저 REDSPUSH.SET_APVL_INFO 구조 내보내기
DELIMITER //
CREATE DEFINER=`redspush`@`%` PROCEDURE `SET_APVL_INFO`(
	IN `P_PROC_ID` VARCHAR(30)    ,
	IN `P_APVL_YN` VARCHAR(1)      ,
  IN `P_USER_ID` VARCHAR(200)     ,
	OUT `P_RESULT_ID` INT         ,
	OUT `P_MESSAGE` TINYTEXT        
)
BEGIN
  SET P_RESULT_ID= -1;
  SET P_MESSAGE= "처리중 오류가 발생했습니다.";
      
  IF  P_PROC_ID = 'APVL_UPDATE' THEN
  
    IF P_APVL_YN = 'N' THEN
     
      UPDATE SN_USER
         SET APVL_YN = NULL,
             USE_YN = NULL,
             USE_ENA_TS = NULL
       WHERE USER_ID = P_USER_ID; 
       
       
       DELETE FROM SN_RIGHT
        WHERE USER_ID = P_USER_ID;
        
      SET P_RESULT_ID= 0;
      SET P_MESSAGE= "정상적으로 처리되었습니다.";
      
    ELSEIF P_APVL_YN = 'R' THEN
      
      UPDATE SN_USER
         SET APVL_YN = P_APVL_YN,
             USE_ENA_TS = NULL
       WHERE USER_ID = P_USER_ID;      
       
      SET P_RESULT_ID= 0;
      SET P_MESSAGE= "정상적으로 처리되었습니다.";
      
    ELSEIF P_APVL_YN = 'E' THEN
      
      UPDATE SN_USER
         SET APVL_YN = P_APVL_YN
       WHERE USER_ID = P_USER_ID;      
       
      SET P_RESULT_ID= 0;
      SET P_MESSAGE= "정상적으로 처리되었습니다.";
      
    ELSE
      
      UPDATE SN_USER
         SET APVL_YN = P_APVL_YN,
             USE_YN = 'Y',
             USE_ENA_TS = DATE_ADD(NOW(), INTERVAL + 1 YEAR)
       WHERE USER_ID = P_USER_ID;        
       
      SET P_RESULT_ID= 0;
      SET P_MESSAGE= "정상적으로 처리되었습니다.";    
    
    END IF;

  END IF;
        
END//
DELIMITER ;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
