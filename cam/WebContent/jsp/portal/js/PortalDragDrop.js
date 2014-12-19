var wigdiv={
		getWidth:function(){
			return document.body.offsetWidth;//浏览器工作区域内页面宽度
		},
		getHeight:function(){
			return document.body.offsetHeight;
		},
		//滚动条TOP
		scrollTop:function(){
			return document.documentElement.scrollTop ? document.documentElement.scrollTop : document.body.scrollTop;
		},
		//滚动条Left
		scrollLeft:function(){
			return document.documentElement.scrollLeft ? document.documentElement.scrollLeft : document.body.scrollLeft;
		},
		//滚动条Right
		scrollRight:function(){
			return document.documentElement.scrollRight ? document.documentElement.scrollRight : document.body.scrollRight;
		},
		//当前工作区clientHeight
		clientHeight:function(){
			return document.documentElement.clientHeight ? document.documentElement.clientHeight : document.body.clientHeight;
		},
		//当前工作区clientWidth
		clientWidth:function(){
			return document.documentElement.clientWidth ? document.documentElement.clientWidth : document.body.clientWidth;
		},
		//显示隐藏操作Widget的面板
		showdiv:function(){
			var showdiv=document.createElement("div");
			showdiv.setAttribute('id','showdiv');
			showdiv.style.position="absolute";
			showdiv.style.left="0";
			showdiv.style.top=wigdiv.getHeight()-30;
			showdiv.style.background="green";
			showdiv.style.opacity="0.6";
			showdiv.style.left="0";
			showdiv.style.width="80px";
			showdiv.style.height="20px";
			showdiv.style.zIndex = "10000";
			showdiv.appendChild(wigdiv.btnindiv());
			return showdiv;
		},
		//widget的存放面板
		tempdiv:function(){
			var bgObj=document.createElement("div");//创建一个div对象（背景层）
			//定义div属性，即相当于
			//<div id="bgDiv" style="position:absolute; top:0; background-color:#777; filter:progid:DXImagesTransform.Microsoft.Alpha(style=3,opacity=25,finishOpacity=75); opacity:0.6; left:0; width:918px; height:768px; z-index:10000;"></div>
			bgObj.setAttribute('id','bgDiv');
			bgObj.style.position="absolute";
			bgObj.style.top="0";
			bgObj.style.background="white";
			bgObj.style.filter="progid:DXImageTransform.Microsoft.Alpha(style=2,opacity=25,finishOpacity=75";
			bgObj.style.opacity="0.6";
			bgObj.style.left="0";
			bgObj.style.display="none";
			bgObj.style.width=140+ "px";
			bgObj.style.height=wigdiv.getHeight() + "px";
			bgObj.style.zIndex = "10000";
			bgObj.innerHTML=wigdiv.tabPanel();
			document.body.appendChild(bgObj);	
			document.body.appendChild(wigdiv.showdiv());
			
			var dd = new L5.Element(L5.get("dd"));   
			dd.dd = new L5.dd.DDProxy(L5.get("dd").id, '_group');  
		},
		btnindiv:function(){
			var button=document.createElement("input");//创建一个input对象（提示框按钮）
			//定义input的属性，即相当于
			//<input type="button" align="center" style="width:100px; align:center; margin-left:250px; margin-bottom:10px;" value="关闭">
			button.setAttribute("type","button");
			button.setAttribute("value","显示工具面板");
			button.setAttribute("id","btn");
			button.style.width="80px";
			button.style.align="center";
			button.style.marginLeft="0px";
			button.style.marginBottom="0px";
			button.style.background="red";
			button.style.border="1px solid "+ "red";
			button.style.color="white";
			button.onclick=wigdiv.move;
			return button;
		},
		//显示/隐藏工具面板事件
		move:function(){
			var val=L5.getDom("btn").value;
			if(val=='显示工具面板'){
				L5.get("bgDiv").slideIn('l',{duration: 1});
				L5.getDom("btn").value="隐藏工具面板";
			}else{
				L5.get("bgDiv").slideOut('l',{duration: 1});
				L5.getDom("btn").value="显示工具面板";
			}
		},
		divScroll:function(){ 
			L5.getDom("showdiv").style.top=(wigdiv.scrollTop()+wigdiv.clientHeight()-document.getElementById("showdiv").offsetHeight)+"px";
			L5.getDom("showdiv").style.left=wigdiv.scrollLeft()+"px";
			L5.getDom("bgDiv").style.top=(wigdiv.scrollTop())+"px";
			L5.getDom("bgDiv").style.left=(wigdiv.scrollLeft())+"px";
		},
		tabPanel:function(){
			var aa="<div id='dd' style='cursor:pointer;align:center;'><ul id='nav'><li>待办事项<li></ul></div>";
			return aa;
		}
}
window.onscroll=wigdiv.divScroll;   
window.onresize=wigdiv.divScroll;   
window.onload=wigdiv.divScroll;
