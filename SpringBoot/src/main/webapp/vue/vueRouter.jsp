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
      <div id="app1">
        <!-- 放入路由选择 -->
        <!-- <a class="btn btn-success" href="vue/vue.jsp#/login?id=10">登陆</a>
        <a class="btn btn-danger" href="vue/vue.jsp#/register/二踢脚">注册</a> -->
        <router-link to="/login?id=10">登陆</router-link>
        <router-link to="/register/二踢脚">注册</router-link>
        <router-view></router-view>
       </div>
   </body>
   <script type="text/javascript">
       
	   //定义一个登陆组件字面量模板对象
	   var login = {
	 		  template:"<h3>这是一个登陆组件字面量对象，使用路由时选择的必须是组件字面量对象</h3>",
	 		  created : function(){
	 			  console.log(this.$route.query.id);
	 		  }
	 		  
	   };
	   //定义一个注册组件字面量模板对象
	   var register = {
	 	      template:"<h3>这是一个注册组件字面量对象，使用路由时选择的必须是组件字面量对象</h3>",
	 	      created : function(){
	 	    	  //第二种方式取得参数
	 			  console.log(this.$route.params.name);
	 		  }
	   };
	   
       //定义一个路由对象,可以传递一个配置对象
	   var vueRoute = new VueRouter({
	 	  //路由匹配规则
	 	  routes : [
	 		//每个路由规则都是一个对象，有两个必须的属性：path(监听的路径)、
	 		//component(匹配后选择的组件对象，必须是字面量模板对象，不能是组件名)
	 		{path : "/login",component:login},
	 		//占位符传参
	 		{path : "/register/:name",component:register}
	 	  ]
	   });
 
       var vm = new Vue({
    	   el : "#app1",
    	   data : {
    		   
    	   },
    	   //注册路由
     	   router : vueRoute
       });
   </script>
</html>