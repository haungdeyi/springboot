package com.springboot.application.domain;

import java.io.Serializable;

public class User implements Serializable{
	
	private String name;
	private Integer IQ;
    
	//需要无参构造器，否则在反序列化的时候会出现异常
	public User() {
		
	}
	public User(String name, Integer IQ) {
		this.name = name;
		this.IQ = IQ;
	}
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Integer getIQ() {
		return IQ;
	}
	public void setIQ(Integer iQ) {
		IQ = iQ;
	}
	
	
}
