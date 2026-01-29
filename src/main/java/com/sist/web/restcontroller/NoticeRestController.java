package com.sist.web.restcontroller;

import java.util.*;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import com.sist.web.service.NoticeService;
import com.sist.web.vo.NoticeVO;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("/notice")
@RequiredArgsConstructor
public class NoticeRestController {
	
	private final NoticeService nService;

	@GetMapping("/list_vue")
	public ResponseEntity<Map<String, Object>> noticeList(
			@RequestParam(value = "page", defaultValue = "1") int page,
			@RequestParam(value = "fd", defaultValue = "") String fd) {
		try {
			Map<String, Object> map = new HashMap<>();
			map.put("list", nService.noticeListData((page - 1) * 8, fd));
			map.put("curpage", page);
			map.put("totalpage", nService.noticeTotalPage(fd));
			return ResponseEntity.ok(map);
		} catch (Exception ex) {
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
		}
	}

	@GetMapping("/detail_vue")
	public ResponseEntity<Map<String, Object>> noticeDetail(@RequestParam("no") int no) {
		try {
			Map<String, Object> map = new HashMap<>();
			map.put("vo", nService.noticeDetailData(no));
			map.put("prevVo", nService.noticePrevData(no));
			map.put("nextVo", nService.noticeNextData(no));
			return ResponseEntity.ok(map);
		} catch (Exception ex) {
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
		}
	}

	@PostMapping("/insert_vue")
	public ResponseEntity<Map<String, String>> noticeInsert(
			@RequestBody NoticeVO vo, 
			HttpSession session) {
		try {
			String adminId = (String) session.getAttribute("username");
			
			if (adminId != null && adminId.equals("admin")) {
				vo.setMem_id(adminId);
				nService.noticeInsert(vo);
				return ResponseEntity.ok(Map.of("msg", "yes"));
			}
			
			return ResponseEntity.ok(Map.of("msg", "no"));
		} catch (Exception ex) {
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
					.body(Map.of("msg", "no"));
		}
	}

	@PutMapping("/update_ok_vue")
	public ResponseEntity<Map<String, String>> noticeUpdate(@RequestBody NoticeVO vo) {
		try {
			nService.noticeUpdate(vo);
			return ResponseEntity.ok(Map.of("msg", "yes"));
		} catch (Exception ex) {
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
					.body(Map.of("msg", "no"));
		}
	}

	@DeleteMapping("/delete_vue/{not_id}")
	public ResponseEntity<Map<String, String>> noticeDelete(@PathVariable("not_id") int not_id) {
		try {
			nService.noticeDelete(not_id);
			return ResponseEntity.ok(Map.of("msg", "yes"));
		} catch (Exception ex) {
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
					.body(Map.of("msg", "no"));
		}
	}
}