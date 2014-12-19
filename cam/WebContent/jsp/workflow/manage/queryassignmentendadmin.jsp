<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<%String actId = request.getParameter("actId");

	if(actId == null){
		actId =(String) request.getSession().getAttribute("proId");
	}else{
		request.getSession().setAttribute("actId",actId);
	}
%>
	<head>
		<title>委派归档管理</title>
		<next:ScriptManager/>
		<script type="text/javascript">
			var beforeInit = {actId:"<%=actId%>"}
		</script>
		<script type="text/javascript" src="queryassignmentendadmin.js"></script>
	</head>
<body>
<model:datasets>
	<model:dataset id="ds" pageSize="10" cmd="org.loushang.workflow.manage.assignmentend.cmd.AssignmentEndManageQueryCmd" global="true">
		<model:record fromBean="org.loushang.workflow.manage.assignmentend.data.AssignmentEndManage"></model:record>
	</model:dataset>
</model:datasets>
<next:ViewPort>
<next:Panel>
<next:GridPanel id="GridPanel" name="processdefGrid" width="100%" stripeRows="true"
height="100%" dataset="ds" title="委派归档管理" notSelectFirstRow="true">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="返回" iconCls="undo" handler="toActivity()"/>
	</next:TopBar>
	<next:Columns>
	    <next:RowNumberColumn width="30"/>
		<next:CheckBoxColumn  ></next:CheckBoxColumn>

		<next:Column id="actualOrganName" header="办理人" field="actualOrganName"  width="200" >
		</next:Column>
		<next:Column id="assCreateTime" header="任务到达时间" field="assCreateTime" width="150" >
		</next:Column>
		<next:Column id="assEndTime" header="任务办理时间"  field="assEndTime" width="150" >
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