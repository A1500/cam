<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<html>
<head>
<%
	String path = "http://adopt.mca.gov.cn/adopt";
%>
<title>全国收养登记管理信息系统</title>
<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
	background-color: #1d86f1;
	background-image: url(<%=path%>/images/bg.jpg);
	background-repeat: repeat-x;
	background-position: top;
	font-family: "宋体";
	font-size: 12px;
}

.input {
	font-family: "宋体";
	font-size: 12px;
	color: #000000;
	background-color: #b9dcf7;
	height: 14px;
	border: 0px none #b9dcf7;
}

a.white-link:link {
	color: #ffffff;
	text-decoration: underline;
}

a.white-link:visited {
	color: #ffffff;
	text-decoration: underline;
}

a.white-link:hover {
	color: #f5cf5d;
	text-decoration: none;
}
-->
</style>
<script language="javascript">      
function checkLogin(){
    if (document.loginform.rcode.value == ""){
        alert("请输入验证码！");
        document.loginform.rcode.focus();
        return false;
    }else{
    	document.loginform.submit();
		return true;
	}
}  
</script>
</head>

<body onLoad="javascript:loginform.rcode.focus();">
<form name="loginform" method="post" action="<%=path%>/loginCheck.jsp"
	onsubmit="return checkLogin();"><input type="hidden"
	name="action" value="login">
<table width="1024" border="0" align="center" cellpadding="0"
	cellspacing="0">
	<tr>
		<td><img src="<%=path%>/images/login_01.jpg" width="1024"
			height="317" /></td>
	</tr>
</table>
<table width="1024" border="0" align="center" cellpadding="0"
	cellspacing="0">
	<tr>
		<td height="215" valign="top"
			background="<%=path%>/images/login_02.jpg">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td width="43%" height="46">&nbsp;</td>
				<td width="57%">&nbsp;</td>
			</tr>
			<tr>
				<td height="19">&nbsp;</td>
				<td><input name="username" type="text" class="input" size="26"
					value="370000" readonly="readonly" /></td>
			</tr>
			<tr>
				<td height="21">&nbsp;</td>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td><input name="password" type="password" class="input"
					size="26" value="14789632" readonly="readonly" /></td>
			</tr>
			<tr>
				<td height="17">&nbsp;</td>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td width="14%"><input name="rcode" maxlength="4" type="text"
							class="input" size="10" value="" /></td>
						<td width="86%">&nbsp; <a href="#1"
							onclick="javascript:document.checkImage.src=document.checkImage.src;">
						<img title="看不清，换一张!" src="<%=path%>/common/showimage.jsp"
							name="checkImage" id="checkImage" style="border: 0px;" /> </a></td>
					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td>
				<table>
					<tr>
						<td><input type="image" src="<%=path%>/images/login-but.jpg"
							width="87" height="32" onclick="return checkLogin()"></td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<table width="1024" border="0" align="center" cellpadding="0"
	cellspacing="0">
	<tr>
		<td><img src="<%=path%>/images/login_03.jpg" width="1024"
			height="81" /></td>
	</tr>
</table>
</form>
</body>
</html>
