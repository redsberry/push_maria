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

-- 테이블 REDSPUSH.PM_SENDRST 구조 내보내기
CREATE TABLE IF NOT EXISTS `PM_SENDRST` (
  `SUCC_LOG_NO` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '성공 로그 번호',
  `TRNS_TS` timestamp NULL DEFAULT NULL COMMENT '전송 일시 ',
  `TRNS_SUCC_YN` enum('Y','N') COLLATE utf8_bin DEFAULT NULL COMMENT '전송 성공 여부',
  `SND_USR_ID` varchar(80) COLLATE utf8_bin DEFAULT NULL COMMENT '송신 사용자 ID ',
  `SND_CPNY_NO` int(10) unsigned NOT NULL COMMENT '송신 회사 번호',
  `SND_OS_CAT` enum('A','I','W','M','L') COLLATE utf8_bin DEFAULT NULL COMMENT '송신 OS 유형 / [A:Android, I:iOS, W:Windows, M:Mac, L:Linux]',
  `SND_OS_VER` varchar(20) COLLATE utf8_bin DEFAULT NULL COMMENT '송신 OS 버전 ',
  `SND_CAT_CD` enum('P','S','M') COLLATE utf8_bin DEFAULT NULL COMMENT '송신 유형 코드 / [P:PUSH, S:SMS, M:MMS]',
  `RCV_TS` timestamp NULL DEFAULT NULL COMMENT '수신 일시 ',
  `RCV_USR_ID` varchar(80) COLLATE utf8_bin DEFAULT NULL COMMENT '수신 사용자 ID ',
  `RCV_CPNY_NO` int(10) unsigned NOT NULL COMMENT '수신 회사 번호',
  `RCV_OS_CAT` enum('A','I','W','M','L') COLLATE utf8_bin DEFAULT NULL COMMENT '수신 OS 유형 / [A:Android, I:iOS, W:Windows, M:Mac, L:Linux]',
  `RCV_OS_VER` varchar(20) COLLATE utf8_bin DEFAULT NULL COMMENT '수신 OS 버전 ',
  `RCV_READING_YN` enum('Y','N') COLLATE utf8_bin DEFAULT NULL COMMENT '수신 열람 여부',
  `RESE_TRNS_YN` enum('Y','N') COLLATE utf8_bin DEFAULT NULL COMMENT '예약 전송 여부',
  `TRNS_NO` int(10) unsigned NOT NULL COMMENT '전송 번호',
  PRIMARY KEY (`SUCC_LOG_NO`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='메시지전송결과';

-- 테이블 데이터 REDSPUSH.PM_SENDRST:0 rows 내보내기
/*!40000 ALTER TABLE `PM_SENDRST` DISABLE KEYS */;
/*!40000 ALTER TABLE `PM_SENDRST` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
