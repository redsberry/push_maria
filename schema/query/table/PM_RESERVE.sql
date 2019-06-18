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

-- 테이블 REDSPUSH.PM_RESERVE 구조 내보내기
CREATE TABLE IF NOT EXISTS `PM_RESERVE` (
  `MNG_NO` int(11) NOT NULL AUTO_INCREMENT COMMENT '관리 번호 ',
  `MSGPLN_NO` int(11) DEFAULT NULL COMMENT '메시지계획 번호 ',
  `TRNS_START_TS` timestamp NULL DEFAULT NULL COMMENT '전송 시작 일시 ',
  `TRNS_CAT_CD` varchar(1) COLLATE utf8_bin DEFAULT NULL COMMENT '전송 유형 코드 / [P:PUSH, S:SMS, M:MMS]',
  `SND_USR_ID` varchar(80) COLLATE utf8_bin DEFAULT NULL COMMENT '송신 사용자 ID ',
  `RCV_USR_ID_LIST` text COLLATE utf8_bin DEFAULT NULL COMMENT '수신 사용자 ID 목록 ',
  `MSG_CAT` varchar(1) COLLATE utf8_bin DEFAULT NULL COMMENT '메시지 유형 / [A:광고, B:업무, C:일정, E:기타]',
  `TRNS_MTHD_TYPE` varchar(1) COLLATE utf8_bin DEFAULT NULL COMMENT '전송 방법 구분 / 전송할 방법 [P:반복발송, R:예약발송]',
  `RPT_TRNS_RULE` varchar(20) COLLATE utf8_bin DEFAULT NULL COMMENT '반복 전송 규칙 ',
  `RESE_TRNS_TS` timestamp NULL DEFAULT NULL COMMENT '예약 전송 일시 ',
  PRIMARY KEY (`MNG_NO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='예약메시지';

-- 테이블 데이터 REDSPUSH.PM_RESERVE:~0 rows (대략적) 내보내기
/*!40000 ALTER TABLE `PM_RESERVE` DISABLE KEYS */;
/*!40000 ALTER TABLE `PM_RESERVE` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
