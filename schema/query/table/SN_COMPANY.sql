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

-- 테이블 REDSPUSH.SN_COMPANY 구조 내보내기
CREATE TABLE IF NOT EXISTS `SN_COMPANY` (
  `CPNY_NO` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '회사 코드',
  `CPNY_NM` varchar(80) COLLATE utf8_bin DEFAULT NULL COMMENT '회사 명 ',
  `CPNY_LOG_IMG_PATH` varchar(256) COLLATE utf8_bin DEFAULT NULL COMMENT '회사 로그 이미지 ',
  `CPNY_ADDR` varchar(300) COLLATE utf8_bin DEFAULT NULL COMMENT '회사 주소 ',
  `CEO_NM` varchar(50) COLLATE utf8_bin DEFAULT NULL COMMENT '대표자 명 ',
  `BZREG_NO` varchar(10) COLLATE utf8_bin DEFAULT NULL COMMENT '사업자등록 번호 ',
  `MSTR_TEL_NO` varchar(20) COLLATE utf8_bin DEFAULT NULL COMMENT '대표 전화 번호 ',
  `MSTR_FAX_NO` varchar(20) COLLATE utf8_bin DEFAULT NULL COMMENT '대표 팩스 번호 ',
  `POST_NO` varchar(5) COLLATE utf8_bin DEFAULT NULL COMMENT '우편 번호 ',
  `REG_TS` timestamp NOT NULL DEFAULT current_timestamp() COMMENT '등록 일시',
  `UPD_TS` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp() COMMENT '수정 일시',
  PRIMARY KEY (`CPNY_NO`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='회사';

-- 테이블 데이터 REDSPUSH.SN_COMPANY:~6 rows (대략적) 내보내기
/*!40000 ALTER TABLE `SN_COMPANY` DISABLE KEYS */;
INSERT INTO `SN_COMPANY` (`CPNY_NO`, `CPNY_NM`, `CPNY_LOG_IMG_PATH`, `CPNY_ADDR`, `CEO_NM`, `BZREG_NO`, `MSTR_TEL_NO`, `MSTR_FAX_NO`, `POST_NO`, `REG_TS`, `UPD_TS`) VALUES
	(1, '(주)이베리', NULL, '서울특별시 영등포구 양평로 22길 21(양평동5가) 선유도 코오롱디지털 타워 1407호', '김대표', NULL, '02-2062-5541', '02-2062-5543', '07205', '2019-06-07 14:23:01', '2019-06-07 14:23:01'),
	(2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-06-07 14:24:37', '2019-06-07 14:24:37'),
	(3, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-06-07 14:24:39', '2019-06-07 14:24:39'),
	(4, '이베리', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-06-07 14:24:54', '2019-06-07 14:24:54'),
	(5, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-06-12 10:47:12', '2019-06-12 10:47:12'),
	(6, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-06-15 18:41:58', '2019-06-15 18:41:58');
/*!40000 ALTER TABLE `SN_COMPANY` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
