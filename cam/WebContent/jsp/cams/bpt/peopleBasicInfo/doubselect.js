
function doubSelect (){		

		    
				/*
					render:渲染体id
					lsText:左选择框文字
					rsText:右选择框文字
					data:左边了数据(以二维数组形式)
					object:新建立的doubSelect对象(为全局变量)
					allmove:是否需要全部移动(默认false)
				*/
				this.config={
					render:"",
					lsText:"可选内容",
					rsText:"已选内容",
					data:[],
					object:"",
					allmove:false
				};
				this.leftSelect={};
				this.rightSelect={};
				this.leftoptions={};
				this.rightoptions={};
				this.str="";
				this.slect={};
				//出生化方法
				 this.init=function (config){
						this.config=config;
				 		this.render(config.render);
				 		this.leftSelect = document.getElementById("leftSelect"+this.config.render);   
				 		this.rightSelect = document.getElementById('rightSelect'+this.config.render);
				 		this.leftoptions = this.leftSelect.options
				 		this.rightoptions = this.rightSelect.options
				 		for(var b=0 ;b<config.data.length;b++ ){
				 			var option = new Option(config.data[b][1],config.data[b][0]);
							this.leftSelect.options.add(option);  
				 		}
				 };
				 //渲染
				 this.render=function(div){
				 
					
					
					this.str+="<table width='280' height='250' border='0' cellspacing='0' cellpadding='0' align='center'> ";
					this.str+="<tr><td width='110' align=left valign=bottom><p>"+this.config.lsText+"</p></td>";
					this.str+="<td></td><td width='110' align=left valign=bottom><p>"+this.config.rsText+"</p></td></tr>";
					this.str+="<tr><td width='110' align=center valign=center><span class='selectBorder'><select multiple  id='leftSelect"+this.config.render+"' ></select></span></td>";
					this.str+="<td width='20' align=center><input type = 'button' value ='---->' onclick='"+this.config.object+".moveRight()' ><br><br>";
					if(this.config.allmove){//如果需要添加全部移动
						this.str+="<input type = 'button' value ='-->>' onclick='"+this.config.object+".moveRightAll()' ><br><br>";
					}
					this.str+="<input type = 'button' value ='<----' onclick='"+this.config.object+".moveLeft()'><br><br>";
					if(this.config.allmove){
						this.str+="<input type = 'button' value ='<<--' onclick='"+this.config.object+".moveLeftAll()'><br><br>";
					}
					this.str+="</td><td width='"+this.config.width+"' align=center valign=center><span class='selectBorder'><select multiple  id='rightSelect"+this.config.render+"'></select></span></td> ";
					this.str+="</tr></table>";
					
					this.slect = document.getElementById(div);
					
					this.slect.innerHTML=this.str;
					
					
					
				 }
				 //向右边移动 
		 		this.moveRight= function (){   //取到leftSelect中所有option集合   
		 		 	var ops=this.leftSelect.getElementsByTagName("option");       
		 		 	for(var i=0;i<ops.length;i++){     
	 		 		   if(ops[i].selected){        
	 		 		  	 	this.rightSelect.appendChild(ops[i--]);                 
			 		 		}    
				 	 }
				 };  
				 //全部移动到右边  
		 		this.moveRightAll=  function (){     
		 		  	 var ops=this.leftSelect.getElementsByTagName("option"); 
		 		  	 for(var i=0;i<ops.length;i++){       
		 		  	   this.rightSelect.appendChild(ops[i--]); 
		 		  	  
		 		  	   } 
		 		   };  
		 		   //右边移动到左边  
			this.moveLeft= function (){     
	  	    	 var ops = this.rightSelect.getElementsByTagName('option');    
	  	    	 for(var i = 0 ; i<ops.length; i++){     
	    	        if(ops[i].selected){     
	    	        	 this.leftSelect.appendChild(ops[i--]);   
	    	        }    
	  	        }  
	  	    };  
				//全部移动到左边  
				this.moveLeftAll= function (){     
		 		  	 var ops=this.rightSelect.getElementsByTagName("option"); 
		 		  	 for(var i=0;i<ops.length;i++){       
		 		  	   this.leftSelect.appendChild(ops[i--]); 
		 		  	  
		 		  	   } 
		 		   };    
		 		  

		 		   //获取所有右边值
		 		this.getRightAll = function (){  
		 		   
		 		  	 var ops=this.rightSelect.getElementsByTagName("option"); 
		 		  	 var rightVule = new Array(ops.length);
		 		  	 for(var i=0;i<ops.length;i++){       
		 		  	   	rightVule[i]=new Array(2);
		 		  			rightVule[i][1]=ops[i].text;
		 		  			rightVule[i][0]=ops[i].value;
		 		  	   } 
		 		  	   
		 		  	return rightVule;
		 		   };    
		 		   //重新加载数据
		 		 this.reloadData=  function (ds){
		 		   	//this.leftSelect = document.getElementById("leftSelect"); 
		 		   	this.clearOptions();  
				 		for(var b=0 ;b<ds.length;b++ ){
				 			var option = new Option(ds[b][1],ds[b][0]);
							this.leftSelect.options.add(option);  
				 		}
				 		this.config.data=ds;
		 		   };
		 		   //清空options集合
				  this.clearOptions=function (){
				        var llength = this.leftoptions.length;
				        for(var i=llength-1;i>=0;i--){
				            this.leftoptions.remove(i);
				        }
				        var rlength = this.rightoptions.length;
				        for(var i=rlength-1;i>=0;i--){
				            this.rightoptions.remove(i);
				        }
				    };
				    //返回数据数组
				    this.getDataArrary=function(){
				    	return this.config.data;
				    }
				
}

