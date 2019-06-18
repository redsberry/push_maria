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

-- 테이블 REDSPUSH.PM_MSGPLAN 구조 내보내기
CREATE TABLE IF NOT EXISTS `PM_MSGPLAN` (
  `TRNS_NO` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '전송 번호',
  `MSGPLN_NO` int(10) unsigned DEFAULT NULL COMMENT '메시지계획 번호',
  `TRNS_REQ_TS` timestamp NULL DEFAULT NULL COMMENT '전송 요청 일시 ',
  `TRNS_CAT_CD` varchar(1) COLLATE utf8_bin DEFAULT NULL COMMENT '전송 유형 코드 / [P:PUSH, S:SMS, M:MMS]',
  `TRNS_STE` varchar(1) COLLATE utf8_bin DEFAULT NULL COMMENT '전송 상태 / [S:성공,F:실패, N:발송대기(발송중)]\r\n',
  `SND_USR_ID` varchar(80) COLLATE utf8_bin NOT NULL COMMENT '송신 사용자 ID ',
  `RCV_USR_ID_LIST` text COLLATE utf8_bin DEFAULT NULL COMMENT '수신 사용자 ID 목록 ',
  `TRNS_CMPT_YN` enum('Y','N') COLLATE utf8_bin DEFAULT NULL COMMENT '전송 완료 여부',
  `TRNS_MTHD_TYPE` enum('D','P','R') COLLATE utf8_bin DEFAULT NULL COMMENT '전송 방법 구분 / [D:즉시발송, P:반복발송, R:예약발송]',
  `MSG_CAT` enum('A','B','C','E') COLLATE utf8_bin DEFAULT NULL COMMENT '메시지 유형 / [A:광고, B:업무, C:일정, E:기타]',
  `RPT_TRNS_RULE` varchar(20) COLLATE utf8_bin DEFAULT NULL COMMENT '반복 전송 규칙',
  `RETRY_SEQ` int(11) DEFAULT NULL COMMENT '재시도 순번 ',
  `RESE_TRNS_TS` timestamp NULL DEFAULT NULL COMMENT '예약 전송 일시',
  `PUSH_TRNS_YN` enum('Y','N') COLLATE utf8_bin DEFAULT NULL COMMENT 'PUSH 전송 여부',
  `SMS_TRNS_YN` enum('Y','N') COLLATE utf8_bin DEFAULT NULL COMMENT 'SMS 전송 여부',
  PRIMARY KEY (`TRNS_NO`)
) ENGINE=MyISAM AUTO_INCREMENT=48 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='메시지전송계획';

-- 테이블 데이터 REDSPUSH.PM_MSGPLAN:47 rows 내보내기
/*!40000 ALTER TABLE `PM_MSGPLAN` DISABLE KEYS */;
INSERT INTO `PM_MSGPLAN` (`TRNS_NO`, `MSGPLN_NO`, `TRNS_REQ_TS`, `TRNS_CAT_CD`, `TRNS_STE`, `SND_USR_ID`, `RCV_USR_ID_LIST`, `TRNS_CMPT_YN`, `TRNS_MTHD_TYPE`, `MSG_CAT`, `RPT_TRNS_RULE`, `RETRY_SEQ`, `RESE_TRNS_TS`, `PUSH_TRNS_YN`, `SMS_TRNS_YN`) VALUES
	(1, 0, '2019-06-07 14:25:37', 'P', 'S', 'jhlee@eberry.co.kr', 'skarjsdn;tjdtmddn@eberry.co.kr', 'Y', NULL, NULL, NULL, 0, NULL, NULL, NULL),
	(2, 0, '2019-06-07 14:26:06', 'P', 'S', 'jhlee@eberry.co.kr', 'tjdtmddn@eberry.co.kr', 'Y', 'D', 'C', NULL, NULL, NULL, 'Y', 'N'),
	(3, 0, '2019-06-07 14:27:07', 'P', 'S', 'jhlee@eberry.co.kr', 'tjdtmddn@eberry.co.kr;skarjsdn', 'Y', 'D', 'C', NULL, NULL, NULL, 'Y', 'N'),
	(4, 0, '2019-06-07 15:00:45', 'P', 'S', 'tjdtmddn@eberry.co.kr', 'jhlee@eberry.co.kr', 'Y', NULL, NULL, NULL, 0, NULL, NULL, NULL),
	(5, 0, '2019-06-07 15:01:04', 'P', 'S', 'tjdtmddn@eberry.co.kr', 'admin@eberry.co.kr;jhlee@eberry.co.kr;skarjsdn', 'Y', NULL, NULL, NULL, 0, NULL, NULL, NULL),
	(6, 0, '2019-06-07 15:02:35', 'P', 'S', 'tjdtmddn@eberry.co.kr', 'jhlee@eberry.co.kr;skarjsdn', 'Y', NULL, NULL, NULL, 0, NULL, NULL, NULL),
	(7, 0, '2019-06-07 15:54:27', 'P', 'S', 'jhlee@eberry.co.kr', 'tjdtmddn@eberry.co.kr;skarjsdn', 'Y', NULL, NULL, NULL, 0, NULL, NULL, NULL),
	(8, 0, '2019-06-11 10:49:59', 'P', 'S', 'skarjsdn', 'jhlee@eberry.co.kr', 'Y', 'D', 'C', NULL, NULL, NULL, 'Y', 'N'),
	(9, 0, '2019-06-12 14:30:17', 'P', 'S', 'sos22233@eberry.co.kr', 'tjdtmddn@eberry.co.kr', 'Y', 'D', 'C', NULL, NULL, NULL, 'Y', 'N'),
	(10, 0, '2019-06-12 18:36:02', 'P', 'S', 'tjdtmddn@eberry.co.kr', 'tablet@eberry.co.kr', 'Y', NULL, NULL, NULL, 0, NULL, NULL, NULL),
	(11, 0, '2019-06-13 14:14:21', 'P', 'S', 'tjdtmddn@eberry.co.kr', 'tablet@eberry.co.kr', 'Y', NULL, NULL, NULL, 0, NULL, NULL, NULL),
	(12, 0, '2019-06-13 14:16:53', 'P', 'S', 'tjdtmddn@eberry.co.kr', 'tablet@eberry.co.kr', 'Y', NULL, NULL, NULL, 0, NULL, NULL, NULL),
	(13, 0, '2019-06-13 14:17:31', 'P', 'S', 'tjdtmddn@eberry.co.kr', 'tablet@eberry.co.kr', 'Y', NULL, NULL, NULL, 0, NULL, NULL, NULL),
	(14, 0, '2019-06-13 14:18:20', 'P', 'S', 'tjdtmddn@eberry.co.kr', 'tablet@eberry.co.kr', 'Y', NULL, NULL, NULL, 0, NULL, NULL, NULL),
	(15, 0, '2019-06-13 14:20:15', 'P', 'S', 'tjdtmddn@eberry.co.kr', 'tablet@eberry.co.kr', 'Y', NULL, NULL, NULL, 0, NULL, NULL, NULL),
	(16, 0, '2019-06-13 17:36:33', 'P', 'S', 'tjdtmddn@eberry.co.kr', 'tablet@eberry.co.kr', 'Y', NULL, NULL, NULL, 0, NULL, NULL, NULL),
	(17, 0, '2019-06-13 17:42:32', 'P', 'S', 'tjdtmddn@eberry.co.kr', 'tablet@eberry.co.kr', 'Y', NULL, NULL, NULL, 0, NULL, NULL, NULL),
	(18, 0, '2019-06-13 17:45:05', 'P', 'S', 'tjdtmddn@eberry.co.kr', 'tablet@eberry.co.kr', 'Y', NULL, NULL, NULL, 0, NULL, NULL, NULL),
	(19, 0, '2019-06-13 17:45:59', 'P', 'S', 'tjdtmddn@eberry.co.kr', 'tablet@eberry.co.kr', 'Y', NULL, NULL, NULL, 0, NULL, NULL, NULL),
	(20, 0, '2019-06-13 17:50:40', 'P', 'S', 'tjdtmddn@eberry.co.kr', 'tablet@eberry.co.kr', 'Y', NULL, NULL, NULL, 0, NULL, NULL, NULL),
	(21, 0, '2019-06-13 17:55:15', 'P', 'S', 'sos22233@eberry.co.kr', 'tablet@eberry.co.kr', 'Y', 'D', 'C', NULL, NULL, NULL, 'Y', 'N'),
	(22, 0, '2019-06-13 18:11:15', 'P', 'S', 'tjdtmddn@eberry.co.kr', 'tablet@eberry.co.kr', 'Y', NULL, NULL, NULL, 0, NULL, NULL, NULL),
	(23, 0, '2019-06-14 09:23:01', 'P', 'S', 'tjdtmddn@eberry.co.kr', 'tablet@eberry.co.kr', 'Y', NULL, NULL, NULL, 0, NULL, NULL, NULL),
	(24, 0, '2019-06-14 09:23:41', 'P', 'S', 'tjdtmddn@eberry.co.kr', 'tablet@eberry.co.kr', 'Y', NULL, NULL, NULL, 0, NULL, NULL, NULL),
	(25, 0, '2019-06-14 09:53:07', 'P', 'S', 'tjdtmddn@eberry.co.kr', 'tablet@eberry.co.kr', 'Y', NULL, NULL, NULL, 0, NULL, NULL, NULL),
	(26, 0, '2019-06-14 19:24:54', 'P', 'S', 'tablet@eberry.co.kr', 'tjdtmddn@eberry.co.kr', 'Y', NULL, NULL, NULL, 0, NULL, NULL, NULL),
	(27, 0, '2019-06-14 19:30:31', 'P', 'S', 'tablet@eberry.co.kr', 'tjdtmddn@eberry.co.kr', 'Y', NULL, NULL, NULL, 0, NULL, NULL, NULL),
	(28, 0, '2019-06-14 19:33:25', 'P', 'S', 'tablet@eberry.co.kr', 'tjdtmddn@eberry.co.kr', 'Y', NULL, NULL, NULL, 0, NULL, NULL, NULL),
	(29, 0, '2019-06-14 19:37:14', 'P', 'S', 'tablet@eberry.co.kr', 'tjdtmddn@eberry.co.kr', 'Y', NULL, NULL, NULL, 0, NULL, NULL, NULL),
	(30, 0, '2019-06-14 19:40:37', 'P', 'S', 'tablet@eberry.co.kr', 'tjdtmddn@eberry.co.kr', 'Y', NULL, NULL, NULL, 0, NULL, NULL, NULL),
	(31, 0, '2019-06-14 19:42:56', 'P', 'S', 'tablet@eberry.co.kr', 'tjdtmddn@eberry.co.kr', 'Y', NULL, NULL, NULL, 0, NULL, NULL, NULL),
	(32, 0, '2019-06-14 19:46:05', 'P', 'S', 'tablet@eberry.co.kr', 'tjdtmddn@eberry.co.kr;jhlee@eberry.co.kr', 'Y', NULL, NULL, NULL, 0, NULL, NULL, NULL),
	(33, 0, '2019-06-14 20:12:57', 'P', 'S', 'tablet2@eberry.co.kr', 'tjdtmddn@eberry.co.kr;jhlee@eberry.co.kr', 'Y', NULL, NULL, NULL, 0, NULL, NULL, NULL),
	(34, 0, '2019-06-14 20:43:00', 'P', 'S', 'tablet2@eberry.co.kr', 'tjdtmddn@eberry.co.kr', 'Y', NULL, NULL, NULL, 0, NULL, NULL, NULL),
	(35, 0, '2019-06-14 20:53:38', 'P', 'S', 'tjdtmddn@eberry.co.kr', 'tablet2@eberry.co.kr', 'Y', NULL, NULL, NULL, 0, NULL, NULL, NULL),
	(36, 0, '2019-06-14 20:55:29', 'P', 'S', 'tjdtmddn@eberry.co.kr', 'tablet2@eberry.co.kr', 'Y', NULL, NULL, NULL, 0, NULL, NULL, NULL),
	(37, 0, '2019-06-14 20:56:56', 'P', 'S', 'tjdtmddn@eberry.co.kr', 'tablet2@eberry.co.kr', 'Y', NULL, NULL, NULL, 0, NULL, NULL, NULL),
	(38, 0, '2019-06-14 20:59:06', 'P', 'S', 'tjdtmddn@eberry.co.kr', 'tablet@eberry.co.kr', 'Y', NULL, NULL, NULL, 0, NULL, NULL, NULL),
	(39, 0, '2019-06-15 16:35:14', 'P', 'S', 'tjdtmddn@eberry.co.kr', 'tablet@eberry.co.kr', 'Y', NULL, NULL, NULL, 0, NULL, NULL, NULL),
	(40, 0, '2019-06-15 16:49:53', 'P', 'S', 'tjdtmddn@eberry.co.kr', 'tablet@eberry.co.kr', 'Y', NULL, NULL, NULL, 0, NULL, NULL, NULL),
	(41, 0, '2019-06-15 16:51:59', 'P', 'S', 'tjdtmddn@eberry.co.kr', 'tablet@eberry.co.kr', 'Y', NULL, NULL, NULL, 0, NULL, NULL, NULL),
	(42, 0, '2019-06-15 16:54:11', 'P', 'S', 'tjdtmddn@eberry.co.kr', 'tablet@eberry.co.kr', 'Y', NULL, NULL, NULL, 0, NULL, NULL, NULL),
	(43, 0, '2019-06-15 16:57:21', 'P', 'S', 'tjdtmddn@eberry.co.kr', 'tablet@eberry.co.kr', 'Y', NULL, NULL, NULL, 0, NULL, NULL, NULL),
	(44, 0, '2019-06-15 16:59:09', 'P', 'S', 'tjdtmddn@eberry.co.kr', 'tablet@eberry.co.kr', 'Y', NULL, NULL, NULL, 0, NULL, NULL, NULL),
	(45, 0, '2019-06-15 17:02:43', 'P', 'S', 'tjdtmddn@eberry.co.kr', 'tablet@eberry.co.kr', 'Y', NULL, NULL, NULL, 0, NULL, NULL, NULL),
	(46, 0, '2019-06-15 17:04:24', 'P', 'S', 'tjdtmddn@eberry.co.kr', 'tablet@eberry.co.kr', 'Y', NULL, NULL, NULL, 0, NULL, NULL, NULL),
	(47, 0, '2019-06-15 17:05:44', 'P', 'S', 'tjdtmddn@eberry.co.kr', 'tablet@eberry.co.kr', 'Y', NULL, NULL, NULL, 0, NULL, NULL, NULL);
/*!40000 ALTER TABLE `PM_MSGPLAN` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
