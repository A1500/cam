<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<%String actId = request.getParameter("actId");
	String actDefName=request.getParameter("actDefName");
	//byte[] bts = actDefName.getBytes();
	//actDefName = new String(bts,"UTF-8");
	if(actId == null){
		actId =(String) request.getSession().getAttribute("proId");
	}else{
		request.getSession().setAttribute("actId",actId);
	}
%>
	<head>
		<title>委派管理</title>
		<next:ScriptManager/>
		<script type="text/javascript">
			var actDefName = "<%=actDefName%>";
		    actDefName = decodeURI(actDefName);
			var beforeInit = {actId:"<%=actId%>",actDefName:actDefName}
		</script>
		<script type="text/javascript" src="queryassignmentadmin.js"></script>
	</head>
<body>
<model:datasets>
	<model:dataset id="ds" pageSize="10" cmd="org.loushang.workflow.manage.assignment.cmd.AssignmentManageQueryCmd" global="true">
		<model:record fromBean="org.loushang.workflow.manage.assignment.data.AssignmentManage"></model:record>
	</model:dataset>
</model:datasets>

<next:GridPanel id="GridPanel" name="processdefGrid" width="100%" stripeRows="true" height="490"
dataset="ds" title="委派管理" notSelectFirstRow="true">
<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="重新委派" iconCls="add" handler="reAssign()"/>
		<next:ToolBarItem text="取消委派" iconCls="remove" handler="cancelAssign()"/>
		<next:ToolBarItem text="返回" iconCls="undo" handler="toActivity()"/>
	</next:TopBar>
	<next:Columns>
	    <next:RowNumberColumn width="30"/>
		<next:RadioBoxColumn></next:RadioBoxColumn>
		<next:Column id="organName" header="参与者" field="organName" width="200" >
		</next:Column>
		<next:Column id="actualOrganName" header="实际处理人" field="actualOrganName"  width="200" >
		</next:Column>
		<next:Column id="actDefName" header="环节名称" field="actDefName" renderer="addName" width="150" >
		</next:Column>
		<next:Column id="status" header="委派状态" field="status" renderer="toStateName" width="150" >
		</next:Column>
		<next:Column id="createTime" header="任务到达时间" field="createTime" width="150" >
		</next:Column>
		<next:Column id="endTime" header="任务办理时间"  field="endTime" width="150" >
		</next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="ds"/>
	</next:BottomBar>
</next:GridPanel>
</body>
</html>