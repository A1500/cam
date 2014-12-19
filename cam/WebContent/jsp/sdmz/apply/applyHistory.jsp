<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<html>
<head>
<title>办理历史明细查询列表</title>
<next:ScriptManager />
<script type="text/javascript">
<%
	String returnPage=new String(request.getParameter("returnPage").getBytes("ISO-8859-1"), "UTF-8");
	%>
	var returnPage1 = '<%=returnPage %>';
</script>
<script type="text/javascript" src="applyHistory.js"></script>

<body>
<model:datasets>
	<model:dataset id="ds" cmd="com.inspur.sdmz.apply.cmd.SamApplyQueryCmd"
		method="ywlsQuery" global="true">
		<model:record fromBean="com.inspur.sdmz.apply.data.SamApplyHandle"></model:record>
		<model:params>
			<model:param name="APPLY_ID" value='<%=request.getParameter("applyId")%>'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="blztDataset" enumName="HANDLE_STATE.TYPE" autoLoad="true"
		global="true"></model:dataset>
	
</model:datasets>


<next:GridPanel id="editGridPanel" name="mignxiGrid" width="100%"
	stripeRows="true" height="300" dataset="ds" notSelectFirstRow="true" title="明细查询">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem text="返回" iconCls="undo" handler="returnPage" ></next:ToolBarItem>
	</next:TopBar>

	
	<next:Columns>
		<next:RowNumberColumn width="30" />
		
		
		<next:Column id="historyId" header="办理历史ID" field="historyId" width="16%">
			<next:TextField />
		</next:Column>

		<next:Column id="handleState" header="办理状态" field="handleState" width="16%" dataset="blztDataset">
			<next:TextField />
		</next:Column>

		<next:Column id="handleOpinion" header="办理意见" field="handleOpinion" width="16%">
			<next:TextField />
		</next:Column>

		<next:Column id="handlePeople" header="办理人姓名" field="handlePeople" width="16%">
			<next:TextField />
		</next:Column>

		<next:Column id="handleOrgName" header="办理单位名称" field="handleOrgName" width="16%">
			<next:TextField />
		</next:Column>

		<next:Column id="handleTime" header="办理时间" field="handleTime" width="16%" >
			<next:TextField />
		</next:Column>

	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="ds" />
	</next:BottomBar>
</next:GridPanel>

</body>
</html>
