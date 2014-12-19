<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%
	String j_auth_action=request.getContextPath()+"/camsext?loginType=somsd";
	String msg=(String)request.getSession().getAttribute("error_info");
	if(msg==null)msg="";
%>
<html>
<head>
<title>民间组织网上年检管理信息系统</title>
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
		alert("用户名为空，请输入!");
		userId.focus();
		return false;
	}
	userId.value = userId.value.toUpperCase();
	var pwd = document.forms[0].pwd;
	if(pwd.value==""){
		alert("密码为空，请输入!");
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
<form name="frmLogin" method="post" action="" Accept-Charset="utf-8">
<table width="100%" height="100%" cellpadding="0" cellspacing="0">
	<tr>
		<td align="center">
			<table width="570" height="355" cellpadding="0" cellspacing="0" background="images/login.png">
				<tr>
					<td style="padding-left:120px;padding-top:120px;">
						<table width="100%" cellpadding="0" cellspacing="2" class="bd" >
							<tr>
								<td width="255" align="right"><b>用户名:             </td>
								<td><input type="text" name="userId" value="superadmin" class="textfield" size="20"/></td>
							</tr>
							<tr>
								<td width="255" align="right"><b>密&nbsp;&nbsp;码:             </td>
								<td><input type="password" name="pwd" value="1" class="textfield" size="20"/></td>
							</tr>
							<tr>
								<td align="right"></td>
								<td>
									<table width="100%" cellspacing="0" cellpadding="0">
										<tr>
											<td width="90"><IMG style="cursor:hand;" src="images/dl.png"  border="0" onclick="doLogin();"></td>
											<td><IMG style="cursor:hand;" src="images/qx.png"  border="0" onclick="document.forms[0].reset();"></td>
	              						</tr>
	              						<tr>
											<td height="23" align="left" colspan=2><a href='userGuard.doc' target="_blank">下载 网上填报使用说明</a></td>
										</tr>
	            					</table>
								</td>
							</tr>
							<tr>
								<td height="43" align="center" colspan=2><div UNSELECTABLE="on" style="width:400;font-size:12px;color:#FF9900;font-weight:bold;margin-bottom:25;"><%=msg%></div></td>
							</tr>							
						</table>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
</form>
</body>
</html>