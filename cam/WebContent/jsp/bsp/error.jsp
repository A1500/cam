<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page isErrorPage="true" %>
<%@page import="org.loushang.bsp.security.exception.AccessDeniedException"%>
<%
    AccessDeniedException e=(AccessDeniedException)request.getAttribute("LOUSHANG_SECURITY_403_EXCEPTION");
%>
<html>
<head><title></title>
<script language="javascript">
function showMessage(){
	var message = document.getElementById("MESSAGE");
	if(message.style.display == "block")
		message.style.display = "none";
	else
		message.style.display = "block";
}
</script>
</head>
<style type="text/css">
	td{font-size:12pt}
	button{
	overflow:	hidden;
	text-align:	center;
	vertical-align:	middle;
	font-size: 9pt;
	cursor: hand;
	height: 20px;
	border: #6489B3 1px solid;
}
</style>
<body topmargin="0" leftmargin="0" rightmargin="0" bgcolor="#DFE8F6">
<form class="L5form">
<table border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse" width="100%">
	<tr><td width="100%" height="30">&nbsp;</td></tr>
	<tr><td width="100%">
	<table border="0" style="border-collapse: collapse" bordercolor="#DCE5F0" width="100%">
		<tr height="22" bgcolor=#7EA5D6>
		<td align="left" valign="top" width=15%>
		<b><FONT COLOR="#CC3333">系统访问权限提示：</FONT></b></td>
		<td  valign="top" width=85%>
		<%=e.getMessage()%>
		</td>

		<td  align="right" valign="top">
		<button name="B1"  onclick="window.history.go(-1)" id="getBack" title="返回" type="button">返回</button>
		</td>

	</table>
	</td></tr>
	<tr><td id="MESSAGE" style="display:none"><textarea style=" color:gray;overflow:auto;height:200px;width:100%" readonly>
	</textarea>
</tr>
	<tr><td width="100%" height="30">&nbsp;</td></tr>
</table>
</form>
</body>
</html>
<script language="javascript">
	if(window.history.length==0){
	   document.getElementByIdx("getback").innerText='关闭';
	   document.getElementByIdx("getback").onclick=winclose;
		//document.all("B1").innerText='关闭';
		//document.all("B1").onclick=winclose;

	}
	function winclose(){
		parent.close();
	}
</script>



