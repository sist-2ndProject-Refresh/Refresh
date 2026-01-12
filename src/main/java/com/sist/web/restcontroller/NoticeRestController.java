package com.sist.web.restcontroller;

import java.util.*;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.sist.web.service.NoticeService;
import com.sist.web.vo.NoticeVO;

import lombok.RequiredArgsConstructor;

@RestController
@RequiredArgsConstructor
public class NoticeRestController {
	private final NoticeService nService;

	// final : 한 번 값이 정해지면 바뀌지 않는다
	@GetMapping("/notice/list_vue")
	// 웹 브라우저 주소창에 이경로로 접속(GET)하면 이 메서드가 실행된다
	public ResponseEntity<Map> notice_list_vue(@RequestParam("page") int page)
	// ResponseEntity : 응답(Response)과 상태(Entity)를 함께 담는 봉투
	// Map : 데이터를 이름:값 형태(키-값 쌍)로 묶어서 보냄
	// @RequestParam("page") int page : 사용자가 보낸 주소(예 ?page=1)에서 page라는
	// 숫자를 읽어와 변수 page에 저장
	{
		Map map = new HashMap();
		// 데이터를 담을 빈 주머니(map)을 만든다
		try {
			List<NoticeVO> list = nService.noticeListData((page - 1) * 10);
			// 현재 페이지가 1이라면 (1-1)*10 = 0번 부터 2라면 (2-1)*10 = 10번 데이터부터
			// 가져오도록 계산하여 서비스에 요청
			int totalpage = nService.noticeTotalPage();
			map.put("list", list);
			// 주머니에 "list"라는 이름으로 게시물 목록을 담는다
			map.put("curpage", page);
			// 현재 페이지 번호도 담는다
			map.put("totalpage", totalpage);
			// 전체 페이지 번호도 담는다
		} catch (Exception ex) {
			return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);
			// 코드가 실행되다 에러가 나면 서버 내부 에러(500번 코드) 신호를 보낸다
		}
		return new ResponseEntity<>(map, HttpStatus.OK);
		// HttpStatus.OK : 성공(200번 코드) 이라는 신호와 함께 주머니를 전송
	}

	@GetMapping("/notice/detail_vue")
	public ResponseEntity<NoticeVO> notice_detail_vue(@RequestParam("no") int no)
	// @RequestParam("no") int no : 상세히 보고 싶은 글의 번호(no)를 전달 받는다
	// ResponseEntity<NoticeVO> : 이번에는 주머니(Map)가 아니라 글 하나에 대한 정보(NoticeVO)만
	// 봉투에 담아서 보낸다
	{
		NoticeVO vo = new NoticeVO();
		try {
			vo = nService.noticeDetailData(no);
			// 서비스 글 번호를 전달하여 DB에서 해당 글 정보를 가져와 vo 객체에 저장
		} catch (Exception ex) {
			return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);
		}
		return new ResponseEntity<>(vo, HttpStatus.OK);
	}

}
