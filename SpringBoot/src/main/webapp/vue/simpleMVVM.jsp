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
       <script type="text/javascript" src="${pageContext.request.contextPath}/js/simpleMVVM.js"></script>
   </head>

   <body>
      <div id="app">
         <div>aaaaa</div>
         <input id="p1" type="text" x-model="directive"/>
         <p id="p2">{{id}}</p>
         <a class="btn btn-success" href="javasrcipt:void(0)" onclick="MVVM()">点我啊</a>
         <ul>
            <li></li>
            <li></li>
         </ul>
      </div>
   </body>
   <script type="text/javascript">
        var vm = new MVVM({
        	el : "#app",
            data : {
            	directive : "替换后的指令",
            	id : "???"
            }
        }); 
   </script>
</html>