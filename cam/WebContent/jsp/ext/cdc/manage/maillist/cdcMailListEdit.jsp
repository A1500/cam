<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<html>
<head>
<title>基层政权与社区建设通讯录</title>
<next:ScriptManager/>
<script type="text/javascript" src="cdcMailListEdit.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript">
	var method='<%=request.getParameter("method")%>';
	var listId='<%=request.getParameter("listId")%>';
</script>
<jsp:include page="../util/cdcOrgan.jsp" flush="true"/>
</head>
<body>
<model:datasets>
	<model:dataset id="cdcMailListDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcMailListQueryCmd" pageSize="20">
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcMailList"/>
	</model:dataset>
	<model:dataset id="sexDataSet" enumName="COMM.SEX" autoLoad="true" global="true"/>
</model:datasets>
<next:Panel width="100%" autoScroll="true">
<next:TopBar>
	<next:ToolBarItem symbol="->"/>
	<next:ToolBarItem iconCls="save" text="保存" handler="save"/>
	<next:ToolBarItem iconCls="return" text="返回" handler="returnBack"/>
</next:TopBar>
<next:Html>
<form id="form1" method="post" dataset="cdcMailListDataSet" onsubmit="return false" class="L5form">
<fieldset>
<legend>人员信息</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel" style="width:18%">姓名：</td>
			<td class="FieldInput" style="width:36%"><input type="text" id="name" field="name" maxlength="72" style="width:50%"/><font color="red">*</font></td>
			<td class="FieldLabel" style="width:16%">性别：</td>
			<td class="FieldInput" style="width:30%"><select id="sex" field="sex"><option dataset="sexDataSet"/></select></td>
		</tr>
		<tr>
			<td class="FieldLabel">单位：</td>
			<td class="FieldInput"><input type="text" id="organ" field="organ" maxlength="100" style="width:90%"/><font color="red">*</font></td>
			<td class="FieldLabel">部门：</td>
			<td class="FieldInput"><input type="text" id="dept" field="dept" maxlength="100" style="width:90%"/><font color="red">*</font></td>
		</tr>
		<tr>
			<td class="FieldLabel">职务：</td>
			<td class="FieldInput"><input type="text" id="duty" field="duty" maxlength="30" style="width:90%"/></td>
			<td class="FieldLabel">分工：</td>
			<td class="FieldInput"><input type="text" id="workContent" field="workContent" maxlength="500" style="width:90%"/></td>
		</tr>
		<tr>
			<td class="FieldLabel">办公电话：</td>
			<td class="FieldInput"><input type="text" id="phone" field="phone" maxlength="30" style="width:50%"/><font color="red">*</font></td>
			<td class="FieldLabel">传真：</td>
			<td class="FieldInput"><input type="text" id="fax" field="fax" maxlength="30" style="width:50%"/></td>
		</tr>
		<tr>
			<td class="FieldLabel">手机：</td>
			<td class="FieldInput"><input type="text" id="moblePhone" field="moblePhone" maxlength="50" style="width:50%"/></td>
			<td class="FieldLabel">邮政编码：</td>
			<td class="FieldInput"><input type="text" id="postCode" field="postCode" maxlength="200" style="width:50%"/></td>
		</tr>
		<tr>
			<td class="FieldLabel">通讯地址：</td>
			<td class="FieldInput"><input type="text" id="postAdds" field="postAdds" maxlength="30" style="width:90%"/><font color="red">*</font></td>
			<td class="FieldLabel">电子邮箱：</td>
			<td class="FieldInput"><input type="text" id="email" field="email" maxlength="30" style="width:90%"/></td>
			
		</tr>
	</table>
</fieldset>
</form>
</next:Html>
</next:Panel>
</body>
</html>