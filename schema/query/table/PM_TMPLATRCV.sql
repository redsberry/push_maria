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

-- 테이블 REDSPUSH.PM_TMPLATRCV 구조 내보내기
CREATE TABLE IF NOT EXISTS `PM_TMPLATRCV` (
  `RCVGRP_NO` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '수신그룹 번호',
  `WTR_ID` varchar(80) COLLATE utf8_bin DEFAULT NULL COMMENT '작성자 ID ',
  `RCVGRP_NM` varchar(20) COLLATE utf8_bin DEFAULT NULL COMMENT '수신그룹 명 ',
  `RCV_USR_ID_LIST` text COLLATE utf8_bin DEFAULT NULL COMMENT '수신 사용자 ID 목록 ',
  `REG_TS` timestamp NOT NULL DEFAULT current_timestamp() COMMENT '등록 일시',
  `UPD_TS` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp() COMMENT '수정 일시',
  PRIMARY KEY (`RCVGRP_NO`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='수신템플릿';

-- 테이블 데이터 REDSPUSH.PM_TMPLATRCV:~24 rows (대략적) 내보내기
/*!40000 ALTER TABLE `PM_TMPLATRCV` DISABLE KEYS */;
INSERT INTO `PM_TMPLATRCV` (`RCVGRP_NO`, `WTR_ID`, `RCVGRP_NM`, `RCV_USR_ID_LIST`, `REG_TS`, `UPD_TS`) VALUES
	(1, 'oslee97', NULL, '{"ITEM_CPNY":"1","ITEM_DIV":"D","ITEM_ID":"2","ITEM_NM":"연구소","ITEM_CNT":"1"},{"ITEM_CPNY":"1","ITEM_DIV":"D","ITEM_ID":"3","ITEM_NM":"SI사업팀","ITEM_CNT":"2"},{"ITEM_CPNY":"1","ITEM_DIV":"P","ITEM_ID":"mhyoon","ITEM_NM":"윤미호","ITEM_CNT":"1"}', '2019-01-16 18:20:05', '2019-01-18 18:44:49'),
	(2, 'oslee97', NULL, '{"ITEM_CPNY":"1","ITEM_DIV":"D","ITEM_ID":"2","ITEM_NM":"연구소","ITEM_CNT":"1"},{"ITEM_CPNY":"1","ITEM_DIV":"D","ITEM_ID":"3","ITEM_NM":"SI사업팀","ITEM_CNT":"2"},{"ITEM_CPNY":"1","ITEM_DIV":"P","ITEM_ID":"mhyoon","ITEM_NM":"윤미호","ITEM_CNT":"1"},{"ITEM_CPNY":"1","ITEM_DIV":"P","ITEM_ID":"tjdtmddn","ITEM_NM":"성승우","ITEM_CNT":"1"},{"ITEM_CPNY":"1","ITEM_DIV":"P","ITEM_ID":"kbjung","ITEM_NM":"정경배","ITEM_CNT":"1"}', '2019-01-16 18:20:57', '2019-01-18 18:44:49'),
	(3, 'oslee97', NULL, '{"ITEM_CPNY":"1","ITEM_DIV":"D","ITEM_ID":"2","ITEM_NM":"연구소","ITEM_CNT":"1"}', '2019-01-22 14:57:22', '2019-01-22 14:57:22'),
	(4, 'oslee97', NULL, '{"ITEM_CPNY":"1","ITEM_DIV":"P","ITEM_ID":"shpark","ITEM_NM":"박성현","ITEM_CNT":"1"}', '2019-01-24 16:28:23', '2019-01-24 16:28:23'),
	(5, 'oslee97', NULL, '{"RM":3,"ITEM_DIV":"D","ITEM_ID":"2","ITEM_NM":"연구소","NCKNM_NM":"(주)이베리","IMG_PATH":"","ITEM_DPT_NM":"연구소","CELL_NO":"","EMAIL_ADDR":"","REG_TS":"2019-01-000000","ITEM_CNT":1,"checked":true,"ITEM_CPNY":1},{"RM":4,"ITEM_DIV":"D","ITEM_ID":"3","ITEM_NM":"SI사업팀","NCKNM_NM":"(주)이베리","IMG_PATH":"","ITEM_DPT_NM":"SI사업팀","CELL_NO":"","EMAIL_ADDR":"","REG_TS":"2019-01-000000","ITEM_CNT":2,"checked":true,"ITEM_CPNY":1}', '2019-04-04 20:06:15', '2019-04-04 20:06:15'),
	(6, 'oslee97', NULL, '{"RM":3,"ITEM_DIV":"D","ITEM_ID":"2","ITEM_NM":"연구소","NCKNM_NM":"(주)이베리","IMG_PATH":"","ITEM_DPT_NM":"연구소","CELL_NO":"","EMAIL_ADDR":"","REG_TS":"2019-01-000000","ITEM_CNT":1,"checked":true,"ITEM_CPNY":1},{"RM":4,"ITEM_DIV":"D","ITEM_ID":"3","ITEM_NM":"SI사업팀","NCKNM_NM":"(주)이베리","IMG_PATH":"","ITEM_DPT_NM":"SI사업팀","CELL_NO":"","EMAIL_ADDR":"","REG_TS":"2019-01-000000","ITEM_CNT":2,"checked":true,"ITEM_CPNY":1}', '2019-04-04 20:15:18', '2019-04-08 15:16:09'),
	(7, 'oslee97', NULL, '{"RM":3,"ITEM_DIV":"D","ITEM_ID":"2","ITEM_NM":"연구소","NCKNM_NM":"(주)이베리","IMG_PATH":"","ITEM_DPT_NM":"연구소","CELL_NO":"","EMAIL_ADDR":"","REG_TS":"2019-01-000000","ITEM_CNT":1,"checked":true,"ITEM_CPNY":1},{"RM":4,"ITEM_DIV":"D","ITEM_ID":"3","ITEM_NM":"SI사업팀","NCKNM_NM":"(주)이베리","IMG_PATH":"","ITEM_DPT_NM":"SI사업팀","CELL_NO":"","EMAIL_ADDR":"","REG_TS":"2019-01-000000","ITEM_CNT":2,"checked":true,"ITEM_CPNY":1}', '2019-04-04 20:36:21', '2019-04-04 20:36:21'),
	(8, 'oslee97', NULL, '{"RM":3,"ITEM_DIV":"D","ITEM_ID":"2","ITEM_NM":"연구소","NCKNM_NM":"(주)이베리","IMG_PATH":"","ITEM_DPT_NM":"연구소","CELL_NO":"","EMAIL_ADDR":"","REG_TS":"2019-01-000000","ITEM_CNT":1,"checked":true,"ITEM_CPNY":1},{"RM":4,"ITEM_DIV":"D","ITEM_ID":"3","ITEM_NM":"SI사업팀","NCKNM_NM":"(주)이베리","IMG_PATH":"","ITEM_DPT_NM":"SI사업팀","CELL_NO":"","EMAIL_ADDR":"","REG_TS":"2019-01-000000","ITEM_CNT":2,"checked":true,"ITEM_CPNY":1}', '2019-04-05 10:42:54', '2019-04-05 10:42:54'),
	(9, 'oslee97', NULL, '{"RM":2,"ITEM_DIV":"D","ITEM_ID":"1","ITEM_NM":"모바일개발팀","NCKNM_NM":"(주)이베리","IMG_PATH":"","ITEM_DPT_NM":"모바일개발팀","CELL_NO":"","EMAIL_ADDR":"","REG_TS":"2019-01-000000","ITEM_CNT":7,"checked":true,"ITEM_CPNY":1}', '2019-04-09 16:30:59', '2019-04-09 16:31:59'),
	(10, 'tjdtmddn', NULL, '{"RM":5,"ITEM_DIV":"P","ITEM_ID":"mhyoon","ITEM_NM":"윤미호","NCKNM_NM":"Galaxy Note Fan Edition","IMG_PATH":"","ITEM_DPT_NM":"모바일개발팀","CELL_NO":"010-4820-2752","EMAIL_ADDR":"mhyoon.co.kr","REG_TS":"0000-00-000000","ITEM_CNT":1,"checked":true,"ITEM_CPNY":1}', '2019-04-10 19:49:40', '2019-04-10 20:08:37'),
	(11, 'tjdtmddn', NULL, '{"RM":5,"ITEM_DIV":"P","ITEM_ID":"mhyoon","ITEM_NM":"윤미호","NCKNM_NM":"Galaxy Note Fan Edition","IMG_PATH":"","ITEM_DPT_NM":"모바일개발팀","CELL_NO":"010-4820-2752","EMAIL_ADDR":"mhyoon.co.kr","REG_TS":"0000-00-000000","ITEM_CNT":1,"checked":true,"ITEM_CPNY":1}', '2019-04-10 19:58:40', '2019-04-10 20:09:48'),
	(12, 'tjdtmddn', NULL, '{"RM":4,"ITEM_DIV":"D","ITEM_ID":"3","ITEM_NM":"SI사업팀","NCKNM_NM":"(주)이베리","IMG_PATH":"","ITEM_DPT_NM":"SI사업팀","CELL_NO":"","EMAIL_ADDR":"","REG_TS":"2019-01-000000","ITEM_CNT":2,"checked":true,"ITEM_CPNY":1}', '2019-04-10 21:17:28', '2019-04-10 21:17:28'),
	(13, 'tjdtmddn', NULL, '{"RM":3,"ITEM_DIV":"D","ITEM_ID":"2","ITEM_NM":"연구소","NCKNM_NM":"(주)이베리","IMG_PATH":"","ITEM_DPT_NM":"연구소","CELL_NO":"","EMAIL_ADDR":"","REG_TS":"2019-01-000000","ITEM_CNT":1,"checked":true,"ITEM_CPNY":1},{"RM":4,"ITEM_DIV":"D","ITEM_ID":"3","ITEM_NM":"SI사업팀","NCKNM_NM":"(주)이베리","IMG_PATH":"","ITEM_DPT_NM":"SI사업팀","CELL_NO":"","EMAIL_ADDR":"","REG_TS":"2019-01-000000","ITEM_CNT":2,"checked":true,"ITEM_CPNY":1}', '2019-04-11 10:20:25', '2019-04-11 10:20:25'),
	(14, 'oslee97', NULL, '{"RM":1,"ITEM_DIV":"C","ITEM_ID":"1","ITEM_NM":"전체회원","NCKNM_NM":"(주)이베리","IMG_PATH":"","ITEM_DPT_NM":"","CELL_NO":"","EMAIL_ADDR":"","REG_TS":"2019-01-000000","ITEM_CNT":10,"checked":true,"ITEM_CPNY":1}', '2019-04-11 10:25:29', '2019-04-11 10:25:29'),
	(15, 'oslee97', NULL, '{"RM":3,"ITEM_DIV":"D","ITEM_ID":"2","ITEM_NM":"연구소","NCKNM_NM":"(주)이베리","IMG_PATH":"","ITEM_DPT_NM":"연구소","CELL_NO":"","EMAIL_ADDR":"","REG_TS":"2019-01-000000","ITEM_CNT":1,"checked":true,"ITEM_CPNY":1}', '2019-04-11 10:27:21', '2019-04-11 10:27:21'),
	(16, 'oslee97', NULL, '{"RM":2,"ITEM_DIV":"D","ITEM_ID":"1","ITEM_NM":"모바일개발팀","NCKNM_NM":"(주)이베리","IMG_PATH":"","ITEM_DPT_NM":"모바일개발팀","CELL_NO":"","EMAIL_ADDR":"","REG_TS":"2019-01-000000","ITEM_CNT":7,"checked":true,"ITEM_CPNY":1}', '2019-04-11 11:39:30', '2019-04-11 11:39:30'),
	(17, 'tjdtmddn', NULL, '{"RM":3,"ITEM_DIV":"D","ITEM_ID":"2","ITEM_NM":"연구소","NCKNM_NM":"(주)이베리","IMG_PATH":"","ITEM_DPT_NM":"연구소","CELL_NO":"","EMAIL_ADDR":"","REG_TS":"2019-01-000000","ITEM_CNT":1,"checked":true,"ITEM_CPNY":1},{"RM":4,"ITEM_DIV":"D","ITEM_ID":"3","ITEM_NM":"SI사업팀","NCKNM_NM":"(주)이베리","IMG_PATH":"","ITEM_DPT_NM":"SI사업팀","CELL_NO":"","EMAIL_ADDR":"","REG_TS":"2019-01-000000","ITEM_CNT":2,"checked":true,"ITEM_CPNY":1}', '2019-04-11 11:54:36', '2019-04-11 11:54:36'),
	(18, 'tjdtmddn', NULL, '{"RM":4,"ITEM_DIV":"D","ITEM_ID":"3","ITEM_NM":"SI사업팀","NCKNM_NM":"(주)이베리","IMG_PATH":"","ITEM_DPT_NM":"SI사업팀","CELL_NO":"","EMAIL_ADDR":"","REG_TS":"2019-01-000000","ITEM_CNT":2,"checked":true,"ITEM_CPNY":1}', '2019-04-11 11:56:27', '2019-04-11 11:56:27'),
	(19, 'tjdtmddn', NULL, '{"RM":3,"ITEM_DIV":"D","ITEM_ID":"2","ITEM_NM":"연구소","NCKNM_NM":"(주)이베리","IMG_PATH":"","ITEM_DPT_NM":"연구소","CELL_NO":"","EMAIL_ADDR":"","REG_TS":"2019-01-000000","ITEM_CNT":1,"checked":true,"ITEM_CPNY":1}', '2019-04-11 12:08:03', '2019-04-11 12:08:03'),
	(20, 'tjdtmddn', NULL, '{"RM":4,"ITEM_DIV":"D","ITEM_ID":"3","ITEM_NM":"SI사업팀","NCKNM_NM":"(주)이베리","IMG_PATH":"","ITEM_DPT_NM":"SI사업팀","CELL_NO":"","EMAIL_ADDR":"","REG_TS":"2019-01-000000","ITEM_CNT":2,"checked":true,"ITEM_CPNY":1}', '2019-04-12 14:49:47', '2019-04-12 14:49:47'),
	(21, 'oslee97', NULL, '{"RM":2,"ITEM_DIV":"D","ITEM_ID":"1","ITEM_NM":"모바일개발팀","NCKNM_NM":"(주)이베리","IMG_PATH":"","ITEM_DPT_NM":"모바일개발팀","CELL_NO":"","EMAIL_ADDR":"","REG_TS":"2019-01-000000","ITEM_CNT":6,"checked":true,"ITEM_CPNY":1}', '2019-04-17 12:18:52', '2019-04-17 12:18:52'),
	(22, 'oslee97', NULL, '{"RM":3,"ITEM_DIV":"D","ITEM_ID":"2","ITEM_NM":"연구소","NCKNM_NM":"(주)이베리","IMG_PATH":"","ITEM_DPT_NM":"연구소","CELL_NO":"","EMAIL_ADDR":"","REG_TS":"2019-01-000000","ITEM_CNT":1,"checked":true,"ITEM_CPNY":1}', '2019-04-18 11:27:13', '2019-04-18 11:27:13'),
	(23, 'oslee97', NULL, '{"RM":5,"ITEM_DIV":"P","ITEM_ID":"mhyoon","ITEM_NM":"윤미호","NCKNM_NM":"Galaxy Note Fan Edition","IMG_PATH":"","ITEM_DPT_NM":"모바일개발팀","CELL_NO":"010-4820-2752","EMAIL_ADDR":"mhyoon.co.kr","REG_TS":"0000-00-000000","ITEM_CNT":1,"checked":true,"ITEM_CPNY":1}', '2019-04-30 21:02:49', '2019-04-30 21:02:49'),
	(24, 'admin', NULL, '{"RM":17,"ITEM_DIV":"P","ITEM_ID":"shpark","ITEM_NM":"박성현","NCKNM_NM":"Galaxy Note 9","IMG_PATH":"","ITEM_DPT_NM":"SI사업팀","CELL_NO":"010-2709-5754","EMAIL_ADDR":"shpark@eberry.co.kr","REG_TS":"0000-00-000000","ITEM_CNT":1,"checked":true,"ITEM_CPNY":1}', '2019-05-20 21:07:07', '2019-05-20 21:07:07');
/*!40000 ALTER TABLE `PM_TMPLATRCV` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
