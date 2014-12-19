<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<script type="text/javascript">
   var struId = '<%=BspUtil.getStruId()%>';
   var organCode = '<%=BspUtil.getOrganCode()%>';
</script>
<html>
<head>
<title>参试抚恤关系跨省迁出</title>
<next:ScriptManager />
<script type="text/javascript" src="emigrationPending.js"></script>
<%
	String struId = BspUtil.getStruId();
%>
</head>
<body>
<model:datasets>
	<model:dataset id="TestedEmigratDataSet"
		cmd="com.inspur.cams.bpt.manage.cmd.BptApplyEmigrationQueryCommand"
		global="true" method="queryUncommitTested">
	</model:dataset>
	<!-- 性别 -->
	<model:dataset id="SexDataset" enumName="COMM.SEX" autoLoad="true" global="true"></model:dataset>
    <!-- 民族 -->
	<model:dataset id="NationDataset"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_NATION'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	 
	<!--参试类别代码-->
	<model:dataset id="dsTest" enumName="TESTED.TYPE" autoLoad="true"></model:dataset>
	<!-- 伤残等级 -->
	<model:dataset id="DisabilityLevelDataset" enumName="LEVEL.CODE" autoLoad="true" global="true"></model:dataset>
</model:datasets>
<next:GridPanel id="editGridPanel" name="baseinfopeopleGrid"
	width="100%" stripeRows="true" height="100%"
	dataset="TestedEmigratDataSet"  notSelectFirstRow="true">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem symbol="-" ></next:ToolBarItem>
		<next:ToolBarItem text="增加" iconCls="add" handler="insert" />
		<next:ToolBarItem symbol="-" ></next:ToolBarItem>
		<next:ToolBarItem text="修改" iconCls="edit" handler="update" />
		<next:ToolBarItem symbol="-" ></next:ToolBarItem>
		<next:ToolBarItem text="查看" iconCls="detail" handler="detail"></next:ToolBarItem>
		<next:ToolBarItem symbol="-" ></next:ToolBarItem>
				<next:ToolBarItem iconCls="view"  text="提交" handler="createAndSend"/>
				<next:ToolBarItem symbol="-" ></next:ToolBarItem>
		
	</next:TopBar>
	
	<next:Columns>
		<next:RowNumberColumn width="50" header="编号" />
		<next:RadioBoxColumn></next:RadioBoxColumn>
		<next:Column id="domicileCode" header="属地行政区划" field="DICNAME"
			width="220">
			<next:TextField allowBlank="false" />
		</next:Column>

		<next:Column id="name" header="姓名" field="NAME" width="70">
			<next:TextField allowBlank="false" />
		</next:Column>

		<next:Column id="idCard" header="身份证件号码" field="ID_CARD" width="160">
			<next:TextField allowBlank="false" />
		</next:Column>

		<next:Column id="sex" header="性别" field="SEX" width="40"
			dataset="SexDataset">
			<next:TextField allowBlank="false" />
		</next:Column>

		<next:Column id="NATION" header="民族" field="NATION" width="70"
			dataset="NationDataset">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="forcesNo" header="原部队代号" field="FORCES_NO"
			width="150">
			<next:TextField />
		</next:Column>

		<next:Column id="testedType" header="参试类别" field="TESTED_TYPE" width="150" dataset="dsTest">
			<next:TextField />
		</next:Column>


		<next:Column id="disabilityLevelCode" header="残疾等级" field="DISABILITY_LEVEL_CODE"
			width="90" dataset="DisabilityLevelDataset">
			<next:TextField />
		</next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="TestedEmigratDataSet" />
	</next:BottomBar>
</next:GridPanel>
</body>
</html>
