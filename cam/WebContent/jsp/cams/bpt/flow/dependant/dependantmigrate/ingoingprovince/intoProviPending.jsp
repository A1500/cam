<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<script type="text/javascript">
   var organCode = '<%=BspUtil.getOrganCode()%>';
</script>
<html>
	<head>
		<title>外省三属人员迁入我省</title>
		<next:ScriptManager/>
		<script type="text/javascript" src="intoProviPending.js"></script>
	</head>
<body>
<model:datasets>
	<!-- 外省三属人员迁入我省【未提交】 -->
	<model:dataset id="DependantIntoProviDataSet" cmd="com.inspur.cams.bpt.manage.cmd.BptApplyIntoprovinceQueryCommand" method="queryUncommitDependIntoprovin" global="true">
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
	<!-- 三属类别代码 -->
	<model:dataset id="DependantTypeCodeEnum" enumName="DEPENDANT.CODE" autoLoad="true" global="true"></model:dataset>
	 
</model:datasets>

<next:GridPanel id="editGridPanel" name="bptpetitionGrid"   stripeRows="true" width="100%" height="100%" dataset="DependantIntoProviDataSet">
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
	     
	    <next:Column id="domicileCode" header="属地行政区划" field="DICNAME" width="140">
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
		
		<next:Column id="disabilityStateCode" header="优抚对象状态" field="DEPENDANT_STATE_CODE" width="90" dataset="ObjectStateDataset">
			<next:TextField allowBlank="false"/>
		</next:Column>
	
		<next:Column id="objectType" header="三属对象类别" field="DEPENDANT_TYPE_CODE" width="130" dataset="DependantTypeCodeEnum">
			<next:TextField allowBlank="false"/>
		</next:Column>
		
		<next:Column id="lezswName" header="烈士姓名" field="LEZSW_NAME" width="60">
			<next:TextField/>
		</next:Column>   
			
		<next:Column id="lezswApproveDate" header="烈士批准时间" field="LEZSW_APPROVE_DATE" width="140">
			<next:TextField/>
		</next:Column>
		
		<next:Column id="oldPaperNo" header="原定期抚恤金编号" field="OLD_PAPER_NO" width="140">
			<next:TextField/>
		</next:Column>   
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="DependantIntoProviDataSet"/>
	</next:BottomBar>
</next:GridPanel>

</body>

</html>
