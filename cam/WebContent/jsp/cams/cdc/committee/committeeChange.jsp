<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils" %>
<html>
<head>
<title>社区管理</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="committeeChange.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript">
	var userId='<%=request.getParameter("userId")%>';
</script>
</head>
<body>
<model:datasets>
	<model:dataset id="comExtUserDs" cmd="com.inspur.cams.comm.extuser.cmd.ComExtUserQueryCmd" pageSize="10">
		<model:record fromBean="com.inspur.cams.comm.extuser.data.ComExtUser"></model:record>
	</model:dataset>
</model:datasets>
<next:Panel width="100%" autoHeight="true">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="save" text="保存" handler="save"></next:ToolBarItem>
	</next:TopBar>
	<next:Html>
		<form id="form1" method="post" dataset="comExtUserDs" onsubmit="return false" class="L5form">
			<fieldset>
				<legend>变更社区信息</legend>
				<table width="100%">
					<tr>
						<td class="FieldLabel">所属街道/乡镇：</td>
						<td class="FieldInput" colspan="3"><label name="organName" id="organName" field="organName"/></td>
					</tr>
					<tr>
						<td class="FieldLabel" style="width:16%">社区行政区划：</td>
						<td class="FieldInput" style="width:30%"><label name="userId" id="userId" field="userId"/></td>
						<td class="FieldLabel" style="width:18%">社区名称：</td>
						<td class="FieldInput" style="width:36%"><input type="text" name="userName" id="userName" field="userName" style="width:90%"/><font color="red">*</font></td>
					</tr>
					<tr>
						<td class="FieldLabel">社区类型：</td>
						<td class="FieldInput">
							<input type="radio" id="communityTypeC" name="communityType" field="communityType" onclick="communityTypeChange(this)" value="C"/>城市社区
							<input type="radio" id="communityTypeN" name="communityType" field="communityType" onclick="communityTypeChange(this)" value="N"/>农村社区<font color="red">*</font>
						</td>
						<td class="FieldLabel">是否自然村：</td>
						<td class="FieldInput">
							<input type="radio" id="ifVillageN" name="ifVillage" field="ifVillage" value="0"/>否
							<input type="radio" id="ifVillageY" name="ifVillage" field="ifVillage" value="1"/>是<font color="red">*</font>
						</td>
					</tr>
				</table>
			</fieldset>
		</form>
	</next:Html>
</next:Panel>
</body>
</html>