<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<html>
<head>
<title>登录单位信息</title>
<next:ScriptManager/>
<script type="text/javascript" src="loginUserEdit.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript">
	var method='<%=request.getParameter("method")%>';
	var userId='<%=request.getParameter("userId")%>';
</script>
<jsp:include page="../util/cdcOrgan.jsp" flush="true"/>
</head>
<body>
<model:datasets>
	<model:dataset id="cdcComExtUserDataSet" cmd="com.inspur.cams.comm.extuser.cmd.ComExtUserQueryCmd" pageSize="20">
		<model:record fromBean="com.inspur.cams.comm.extuser.data.ComExtUser"/>
	</model:dataset>
	<model:dataset id="communityTypeDataSet" enumName="CDC.COMMUNITY_TYPE" autoLoad="true" global="true" />
	<model:dataset id="YorN" enumName="COMM.YESORNO" autoLoad="true" global="true" />
</model:datasets>
<next:Panel width="100%" autoScroll="true">
<next:TopBar>
	<next:ToolBarItem symbol="->"/>
	<next:ToolBarItem iconCls="save" text="保存" handler="save"/>
	<next:ToolBarItem iconCls="return" text="返回" handler="returnBack"/>
</next:TopBar>
<next:Html>
<form id="form1" method="post" dataset="cdcComExtUserDataSet" onsubmit="return false" class="L5form">
<fieldset>
<legend>登录单位信息</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel" style="width:18%">登录账号：</td>
			<td class="FieldInput" style="width:30%"><label field="userId"/></td>
			<td class="FieldLabel" style="width:18%">登录用户：</td>
			<td class="FieldInput" style="width:30%"><label field="userName" /></td>
		</tr>
		<tr>
			<td class="FieldLabel">办公电话：</td>
			<td class="FieldInput"><input type="text" field="phone" maxlength="100" style="width: 80%" /><font color="red">*</font></td>
			<td class="FieldLabel">电子邮箱：</td>
			<td class="FieldInput"><input type="text" field="email" maxlength="100" style="width: 80%" /><font color="red">*</font></td>
		</tr>
		<tr>
			<td class="FieldLabel">通讯地址：</td>
			<td class="FieldInput" colspan="3"><input type="text" field="adds" style="width: 62%" /><font color="red">*</font></td>
		</tr>
		<tr>
			<td class="FieldLabel">社区类型：</td>
			<td class="FieldInput"><select field="communityType"> <option dataset = "communityTypeDataSet" ></option> </select> <font color="red">*</font></td>
			<td class="FieldLabel">是否为自然村：</td>
			<td class="FieldInput"><select field="ifVillage"> <option dataset = "YorN" ></option> </select><font color="red">*</font></td>
		</tr>
	</table>
</fieldset>
</form>
</next:Html>
</next:Panel>
</body>
</html>