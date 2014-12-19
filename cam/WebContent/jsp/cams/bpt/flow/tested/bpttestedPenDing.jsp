<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<script type="text/javascript">
   var struId = '<%=BspUtil.getStruId()%>';
   var organCode = '<%=BspUtil.getOrganCode()%>';
   var organType = '<%=BspUtil.getOrganType()%>';
</script>
<html>
<head>
<title>参试人员</title>
<next:ScriptManager />
<script type="text/javascript" src="bpttestedPenDing.js"></script>
<%
	String struId = BspUtil.getStruId();
%>
</head>
<body>
<model:datasets>
	<model:dataset id="BaseinfoPeopleDataSet"
		cmd="com.inspur.cams.bpt.manage.cmd.BptPeopleTestedQueryCommand"
		global="true" method="queryUnCommitTest">
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
	 
	<!--参试类别代码-->
	<model:dataset id="dsTest" enumName="TESTED.TYPE" autoLoad="true"></model:dataset>
	<!-- 伤残等级 -->
	<model:dataset id="DisabilityLevelDataset" enumName="LEVEL.CODE" autoLoad="true" global="true"></model:dataset>
</model:datasets>
<next:GridPanel id="editGridPanel" name="baseinfopeopleGrid" width="100%" stripeRows="true" height="100%" dataset="BaseinfoPeopleDataSet"  notSelectFirstRow="true" clickToSelectedForChkSM="true">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem symbol="-" ></next:ToolBarItem>
		<next:ToolBarItem text="增加"  id="add_button"iconCls="add" handler="insert"/>
		<next:ToolBarItem symbol="-" ></next:ToolBarItem>
		<next:ToolBarItem text="修改"  id="update_button"iconCls="edit" handler="update"/>
		<next:ToolBarItem symbol="-"  ></next:ToolBarItem>
		<next:ToolBarItem text="查看" id="detail_button" iconCls="detail" handler="detailTested"></next:ToolBarItem>
		<next:ToolBarItem symbol="-" ></next:ToolBarItem>
		<next:ToolBarItem text="删除" id="del_button" iconCls="delete" handler="del"></next:ToolBarItem>
		<next:ToolBarItem symbol="-" ></next:ToolBarItem>
		<next:ToolBarItem text="审批" id="submitButton" iconCls="view" handler="sure"/>
		<next:ToolBarItem symbol="-" ></next:ToolBarItem>
		<next:ToolBarItem text="批量审批" id="bthSmtBtn" iconCls="view" handler="batchSend"/>
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
		
		<next:Column id="reg_time" header="录入日期" field="REG_TIME" width="140">
						<next:TextField  />
		</next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="BaseinfoPeopleDataSet" />
	</next:BottomBar>
</next:GridPanel>
</body>
</html>
