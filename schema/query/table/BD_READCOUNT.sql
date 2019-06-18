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

-- 테이블 REDSPUSH.BD_READCOUNT 구조 내보내기
CREATE TABLE IF NOT EXISTS `BD_READCOUNT` (
  `BRD_CD` varchar(5) COLLATE utf8_bin NOT NULL COMMENT '게시판 코드 ',
  `USR_ID` varchar(80) COLLATE utf8_bin NOT NULL COMMENT '사용자 ID ',
  `UNREAD_CNT` int(11) DEFAULT NULL COMMENT '미확인 건수 ',
  PRIMARY KEY (`BRD_CD`,`USR_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='게시물확인건수';

-- 테이블 데이터 REDSPUSH.BD_READCOUNT:~9 rows (대략적) 내보내기
/*!40000 ALTER TABLE `BD_READCOUNT` DISABLE KEYS */;
INSERT INTO `BD_READCOUNT` (`BRD_CD`, `USR_ID`, `UNREAD_CNT`) VALUES
	('BBS01', '30', 1),
	('BBS01', 'admin', 1),
	('BBS01', 'dlqpfl', 1),
	('BBS01', 'jhlee@eberry.co.kr', 1),
	('BBS01', 'mhyoon', 1),
	('BBS01', 'null', 1),
	('BBS01', 'oslee97', 1),
	('BBS02', 'oslee97', 1),
	('BBS03', 'oslee97', 1);
/*!40000 ALTER TABLE `BD_READCOUNT` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
