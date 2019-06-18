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

-- 테이블 REDSPUSH.BD_READLOG 구조 내보내기
CREATE TABLE IF NOT EXISTS `BD_READLOG` (
  `CNTS_SEQ_NO` int(11) NOT NULL COMMENT '게시물 관리번호 ',
  `USR_ID` varchar(80) COLLATE utf8_bin NOT NULL COMMENT '사용자 ID ',
  `BRD_CD` varchar(5) COLLATE utf8_bin DEFAULT NULL COMMENT '게시판 관리번호',
  `READ_TS` timestamp NULL DEFAULT NULL COMMENT '확인 일시 ',
  PRIMARY KEY (`CNTS_SEQ_NO`,`USR_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='게시물확인이력';

-- 테이블 데이터 REDSPUSH.BD_READLOG:~35 rows (대략적) 내보내기
/*!40000 ALTER TABLE `BD_READLOG` DISABLE KEYS */;
INSERT INTO `BD_READLOG` (`CNTS_SEQ_NO`, `USR_ID`, `BRD_CD`, `READ_TS`) VALUES
	(1, 'jhlee@eberry.co.kr', 'BBS01', '2019-05-22 19:11:26'),
	(1, 'oslee97', NULL, '2019-05-10 12:11:15'),
	(2, 'jhlee@eberry.co.kr', 'BBS01', '2019-05-22 21:11:37'),
	(2, 'mhyoon', 'BBS01', '2019-05-23 11:30:17'),
	(2, 'oslee97', 'BBS01', '2019-05-14 09:47:17'),
	(4, 'oslee97', 'BBS02', '2019-05-14 14:36:31'),
	(5, 'oslee97', 'BBS02', '2019-05-14 14:34:35'),
	(7, 'oslee97', 'BBS02', '2019-05-14 14:34:29'),
	(8, 'oslee97', 'BBS03', '2019-05-14 14:35:18'),
	(12, 'jhlee@eberry.co.kr', 'BBS01', '2019-05-22 21:11:58'),
	(12, 'mhyoon', 'BBS01', '2019-05-23 11:32:03'),
	(12, 'oslee97', 'BBS01', '2019-05-10 13:17:39'),
	(13, 'jhlee@eberry.co.kr', 'BBS01', '2019-05-22 19:16:31'),
	(13, 'mhyoon', 'BBS01', '2019-05-28 15:05:39'),
	(13, 'oslee97', 'BBS01', '2019-05-28 10:00:19'),
	(16, 'mhyoon', 'BBS01', '2019-05-28 14:54:57'),
	(18, 'mhyoon', 'BBS01', '2019-05-28 14:54:27'),
	(24, 'dlqpfl', 'BBS01', '2019-05-23 13:09:08'),
	(24, 'jhlee@eberry.co.kr', 'BBS01', '2019-05-23 13:31:18'),
	(24, 'mhyoon', 'BBS01', '2019-05-16 21:26:46'),
	(24, 'null', 'BBS01', '2019-06-15 16:35:02'),
	(24, 'oslee97', 'BBS01', '2019-05-14 14:33:12'),
	(25, 'oslee97', 'BBS03', '2019-05-14 14:35:12'),
	(30, 'admin', 'BBS01', '2019-05-20 21:07:50'),
	(30, 'jhlee@eberry.co.kr', 'BBS01', '2019-05-16 21:40:51'),
	(30, 'mhyoon', 'BBS01', '2019-05-16 21:26:41'),
	(30, 'oslee97', 'BBS01', '2019-05-24 13:25:14'),
	(36, 'mhyoon', 'BBS01', '2019-05-28 14:45:28'),
	(38, 'mhyoon', 'BBS01', '2019-05-28 14:49:18'),
	(45, 'oslee97', 'BBS02', '2019-05-20 14:37:46'),
	(48, '30', 'BBS01', '2019-05-10 12:16:40'),
	(48, 'dlqpfl', 'BBS01', '2019-05-28 16:13:26'),
	(48, 'jhlee@eberry.co.kr', 'BBS01', '2019-05-31 22:41:40'),
	(48, 'mhyoon', 'BBS01', '2019-05-28 14:54:27'),
	(48, 'oslee97', 'BBS01', '2019-05-27 10:21:47');
/*!40000 ALTER TABLE `BD_READLOG` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
