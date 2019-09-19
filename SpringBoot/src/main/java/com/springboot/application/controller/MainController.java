package com.springboot.application.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.IOUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.springboot.application.domain.User;

@Controller
@RequestMapping("/")
public class MainController {
    
	@RequestMapping("linkToMainPage")
	public String linkToMainPage() {
		return "main";
	}
	
	@RequestMapping("smallProgram")
	@ResponseBody
	public List<User> smallProgram() {
		List<User> userList = new ArrayList<User>();
		userList.add(new User("二狗子",250));
		userList.add(new User("麻雷子",251));
		userList.add(new User("大呲花",252));
		userList.add(new User("二踢脚",253));
		
		return userList;
		
	}
	
	@RequestMapping("smallProgramLogin")
	@ResponseBody
	public String smallProgramLogin(String code,HttpServletRequest request) {
		String query = request.getQueryString();
		
		String appId = "wx721cc3f57e51c252";
		String AppSecret = "b2591cf6a9d39b807cf012cb940b44bb";
		String wxAPI = "https://api/weixin.qq.com/sns/jscode2session?"
				       + "appid=" + appId + "&secret=" + AppSecret + 
				       "&js_code=" + code;
		//发起请求，得到openid
		return wxAPI;
	}
	
	//转到文件上传页面
	@RequestMapping("linkToUploadFile")
	public String linkToUploadFile() {
		return "upLoadFile";
	}
	
	//接收文件
	@RequestMapping("uploadFile")
	public String uploadFile(HttpServletRequest request,MultipartFile file) throws IOException{
		
		//将上传的文件转换为字节数组
		byte[] bytes = file.getBytes();
	
		//使用java7之前的文件类File
		File localRepository = new File("D:\\photoDir\\");
		
		//随机生成65~90之间的数字
		int num = new Random().nextInt(26) + 65;
		//将数字强转为字母
		Character secondDir= (char)num;
		//得到图片在服务器的保存路径(java7之后新加了Path和Files两个文件处理相关类)
		Path path = Paths.get(localRepository.toString(),secondDir.toString());
		//如果路径不存在则逐级创建
		if(!Files.exists(path)) {
			Files.createDirectory(path);
		}
		
		//得到带后缀的文件名
		String filename = file.getOriginalFilename();
		//取出后缀
		String fileType = filename.substring(filename.lastIndexOf("."));
		//记得带文件后缀啊啊啊啊啊啊啊啊！！！！！兄弟	
		String newFileName = UUID.randomUUID().toString() + fileType;
		Path lastPath = path.resolve(newFileName);
		
		//最原始的方式
		/*InputStream in = request.getInputStream();
		IOUtils.SYS*/
		
		//原始的方式2
		/*OutputStream out = new FileOutputStream(path.toFile());
		out.write(bytes);	*/

		//将文件保存到指定的路径(Spring提供的封装好的方式)
		file.transferTo(lastPath.toFile());
		
		//将用户的文件信息保存到数据库
		//new UserInfo(user,newFileName,path.toString());
		return "main";
	}
	
	//将文件传到前端
	@RequestMapping("downloadFile")
	public void downloadFile(HttpServletResponse response) throws IOException {
		FileInputStream in = new FileInputStream("D:\\photoDir\\A\\a4ed6912-2e10-4274-8559-b5a119ad532a.jpg");
		OutputStream os = response.getOutputStream();
		//第一种方式,一次性写入
		/*byte[] bytes = new byte[in.available()];
		in.read(bytes);
		os.write(bytes);
		os.flush();
		os.close();*/
		
		
		
		//第二种方式
		byte[] bytes = new byte[1024];
		int length;
		//将图片转成字节并写入响应流中
		while(( length = in.read(bytes)) != -1) {
			os.write(bytes, 0, length);
		}
		os.flush();
		os.close();
	}
	
	//测试RequestBody
	@CrossOrigin
	@RequestMapping("testRequestBody")
	@ResponseBody
	public Map<String,User> testRequestBody(HttpServletRequest request ,@RequestBody Map<String,String> params){
		String header = request.getHeader("x-tif-uinfo");
		Map<String,User> map = new HashMap<String,User>();
	    map.put("smallSB", new User("二狗子",250));
	    map.put("bigSB", new User("二麻雷子",251));
	    return map;
	}
}
