<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
   <head>
       <base href="<%=basePath%>">    
       <title>insert title in here</title>
       <meta http-equiv="X-UA-Compatible" content="IE=edge">
       <!--响应式布局-->
       <meta name="viewport" content="width=device-width, initial-scale=1">        
       <meta http-equiv="pragma" content="no-cache">
       <meta http-equiv="cache-control" content="no-cache">
       <meta http-equiv="expires" content="0">    
       <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
       <meta http-equiv="description" content="This is my page">
       <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/bootstrap.css">
       <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.4.1.js"></script>
       <script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap.js"></script>
       <script type="text/javascript" src="${pageContext.request.contextPath}/js/vue.js"></script>
   </head>

   <body>
     <div id="vue1">
        <!-- v-cloak解决插值表达式的闪现问题 -->
        <p v-cloak>{{msg}}</p>
        
        <!-- v-text也可以解决插值表达式闪烁问题，并完全替换元素内容 -->
        <h3 v-text>-------{{msg}}-------</h3>
        
        <!-- v-html将插值表达式的值解析为html元素 -->
        <p v-html>{{msg2}}</p>
        
        <!-- v-bind用于绑定变量。可以简写为: -->
        <input type="button" value="按钮" v-bind:title="button_title"/>
        
        <!-- v-if用于判断 -->
        <div v-if="msg.length > 10">条件为真时我会出现</div>
        <!-- v-for用于循环遍历对象、数组、集合 -->
        <table class="table table-bordered">
          <tr v-for="person in array">
             <td>{{person.name}}</td>
             <td>{{person.age}}</td>
          </tr>
          <tr v-for="feild in object">
            <td>{{feild}}</td>
          </tr>
        </table>
        <!-- v-model命令用于双向绑定模型数据 -->
        <label>改变model数据</label><input type="text" v-model="msg"/>
        <!-- v-on命令用于绑定事件 -->
        <button class="btn btn-success" v-on:click="changeMsg()">点我点我</button>
        <!-- 使用过滤器 -->
        <p>{{upper | toUpper}}</p>
     </div>
   </body>
   <script type="text/javascript">
      var vue = new Vue({
    	  //控制的区域
    	  el : "#vue1",
    	  // 数据集
    	  data : {
    		  msg : "双向数据绑定",
    		  msg2 : "<h1>会解析成html标签元素</h1>",
    		  button_title : "我是按钮",
    		  upper : "abc",
    		  array :[{name:"张三",age:250},{name:"李四",age:251}],
    		  object : {phone:1111,email:"qq.com"}
    	  },
    	  //函数集
    	  methods :{
    		  changeMsg : function(){
    			  
    			  this.msg = "你点击了按钮";
    		  }
    	  },
    	  //过滤器集
    	  filters : {
    		  toUpper : function(value){
    			  return value.toUpperCase();
    		  }
    	  },
    	  //计算属性集
    	  computed :{
    		  count : function(){
    			 //业务逻辑  
    		  }
    	  },
    	  //观察属性
    	  watch : {
    		  //msg是数据属性，该属性变化时调用对应的监听程序
    		  msg : function(){
    			  //业务逻辑
    		  }
    	  }
      });
   </script>
</html>