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

-- 프로시저 REDSPUSH.SET_DPT_INFO 구조 내보내기
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `SET_DPT_INFO`(
  IN `P_PROC_ID`       VARCHAR(30)     ,
  IN `P_CPNY_NO`       INT(10)     ,
  IN `P_DPT_NO`        INT(10)     ,
  IN `P_DPT_NM`       VARCHAR(30)     ,
  IN `P_DPT_TEL_NO`     VARCHAR(30)    ,
  IN `P_DPT_FAX_NO`     VARCHAR(30)    ,
  OUT `P_RESULT_ID`    INT             ,
  OUT `P_MESSAGE`     VARCHAR(500)
)
BEGIN
    SET P_RESULT_ID= -1;
    SET P_MESSAGE= "처리중 오류가 발생했습니다.";

    IF  P_PROC_ID = 'DPT_INSERT' THEN  
      INSERT INTO SN_DPT (CPNY_NO,
                          DPT_NM)
          VALUES (P_CPNY_NO,
                  P_DPT_NM);
        SET P_RESULT_ID= 0;
        SET P_MESSAGE= "정상적으로 처리되었습니다."; 
    
    ELSEIF  P_PROC_ID = 'DPT_UPDATE' THEN
      UPDATE  SN_DPT
      SET     DPT_NM            = IFNULL(P_DPT_NM,''),
              DPT_TEL_NO        = IFNULL(P_DPT_TEL_NO,''),
              DPT_FAX_NO        = IFNULL(P_DPT_FAX_NO,'')
			  WHERE DPT_NO = P_DPT_NO;
        SET P_RESULT_ID= 0;
        SET P_MESSAGE= "정상적으로 처리되었습니다.";  
    
    END IF;
 END//
DELIMITER ;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
