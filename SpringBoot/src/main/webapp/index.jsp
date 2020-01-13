<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/ref/taglib.jsp" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
   <head>
     <%@ include file="/ref/header.jsp"%>
     <title></title>
   </head>

   <body>
     <h1>欢迎欢迎，热烈欢迎</h1>
     ${contextPath}
   </body>
</html>