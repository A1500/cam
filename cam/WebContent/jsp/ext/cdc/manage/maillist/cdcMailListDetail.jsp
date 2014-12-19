<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<title>基层政权与社区建设通讯录</title>
<next:ScriptManager/>
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
	<next:ToolBarItem iconCls="return" text="返回" handler="returnBack"/>
</next:TopBar>
<next:Html>
<form id="form1" method="post" dataset="cdcMailListDataSet" onsubmit="return false" class="L5form">
<fieldset>
<legend>人员信息</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel" style="width:18%">姓名：</td>
			<td class="FieldInput" style="width:36%"><label field="name"/></td>
			<td class="FieldLabel" style="width:16%">性别：</td>
			<td class="FieldInput" style="width:30%"><label field="sex" dataset="sexDataSet"/></td>
		</tr>
		<tr>
			<td class="FieldLabel">单位：</td>
			<td class="FieldInput"><label field="organ"/></td>
			<td class="FieldLabel">部门：</td>
			<td class="FieldInput"><label field="dept"/></td>
		</tr>
		<tr>
			<td class="FieldLabel">职务：</td>
			<td class="FieldInput"><label field="duty"/></td>
			<td class="FieldLabel">分工：</td>
			<td class="FieldInput"><label field="workContent"/></td>
		</tr>
		<tr>
			<td class="FieldLabel">办公电话：</td>
			<td class="FieldInput"><label field="phone"/></td>
			<td class="FieldLabel">传真：</td>
			<td class="FieldInput"><label field="fax"/></td>
		</tr>
		<tr>
			<td class="FieldLabel">手机：</td>
			<td class="FieldInput"><label field="moblePhone"/></td>
			<td class="FieldLabel">电子邮箱：</td>
			<td class="FieldInput"><label field="email"/></td>
		</tr>
		<tr>
			<td class="FieldLabel">通讯地址：</td>
			<td class="FieldInput"><label field="postAdds"/></td>
			<td class="FieldLabel">邮政编码：</td>
			<td class="FieldInput"><label field="postCode"/></td>
		</tr>
	</table>
</fieldset>
</form>
</next:Html>
</next:Panel>
</body>
</html>
<script language="javascript">
function init(){
	var ds=L5.DatasetMgr.lookup("cdcMailListDataSet");
	ds.setParameter("LIST_ID@=",'<%=request.getParameter("listId")%>');
	ds.load();
}
function returnBack(){
	history.go(-1);
}
</script>