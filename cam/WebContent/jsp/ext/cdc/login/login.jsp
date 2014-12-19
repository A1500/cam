<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="com.inspur.cams.comm.message.cmd.ComLoginMsg"%>
<%@ page import="org.loushang.next.data.DataSet"%>
<%
String j_auth_action=request.getContextPath()+"/camsext?loginType=cdc";
String msg=(String)request.getSession().getAttribute("AuthenticationException");
if(msg==null)msg="";
DataSet msgDs = new DataSet();
ComLoginMsg comLoginMsg = new ComLoginMsg();
msgDs = comLoginMsg.queryMsg();
String ie=request.getHeader("User-Agent"); //得到浏览器等相关信息
String tips="";
if(ie.indexOf("MSIE")==-1){
	tips="您的浏览器非IE浏览器，请使用IE浏览器登录本系统 !";
}else{
	if(ie.indexOf("MSIE 11.0")==-1&&ie.indexOf("MSIE 10.0")==-1&&ie.indexOf("MSIE 9.0")==-1&&ie.indexOf("MSIE 8.0")==-1&&ie.indexOf("MSIE 7.0")==-1){
		tips="您的IE浏览器版本过低，请使用IE7及以上浏览器登录本系统！";
	}
}
String webPath =request.getContextPath()+"/";

%>
<html>
<head>
<title>基层政权与社区建设信息管理系统</title>
<style type="text/css">
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
.style1 {color: #FFFFFF}
.bd {
	font-family: 宋体;
	font-size: 14px;
	color: #376a81;
}
.textfield {
	BORDER-RIGHT: #000000 1px solid;
	BORDER-TOP: #000000 1px solid;
	FONT-WEIGHT: normal;
	BORDER-LEFT: #000000 1px solid;
	COLOR: #105194;
	BORDER-BOTTOM: #000000 1px solid;
	FONT-FAMILY: "Arial", "Helvetica", "sans-serif";
	TEXT-DECORATION: none;
	font-size: 14px;
}
a:link {
	font-family: 宋体;
	font-size: 14px;
	line-height: 150%;
	color: #4E5971;

}
a:visited {
	font-family: 宋体;
	font-size: 14px;
	color: #4E5971;
	text-decoration: none;
	line-height: 150%;
}
a:hover {
	font-family: 宋体;
	font-size: 14px;
	line-height: 150%;
	color: #0000FF;
	text-decoration: none;
}
</style>
<script language="javascript">

window.onload = function(){
	//获取随机码
	L5.Ajax.request({
	url : L5.webPath + "/command/dispatcher/org.loushang.bsp.security.web.RandomCodeCommand",
	sync : false,
	callback : successHandler
	});
	function successHandler(options,success,response){
	var o = L5.decode(response.responseText);
	document.getElementById("rdmCode").value = o.code;
	}
	}

function doSession(){
	if(window.dialogArguments!=null){
		window.dialogArguments.location=self.location;
		window.returnValue="aa";
		parent.close();
		return;
	}
	if(self!=top){top.location=self.location;}
}
doSession();
var bikky = document.cookie;
function getCookie(name) {
	var index = bikky.indexOf(name + "=");
	if (index == -1) return null;
	index = bikky.indexOf("=", index) + 1;
	var endstr = bikky.indexOf(";", index);
	if (endstr == -1) endstr = bikky.length;
	return unescape(bikky.substring(index, endstr));
}
var today = new Date();
var expiry = new Date(today.getTime() + 28 * 24 * 60 * 60 * 1000);
function setCookie(name, value) {
	if (value != null && value != "")
		document.cookie=name + "=" + escape(value) + "; expires=" + expiry.toGMTString();
	bikky = document.cookie;
}
function setall(){
	var userId = document.forms[0].userId.value;
	setCookie("userId",userId);
	var pwd = document.forms[0].pwd.value;
	setCookie("pwd",pwd);
}
function init(){
	var userId = getCookie("userId");
	if (userId != null && userId != "null") {
		document.forms[0].userId.value = userId;
	}
	var pwd = getCookie("pwd");
	if (pwd != null && pwd != "null") {
	}
}
function doLogin(){
	if(!check()) return;
	setall();
	document.forms[0].action ="<%=j_auth_action%>";
	document.forms[0].submit();
}
function check(){
	var userId = document.forms[0].userId;
	if(userId.value==""){
		alert("请输入用户名!");
		userId.focus();
		return false;
	}
	userId.value = userId.value;
	var pwd = document.forms[0].pwd;
	if(pwd.value==""){
		alert("请输入密码！");
		pwd.focus();
		return false;
	}
	return true;
}
//'enter' key,/=47,*=42,+=43
function keypress(e){
	if(!window.event){
		e = e.which;
	}else{
		e = window.event.keyCode;
	}
	if(e==13||e==42){	//'enter' key,*
		doLogin();
	}
}
</script>
</head>
<body onload="init()" onkeydown="keypress(event);" background="images/loginbg.png">
<DIV id=eMeng style="BORDER-RIGHT: #455690 1px solid; BORDER-TOP: #a6b4cf 1px solid; Z-INDEX:99999; right: 0px; VISIBILITY: hidden; BORDER-LEFT: #a6b4cf 1px solid; WIDTH: 340px; BORDER-BOTTOM: #455690 1px solid; POSITION: absolute; bottom: 0px; HEIGHT: 80px; BACKGROUND-COLOR: #c9d3f3">
	<TABLE style="BORDER-TOP: #ffffff 1px solid; BORDER-LEFT: #ffffff 1px solid" cellSpacing=0 cellPadding=0 width="100%" bgColor=#cfdef4 border=0>
	<TBODY>
		<TR>
			<TD style="FONT-WEIGHT: normal; FONT-SIZE: 12px; COLOR: #1f336b; PADDING-TOP: 4px;PADDING-left: 4px" align=left colSpan=2><span title=关闭 style="CURSOR: hand;color:red;font-size:12px;font-weight:bold;margin-right:4px;" onclick=closeDiv() >×</span> 消息提示：</TD>
			<TD style="PADDING-TOP: 2px;PADDING-right:2px" align=right width=19></TD>
		</TR>
		<%for(int k=0;k<msgDs.getCount();k++){%>
		<TR>
			<TD  colSpan=2 height=5 align="left">
				<DIV  style="display:block; font-size:12; float:left; text-decoration:none; white-space:nowrap; text-overflow:ellipsis; overflow: hidden; display:inline;color:#030303;">
				<font style="font-family: 宋体;"><%=msgDs.getRecord(k).get("MESSAGE_TITLE")%></font>
				</DIV>
			</TD>
			<TD  colSpan=1 height=5 align="right">
				<DIV style="display:block; font-size:12; float:left; text-decoration:none; white-space:nowrap; text-overflow:ellipsis; overflow: hidden; display:inline;color:#030303;">
				<a href=<%=webPath%>download?table=COM_MESSAGE_ATTACHMENT&column=FILE_CONTENT&filename=FILE_NAME&pk=ATTACHMENT_ID&ATTACHMENT_ID='<%=msgDs.getRecord(k).get("ATTACHMENT_ID")%>'><font style="font-family: 宋体;">附件</font></a>
				</DIV>
			</TD>
		</TR>
		<%} %>
	</TBODY>
	</TABLE>
</DIV>
<form name="frmLogin" method="post" action="">
<table width="100%" height="100%" cellpadding="0" cellspacing="0">
	<tr>
		<td align="center">
			<table width="605" height="355" cellpadding="0" cellspacing="0" background="images/login.png">
				<tr>
					<td style="padding-left:180px;padding-top:200px;">
						<table width="100%" cellpadding="0" cellspacing="2" class="bd">
							<tr>
								<td width="242" align="right"><b>用户名:             </td>
								<td><input type="text" name="userId" class="textfield" size="20"/></td>
							</tr>
							<tr>
								<td width="242" align="right"><b>密&nbsp;&nbsp;码:             </td>
								<td><input type="password" name="pwd" class="textfield" size="20"/></td>
							</tr>
							<tr>
								<td align="right"></td>
								<td>
									<table width="100%" cellspacing="0" cellpadding="0">
										<tr>
											<td width="90"><IMG style="cursor:hand;" src=<%=SkinUtils.getImage(request,"l5/dl.gif")%>  border="0" onclick="doLogin();"></td>
											<td><IMG style="cursor:hand;" src=<%=SkinUtils.getImage(request,"l5/qx.gif")%>  border="0" onclick="document.forms[0].reset();"></td>
	              						</tr>
	            					</table>
								</td>
							</tr>
							<tr>
								<td height="86" align="center" colspan=2><div UNSELECTABLE="on" style="width:400;font-size:12px;color:#FF9900;font-weight:bold;margin-bottom:25;"><%=msg%></div></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
</form>
<script type="text/javascript">
window.onload = getMsg;
window.onresize = resizeDiv;
window.onerror = function(){}
//短信提示使用(asilas添加)
var divTop,divLeft,divWidth,divHeight,docHeight,docWidth,objTimer;
function getMsg(){
	init();
	try{
		divTop = parseInt(document.getElementById("eMeng").style.top,10);
		divLeft = parseInt(document.getElementById("eMeng").style.left,10);
		divHeight = parseInt(document.getElementById("eMeng").offsetHeight,10);
		divWidth = parseInt(document.getElementById("eMeng").offsetWidth,10);
		docWidth = document.body.clientWidth;
		docHeight = document.body.clientHeight;
		document.getElementById("eMeng").style.visibility="visible";
		objTimer = window.setInterval("moveDiv()",10);
	}
	catch(e){}
}
function resizeDiv(){
	try{
		divHeight = parseInt(document.getElementById("eMeng").offsetHeight,10);
		divWidth = parseInt(document.getElementById("eMeng").offsetWidth,10);
		docWidth = document.body.clientWidth;
		docHeight = document.body.clientHeight;
		document.getElementById("eMeng").style.top = docHeight - divHeight + parseInt(document.body.scrollTop,10);
		document.getElementById("eMeng").style.left = docWidth - divWidth + parseInt(document.body.scrollLeft,10);
		setTimeout("closeDiv()",60000);
	}
	catch(e){}
}
function moveDiv(){
	try{
		if(parseInt(document.getElementById("eMeng").style.top,10) <= (docHeight - divHeight + parseInt(document.body.scrollTop,10))){
			window.clearInterval(objTimer);
			objTimer = window.setInterval("resizeDiv()",10);
		}
		divTop = parseInt(document.getElementById("eMeng").style.top,10);
		document.getElementById("eMeng").style.top = divTop - 4;
	}
	catch(e){
	}
}

function closeDiv(){
	document.getElementById('eMeng').style.visibility='hidden';
	if(objTimer) window.clearInterval(objTimer);
}
</script>
</body>
</html>