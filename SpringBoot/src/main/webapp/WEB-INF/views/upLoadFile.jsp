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
       <form id="form" action="${pageContext.request.contextPath}/uploadFile" method="post" enctype="multipart/form-data">
          <div class="form-group">
               <label class="col-lg-2">用户名：</label>
               <input class="form-control col-lg-10" type="text" name="username"/>
          </div>
          <div class="form-group">
              <label class="col-lg-2">请选择图片：</label>
              <input class="form-control col-lg-2" type="file" name="file"/>
          </div>
          
          <button id="btn" class="btn btn-info form-control">注册</button>
       </form>
   </body>
   <script type="text/javascript">
          let btn = document.getElementById("btn");
          btn.addEventListener("click",function(event){
        	  document.getElementById("form").submit();
          });
   </script>
</html>