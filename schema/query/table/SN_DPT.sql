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

-- 테이블 REDSPUSH.SN_DPT 구조 내보내기
CREATE TABLE IF NOT EXISTS `SN_DPT` (
  `DPT_NO` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '부서 코드',
  `CPNY_NO` int(10) unsigned NOT NULL COMMENT '회사 코드',
  `DPT_NM` varchar(80) COLLATE utf8_bin DEFAULT NULL COMMENT '부서 명 ',
  `DPT_TEL_NO` varchar(20) COLLATE utf8_bin DEFAULT NULL COMMENT '부서 전화 번호',
  `DPT_FAX_NO` varchar(20) COLLATE utf8_bin DEFAULT NULL COMMENT '부서 팩스 번호',
  `REG_TS` timestamp NOT NULL DEFAULT current_timestamp() COMMENT '등록 일시',
  `UPD_TS` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp() COMMENT '수정 일시',
  PRIMARY KEY (`DPT_NO`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='부서';

-- 테이블 데이터 REDSPUSH.SN_DPT:~3 rows (대략적) 내보내기
/*!40000 ALTER TABLE `SN_DPT` DISABLE KEYS */;
INSERT INTO `SN_DPT` (`DPT_NO`, `CPNY_NO`, `DPT_NM`, `DPT_TEL_NO`, `DPT_FAX_NO`, `REG_TS`, `UPD_TS`) VALUES
	(1, 1, '인사', NULL, NULL, '2019-06-07 14:23:02', '2019-06-07 14:23:02'),
	(2, 4, '연구소', NULL, NULL, '2019-06-07 15:29:37', '2019-06-07 15:29:37'),
	(3, 4, '인사', NULL, NULL, '2019-06-07 16:16:57', '2019-06-07 16:16:57');
/*!40000 ALTER TABLE `SN_DPT` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
