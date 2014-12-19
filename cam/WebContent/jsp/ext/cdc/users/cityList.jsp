<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<html>
<head>
<title>城市社区管理</title>
<next:ScriptManager/>
<script type="text/javascript" src="cityList.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript">
	var method='<%=request.getParameter("method")%>';
	var organId='<%=request.getParameter("id")%>';
	var organName='<%=request.getParameter("name")%>';
	organName=decodeURIComponent(organName);
	var myDate = new Date();
	var mytime=myDate.toLocaleTimeString();
</script>
</head>
<body>
<model:datasets>
	<model:dataset id="userDs" cmd="com.inspur.cams.comm.extuser.cmd.ComExtUserQueryCmd">
		<model:record fromBean="com.inspur.cams.comm.extuser.data.ComExtUser"/>
	</model:dataset>
	<model:dataset id="cityDs" cmd="com.inspur.cams.comm.diccity.cmd.DicCityQueryCommand" pageSize="15" method="queryCity">
	</model:dataset>
</model:datasets>
<next:ViewPort>
	<next:TabPanel width="100%" height="100%">
		<next:Tabs>
			<next:Panel title="城市社区管理" width="100%" height="100%" >
<next:EditGridPanel id="selectedGrid"  dataset="cityDs" width="100%" stripeRows="true" height="99.9%" >
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="save" text="增加" handler="insert"></next:ToolBarItem>
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn></next:RowNumberColumn>
		<next:CheckBoxColumn></next:CheckBoxColumn>
		<next:Column field="ID" header="区划代码" width="150" sortable="false"/>
		<next:Column field="NAME" header="单位名称" width="150" sortable="false"/>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="cityDs"/>
	</next:BottomBar>
</next:EditGridPanel>
</next:Panel>
</next:Tabs>
</next:TabPanel>
</next:ViewPort>
</body>
</html>