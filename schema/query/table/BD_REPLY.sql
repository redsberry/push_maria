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

-- 테이블 REDSPUSH.BD_REPLY 구조 내보내기
CREATE TABLE IF NOT EXISTS `BD_REPLY` (
  `RPY_SEQ_NO` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '댓글 관리번호',
  `CNTS_SEQ_NO` int(10) unsigned NOT NULL COMMENT '게시물 관리번호',
  `RPY_DEPTH` smallint(6) DEFAULT NULL COMMENT '댓글 깊이 ',
  `RPY_ORD` smallint(6) DEFAULT NULL COMMENT '댓글 순서 ',
  `RPY_MSG` longtext COLLATE utf8_bin DEFAULT NULL COMMENT '댓글 내용글 ',
  `WTR_ID` varchar(80) COLLATE utf8_bin DEFAULT NULL COMMENT '작성자 ID ',
  `WTR_NM` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '작성자 명 ',
  `REG_TS` timestamp NOT NULL DEFAULT current_timestamp() COMMENT '등록 일시',
  `UPD_TS` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp() COMMENT '수정 일시',
  PRIMARY KEY (`RPY_SEQ_NO`)
) ENGINE=MyISAM AUTO_INCREMENT=40 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='게시물댓글';

-- 테이블 데이터 REDSPUSH.BD_REPLY:35 rows 내보내기
/*!40000 ALTER TABLE `BD_REPLY` DISABLE KEYS */;
INSERT INTO `BD_REPLY` (`RPY_SEQ_NO`, `CNTS_SEQ_NO`, `RPY_DEPTH`, `RPY_ORD`, `RPY_MSG`, `WTR_ID`, `WTR_NM`, `REG_TS`, `UPD_TS`) VALUES
	(1, 12, 1, 19, '댓글1 테스트합니다.', 'oslee97', '이옥선', '2019-03-25 17:53:51', '2019-03-29 09:27:02'),
	(2, 12, 1, 18, '댓글2 테스트합니다.', 'oslee97', '이옥선', '2019-03-25 17:54:03', '2019-03-29 09:27:02'),
	(3, 12, 1, 17, '댓글3 테스트합니다.', 'oslee97', '이옥선', '2019-03-25 17:54:28', '2019-03-29 09:27:02'),
	(4, 12, 1, 16, '댓글4 테스트합니다.', 'oslee97', '이옥선', '2019-03-25 17:55:40', '2019-03-29 09:27:02'),
	(5, 12, 1, 15, '댓글5 테스트합니다.', 'oslee97', '이옥선', '2019-03-25 17:56:18', '2019-03-29 09:27:02'),
	(6, 12, 1, 14, '댓글6 테스트합니다.', 'oslee97', '이옥선', '2019-03-25 17:56:56', '2019-03-29 09:27:02'),
	(7, 12, 1, 9, '댓글7 테스트합니다.', 'oslee97', '이옥선', '2019-03-25 17:58:42', '2019-03-29 09:27:02'),
	(8, 12, 2, 10, '댓글7의 답글1입니다.', 'oslee97', '이옥선', '2019-03-26 10:44:23', '2019-03-29 09:27:02'),
	(9, 12, 2, 11, '댓글7 댓글2 테스트합니다.', 'oslee97', '이옥선', '2019-03-26 13:34:16', '2019-03-29 09:27:02'),
	(10, 12, 1, 7, '댓글 8 테스트입니다.', 'oslee97', '이옥선', '2019-03-27 15:38:41', '2019-03-29 09:27:02'),
	(12, 12, 1, 5, '댓글 9입니다.\n댓글 9입니다.', 'oslee97', '이옥선', '2019-03-27 16:48:15', '2019-03-29 09:27:02'),
	(11, 12, 2, 8, '댓글8의 답글1입니다.\n댓글8의 답글1입니다.', 'oslee97', '이옥선', '2019-03-27 16:35:54', '2019-03-29 09:27:02'),
	(19, 12, 1, 1, '댓글 11 테스트입니다.', 'oslee97', '이옥선', '2019-03-28 11:49:58', '2019-03-29 09:27:02'),
	(14, 12, 1, 3, '댓글 10 테스트입니다.\n댓글 10 테스트입니다.\n댓글 10 테스트입니다.', 'oslee97', '이옥선', '2019-03-27 17:55:45', '2019-03-29 09:27:02'),
	(16, 12, 3, 12, '댓글7의 답글2의 답글 테스트합니다.', 'oslee97', '이옥선', '2019-03-28 10:17:20', '2019-03-29 09:27:02'),
	(17, 12, 4, 13, '댓글7의 답글2의 답글2를 테스트합니다.', 'oslee97', '이옥선', '2019-03-28 10:19:36', '2019-03-29 09:27:02'),
	(18, 12, 2, 20, '댓글1의 답글을 테스트합니다.', 'oslee97', '이옥선', '2019-03-28 10:22:38', '2019-03-29 09:27:02'),
	(20, 12, 1, 0, '댓글 12입니다', 'oslee97', '이옥선', '2019-03-29 09:27:02', '2019-03-29 09:27:02'),
	(21, 13, 1, 0, '댓글1입니다.', 'oslee97', '이옥선', '2019-03-29 09:35:26', '2019-03-29 09:35:26'),
	(23, 13, 2, 3, '댓글1의 답글2입니다.', 'oslee97', '이옥선', '2019-03-29 16:09:41', '2019-03-29 18:00:24'),
	(24, 13, 3, 4, '댓글1의 답글2의 1번답글', 'oslee97', '이옥선', '2019-03-29 16:09:57', '2019-03-29 18:00:24'),
	(29, 24, 1, 2, '댓글2', 'oslee97', '이옥선', '2019-03-29 18:15:58', '2019-03-29 18:21:44'),
	(27, 13, 3, 2, '댓글1의 답글1의 1', 'oslee97', '이옥선', '2019-03-29 18:00:24', '2019-03-29 18:00:24'),
	(28, 24, 1, 6, '댓글1', 'oslee97', '이옥선', '2019-03-29 18:00:36', '2019-03-29 18:21:44'),
	(26, 13, 2, 1, '댓글1의 답글1입니다.', 'oslee97', '이옥선', '2019-03-29 17:56:34', '2019-03-29 17:56:34'),
	(30, 24, 2, 3, '댓글2의 답글1', 'oslee97', '이옥선', '2019-03-29 18:16:42', '2019-03-29 18:21:44'),
	(31, 24, 1, 1, '댓글3', 'oslee97', '이옥선', '2019-03-29 18:20:30', '2019-03-29 18:21:44'),
	(32, 24, 1, 0, '댓글4', 'oslee97', '이옥선', '2019-03-29 18:21:44', '2019-03-29 18:21:44'),
	(33, 30, 1, 6, '댓글1', 'oslee97', '이옥선', '2019-04-01 17:56:11', '2019-04-01 18:14:31'),
	(34, 30, 1, 0, '댓글2', 'oslee97', '이옥선', '2019-04-01 17:56:17', '2019-04-01 17:56:17'),
	(35, 30, 2, 5, '댓글2의 답글1', 'oslee97', '이옥선', '2019-04-01 17:56:58', '2019-04-01 18:14:31'),
	(36, 30, 2, 4, '댓글2의 답글2', 'oslee97', '이옥선', '2019-04-01 18:03:13', '2019-04-01 18:14:31'),
	(37, 30, 2, 1, '댓글2의 답글3', 'oslee97', '이옥선', '2019-04-01 18:10:07', '2019-04-01 18:10:07'),
	(38, 30, 3, 2, '댓글2의 답글3의 1', 'oslee97', '이옥선', '2019-04-01 18:14:11', '2019-04-01 18:14:11'),
	(39, 30, 4, 3, '댓글2의 답글3의 2', 'oslee97', '이옥선', '2019-04-01 18:14:31', '2019-04-01 18:14:31');
/*!40000 ALTER TABLE `BD_REPLY` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
