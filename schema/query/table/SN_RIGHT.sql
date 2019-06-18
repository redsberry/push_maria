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

-- 테이블 REDSPUSH.SN_RIGHT 구조 내보내기
CREATE TABLE IF NOT EXISTS `SN_RIGHT` (
  `USR_ID` varchar(80) COLLATE utf8_bin NOT NULL COMMENT '사용자 ID ',
  `RIG_GRP_CD` varchar(3) COLLATE utf8_bin NOT NULL COMMENT '권한 그룹 코드 ',
  `USE_YN` enum('Y','N') COLLATE utf8_bin DEFAULT NULL COMMENT '사용 여부',
  `UPR_ID` varchar(80) COLLATE utf8_bin DEFAULT NULL COMMENT '수정자 ID ',
  `REG_TS` timestamp NOT NULL DEFAULT current_timestamp() COMMENT '등록 일시',
  `UPD_TS` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp() COMMENT '수정 일시',
  PRIMARY KEY (`USR_ID`,`RIG_GRP_CD`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='사용별권한';

-- 테이블 데이터 REDSPUSH.SN_RIGHT:~8 rows (대략적) 내보내기
/*!40000 ALTER TABLE `SN_RIGHT` DISABLE KEYS */;
INSERT INTO `SN_RIGHT` (`USR_ID`, `RIG_GRP_CD`, `USE_YN`, `UPR_ID`, `REG_TS`, `UPD_TS`) VALUES
	('admin@eberry.co.kr', 'RG2', 'Y', 'admin@eberry.co.kr', '2019-06-07 14:23:02', '2019-06-07 14:23:02'),
	('dockertablet@eberry.co.kr', 'RG4', 'Y', 'admin@eberry.co.kr', '2019-06-15 18:41:58', '2019-06-15 18:41:58'),
	('jhlee@eberry.co.kr', 'RG4', 'Y', 'admin@eberry.co.kr', '2019-06-07 14:24:39', '2019-06-07 14:24:39'),
	('oslee97@eberry.co.kr', 'RG1', 'Y', 'oslee97@eberry.co.kr', '2019-06-17 10:53:26', '2019-06-17 10:58:29'),
	('skarjsdn', 'RG2', 'Y', 'skarjsdn', '2019-06-17 10:52:35', '2019-06-17 10:52:35'),
	('skarjsdn', 'RG4', 'Y', 'admin@eberry.co.kr', '2019-06-17 10:52:35', '2019-06-17 10:52:35'),
	('sos22233@eberry.co.kr', 'RG4', 'Y', 'sos22233@eberry.co.kr', '2019-06-12 14:29:52', '2019-06-12 14:29:52'),
	('tjdtmddn@eberry.co.kr', 'RG4', 'Y', 'admin@eberry.co.kr', '2019-06-07 14:24:37', '2019-06-07 14:24:37');
/*!40000 ALTER TABLE `SN_RIGHT` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
