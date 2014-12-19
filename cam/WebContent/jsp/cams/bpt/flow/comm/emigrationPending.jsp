<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<script type="text/javascript">
   var organCode = '<%=BspUtil.getOrganCode()%>';
   var organType = '<%=BspUtil.getOrganType()%>';
</script>
<html>
	<head>
		<title>其他抚恤关系跨省迁出</title>
		<next:ScriptManager/>
		<script type="text/javascript" src="emigrationPending.js"></script>
	</head>
<body>
<model:datasets>
	<!-- 其他抚恤关系跨省迁出【未提交】 -->
	<model:dataset id="EmigratDataSet" cmd="com.inspur.cams.bpt.manage.cmd.BptApplyEmigrationQueryCommand" method="queryEmigration" global="true">
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
</model:datasets>

<next:GridPanel id="editGridPanel" name="bptpetitionGrid" clickToSelectedForChkSM="true"  stripeRows="true" width="100%" height="100%" dataset="EmigratDataSet">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem symbol="-" ></next:ToolBarItem>
		<next:ToolBarItem iconCls="add"  id="add_button"  text="增加" handler="insert"/>
		<next:ToolBarItem symbol="-" ></next:ToolBarItem>
		<next:ToolBarItem iconCls="edit"  id="update_button"  text="修改" handler="update"/>
		<next:ToolBarItem symbol="-" ></next:ToolBarItem>
		<next:ToolBarItem text="查看"  id="detail_button" iconCls="detail" handler="detail"/>
		<next:ToolBarItem symbol="-" ></next:ToolBarItem>
		<next:ToolBarItem text="删除"  id="del_button" iconCls="delete" handler="del"/>
		<next:ToolBarItem symbol="-" ></next:ToolBarItem>
		<next:ToolBarItem iconCls="view" id="submitButton" text="提交" handler="createAndSend"/>
		<next:ToolBarItem symbol="-" ></next:ToolBarItem>
		<next:ToolBarItem iconCls="view" id="bthSmtBtn" text="批量提交" handler="batchSend"/>
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
		
		<next:Column id="disabilityStateCode" header="业务类型" field="OBJECT_NAME" width="240">
			<next:TextField allowBlank="false"/>
		</next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="EmigratDataSet"/>
	</next:BottomBar>
</next:GridPanel>

</body>

</html>
