<%@ page isErrorPage="true" %>
<%@page import="org.loushang.next.web.ErrorResponse"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<html>
<head><title>出现异常信息</title>
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
<body topmargin="0" leftmargin="0" rightmargin="0" bgcolor="#DCE5F0">
<form>
<table border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse" width="100%">
	<tr><td width="100%" height="30">&nbsp;</td></tr>
	<tr><td width="100%">
	<table border="0" style="border-collapse: collapse" bordercolor="#DCE5F0" width="100%">
		<tr height="22" bgcolor=#7EA5D6 onclick="javascript:showMessage();">
		<td bgcolor=#7EA5D6 align="left" valign="top" width=10%>
		<FONT COLOR="#CC3333">操作失败</FONT>
		</td>
		<td bgcolor=#7EA5D6 align="left" valign="top" width=85%>
		<%
		    Object result = request.getAttribute("javax.servlet.error.exception_type");
			if(!(result instanceof Throwable)){
				out.print(result);				
			}
		%>
		</td>
		<td bgcolor=#7EA5D6 align="right" valign="top">
		<button name="B1" onclick="javascript:window.history.go(-1)">返回</button>
		</td>
	</table>
	</td></tr>
	<tr><td id="MESSAGE" style="display:none"><textarea style=" color:gray;overflow:auto;height:200px;width:100%" readonly>
	<%
	if(result instanceof Throwable){
		Throwable t=(Throwable)result;
		t.printStackTrace(new java.io.PrintWriter(out));
		if (t.getCause() != null) {
			t.getCause().printStackTrace(new java.io.PrintWriter(out));
		}
	}	
	%>
	</textarea>
</tr>
	<tr><td width="100%" height="30">&nbsp;</td></tr>
</table>
</form>
</body>
</html>
<script language="javascript">
	if(window.history.length==0){
		document.all("B1").innerText='关闭';
		document.all("B1").onclick=winclose;
	}
	function winclose(){
		parent.close();
	}
</script>