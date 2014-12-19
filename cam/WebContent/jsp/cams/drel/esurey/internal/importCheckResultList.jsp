<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<html>
<head>
<title>核查业务反馈列表</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript" src="importCheckResultList.js"></script>
</head>
<body>
<model:datasets>
	<model:dataset id="ensureToClientDataSet" cmd="com.inspur.cams.drel.ensureInfo.cmd.EnsureToClientQueryCmd" method="queryInfo" pageSize="200">
		<model:record>
			<model:field name="PROJECT_NAME"  mapping="PROJECT_NAME"/>
		</model:record>
	</model:dataset>
</model:datasets>
<next:EditGridPanel id="grid" dataset="ensureToClientDataSet" width="100%" stripeRows="true" height="99.9%">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="export"  text="导入核对信息" handler="importEnsureInfo"/>
		<next:ToolBarItem iconCls="detail"  text="查看反馈数据" hidden="true" handler="feedBackDetail"/>
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn></next:RowNumberColumn>
		<next:RadioBoxColumn></next:RadioBoxColumn>
		<next:Column field="FEEDBACK_TIME" header="反馈时间"  width="15%" sortable="false"/>
		<next:Column field="AREA_NAME" header="单位名称" width="15%" sortable="false"/>
		<next:Column field="FAMILY_NUM" header="核查户数" width="15%" hidden="true" sortable="false" />
		<next:Column field="PEOPLE_NUM" header="核查人数" width="15%"  sortable="false" renderer="editHref"/>
		<next:Column field="APPLY_TYPE" header="核查类别" width="15%"  sortable="false" />
		<next:Column field="PROJECT_NAME" header="核查项目"  width="30%" sortable="false"/>
		<next:Column field="AREA_NAME" header="核查结果" width="15%" hidden="true" sortable="false"/>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="ensureToClientDataSet"/>
	</next:BottomBar>
</next:EditGridPanel>
</body>
</html>

<!-- 导入xml窗口 -->
<next:Window id="importWin" closeAction="hide" title="导入窗口"  height="150" width="600" modal="true">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="save" text="导入"  handler="importXml"></next:ToolBarItem>
		<next:ToolBarItem iconCls="return" text="关闭"    handler="closeWin"></next:ToolBarItem>
	</next:TopBar>
	<next:Html>
		<form id="form_content" onsubmit="return false" class="L5form">
		<table border="1" width="100%" >
			<tr>
				<td class="FieldLabel"  width="20%" >XML文件路径：</td>
				<td class="FieldInput"  colspan="3">
				<input class="file" type="file"  id="xmlFilePath" name="xmlFilePath"  style="width: 95%; height: 40" /></td>
			</tr>
		</table>
		</form>
	</next:Html>
</next:Window>