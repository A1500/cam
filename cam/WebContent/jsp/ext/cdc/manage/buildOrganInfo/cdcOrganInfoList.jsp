<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<html>
<head>
<title>基础信息社区共建单位信息列表</title>
<next:ScriptManager></next:ScriptManager>
<jsp:include page="../util/cdcOrgan.jsp" flush="true"/>
<script type="text/javascript" src="cdcOrganInfoList.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
</head>
<body>
<model:datasets>
	<model:dataset id="cdcOrganInfoDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcOrganInfoQueryCmd" pageSize="200">
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcOrganInfo"/>
	</model:dataset>
	<model:dataset id="organTypeDataSet" enumName="CDC.CORP_TYPE" autoLoad="true" global="true"/>
</model:datasets>
<next:Panel width="100%" border="0">
	<next:Html>
	<fieldset style="overflow:visible;" class="GroupBox">
	<legend class="GroupBoxTitle">查询条件</legend>
		<form class="L5form">
			<table border="1" width="100%">
				<tr>
					<td class="FieldLabel" style="width:10%">共建单位名称：</td>
					<td class="FieldInput" style="width:12%"><input type="text" id = "query_name" /></td>
					<td class="FieldLabel" style="width:10%">共建单位性质：</td>
					<td class="FieldInput" style="width:12%"><select type="text" id = "query_kind"> <option dataset = "organTypeDataSet"></option> </select> </td>
					<td class="FieldButton" style="width:20%"><button onclick="query()">查询</button>&nbsp;&nbsp;&nbsp;&nbsp;<button type="reset">重置</button></td>
				</tr>
			</table>
		</form>
	</fieldset>
	</next:Html>
</next:Panel>
<next:EditGridPanel id="grid" dataset="cdcOrganInfoDataSet" width="100%" stripeRows="true" height="99.9%" autoExpandColumn="organAdds">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="add" text="增加" handler="insert"></next:ToolBarItem>
		<next:ToolBarItem iconCls="edit" text="修改" handler="update"></next:ToolBarItem>
		<next:ToolBarItem iconCls="detail" text="明细" handler="detail"></next:ToolBarItem>
		<next:ToolBarItem iconCls="delete" text="删除" handler="del"></next:ToolBarItem>
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn></next:RowNumberColumn>
		<next:RadioBoxColumn></next:RadioBoxColumn>
		<next:Column field="corpName" header="共建单位名称" width="150" sortable="false"/>
		<next:Column field="organizationCode" header="组织机构代码" width="180" sortable="false"/>
		<next:Column field="legalPeople" header="法人代表" width="100" sortable="false"/>
		<next:Column field="organPhone" header="联系电话" width="100" sortable="false"/>
		<next:Column field="organKind" header="共建单位性质" dataset = "organTypeDataSet"width="100" sortable="false"/>
		<next:Column id ="organAdds" field="organAdds" header="地址" width="150" sortable="false"/>
		<next:Column field="postCode" header="邮编" width="100" sortable="false"/>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="cdcOrganInfoDataSet"/>
	</next:BottomBar>
</next:EditGridPanel>
</body>
</html>