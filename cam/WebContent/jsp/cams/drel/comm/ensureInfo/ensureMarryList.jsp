<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<html>
<head>
<title>婚姻核查信息列表</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="ensureMarryList.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
</head>
<body>
<model:datasets>
	<model:dataset id="ensureToClientDataSet" cmd="com.inspur.cams.drel.ensureInfo.cmd.EnsureToClientQueryCmd" global="true"  method="queryMarryInfo" pageSize="20">
	</model:dataset>
	<!-- 性别 -->
	<model:dataset id="sex" enumName="COMM.SEX"
		autoLoad="true" global="true"></model:dataset>
		
	<!-- 婚姻状态 -->
	<model:dataset id="marryStatus" enumName="ENSURE.MARRY_STATUS"
		autoLoad="true" global="true"></model:dataset>
</model:datasets>
<next:Panel width="100%" border="0">
	<next:Html>
	<fieldset style="overflow:visible;" class="GroupBox">
	<legend class="GroupBoxTitle">查询条件</legend>
		<form class="L5form">
			<table border="1" width="100%">
				<tr>
					<td class="FieldLabel" style="width:18%">户主姓名：</td>
					<td class="FieldInput" style="width:18%"><input id="familyName"/></td>
					<td class="FieldLabel" style="width:18%">是否有配偶：</td>
					<td class="FieldInput" style="width:18%"><select id="isMarry">
						<option >请选择...</option>
						<option value = '1'>是</option>
						<option value = '0'>否</option>
					</select></td>
					<td class="FieldButton" style="width:20%">
					<button onclick="query()">查询</button>&nbsp;&nbsp;&nbsp;&nbsp;<button type="reset">重置</button></td>
				</tr>
			</table>
		</form>
	</fieldset>
	</next:Html>
</next:Panel>
<next:EditGridPanel id="grid" dataset="ensureToClientDataSet" width="100%" stripeRows="true" height="99.9%">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="export"  text="明细" />
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn></next:RowNumberColumn>
		<next:RadioBoxColumn></next:RadioBoxColumn>
		<next:Column field="FAMILY_NAME" header="户主姓名" width="10%" sortable="false"/>
		<next:Column field="SEX" header="户主性别" width="10%" dataset ='sex' sortable="false"/>
		<next:Column field="FAMILY_CARD_NO" header="户主身份证号" width="15%" sortable="false"/>
		<next:Column field="SPOUSE_NAME" header="配偶姓名"  width="10%" sortable="false"/>
		<next:Column field="SPOUSE_ID_CARD" header="配偶身份证号"  width="15%" sortable="false"/>
		<next:Column field="DEPT_NAME" header="登记单位" width="15%" sortable="false"/>
		<next:Column field="OP_TYPE" header="登记状态" width="10%" dataset="marryStatus" sortable="false"/>
		<next:Column field="REGISTER_DATE" header="登记时间" width="10%" sortable="false"/>
		<next:Column field="PRINT_REMARK" header="备注" width="20%" sortable="false"/>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="ensureToClientDataSet"/>
	</next:BottomBar>
</next:EditGridPanel>
</body>
</html>