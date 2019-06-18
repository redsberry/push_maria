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

-- 테이블 REDSPUSH.SN_MENU 구조 내보내기
CREATE TABLE IF NOT EXISTS `SN_MENU` (
  `MNU_CD` varchar(5) COLLATE utf8_bin NOT NULL COMMENT '메뉴 코드 ',
  `MNU_NM` varchar(60) COLLATE utf8_bin DEFAULT NULL COMMENT '메뉴 명 ',
  `MNU_PATH` varchar(256) COLLATE utf8_bin DEFAULT NULL COMMENT '메뉴 경로 ',
  `MNU_ORD` smallint(6) DEFAULT NULL COMMENT '메뉴 순서 ',
  `MNU_DEPTH` smallint(6) DEFAULT NULL COMMENT '메뉴 깊이 ',
  `MNU_GRP_YN` enum('Y','N') COLLATE utf8_bin DEFAULT NULL COMMENT '메뉴 그룹 여부',
  `UP_MNU_CD` varchar(5) COLLATE utf8_bin DEFAULT NULL COMMENT '상위 메뉴 코드 ',
  `USE_YN` enum('Y','N') COLLATE utf8_bin DEFAULT NULL COMMENT '사용 여부',
  PRIMARY KEY (`MNU_CD`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='메뉴관리';

-- 테이블 데이터 REDSPUSH.SN_MENU:~29 rows (대략적) 내보내기
/*!40000 ALTER TABLE `SN_MENU` DISABLE KEYS */;
INSERT INTO `SN_MENU` (`MNU_CD`, `MNU_NM`, `MNU_PATH`, `MNU_ORD`, `MNU_DEPTH`, `MNU_GRP_YN`, `UP_MNU_CD`, `USE_YN`) VALUES
	('BBS00', '게시판', '#', 3, 1, 'Y', '00000', 'Y'),
	('BBS01', '공지사항', '/board/viewNotice', 1, 2, 'N', 'BBS00', 'Y'),
	('BBS02', 'Q&A', '/board/viewQNA', 2, 2, 'N', 'BBS00', 'Y'),
	('BBS03', '시스템 장애 신고', '/board/viewSystem', 3, 2, 'N', 'BBS00', 'Y'),
	('CMN00', '공통', '#', 7, 1, 'Y', '00000', 'Y'),
	('CMN01', '조직관리', '/cmn/deptinfo', 1, 2, 'N', 'CMN00', 'N'),
	('CMN02', '메뉴관리', '/cmn/menu', 2, 2, 'N', 'CMN00', 'Y'),
	('CMN03', '권한관리', '/cmn/right', 3, 2, 'N', 'CMN00', 'Y'),
	('CMN04', '코드관리', '/cmn/code', 4, 2, 'N', 'CMN00', 'Y'),
	('CMN07', '게시판관리', '/cmn/bbs', 7, 2, 'N', 'CMN00', 'Y'),
	('CMN09', '접속통계', '/cmn/statLogin', 9, 2, 'N', 'CMN00', 'Y'),
	('CMN10', '접속자별 통계', '/cmn/statLoginUser', 10, 2, 'N', 'CMN00', 'Y'),
	('CMN11', '디바이스', '/cmn/dvc', 11, 2, 'N', 'CMN00', 'Y'),
	('CPN00', '조직관리', '#', 5, 1, 'Y', '00000', 'Y'),
	('CPN01', '부서관리', '/cpn/dptMng', 2, 2, 'N', 'CPN00', 'Y'),
	('CPN02', '회사관리', '/cpn/cpnMng', 1, 2, 'N', 'CPN00', 'N'),
	('HIS00', '푸시이력', '#', 2, 1, 'Y', '00000', 'Y'),
	('HIS01', '발송이력', '/history/sendHistory', 1, 2, 'N', 'HIS00', 'Y'),
	('HIS02', '수신이력', '/history/receiveHistory', 2, 2, 'N', 'HIS00', 'Y'),
	('PSH00', '푸시발송', '#', 1, 1, 'Y', '00000', 'Y'),
	('PSH01', '푸시발송', '/push/pushSend', 1, 2, 'N', 'PSH00', 'Y'),
	('PSH02', '푸시예약', '/push/pushReserve', 2, 2, 'N', 'PSH00', 'Y'),
	('STA00', '통계', '#', 4, 1, 'Y', '00000', 'Y'),
	('STA01', '발송 상태', '/stat/transCat', 1, 2, 'N', 'STA00', 'Y'),
	('STA02', '발송 요청', '/stat/transReq', 2, 2, 'N', 'STA00', 'Y'),
	('STA03', '발송 방법', '/stat/transType', 3, 2, 'N', 'STA00', 'Y'),
	('STA04', '메세지 유형', '/stat/msgCat', 4, 2, 'N', 'STA00', 'Y'),
	('STA05', '예약 반복 발송 요청', '/stat/transMthd', 4, 1, 'N', 'STA00', 'Y'),
	('USR00', '회원관리', '#', 6, 1, 'Y', '00000', 'Y'),
	('USR01', '회원관리', '/user/userMng', 1, 2, 'N', 'USR00', 'Y'),
	('USR02', '권한부여', '/user/userRight', 2, 2, 'N', 'USR00', 'Y');
/*!40000 ALTER TABLE `SN_MENU` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
