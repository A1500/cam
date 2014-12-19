<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils" %>
<html>
<head>
<title>社区用户管理</title>
<next:ScriptManager></next:ScriptManager>
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
	<model:dataset id="comExtOrganTypeDs" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value="COM_EXT_ORGAN_TYPE"></model:param>
			<model:param name="value" value="CODE"></model:param>
			<model:param name="text" value="NAME"></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="organTypeDataSet" enumName="CDC.ORGAN_TYPE" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="communityTypeDataSet" enumName="CDC.COMMUNITY_TYPE" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="yesornoDataSet" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
</model:datasets>
<next:Panel width="100%" autoHeight="true">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
	</next:TopBar>
	<next:Html>
		<form id="form1" method="post" dataset="comExtUserDs" onsubmit="return false" class="L5form">
			<fieldset>
				<legend>社区用户管理</legend>
				<table width="100%">
					<tr>
						<td class="FieldLabel">所属街道/乡镇：</td>
						<td class="FieldInput" colspan="3"><label field="organName"/></td>
					</tr>
					<tr>
						<td class="FieldLabel" style="width:16%">社区行政区划：</td>
						<td class="FieldInput" style="width:30%"><label field="userId"/></td>
						<td class="FieldLabel" style="width:18%">社区名称：</td>
						<td class="FieldInput" style="width:36%"><label field="userName"/></td>
					</tr>
					<tr>
						<td class="FieldLabel">社区类型：</td>
						<td class="FieldInput"><label field="communityType" dataset="communityTypeDataSet"/></td>
						<td class="FieldLabel">是否自然村：</td>
						<td class="FieldInput"><label field="ifVillage" dataset="yesornoDataSet"/></td>
					</tr>
					<tr>
						<td class="FieldLabel">通信地址：</td>
						<td class="FieldInput" colspan="3"><label field="adds"/></td>
					</tr>
					<tr>
						<td class="FieldLabel">联系电话：</td>
						<td class="FieldInput"><label field="phone"/></td>
						<td class="FieldLabel">电子邮箱：</td>
						<td class="FieldInput"><label field="email"/></td>
					</tr>
					<tr>
						<td class="FieldLabel">账户状态：</td>
						<td class="FieldInput" colspan="3">
							<select name="accountStatus" id="accountStatus" field="accountStatus" disabled="true">
								<option value="1">有效</option>
								<option value="0">无效</option>
							</select>
						</td>
					</tr>
					<input type="hidden" name="organId" id="organId" field="organId"/>
				</table>
			</fieldset>
		</form>
	</next:Html>
</next:Panel>
</body>
</html>
<script language="javascript">
function init(){
	var ds=L5.DatasetMgr.lookup("comExtUserDs");
	ds.setParameter("USER_ID@=", userId);
	ds.load();
}
</script>