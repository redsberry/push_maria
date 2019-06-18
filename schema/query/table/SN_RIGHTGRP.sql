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

-- 테이블 REDSPUSH.SN_RIGHTGRP 구조 내보내기
CREATE TABLE IF NOT EXISTS `SN_RIGHTGRP` (
  `RIG_GRP_CD` varchar(3) COLLATE utf8_bin NOT NULL COMMENT '권한 그룹 코드 ',
  `RIG_GRP_NM` varchar(30) COLLATE utf8_bin DEFAULT NULL COMMENT '권한 그룹 명 ',
  `RIG_GRP_DESC` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '권한 그룹 설명 ',
  `USE_GRP_CD` varchar(1) COLLATE utf8_bin DEFAULT NULL COMMENT '사용 권한 코드',
  `USE_YN` enum('Y','N') COLLATE utf8_bin DEFAULT NULL COMMENT '사용 여부',
  `SYS_YN` enum('Y','N') COLLATE utf8_bin DEFAULT NULL COMMENT '시스템 여부',
  `UPR_ID` varchar(80) COLLATE utf8_bin DEFAULT NULL COMMENT '수정자 ID ',
  `UPD_TS` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp() COMMENT '수정 일시',
  PRIMARY KEY (`RIG_GRP_CD`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='권한그룹';

-- 테이블 데이터 REDSPUSH.SN_RIGHTGRP:~4 rows (대략적) 내보내기
/*!40000 ALTER TABLE `SN_RIGHTGRP` DISABLE KEYS */;
INSERT INTO `SN_RIGHTGRP` (`RIG_GRP_CD`, `RIG_GRP_NM`, `RIG_GRP_DESC`, `USE_GRP_CD`, `USE_YN`, `SYS_YN`, `UPR_ID`, `UPD_TS`) VALUES
	('RG1', '시스템 담당자', '서비스 사업자 권한', 'A', 'Y', 'Y', 'admin', '2019-05-15 11:17:43'),
	('RG2', '최고 관리자', '회사 및 부서정보를 관리할 수 있다.(회사내 1명)', 'B', 'Y', 'Y', 'admin', '2019-05-15 11:17:47'),
	('RG3', '부서 관리자', '부서내 부서원 정보를 관리할 수 있다.(부서별 1명)', 'C', 'Y', 'N', 'tjdtmddn', '2019-05-15 11:17:52'),
	('RG4', '일반 사용자', '일반 사용자로 메시지 전송 및 읽기 권한', 'D', 'Y', 'N', 'oslee97', '2019-05-15 11:53:32');
/*!40000 ALTER TABLE `SN_RIGHTGRP` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
