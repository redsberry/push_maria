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

-- 테이블 REDSPUSH.PM_RESERVECNT 구조 내보내기
CREATE TABLE IF NOT EXISTS `PM_RESERVECNT` (
  `MNG_NO` int(11) NOT NULL COMMENT '관리 번호 ',
  `MSG_SUBJ` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '메시지 제목 ',
  `MSG_CTNTS` text COLLATE utf8_bin DEFAULT NULL COMMENT '메시지 내용 ',
  `ATT_CAT_EXT` varchar(5) COLLATE utf8_bin DEFAULT NULL COMMENT '첨부 유형 확장자 / [D:문서유형(TXT, PDF, DOC ...), M:동영상, A:오디오, E:실행파일, F:단순파일(No Action), X:첨부없음]',
  `ATT_FILE_PATH` varchar(256) COLLATE utf8_bin DEFAULT NULL COMMENT '첨부 파일 경로 ',
  PRIMARY KEY (`MNG_NO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='예약메시지내용';

-- 테이블 데이터 REDSPUSH.PM_RESERVECNT:~0 rows (대략적) 내보내기
/*!40000 ALTER TABLE `PM_RESERVECNT` DISABLE KEYS */;
/*!40000 ALTER TABLE `PM_RESERVECNT` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
