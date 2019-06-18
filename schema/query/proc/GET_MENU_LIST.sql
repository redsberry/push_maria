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

-- 프로시저 REDSPUSH.GET_MENU_LIST 구조 내보내기
DELIMITER //
CREATE DEFINER=`redspush`@`%` PROCEDURE `GET_MENU_LIST`(
	IN `P_PROC_ID` VARCHAR(30)     ,
  IN `P_USR_ID` VARCHAR(30)     ,
	OUT `P_MENU_CNT` INT             ,
	OUT `P_SUB_CNT` INT             ,
	OUT `P_RESULT_ID` INT             ,
	OUT `P_MESSAGE` TINYTEXT        
 
)
BEGIN
    SET P_RESULT_ID= 0;
    SET P_MESSAGE= "정상적으로 처리되었습니다.";

    IF  P_PROC_ID = 'GET_MENU_LIST' THEN       
        SELECT COUNT(MNU_CD) INTO P_MENU_CNT
          FROM SN_MENU
         WHERE USE_YN='Y'
           AND UP_MNU_CD = '00000';

        SELECT * FROM SN_MENU
         WHERE USE_YN='Y'
           AND UP_MNU_CD = '00000'
         ORDER BY MNU_ORD;

        SELECT COUNT(MNU_CD) INTO P_SUB_CNT
          FROM SN_MENU
         WHERE UP_MNU_CD != '00000';

        SELECT * FROM SN_MENU
         WHERE UP_MNU_CD != '00000'
         ORDER BY MNU_CD, MNU_ORD;
         
      ELSEIF  P_PROC_ID = 'GET_USER_MENU_LIST' THEN       
        SELECT COUNT(1) INTO P_MENU_CNT
          FROM (
					        SELECT (SELECT COUNT(MNU_CD) FROM SN_MENU WHERE MNU_CD = CONCAT(SUBSTRING(M.MNU_CD, 1, 3), '00') AND UP_MNU_CD = '00000') AS MNU_CD,
					               (SELECT MNU_NM FROM SN_MENU WHERE MNU_CD = CONCAT(SUBSTRING(M.MNU_CD, 1, 3), '00') AND UP_MNU_CD = '00000') AS MNU_NM,
					               (SELECT MNU_ORD FROM SN_MENU WHERE MNU_CD = CONCAT(SUBSTRING(M.MNU_CD, 1, 3), '00') AND UP_MNU_CD = '00000') AS MNU_ORD,
					               (SELECT MNU_PATH FROM SN_MENU WHERE MNU_CD = CONCAT(SUBSTRING(M.MNU_CD, 1, 3), '00') AND UP_MNU_CD = '00000') AS MNU_PATH,
					               (SELECT UP_MNU_CD FROM SN_MENU WHERE MNU_CD = CONCAT(SUBSTRING(M.MNU_CD, 1, 3), '00') AND UP_MNU_CD = '00000') AS UP_MNU_CD
					        FROM (
					        SELECT R.MNU_CD, 
					               IF(SIGN(R.REA_RIG)=1, 'Y', 'N') AS REA,
					               IF(SIGN(R.UPD_RIG)=1, 'Y', 'N') AS UPD,
					               IF(SIGN(R.CRE_RIG)=1, 'Y', 'N') AS CRE,
					               IF(SIGN(R.DEL_RIG)=1, 'Y', 'N') AS DEL,
					               IF(SIGN(R.PRT_RIG)=1, 'Y', 'N') AS PRT  
					          FROM ( SELECT C.MNU_CD,
					        			       SUM(IF(C.REA_RIG_YN='Y', 1, 0)) AS REA_RIG,
					        			       SUM(IF(C.UPD_RIG_YN='Y', 1, 0)) AS UPD_RIG,
					        			       SUM(IF(C.CRE_RIG_YN='Y', 1, 0)) AS CRE_RIG,
					        			       SUM(IF(C.DEL_RIG_YN='Y', 1, 0)) AS DEL_RIG,
					        			       SUM(IF(C.PRT_RIG_YN='Y', 1, 0)) AS PRT_RIG
					        			  FROM SN_USR A, 
					        			       SN_RIGHT B,
					        			       SN_MENUGRP C       
					        			 WHERE A.USR_ID = B.USR_ID
					        			   AND B.RIG_GRP_CD = C.RIG_GRP_CD
					        				AND B.USE_YN = 'Y' 
					        				AND A.USR_ID = P_USR_ID
					               GROUP BY A.USR_ID, C.MNU_CD) R
					          WHERE R.REA_RIG + R.UPD_RIG + R.CRE_RIG + R.DEL_RIG + R.PRT_RIG > 0 ) T,
					          SN_MENU M
					          WHERE T.MNU_CD = M.MNU_CD
					          GROUP BY M.UP_MNU_CD
					          ORDER BY MNU_ORD, M.UP_MNU_CD
					     ) A;

        SELECT (SELECT MNU_CD FROM SN_MENU WHERE MNU_CD = CONCAT(SUBSTRING(M.MNU_CD, 1, 3), '00') AND UP_MNU_CD = '00000') AS MNU_CD,
               (SELECT MNU_NM FROM SN_MENU WHERE MNU_CD = CONCAT(SUBSTRING(M.MNU_CD, 1, 3), '00') AND UP_MNU_CD = '00000') AS MNU_NM,
               (SELECT MNU_ORD FROM SN_MENU WHERE MNU_CD = CONCAT(SUBSTRING(M.MNU_CD, 1, 3), '00') AND UP_MNU_CD = '00000') AS MNU_ORD,
               (SELECT MNU_PATH FROM SN_MENU WHERE MNU_CD = CONCAT(SUBSTRING(M.MNU_CD, 1, 3), '00') AND UP_MNU_CD = '00000') AS MNU_PATH,
               (SELECT UP_MNU_CD FROM SN_MENU WHERE MNU_CD = CONCAT(SUBSTRING(M.MNU_CD, 1, 3), '00') AND UP_MNU_CD = '00000') AS UP_MNU_CD
        FROM (
              SELECT R.MNU_CD, 
                     IF(SIGN(R.REA_RIG)=1, 'Y', 'N') AS REA,
                     IF(SIGN(R.UPD_RIG)=1, 'Y', 'N') AS UPD,
                     IF(SIGN(R.CRE_RIG)=1, 'Y', 'N') AS CRE,
                     IF(SIGN(R.DEL_RIG)=1, 'Y', 'N') AS DEL,
                     IF(SIGN(R.PRT_RIG)=1, 'Y', 'N') AS PRT  
                FROM ( SELECT C.MNU_CD,
              			       SUM(IF(C.REA_RIG_YN='Y', 1, 0)) AS REA_RIG,
              			       SUM(IF(C.UPD_RIG_YN='Y', 1, 0)) AS UPD_RIG,
              			       SUM(IF(C.CRE_RIG_YN='Y', 1, 0)) AS CRE_RIG,
              			       SUM(IF(C.DEL_RIG_YN='Y', 1, 0)) AS DEL_RIG,
              			       SUM(IF(C.PRT_RIG_YN='Y', 1, 0)) AS PRT_RIG
              			  FROM SN_USR A, 
              			       SN_RIGHT B,
              			       SN_MENUGRP C       
              			 WHERE A.USR_ID = B.USR_ID
              			   AND B.RIG_GRP_CD = C.RIG_GRP_CD
              				AND B.USE_YN = 'Y' 
              				AND A.USR_ID = P_USR_ID
                     GROUP BY A.USR_ID, C.MNU_CD) R
                WHERE R.REA_RIG + R.UPD_RIG + R.CRE_RIG + R.DEL_RIG + R.PRT_RIG > 0 
                ) T,
                SN_MENU M
          WHERE T.MNU_CD = M.MNU_CD
          GROUP BY M.UP_MNU_CD
          ORDER BY MNU_ORD, M.UP_MNU_CD;

        SELECT COUNT(1) INTO P_SUB_CNT
          FROM (
                SELECT R.MNU_CD, 
                       IF(SIGN(R.REA_RIG)=1, 'Y', 'N') AS REA,
                       IF(SIGN(R.UPD_RIG)=1, 'Y', 'N') AS UPD,
                       IF(SIGN(R.CRE_RIG)=1, 'Y', 'N') AS CRE,
                       IF(SIGN(R.DEL_RIG)=1, 'Y', 'N') AS DEL,
                       IF(SIGN(R.PRT_RIG)=1, 'Y', 'N') AS PRT  
                  FROM ( SELECT C.MNU_CD,
                			       SUM(IF(C.REA_RIG_YN='Y', 1, 0)) AS REA_RIG,
                			       SUM(IF(C.UPD_RIG_YN='Y', 1, 0)) AS UPD_RIG,
                			       SUM(IF(C.CRE_RIG_YN='Y', 1, 0)) AS CRE_RIG,
                			       SUM(IF(C.DEL_RIG_YN='Y', 1, 0)) AS DEL_RIG,
                			       SUM(IF(C.PRT_RIG_YN='Y', 1, 0)) AS PRT_RIG
                			  FROM SN_USR A, 
                			       SN_RIGHT B,
                			       SN_MENUGRP C       
                			 WHERE A.USR_ID = B.USR_ID
                			   AND B.RIG_GRP_CD = C.RIG_GRP_CD
                				AND B.USE_YN = 'Y' 
                				AND A.USR_ID = P_USR_ID
                       GROUP BY A.USR_ID, C.MNU_CD) R
                  WHERE R.REA_RIG + R.UPD_RIG + R.CRE_RIG + R.DEL_RIG + R.PRT_RIG > 0
                 ) A ;

        SELECT T.MNU_CD,
        		 M.MNU_NM,
        		 M.MNU_PATH,	
             M.UP_MNU_CD,
        		 T.REA,
        		 T.UPD,
        		 T.CRE,
        		 T.DEL,
        		 T.PRT
          FROM (
        		  SELECT R.MNU_CD, 
                       IF(SIGN(R.REA_RIG)=1, 'Y', 'N') AS REA,
                       IF(SIGN(R.UPD_RIG)=1, 'Y', 'N') AS UPD,
                       IF(SIGN(R.CRE_RIG)=1, 'Y', 'N') AS CRE,
                       IF(SIGN(R.DEL_RIG)=1, 'Y', 'N') AS DEL,
                       IF(SIGN(R.PRT_RIG)=1, 'Y', 'N') AS PRT  
                  FROM ( SELECT C.MNU_CD,
                			       SUM(IF(C.REA_RIG_YN='Y', 1, 0)) AS REA_RIG,
                			       SUM(IF(C.UPD_RIG_YN='Y', 1, 0)) AS UPD_RIG,
                			       SUM(IF(C.CRE_RIG_YN='Y', 1, 0)) AS CRE_RIG,
                			       SUM(IF(C.DEL_RIG_YN='Y', 1, 0)) AS DEL_RIG,
                			       SUM(IF(C.PRT_RIG_YN='Y', 1, 0)) AS PRT_RIG
                			  FROM SN_USR A, 
                			       SN_RIGHT B,
                			       SN_MENUGRP C       
                			 WHERE A.USR_ID = B.USR_ID
                			   AND B.RIG_GRP_CD = C.RIG_GRP_CD
                				AND B.USE_YN = 'Y' 
                				AND A.USR_ID = P_USR_ID
                       GROUP BY A.USR_ID, C.MNU_CD) R
                  WHERE R.REA_RIG + R.UPD_RIG + R.CRE_RIG + R.DEL_RIG + R.PRT_RIG > 0
                  )T,
                  SN_MENU M
         WHERE T.MNU_CD = M.MNU_CD;
    ELSEIF  P_PROC_ID = 'GET_USER_LINK_LIST' THEN         
        SELECT T.MNU_CD,
        		 M.MNU_NM,
        		 M.MNU_PATH,	
             M.UP_MNU_CD,
        		 T.REA,
        		 T.UPD,
        		 T.CRE,
        		 T.DEL,
        		 T.PRT
          FROM (
        		  SELECT R.MNU_CD, 
                       IF(SIGN(R.REA_RIG)=1, 'Y', 'N') AS REA,
                       IF(SIGN(R.UPD_RIG)=1, 'Y', 'N') AS UPD,
                       IF(SIGN(R.CRE_RIG)=1, 'Y', 'N') AS CRE,
                       IF(SIGN(R.DEL_RIG)=1, 'Y', 'N') AS DEL,
                       IF(SIGN(R.PRT_RIG)=1, 'Y', 'N') AS PRT  
                  FROM ( SELECT C.MNU_CD,
                			       SUM(IF(C.REA_RIG_YN='Y', 1, 0)) AS REA_RIG,
                			       SUM(IF(C.UPD_RIG_YN='Y', 1, 0)) AS UPD_RIG,
                			       SUM(IF(C.CRE_RIG_YN='Y', 1, 0)) AS CRE_RIG,
                			       SUM(IF(C.DEL_RIG_YN='Y', 1, 0)) AS DEL_RIG,
                			       SUM(IF(C.PRT_RIG_YN='Y', 1, 0)) AS PRT_RIG
                			  FROM SN_USR A, 
                			       SN_RIGHT B,
                			       SN_MENUGRP C       
                			 WHERE A.USR_ID = B.USR_ID
                			   AND B.RIG_GRP_CD = C.RIG_GRP_CD
                				AND B.USE_YN = 'Y' 
                				AND A.USR_ID = P_USR_ID
                        AND C.MNU_CD IN ('DAT01', 'CER01', 'STA01', 'DAT07')
                       GROUP BY A.USR_ID, C.MNU_CD) R
                  WHERE R.REA_RIG + R.UPD_RIG + R.CRE_RIG + R.DEL_RIG + R.PRT_RIG > 0
                  )T,
                  SN_MENU M
         WHERE T.MNU_CD = M.MNU_CD;
         
        SELECT T.MNU_CD,
        		 M.MNU_NM,
        		 M.MNU_PATH,	
             M.UP_MNU_CD,
        		 T.REA,
        		 T.UPD,
        		 T.CRE,
        		 T.DEL,
        		 T.PRT
          FROM (
        		  SELECT R.MNU_CD, 
                       IF(SIGN(R.REA_RIG)=1, 'Y', 'N') AS REA,
                       IF(SIGN(R.UPD_RIG)=1, 'Y', 'N') AS UPD,
                       IF(SIGN(R.CRE_RIG)=1, 'Y', 'N') AS CRE,
                       IF(SIGN(R.DEL_RIG)=1, 'Y', 'N') AS DEL,
                       IF(SIGN(R.PRT_RIG)=1, 'Y', 'N') AS PRT  
                  FROM ( SELECT C.MNU_CD,
                			       SUM(IF(C.REA_RIG_YN='Y', 1, 0)) AS REA_RIG,
                			       SUM(IF(C.UPD_RIG_YN='Y', 1, 0)) AS UPD_RIG,
                			       SUM(IF(C.CRE_RIG_YN='Y', 1, 0)) AS CRE_RIG,
                			       SUM(IF(C.DEL_RIG_YN='Y', 1, 0)) AS DEL_RIG,
                			       SUM(IF(C.PRT_RIG_YN='Y', 1, 0)) AS PRT_RIG
                			  FROM SN_USR A, 
                			       SN_RIGHT B,
                			       SN_MENUGRP C       
                			 WHERE A.USR_ID = B.USR_ID
                			   AND B.RIG_GRP_CD = C.RIG_GRP_CD
                				AND B.USE_YN = 'Y' 
                				AND A.USR_ID = P_USR_ID
                       GROUP BY A.USR_ID, C.MNU_CD) R
                  WHERE R.REA_RIG + R.UPD_RIG + R.CRE_RIG + R.DEL_RIG + R.PRT_RIG > 0
                  )T,
                  SN_MENU M
         WHERE T.MNU_CD = M.MNU_CD;         

    END IF;

END//
DELIMITER ;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
