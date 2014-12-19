<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils" %>
<html>
<head>
<title>社区管理</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="committeeMerge.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript">
	var organId='<%=request.getParameter("organId")%>';
	var organName=decodeURIComponent('<%=request.getParameter("organName")%>');
</script>
</head>
<body>
<model:datasets>
	<model:dataset id="comExtUserDs" cmd="com.inspur.cams.comm.extuser.cmd.ComExtUserQueryCmd" pageSize="10">
		<model:record fromBean="com.inspur.cams.comm.extuser.data.ComExtUser"></model:record>
	</model:dataset>
	<model:dataset id="cdcOrganChangeDs" cmd="com.inspur.cams.cdc.base.cmd.CdcOrganChangeQueryCmd" pageSize="200">
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcOrganChange"></model:record>
	</model:dataset>
</model:datasets>
<next:Panel width="98%" autoHeight="true">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="save" text="保存" handler="save"></next:ToolBarItem>
	</next:TopBar>
	<next:Html>
		<form id="form1" method="post" dataset="comExtUserDs" onsubmit="return false" class="L5form">
			<fieldset>
				<legend>合并社区信息</legend>
				<table width="100%">
					<tr>
						<td class="FieldLabel">所属街道/乡镇：</td>
						<td class="FieldInput" colspan="3"><label name="organName" id="organName" field="organName"/></td>
					</tr>
					<tr>
						<td class="FieldLabel" style="width:16%">社区行政区划：</td>
						<td class="FieldInput" style="width:30%"><input type="text" name="userId" id="userId" field="userId" maxlength="12" style="width:90%"/><font color="red">*</font></td>
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
					<tr>
						<td class="FieldLabel">通信地址：</td>
						<td class="FieldInput" colspan="3"><input type="text" name="adds" id="adds" field="adds" maxlength="250" style="width:90%"/></td>
					</tr>
					<tr>
						<td class="FieldLabel">联系电话：</td>
						<td class="FieldInput"><input type="text" name="phone" id="phone" field="phone" maxlength="30" style="width:90%"/></td>
						<td class="FieldLabel">电子邮箱：</td>
						<td class="FieldInput"><input type="text" name="email" id="email" field="email" maxlength="50" style="width:90%"/></td>
					</tr>
				</table>
			</fieldset>
			<fieldset>
				<legend>社区用户信息</legend>
				<table width="100%">
					<tr>
						<td class="FieldLabel" style="width:16%">登录密码：</td>
						<td class="FieldInput" style="width:30%"><input type="password" name="pwd" id="pwd" field="pwd" style="width:90%"/><font color="red">*</font></td>
						<td class="FieldLabel" style="width:18%">确认密码：</td>
						<td class="FieldInput" style="width:36%"><input type="password" name="repwd" id="repwd" style="width:90%"/><font color="red">*</font></td>
					</tr>
					<tr>
						<td class="FieldLabel">账户状态：</td>
						<td class="FieldInput" colspan="3">
							<select name="accountStatus" id="accountStatus" field="accountStatus">
								<option value="1">有效</option>
								<option value="0">无效</option>
							</select>
						</td>
					</tr>
				</table>
			</fieldset>
		</form>
	</next:Html>
</next:Panel>
<next:EditGridPanel id="grid" dataset="cdcOrganChangeDs" width="98%" stripeRows="true" height="500" hasSum="true">
	<next:TopBar>
		<next:ToolBarItem symbol="合并社区列表"/>
		<next:ToolBarItem symbol="->"/>
		<next:ToolBarItem iconCls="add" text="增加" handler="addOrgan"/>
		<next:ToolBarItem iconCls="delete" text="删除" handler="deleteOrgan"/>
	</next:TopBar>
	<next:Columns>
		<next:CheckBoxColumn/>
		<next:Column id="areaCode" header="社区行政区划" field="areaCode" width="150"/>
		<next:Column id="areaName" header="社区名称" field="areaName" width="300"/>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="cdcOrganChangeDs"/>
	</next:BottomBar>
</next:EditGridPanel>
</body>
</html>