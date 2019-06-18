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

-- 테이블 REDSPUSH.SN_CODECAT 구조 내보내기
CREATE TABLE IF NOT EXISTS `SN_CODECAT` (
  `CD_CLS` varchar(3) COLLATE utf8_bin NOT NULL COMMENT '코드 분류 ',
  `CD_CLS_NM` varchar(60) COLLATE utf8_bin DEFAULT NULL COMMENT '코드 분류 명 ',
  `USE_YN` enum('Y','N') COLLATE utf8_bin DEFAULT NULL COMMENT '사용 여부',
  `SYS_YN` enum('Y','N') COLLATE utf8_bin DEFAULT NULL COMMENT '시스템 여부',
  `REMARK` varchar(500) COLLATE utf8_bin DEFAULT NULL COMMENT '비고 ',
  `UPR_ID` varchar(80) COLLATE utf8_bin DEFAULT NULL COMMENT '수정자 ID ',
  `UPD_TS` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp() COMMENT '수정 일시',
  PRIMARY KEY (`CD_CLS`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='공통코드분류';

-- 테이블 데이터 REDSPUSH.SN_CODECAT:~4 rows (대략적) 내보내기
/*!40000 ALTER TABLE `SN_CODECAT` DISABLE KEYS */;
INSERT INTO `SN_CODECAT` (`CD_CLS`, `CD_CLS_NM`, `USE_YN`, `SYS_YN`, `REMARK`, `UPR_ID`, `UPD_TS`) VALUES
	('111', 'aaaa', 'Y', NULL, 'nn', 'tjdtmddn', '2019-04-09 09:47:26'),
	('RNK', '직급', 'Y', 'Y', '직급 코드', 'admin', '2019-01-10 19:17:36'),
	('STS', '사용자 상태', 'Y', 'Y', '상태코드', 'admin', '2019-03-29 19:36:31'),
	('aaa', '1234', 'Y', NULL, '1234', 'tjdtmddn', '2019-03-29 23:12:56');
/*!40000 ALTER TABLE `SN_CODECAT` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
