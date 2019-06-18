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

-- 테이블 REDSPUSH.BD_ATTACH 구조 내보내기
CREATE TABLE IF NOT EXISTS `BD_ATTACH` (
  `ATTFILE_SEQ_NO` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '첨부파일 관리번호',
  `CNTS_SEQ_NO` int(10) unsigned NOT NULL COMMENT '게시물 관리번호',
  `SAVE_SVR` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '저장 서버 ',
  `ORG_FILE_NM` varchar(256) COLLATE utf8_bin DEFAULT NULL COMMENT '원본 파일 이름 ',
  `SAVE_SVR_PATH` varchar(256) COLLATE utf8_bin DEFAULT NULL COMMENT '저장 서버 경로 ',
  `SAVE_FILE_NM` varchar(256) COLLATE utf8_bin DEFAULT NULL COMMENT '저장 파일 명 ',
  `SAVE_FILE_SZ` int(11) DEFAULT NULL COMMENT '저장 파일 크기 ',
  `REG_TS` timestamp NOT NULL DEFAULT current_timestamp() COMMENT '생성 일시',
  PRIMARY KEY (`ATTFILE_SEQ_NO`)
) ENGINE=MyISAM AUTO_INCREMENT=20 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='게시물첨부';

-- 테이블 데이터 REDSPUSH.BD_ATTACH:8 rows 내보내기
/*!40000 ALTER TABLE `BD_ATTACH` DISABLE KEYS */;
INSERT INTO `BD_ATTACH` (`ATTFILE_SEQ_NO`, `CNTS_SEQ_NO`, `SAVE_SVR`, `ORG_FILE_NM`, `SAVE_SVR_PATH`, `SAVE_FILE_NM`, `SAVE_FILE_SZ`, `REG_TS`) VALUES
	(1, 13, 'http://localhost:4300/', 'FPMM0408.PNG', 'files/uploads/images/', '1553650983913_FPMM0408.PNG', 18799, '2019-03-27 10:43:05'),
	(2, 13, 'http://localhost:4300/', 'IMG_7358.PNG', 'files/uploads/images/', '1553650983914_IMG_7358.PNG', 8084, '2019-03-27 10:43:05'),
	(19, 48, 'http://211.115.91.57:4201/', '범죄자료품질검사.jpg', 'files/uploads/images/', '1557458178235_범죄자료품질검사.jpg', 129045, '2019-05-10 12:16:18'),
	(14, 24, 'http://localhost:4300/', 'IMG_7358.PNG', 'files/uploads/images/', '1553822304856_IMG_7358.PNG', 8084, '2019-03-29 10:18:24'),
	(15, 24, 'http://localhost:4300/', 'FPMM0408.PNG', 'files/uploads/images/', '1553822304785_FPMM0408.PNG', 18799, '2019-03-29 10:18:24'),
	(16, 25, 'http://localhost:4300/', 'IMG_7358.PNG', 'files/uploads/images/', '1553822732313_IMG_7358.PNG', 8084, '2019-03-29 10:25:31'),
	(17, 13, 'http://localhost:4300/', 'mongo.txt', 'files/uploads/files/', '1554098449725_mongo.txt', 6086, '2019-04-01 15:00:48'),
	(18, 30, 'http://redsberry.co.kr/', 'IMG_7358.PNG', 'files/uploads/images/', '1554108960285_IMG_7358.PNG', 8084, '2019-04-01 17:56:00');
/*!40000 ALTER TABLE `BD_ATTACH` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
