<%@ page contentType="text/html; charset=UTF-8"%>
<div class="l-window" id="msgTip"
	style="width: 250px; height: 0px; display: none; position: absolute; bottom: 0px; right: 0px; overflow: hidden;">
<!-- 标题 -->
<div class="l-window-tl">
<div class="l-window-tr">
<div class="l-window-tc">
<div style="MozUserSelect: none; KhtmlUserSelect: none"
	class="l-window-header l-unselectable l-window-draggable" align=left
	unselectable="on">
<div class="l-tool l-tool-close" onclick="closeTip();">&nbsp;</div>
<span class="l-window-header-text">温馨提示</span></div>
</div>
</div>
</div>
<!-- 内容 -->
<div class="l-window-bwrap">
<div class="l-window-ml">
<div class="l-window-mr">
<div class="l-window-mc">
<table>
	<tr>
		<td width="10%">&nbsp;</td>
		<td class="l-window-body">
		<div style="width: 200px; font-size: 12px;">收到<font color="red"
			id="unreadCount">2</font>条消息, <a href="all_inbox_list.jsp">点击查看</a>
		</div>
		</td>
		<td width="10%">&nbsp;</td>
	</tr>
	<tr>
		<td width="10%">&nbsp;</td>
		<td class="l-window-body"><input type="checkbox" id="nextShow"><label>下次不再显示</label>
		</td>
		<td width="10%">&nbsp;</td>
	</tr>
</table>


</div>
</div>
</div>
<!-- 脚部分 -->
<div class="l-window-bl l-panel-nofooter">
<div class=l-window-br>
<div class=l-window-bc></div>
</div>
</div>
</div>
</div>

<script type="text/javascript">
//初始化开始控制逐渐显示
var showtimer = null;
var checktimer = null;
var httpRequest = null;

//表示当前动作
var showing = false;
var hiding = false;

//设置提示显示的时间(s)
var showtime = 5;
//设置提示逐渐显示的速度(ms),设置越大显示越慢
var speed = 30;
//设置多少时间请求一次未读消息(s)
var reqtime = 30;

window.onload = function(){
	//开启定时获得未读消息
	//showtimer = setInterval(showTip , speed);
	intervalCheck();
	checktimer = setInterval(intervalCheck , reqtime*1000);	
}
//显示
function showTip()
{
	if(hiding)
		return;	
	showing = true;
	var height = parseInt(document.getElementById("msgTip").style.height);
	if(height==0){
		document.getElementById("msgTip").style.height = "1px";
		document.getElementById("msgTip").style.display = "block";
	}else if(height < 76){
		height++;
		document.getElementById("msgTip").style.height = height + "px";
	}else if(height == 76){
		clearInterval(showtimer);
		showing = false;
		//设置关闭定时
		setTimeout(
			function(){
				showtimer = setInterval(hideTip , speed);
			},
			showtime*1000
		);
	}
}
//隐藏
function hideTip(){
	if(showing)
	 	return;
	hiding = true;
	var height = parseInt(document.getElementById("msgTip").style.height);
	if(height > 0){
		height--;
		document.getElementById("msgTip").style.height = height + "px";
	}else if(height == 0){
		document.getElementById("msgTip").style.display = "none";
		clearInterval(showtimer);	
		hiding = false;  
		if(document.getElementById("nextShow").checked){
			clearInterval(checktimer);
		}
	}
}
function closeTip(){
	showtimer = setInterval(hideTip , speed);
	if(document.getElementById("nextShow").checked){
		clearInterval(checktimer);
	}
}
//创建ajax请求
function GetXmlHttpObject()
{
	var xmlHttp = null;
	try{
	    // Firefox, Opera 8.0+, Safari
	    xmlHttp=new XMLHttpRequest();
    }catch (e){
    	// Internet Explorer
    	try{
      		xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
      	}catch (e){
      		xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
      	}
    }
	return xmlHttp;
}
function intervalCheck(){
	httpRequest = GetXmlHttpObject();
	httpRequest.open('post' , 'checkMessage.jsp' , true);
	httpRequest.setRequestHeader('Content-Type','application/x-www-form-urlencoded; charset=UTF-8');
	httpRequest.onreadystatechange = getTip;	
	httpRequest.send(null);
}
function getTip(){
	if(httpRequest.readyState == 4 &&　httpRequest.status== 200){
		//设置未读条数
		var resText =  parseInt(httpRequest.responseText);
		if(resText != 0 && !isNaN(resText)){
			document.getElementById("unreadCount").innerHTML　= resText;　
			showtimer = setInterval(showTip , speed);			
		}
	}	
}

</script>
