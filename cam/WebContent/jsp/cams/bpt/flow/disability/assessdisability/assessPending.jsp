<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<script type="text/javascript">
   var organCode = '<%=BspUtil.getOrganCode()%>';
   var organType = '<%=BspUtil.getOrganType()%>';
</script>
<html>
	<head>
		<title>伤残人员评定伤残等级待办</title>
		<next:ScriptManager/>
		<script type="text/javascript" src="assessPending.js"></script>
	</head>
<body>
<model:datasets>
	<!-- 未提交伤残人员 -->
	<model:dataset id="DisabilityPeopleDataSet" cmd="com.inspur.cams.bpt.manage.cmd.BptPeopleDisabilityQueryCommand" method="queryUnCommitDisPeo" global="true">
	</model:dataset>
	
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
	
	<!-- 性别 -->
	<model:dataset id="SexDataset" enumName="COMM.SEX" autoLoad="true" global="true"></model:dataset>
	
	<!-- 优抚对象状态 -->
	<model:dataset id="ObjectStateDataset" enumName="OBJECT.STATE" autoLoad="true" global="true"></model:dataset>
	
	<!-- 优抚对象类别 -->
	<model:dataset id="ObjectTypeDataset"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_BPT_OBJECT_TYPE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 伤残属别 -->
	<model:dataset id="DisabilityGenusDataset" enumName="GENUS.CODE" autoLoad="true" global="true"></model:dataset>
	<!-- 伤残性质 -->
	<model:dataset id="DisabilityCaseDataset" enumName="CASE.CODE" autoLoad="true" global="true"></model:dataset>
	<!-- 伤残等级 -->
	<model:dataset id="DisabilityLevelDataset" enumName="LEVEL.CODE" autoLoad="true" global="true"></model:dataset>
</model:datasets>

<next:GridPanel id="editGridPanel" name="bptpetitionGrid" clickToSelectedForChkSM="true" stripeRows="true" width="100%" height="100%" dataset="DisabilityPeopleDataSet">
	<next:TopBar >
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem symbol="-" ></next:ToolBarItem>
		<next:ToolBarItem iconCls="add" id="add_button"  text="增加" handler="insert"/>
		<next:ToolBarItem symbol="-" ></next:ToolBarItem>
		<next:ToolBarItem iconCls="edit" id="update_button" text="修改" handler="update"/>
		<next:ToolBarItem symbol="-" ></next:ToolBarItem>
		<next:ToolBarItem text="查看"id="detail_button" iconCls="detail" handler="detail"/>
		<next:ToolBarItem symbol="-" ></next:ToolBarItem>
		<next:ToolBarItem text="删除" id="del_button" iconCls="delete" handler="del"/>
		<next:ToolBarItem symbol="-" ></next:ToolBarItem>
		<next:ToolBarItem iconCls="view" id="submitButton" text="提交" handler="createAndSend"/>
		<next:ToolBarItem symbol="-" ></next:ToolBarItem>
		<next:ToolBarItem iconCls="view" id="bthSmtBtn"  text="批量提交" handler="batchSend()"/>
		<next:ToolBarItem symbol="-" ></next:ToolBarItem>
	</next:TopBar>
	
	<next:Columns>
	    <next:RowNumberColumn header="序号" width="45"/>
	     <next:CheckBoxColumn></next:CheckBoxColumn>
	     
	    <next:Column id="domicileCode" header="属地行政区划" field="DOMI_NAME" width="140">
						<next:TextField allowBlank="false" />
		</next:Column>
	
		<next:Column id="name" header="姓名" field="NAME" width="60" >
			<next:TextField allowBlank="false" />
		</next:Column>
		
		<next:Column id="sex" header="性别" field="SEX" width="60" dataset="SexDataset">
			<next:TextField allowBlank="false" />
		</next:Column>
		
		<next:Column id="nation" header="民族" field="NATION" width="60" dataset="NationDataset" >
			<next:TextField allowBlank="false" />
		</next:Column>
	
		<next:Column id="idCard" header="身份证件号码" field="ID_CARD" width="135" >
			<next:TextField allowBlank="false" />
		</next:Column>
		
		<next:Column id="disabilityStateCode" header="优抚对象状态" field="DISABILITY_STATE_CODE" width="90" dataset="ObjectStateDataset">
						<next:TextField allowBlank="false" />
		</next:Column>
	
		<next:Column id="objectType" header="伤残类别" field="DISABILITY_TYPE_CODE" width="130" dataset="ObjectTypeDataset">
			<next:TextField allowBlank="false" />
		</next:Column>
		
		<next:Column id="disabilityLevelCode" header="伤残等级" field="DISABILITY_LEVEL_CODE" width="60" dataset="DisabilityLevelDataset">
			<next:TextField  />
		</next:Column>
			
		<next:Column id="disabilityCaseCode" header="伤残性质" field="DISABILITY_CASE_CODE" width="90" dataset="DisabilityCaseDataset">
			<next:TextField  />
		</next:Column>
		
		<next:Column id="disabilityGenus" header="伤残属别" field="DISABILITY_GENUS_CODE" width="80" dataset="DisabilityGenusDataset">
			<next:TextField allowBlank="false" />
		</next:Column>
		
		<next:Column id="regTime" header="录入时间" field="REG_TIME" width="140" >
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="applyId" header="apply_id" field="APPLY_ID"  width="240" hidden="true"/>
		<next:Column id="serviceType" header="serviceType" field="SERVICE_TYPE"  width="240" hidden="true"/>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="DisabilityPeopleDataSet" />
	</next:BottomBar>
</next:GridPanel>

</body>

</html>
