package com.sist.web.restcontroller;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import lombok.RequiredArgsConstructor;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.net.URLEncoder;
import java.nio.file.Files;
import java.util.*;
import com.sist.web.vo.*;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.sist.web.config.SecurityConfig;
import com.sist.web.service.*;

@RestController
@RequiredArgsConstructor
public class ReportRestController {

    private final SecurityConfig securityConfig;
	private final ReportService rService;
	
	@Value("${file.upload-dir}")
	private String uploadDir;	
	
	@PostMapping("/report/insert_vue/")
	public ResponseEntity<String> report_insert_vue(@ModelAttribute ReportVO vo,
			@RequestParam(value="file1",required = false)MultipartFile file1,
			@RequestParam(value="file2",required = false)MultipartFile file2,
			@RequestParam(value="file3",required = false)MultipartFile file3)
	{
		String res = "no";
		try {
			String dirPath = uploadDir+"report";
			File dir = new File(dirPath);
			
			if(!dir.exists())
			{
				dir.mkdirs();
			}
			if(file1!=null && !file1.isEmpty())
			{
				String filename=file1.getOriginalFilename();
				String savename="";
				File f = new File(dirPath+File.separator+filename);
				if(f.exists())
				{
					String name=filename.substring(0,filename.lastIndexOf("."));
					String ext = filename.substring(filename.lastIndexOf("."));
					int count=1;
					while(f.exists())
					{
						savename=name+"("+count+")"+ext;
						f = new File(dirPath+File.separator+savename);
						count++;
					}
				}
				else {
					savename=filename;
				}
				file1.transferTo(f);
				vo.setImage1("/userimages/store/"+savename);
			}
			if(file2!=null && !file2.isEmpty())
			{
				String filename=file2.getOriginalFilename();
				String savename="";
				File f = new File(dirPath+File.separator+filename);
				if(f.exists())
				{
					String name=filename.substring(0,filename.lastIndexOf("."));
					String ext = filename.substring(filename.lastIndexOf("."));
					int count=1;
					while(f.exists())
					{
						savename=name+"("+count+")"+ext;
						f = new File(dirPath+File.separator+savename);
						count++;
					}
				}
				else {
					savename=filename;
				}
				file2.transferTo(f);
				vo.setImage2("/userimages/store/"+savename);
			}
			if(file3!=null && !file3.isEmpty())
			{
				String filename=file3.getOriginalFilename();
				String savename="";
				File f = new File(dirPath+File.separator+filename);
				if(f.exists())
				{
					String name=filename.substring(0,filename.lastIndexOf("."));
					String ext = filename.substring(filename.lastIndexOf("."));
					int count=1;
					while(f.exists())
					{
						savename=name+"("+count+")"+ext;
						f = new File(dirPath+File.separator+savename);
						count++;
					}
				}
				else {
					savename=filename;
				}
				file3.transferTo(f);
				vo.setImage3("/userimages/store/"+savename);
			}
			if(vo.getSubStorename()!=null)
			{
				int subject=rService.subjectNoFindByStorename(vo.getSubStorename());
				if(subject==0 ) {
					res="NOID";
					return new ResponseEntity<String>(res,HttpStatus.OK);
				}
				vo.setSubject(subject);
			}
			rService.reportUserInsert(vo);
			res="OK";
		}catch(Exception ex)
		{
			ex.printStackTrace();
			return new ResponseEntity<>(null,HttpStatus.INTERNAL_SERVER_ERROR);
		}
		
		return new ResponseEntity<String>(res,HttpStatus.OK);
	}
	@GetMapping("/report/subjectId_Check/")
	public ResponseEntity<Integer> subjectId_check(@RequestParam("subStorename")String subStorename)
	{
		int count = 0;
		try {
			count = rService.subjectStoreNameCheck(subStorename);
		}catch(Exception ex)
		{
			return new ResponseEntity<>(null,HttpStatus.INTERNAL_SERVER_ERROR);
		}
		return new ResponseEntity<Integer>(count,HttpStatus.OK);
	}
	@GetMapping("/report/userReport_list/")
	public ResponseEntity<List<ReportVO>> user_report_list(@RequestParam("reporter")int reporter,@RequestParam("page")int page)
	{
		List<ReportVO> list = null;
		try {
			list = rService.reportUserListData(reporter,(page-1)*10);
		}catch(Exception ex)
		{
			ex.printStackTrace();
			return new ResponseEntity<>(null,HttpStatus.INTERNAL_SERVER_ERROR);
		}
		
		return new ResponseEntity<>(list,HttpStatus.OK);
	}
	@GetMapping("/report/detail_vue/")
	public ResponseEntity<ReportVO> report_detail_vue(@RequestParam("no")int no,@RequestParam("state")int state,@RequestParam("reporttype")int reporttype)
	{
		ReportVO vo = null;
		try {
			Map map = new HashMap();
			map.put("no",no);
			map.put("state",state);
			map.put("reporttype",reporttype);
			
			vo = rService.reportDetailData(map);

		}catch(Exception ex)
		{
			ex.printStackTrace();
			return new ResponseEntity<>(null,HttpStatus.INTERNAL_SERVER_ERROR);
		}
		
		return new ResponseEntity<>(vo,HttpStatus.OK);
	}
	   @GetMapping("/report/download")
	   public void databoard_download(@RequestParam("name") String name,
	      HttpServletRequest request,HttpServletResponse response
	   )throws Exception
	   {
		   String fileName = name.substring(name.lastIndexOf("/")+1);
		   System.out.println(fileName);
		   File file=new File(uploadDir+"report"+File.separator+fileName);
		   response.setHeader("Content-Disposition", "attchement;filename="+URLEncoder.encode(fileName, "UTF-8"));
		   response.setContentLength((int)file.length());
		   
		   BufferedInputStream bis=new BufferedInputStream(new FileInputStream(file));
		   BufferedOutputStream bos= new BufferedOutputStream(response.getOutputStream());
		   int i=0;
		   byte[] buffer=new byte[1024];
		   while((i=bis.read(buffer, 0, 1024))!=-1)
		   {
			   bos.write(buffer, 0, i);
		   }
		   bis.close();
		   bos.close();
	   }
	   @GetMapping("/report/admin/Report_list/")
		public ResponseEntity<List<ReportVO>> admin_report_list()
		{
			List<ReportVO> list = null;
			try {
				list = rService.reportAdminListData();
			}catch(Exception ex)
			{
				ex.printStackTrace();
				return new ResponseEntity<>(null,HttpStatus.INTERNAL_SERVER_ERROR);
			}
			
			return new ResponseEntity<>(list,HttpStatus.OK);
		}
	   @PostMapping("/report/admin/respond_insert/")
	   public ResponseEntity<String> admin_respond_insert(@RequestBody RespondVO vo)
	   {
		   String result ="NO";
		   try {
			   
			   System.out.println(vo);
			   rService.respondInsert(vo);
			   result="OK";
			}catch(Exception ex)
			{
				ex.printStackTrace();
				return new ResponseEntity<>(null,HttpStatus.INTERNAL_SERVER_ERROR);
			}
			
			return new ResponseEntity<>(result,HttpStatus.OK);
	   }
	   @GetMapping("/report/user/respond_ok/")
	   public ResponseEntity<String> user_respond_ok(@RequestParam("no")int no)
	   {
		   String result ="NO";
		   try {
			   
			   rService.reportStateUpdate(3, no);
			   result="OK";
			}catch(Exception ex)
			{
				ex.printStackTrace();
				return new ResponseEntity<>(null,HttpStatus.INTERNAL_SERVER_ERROR);
			}
			
			return new ResponseEntity<>(result,HttpStatus.OK);
	   }
	
}

