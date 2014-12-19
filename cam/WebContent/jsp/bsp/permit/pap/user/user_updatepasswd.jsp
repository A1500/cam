<%@page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils" %>
<%@ include file="/jsp/public/resources_jspdir.jsp" %>
<html>
<head>

<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="user_updatepasswd.js"></script>
</head>

<body>

<next:Panel name="form" width="100%"   autoHeight="true"  collapsible="true">
<next:TopBar>
	<next:ToolBarItem symbol="->" ></next:ToolBarItem>
    <next:ToolBarItem iconCls="save" id="saveBtn"  text='<%=res.get("LABEL_MODEFY_PASSWD")%>' handler="updatepwd"/>
</next:TopBar>
	<next:Html>
		<div>
		<form   method="post" action="" class="L5form" id="passwdForm">
			<table border="0"  width="100%" >
				<tr>
				<td  class="FieldLabel" style="width:10%"><%=res.get("LABEL_OLD_PASSWD")%></td>
				<td class="FieldInput" style="width:35%">
				<input type="password" id="oldPasswd" name="oldPasswd" onchange="check_user()" /><font id="functionHint" color="red">*</font>
				</td>
				</tr>
				<tr>
				<td  class="FieldLabel" style="width:10%"><%=res.get("LABEL_NEW_PASSWD")%></td>
				<td class="FieldInput" style="width:35%">
				<input type="password" id="newPasswd" name="newPasswd" onchange="check_newpwd()" /><font id="functionHint1" color="red">*</font>
				</td>
				</tr>
				<tr>
				<td  class="FieldLabel" style="width:10%"><%=res.get("LABEL_NEW_PASSWD2")%></td>
				<td class="FieldInput" style="width:35%">
				<input type="password" id="newPasswd2" name="newPasswd2" onchange="check_newpwd2()" /><font id="functionHint2" color="red">*</font>
				</td>
				</tr>
				</table>
			</form>
		</div>
	</next:Html>
</next:Panel>

</body>
</html>