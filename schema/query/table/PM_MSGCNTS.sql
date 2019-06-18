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

-- 테이블 REDSPUSH.PM_MSGCNTS 구조 내보내기
CREATE TABLE IF NOT EXISTS `PM_MSGCNTS` (
  `TRNS_NO` int(10) unsigned NOT NULL COMMENT '전송 번호',
  `MSG_SUBJ` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '메시지 제목 ',
  `MSG_CTNTS` text COLLATE utf8_bin DEFAULT NULL COMMENT '메시지 내용 ',
  `ATT_CAT_EXT` varchar(5) COLLATE utf8_bin DEFAULT NULL COMMENT '첨부 유형 확장자',
  `ATT_FILE_PATH` varchar(256) COLLATE utf8_bin DEFAULT NULL COMMENT '첨부 파일 경로 ',
  PRIMARY KEY (`TRNS_NO`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='전송메시지내용';

-- 테이블 데이터 REDSPUSH.PM_MSGCNTS:47 rows 내보내기
/*!40000 ALTER TABLE `PM_MSGCNTS` DISABLE KEYS */;
INSERT INTO `PM_MSGCNTS` (`TRNS_NO`, `MSG_SUBJ`, `MSG_CTNTS`, `ATT_CAT_EXT`, `ATT_FILE_PATH`) VALUES
	(1, '1241234', '12421342143', '', ''),
	(2, '2535523523525', '234234234234234234234', NULL, NULL),
	(3, '웹 테스트', '웹 테스트', NULL, NULL),
	(4, '123421312', '3213123213123123', '', ''),
	(5, '123213', '12312312312312313', '', ''),
	(6, '234234234234234234', '312312312312314', '', ''),
	(7, '55555', '55555', '', ''),
	(8, 'ㅅㅅㅅㅅ', 'zzzz', NULL, NULL),
	(9, 'sdfgsdfgsdfg', 'sagagdgf', NULL, NULL),
	(10, 'zjsjsjjsjsjsj', 'zjsjsjjsjsjsj', '', ''),
	(11, 'zjjsjsjsjs', 'zjjsjsjsjs', '', ''),
	(12, 'djsjsjjss', 'djsjsjjss', '', ''),
	(13, '0000000000', '0000000000', '', ''),
	(14, '555555', '555555', '', ''),
	(15, '1111', '1111', '', ''),
	(16, '444', '444', '', ''),
	(17, '66666', '66666', '', ''),
	(18, 'djdjdjjdjd', 'djdjdjjdjd', '', ''),
	(19, 'yyyyyy', 'yyyyyy', '', ''),
	(20, '777', '777', '', ''),
	(21, '1234', '1234', NULL, NULL),
	(22, '1111', '1111', '', ''),
	(23, '00000', '00000', '', ''),
	(24, '44444', '44444', '', ''),
	(25, 'dhdhdhdj', 'dhdhdhdj', 'jpg', 'http://push.redsberry.co.kr/uploads/images/1560473581662_1560473581834.jpg'),
	(26, '1111111', '1111111', '', ''),
	(27, '222222', '222222', '', ''),
	(28, '111', '111', '', ''),
	(29, '888888', '888888', '', ''),
	(30, 'ㅜㅕㅕㅜㅕㅗㅕㅜㅜ', 'ㅜㅕㅕㅜㅕㅗㅕㅜㅜ', '', ''),
	(31, '8888888', '8888888', '', ''),
	(32, '1111111111', '1111111111', 'jpg', 'http://push.redsberry.co.kr/uploads/images/1560509160782_1560509161836.jpg'),
	(33, '111111', '111111', 'jpg', 'http://push.redsberry.co.kr/uploads/images/1560510768390_1560510769385.jpg'),
	(34, 'ㅑㅑㅑㅑㅑ', 'ㅑㅑㅑㅑㅑ', '', ''),
	(35, 'djdjdjjdj', 'djdjdjjdj', 'pdf', 'http://push.redsberry.co.kr/uploads/files/1560513211874_1560513212452.pdf'),
	(36, '1111', '1111', 'jpg', 'http://push.redsberry.co.kr/uploads/images/1560513327121_1560513327740.jpg'),
	(37, '00000', '00000', 'jpg', 'http://push.redsberry.co.kr/uploads/images/1560513414887_1560513415562.jpg'),
	(38, '11111', '11111', 'jpg', 'http://push.redsberry.co.kr/uploads/images/1560513545228_1560513545917.jpg'),
	(39, '0000', '0000', '', ''),
	(40, '0000000', '0000000', '', ''),
	(41, 'vvvvvvvv', 'vvvvvvvv', '', ''),
	(42, '0000', '0000', '', ''),
	(43, 'bugigig', 'bugigig', '', ''),
	(44, 'hhhhhh', 'hhhhhh', '', ''),
	(45, 'lllllllll', 'lllllllll', '', ''),
	(46, 'kkkk', 'kkkk', '', ''),
	(47, '40303030300', '40303030300', '', '');
/*!40000 ALTER TABLE `PM_MSGCNTS` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
