<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<script type="text/javascript">
   var organCode = '<%=BspUtil.getOrganCode()%>';
</script>
<html>
	<head>
		<title>外省残疾人员抚恤关系迁入我省未提交列表</title>
		<next:ScriptManager/>
		<script type="text/javascript" src="intoProviPending.js"></script>
	</head>
<body>
<model:datasets>
	<!-- 未提外省残疾人员抚恤关系迁入我省人员 -->
	<model:dataset id="IntoProvinceDataSet" cmd="com.inspur.cams.bpt.manage.cmd.BptApplyIntoprovinceQueryCommand" method="queryUnCommitDisaIntoprovi" global="true">
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
	<!-- 伤残类别代码 -->
	<model:dataset id="DisabilityTypeCodeEnum" enumName="DISABILITY.TYPE.CODE" autoLoad="true" global="true"></model:dataset>
	<!-- 伤残属别 -->
	<model:dataset id="DisabilityGenusDataset" enumName="GENUS.CODE" autoLoad="true" global="true"></model:dataset>
	<!-- 伤残性质 -->
	<model:dataset id="DisabilityCaseDataset" enumName="CASE.CODE" autoLoad="true" global="true"></model:dataset>
	<!-- 伤残等级 -->
	<model:dataset id="DisabilityLevelDataset" enumName="LEVEL.CODE" autoLoad="true" global="true"></model:dataset>
</model:datasets>

<next:GridPanel id="editGridPanel" name="bptpetitionGrid"   stripeRows="true" width="100%" height="100%" dataset="IntoProvinceDataSet">
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
	    <next:RowNumberColumn header="序号" width="20"/>
	     <next:CheckBoxColumn></next:CheckBoxColumn>
	     
	    <next:Column id="domicileCode" header="属地行政区划" field="DOMI_NAME" width="160">
				<next:TextField allowBlank="false"/>
		</next:Column>
		<next:Column id="name" header="姓名" field="NAME" width="60">
			<next:TextField allowBlank="false"/>
		</next:Column>
		
		<next:Column id="sex" header="性别" field="SEX" width="35" dataset="SexDataset">
			<next:TextField allowBlank="false"/>
		</next:Column>
		
		<next:Column id="nation" header="民族" field="NATION" width="45" dataset="NationDataset">
			<next:TextField allowBlank="false"/>
		</next:Column>
	
		<next:Column id="idCard" header="身份证件号码" field="ID_CARD" width="135">
			<next:TextField allowBlank="false"/>
		</next:Column>
		
		<next:Column id="disabilityStateCode" header="优抚对象状态" field="DISABILITY_STATE_CODE" width="90" dataset="ObjectStateDataset">
						<next:TextField allowBlank="false"/>
		</next:Column>
	
		<next:Column id="objectType" header="伤残类别" field="DISABILITY_TYPE_CODE" width="130" dataset="DisabilityTypeCodeEnum">
			<next:TextField allowBlank="false"/>
		</next:Column>
		
		<next:Column id="disabilityLevelCode" header="伤残等级" field="DISABILITY_LEVEL_CODE" width="55" dataset="DisabilityLevelDataset">
			<next:TextField/>
		</next:Column>
			
		<next:Column id="disabilityCaseCode" header="伤残性质" field="DISABILITY_CASE_CODE" width="55" dataset="DisabilityCaseDataset">
			<next:TextField/>
		</next:Column>
		
		<next:Column id="disabilityGenus" header="伤残属别" field="DISABILITY_GENUS_CODE" width="55" dataset="DisabilityGenusDataset">
			<next:TextField allowBlank="false"/>
		</next:Column>
		
		<next:Column id="disabilityNo" header="原残疾证件编号" field="DISABILITY_NO" width="120">
			<next:TextField allowBlank="false"/>
		</next:Column>
		
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="IntoProvinceDataSet"/>
	</next:BottomBar>
</next:GridPanel>

</body>

</html>
