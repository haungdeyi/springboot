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
       <script type="text/javascript" src="${pageContext.request.contextPath}/js/vue-router-3.1.3.js"></script>
   </head>

   <body>
       <div id="app">
          <p v-if="goodList.length == 0">购物车为空</p>
          <table v-else="goodList.length" class="table table-bordered table-hover" :style="text">
             <thead>
               <tr>
                 <td>序号</td>
                 <td>品名</td>
                 <td>价格</td>
                 <td></td>
                 <td></td>
               </tr>
             </thead>
             <tbody>
               <tr v-for="(item,index) in goodList">
                 <td>{{index + 1}}</td>
                 <td>{{item.name}}</td>
                 <td>{{item.price}}</td> 
                 <td>
                    <button class="btn btn-sm" :disabled="item.disabled" v-on:click="sub(index)">-</button>
                    <span>{{item.count}}</span>
                    <button class="btn btn-sm" @click="add(index)">+</button>
                 </td> 
                 <td><a class="btn btn-danger" @click.prevent="deleted(item.id)">删除</a></td>  
               </tr>
             </tbody>
          </table>
          <p :style="text">总计：{{sum}} ￥</p>
       </div>
   </body>
   <script type="text/javascript">
       var vm = new Vue({
    	   el : "#app",
    	   data : {
    		   text : {'text-align':'center'},
    		   goodList : [
    			   {id:1,name:"二狗子",price:250,count:1,disabled : true},
    			   {id:2,name:"麻雷子",price:251,count:1,disabled : true},
    			   {id:3,name:"大呲花",price:252,count:1,disabled : true},
    			   {id:4,name:"二踢脚",price:253,count:1,disabled : true}
    		   ]
    	   },
    	   methods : {
    		   sub : function(index){
    			  this.goodList[index].count -= 1;   
    			  if(this.goodList[index].count == 1){
    				  this.goodList[index].disabled = true;  
      			  }
    		   },
    		   add : function(index){
    			   if(this.goodList[index].count == 1){
    				   this.goodList[index].disabled = false;
    			   }
    			   this.goodList[index].count += 1;
    		   },
    		   deleted : function(id){
    			   for(var i=0;i<this.goodList.length;i++){
    				  if(this.goodList[i].id == id){
    					  //从下标i开始删除一个元素
    					  this.goodList.splice(i,1);
    				  }
    			   }
    		   }
    	   },
    	   computed : {
    		   sum : function(){
    			   var sum = 0;
    			   for(var i=0;i<this.goodList.length;i++){
    				   sum += this.goodList[i].price * this.goodList[i].count;
    			   }
    			   return sum;
    		   }
    	   }
       });
   </script>
</html>