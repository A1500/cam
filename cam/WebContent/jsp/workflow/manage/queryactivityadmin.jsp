<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<%String proId = request.getParameter("proId");
	String procDefName = request.getParameter("procDefName");
	if(proId == null){
		proId =(String) request.getSession().getAttribute("proId");
		procDefName =(String) request.getSession().getAttribute("procDefName");
	}else{

		request.getSession().setAttribute("proId",proId);
		request.getSession().setAttribute("procDefName",procDefName);
	}
%>
	<head>
		<title>环节实例管理</title>
		<next:ScriptManager/>
		<script type="text/javascript">
			var proDefName = "<%=procDefName%>";
		     proDefName = decodeURI(proDefName);
			var beforeInit = {proId:"<%=proId%>",procDefName:proDefName}
		</script>
		<script type="text/javascript" src="queryactivityadmin.js"></script>
	</head>
<body>
	<model:datasets>
		<model:dataset id="ds" pageSize="10" cmd="org.loushang.workflow.manage.activity.cmd.ActivityManageQueryCmd" global="true">
			<model:record fromBean="org.loushang.workflow.manage.activity.data.ActivityManage"></model:record>
		</model:dataset>
	</model:datasets>
	<next:ViewPort>
		<next:Panel>
			<next:GridPanel id="GridPanel" name="processdefGrid" width="100%" stripeRows="true" height="100%" dataset="ds"
			title="环节实例管理" notSelectFirstRow="true">
			<next:TopBar>
					<next:ToolBarItem symbol="->"></next:ToolBarItem>
					<next:ToolBarItem text="委派列表" iconCls="select" handler="toAssignment()"/>
					<next:ToolBarItem text="挂起" iconCls="remove" handler="suspend()"/>
					<next:ToolBarItem text="恢复" iconCls="undo" handler="resume()"/>
					<next:ToolBarItem text="中断" iconCls="remove" handler="abort()"/>
					<next:ToolBarItem text="终止" iconCls="remove" handler="terminate()"/>
					<next:ToolBarItem text="启动环节" iconCls="select" handler="start()"/>
					<next:ToolBarItem text="返回" iconCls="undo" handler="toProcess()"/>
				</next:TopBar>
				<next:Columns>
				    <next:RowNumberColumn width="30"/>
					<next:RadioBoxColumn></next:RadioBoxColumn>
					<next:Column id="actDefName" header="环节名称" field="actDefName" width="200" >
					</next:Column>
					<next:Column id="state" header="状态" field="state" renderer="toStateName" width="200" >
					</next:Column>
					<next:Column id="createTime" header="开始时间" field="createTime"  width="150" >
					</next:Column>
					<next:Column id="currentStateTime" header="当前状态时间" field="currentStateTime" width="150" >
					</next:Column>
					<next:Column id="procDefName" header="流程名称"  field="procDefName" renderer="rendererProName" width="300" >
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