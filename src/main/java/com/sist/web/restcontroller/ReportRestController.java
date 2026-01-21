package com.sist.web.restcontroller;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import lombok.RequiredArgsConstructor;

import java.io.File;
import java.nio.file.Files;
import java.util.*;
import com.sist.web.vo.*;
import com.sist.web.service.*;
@RestController
@RequiredArgsConstructor
public class ReportRestController {
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
			
			if(dir.exists())
			{
				dir.mkdirs();
			}
			if(!file1.isEmpty())
			{
				String filename=file1.getOriginalFilename();
				String savename="";
				File f = new File(dirPath+File.separator+filename);
				if(f.exists())
				{
					String name=filename.substring(0,filename.lastIndexOf("."));
					String ext = filename.substring(filename.lastIndexOf("."));
					int count=1;
					while(!f.exists())
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
			if(!file2.isEmpty())
			{
				String filename=file2.getOriginalFilename();
				String savename="";
				File f = new File(dirPath+File.separator+filename);
				if(f.exists())
				{
					String name=filename.substring(0,filename.lastIndexOf("."));
					String ext = filename.substring(filename.lastIndexOf("."));
					int count=1;
					while(!f.exists())
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
				vo.setImage1("/userimages/store/"+savename);
			}
			if(!file3.isEmpty())
			{
				String filename=file3.getOriginalFilename();
				String savename="";
				File f = new File(dirPath+File.separator+filename);
				if(f.exists())
				{
					String name=filename.substring(0,filename.lastIndexOf("."));
					String ext = filename.substring(filename.lastIndexOf("."));
					int count=1;
					while(!f.exists())
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
				vo.setImage1("/userimages/store/"+savename);
			}
			rService.reportUserInsert(vo);
		}catch(Exception ex)
		{
			ex.printStackTrace();
			return new ResponseEntity<>(null,HttpStatus.INTERNAL_SERVER_ERROR);
		}
		
		return new ResponseEntity<String>(res,HttpStatus.OK);
	}
}
