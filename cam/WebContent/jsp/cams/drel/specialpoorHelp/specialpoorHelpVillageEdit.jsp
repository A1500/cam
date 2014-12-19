<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<html>
<head>
<title>帮包村信息表编辑</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="specialpoorHelpVillage.js"></script>
<script type="text/javascript"
	src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript">
	var method='<%=request.getParameter("method")%>';
	var helpVillageCode='<%=request.getParameter("helpVillageCode")%>';
</script>
</head>
<body>
<model:datasets>
	<model:dataset id="specialpoorHelpVillageDataSet"
		cmd="com.inspur.cams.drel.special.cmd.SpecialpoorHelpVillageQueryCmd"
		pageAble="-1">
		<model:record
			fromBean="com.inspur.cams.drel.special.data.SpecialpoorHelpVillage">
			<model:field name="helpVillageCode" type="string" rule="require"></model:field>
			<model:field name="helpVillageName" type="string" rule="require"></model:field>
			<model:field name="helpVillageFlag" type="string" rule="require"></model:field>
		</model:record>
	</model:dataset>

	<!-- 是否 -->
	<model:dataset id="commYesOrNoDS" enumName="COMM.YESORNO"
		autoLoad="true" global="true">
	</model:dataset>
</model:datasets>
<next:Panel width="100%" autoScroll="true">
	<next:TopBar>
		<next:ToolBarItem symbol="->" />
		<next:ToolBarItem iconCls="save" text="保存" handler="save" />
		<next:ToolBarItem iconCls="return" text="返回" handler="returnBack" />
	</next:TopBar>
	<next:Html>
		<form id="form1" method="post" dataset="specialpoorHelpVillageDataSet"
			onsubmit="return false" class="L5form">
		<fieldset><legend>帮包村信息表</legend>
		<table width="100%">
			<tr>
				<td class="FieldLabel" style="width: 18%">帮包村代码：</td>
				<td class="FieldInput" style="width: 36%"><input type="text"
					name="帮包村代码" id="helpVillageCode" field="helpVillageCode"
					maxlength="50" style="width: 90%"/><font color="red">*</font></td>
			</tr>
			<tr>
				<td class="FieldLabel" style="width: 18%">帮包村名称：</td>
				<td class="FieldInput" style="width: 36%"><input type="text"
					name="帮包村名称" id="helpVillageName" field="helpVillageName"
					maxlength="50" style="width: 90%" /><font color="red">*</font></td>
			</tr>
			<tr>
				<td class="FieldLabel" style="width: 18%">是否有效：</td>
				<td class="FieldInput" style="width: 36%"><select name="是否有效"
					id="helpVillageFlag" style="width: 68%;" field="helpVillageFlag">
					<option dataset="commYesOrNoDS"></option>
				</select><font color="red">*</font></td>
			</tr>
		</table>
		</fieldset>
		</form>
	</next:Html>
</next:Panel>
</body>
</html>