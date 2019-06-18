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

-- 테이블 REDSPUSH.PM_TMPLATMSG 구조 내보내기
CREATE TABLE IF NOT EXISTS `PM_TMPLATMSG` (
  `MSGPLN_NO` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '메시지계획 번호',
  `WTR_ID` varchar(80) COLLATE utf8_bin DEFAULT NULL COMMENT '작성자 ID ',
  `RCVGRP_NO` int(10) unsigned NOT NULL COMMENT '수신그룹 번호',
  `TMPLAT_NM` varchar(40) COLLATE utf8_bin DEFAULT NULL COMMENT '템플릿 명',
  `TRNS_MTHD_TYPE` enum('D','P','R') COLLATE utf8_bin DEFAULT NULL COMMENT '전송 방법 구분 / [D:즉시발송, P:반복발송, R:예약발송]',
  `RPT_TRNS_RULE` varchar(20) COLLATE utf8_bin DEFAULT NULL COMMENT '반복 전송 규칙',
  `RESE_TRNS_TS` timestamp NULL DEFAULT NULL COMMENT '예약 전송 일시',
  `PUSH_TRNS_YN` enum('Y','N') COLLATE utf8_bin DEFAULT NULL COMMENT 'PUSH 전송 여부',
  `SMS_TRNS_YN` enum('Y','N') COLLATE utf8_bin DEFAULT NULL COMMENT 'SMS 전송 여부',
  `MSG_CTNTS_CAT` enum('A','B','C','E') COLLATE utf8_bin DEFAULT NULL COMMENT '메시지 내용 유형 / [A:광고, B:업무, C:일정, E:기타]',
  `MSG_CTNTS_ATTR` enum('P','H') COLLATE utf8_bin DEFAULT NULL COMMENT '메시지 내용 속성 / [P:Plain text, H:HTML]',
  `MSG_SUBJ` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '메시지 제목 ',
  `MSG_CTNTS` text COLLATE utf8_bin DEFAULT NULL COMMENT '메시지 내용 ',
  `ATT_CAT_EXT` varchar(5) COLLATE utf8_bin DEFAULT NULL COMMENT '첨부 유형 확장자',
  `ATT_FILE_PATH` varchar(256) COLLATE utf8_bin DEFAULT NULL COMMENT '첨부 파일 경로 ',
  `REG_TS` timestamp NOT NULL DEFAULT current_timestamp() COMMENT '등록 일시',
  `UPD_TS` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp() COMMENT '수정 일시',
  PRIMARY KEY (`MSGPLN_NO`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='메시지템플릿';

-- 테이블 데이터 REDSPUSH.PM_TMPLATMSG:~20 rows (대략적) 내보내기
/*!40000 ALTER TABLE `PM_TMPLATMSG` DISABLE KEYS */;
INSERT INTO `PM_TMPLATMSG` (`MSGPLN_NO`, `WTR_ID`, `RCVGRP_NO`, `TMPLAT_NM`, `TRNS_MTHD_TYPE`, `RPT_TRNS_RULE`, `RESE_TRNS_TS`, `PUSH_TRNS_YN`, `SMS_TRNS_YN`, `MSG_CTNTS_CAT`, `MSG_CTNTS_ATTR`, `MSG_SUBJ`, `MSG_CTNTS`, `ATT_CAT_EXT`, `ATT_FILE_PATH`, `REG_TS`, `UPD_TS`) VALUES
	(1, 'oslee97', 1, NULL, 'D', NULL, NULL, 'Y', 'N', 'A', 'P', '즉시발송 템플릿 테스트', '즉시발송 템플릿 테스트', 'X', NULL, '2019-01-16 18:20:05', '2019-01-18 18:44:51'),
	(2, 'oslee97', 2, NULL, 'R', NULL, '2019-01-23 12:00:00', 'Y', 'Y', 'A', 'P', '예약발송 템플릿 테스트', '예약발송 템플릿 테스트', 'X', NULL, '2019-01-16 18:20:57', '2019-01-18 18:44:51'),
	(3, 'oslee97', 3, '반복 발송 템플릿', 'P', '* 12 * * 1234560', NULL, 'Y', 'N', 'A', 'P', '템플릿 저장 테스트', '템플릿 저장 테스트', NULL, NULL, '2019-01-22 14:57:22', '2019-01-22 14:57:22'),
	(4, 'oslee97', 4, '파일 첨부 템플릿', 'D', NULL, NULL, 'Y', 'N', 'A', 'P', '템플릿 첨부파일 저장 테스트', '템플릿 첨부파일 저장 테스트\n어떤 파일을 첨부해 볼까요', 'JPG', 'files/uploads/images/1548314903861_img_sample01.jpg', '2019-01-24 16:28:23', '2019-01-24 16:28:23'),
	(5, 'oslee97', 5, '', 'D', NULL, NULL, 'Y', 'Y', 'A', 'P', '테스트', '앵귤러', NULL, NULL, '2019-04-04 20:06:15', '2019-04-04 20:06:15'),
	(6, 'oslee97', 6, '앵귤러 템플릿', 'D', NULL, NULL, 'Y', 'Y', 'A', 'P', '앵귤러 테스트fdfddfdfdf', '앵귤러 테스트fdfddfdfdf', NULL, NULL, '2019-04-04 20:15:18', '2019-04-08 15:16:09'),
	(7, 'oslee97', 7, 'test', 'D', NULL, NULL, 'Y', 'Y', 'A', 'P', 'test', 'test', NULL, NULL, '2019-04-04 20:36:21', '2019-04-04 20:36:21'),
	(8, 'oslee97', 8, '파일다운로드', 'D', NULL, NULL, 'Y', 'Y', 'A', 'P', 'angular', '파일 다운로드 테스트', 'TXT', 'files/uploads/files/1554428579131_112시스템 서버 접속 및 운영 방법.txt', '2019-04-05 10:42:54', '2019-04-05 10:42:54'),
	(9, 'oslee97', 9, '반복발송 테스트', 'P', '12 12 * * 1234560', NULL, 'Y', 'Y', 'A', 'P', '반복발송 테스트', '반복발송 테스트', NULL, NULL, '2019-04-09 16:30:59', '2019-04-09 16:31:59'),
	(10, 'tjdtmddn', 10, '즉시발송 템플릿', 'D', NULL, NULL, 'Y', 'Y', 'A', 'P', '22222222222222222', '22222222222', NULL, NULL, '2019-04-10 19:49:40', '2019-04-10 20:08:37'),
	(11, 'tjdtmddn', 11, '매체테스트', 'R', NULL, '2019-04-10 11:11:00', 'Y', 'Y', 'C', 'P', '확인합시다', '매체 테스트', NULL, NULL, '2019-04-10 19:58:40', '2019-04-10 20:09:48'),
	(12, 'tjdtmddn', 12, '자동저장테스트', 'D', NULL, NULL, 'Y', 'Y', 'E', 'P', '자동저장 테스트', '자동저장 테스트', NULL, NULL, '2019-04-10 21:17:28', '2019-04-10 21:17:28'),
	(13, 'tjdtmddn', 13, '123', 'D', NULL, NULL, 'Y', 'Y', 'C', 'P', 'ㅁㅁㅁㅁㅁㅁㅁㅁ', 'ㅁㅁㅁㅁㅁㅁㅁ', NULL, NULL, '2019-04-11 10:20:25', '2019-04-11 10:20:25'),
	(14, 'oslee97', 14, 'test', 'D', NULL, NULL, 'Y', 'Y', 'A', 'P', '1111111', '1111111', NULL, NULL, '2019-04-11 10:25:29', '2019-04-11 10:25:29'),
	(15, 'oslee97', 15, '', 'D', NULL, NULL, 'Y', 'Y', 'A', 'P', 'testt1111111', 'testt1111111', NULL, NULL, '2019-04-11 10:27:21', '2019-04-11 10:27:21'),
	(16, 'oslee97', 16, '12345', 'D', NULL, NULL, 'Y', 'Y', 'A', 'P', 'testeeeee', 'testeeeee', NULL, NULL, '2019-04-11 11:39:30', '2019-04-11 11:39:30'),
	(17, 'tjdtmddn', 17, '즉발테스트', 'D', NULL, NULL, 'Y', 'N', 'A', 'P', '즉발 테스트', '즉시발송 테스트', NULL, NULL, '2019-04-11 11:54:36', '2019-04-11 11:54:36'),
	(18, 'tjdtmddn', 18, '', 'D', NULL, NULL, 'Y', 'N', 'A', 'P', '11', '11', NULL, NULL, '2019-04-11 11:56:27', '2019-04-11 11:56:27'),
	(19, 'tjdtmddn', 19, '', 'D', NULL, NULL, 'Y', 'N', 'A', 'P', '22', '22', NULL, NULL, '2019-04-11 12:08:03', '2019-04-11 12:08:03'),
	(20, 'tjdtmddn', 20, '첨부파일', 'D', NULL, NULL, 'Y', 'N', 'A', 'P', 'attach', '첨부파일 테스트', 'PNG', 'files/uploads/images/1555048191903_test.png', '2019-04-12 14:49:47', '2019-04-12 14:49:47'),
	(21, 'oslee97', 21, '반복발송', 'P', ' 12 *  1234560', NULL, 'Y', 'N', 'A', 'P', '반복발송 테스트', '반복발송 테스트', NULL, NULL, '2019-04-17 12:18:52', '2019-04-17 12:18:52'),
	(22, 'oslee97', 23, '', 'D', NULL, NULL, 'Y', 'N', 'A', 'P', 'llll', 'lll', NULL, NULL, '2019-04-30 21:02:49', '2019-04-30 21:02:49'),
	(23, 'admin', 24, '모지', 'D', NULL, NULL, 'Y', 'N', 'A', 'P', '가요?', '가요?', NULL, NULL, '2019-05-20 21:07:07', '2019-05-20 21:07:07');
/*!40000 ALTER TABLE `PM_TMPLATMSG` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
