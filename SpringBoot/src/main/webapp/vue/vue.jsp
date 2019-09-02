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
       <script type="text/javascript" src="${pageContext.request.contextPath}/js/vue.2.0.js"></script>
       <script type="text/javascript" src="${pageContext.request.contextPath}/js/vue-router-3.1.3.js"></script>
   </head>

   <body>
     <div id="vue1">
        <!-- v-cloak解决插值表达式的闪现问题 -->
        <p v-cloak>{{msg}}</p>
        
        <!-- v-text也可以解决插值表达式闪烁问题，并完全替换元素内容 -->
        <h3 v-text="msg">-------{{msg}}-------</h3>
        
        <!-- v-html将插值表达式的值解析为html元素 -->
        <p v-html="msg2"></p>
        
        <!-- v-bind用于绑定变量,实现数据的单向绑定。可以简写为: -->
        <input type="button" value="按钮" v-bind:title="button_title"/>
        
        <!-- v-if用于判断 -->
        <div v-if="msg.length > 10">条件为真时我会出现</div>
        
        <!-- v-for用于循环遍历对象、数组、集合 -->
        <table class="table table-bordered">
          <!-- i是当前循环的下标 -->
          <tr v-for="(person,i) in array">
             <td>{{person.name}}</td>
             <td>{{person.age}}</td>
             <td>索引：{{i}}</td>
          </tr>
          <tr v-for="feild in object">
            <td>字段值：{{feild}}</td>
          </tr>
          <tr v-for="(val,key) in object">
            <td>键：{{key}}</td>
            <td>值：{{val}}</td>
          </tr>
        </table>
        
        <!-- 将方法的返回值作为循环的数据 -->
        <table class="table table-bordered">
          <tr v-for="item in search(this.keywords)">
             <td>姓名：{{item.name}}</td>
             <td>智商：{{item.IQ}}</td>
          </tr>
        </table>
        
        <!-- v-model命令用于双向绑定模型数据 -->
        <label>改变model数据</label><input type="text" v-model="msg"/>
        
        <!-- v-on命令用于绑定事件。可以简写成@ -->
        <p><button class="btn btn-success" v-on:click="changeMsg()">点我点我</button></p>
        
        <!-- 使用事件修饰符 : .stop(阻止冒泡)     .prevent(阻止默认行为) 
                            .onece(只触发一次)  .self(只触发自身绑定的事件)
                            .captuer(一捕获事件马上触发)
        -->
        
        <!-- 绑定class属性 -->
        <p><a :class="classAttr" href="#" @click.prevent="prevent()">阻止事件的默认行为</a></p>
        
        <!-- 绑定style -->
        <p :style="style">你好呀</p>
        
        <!-- 使用过滤器 -->
        <p>{{upper | toUpper}}</p>
        
        <!-- 当前时间 -->
        <p>当前日期：{{dateStr | transDate}}</p>
        
        <!-- 使用自定义指令 -->
        <label>焦点在这里:</label><input type="text" v-focus="'指令的参数'"/>
        
        <!-- 挂载(渲染)到页面前 -->
        <h4 id="beforeMount">{{msg}}</h4>
        
        <!-- 调用外部函数 -->
        <button class="btn btn-success" v-on:click="callOuterFunction()">调用外部函数</button>
        
        <!-- 使用动画-->
        <button class="btn btn-danger" v-on:click="transition()">动画</button>
        <transition>
          <h3 v-if="flag">演示动画</h3>
        </transition>
        
        <!-- 使用全局组件 -->
        <my-comp1></my-comp1>

        <!-- 使用私有组件 -->
        <login v-bind:parentmsg="parentCompMsg"></login>
        
        <!-- 组件切换,方式一 -->
        <a href="#" v-on:click.prevent="changeComponent('myComp1')">全局组件</a>
        <a href="#" v-on:click.prevent="changeComponent('login')">私有组件</a>
        <my-comp1 v-if="flag"></my-comp1>
        <login v-else="flag"></login>
        
        <!-- 方式二 -->
        <component :is="componentName"></component><hr>
        
        <!-- 通过属性绑定向子组件传递父组件的数据 -->
        <login v-bind:parentmsg="parentCompMsg"></login>
        
        <!-- 通过事件绑定向子组件传递父组件的方法 -->
        <login v-on:func="prevent"></login>
        
        <!-- 通过ref得到原生DOM对象 -->
        <h1 id="ref" ref="ref">通过ref得到原生DOM对象</h1>
        <p>--------------------------------------------</p>
        
        <!-- 放入路由选择 -->
        <a class="btn btn-success" href="vue/vue.jsp#/login?id=10">登陆</a>
        <a class="btn btn-danger" href="vue/vue.jsp#/register/二踢脚">注册</a>
        <!-- <router-link to="/login">登陆</router-link>
        <router-link to="/register">注册</router-link> -->
        <router-view></router-view>
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
      function outerFunction(vue){
    	  alert("我是外部的全局函数，谁要调用我？？");
    	  console.log(vue.msg);
      }
      
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
    		//每个路由规则都是一个对象，有两个必须的属性：path(监听的路径)、component(匹配后选择的组件对象)
    		{path : "/login",component:login},
    		//占位符传参
    		{path : "/register/:name",component:register}
    	  ]
      });
      
      //定义Vue的全局过滤器
      Vue.filter("filterName",function(value,params){
    	  alert("定义了一个Vue的全局过滤器");
      });
      
      //自定义全局Vue指令
      //参数1是指令的名称，不需加上v-
      //参数二是一个对象，里面有几个相关的钩子函数
      Vue.directive("focus",{
    	  //绑定时调用的函数,函数的第一个参数是对应绑定的原生的js元素
    	  //第二个参数是binding对象。有name、value等属性
    	  bind : function(element){
    		  element.focus();
    	  },
    	  //插入时调用的函数
    	  inserted : function(element,binding){
    		  //使用隐藏的参数集取得第一个参数
    		  arguments[0].focus();
    		  console.log(binding.value);
    	  },
    	  //更新时调用的函数
    	  updated : function(){
    		  
    	  }
      });
      
      //定义Vue的全局组件
      //方式一
      //使用驼峰命名法时需要使用-，否则直接使用组件名进行调用
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
    		  object : {phone:1111,email:"qq.com"},
    		  //有“-”时需要把属性放在''中
    		  classAttr : {btn:true,'btn-primary':true},
    		  style : {'font-size':'100px'},
    		  keywords : "二狗子",
    		  dateStr : "2019-08-31 12:00:00",
    		  flag : true,
    		  componentName : "",
    		  parentCompMsg : "父组件中的数据"
    		  
    	  },
    	  
    	  //函数集
    	  methods :{
    		  changeMsg : function(){
    			  this.msg = "你点击了按钮";
    		  },
    		  
    		  prevent : function(){
    			  alert("默认行为被我阻止了");
    			  alert(this.$refs.ref.innerText);
    		  },
    		  
    		  search : function(keywords){
    			  console.log(keywords);
    			  return [{name:"二狗子",IQ:0},{name:"麻雷子",IQ:1}];
    		  },
    		  
    		  //调用外部函数
    		  callOuterFunction : function(){
    			  outerFunction(this);
    		  },
    		  
    		  //演示动画
    		  transition : function(){
    			  this.flag = true;
    		  },
    		  
    		  changeComponent : function(componentName){
    			 //this.flag = !this.flag;
    			 this.componentName = componentName;
    		  }
    	  },
    	  
    	  //局部过滤器集
    	  filters : {
    		  toUpper : function(value){
    			  return value.toUpperCase();
    		  },
    		  
    		  //转换为本地日期
    		  transDate : function(dateStr){
    			  return new Date().toLocaleString();
    		  }
    	  
    	  },
    	  
    	  //局部自定义指令集
    	  directives : {
    		  'pri' : {
    			  bind : function(element,binding){
    				alert("我是局部自定义指令集");  
    			  },
    			  
    			  inserted : function(element,binding){
    				  
    			  },
    			  
    			  updated : function(element,binding){
    				  
    			  }
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
    	  },
    	  
    	  //定义Vue实例私有组件(子组件)
    	  components : {
    		login : {
    			template : "#template",
   				//组件中的属性
   	    		props : ["parentmsg"],
   	    	    //组件中的方法集
   	    		methods : {
   	    			subClick : function(){
   	    				this.$emit('func');
   	    			}
   	    		}
    		}, 
    	  },
    	  
    	  //注册路由
    	  router : vueRoute,
    	  
    	  //Vue的生命周期函数
    	  //创建前
    	  beforeCreate :function(){
    		 console.log("我要被创建出来了");
    	  },
    	  
    	  //创建后
    	  created : function(){
    		  this.changeMsg();
    	  },
    	  
    	  //挂载(渲染)到页面前
    	  beforeMount : function(){
    		  alert(document.getElementById("beforeMount").innerText);
    	  },
    	  
    	  //挂载(渲染)后
    	  mounted : function(){
    		  alert(document.getElementById("beforeMount").innerText);
    	  },
    	  
    	  //循环监听,model更新前
    	  beforeUpdate : function(){
    	        alert("谁TM又要更新了");
    	  },
    	  
    	  //model更新前后
    	  updated : function(){
    		  alert("更新之后");
    	  },
    	  
    	  //销毁前
    	  beforeDestroy : function(){
    		  
    	  },
    	  
    	  //销毁后
    	  destroyed : function(){
    		  
    	  }
    	  
      });
   </script>
</html>