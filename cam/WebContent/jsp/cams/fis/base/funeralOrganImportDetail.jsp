<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<html>
<head>
<title>上报信息</title>
<next:ScriptManager />
<script type="text/javascript">
	var method = "<%=request.getParameter("method")%>";
	var unitId = "<%=request.getParameter("unitId")%>";
	var prop = "<%=request.getParameter("prop")%>";
	var organCode = "<%=request.getParameter("organCode")%>";
</script>
<script type="text/javascript" src="funeralOrganImportDetail.js"></script>
<script type="text/javascript"
	src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript" src="../funeral/PublicTimeControl.js"></script>
</head>
<body>

<model:datasets>
	<!-- 殡仪馆上报信息 -->
	<model:dataset id="ds"
		cmd="com.inspur.cams.fis.base.cmd.FisImportDataQueryCmd" global="true"
		pageSize="10" sortField="START_TIME DESC,UPLOAD_TIME" sortDirection="DESC">
		<model:record fromBean="com.inspur.cams.fis.base.data.FisImportData"></model:record>
	</model:dataset>
</model:datasets>

<next:ViewPort>
	<next:Panel width="100%" height="100%">
	<next:Panel height="50%">
		<next:Html>
			<iframe id="iframe"
				frameborder="no" border="0" marginwidth="0" marginheight="0"
				scrolling="no" allowtransparency="yes" width="100%" height="99%">
			</iframe>
		</next:Html>
	</next:Panel>
	
	<next:GridPanel id="editGridPanel2" name="editGridPanel2"
		height="50%" stripeRows="true" dataset="ds"
		notSelectFirstRow="true" autoScroll="true">
		<next:TopBar>
			<next:ToolBarItem symbol="上报信息列表"></next:ToolBarItem>
			<next:ToolBarItem symbol="->"></next:ToolBarItem>
			<next:ToolBarItem iconCls="export" text="导出" hidden="true"/>
		</next:TopBar>
		<next:Columns>
			<next:RowNumberColumn width="30" />
			<next:Column id="uploadTime" header='上报时间' field="uploadTime"
				width="140">
				<next:TextField allowBlank="false" />
			</next:Column>
			<next:Column id="startTime" header='开始时间' field="startTime"
				width="140">
				<next:TextField allowBlank="false" />
			</next:Column>
			<next:Column id="endTime" header='结束时间' field="endTime"
				width="140">
				<next:TextField allowBlank="false" />
			</next:Column>
			<next:Column id="ifFile" header='上报方式' field="ifFile"
				width="80" align="center" renderer="sbfsRenderer">
				<next:TextField allowBlank="false" />
			</next:Column>
			<next:Column id="ifFile" header='查看' field="ifFile"
				width="80" renderer="ckRenderer" hidden="true">
				<next:TextField allowBlank="false" />
			</next:Column>
		</next:Columns>
		<next:BottomBar>
			<next:PagingToolBar dataset="ds"></next:PagingToolBar>
		</next:BottomBar>
	</next:GridPanel>
	</next:Panel>
</next:ViewPort>
</body>