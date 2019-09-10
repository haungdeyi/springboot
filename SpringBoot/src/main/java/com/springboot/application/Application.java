package com.springboot.application;

import java.text.SimpleDateFormat;
import java.util.Calendar;

import org.junit.Test;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class Application {

	//启动运用
	public static void main(String[] args) {
		SpringApplication.run(Application.class);
	}
	
	@Test
	public void hello(){
		Calendar cld = Calendar.getInstance();
        cld.add(Calendar.DATE, 0);
        String date = new SimpleDateFormat("yyyy-MM-dd").format(cld.getTime());
        System.out.println(cld.getTime());
	}
}
