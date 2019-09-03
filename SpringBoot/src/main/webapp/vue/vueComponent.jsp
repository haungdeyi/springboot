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
       <script type="text/javascript" src="${pageContext.request.contextPath}/js/vue.2.0.js"></script>
   </head>

   <body>
      <div id="app1">
        <!-- 使用全局组件 -->
        <my-comp1></my-comp1>

        <!-- 使用私有组件,绑定parentmsg属性变量指向父组件的数据parentCompMsg -->
        <login v-bind:parentmsg="parentCompMsg"></login>
        <hr>
        
        <!-- 组件切换,方式一 -->
        <!-- <my-comp1 v-if="flag"></my-comp1>
        <login v-else="flag"></login> -->
        
        <!-- 方式二 -->
        <a href="#" v-on:click.prevent="changeComponent('myComp1')">全局组件</a>
        <a href="#" v-on:click.prevent="changeComponent('login')">私有组件</a>
        <component :is="componentName"></component><hr>
        
        <!-- 通过组件属性绑定向子组件传递父组件的数据 -->
        <login v-bind:parentmsg="parentCompMsg"></login>
        
        <!-- 通过事件绑定向子组件传递父组件的方法 -->
        <!-- func是子组件自定义的一个事件，通过$.emit()触发 -->
        <!-- 父组件在这个自定义事件上添加了监听，当子组件触发这个事件时，父组件的监听处理方法会执行 -->
        <login v-on:func="parentComponentMethod"></login>
        
        <!-- 通过ref得到原生DOM对象 -->
        <h1 id="ref" ref="ref">通过ref得到原生DOM对象</h1>
        <a class="btn btn-success" href="#" v-on:click.prevent="getRef()">点这里得到ref</a>
      </div>
      
      <!-- 在外部定义组件的模板，方便代码提示。要放在被Vue控制的区域外 -->
      <template id="template">
        <div>
          <p>我是私有组件，组件模板在外部定义</p>
          <p>取到父组件中的数据：{{parentmsg}}</p>
          <button class="btn btn-info" @click="subClick()">子组件的按钮</button>
        </div>
      </template>
   </body>
   <script type="text/javascript">
      
       //定义Vue的全局组件
	   //使用驼峰命名法时需要使用-，否则直接使用组件名进行调用
	   //参数一是组件名，参数2是一个模板对象
	   
	   //方式一
	   Vue.component("myComp1",{
	 	  template : "<h3>使用component方法创建的组件,----引用：{{message}}-----</h3>",
	 	  //组件中的data必须是function，返回值是Object
	 	  data : function(){
	 		  var object = {
	 				  message : "组件中的数据"
	 		  };
	 		  return object;
	 	  }
	   });
	   
	   //方式二
	   //定义模板，可以被组件引用
	   var template = Vue.extend({
	 	 //模板必须有且只有一个根元素
	 	 template : "<h3>使用extend方法创建的组件</h3>"
	 	 
	 	 //模板可以在外部定义，通过id引用，方便代码提示。
	 	 //template : "#template"
	   });
	   Vue.component("myComp2",template);
	   
	   //方式三
	   var tempObject = {
	 	 template : "<h3>使用extend方法创建的组件</h3>",
	 	 data : function(){
	 		 return {username : "乱七八糟"};
	 	 }
	   };
       Vue.component("myComp3",tempObject);
      
       //创建一个vm对象
       var vm = new Vue({
    	  el : "#app1",
    	  data : {
    		  parentCompMsg : "父组件中的数据",
    		  flag : true,
    		  componentName : ""
    	  },
    	  methods : {
    		  //监听子组件特定事件触发的处理函数
    		  parentComponentMethod : function(){
    			  alert("我是父类中的方法");
    		  },
    		  //切换组件
    		  changeComponent : function(componentName){
     			 //this.flag = !this.flag;
     			 this.componentName = componentName;
     		  },
    		  //得到ref属性
    		  getRef : function(){
    			  //得到原生js标签对象的text
    			  alert(this.refs.ref.innerText);
    		  }
    	  },
    	  //定义Vue实例私有组件(子组件)
    	  components : {
    		login : {
    			template : "#template",
   				//组件中的属性，用来接收父组件的数据
   	    		props : ["parentmsg"],
   	    	    //组件中的方法集
   	    		methods : {
   	    			subClick : function(){
   	    				//子组件触发自定义的func事件，父组件的监听事件会执行，可以在这里向父组件传送数据
   	    				this.$emit('func');
   	    				
   	    				//通过父链直接操作父组件中的数据(不推荐)
   	    				this.$parent.parentCompMsg = "直接改父组件额度数据";
   	    			}
   	    		}
    		}, 
    	  }
      });
   </script>
</html>