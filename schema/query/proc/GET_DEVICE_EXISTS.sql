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

-- 함수 REDSPUSH.GET_DEVICE_EXISTS 구조 내보내기
DELIMITER //
CREATE DEFINER=`redspush`@`%` FUNCTION `GET_DEVICE_EXISTS`(P_USR_ID VARCHAR(50)) RETURNS char(1) CHARSET utf8 COLLATE utf8_bin
BEGIN
	DECLARE	V_RET_INFO	CHAR(1) DEFAULT 'N';
	
	IF EXISTS (	SELECT	DVC_NO
				FROM	SN_DEVICE
				WHERE	USR_ID	= P_USR_ID) THEN
		SET V_RET_INFO  = 'Y';
	END IF;
	
  	RETURN   V_RET_INFO;

END//
DELIMITER ;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
