<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<script type="text/javascript">
   var organCode = '<%=BspUtil.getOrganCode()%>';
</script>
<html>
	<head>
		<title>参战人员跨省迁出</title>
		<next:ScriptManager/>
		<script type="text/javascript" src="emigrationPending.js"></script>
	</head>
<body>
<model:datasets>
	<!-- 参战人员抚恤关系跨省迁出【未提交】 -->
	<model:dataset id="EmigratDataSet" cmd="com.inspur.cams.bpt.manage.cmd.BptApplyEmigrationQueryCommand" method="queryUnComWarEmigrate" global="true">
	</model:dataset>
	<!-- 民族 -->
	<model:dataset id="NationDataset" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_NATION'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 性别 -->
	<model:dataset id="SexDataset" enumName="COMM.SEX" autoLoad="true" global="true"></model:dataset>
	<!-- 优抚对象状态 -->
	<model:dataset id="ObjectStateDataset" enumName="OBJECT.STATE" autoLoad="true" global="true"></model:dataset>
	<!--参战类别代码-->
	<model:dataset id="dsWarData" enumName="WARTYPE.CODE" autoLoad="true" global="true"></model:dataset>
	
</model:datasets>

<next:GridPanel id="editGridPanel" name="bptpetitionGrid"   stripeRows="true" width="100%" height="100%" dataset="EmigratDataSet">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem symbol="-" ></next:ToolBarItem>
		<next:ToolBarItem iconCls="add"  text="增加" handler="insert"/>
		<next:ToolBarItem symbol="-" ></next:ToolBarItem>
		<next:ToolBarItem iconCls="edit"  text="修改" handler="update"/>
		<next:ToolBarItem symbol="-" ></next:ToolBarItem>
		<next:ToolBarItem text="查看" iconCls="detail" handler="detail"/>
		<next:ToolBarItem symbol="-" ></next:ToolBarItem>
				<next:ToolBarItem iconCls="view"  text="提交" handler="createAndSend"/>
				<next:ToolBarItem symbol="-" ></next:ToolBarItem>
		
	</next:TopBar>
	
	<next:Columns>
	    <next:RowNumberColumn header="序号" width="45"/>
	     <next:CheckBoxColumn></next:CheckBoxColumn>
	     
	    <next:Column id="domicileCode" header="属地行政区划" field="DOMI_NAME" width="140">
			<next:TextField allowBlank="false"/>
		</next:Column>
		
		<next:Column id="name" header="姓名" field="NAME" width="60">
			<next:TextField allowBlank="false"/>
		</next:Column>
		
		<next:Column id="sex" header="性别" field="SEX" width="60" dataset="SexDataset">
			<next:TextField allowBlank="false"/>
		</next:Column>
		
		<next:Column id="nation" header="民族" field="NATION" width="60" dataset="NationDataset">
			<next:TextField allowBlank="false"/>
		</next:Column>
	
		<next:Column id="idCard" header="身份证件号码" field="ID_CARD" width="135">
			<next:TextField allowBlank="false"/>
		</next:Column>
		
		<next:Column id="warTypeCode" header="参战类别" field="WAR_TYPE_CODE" width="180" dataset="dsWarData">
			<next:TextField allowBlank="false"/>
		</next:Column>
		
		<next:Column id="forcesNo" header="原部队" field="FORCES_NO" width="90" >
			<next:TextField allowBlank="false"/>
		</next:Column>
		
		<next:Column id="position" header="职务" field="POSITION" width="90" >
			<next:TextField allowBlank="false"/>
		</next:Column>
		
		<next:Column id="asdpNo" header="退伍证号" field="ASDP_NO" width="90" >
			<next:TextField allowBlank="false"/>
		</next:Column>
		
		
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="EmigratDataSet"/>
	</next:BottomBar>
</next:GridPanel>

</body>

</html>
