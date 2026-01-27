package com.sist.web.restcontroller;

import java.util.*;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.sist.web.service.NoticeService;
import com.sist.web.vo.NoticeVO;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@RestController
@RequiredArgsConstructor
public class NoticeRestController {
    private final NoticeService nService;

    @GetMapping("/notice/list_vue")
    public ResponseEntity<Map> notice_list_vue(@RequestParam("page") int page) {
        Map map = new HashMap();
        try {
            List<NoticeVO> list = nService.noticeListData((page - 1) * 8);
            int totalpage = nService.noticeTotalPage();
            
            map.put("list", list);
            map.put("curpage", page);
            map.put("totalpage", totalpage);
        } catch (Exception ex) {
            return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);
        }
        return new ResponseEntity<>(map, HttpStatus.OK);
    }

    @GetMapping("/notice/detail_vue")
    public ResponseEntity<NoticeVO> notice_detail_vue(@RequestParam("no") int no) {
        try {
            NoticeVO vo = nService.noticeDetailData(no);
            return new ResponseEntity<>(vo, HttpStatus.OK);
        } catch (Exception ex) {
            return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @PostMapping("/notice/insert_vue")
    public String notice_insert(@RequestBody NoticeVO vo, HttpSession session) {
        String adminId = (String) session.getAttribute("username");
        if (adminId != null && adminId.equals("admin")) {
            vo.setMem_id(adminId);
            nService.noticeInsert(vo);
            return "yes";
        }
        return "no";
    }

    @DeleteMapping("/notice/delete_vue/{not_id}")
    public ResponseEntity<Map> notice_delete(@PathVariable("not_id") int not_id) {
        Map map = new HashMap();
        try {
            nService.noticeDelete(not_id);
            map.put("msg", "yes");
            return new ResponseEntity<>(map, HttpStatus.OK);
        } catch (Exception ex) {
            return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @PutMapping("/notice/update_ok_vue")
    public ResponseEntity<Map> notice_update_ok_vue(@RequestBody NoticeVO vo) {
        Map map = new HashMap();
        try {
            nService.noticeUpdate(vo);
            map.put("msg", "yes");
            return new ResponseEntity<>(map, HttpStatus.OK);
        } catch (Exception ex) {
            return new ResponseEntity<>(null, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
}