package com.sist.web.restcontroller;

import java.io.File;
import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.kafka.common.Uuid;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.sist.web.service.UserService;
import com.sist.web.vo.StoreVO;
import com.sist.web.vo.UserVO;

import jakarta.mail.Multipart;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@RestController
@RequiredArgsConstructor
public class UserRestController {
	private final UserService uService;
	private final PasswordEncoder encoder;
	@GetMapping("/member/idcheck_vue/")
	public ResponseEntity<Integer> member_idCheck(@RequestParam("provider")String provider,@RequestParam("username")String username)
	{
		int count = 1;
		try {
			count = uService.usernameIdCk(provider, username);
		}catch(Exception ex) {
			ex.printStackTrace();
			return new ResponseEntity<>(null,HttpStatus.INTERNAL_SERVER_ERROR);
		}
		
		return new ResponseEntity<Integer>(count,HttpStatus.OK);
	}
	@GetMapping("/member/store_name_vue/")
	public ResponseEntity<Integer> member_storeCheck(@RequestParam("storename")String storename)
	{
		int count = 1;
		try {
			count = uService.storenameCheck(storename);
		}catch(Exception ex) {
			ex.printStackTrace();
			return new ResponseEntity<>(null,HttpStatus.INTERNAL_SERVER_ERROR);
		}
		return new ResponseEntity<Integer>(count,HttpStatus.OK);
	}
	@PostMapping("/member/user_join_vue/")
	public ResponseEntity<Map> user_join_vue(@RequestBody UserVO vo)
	{
		System.out.println("user_join_vue 호출");
		Map map = new HashMap<>();
		try {
			String msg = "NO";
			if(vo.getProvider()==null || vo.getUsername()==null || vo.getPassword()==null || vo.getPost()==null || vo.getAddr1() == null ||vo.getPhone()==null || vo.getEmail() == null)
			{
				map.put("msg", msg);
				return new ResponseEntity<Map>(map,HttpStatus.OK);
			}
			
			int count = uService.usernameIdCk(vo.getProvider(), vo.getUsername());
			if(count == 0)
			{
				vo.setPassword(encoder.encode(vo.getPassword()));
				uService.userInsert(vo);
				uService.userRoleInsert(vo);
				int no = uService.userNoData(vo);
				msg = "OK";
				map.put("msg", msg);
				map.put("no", no);
			}
			else {
				map.put("msg", msg);
				return new ResponseEntity<Map>(map,HttpStatus.OK);
			}
		}catch(Exception ex)
		{
			ex.printStackTrace();
			return new ResponseEntity<>(null,HttpStatus.INTERNAL_SERVER_ERROR);
		}
		
		return new ResponseEntity<Map>(map,HttpStatus.OK);
	}
	@PostMapping("/member/store_join_vue/")
	public ResponseEntity<String> store_join_vue(@ModelAttribute StoreVO vo,@RequestParam(value="image",required=false)MultipartFile image){
		System.out.println("store_join_vue 호출");
		String msg = "NO";
		try {
			if(image !=null && !image.isEmpty())
			{
				
				String imagename = image.getOriginalFilename();
				String ext = imagename.substring(imagename.lastIndexOf("."));
				
				String savename = Uuid.randomUuid()+ext;
				String savePath = "/images/store/"+savename;
				System.out.println(savePath);
				image.transferTo(new File(savePath));
				vo.setImage(savePath);
			}
			else {
				vo.setImage("/images/store/default-shop.jpg");
			}
			uService.storeInsert(vo);
			msg="OK";
		}catch(Exception ex)
		{
			ex.printStackTrace();
			return new ResponseEntity<>(null,HttpStatus.INTERNAL_SERVER_ERROR);
			
		}
		
		return new ResponseEntity<>(msg,HttpStatus.OK);
	}
	@DeleteMapping("/member/user_error_delete/")
	public void member_error_delete(@RequestParam("no")int no)
	{
		uService.userErrorDelete(no);
	}
}
