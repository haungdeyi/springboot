
    function MVVM(options){
	  	 this.el = options.el;
	  	 this.data = options.data;
	  	 //一个vm实例对应一个指令集
	  	 this.directives = new Directives();
	  	 //一个vm实例对应一个监听对象，监听vm实例上所有被使用的data
	  	 this.listener = new Listener();
	  	 //编译vm实例控制的区域
	  	 if(this.el){
	  		 new Compiler(this.el,this);
	  	 }
	  	 //数据劫持
	  	 this.proxyData(this.data);
	  	 //绑定数据到vm实例上
	  	 this.bind(this.data);
	  	 //绑定methods里面所有方法到vm上
	  	 this.bind(options.methods);
	  	 console.log(this.listener);
    }
	
    MVVM.prototype = {
    		proxyData : function(data,dataExpr){
        		if(data && typeof data === "object"){
    				  for(let key in data){
    					  //取出data[key]，判断是否对象，如果是则逐级劫持
    					  if(typeof data[key] === "object"){
    						 if(dataExpr){
    							 dataExpr.push(key);
    						 }
    						 else{
    							 dataExpr = new Array(key); 
    						 }
    						 this.proxyData(data[key],dataExpr);
    						 //递归完毕时需要将栈顶的元素弹出，因为递归结束时还会push一次
    						 dataExpr.pop();
    					  }
    					  //将当前的key push进dataExpr中
    					  if(dataExpr){
    						 dataExpr.push(key);
    						 //set方法每次执行时都会根据属性定义时所传入的参数作为执行依据
    						 //因为dataExpr最后会被清空，如果传入dataExpr的话，那么set方法执行时指向的dataExpr
    						 //也为空。所以需要得到一个新数组并传入definedReactive()中，才能得到正确的结果
    						 var newArray = dataExpr.slice(0,dataExpr.length);
    					  }
    					  
    					  //使用Object.defineProperty进行数据劫持(实质上是重新定义对象上的属性)
    					  this.definedReactive(data,key,data[key],newArray);
    					  //属性定义完毕后将key弹出，开始下一个属性的定义
    					  if(dataExpr){
    						  dataExpr.pop();
    					  }
    				  }
    		    }
        	},
        	
	    	definedReactive : function(data,key,curentValue,dataExpr){
	    		   var _this = this;
	    		  //给一个对象动态定义属性，实现劫持数据
	  			  Object.defineProperty(data,key,{
	  				 //是否可删除
	  				 configurable : false,
	  				 //可写,与getter、setter不能共存
	  				 //wirteable : true,
	  			     //value : "值",
	  			     
	  				 //是否可枚举
	  				 enumerable : true,
	  				 //得到数据
	  				 get : function(){
	  					 //如果调用data[key]的话就会调用get方法，所以会出现死循环
	  					 return curentValue;
	  				 },
	  				 //修改当前对象data中的名为key的属性，会同步修改options对象data中对应的key的值，因为它们指向的是同一个对象
	  				 set : function(newValue){
	  					 if(newValue != curentValue){
	  						//如果赋的值是一个对象，也需要劫持
	  						if(typeof newValue == "object"){
	  							_this.proxyData(newValue);
	  						} 
	  						curentValue = newValue;
	  						//发布通知
	  						if(dataExpr && dataExpr.length > 0){
	  							key = dataExpr.join(".").toString();
	  						}
	  						_this.listener.notify(key);
	  					 }
	  				 }
	  			  });
	    	},
	    	
	    	//绑定数据到vm实例上
	    	bind : function(data){
	    		//用var的时候会有问题,绑定的都是最后一个数据。因为js不存在代码块变量
	    		//不支持多级绑定。只能绑定到data.student,而不能绑定到data.student.name的层次
	    		for(let key in data){
	    			Object.defineProperty(this,key,{
	    				//获取数据
	    				get : function(){
	    					return data[key];
	    				},
	    				
	    				//更新数据
	    				set : function(newValue){
	    					data[key] = newValue;
	    				}
	    			});
	    		}

	    	}
    }
    
    function Compiler(el,vm){
    	
  	  this.el = this.isElementNode(el) ? el : document.querySelector(el);
  	  
  	  this.vm = vm;
  	  
  	  //获取当前元素的节点并移到文档碎片中
  	  var fragment = this.nodeFragment(this.el);
  	  
  	  //把文档碎片中节点的内容在内存中进行编译、替换
  	  this.compile(fragment);
  	  
  	  //将编译好的节点内容重新塞回页面(dom)
  	  this.el.appendChild(fragment);
  	  
    }
    
    //Compiler函数的原型对象
    Compiler.prototype = {
  		  isElementNode : function(el){
  			  
			//判断当前元素是否是元素节点类型
  			return el.nodeType === 1;  
  		  },
  		  
  		  //把节点移到内存中
  		  nodeFragment : function(node){
  			   //创建文档碎片
  			   var fragment = document.createDocumentFragment();
  			   var firstChild;
  			   //遍历node的子节点
  			   while(firstChild = node.firstChild){
  				   //将子节点从dom中移动到文档碎片
  				   fragment.appendChild(firstChild);
  			   }
  			   //返回文档碎片
  			   return fragment;
  		  },
  		  
  		  //编译节点
  		  compile : function(node){
  			  //得到节点的所有子节点，返回的是Nodelist，类似于函数的arguments
  			  var childNodes = node.childNodes;
  			  //将Nodelist转为数组
  			  var arry = Array.prototype.slice.call(childNodes);
  			  for(var i = 0; i < childNodes.length; i++){
  				  var childNode = childNodes[i];
  				  //子节点是否为元素节点
  				  if(this.isElementNode(childNode)){
  					 //递归遍历该元素节点下的子节点
  					 this.compile(childNode);
  					 this.compileElementNode(childNode);
  				  }
  				  else{
  					 this.compileTextNode(childNode);
  				  }
  			  }
  		  },
  		  
  		  //编译元素节点
  		  compileElementNode : function(elementNode){
  			  //得到元素节点的attributes，是一个NodeMapList。是一个个的attrName:attrValue组成的list
  			  var attributes = elementNode.attributes;
  			  for(var i = 0 ; i < attributes.length;i++){
  				  //取出属性名
  				  if(attributes[i].name.startsWith("x-")){
  					  //将指令拆分，然后取出指令名
  					  var directName = attributes[i].name.split("-")[1];
  					  //取出属性值(表达式)
  					  var dataExpr = attributes[i].value;
  					  //编译指令绑定的属性值
  					  var compileValue = this.vm.directives.adapter(this.vm,elementNode,directName,dataExpr,this);
  					  //model指令用于绑定输入框，需要特殊处理
  					  if(directName == "model"){
  						  this.showContent(elementNode,compileValue);
  					  }
  					  else{
  						  //将编译后返回的数据替换指令绑定的的属性值
  	  	  				  this.showContent(attributes[i],compileValue);  
  					  }
  				  }
  			  }
  		  },
  		  
  		  //编译文本节点
  		  compileTextNode : function(textNode){
  			  var textContent = textNode.textContent;
  			  //是否匹配插值表达式
  			  if(/\{\{(.+?)\}\}/.test(textContent)){
  				 //拿出{{}}中的内容
  				 var vn = textContent.match(/\{\{(.+?)\}\}/g).toString();
  				 var dataExpr = vn.substring(2,vn.length-2);
  				 //将编译后的值替换掉原先文本中的值
  				 this.showContent(textNode,this.vm.directives.adapter(this.vm,textNode,"text",dataExpr,this));
  			  }
  		  },
  		  
  		  //渲染编译后的值
  		  showContent : function(node,value){
  			  //如果是文本节点则需要设置textContent ，而不是value
  			  if(node.nodeType === 3){
  				  node.textContent = value;
  			  }
  			  else{
  				  node.value = value;
  			  }
  		  }  
    };
    
    
    //指令集构造函数
    function Directives(){
    	//适配器
    	this.adapter = function(vm,element,directName,dataExpr,compile){
    		return this[directName](vm,element,dataExpr,compile);
    	}
    }
    
    Directives.prototype = {
    		//绑定模型数据
    		model : function(vm,element,dataExpr,compile){
    			//添加观察者到观察者集合中，实现model实时绑定到view
    			vm.listener.addReader(new Observer(vm,dataExpr,compile.showContent,element));
    			//实现view的数据实时绑定到model
    			element.addEventListener("input",function(event){
    				let arry = dataExpr.split(".");
                    if(arry.length == 1){
                    	vm.data[arry[0]] = event.target.value;
                    }
                    else{
                    	let current = vm.data[arry[0]];
                    	for(var i = 1;i < arry.length -1;i++){
        					current = current[arry[i]];
        				}
                    	current[arry[i]] = event.target.value;
                    }
    			});
    			
    			/*
    			 *箭头函数：(event)是函数的参数列表
    			 *         {.....}是函数体
    			 *         this的指向不同，箭头函数的 this是在定义的时候就已经绑定它所在函数的this，而
    			 *         函数所在的this要看函数定义在哪个对象下，而不是在调用的时候根据调用位置决定。
    			 *         例如：此例子中箭头函数所在的函数是model，而model函数是定义在Directives对象
    			 *         下的所以箭头函数的this指向的是Directives。
    			element.addEventListener("input",(event) =>{
    				vm.data[dataExpr] = event.target.value;
    			});
    			*/
    			return this.compileData(vm,dataExpr);
    		},
    		
    		//监听事件
    		onclick : function(vm,element,dataExpr,compile){
    			element.addEventListener("click",function(){
    				//在点击事件的回调函数中调用vm实例上绑定的方法，并指定方法的运行环境
    				vm[dataExpr].call(vm);
    			});
    		},
    		
    		text : function(vm,element,dataExpr,compile){
    			 vm.listener.addReader(new Observer(vm,dataExpr,compile.showContent,element));
    			 return this.compileData(vm,dataExpr);
    		},
    		
    		//将表达式编译成具体的值
    		compileData : function(vm,dataExpr){
    			var obj = dataExpr.split(".");
    			var current = vm.data[obj[0]];
                //基本类型直接返回
    			if(obj.length == 1){
    				return current;
    			}
    			//引用类型逐级取值
    			else{
    				for(var i = 1;i < obj.length;i++){
    					current = current[obj[i]];
    				}
    				return current;
    			}
    		},
    }
    
    //观察者(订阅方)，订阅监听者发布的消息
    function Observer(vm,dataExpr,showContent,element){
    	this.vm = vm;
    	//每个观察者只观察一个表达式
    	this.dataExpr = dataExpr;
    	this.showContent = showContent;
    	this.element = element;
    	this.directives = vm.directives;
    	//先取出所观察的表达式的值
    	this.oldValue = this.getOldValue(this.vm,this.dataExpr);
    }
    
    Observer.prototype = {
    	 getOldValue : function(){
    		 var oldValue = this.directives.compileData(this.vm,this.dataExpr);
    		 return oldValue;
    	 },
    	 
    	 updateValue : function(){
    		 var newValue = this.directives.compileData(this.vm,this.dataExpr);
    		 //更新时先判断如果新值与旧值不等，才进行更新
    		 if(newValue != this.oldValue){
    			 //通知节点更新数据
    			 this.showContent(this.element,newValue);
    		 }
    	 }
    };
    
    //监听者，监听到数据变化时会发布消息
    function Listener(){
    	//存放所有的订阅者
    	this.myReader = [];
    }

    Listener.prototype = {
    	//添加订阅者	
    	addReader : function(observer){
    		this.myReader.push(observer);
    	},
    
        //通知订阅者数据变化了
        notify : function(key){
        	this.myReader.forEach(function(observer){
        		//只有观察者订阅的数据发生变化才更新
        		if(observer.dataExpr == key){
        			observer.updateValue();
        		}
        	});
        }
    };