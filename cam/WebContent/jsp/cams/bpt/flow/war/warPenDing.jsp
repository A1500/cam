<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<script type="text/javascript">
	var struId = '<%=BspUtil.getStruId()%>';
	var organCode = '<%=BspUtil.getOrganCode()%>';
	var organType = '<%=BspUtil.getOrganType()%>';
</script>
<html>
<head>
<title>参战人员业务受理</title>
<next:ScriptManager />
<script type="text/javascript" src="warPenDing.js"></script>
	<%
		String struId = BspUtil.getStruId();
	%>
</head>
<body>
<model:datasets>
	<model:dataset id="WarinfoDataSet"
		cmd="com.inspur.cams.bpt.manage.cmd.BptPeopleWarQueryCommand"
		global="true" method="queryUnCommitWar">
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
	<!-- 与户主关系 -->
	<model:dataset id="RelationshipTypeDataset" enumName="RELATIONSHIP.TYPE" autoLoad="true" global="true"></model:dataset>
	<!-- 文化程度 -->
	<model:dataset id="EducationDataset" enumName="EDUCATION.TYPE" autoLoad="true" global="true"></model:dataset>
	<!-- 婚姻状况 -->
	<model:dataset id="MarriageDataset" enumName="MARRIAGE.STATE" autoLoad="true" global="true"></model:dataset> 
	<!-- 户籍类别 -->
	<model:dataset id="DomicileDataset" enumName="DOMICILE.TYPE" autoLoad="true" global="true"></model:dataset>
	<!-- 政治面貌 -->
	<model:dataset id="PoliticalDataset" enumName="POLITICAL.LANDSCAPE" autoLoad="true" global="true"></model:dataset>
	<!-- 优抚对象类型 -->
	<model:dataset id="ObjectTypeDataset" enumName="OBJECT.TYPE.PART" autoLoad="true" global="true"></model:dataset>
	<!--参战类别代码-->
	<model:dataset id="warTypeCodeDataset" enumName="WARTYPE.CODE" autoLoad="true" global="true"></model:dataset>
</model:datasets>
<next:GridPanel id="editGridPanel" name="baseinfopeopleGrid" width="100%" stripeRows="true" height="100%" dataset="WarinfoDataSet" notSelectFirstRow="true" clickToSelectedForChkSM="true" >
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem symbol="-" ></next:ToolBarItem>
		<next:ToolBarItem text="增加" id="add_button" iconCls="add" handler="insert"/>
		<next:ToolBarItem symbol="-" ></next:ToolBarItem>
		<next:ToolBarItem text="修改"id="update_button"  iconCls="edit" handler="update" />
		<next:ToolBarItem symbol="-" ></next:ToolBarItem>
		<next:ToolBarItem text="查看" id="detail_button" iconCls="detail" handler="detailWar" />
		<next:ToolBarItem symbol="-" ></next:ToolBarItem>
		<next:ToolBarItem text="删除" id="del_button" iconCls="delete" handler="del" />
		<next:ToolBarItem symbol="-" ></next:ToolBarItem>
		<next:ToolBarItem text="审批" id="submitButton" iconCls="view" handler="sure" />
		<next:ToolBarItem symbol="-" ></next:ToolBarItem>
		<next:ToolBarItem text="批量审批" id="bthSmtBtn" iconCls="view" handler="batchSend" />
		<next:ToolBarItem symbol="-" ></next:ToolBarItem>
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn width="50" header="编号" />
		<next:CheckBoxColumn></next:CheckBoxColumn>
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
		<next:Column id="asdpNo" header="退伍证号" field="ASDP_NO" width="90">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="forcesNo" header="原部队代号" field="FORCES_NO"
			width="140">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="warTypeCode" header="参战类别代码" field="WAR_TYPE_CODE"
			width="150" dataset="warTypeCodeDataset">
			<next:TextField allowBlank="false" />
		</next:Column>
        <next:Column id="regTime" header="录入时间" field="REG_TIME" width="140">
			<next:TextField  allowBlank="false"  />
		</next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="WarinfoDataSet" />
	</next:BottomBar>
</next:GridPanel>
</body>
</html>
