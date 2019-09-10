package com.springboot.application.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

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
}
