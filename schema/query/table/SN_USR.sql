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

-- 테이블 REDSPUSH.SN_USR 구조 내보내기
CREATE TABLE IF NOT EXISTS `SN_USR` (
  `USR_ID` varchar(80) COLLATE utf8_bin NOT NULL COMMENT '사용자 ID ',
  `USR_PW` varchar(512) COLLATE utf8_bin DEFAULT NULL COMMENT '사용자 PW ',
  `USR_NM` varchar(50) COLLATE utf8_bin DEFAULT NULL COMMENT '사용자 명 ',
  `USR_NCKNM` varchar(50) COLLATE utf8_bin DEFAULT NULL COMMENT '별명 명 ',
  `USR_BIRDT` varchar(8) COLLATE utf8_bin DEFAULT NULL COMMENT '생년월일 ',
  `USR_SEX` varchar(1) COLLATE utf8_bin DEFAULT NULL COMMENT '성별 ',
  `EMAIL_ADDR` varchar(80) COLLATE utf8_bin DEFAULT NULL COMMENT '이메일 주소 ',
  `CELL_NO` varchar(20) COLLATE utf8_bin DEFAULT NULL COMMENT '휴대폰 번호 ',
  `TEL_NO` varchar(20) COLLATE utf8_bin DEFAULT NULL COMMENT '전화 번호 ',
  `POS_NM` varchar(20) COLLATE utf8_bin DEFAULT NULL COMMENT '직급 명 ',
  `DUTY_NM` varchar(20) COLLATE utf8_bin DEFAULT NULL COMMENT '직책 명 ',
  `AVT_IMG_PATH` varchar(256) COLLATE utf8_bin DEFAULT NULL COMMENT '아바타 이미지 경로',
  `CPNY_NO` int(10) unsigned NOT NULL COMMENT '회사 코드',
  `CPNY_MGR_YN` enum('Y','N') COLLATE utf8_bin DEFAULT NULL COMMENT '회사 관리자 여부',
  `DPT_NO` int(10) unsigned NOT NULL COMMENT '부서 코드',
  `DPT_MGR_YN` enum('Y','N') COLLATE utf8_bin DEFAULT NULL COMMENT '부서 관리자 여부',
  `ACNT_KAKAO_LINK_YN` enum('Y','N') COLLATE utf8_bin DEFAULT NULL COMMENT '계정 KAKAO 연결 여부',
  `ACNT_GOOGLE_LINK_YN` enum('Y','N') COLLATE utf8_bin DEFAULT NULL COMMENT '계정 GOOGLE 연결 여부',
  `PP_AGR_YN` enum('Y','N') COLLATE utf8_bin DEFAULT NULL COMMENT '개인정보취급방침 동의 여부',
  `TOS_AGR_YN` enum('Y','N') COLLATE utf8_bin DEFAULT NULL COMMENT '서비스이용약관 동의 여부',
  `DVC_AUTH_YN` enum('Y','N') COLLATE utf8_bin DEFAULT NULL COMMENT '모바일 인증 여부',
  `EMAIL_AUTH_YN` enum('Y','N') COLLATE utf8_bin DEFAULT NULL COMMENT '이메일 인증 여부',
  `JOIN_STE_CD` enum('A','B','C','D') COLLATE utf8_bin DEFAULT NULL COMMENT '가입 상태 코드 / [A:정상가입, B:인증대기, C:가입거부, D:탈퇴요청]',
  `PRE_REG_YN` enum('Y','N') COLLATE utf8_bin DEFAULT NULL COMMENT '사전 등록 여부 / 관리자가 사전 일괄등록기능을 통해 입력한 정보 여부',
  `SYS_YN` enum('Y','N') COLLATE utf8_bin DEFAULT NULL COMMENT '시스템 코드',
  `LATELY_CONN_TS` timestamp NULL DEFAULT NULL COMMENT '최근 접속 일시 ',
  `REG_TS` timestamp NOT NULL DEFAULT current_timestamp() COMMENT '생성 일시',
  `UPD_TS` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp() COMMENT '수정 일시',
  PRIMARY KEY (`USR_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='사용자';

-- 테이블 데이터 REDSPUSH.SN_USR:~11 rows (대략적) 내보내기
/*!40000 ALTER TABLE `SN_USR` DISABLE KEYS */;
INSERT INTO `SN_USR` (`USR_ID`, `USR_PW`, `USR_NM`, `USR_NCKNM`, `USR_BIRDT`, `USR_SEX`, `EMAIL_ADDR`, `CELL_NO`, `TEL_NO`, `POS_NM`, `DUTY_NM`, `AVT_IMG_PATH`, `CPNY_NO`, `CPNY_MGR_YN`, `DPT_NO`, `DPT_MGR_YN`, `ACNT_KAKAO_LINK_YN`, `ACNT_GOOGLE_LINK_YN`, `PP_AGR_YN`, `TOS_AGR_YN`, `DVC_AUTH_YN`, `EMAIL_AUTH_YN`, `JOIN_STE_CD`, `PRE_REG_YN`, `SYS_YN`, `LATELY_CONN_TS`, `REG_TS`, `UPD_TS`) VALUES
	('admin@eberry.co.kr', 'UH9jwfluS0Nukf7C4MdkLykVhPGGDmIY69mjnozc0JlGLhST6kSzF3aNc9n8cUiuFRVhKIKOILbmAX7fx/+VnQ==', '관리자', '관리자', NULL, 'M', NULL, NULL, '010-0000-0000', NULL, NULL, NULL, 1, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'A', NULL, 'Y', '2019-06-17 10:52:09', '2019-06-07 14:23:02', '2019-06-17 10:52:09'),
	('dockertablet@eberry.co.kr', 'ULGsAvxnl0jwKEsZ7aGTMSht7B6S8A2854CG1OgZztoGQPlONxJqzmxj967T6hiAZrQBoJyy22TB2YBbGS1S/A==', '성승우', NULL, '19890925', 'M', 'dockertablet@eberry.co.kr', '01041252752', NULL, NULL, NULL, NULL, 1, 'Y', 1, NULL, NULL, NULL, 'Y', 'Y', NULL, 'Y', 'A', NULL, NULL, '2019-06-15 18:47:04', '2019-06-15 18:41:58', '2019-06-15 18:47:04'),
	('hong@eberry.co.kr', 'yKpK85RQRqQLjwj/xvEqPj6XjHx2y8QN9rBQSQrWznSaKkRKqX8tygqrftUxV4Us6gmo4Z6BYk/Xy2/kGZqtjw==', '홍길동', '홍길동', '20190607', 'M', 'hong@eberry.co.kr', '01112341234', NULL, NULL, NULL, NULL, 4, NULL, 2, NULL, NULL, NULL, 'Y', 'Y', NULL, 'Y', 'A', NULL, NULL, NULL, '2019-06-07 16:15:33', '2019-06-07 16:15:33'),
	('jhlee@eberry.co.kr', 'cgnh82rgZo6FkPplib3xocRrAbBE812O/HatNiXaLGLEY2M10rUiOKM4/FjNowWLYNjep8e0ptNgH52/EdHBuQ==', '이진호', NULL, '19760713', 'M', 'jhlee@eberry.co.kr', '01094739480', NULL, NULL, NULL, '/uploads/profile/jhlee@eberry.co.kr.jpg', 1, 'Y', 1, NULL, NULL, NULL, 'Y', 'Y', NULL, 'Y', 'A', NULL, NULL, '2019-06-11 13:47:12', '2019-06-07 14:24:39', '2019-06-11 13:47:12'),
	('oslee97@eberry.co.kr', 'UH9jwfluS0Nukf7C4MdkLykVhPGGDmIY69mjnozc0JlGLhST6kSzF3aNc9n8cUiuFRVhKIKOILbmAX7fx/+VnQ==', '이옥선', '이옥선', '20190607', 'F', 'oslee97@eberry.co.kr', '01088695376', NULL, NULL, NULL, NULL, 4, NULL, 2, 'Y', NULL, NULL, 'Y', 'Y', NULL, 'Y', 'A', NULL, NULL, '2019-06-17 13:35:48', '2019-06-07 15:29:37', '2019-06-17 13:35:48'),
	('skarjsdn', 'UH9jwfluS0Nukf7C4MdkLykVhPGGDmIY69mjnozc0JlGLhST6kSzF3aNc9n8cUiuFRVhKIKOILbmAX7fx/+VnQ==', '남건우', '남건우', '19920620', 'M', 'skarjsdn', '', NULL, NULL, NULL, NULL, 1, 'Y', 1, NULL, NULL, NULL, 'Y', 'Y', NULL, 'Y', 'A', NULL, NULL, '2019-06-17 10:14:40', '2019-06-07 14:24:54', '2019-06-17 10:14:40'),
	('sos22233@eberry.co.kr', 'ULGsAvxnl0jwKEsZ7aGTMSht7B6S8A2854CG1OgZztoGQPlONxJqzmxj967T6hiAZrQBoJyy22TB2YBbGS1S/A==', '테스트계정', NULL, '19890925', 'M', 'tjdtmddn@eberry.co.kr', '010-1234-5678', NULL, NULL, NULL, NULL, 1, 'Y', 1, NULL, NULL, NULL, 'Y', 'Y', NULL, 'Y', 'A', NULL, NULL, '2019-06-13 17:55:05', '2019-06-07 14:24:37', '2019-06-13 17:55:05'),
	('tablet2@eberry.co.kr', 'ULGsAvxnl0jwKEsZ7aGTMSht7B6S8A2854CG1OgZztoGQPlONxJqzmxj967T6hiAZrQBoJyy22TB2YBbGS1S/A==', '태블릿테스트', NULL, '19890925', 'M', 'tablet@eberry.co.kr', '01041252752', NULL, NULL, NULL, NULL, 1, 'Y', 1, NULL, NULL, NULL, 'Y', 'Y', NULL, 'Y', 'A', NULL, NULL, '2019-06-14 20:54:57', '2019-06-12 10:47:12', '2019-06-14 20:54:57'),
	('tablet@eberry.co.kr', 'ULGsAvxnl0jwKEsZ7aGTMSht7B6S8A2854CG1OgZztoGQPlONxJqzmxj967T6hiAZrQBoJyy22TB2YBbGS1S/A==', '태블릿테스트', NULL, '19890925', 'M', 'tablet@eberry.co.kr', '01041252752', NULL, NULL, NULL, '/uploads/profile/tablet@eberry.co.kr.jpg', 1, 'Y', 1, NULL, NULL, NULL, 'Y', 'Y', NULL, 'Y', 'A', NULL, NULL, '2019-06-18 17:00:38', '2019-06-12 10:47:12', '2019-06-18 17:00:38'),
	('testtest@eberry.co.kr', 'ULGsAvxnl0jwKEsZ7aGTMSht7B6S8A2854CG1OgZztoGQPlONxJqzmxj967T6hiAZrQBoJyy22TB2YBbGS1S/A==', '웹테스트', '웹테스트', '20190607', 'M', 'testtest@eberry.co.kr', '01012341234', NULL, NULL, NULL, NULL, 4, NULL, 3, 'Y', NULL, NULL, 'Y', 'Y', NULL, 'Y', 'A', NULL, NULL, '2019-06-12 14:27:08', '2019-06-07 16:16:57', '2019-06-12 14:27:08'),
	('tjdtmddn@eberry.co.kr', 'ULGsAvxnl0jwKEsZ7aGTMSht7B6S8A2854CG1OgZztoGQPlONxJqzmxj967T6hiAZrQBoJyy22TB2YBbGS1S/A==', 'ssw테스트', NULL, '19890925', 'M', 'tjdtmddn@eberry.co.kr', '010-1234-5678', NULL, NULL, NULL, NULL, 1, 'Y', 1, NULL, NULL, NULL, 'Y', 'Y', NULL, 'Y', 'A', NULL, NULL, '2019-06-14 20:52:42', '2019-06-07 14:24:37', '2019-06-14 20:52:42');
/*!40000 ALTER TABLE `SN_USR` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
