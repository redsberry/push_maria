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

-- 테이블 REDSPUSH.SN_CODE 구조 내보내기
CREATE TABLE IF NOT EXISTS `SN_CODE` (
  `CD_CLS` varchar(3) COLLATE utf8_bin NOT NULL COMMENT '코드 분류 ',
  `CMN_CD` varchar(15) COLLATE utf8_bin NOT NULL COMMENT '공통 코드 ',
  `CMN_CD_NM` varchar(200) COLLATE utf8_bin DEFAULT NULL COMMENT '공통 코드 명 ',
  `CMN_CD_ABB` varchar(200) COLLATE utf8_bin DEFAULT NULL COMMENT '공통 코드 약어 ',
  `CMN_CD_ANO` varchar(200) COLLATE utf8_bin DEFAULT NULL COMMENT '공통 코드 이명 ',
  `CMN_REL_CD` varchar(30) COLLATE utf8_bin DEFAULT NULL COMMENT '공통 연관 코드 ',
  `USE_YN` enum('Y','N') COLLATE utf8_bin DEFAULT NULL COMMENT '사용 여부',
  `SYS_YN` enum('Y','N') COLLATE utf8_bin DEFAULT NULL COMMENT '시스템 여부',
  `UPR_ID` varchar(80) COLLATE utf8_bin DEFAULT NULL COMMENT '수정자 ID ',
  `UPD_TS` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp() COMMENT '수정 일시',
  `REMARK` varchar(500) COLLATE utf8_bin DEFAULT NULL COMMENT '비고 ',
  PRIMARY KEY (`CD_CLS`,`CMN_CD`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='공통코드';

-- 테이블 데이터 REDSPUSH.SN_CODE:~7 rows (대략적) 내보내기
/*!40000 ALTER TABLE `SN_CODE` DISABLE KEYS */;
INSERT INTO `SN_CODE` (`CD_CLS`, `CMN_CD`, `CMN_CD_NM`, `CMN_CD_ABB`, `CMN_CD_ANO`, `CMN_REL_CD`, `USE_YN`, `SYS_YN`, `UPR_ID`, `UPD_TS`, `REMARK`) VALUES
	('STS', '01', '사용', '', '', NULL, 'Y', 'Y', 'admin', '2019-04-08 17:50:08', NULL),
	('STS', '02', '휴직', NULL, NULL, NULL, 'Y', 'Y', 'admin', '2019-01-05 00:00:00', NULL),
	('STS', '03', '퇴직', NULL, NULL, NULL, 'Y', 'Y', 'admin', '2019-01-05 00:00:00', NULL),
	('STS', '04', '일시정지', '', '', NULL, 'Y', 'Y', 'admin', '2019-04-08 17:50:08', NULL),
	('aaa', '00001', '1234', '1234', '1234', '1', 'Y', NULL, 'tjdtmddn', '2019-03-29 23:14:22', '1'),
	('aaa', '00006', '5', '5', '5', '5', 'Y', NULL, 'tjdtmddn', '2019-04-09 09:52:47', '5');
/*!40000 ALTER TABLE `SN_CODE` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
