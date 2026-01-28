package com.sist.web.restcontroller;

import java.util.*;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import com.sist.web.service.BoardService;
import com.sist.web.vo.BoardVO;
import com.sist.web.vo.BoardReplyVO;
import lombok.RequiredArgsConstructor;
import jakarta.servlet.http.HttpSession;

@RestController
@RequiredArgsConstructor
@CrossOrigin("*")
public class BoardRestController {
    private final BoardService bService;

    @GetMapping("/board/list_vue")
    public ResponseEntity<Map> board_list_vue(@RequestParam(value = "page", defaultValue = "1") int page,
            @RequestParam(value = "fd", defaultValue = "") String fd) {
        Map map = new HashMap();
        try {
            List<BoardVO> list = bService.BoardListData((page - 1) * 12, fd);
            int totalpage = bService.BoardTotalPage(fd);
            map.put("list", list);
            map.put("curpage", page);
            map.put("totalpage", totalpage);
            return new ResponseEntity<>(map, HttpStatus.OK);
        } catch (Exception ex) {
            return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @GetMapping("/board/detail_vue")
    public ResponseEntity<Map> board_detail_vue(@RequestParam("no") int no, HttpSession session) {
        try {
            String username = (String) session.getAttribute("username");
            if (username == null) username = "";

            Map map = bService.boardDetailAllData(no, username);
            return new ResponseEntity<>(map, HttpStatus.OK);
        } catch (Exception ex) {
            ex.printStackTrace();
            return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @PostMapping("/board/like_vue")
    public ResponseEntity<BoardVO> board_like_vue(@RequestBody Map<String, Integer> params, HttpSession session) {
        try {
            String username = (String) session.getAttribute("username");
            if (username == null) return new ResponseEntity<>(null, HttpStatus.UNAUTHORIZED);

            int no = params.get("no");
            BoardVO vo = bService.boardLikeToggle(no, username);
            return new ResponseEntity<>(vo, HttpStatus.OK);
        } catch (Exception ex) {
            return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @PostMapping("/board/insert_vue")
    public ResponseEntity<Map> board_insert_vue(@RequestBody BoardVO vo, HttpSession session) {
        Map map = new HashMap();
        try {
            String username = (String) session.getAttribute("username");
            if (username == null || username.isEmpty()) {
                map.put("msg", "login_required");
                return new ResponseEntity<>(map, HttpStatus.OK);
            }
            vo.setMem_id(username);
            bService.boardInsert(vo);
            map.put("msg", "yes");
            return new ResponseEntity<>(map, HttpStatus.OK);
        } catch (Exception ex) {
            map.put("msg", "no");
            return new ResponseEntity<>(map, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @PutMapping("/board/update_ok_vue") 
    public ResponseEntity<Map> board_update_ok_vue(@RequestBody BoardVO vo, HttpSession session) {
        Map map = new HashMap();
        try {
            String sessionId = (String) session.getAttribute("username");
            if (sessionId == null) {
                map.put("msg", "no");
                return new ResponseEntity<>(map, HttpStatus.UNAUTHORIZED);
            }
            
            String result = bService.boardUpdate(vo, sessionId);
            map.put("msg", result);
            return new ResponseEntity<>(map, HttpStatus.OK);
        } catch (Exception ex) {
            map.put("msg", "no");
            return new ResponseEntity<>(map, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @DeleteMapping("/board/delete_vue/{no}")
    public ResponseEntity<Map> board_delete_vue(@PathVariable("no") int no, HttpSession session) {
        Map map = new HashMap();
        try {
            String username = (String) session.getAttribute("username");
            if (username == null) {
                map.put("msg", "no");
                return new ResponseEntity<>(map, HttpStatus.UNAUTHORIZED);
            }
            String result = bService.boardDelete(no, username);
            map.put("msg", result);
            return new ResponseEntity<>(map, HttpStatus.OK);
        } catch (Exception ex) {
            map.put("msg", "no");
            return new ResponseEntity<>(map, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @PostMapping("/board/reply_insert_vue")
    public ResponseEntity<Map> reply_insert(@RequestBody BoardReplyVO vo,
            @RequestParam(value = "pId", defaultValue = "0") int pId, HttpSession session) {
        Map map = new HashMap();
        try {
            String username = (String) session.getAttribute("username");
            if (username == null) {
                map.put("msg", "no");
                return new ResponseEntity<>(map, HttpStatus.UNAUTHORIZED);
            }
            vo.setMem_id(username);
            bService.replyInsert(vo, pId);
            map.put("msg", "yes");
            return new ResponseEntity<>(map, HttpStatus.OK);
        } catch (Exception ex) {
            map.put("msg", "no");
            return new ResponseEntity<>(map, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @GetMapping("/board/getUserAddr_vue")
    public ResponseEntity<String> board_getUserAddr_vue(@RequestParam("id") String id) {
        try {
            String addr = bService.getMemberAddr(id);
            return new ResponseEntity<>(addr, HttpStatus.OK);
        } catch (Exception ex) {
            return new ResponseEntity<>("서울", HttpStatus.OK);
        }
    }
}