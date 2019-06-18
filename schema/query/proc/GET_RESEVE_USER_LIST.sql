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

-- 프로시저 REDSPUSH.GET_RESEVE_USER_LIST 구조 내보내기
DELIMITER //
CREATE DEFINER=`redspush`@`%` PROCEDURE `GET_RESEVE_USER_LIST`(
    IN `P_PROC_ID` VARCHAR(30),
    IN `P_MNG_NO` VARCHAR(30),
  	IN `P_USR_LIST` TEXT,
    IN `P_START_NO` INT,
    IN `P_PAGE_NO` INT,
  	OUT `P_RECV_CNT` INT,
    OUT P_RESULT_ID INT,
    OUT P_MESSAGE   TINYTEXT    
)
    COMMENT '[oslee97] 예약,반복 발송 수신자 목록 조회.'
BEGIN
    SET P_RESULT_ID= -1;
    SET P_MESSAGE= "처리중 오류가 발생했습니다.";  
    SET @ROWNUM =P_START_NO;
    
    IF P_PROC_ID = 'RECV_USER_LIST' THEN
      SELECT COUNT(A.USR_ID) AS CNT
        INTO P_RECV_CNT
        FROM SN_USR A
       WHERE FIND_IN_SET(A.USR_ID, P_USR_LIST);
         
      
      SELECT @ROWNUM := @ROWNUM+1 RM,
             B.USR_ID,
             IFNULL(B.USR_NM, '') AS USR_NM,
             CASE WHEN IFNULL(B.USR_NCKNM, '') = '' THEN B.USR_NM ELSE B.USR_NCKNM END AS USR_NCKNM,
             IFNULL(B.CELL_NO, '') AS CELL_NO,
             IFNULL(B.EMAIL_ADDR, '') AS EMAIL_ADDR,
             IFNULL(B.AVT_IMG_PATH, '') AS AVT_IMG_PATH,
             (SELECT D.DPT_NM FROM SN_DPT D WHERE D.CPNY_NO = B.CPNY_NO AND D.DPT_NO = B.DPT_NO) AS DPT_NM
        FROM SN_USR B
       WHERE FIND_IN_SET(B.USR_ID, P_USR_LIST)
       LIMIT P_START_NO, P_PAGE_NO ;
    
      SET P_RESULT_ID= 0;
      SET P_MESSAGE= "정상적으로 처리되었습니다.";
    
    END IF;
END//
DELIMITER ;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
