<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
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
       <script type="text/javascript" src="${pageContext.request.contextPath}/js/vue.2.0.js"></script>
       <script type="text/javascript" src="${pageContext.request.contextPath}/js/vue-router-3.1.3.js"></script>
   </head>

   <body>
       <button onclick="startRequest()">点击请求</button>
       <img alt="????" src="${pageContext.request.contextPath}/downloadFile">
   </body>
   <script type="text/javascript">
         function startRequest(){
			var obj = {"regCode":"001"};
		    $.ajax({
		    	//同一个域发起的请求，所以没有问题
			    url : '/SpringBoot/testRequestBody',
				type : 'post',
				contentType : "application/json;charset=UTF-8",
				data : JSON.stringify(obj),
				dataType : 'json',
				success : function(data){
					console.log(data);
				},
			    error : function(){
				  alert("请求失败");
				}
			});
		  
		 }
   </script>
</html>