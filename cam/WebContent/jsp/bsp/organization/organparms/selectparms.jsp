<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<next:ScriptManager ></next:ScriptManager>
<html>
<head>
<title>选择参数名称</title>
<script type="text/javascript">
	var choiceBox='<%=request.getParameter("choiceBox")%>';

</script>
<script type="text/javascript" src="selectparms.js"></script>
<script type="text/javascript" src="parmhelp.js"></script>
</head>
<body>

<model:datasets>

	<model:dataset id="parmsTypeDs" autoLoad="true" global="true" cmd="org.loushang.bsp.organization.cmd.PubOrganParmsTypeQueryCommand" pageSize="-1">
		<model:record>
			<model:field name="organParmsDes" mapping="organParmsDes"/>
			<model:field name="organParmsName" mapping="organParmsName"/>
			<model:field name="dataSource" mapping="dataSource"/>
			<model:field name="enumName" mapping="enumName"/>
			<model:field name="sourceTableName" mapping="sourceTableName"/>
			<model:field name="whereCondition" mapping="whereCondition"/>
			<model:field name="selCol" mapping="selCol"/>
			<model:field name="dispCol" mapping="dispCol"/>
		</model:record>
	</model:dataset>
</model:datasets>
<next:ViewPort>
<next:AnchorLayout>
<next:GridPanel id="parmsGrid" name="parmsGrid" width="100%" height="100%" dataset="parmsTypeDs" >

	<next:TopBar>
		<next:ToolBarItem text="参数名称"></next:ToolBarItem>
		<next:ToolBarItem text="参数名称"  xtype="textfield" id="name" />
		<next:ToolBarItem text="查询" iconCls="query" handler="search" />
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem id="saveButoon" iconCls="yes" text="确定" handler="confirmValue()"></next:ToolBarItem>
	<next:ToolBarItem id="closeButoon" iconCls="no" text="关闭" handler="closew()"></next:ToolBarItem>
	</next:TopBar>

	<next:Columns>
		<next:RowNumberColumn width="30"/>
		<next:RadioBoxColumn></next:RadioBoxColumn>
		<next:Column  id="roleGroupName" header="参数名称" field="organParmsName" width="185">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="corporationName" header="参数描述" field="organParmsDes" width="190">
			<next:TextField allowBlank="false" />
		</next:Column>
	</next:Columns>

</next:GridPanel>
</next:AnchorLayout>
</next:ViewPort>
</body>
</html>
<script type="text/javascript">

</script>