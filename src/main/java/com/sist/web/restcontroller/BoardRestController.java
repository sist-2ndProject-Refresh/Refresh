package com.sist.web.restcontroller;

import java.util.*;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import com.sist.web.service.BoardService;
import com.sist.web.vo.BoardVO;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@RestController
@RequiredArgsConstructor
@CrossOrigin("*")
public class BoardRestController {

	private final BoardService bService;

	@GetMapping("/board/list_vue")
	public ResponseEntity<Map> board_list_vue(@RequestParam(value = "page", defaultValue = "1") int page,
			@RequestParam(value = "fd", defaultValue = "", required = false) String fd) { // [수정] 검색어 fd 파라미터 추가

		Map map = new HashMap();
		try {
			int rowSize = 12;
			List<BoardVO> list = bService.BoardListData((page - 1) * rowSize, fd);
			int totalpage = bService.BoardTotalPage(fd);

			map.put("list", list);
			map.put("curpage", page);
			map.put("totalpage", totalpage);

			return new ResponseEntity<>(map, HttpStatus.OK);
		} catch (Exception ex) {
			ex.printStackTrace();
			return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}

	@GetMapping("/board/detail_vue")
	public ResponseEntity<BoardVO> board_detail_vue(@RequestParam("no") int no) {
		try {
			BoardVO vo = bService.boardDetailData(no);
			return new ResponseEntity<>(vo, HttpStatus.OK);
		} catch (Exception ex) {
			return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}

	@PostMapping("/board/insert_vue")
	public ResponseEntity<Map> board_insert_vue(@RequestBody BoardVO vo, HttpSession session) {
		Map map = new HashMap();
		try {
			String userId = (String) session.getAttribute("username");
			if (userId == null) {
				map.put("msg", "no");
				return new ResponseEntity<>(map, HttpStatus.FORBIDDEN);
			}
			vo.setMem_id(userId);
			bService.boardInsert(vo);
			map.put("msg", "yes");
			return new ResponseEntity<>(map, HttpStatus.OK);
		} catch (Exception ex) {
			return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}

	@PutMapping("/board/update_ok_vue")
	public ResponseEntity<Map> board_update_ok_vue(@RequestBody BoardVO vo, HttpSession session) {
		Map map = new HashMap();
		try {
			String userId = (String) session.getAttribute("username");
			if (userId == null) {
				map.put("msg", "no");
				return new ResponseEntity<>(map, HttpStatus.FORBIDDEN);
			}
			String result = bService.boardUpdate(vo, userId);
			map.put("msg", result);
			return new ResponseEntity<>(map, HttpStatus.OK);
		} catch (Exception ex) {
			return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}

	@DeleteMapping("/board/delete_vue/{no}")
	public ResponseEntity<Map> board_delete_vue(@PathVariable("no") int no, HttpSession session) {
		Map map = new HashMap();
		try {
			String userId = (String) session.getAttribute("username");
			if (userId == null) {
				map.put("msg", "no");
				return new ResponseEntity<>(map, HttpStatus.FORBIDDEN);
			}
			String result = bService.boardDelete(no, userId);
			map.put("msg", result);
			return new ResponseEntity<>(map, HttpStatus.OK);
		} catch (Exception ex) {
			return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}

	@GetMapping("/board/getUserAddr_vue")
	public ResponseEntity<String> board_user_addr(@RequestParam("id") String id) {
		try {
			String addr = bService.getMemberAddr(id);
			return new ResponseEntity<>(addr != null ? addr : "", HttpStatus.OK);
		} catch (Exception ex) {
			ex.printStackTrace();
			return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}
}