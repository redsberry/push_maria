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

-- 테이블 REDSPUSH.SN_DEVICE 구조 내보내기
CREATE TABLE IF NOT EXISTS `SN_DEVICE` (
  `DVC_NO` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '장비 번호',
  `USR_ID` varchar(80) COLLATE utf8_bin NOT NULL COMMENT '사용자 ID ',
  `DVC_KIND` enum('P','M') COLLATE utf8_bin DEFAULT NULL COMMENT '장비 종류 / [P:PC/DeskTop, M:Mobile]',
  `DVC_UID` varchar(36) COLLATE utf8_bin DEFAULT NULL COMMENT '장비 UID ',
  `DVC_MNG_NM` varchar(40) COLLATE utf8_bin DEFAULT NULL COMMENT '장비 관리 명 ',
  `DVC_OS_CAT` enum('A','I','W','M','L') COLLATE utf8_bin DEFAULT NULL COMMENT '장비 OS 유형 / [A:Android, I:iOS, W:Windows, M:Mac, L:Linux]',
  `DVC_OS_VER` varchar(20) COLLATE utf8_bin DEFAULT NULL COMMENT '장비 OS 버전',
  `DVC_CONF_YN` char(1) COLLATE utf8_bin DEFAULT 'N' COMMENT '장비 승인여부',
  `DVC_USE_YN` char(1) COLLATE utf8_bin DEFAULT 'Y' COMMENT '장비 사용여부',
  `REG_TS` timestamp NOT NULL DEFAULT current_timestamp() COMMENT '등록 일시',
  PRIMARY KEY (`DVC_NO`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='디바이스';

-- 테이블 데이터 REDSPUSH.SN_DEVICE:~11 rows (대략적) 내보내기
/*!40000 ALTER TABLE `SN_DEVICE` DISABLE KEYS */;
INSERT INTO `SN_DEVICE` (`DVC_NO`, `USR_ID`, `DVC_KIND`, `DVC_UID`, `DVC_MNG_NM`, `DVC_OS_CAT`, `DVC_OS_VER`, `DVC_CONF_YN`, `DVC_USE_YN`, `REG_TS`) VALUES
	(1, 'tjdtmddn@eberry.co.kr', 'M', '574bf0123ffbbfe6', NULL, 'A', NULL, 'Y', 'Y', '2019-06-07 14:24:37'),
	(2, 'jhlee@eberry.co.kr', 'P', 'D05099AA0E8E', NULL, 'W', NULL, 'Y', 'Y', '2019-06-07 14:24:39'),
	(3, 'skarjsdn', 'M', 'B881FDD22BDE', NULL, 'I', NULL, 'Y', 'Y', '2019-06-07 14:24:54'),
	(4, 'jhlee@eberry.co.kr', 'M', 'e2396177460f80d6', NULL, 'A', NULL, 'N', 'Y', '2019-06-07 15:26:53'),
	(5, 'skarjsdn', 'M', 'EBDE74D61115', NULL, NULL, NULL, 'N', 'Y', '2019-06-11 10:21:25'),
	(6, 'skarjsdn', 'M', '169E1989DD25', NULL, NULL, NULL, 'N', 'Y', '2019-06-11 10:29:28'),
	(7, 'skarjsdn', 'M', '51049E3B76D5', NULL, NULL, NULL, 'N', 'Y', '2019-06-11 10:43:04'),
	(10, 'tjdtmddn@eberry.co.kr', 'M', 'f05264c6e0b847b9', NULL, 'A', NULL, 'N', 'Y', '2019-06-12 14:25:23'),
	(11, 'skarjsdn', 'M', '4CE5CB74BEC5', NULL, NULL, NULL, 'N', 'Y', '2019-06-12 15:48:36'),
	(14, 'tablet@eberry.co.kr', 'M', 'cf8d07b1dc93b470', NULL, NULL, NULL, 'N', 'Y', '2019-06-17 13:52:57'),
	(15, 'tablet@eberry.co.kr', 'M', '6b950e1c614d4864', NULL, NULL, NULL, 'N', 'Y', '2019-06-17 15:34:54');
/*!40000 ALTER TABLE `SN_DEVICE` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
