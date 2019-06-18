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

-- 테이블 REDSPUSH.PM_MSGSEND 구조 내보내기
CREATE TABLE IF NOT EXISTS `PM_MSGSEND` (
  `SNDMSG_NO` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '송신메시지 번호',
  `SND_TS` timestamp NULL DEFAULT NULL COMMENT '송신 일시 ',
  `USR_ID` varchar(80) COLLATE utf8_bin DEFAULT NULL COMMENT '사용자 ID ',
  `TRNS_NO` int(10) unsigned NOT NULL COMMENT '전송 번호',
  PRIMARY KEY (`SNDMSG_NO`)
) ENGINE=MyISAM AUTO_INCREMENT=48 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='송신메시지';

-- 테이블 데이터 REDSPUSH.PM_MSGSEND:47 rows 내보내기
/*!40000 ALTER TABLE `PM_MSGSEND` DISABLE KEYS */;
INSERT INTO `PM_MSGSEND` (`SNDMSG_NO`, `SND_TS`, `USR_ID`, `TRNS_NO`) VALUES
	(1, '2019-06-07 14:25:37', 'jhlee@eberry.co.kr', 1),
	(2, '2019-06-07 14:26:06', 'jhlee@eberry.co.kr', 2),
	(3, '2019-06-07 14:27:07', 'jhlee@eberry.co.kr', 3),
	(4, '2019-06-07 15:00:45', 'tjdtmddn@eberry.co.kr', 4),
	(5, '2019-06-07 15:01:04', 'tjdtmddn@eberry.co.kr', 5),
	(6, '2019-06-07 15:02:35', 'tjdtmddn@eberry.co.kr', 6),
	(7, '2019-06-07 15:54:27', 'jhlee@eberry.co.kr', 7),
	(8, '2019-06-11 10:49:59', 'skarjsdn', 8),
	(9, '2019-06-12 14:30:17', 'sos22233@eberry.co.kr', 9),
	(10, '2019-06-12 18:36:02', 'tjdtmddn@eberry.co.kr', 10),
	(11, '2019-06-13 14:14:21', 'tjdtmddn@eberry.co.kr', 11),
	(12, '2019-06-13 14:16:53', 'tjdtmddn@eberry.co.kr', 12),
	(13, '2019-06-13 14:17:31', 'tjdtmddn@eberry.co.kr', 13),
	(14, '2019-06-13 14:18:20', 'tjdtmddn@eberry.co.kr', 14),
	(15, '2019-06-13 14:20:15', 'tjdtmddn@eberry.co.kr', 15),
	(16, '2019-06-13 17:36:33', 'tjdtmddn@eberry.co.kr', 16),
	(17, '2019-06-13 17:42:32', 'tjdtmddn@eberry.co.kr', 17),
	(18, '2019-06-13 17:45:05', 'tjdtmddn@eberry.co.kr', 18),
	(19, '2019-06-13 17:45:59', 'tjdtmddn@eberry.co.kr', 19),
	(20, '2019-06-13 17:50:40', 'tjdtmddn@eberry.co.kr', 20),
	(21, '2019-06-13 17:55:15', 'sos22233@eberry.co.kr', 21),
	(22, '2019-06-13 18:11:15', 'tjdtmddn@eberry.co.kr', 22),
	(23, '2019-06-14 09:23:01', 'tjdtmddn@eberry.co.kr', 23),
	(24, '2019-06-14 09:23:41', 'tjdtmddn@eberry.co.kr', 24),
	(25, '2019-06-14 09:53:07', 'tjdtmddn@eberry.co.kr', 25),
	(26, '2019-06-14 19:24:54', 'tablet@eberry.co.kr', 26),
	(27, '2019-06-14 19:30:31', 'tablet@eberry.co.kr', 27),
	(28, '2019-06-14 19:33:25', 'tablet@eberry.co.kr', 28),
	(29, '2019-06-14 19:37:14', 'tablet@eberry.co.kr', 29),
	(30, '2019-06-14 19:40:37', 'tablet@eberry.co.kr', 30),
	(31, '2019-06-14 19:42:56', 'tablet@eberry.co.kr', 31),
	(32, '2019-06-14 19:46:05', 'tablet@eberry.co.kr', 32),
	(33, '2019-06-14 20:12:57', 'tablet2@eberry.co.kr', 33),
	(34, '2019-06-14 20:43:00', 'tablet2@eberry.co.kr', 34),
	(35, '2019-06-14 20:53:38', 'tjdtmddn@eberry.co.kr', 35),
	(36, '2019-06-14 20:55:29', 'tjdtmddn@eberry.co.kr', 36),
	(37, '2019-06-14 20:56:56', 'tjdtmddn@eberry.co.kr', 37),
	(38, '2019-06-14 20:59:06', 'tjdtmddn@eberry.co.kr', 38),
	(39, '2019-06-15 16:35:14', 'tjdtmddn@eberry.co.kr', 39),
	(40, '2019-06-15 16:49:53', 'tjdtmddn@eberry.co.kr', 40),
	(41, '2019-06-15 16:51:59', 'tjdtmddn@eberry.co.kr', 41),
	(42, '2019-06-15 16:54:11', 'tjdtmddn@eberry.co.kr', 42),
	(43, '2019-06-15 16:57:21', 'tjdtmddn@eberry.co.kr', 43),
	(44, '2019-06-15 16:59:09', 'tjdtmddn@eberry.co.kr', 44),
	(45, '2019-06-15 17:02:43', 'tjdtmddn@eberry.co.kr', 45),
	(46, '2019-06-15 17:04:24', 'tjdtmddn@eberry.co.kr', 46),
	(47, '2019-06-15 17:05:44', 'tjdtmddn@eberry.co.kr', 47);
/*!40000 ALTER TABLE `PM_MSGSEND` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
