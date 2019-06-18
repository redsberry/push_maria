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

-- 테이블 REDSPUSH.PM_ERRLOG 구조 내보내기
CREATE TABLE IF NOT EXISTS `PM_ERRLOG` (
  `FAIL_LOG_NO` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '실패 로그 번호',
  `TRNS_NO` int(10) unsigned NOT NULL COMMENT '전송 번호',
  `LOG_TS` timestamp NULL DEFAULT NULL COMMENT '로그 일시 ',
  `ERROR_CD` varchar(5) COLLATE utf8_bin DEFAULT NULL COMMENT '오류 코드 ',
  `ERROR_CTNTS` varchar(200) COLLATE utf8_bin DEFAULT NULL COMMENT '오류 내용 ',
  `RETRY_SEQ` int(11) DEFAULT NULL COMMENT '재시도 순번 ',
  PRIMARY KEY (`FAIL_LOG_NO`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='메시지전송오류';

-- 테이블 데이터 REDSPUSH.PM_ERRLOG:0 rows 내보내기
/*!40000 ALTER TABLE `PM_ERRLOG` DISABLE KEYS */;
/*!40000 ALTER TABLE `PM_ERRLOG` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
