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

-- 프로시저 REDSPUSH.GET_PUSH_SEND_TARGET 구조 내보내기
DELIMITER //
CREATE DEFINER=`redspush`@`%` PROCEDURE `GET_PUSH_SEND_TARGET`(
	IN `P_CPNY_NO` INT(10),
  IN `P_CPNY_LIST` TEXT,
  IN `P_DPT_NO` TEXT,
  IN `P_USR_ID` TEXT,
	OUT `P_RESULT_ID` INTEGER,
	OUT `P_MESSAGE` VARCHAR(500)
)
    COMMENT '[neal] 푸시발송 대상 목록을 선택하기 위한 발송대상목록을 조회한다.'
BEGIN

    DECLARE SQLSTRING   TEXT;
    DECLARE CNTSTRING   TEXT;
    
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
      BEGIN
        SET P_RESULT_ID	= -1;
        SET P_MESSAGE	= "조회중 오류가 발생하였습니다.";
    END;    
        
    SET SQLSTRING = "";  
    SET CNTSTRING = "";
        
    SET P_RESULT_ID= 0;
    SET P_MESSAGE= "정상적으로 처리되었습니다.";

    SELECT DISTINCT T.USR_ID
    FROM (
      SELECT A.USR_ID AS USR_ID
      FROM SN_USR A, SN_COMPANY C, SN_DEVICE D
      WHERE A.CPNY_NO = C.CPNY_NO
        AND A.USR_ID = D.USR_ID
        AND C.CPNY_NO = P_CPNY_LIST
      UNION ALL
      SELECT A.USR_ID
      FROM SN_USR A, SN_DPT C, SN_DEVICE D
      WHERE A.DPT_NO = C.DPT_NO
        AND A.USR_ID = D.USR_ID
        AND A.CPNY_NO = P_CPNY_NO
        AND FIND_IN_SET(C.DPT_NO, P_DPT_NO)
      UNION ALL
      SELECT A.USR_ID
      FROM SN_USR A, SN_DEVICE D
      WHERE A.USR_ID = D.USR_ID
        AND FIND_IN_SET(A.USR_ID, P_USR_ID)
    ) T;
    
 END//
DELIMITER ;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
