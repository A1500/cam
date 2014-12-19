<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ page import="com.inspur.cams.comm.soo.util.SooUtil" %>
<%
	String path="http://10.60.0.39:6888";
	//String path="http://10.60.0.39:6888/saas/j_security_check?j_username=shandong&j_password=96318e2a633d47f342a7e17d60ffae67";
	//response.sendRedirect(path);
%>
<html>
<head>
<title>全国最低生活保障信息系统</title>
<link rel="stylesheet" type="text/css" href="http://10.60.0.39:6888/saas/css/framework/default/t1-all.css" />
<link type="text/css" href="http://10.60.0.39:6888/saas/css/framework/default/login.css" rel="stylesheet" />
<script language="javascript">
function onLogin() {
  	document.logonInfoForm.submit();  
}
function refreshImg(){
	var randomnum = Math.random(); 
	var imgObj = document.getElementById("captchaImg");
	imgObj.src="http://10.60.0.39:6888/saas/captchaServlet?randomnum="+randomnum;
}
/**
 * 重置用户名密码
 */
function resetForm(){
  	document.logonInfoForm.reset();
}
function changeImageover(){
	var img = document.getElementById("causer");
   	img.src = path+"/images/framework/default/login/causer2.gif";
}
function changeImageout(){
	var img = document.getElementById("causer");
	img.src = path+"/images/framework/default/login/causer1.gif";
}
</script>
</head>
<body id="bodyId">
<div id="height">
<form name="logonInfoForm" action="http://10.60.0.39:6888/saas/j_security_check" method="post">
<input type=hidden name=j_logontype id=j_logontype value="explorer">
	<table height="100%" border="0" align="center" cellspacing="0">
		<tr>
			<td width="400" align="left" valign="top">
				<table id="tableheight" width="60%" height="28%" border="0" cellspacing="0">
					<tr>
						<td></td>
					</tr>
				</table>
				<br />
				<br />
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td colspan="3" height="50" valign="top">
							<table width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td width="80" align="right">
										<img src="<%=path%>/saas/images/framework/default/login/iconInfo.gif">&nbsp;&nbsp;
									</td>
									<td id="tipInfo">
										<img src="<%=path%>/saas/images/framework/default/login/tipInfo.gif">
									</td>
								</tr>
							</table>
						</td>
					</tr>
					<tr>
						<td class="titleUser"></td>
						<td colspan=2>
							<div id="usernameDiv" class="x-form-element">
								<input type="hidden" id="j_username" name="j_username" value="<%=SooUtil.getSooUserName("saas") %>">
							</div>
						</td>
					</tr>
					<tr>
						<td class="titlePsw"></td>
						<td colspan=2>
							<div id="passwordDiv" class="x-form-element">
								<input type="hidden" id="j_password" name="j_password" value="<%=SooUtil.md5(SooUtil.getSooUserName("saas")) %>">
							</div>
						</td>
					</tr>
					<tr>
						<td class="titleCaptcha"></td>
						<td width="80">
							<div id="captchaDiv" class="x-form-element">
								<input type="text" id="j_captcha" name="j_captcha" value="">
							</div>
						</td>
						<td align="left">
							<a href="#"><img id="captchaImg"
									src="http://10.60.0.39:6888/saas/captchaServlet" style="cursor: hand"
									title="看不清，点击图片换一张" onclick="refreshImg()">
							</a>
						</td>
					</tr>
					<tr>
						<td height="80" colspan="3" align="center">
							<table border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td width="20"></td>
									<td class="btnLoad">
										<a href="#" style="cursor: pointer" onclick="onLogin();"><img
												src="<%=path%>/saas/images/framework/default/s.gif"  />
										</a>
									</td>
									<td width="30"></td>
									<td class="btnCancel">
										<a href="#" style="cursor: pointer" onclick="resetForm();"><img
												src="<%=path%>/saas/images/framework/default/s.gif"  />
										</a>
									</td>
									<td width="40"></td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
</form>
</div>
</body>
</html>