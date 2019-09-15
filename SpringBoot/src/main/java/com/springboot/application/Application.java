package com.springboot.application;

import java.io.File;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Random;
import java.util.UUID;

import org.junit.Test;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class Application {

	//启动运用
	public static void main(String[] args) {
		SpringApplication.run(Application.class);
	}
	
	/*@Test
	public void hello(){
		Calendar cld = Calendar.getInstance();
        cld.add(Calendar.DATE, 0);
        String date = new SimpleDateFormat("yyyy-MM-dd").format(cld.getTime());
		
		//随机生成65~90之间的数字
		int num = new Random().nextInt(26) + 65;
		//将数字转换为字母
		Character secondDir= (char)num;
        System.out.println(secondDir.toString());
        File localRepository = new File("D:\\photoDir\\");
        Path path = Paths.get(localRepository.toString(),secondDir.toString());
        //resolve不会影响当前的Path
        Path newPath = path.resolve(UUID.randomUUID().toString() + ".jpg");
        System.out.println(newPath.toString());
	}*/
}
