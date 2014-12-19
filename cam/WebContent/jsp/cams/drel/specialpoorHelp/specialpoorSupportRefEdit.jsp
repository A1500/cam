<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<html>
<head>
<title>帮扶关系表编辑</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="specialpoorSupportRef.js"></script>
<script type="text/javascript"
	src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript">
	var method='<%=request.getParameter("method")%>';
	var supportUnitCode='<%=request.getParameter("supportUnitCode")%>';
</script>
</head>
<body>
<model:datasets>
	<!--帮扶单位-->
	<model:dataset id="specialpoorSupportUnitDataSet"
		cmd="com.inspur.cams.drel.special.cmd.SpecialpoorSupportUnitQueryCmd"
		pageSize="-1">
		<model:record
			fromBean="com.inspur.cams.drel.special.data.SpecialpoorSupportUnit" />
	</model:dataset>
	<!--帮扶关系-->
	<model:dataset id="specialpoorSupportRefDataSet"
		cmd="com.inspur.cams.drel.special.cmd.SpecialpoorSupportRefQueryCmd"
		pageSize="-1" method="querySpecialpoorHelpVillage">
		<model:record
			fromBean="com.inspur.cams.drel.special.data.SpecialpoorSupportRef" />
	</model:dataset>
	<!-- 是否 -->
	<model:dataset id="commYesOrNoDS" enumName="COMM.YESORNO"
		autoLoad="true" global="true">
	</model:dataset>
</model:datasets>

<next:Panel width="100%" autoScroll="true">
	<next:TopBar>
		<next:ToolBarItem symbol="->" />
		<next:ToolBarItem iconCls="return" text="返回" handler="returnBack" />
	</next:TopBar>
	<next:Html>
		<form id="form1" method="post" dataset="specialpoorSupportUnitDataSet"
			onsubmit="return false" class="L5form">
		<fieldset><legend>特殊困难帮扶单位信息表</legend>
		<table width="100%">
			<tr>
				<td class="FieldLabel" style="width: 18%">帮扶单位代码：</td>
				<td class="FieldInput" style="width: 36%"><label
					field="supportUnitCode" /></td>
				<td class="FieldLabel" style="width: 18%">单位类型代码：</td>
				<td class="FieldInput" style="width: 36%"><label
					field="supportUnitTypeCode" /></td>
			</tr>
			<tr>
				<td class="FieldLabel" style="width: 18%">单位类型名称：</td>
				<td class="FieldInput" style="width: 36%"><label
					field="supportUnitTypeName" /></td>
				<td class="FieldLabel" style="width: 18%">顺序号：</td>
				<td class="FieldInput" style="width: 36%"><label
					field="supportUnitSn" /></td>
			</tr>
			<tr>
				<td class="FieldLabel" style="width: 18%">帮扶单位名称：</td>
				<td class="FieldInput" style="width: 36%"><label
					field="supportUnitName" /></td>
				<td class="FieldLabel" style="width: 18%">帮扶区县代码：</td>
				<td class="FieldInput" style="width: 36%"><label
					field="supportCountyCode" /></td>
			</tr>
			<tr>
				<td class="FieldLabel" style="width: 18%">帮扶区县名称：</td>
				<td class="FieldInput" style="width: 36%"><label
					field="supportCountyName" /></td>
				<td class="FieldLabel" style="width: 18%">帮扶镇级代码：</td>
				<td class="FieldInput" style="width: 36%"><label
					field="supportTownCode" /></td>
			</tr>
			<tr>
				<td class="FieldLabel" style="width: 18%">帮扶镇级名称：</td>
				<td class="FieldInput" style="width: 36%"><label
					field="supportTownName" /></td>
				<td class="FieldLabel" style="width: 18%">帮扶村代码：</td>
				<td class="FieldInput" style="width: 36%"><label
					field="supportVillageCode" /></td>
			</tr>
			<tr>
				<td class="FieldLabel" style="width: 18%">帮扶村名称：</td>
				<td class="FieldInput" style="width: 36%" colspan="3"><label
					field="supportVillageName" /></td>
			</tr>
		</table>
		</fieldset>
		</form>
	</next:Html>
</next:Panel>

<next:EditGridPanel id="grid" dataset="specialpoorSupportRefDataSet"
	width="100%" stripeRows="true" height="99.9%">
	<next:TopBar>
		<next:ToolBarItem iconCls="add" text="增加" handler="insert"></next:ToolBarItem>
		<next:ToolBarItem iconCls="delete" text="删除" handler="del"></next:ToolBarItem>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn></next:RowNumberColumn>
		<next:RadioBoxColumn></next:RadioBoxColumn>
		<next:Column field="RECORD_ID" header="代码" width="135"
			sortable="false" hidden="true"/>
		<next:Column field="HELP_VILLAGE_CODE" header="帮包村代码" width="135"
			sortable="false" />
		<next:Column field="HELP_VILLAGE_NAME" header="帮包村名称" width="220"
			sortable="false" />
		<next:Column field="HELP_VILLAGE_FLAG" header="是否有效" width="80"
			sortable="false" dataset="commYesOrNoDS" hidden="true"/>
	</next:Columns>
</next:EditGridPanel>
</body>
</html>