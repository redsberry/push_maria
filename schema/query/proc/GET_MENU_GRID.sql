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

-- 프로시저 REDSPUSH.GET_MENU_GRID 구조 내보내기
DELIMITER //
CREATE DEFINER=`redspush`@`%` PROCEDURE `GET_MENU_GRID`(
  IN `P_PROC_ID` VARCHAR(30)     ,
  IN `P_START_NO` INT            ,
  IN `P_PAGE_NO` INT             ,
  OUT `P_MENU_CNT` INT             ,
  OUT `P_SUB_CNT` INT             ,
  OUT `P_RESULT_ID` INT             ,
  OUT `P_MESSAGE` TINYTEXT        
 
)
BEGIN
    SET P_RESULT_ID= 0;
    SET P_MESSAGE= "정상적으로 처리되었습니다.";

    IF  P_PROC_ID = 'GET_MENU_GRID' THEN
    
        SET @EXEC_ST  = P_START_NO;
        SET @EXEC_CNT  = P_PAGE_NO;            
        SET @ROWNUM =P_START_NO;

        SELECT COUNT(MNU_CD) INTO P_MENU_CNT
          FROM SN_MENU
         WHERE UP_MNU_CD = '00000';

        SELECT '/images/common/menu3.png' AS EDIT,
              MNU_CD,
              MNU_NM,
              MNU_PATH,
              MNU_ORD,
              MNU_DEPTH,
              MNU_GRP_YN,
              UP_MNU_CD,
              USE_YN 
        FROM SN_MENU
         WHERE UP_MNU_CD = '00000'
         ORDER BY MNU_ORD;

        SELECT COUNT(MNU_CD) INTO P_SUB_CNT
          FROM SN_MENU
         WHERE UP_MNU_CD != '00000';

        SELECT '/images/common/menu3.png' AS EDIT,
              MNU_CD,
              MNU_NM,
              MNU_PATH,
              MNU_ORD,
              MNU_DEPTH,
              MNU_GRP_YN,
              UP_MNU_CD,
              USE_YN 
        FROM SN_MENU
         WHERE UP_MNU_CD != '00000'
         ORDER BY MNU_CD, MNU_ORD;
    END IF;

END//
DELIMITER ;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
