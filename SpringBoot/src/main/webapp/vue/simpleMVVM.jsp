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
       <script type="javascript/text" src="${pageContext.request.contextPath}/js/jquery-3.4.1.js"></script>
       <script type="javascript/text" src="${pageContext.request.contextPath}/js/bootstrap.js"></script>
   </head>

   <body>
      <div id="app">
      
      </div>
   </body>
   <script type="text/javascript">
      /* function MVVM(options){
    	 var _this = this;
    	 //让当前对象的data指向options的data
    	 this.data = options.data;
    	 Object.keys(options.data).forEach(function(key){
    		 _this.proxyData(key);
    	 });
      } */
      
      MVVM.prototype = {
    		  proxyData : function(key){
    			  var _this = this;
    			  //不劫持数组
    			  if(typeof key == "object" && !(key instanceof Array)){
    				  var _keys = key
    				  Object.keys(_keys).forEach(function(key){
    					  _this.proxyData(key);
    				  });
    			  }
    			  //给一个对象动态定义属性，实现劫持数据
    			  Object.defineProperty(_this,key,{
    				 //是否可设置
    				 configurable : false,
    				 //是否可枚举
    				 enumerable : true,
    				 //得到数据
    				 get : function proxyGetter(){
    					 return _this.data[key];
    				 },
    				 //修改当前对象data中的名为key的属性，会同步修改options对象data中对应的key的值，因为它们指向的是同一个对象
    				 set : function proxySetter(newValue){
    					 _this.data[key] = newValue;
    				 }
    			  })
    		  }
      }
      var 
   
   </script>
</html>