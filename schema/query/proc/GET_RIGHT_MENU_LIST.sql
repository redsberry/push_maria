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

-- 프로시저 REDSPUSH.GET_RIGHT_MENU_LIST 구조 내보내기
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `GET_RIGHT_MENU_LIST`(
	IN `P_PROC_ID` VARCHAR(30)     ,
  IN `P_RIGHT_ID` VARCHAR(30)     ,
	OUT `P_MENU_CNT` INT             ,
	OUT `P_RESULT_ID` INT             ,
	OUT `P_MESSAGE` TINYTEXT        
)
BEGIN
    SET P_RESULT_ID    = 0;
    SET P_MESSAGE    = "정상적으로 처리되었습니다.";

    IF  P_PROC_ID = 'GET_RIGHT_MENU_LIST' THEN

        SELECT COUNT(1)
          INTO P_MENU_CNT
          FROM SN_MENU;            

        SELECT A.MNU_CD AS MNU_CD,
               A.MNU_NM AS MNU_NM,
               A.MNU_PATH AS MNU_PATH,
               A.MNU_ORD AS MNU_ORD,
               A.MNU_DEPTH AS MNU_DEPTH,
               A.MNU_GRP_YN AS MNU_GRP_CD,
               A.UP_MNU_CD AS UP_MNU_CD,
               A.USE_YN AS USE_YN,
               (SELECT COUNT(B.MNU_CD)  FROM SN_MENU B WHERE SUBSTR(B.MNU_CD, 1, 3) = SUBSTR(A.MNU_CD, 1, 3)) GRP_CNT
          FROM SN_MENU A;
          
          SELECT B.RIG_GRP_CD AS RIG_GRP_CD,
                 A.MNU_CD AS MNU_CD,
                 A.MNU_NM AS MNU_NM,
                 A.UP_MNU_CD AS UP_MNU_CD,
                 B.REA_RIG_YN,
                 B.UPD_RIG_YN,
                 B.CRE_RIG_YN,
                 B.DEL_RIG_YN,
                 B.PRT_RIG_YN
            FROM SN_MENUGRP B, SN_MENU A
            WHERE B.MNU_CD = A.MNU_CD
              AND B.RIG_GRP_CD = P_RIGHT_ID;
          
          
    ELSE
        SET P_RESULT_ID= -1;
        SET P_MESSAGE= "매개변수를 확인해주시기 바랍니다.";
    END IF;    
END//
DELIMITER ;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
