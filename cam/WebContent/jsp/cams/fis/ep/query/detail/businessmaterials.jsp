<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<title>业务材料</title>
<next:ScriptManager />
<script>
		var idField='<%=request.getParameter("dataBean")%>';
</script>
<script type="text/javascript" src="businessmaterials.js"></script>
</head>
<body>
<model:datasets>
	<model:dataset id="accessoriesDataSet"
		cmd="com.inspur.cams.fis.ep.base.cmd.CemeInspectionQueryCmd"
		method="queryAccessories" global="true">
		<model:record  fromBean="com.inspur.cams.fis.ep.base.data.FisCemeAccessories"></model:record>
	</model:dataset>
	<model:dataset id="accessoriesItemDataSet"
		cmd="com.inspur.cams.fis.ep.base.cmd.CemeInspectionQueryCmd"
		method="queryAccessoriesItem" global="true">
		<model:record  fromBean="com.inspur.cams.fis.ep.base.data.FisCemeAccessories"></model:record>
	</model:dataset>
	<model:dataset id="accessoriesType" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_CEME_ACCESSORIES_TYPE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
</model:datasets>

<!-- 业务材料 -->

<next:Panel title="业务材料">
	<next:EditGridPanel id="uploadGrid" width="99.9%" stripeRows="true"
		height="100%" dataset="accessoriesDataSet">
		<next:TopBar>
			<next:ToolBarItem symbol="附件列表"></next:ToolBarItem>
			<next:ToolBarItem symbol="->"></next:ToolBarItem>
			<next:ToolBarItem iconCls="detail" text="查看上传附件"
				handler="clickUploadFile"></next:ToolBarItem>
				<next:ToolBarItem iconCls="return" text="返回" handler="back" />
		</next:TopBar>

		<next:Columns>
			<next:RowNumberColumn />
			<next:RadioBoxColumn></next:RadioBoxColumn>
			<next:Column header="材料类型" field="code" width="40%" editable="false"
				dataset="accessoriesType">
				<next:TextField />
			</next:Column>
			<next:Column header="附件名称" field="accessoriesName" width="30%"
				editable="false">
				<next:TextField />
			</next:Column>
			<next:Column header="附件描述" field="note" width="28%" editable="false">
				<next:TextField />
			</next:Column>
		</next:Columns>
		<next:BottomBar>
			<next:PagingToolBar dataset="accessoriesDataSet" />
		</next:BottomBar>
	</next:EditGridPanel>
</next:Panel>

<!-- 下载附件列表 -->
<next:Window id="uploadList" closeAction="hide" title="附件上传列表"
	width="630" height="300" autoScroll="true" modal="true"
	closable="false">
	<next:EditGridPanel id="uploadListGrid" width="98%" stripeRows="true"
		height="88%" dataset="accessoriesItemDataSet">
		<next:TopBar>
			<next:ToolBarItem symbol="附件列表"></next:ToolBarItem>
			<next:ToolBarItem symbol="->"></next:ToolBarItem>
			<next:ToolBarItem iconCls="return" text="关闭"
				handler="closeUploadList"></next:ToolBarItem>
		</next:TopBar>
		<next:Columns>
			<next:RowNumberColumn />
			<next:RadioBoxColumn></next:RadioBoxColumn>
			<next:Column header="附件名称" width="18%" field="accessoriesName"
				editable="false">
				<next:TextField />
			</next:Column>
			<next:Column header="附件描述" width="15%" field="note" editable="false">
				<next:TextField />
			</next:Column>
			<next:Column header="下载附件" field="" width="10%" editable="false"
				renderer="downloadUploadFile">
				<next:TextField />
			</next:Column>
		</next:Columns>
		<next:BottomBar>
			<next:PagingToolBar dataset="accessoriesItemDataSet" />
		</next:BottomBar>
	</next:EditGridPanel>
</next:Window>
</body>
</html>
