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

-- 프로시저 REDSPUSH.SET_MENU_INFO 구조 내보내기
DELIMITER //
CREATE DEFINER=`redspush`@`%` PROCEDURE `SET_MENU_INFO`(
  IN `P_PROC_ID` VARCHAR(30)     ,
  IN `P_MNU_CD` VARCHAR(30)     ,
  IN `P_MNU_NM` VARCHAR(30)     ,
  IN `P_MNU_PATH` VARCHAR(30)     ,
  IN `P_MNU_ORD` VARCHAR(30)     ,
  IN `P_MNU_DEPTH` VARCHAR(30)     ,
  IN `P_MNU_GRP_YN` VARCHAR(30)     ,
  IN `P_UP_MNU_CD` VARCHAR(30)     ,
  IN `P_USE_YN` VARCHAR(2)      ,
  OUT `P_RESULT_ID` INT             ,
  OUT `P_MESSAGE` TINYTEXT        

)
BEGIN
    
    SET P_RESULT_ID    = 0;
    SET P_MESSAGE    = "정상적으로 처리되었습니다.";

    IF  P_PROC_ID = 'MENU_INSERT' THEN
        IF P_MNU_CD = '' THEN
          SELECT CONCAT(SUBSTRING(P_UP_MNU_CD, 1, 3), 
                (LPAD((CASE COALESCE(MNU_CD, '') WHEN '' THEN '1'
                       ELSE SUBSTRING(MAX(MNU_CD), -2) + 1
                       END), 2, '0'))) INTO P_MNU_CD
            FROM SN_MENU
          WHERE UP_MNU_CD = P_UP_MNU_CD;
        END IF;


        INSERT INTO SN_MENU (MNU_CD,
                           MNU_NM,
                           MNU_PATH,
                           MNU_ORD,
                           MNU_DEPTH,
                           MNU_GRP_YN,
                           UP_MNU_CD,
                           USE_YN)
             VALUES (P_MNU_CD,
                     P_MNU_NM,
                     P_MNU_PATH,
                     P_MNU_ORD,
                     P_MNU_DEPTH,
                     P_MNU_GRP_YN,
                     P_UP_MNU_CD,
                     P_USE_YN);

    ELSEIF  P_PROC_ID = 'MENU_UPDATE' THEN
    
        UPDATE SN_MENU
           SET MNU_NM = P_MNU_NM,
               MNU_PATH = P_MNU_PATH,
               MNU_ORD = P_MNU_ORD,
               MNU_DEPTH = P_MNU_DEPTH,
               UP_MNU_CD = P_UP_MNU_CD,
               USE_YN = P_USE_YN
         WHERE MNU_CD = P_MNU_CD;    
         
    ELSEIF  P_PROC_ID = 'MENU_DELETE' THEN
    
        DELETE FROM SN_MENU
         
         WHERE FIND_IN_SET(MNU_CD, P_MNU_CD)
               OR FIND_IN_SET(UP_MNU_CD, P_MNU_CD);
      
         
    ELSE
        SET P_RESULT_ID= -1;
        SET P_MESSAGE= "매개변수를 확인해주시기 바랍니다.";
    END IF;    
END//
DELIMITER ;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
