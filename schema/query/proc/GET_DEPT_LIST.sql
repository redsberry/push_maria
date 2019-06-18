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

-- 프로시저 REDSPUSH.GET_DEPT_LIST 구조 내보내기
DELIMITER //
CREATE DEFINER=`redspush`@`%` PROCEDURE `GET_DEPT_LIST`(
    IN `P_PROC_ID` VARCHAR(30)     ,
    IN `P_DPT_CD` VARCHAR(30)     ,
    IN `P_START_NO` INT            ,
    IN `P_PAGE_NO` INT             ,
    OUT `P_DEPT_CNT` INT             ,
    OUT `P_RESULT_ID` INT             ,
    OUT `P_MESSAGE` TINYTEXT        
 
)
BEGIN
    DECLARE V_COL   TEXT;
    
    SET P_RESULT_ID= 0;
    SET P_MESSAGE= "정상적으로 처리되었습니다.";
    IF  P_PROC_ID = 'GET_DEPT_INFO_LIST' THEN       

        SELECT COUNT(DPT_CD) INTO P_DEPT_CNT
          FROM SN_DPT
         WHERE USE_YN='Y';

        SELECT 
          R.DPT_CD,
          R.DPT_NM,
          R.DPT_ALL_NM,
          R.DPT_ORDER,
          R.UP_DPT_CD,
          R.BLG_PA_CD,
          R.BLG_PS_CD,
          R.PANS_DIRBL_TYPE,
          R.USE_YN
        FROM SN_DPT R
        WHERE R.USE_YN='Y'
        ORDER BY DPT_CD;
        
        
    ELSEIF  P_PROC_ID = 'GET_STAMP_ALL_INFO_LIST' THEN       

        SELECT COUNT(DPT_CD) INTO P_DEPT_CNT
          FROM SN_DPT R
          WHERE 
                R.USE_YN='Y' AND 
                R.UP_DPT_CD is null OR 
                R.UP_DPT_CD in (
                          SELECT DPT_CD 
                          FROM SN_DPT 
                          WHERE R.USE_YN='Y' AND 
                                UP_DPT_CD is null
                        ) OR 
                R.UP_DPT_CD in (
                        SELECT DPT_CD 
                        FROM SN_DPT 
                        WHERE R.USE_YN='Y' AND 
                              UP_DPT_CD in (
                                      SELECT DPT_CD 
                                      FROM SN_DPT 
                                      WHERE R.USE_YN='Y' AND 
                                            UP_DPT_CD is null
                                      )
          );

        SELECT 
          R.DPT_CD,
          R.DPT_NM,
          R.DPT_ALL_NM,
          R.DPT_ORDER,
          R.UP_DPT_CD,
          R.BLG_PA_CD,
          R.BLG_PS_CD,
          R.PANS_DIRBL_TYPE,
          R.USE_YN, 
          (SELECT A.DPT_CD FROM SN_STMPIMG A WHERE A.DPT_CD = R.DPT_CD) AS STAMP_YN 
        FROM SN_DPT R
        WHERE R.USE_YN='Y' AND 
              R.UP_DPT_CD is null OR
              R.UP_DPT_CD in (
                          SELECT DPT_CD 
                          FROM SN_DPT 
                          WHERE R.USE_YN='Y' AND 
                                UP_DPT_CD is null
                        ) OR 
              R.UP_DPT_CD in (
                        SELECT DPT_CD 
                        FROM SN_DPT 
                        WHERE R.USE_YN='Y' AND 
                              UP_DPT_CD in (
                                      SELECT DPT_CD 
                                      FROM SN_DPT 
                                      WHERE R.USE_YN='Y' AND 
                                            UP_DPT_CD is null
                                      )
                        )
        ORDER BY DPT_CD;
        
    ELSEIF  P_PROC_ID = 'GET_STAMP_INFO_LIST' THEN       

        SELECT COUNT(DPT_CD) INTO P_DEPT_CNT
          FROM SN_DPT R
          WHERE R.BLG_PA_CD = P_DPT_CD AND
                R.USE_YN='Y' AND 
                R.UP_DPT_CD is null OR 
                R.UP_DPT_CD in (
                          SELECT DPT_CD 
                          FROM SN_DPT 
                          WHERE R.BLG_PA_CD = P_DPT_CD AND
                                R.USE_YN='Y' AND 
                                UP_DPT_CD is null
                        ) OR 
                R.UP_DPT_CD in (
                        SELECT DPT_CD 
                        FROM SN_DPT 
                        WHERE R.BLG_PA_CD = P_DPT_CD AND
                              R.USE_YN='Y' AND 
                              UP_DPT_CD in (
                                      SELECT DPT_CD 
                                      FROM SN_DPT 
                                      WHERE R.BLG_PA_CD = P_DPT_CD AND
                                            R.USE_YN='Y' AND 
                                            UP_DPT_CD is null
                                      )
          );

        SELECT 
          R.DPT_CD,
          R.DPT_NM,
          R.DPT_ALL_NM,
          R.DPT_ORDER,
          R.UP_DPT_CD,
          R.BLG_PA_CD,
          R.BLG_PS_CD,
          R.PANS_DIRBL_TYPE,
          R.USE_YN, 
          (SELECT A.STMP_IMG FROM SN_STMPIMG A WHERE A.DPT_CD = R.DPT_CD) AS STAMP_YN 
        FROM SN_DPT R
        WHERE R.BLG_PA_CD = P_DPT_CD AND
              R.USE_YN='Y' AND 
              R.UP_DPT_CD is null OR
              R.UP_DPT_CD in (
                          SELECT DPT_CD 
                          FROM SN_DPT 
                          WHERE R.BLG_PA_CD = P_DPT_CD AND
                                R.USE_YN='Y' AND 
                                UP_DPT_CD is null
                        ) OR 
              R.UP_DPT_CD in (
                        SELECT DPT_CD 
                        FROM SN_DPT 
                        WHERE R.BLG_PA_CD = P_DPT_CD AND
                              R.USE_YN='Y' AND 
                              UP_DPT_CD in (
                                      SELECT DPT_CD 
                                      FROM SN_DPT 
                                      WHERE R.BLG_PA_CD = P_DPT_CD AND
                                            R.USE_YN='Y' AND 
                                            UP_DPT_CD is null
                                      )
                        )
        ORDER BY DPT_CD;

    ELSEIF P_PROC_ID = 'GET_DEPT_GRID' THEN

        SELECT COUNT(DPT_CD) INTO P_DEPT_CNT
          FROM SN_DPT
         WHERE USE_YN='Y'
         AND UP_DPT_CD = P_DPT_CD;

        SELECT 
          R.DPT_CD,
          R.DPT_NM,
          R.DPT_ALL_NM,
          IFNULL(R.UP_DPT_CD, '') AS UP_DPT_CD,
          (SELECT DPT_NM FROM SN_DPT A WHERE A.DPT_CD = R.UP_DPT_CD) AS UP_DPT_NM,
          R.BLG_PA_CD,
          R.BLG_PS_CD,
          R.USE_YN
        FROM SN_DPT R
        WHERE USE_YN='Y'
        AND UP_DPT_CD = P_DPT_CD || DPT_CD = P_DPT_CD
        ORDER BY DPT_CD
        LIMIT P_START_NO, P_PAGE_NO;

       

    END IF;
    
END//
DELIMITER ;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
