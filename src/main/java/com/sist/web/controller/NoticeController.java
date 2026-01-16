package com.sist.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
public class NoticeController {
	@GetMapping("/notice/list")
	// 사용자가 브라우저 창에 http://localhost:8080/notice/list 라고 입력하면 이 메소드가 실행
	public String notice_list(Model model)
	// 이 메서드가 실행된 후, 보여줄 JSP파일의 경로(문자열)을 반환한다
	// Model: 데이터를 실어 나르는 바구니 컨트롤러에서 만든 데이터를 JSP 화면으로 전달할 때 사용
	{
		model.addAttribute("main_jsp", "../notice/list.jsp");
		// addAttribute : 바구니에 데이터를 넣는 기능
		// "main_jsp" : 데이터의 이름(key)
		// "../notice/list.jsp" : 실제 값(value)
		return "main/main";
		// main/main.jsp 파일을 화면에 띄워라
	}

	@GetMapping("/notice/detail")
	// 사용자가 게시물을 클릭해서 상세 내용을 보고 싶을 때 접속하는 경로
	public String notice_detail(Model model) {
		model.addAttribute("main_jsp", "../notice/detail.jsp");
		return "main/main";
	}
	
	@GetMapping("/notice/insert")
	public String notice_insert(Model model) {
		model.addAttribute("main_jsp", "../notice/insert.jsp");
		return "main/main";
	}
	
	@GetMapping("/notice/update")
	public String notice_update(Model model) {
		model.addAttribute("main_jsp","../notice/update.jsp");
		return "main/main";
	}
	
	@GetMapping("/notice/delete")
	public String notice_delete(Model model) {
		model.addAttribute("main_jsp","../notice/delete.jsp");
		return "main/main";
	}
}
