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

-- 테이블 REDSPUSH.BD_MANAGE 구조 내보내기
CREATE TABLE IF NOT EXISTS `BD_MANAGE` (
  `BRD_CD` varchar(5) COLLATE utf8_bin NOT NULL COMMENT '게시판 관리번호',
  `BRD_TYPE_CD` varchar(1) COLLATE utf8_bin DEFAULT NULL COMMENT '게시판 구분 코드 ',
  `BRD_DESC` varchar(500) COLLATE utf8_bin DEFAULT NULL COMMENT '게시판 설명 ',
  `BRD_NM` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '게시판 이름 ',
  `ANS_ENA_YN` enum('Y','N') COLLATE utf8_bin DEFAULT NULL COMMENT '답변 가능 여부',
  `RPY_ENA_YN` enum('Y','N') COLLATE utf8_bin DEFAULT NULL COMMENT '댓글 가능 여부',
  `USE_YN` enum('Y','N') COLLATE utf8_bin DEFAULT NULL COMMENT '사용 여부',
  `SYS_YN` enum('Y','N') COLLATE utf8_bin DEFAULT NULL COMMENT '시스템 여부',
  `RER_ID` varchar(80) COLLATE utf8_bin DEFAULT NULL COMMENT '등록자 ID ',
  `REG_TS` timestamp NOT NULL DEFAULT current_timestamp() COMMENT '생성 일시',
  `UPD_TS` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp() COMMENT '수정 일시',
  PRIMARY KEY (`BRD_CD`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='게시판관리';

-- 테이블 데이터 REDSPUSH.BD_MANAGE:~3 rows (대략적) 내보내기
/*!40000 ALTER TABLE `BD_MANAGE` DISABLE KEYS */;
INSERT INTO `BD_MANAGE` (`BRD_CD`, `BRD_TYPE_CD`, `BRD_DESC`, `BRD_NM`, `ANS_ENA_YN`, `RPY_ENA_YN`, `USE_YN`, `SYS_YN`, `RER_ID`, `REG_TS`, `UPD_TS`) VALUES
	('BBS01', 'C', '공지사항 게시판', '공지사항', 'N', 'Y', 'Y', 'Y', 'admin', '2018-05-08 00:00:00', '2019-03-29 10:40:14'),
	('BBS02', 'Q', '질문 답변 게시판', 'Q&A', 'Y', 'Y', 'Y', 'Y', 'admin', '2018-07-17 00:00:00', '2018-07-31 00:00:00'),
	('BBS03', 'S', '시스템 장애 신고 게시판', '시스템 장애 신고', 'Y', 'Y', 'Y', 'Y', 'admin', '2018-07-17 00:00:00', '2019-01-18 19:41:12');
/*!40000 ALTER TABLE `BD_MANAGE` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
