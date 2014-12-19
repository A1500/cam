<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<html>
<head>
<title>信息质量查询列表</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="fisCremationInfoParseList.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
</head>
<body>
<model:datasets>
	<model:dataset id="fisCremationInfoParseDataSet" cmd="com.inspur.cams.fis.base.cmd.FisCremationInfoParseQueryCmd" method="queryDs" >
		<model:record fromBean="com.inspur.cams.fis.base.data.FisCremationInfoParse"/>
	</model:dataset>
</model:datasets>
<next:Panel width="100%" border="0">
	<next:Html>
	<fieldset style="overflow:visible;" class="GroupBox">
	<legend class="GroupBoxTitle">查询条件</legend>
		<form class="L5form">
			<table border="1" width="100%">
				<tr>
				    <td class="FieldLabel" style="width:10%">单位名称</td>
				    <td class="FieldInput" style="width:20%"><input type="text" id="unitName"/></td>
					<td class="FieldButton" style="width:20%"><button onclick="query()">查询</button>&nbsp;&nbsp;&nbsp;&nbsp;<button type="reset">重置</button></td>
				</tr>
			</table>
		</form>
	</fieldset>
	</next:Html>
</next:Panel>
<next:EditGridPanel id="grid" dataset="fisCremationInfoParseDataSet" width="100%" stripeRows="true" height="99.9%" title="数据质量查询">
    <next:TopBar>
        <next:ToolBarItem symbol="->"></next:ToolBarItem>
        <next:ToolBarItem iconCls="export" text="Excel导出" handler="exportExcel"></next:ToolBarItem>
    </next:TopBar>
	<next:Columns>
		<next:RowNumberColumn></next:RowNumberColumn>
		<next:RadioBoxColumn></next:RadioBoxColumn>
		<next:Column field="UNIT_ID" header="单位编码" width="100" sortable="false"/>
		<next:Column field="UNIT_NAME" header="单位名称" width="150" sortable="false"/>
		<next:Column field="CREMATION_NUM_YEAR" header="当年火化数" width="10%" sortable="false" align="right"/>
		<next:Column field="CREMATION_NUM_LAST_YEAR" header="上年火化数" width="10%" sortable="false" align="right"/>
		<next:Column field="NULL_IDTYPE_NUM" header="证件类型为空数量" width="10%" sortable="false" align="right"/>
		<next:Column field="ILLEGAL_ID_NUM" header="身份证号不合法数量" width="10%" sortable="false" align="right"/>
		<next:Column field="ILLEGAL_DATA_YEAR" header="当年不规则数据" width="155" sortable="false" align="right"/>
		<next:Column field="ILLEGAL_DATA_TOTAL" header="不规则数据总数" width="155" sortable="false" align="right"/>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="fisCremationInfoParseDataSet"/>
	</next:BottomBar>
</next:EditGridPanel>
</body>
</html>