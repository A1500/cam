<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<%String proId = request.getParameter("proId");

	if(proId == null){
		proId =(String) request.getSession().getAttribute("proId");
	}else{
		request.getSession().setAttribute("proId",proId);
	}
%>
	<head>
		<title>委派归档列表</title>
		<next:ScriptManager/>
		<script type="text/javascript">
			var beforeInit = {proId:"<%=proId%>"}
		</script>
		<script type="text/javascript" src="queryactivityendadmin.js"></script>
	</head>
<body>
	<model:datasets>
		<model:dataset id="ds" pageSize="10" cmd="org.loushang.workflow.manage.activityend.cmd.ActivityEndManageQueryCmd" global="true">
			<model:record fromBean="org.loushang.workflow.manage.activityend.data.ActivityEndManage"></model:record>
		</model:dataset>
	</model:datasets>
	<next:ViewPort>
		<next:Panel>
			<next:GridPanel id="GridPanel" name="processdefGrid" width="100%" stripeRows="true"
			height="100%" dataset="ds" title="环节归档管理" notSelectFirstRow="true">
			<next:TopBar>
					<next:ToolBarItem symbol="->"></next:ToolBarItem>
					<next:ToolBarItem text="委派归档列表" iconCls="select" handler="toAssignment()"/>
					<next:ToolBarItem text="返回" iconCls="undo" handler="toProcess()"/>
				</next:TopBar>
				<next:Columns>
				    <next:RowNumberColumn width="30"/>
					<next:RadioBoxColumn></next:RadioBoxColumn>
					<next:Column id="actDefName" header="环节名称" field="actDefName" width="200" >
					</next:Column>
					<next:Column id="actCreateTime" header="开始时间" field="actCreateTime"  width="150" >
					</next:Column>
					<next:Column id="actEndTime" header="结束时间" field="actEndTime" width="150" >
					</next:Column>
					</next:Columns>
				<next:BottomBar>
					<next:PagingToolBar dataset="ds"/>
				</next:BottomBar>
			</next:GridPanel>
		</next:Panel>
	</next:ViewPort>
</body>
</html>