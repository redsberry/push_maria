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

-- 테이블 REDSPUSH.PM_MSGRECV 구조 내보내기
CREATE TABLE IF NOT EXISTS `PM_MSGRECV` (
  `RCVMSG_NO` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '수신메시지 번호',
  `RCV_TS` timestamp NULL DEFAULT NULL COMMENT '수신 일시 ',
  `USR_ID` varchar(80) COLLATE utf8_bin DEFAULT NULL COMMENT '사용자 ID ',
  `TRNS_NO` int(10) unsigned NOT NULL COMMENT '전송 번호',
  `READING_YN` enum('Y','N') COLLATE utf8_bin DEFAULT NULL COMMENT '열람 여부',
  `SNDMSG_NO` int(10) unsigned NOT NULL COMMENT '송신메시지 번호',
  PRIMARY KEY (`RCVMSG_NO`)
) ENGINE=MyISAM AUTO_INCREMENT=49 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='수신메시지';

-- 테이블 데이터 REDSPUSH.PM_MSGRECV:48 rows 내보내기
/*!40000 ALTER TABLE `PM_MSGRECV` DISABLE KEYS */;
INSERT INTO `PM_MSGRECV` (`RCVMSG_NO`, `RCV_TS`, `USR_ID`, `TRNS_NO`, `READING_YN`, `SNDMSG_NO`) VALUES
	(1, '2019-06-07 14:25:37', 'skarjsdn', 1, 'Y', 1),
	(2, '2019-06-07 14:25:37', 'tjdtmddn@eberry.co.kr', 1, 'Y', 1),
	(3, '2019-06-07 14:26:07', 'tjdtmddn@eberry.co.kr', 2, 'Y', 2),
	(4, '2019-06-07 14:27:07', 'tjdtmddn@eberry.co.kr', 3, 'Y', 3),
	(5, '2019-06-07 14:27:07', 'skarjsdn', 3, 'Y', 3),
	(6, '2019-06-07 15:01:04', 'skarjsdn', 5, 'N', 5),
	(7, '2019-06-07 15:02:35', 'skarjsdn', 6, 'N', 6),
	(8, '2019-06-07 15:54:27', 'tjdtmddn@eberry.co.kr', 7, 'N', 7),
	(9, '2019-06-07 15:54:27', 'skarjsdn', 7, 'N', 7),
	(10, '2019-06-11 10:50:01', 'jhlee@eberry.co.kr', 8, 'N', 8),
	(11, '2019-06-12 14:30:20', 'tjdtmddn@eberry.co.kr', 9, 'N', 9),
	(12, '2019-06-12 18:36:02', 'tablet@eberry.co.kr', 10, 'Y', 10),
	(13, '2019-06-13 14:14:21', 'tablet@eberry.co.kr', 11, 'Y', 11),
	(14, '2019-06-13 14:16:53', 'tablet@eberry.co.kr', 12, 'Y', 12),
	(15, '2019-06-13 14:17:31', 'tablet@eberry.co.kr', 13, 'Y', 13),
	(16, '2019-06-13 14:18:20', 'tablet@eberry.co.kr', 14, 'Y', 14),
	(17, '2019-06-13 14:20:15', 'tablet@eberry.co.kr', 15, 'Y', 15),
	(18, '2019-06-13 17:36:33', 'tablet@eberry.co.kr', 16, 'Y', 16),
	(19, '2019-06-13 17:42:32', 'tablet@eberry.co.kr', 17, 'Y', 17),
	(20, '2019-06-13 17:45:05', 'tablet@eberry.co.kr', 18, 'Y', 18),
	(21, '2019-06-13 17:45:59', 'tablet@eberry.co.kr', 19, 'Y', 19),
	(22, '2019-06-13 17:50:40', 'tablet@eberry.co.kr', 20, 'Y', 20),
	(23, '2019-06-13 17:55:18', 'tablet@eberry.co.kr', 21, 'Y', 21),
	(24, '2019-06-13 18:11:15', 'tablet@eberry.co.kr', 22, 'Y', 22),
	(25, '2019-06-14 09:23:01', 'tablet@eberry.co.kr', 23, 'Y', 23),
	(26, '2019-06-14 09:23:41', 'tablet@eberry.co.kr', 24, 'Y', 24),
	(27, '2019-06-14 09:53:07', 'tablet@eberry.co.kr', 25, 'Y', 25),
	(28, '2019-06-14 19:24:54', 'tjdtmddn@eberry.co.kr', 26, 'N', 26),
	(29, '2019-06-14 19:30:31', 'tjdtmddn@eberry.co.kr', 27, 'N', 27),
	(30, '2019-06-14 19:33:25', 'tjdtmddn@eberry.co.kr', 28, 'N', 28),
	(31, '2019-06-14 19:37:14', 'tjdtmddn@eberry.co.kr', 29, 'N', 29),
	(32, '2019-06-14 19:40:37', 'tjdtmddn@eberry.co.kr', 30, 'N', 30),
	(33, '2019-06-14 19:42:56', 'tjdtmddn@eberry.co.kr', 31, 'N', 31),
	(34, '2019-06-14 19:46:05', 'tjdtmddn@eberry.co.kr', 32, 'N', 32),
	(35, '2019-06-14 19:46:05', 'jhlee@eberry.co.kr', 32, 'N', 32),
	(36, '2019-06-14 20:12:57', 'tjdtmddn@eberry.co.kr', 33, 'N', 33),
	(37, '2019-06-14 20:12:57', 'jhlee@eberry.co.kr', 33, 'N', 33),
	(38, '2019-06-14 20:43:00', 'tjdtmddn@eberry.co.kr', 34, 'N', 34),
	(39, '2019-06-14 20:59:06', 'tablet@eberry.co.kr', 38, 'Y', 38),
	(40, '2019-06-15 16:35:14', 'tablet@eberry.co.kr', 39, 'Y', 39),
	(41, '2019-06-15 16:49:53', 'tablet@eberry.co.kr', 40, 'Y', 40),
	(42, '2019-06-15 16:51:59', 'tablet@eberry.co.kr', 41, 'Y', 41),
	(43, '2019-06-15 16:54:11', 'tablet@eberry.co.kr', 42, 'Y', 42),
	(44, '2019-06-15 16:57:21', 'tablet@eberry.co.kr', 43, 'Y', 43),
	(45, '2019-06-15 16:59:09', 'tablet@eberry.co.kr', 44, 'Y', 44),
	(46, '2019-06-15 17:02:43', 'tablet@eberry.co.kr', 45, 'Y', 45),
	(47, '2019-06-15 17:04:24', 'tablet@eberry.co.kr', 46, 'Y', 46),
	(48, '2019-06-15 17:05:44', 'tablet@eberry.co.kr', 47, 'Y', 47);
/*!40000 ALTER TABLE `PM_MSGRECV` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
