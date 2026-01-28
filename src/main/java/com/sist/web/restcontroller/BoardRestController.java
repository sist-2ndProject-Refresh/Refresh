package com.sist.web.restcontroller;

import java.util.*;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import com.sist.web.service.BoardService;
import com.sist.web.vo.BoardReplyVO;
import com.sist.web.vo.BoardVO;
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
    public ResponseEntity<Map> board_detail_vue(@RequestParam("no") int no) {
        try {
            Map map = bService.boardDetailAllData(no);
            return new ResponseEntity<>(map, HttpStatus.OK);
        } catch (Exception ex) {
            return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @PostMapping("/board/insert_vue")
    public ResponseEntity<Map> board_insert_vue(@RequestBody BoardVO vo) {
        Map map = new HashMap();
        try {
            bService.boardInsert(vo);
            map.put("msg", "yes");
            return new ResponseEntity<>(map, HttpStatus.OK);
        } catch (Exception ex) {
            map.put("msg", "no");
            return new ResponseEntity<>(map, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @PutMapping("/board/update_ok_vue")
    public ResponseEntity<Map> board_update_ok_vue(@RequestBody BoardVO vo) {
        Map map = new HashMap();
        try {
            String result = bService.boardUpdate(vo, vo.getMem_id());
            map.put("msg", result);
            return new ResponseEntity<>(map, HttpStatus.OK);
        } catch (Exception ex) {
            map.put("msg", "no");
            return new ResponseEntity<>(map, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @DeleteMapping("/board/delete_vue/{id}")
    public ResponseEntity<Map> board_delete_vue(@PathVariable("id") int id, HttpSession session) {
        Map map = new HashMap();
        try {
            String sessionId = (String) session.getAttribute("username"); 
            String result = bService.boardDelete(id, sessionId);
            map.put("msg", result); 
            return new ResponseEntity<>(map, HttpStatus.OK);
        } catch (Exception ex) {
            map.put("msg", "no");
            return new ResponseEntity<>(map, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @PostMapping("/board/reply_insert_vue")
    public ResponseEntity<Map> reply_insert(@RequestBody BoardReplyVO vo, 
                                          @RequestParam(value = "pId", defaultValue = "0") int pId) {
        Map map = new HashMap();
        try {
            bService.replyInsert(vo, pId);
            map.put("msg", "yes");
            return new ResponseEntity<>(map, HttpStatus.OK);
        } catch (Exception ex) {
            ex.printStackTrace();
            map.put("msg", "no");
            return new ResponseEntity<>(map, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @DeleteMapping("/board/reply_delete_vue/{id}")
    public ResponseEntity<Map> reply_delete(@PathVariable("id") int id) {
        Map map = new HashMap();
        try {
            bService.replyDelete(id);
            map.put("msg", "yes");
            return new ResponseEntity<>(map, HttpStatus.OK);
        } catch (Exception ex) {
            map.put("msg", "no");
            return new ResponseEntity<>(map, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
    
    @PostMapping("/board/reply_update_vue")
    public ResponseEntity<Map> reply_update(@RequestBody BoardReplyVO vo) {
        Map map = new HashMap();
        try {
            bService.replyUpdate(vo); 
            
            map.put("msg", "yes");
            return new ResponseEntity<>(map, HttpStatus.OK);
        } catch (Exception ex) {
            ex.printStackTrace();
            map.put("msg", "no");
            return new ResponseEntity<>(map, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
}