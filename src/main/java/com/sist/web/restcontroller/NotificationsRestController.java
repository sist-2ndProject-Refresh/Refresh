package com.sist.web.restcontroller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.sist.web.service.NotificationService;
import com.sist.web.vo.NotificationVO;

import lombok.RequiredArgsConstructor;

@RestController
@RequiredArgsConstructor
public class NotificationsRestController {
	private final NotificationService nService;
	
	@GetMapping("/notify/list/")
	public ResponseEntity<Map> notify_list(@RequestParam("receiverId") int receiverId)
	{
		Map map=new HashMap<>();
		try
		{
			List<NotificationVO> list=nService.notifyListDAta(receiverId);
			int count=nService.notifyCount(receiverId);
			
			map.put("list", list);
			map.put("count", count);
		}catch(Exception ex)
		{
			ex.printStackTrace();
			return new ResponseEntity<>(null,HttpStatus.INTERNAL_SERVER_ERROR);
		}
		return new ResponseEntity<>(map,HttpStatus.OK);
	}
	
	@DeleteMapping("/notify/delete/")
	public ResponseEntity<NotificationVO> notify_delete(@RequestParam("notifyId") int notifyId)
	{
		NotificationVO vo=new NotificationVO();
		try
		{
			nService.deleteNotify(notifyId);
		}catch(Exception ex)
		{
			ex.printStackTrace();
			return new ResponseEntity<>(null,HttpStatus.INTERNAL_SERVER_ERROR);
		}
		return new ResponseEntity<>(vo,HttpStatus.OK);
	}
}
