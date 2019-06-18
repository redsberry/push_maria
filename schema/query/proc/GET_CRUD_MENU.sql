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

-- 프로시저 REDSPUSH.GET_CRUD_MENU 구조 내보내기
DELIMITER //
CREATE DEFINER=`redspush`@`%` PROCEDURE `GET_CRUD_MENU`(
    IN  `P_RIGHT_ID` VARCHAR(3),             
    IN  `P_MENU_ID` VARCHAR(5),             
    OUT `P_RESULT_ID` INT             ,
    OUT `P_MESSAGE` TINYTEXT        
 
)
BEGIN

    SET P_RESULT_ID= 0;
    SET P_MESSAGE= "정상적으로 처리되었습니다.";
    
    SELECT  REA_RIG_YN,
            UPD_RIG_YN,
            CRE_RIG_YN,
            DEL_RIG_YN,
            PRT_RIG_YN,
            (CASE SUBSTRING(P_MENU_ID, 1, 3) WHEN 'BBS' THEN (SELECT ANS_ENA_YN FROM BD_MANAGE WHERE BRD_CD = P_MENU_ID )
              ELSE ''
              END) AS ANS_ENA_YN,
            (CASE SUBSTRING(P_MENU_ID, 1, 3) WHEN 'BBS' THEN (SELECT RPY_ENA_YN FROM BD_MANAGE WHERE BRD_CD = P_MENU_ID )
              ELSE ''
              END) AS RPY_ENA_YN,
            (SELECT MNU_NM FROM SN_MENU WHERE SN_MENU.MNU_CD = P_MENU_ID) AS MNU_NM  
      FROM SN_MENUGRP
     WHERE RIG_GRP_CD = P_RIGHT_ID
       AND MNU_CD = P_MENU_ID;
     
END//
DELIMITER ;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
