
  function MVVM(options){
	  	 var _this = this;
	  	 this.el = options.el;
	  	 this.data = options.data;
	  	 if(this.el){
	  		 new Compiler(this.el,this);
	  	 }
	  	 /*//让当前对象的data指向options的data
	  	 this.data = options.data;
	  	 Object.keys(options.data).forEach(function(key){
	  		 _this.proxyData(key);
	  	 });*/
   }
	    
	   /*  MVVM.prototype = {
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
	  				 //可写,与getter、setter不能共存
	  				 //wirteable : true,
	  			     //value : "值",
	  			     
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
	    } */
	 
    function Compiler(el,vm){
    	
  	  this.el = this.isElementNode(el) ? el : document.querySelector(el);
  	  
  	  this.vm = vm;
  	  
  	  //获取当前元素的节点并移到内存中处理
  	  var fragment = this.nodeFragment(this.el);
  	  
  	  //把节点的内容进行编译、替换
  	  this.compile(fragment);
  	  
  	  //将编译好的节点内容重新塞回页面
  	  this.el.appendChild(fragment);
  	  
    }
    
    //Compiler函数的原型对象
    Compiler.prototype = {
  		  isElementNode : function(el){
  			  //判断当前元素是否是节点类型
  			  return el.nodeType === 1;
  		  },
  		  
  		  //把节点移到内存中
  		  nodeFragment : function(node){
  			   //创建文档碎片
  			   var fragment = document.createDocumentFragment();
  			   var firstChild;
  			   //遍历子节点
  			   while(firstChild = node.firstChild){
  				   //将节点移到文档碎片中
  				   fragment.appendChild(firstChild);
  			   }
  			   //console.log(fragment);
  			   return fragment;
  		  },
  		  
  		  //编译节点
  		  compile : function(node){
  			  //得到节点的所有子节点，返回的是Nodelist，类似于函数的arguments
  			  var childNodes = node.childNodes;
  			  /*[...childNodes].forEach(child => {
  				if(this.isElementNode(child)){
					console.log("ele" , child);
			    }
			    else{
				    console.log("text" , child);
			    }
  			  });*/
  			  //将Nodelist转为数组
  			  var arry = Array.prototype.slice.call(childNodes);
  			  for(var i = 0; i < childNodes.length; i++){
  				  var childNode = childNodes[i];
  				  if(this.isElementNode(childNode)){
  					 //递归遍历该元素节点下的子节点
  					 this.compile(childNode);
  					 this.compileElement(childNode);
  				  }
  				  else{
  					 this.compileText(childNode);
  				  }
  			  }
  		  },
  		  
  		  //编译元素节点
  		  compileElement : function(element){
  			  //attributes类似于函数的arguments，是一个类数组
  			  var attributes = element.attributes;
  			  //console.log(attributes);
  			  for(var i = 0 ; i < attributes.length;i++){
  				  //console.log(attributes[i].name);
  				  if(attributes[i].name.startsWith("x-")){
  					  //将指令拆分，然后取出指令名
  					  var varName = attributes[i].name.split("-")[1];
  					  //编译指令绑定的属性值
  					  var compileValue = new Directives().adapter(varName,attributes[i].value,this.vm);
  					  //model指令用于绑定输入框，需要特殊处理
  					  if(varName == "model"){
  						  element.value = compileValue;
  					  }
  					  else{
  						  //将编译后返回的数据替换指令绑定的的属性值
  	  	  				  attributes[i].value = compileValue;  
  					  }
  					  
  				  }
  				console.log(attributes[i])
  			  }
  		  },
  		  
  		  //编译文本节点
  		  compileText : function(text){
  			  var textContent = text.textContent;
  			  //var content = ;
  			  if(/\{\{(.+?)\}\}/.test(textContent)){
  				 var vn = textContent.match(/\{\{(.+?)\}\}/g);
  				 var varName = vn.toString().substring(2,vn.length-2);
  				 new Directives().adapter("text",varName,this.vm);
  			  }
  		  }
  		  
  		  
    };
    
    
    //指令集构造函数
    function Directives(){
    	//适配器
    	this.adapter = function(directive,value,vm){
    		return this[directive](value,vm);
    	}
    }
    
    Directives.prototype = {
    		//绑定模型数据
    		model : function(value,vm){
    			return this.compileData(value,vm);
    		},
    		
    		//监听事件
    		on : function(){
    			
    		},
    		
    		text : function(value,vm){
    			return this.compileData(value,vm);
    		},
    		
    		compileData : function(value,vm){
    			var obj = value.split(".");
    			var current = {};
    			obj.forEach(function(item){
    				current = vm.data[item];
    			});
    			return current;
    		}
    }