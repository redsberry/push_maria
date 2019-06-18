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

-- 테이블 REDSPUSH.SN_DASHBOARD 구조 내보내기
CREATE TABLE IF NOT EXISTS `SN_DASHBOARD` (
  `WG_NO` int(11) unsigned NOT NULL COMMENT '위젯 번호 ',
  `USR_ID` varchar(80) COLLATE utf8_bin NOT NULL COMMENT '사용자 ID ',
  PRIMARY KEY (`WG_NO`,`USR_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='개인별대시보드';

-- 테이블 데이터 REDSPUSH.SN_DASHBOARD:~34 rows (대략적) 내보내기
/*!40000 ALTER TABLE `SN_DASHBOARD` DISABLE KEYS */;
INSERT INTO `SN_DASHBOARD` (`WG_NO`, `USR_ID`) VALUES
	(1, 'admin'),
	(1, 'admin@eberry.co.kr'),
	(1, 'oslee97'),
	(1, 'skarjsdn'),
	(1, 'tjdtmddn'),
	(2, 'admin'),
	(2, 'admin@eberry.co.kr'),
	(2, 'oslee97'),
	(2, 'skarjsdn'),
	(2, 'tjdtmddn'),
	(3, 'admin'),
	(3, 'admin@eberry.co.kr'),
	(3, 'oslee97'),
	(3, 'skarjsdn'),
	(3, 'tjdtmddn'),
	(4, 'admin@eberry.co.kr'),
	(5, 'admin@eberry.co.kr'),
	(6, 'admin@eberry.co.kr'),
	(7, 'admin@eberry.co.kr'),
	(8, 'admin'),
	(8, 'admin@eberry.co.kr'),
	(8, 'oslee97'),
	(8, 'skarjsdn'),
	(8, 'tjdtmddn'),
	(9, 'admin'),
	(9, 'admin@eberry.co.kr'),
	(9, 'oslee97'),
	(9, 'skarjsdn'),
	(9, 'tjdtmddn'),
	(10, 'admin'),
	(10, 'admin@eberry.co.kr'),
	(10, 'oslee97'),
	(10, 'skarjsdn'),
	(10, 'tjdtmddn');
/*!40000 ALTER TABLE `SN_DASHBOARD` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
