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

-- 테이블 REDSPUSH.BD_BOARD 구조 내보내기
CREATE TABLE IF NOT EXISTS `BD_BOARD` (
  `CNTS_SEQ_NO` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '게시물 관리번호',
  `BRD_CD` varchar(5) COLLATE utf8_bin NOT NULL COMMENT '게시판 관리번호',
  `CNTS_ORD` int(11) DEFAULT NULL COMMENT '게시물 순서 ',
  `CNTS_DEPTH` smallint(6) DEFAULT NULL COMMENT '게시물 깊이 ',
  `CNTS_TYPE` varchar(40) COLLATE utf8_bin DEFAULT NULL COMMENT '게시물 구분 ',
  `CNTS_KIND_CD` varchar(1) COLLATE utf8_bin DEFAULT NULL COMMENT '게시물 종류 코드 / [F:FAQ, Q:Question, A:Answer, S:Solution]',
  `CNTS_WR_DPT` varchar(4) COLLATE utf8_bin DEFAULT NULL COMMENT '게시물 작성 부서 ',
  `CNTS_SUBJ` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '게시물 제목 ',
  `CNTS_MSG` longtext COLLATE utf8_bin DEFAULT NULL COMMENT '게시물 내용글 ',
  `ATTFILE_YN` enum('Y','N') COLLATE utf8_bin DEFAULT NULL COMMENT '첨부파일 여부',
  `REA_CNT` int(11) DEFAULT NULL COMMENT '조회 수 ',
  `WTR_ID` varchar(80) COLLATE utf8_bin DEFAULT NULL COMMENT '작성자 ID ',
  `WTR_NM` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '작성자 명 ',
  `REG_TS` timestamp NOT NULL DEFAULT current_timestamp() COMMENT '등록 일시',
  `UPD_TS` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp() COMMENT '수정 일시',
  PRIMARY KEY (`CNTS_SEQ_NO`)
) ENGINE=MyISAM AUTO_INCREMENT=49 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='게시물관리';

-- 테이블 데이터 REDSPUSH.BD_BOARD:18 rows 내보내기
/*!40000 ALTER TABLE `BD_BOARD` DISABLE KEYS */;
INSERT INTO `BD_BOARD` (`CNTS_SEQ_NO`, `BRD_CD`, `CNTS_ORD`, `CNTS_DEPTH`, `CNTS_TYPE`, `CNTS_KIND_CD`, `CNTS_WR_DPT`, `CNTS_SUBJ`, `CNTS_MSG`, `ATTFILE_YN`, `REA_CNT`, `WTR_ID`, `WTR_NM`, `REG_TS`, `UPD_TS`) VALUES
	(1, 'BBS01', 36, 1, '', 'C', '1', '8월 정기점검 안내', '<p>2018년도 8월 정기정검을 다음과 같이 실시할 예정이니 참고해주시기 바랍니다.</p><p><br></p><p>일시 : 2018.08.30 05:00 ~ 06:00 (1시간)</p><p>내용 : 서버안정화를 위한 정기점검</p><p><br></p><p>업무에 참고하시기 바랍니다.</p>', 'N', 40, 'admin', '관리자', '2018-08-29 00:00:00', '2019-05-22 19:11:26'),
	(2, 'BBS01', 35, 1, '', 'C', '1', '로그인시 메뉴가 홈만 보일경우 안내', '<div align="" style=""><p>최초 로그인시 권한부여가 빠져있을수 있습니다.</p><p>왼쪽메뉴가 첨부된 화면처럼</p><p>홈밖에 보이지 않는 사용자 분들은 관리자에게</p><p>문의해주시기 바랍니다.</p></div><p><br></p>', 'Y', 190, 'admin', '관리자', '2018-08-29 00:00:00', '2019-05-23 11:30:17'),
	(4, 'BBS02', 17, 1, 'Q', 'Q', '1', '좌측 상단에 돋보기 버튼 관련 문의', '<p>무슨 버튼인가요?? 눌러도 아무 반응이 없네요</p>', 'N', 79, 'test', '홍길동', '2018-08-29 00:00:00', '2019-05-14 14:36:31'),
	(5, 'BBS02', 18, 2, 'A', 'Q', '1', '답변: 좌측 상단에 돋보기 버튼 관련 문의', '<p>전체 검색 버튼 아직 기능 구현안됬나바요.</p><p>기다려바야할듯</p>', 'N', 22, 'tjdtmddn', '성승우', '2018-08-29 00:00:00', '2019-05-14 14:34:35'),
	(6, 'BBS02', 20, 2, 'A', 'Q', '1', '답변: 좌측 메뉴가 게시판밖에 없습니다', '<p>시스템 장애신고에 관련된글 있던데</p><p>한번 봐보시면 될듯해요</p>', 'N', 16, 'tjdtmddn', '성승우', '2018-08-29 00:00:00', '2019-04-25 16:55:09'),
	(7, 'BBS02', 12, 1, 'FAQ', 'Q', '1', '[브라우저 종료]게시판 등 파일 첨부 시 크롬 브라우저가 강제 종료됩니다.', '<p>파일 첨부 시 크롬 브라우저가 강제 종료되는 경우가 있습니다.</p><p>한글의 dll과 충돌하여 발생하는 문제점으로 HncShellExt64.dl 파일을 찾아 파일명을 변경합니다.<br></p><p><br></p><p>1. 윈도우 탐색기를 실행하고 C:\\Program Files (x86)\\Hnc\\Hwp80로 이동합니다.</p><p>2. HncShellExt64.dll 파일을 찾아 HncShellExt64.dll.old 로 파일명을 변경합니다.<br></p><p>3. 시스템을 재시작 후 증상을 확인합니다.<br></p><p><br></p><p>한글 소프트웨어 업데이트 시 해당 파일이 다시 복구되면 또 다시 발생할 수 있으니 소프트웨어 업그레이드 후 상기 방법으로 다시 수행하시기 바랍니다.</p>', 'N', 74, 'troh', '관리자', '2018-11-14 00:00:00', '2019-05-14 14:34:29'),
	(8, 'BBS03', 5, 1, '답변완료', 'S', '1', '로그인 했는데 메뉴가 보이지 않습니다', '<div align="" style=""><div align="" style=""><p>메뉴가 게시판밖에 없는데 어떡해야하나요??</p></div></div><p><br></p>', 'N', 73, 'test', '홍길동', '2018-08-29 00:00:00', '2019-05-14 14:35:18'),
	(9, 'BBS03', 8, 2, '해결', 'S', '1', '답글: 이름이 잘못 입력되어 있어요 어떻게 해야하나요?', '<p>수정해야하는 이름 알려주시면 바로 수정해드리겠습니다.</p><p>감사합니다.</p>', 'N', 2, 'admin', '관리자', '2018-08-29 00:00:00', '2019-04-24 15:19:45'),
	(10, 'BBS03', 6, 2, '해결', 'S', '1', '답글: 로그인 했는데 메뉴가 보이지 않습니다', '<p>초기 로그인시 권한을 지정안하면 메뉴가 홈밖에</p><p>보이지 않을 수 있습니다.</p><p>방금 확인하여 권한드려서 보이실겁니다.</p><p>감사합니다.</p>', 'N', 17, 'admin', '관리자', '2018-08-29 00:00:00', '2019-04-23 12:17:04'),
	(12, 'BBS01', 25, 1, '', 'C', '1', '레즈베리 푸시 게시판 테스트', '<p>레즈베리 푸시 게시판 테스트<br></p>', 'N', 611, 'oslee97', '이옥선', '2019-01-02 00:00:00', '2019-05-23 11:32:03'),
	(13, 'BBS01', 24, 1, '', 'C', '2', '공지사항 테스트입니다.', '<p>공지사항 테스트입니다.</p>', 'Y', 345, 'oslee97', '이옥선', '2019-03-27 10:43:05', '2019-05-28 15:05:39'),
	(48, 'BBS01', 0, 1, '', 'C', '2', 'test', '<p>test</p>', 'Y', 193, 'oslee97', '이옥선', '2019-05-10 12:16:18', '2019-05-31 22:41:40'),
	(24, 'BBS01', 7, 1, '', 'C', '2', '1212121', '<p>11212</p>', 'Y', 98, 'oslee97', '이옥선', '2019-03-29 10:18:24', '2019-06-15 16:35:02'),
	(25, 'BBS03', 1, 1, NULL, 'S', '2', 'test', '<p>test</p>', 'Y', 27, 'oslee97', '이옥선', '2019-03-29 10:25:31', '2019-05-14 14:35:12'),
	(26, 'BBS03', 3, 2, NULL, 'S', '2', '답변: test', '<p>답변 테스트입니다.</p>', 'N', 2, 'oslee97', '이옥선', '2019-03-29 10:27:52', '2019-04-22 10:23:36'),
	(27, 'BBS03', 2, 2, NULL, 'S', '2', '답변: test', '<p>두번째 답변</p>', 'N', 1, 'oslee97', '이옥선', '2019-03-29 10:28:54', '2019-04-09 16:18:24'),
	(30, 'BBS01', 6, 1, '', 'C', '2', 'node 버전 공지사항', '<p>node 버전 공지사항<br></p>', 'Y', 95, 'oslee97', '이옥선', '2019-04-01 17:56:00', '2019-05-24 13:25:14'),
	(45, 'BBS02', 13, 2, 'A', 'Q', '1', '답변: [브라우저 종료]게시판 등 파일 첨부 시 크롬 브라우저가 강제 종료됩니다.', '<p>ㅁㄴㅇㄹㅋㅋㅋㅋ</p>', 'N', 15, 'skarjsdn', '남건우', '2019-04-09 17:34:41', '2019-05-20 14:37:46');
/*!40000 ALTER TABLE `BD_BOARD` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
