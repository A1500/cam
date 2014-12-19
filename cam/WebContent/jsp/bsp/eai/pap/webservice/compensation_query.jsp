<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ include file="/jsp/public/resources_jspdir.jsp"%>
<html>
<head>
<title>服务补偿</title>
<next:ScriptManager />
<script type="text/javascript" src="compensation_query.js"></script>
<script language="javascript">
var RES_DELETE='<%=res.get("ASK.DELETE")%>';
</script>
</head>
<body>

<model:datasets>
	<model:dataset id="compensationDataSet" cmd="org.loushang.bsp.eai.pap.compensation.cmd.CompensationQueryCommand" global="true"  pageSize="10">
		<model:record fromBean="org.loushang.bsp.eai.pap.compensation.data.Compensation">
			<model:field name="appName" type="string"/>
		</model:record>
	</model:dataset>
</model:datasets>
<next:ViewPort>
<next:AnchorLayout>
<next:GridPanel id="compensationGrid" name="compensationGrid" width="100%" height="300" dataset="compensationDataSet" >
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem text="补偿" iconCls="edit" handler="compensate_click"/>
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn width="30"/>
		<next:CheckBoxColumn></next:CheckBoxColumn>
		<next:Column id="appName" header="应用" field="roleName" width="150">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="webserviceAddress" header="服务地址" field="webserviceAddress" width="200">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="operation" header="操作" field="operation" width="100">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="createTime" header="创建时间" field="createTime" width="120">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="objectValue" header="操作内容" field="objectValue" width="240">
			<next:TextField allowBlank="false" />
		</next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar  dataset="compensationDataSet"/>
	</next:BottomBar>
</next:GridPanel>
</next:AnchorLayout>
</next:ViewPort>
</body>
</html>