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

-- 테이블 REDSPUSH.SN_WIDGET 구조 내보내기
CREATE TABLE IF NOT EXISTS `SN_WIDGET` (
  `WG_NO` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '위젯 번호 ',
  `WG_NM` varchar(60) COLLATE utf8_bin DEFAULT NULL COMMENT '위젯 명 ',
  `WG_GRP` varchar(1) COLLATE utf8_bin DEFAULT NULL COMMENT '위젯 그룹 / [B:게시판, C:차트, S:통계]',
  `WG_TYPE` varchar(20) COLLATE utf8_bin DEFAULT NULL COMMENT '위젯 구분 ',
  `WG_PATH` varchar(512) COLLATE utf8_bin DEFAULT NULL COMMENT '위젯 경로 ',
  PRIMARY KEY (`WG_NO`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='위젯';

-- 테이블 데이터 REDSPUSH.SN_WIDGET:~10 rows (대략적) 내보내기
/*!40000 ALTER TABLE `SN_WIDGET` DISABLE KEYS */;
INSERT INTO `SN_WIDGET` (`WG_NO`, `WG_NM`, `WG_GRP`, `WG_TYPE`, `WG_PATH`) VALUES
	(1, '발송 방법 통계 차트', 'C', 'C', 'stat/getMsgCatStat'),
	(2, '메세지 유형 통계 차트', 'C', 'C', 'stat/getTransTypeStat'),
	(3, '시간대별 발송요청 차트', 'C', 'P', 'stat/getMainTransTime'),
	(4, '발송상태 통계', 'C', 'C', 'stat/getTransStatusStat'),
	(5, '예약,반복발송요청 통계', 'C', 'C', 'stat/getTransMthdStat'),
	(6, '접속 통계', 'C', 'C', 'stat/getStatLogin'),
	(7, '접속자별 통계', 'C', 'C', 'stat/getStatLoginUser'),
	(8, '공지사항', 'B', 'N', 'board/getMainBoardList'),
	(9, 'Q&A', 'B', 'Q', 'board/getMainBoardList'),
	(10, '시스템 장애신고', 'B', 'S', 'board/getMainBoardList');
/*!40000 ALTER TABLE `SN_WIDGET` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
