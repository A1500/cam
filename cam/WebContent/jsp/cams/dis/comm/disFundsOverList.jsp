<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
<head>
<title>资金结转配置</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript">
	var organCode='<%=BspUtil.getOrganCode()%>';
	var organName='<%=BspUtil.getOrganName()%>';
	var organType='<%=BspUtil.getOrganType()%>';
</script>
<script type="text/javascript" src="disFundsOverList.js"></script>
<script type="text/javascript"
	src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
</head>
<body>
<model:datasets>
</model:datasets>

<next:Panel width="100%" title="资金结转配置">
	<next:TopBar>
		<next:ToolBarItem text="资金结转配置"></next:ToolBarItem>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="save" text="保存" handler="onSave"></next:ToolBarItem>
	</next:TopBar>
	<next:Html>
		<form method="post" onsubmit="return false" class="L5form" width="100%">
		<table border="0" width="100%">
			<tr>
				<td class="FieldLabel" width="15%">自动结转的过期时间:</td>
				<td class="FieldInput"><input type="text" name="过期时间"
					label="过期时间" title="过期时间" field="upAllocationNum"
					style="width: 60;text-align: right;" value="10" maxlength="2" />天
				</td>
			</tr>
			<tr>
				<td class="FieldButton" style="text-align: left" colspan="2">
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				注：当进入新的年份时，系统会自动提醒各级管理人员对剩余资金（上级下拨）进行年度结转，超过“过期时间”，系统自动进行年度结转！
				</td>
			</tr>
		</table>
		</form>
	</next:Html>
</next:Panel>
</body>
</html>