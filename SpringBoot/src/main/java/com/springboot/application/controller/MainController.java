package com.springboot.application.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/")
public class MainController {
    
	@RequestMapping("linkToMainPage")
	public String linkToMainPage() {
		return "main";
	}
}
