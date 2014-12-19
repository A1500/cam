<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<script type="text/javascript">
   var organCode = '<%=BspUtil.getOrganCode()%>'; 
   var organType = '<%=BspUtil.getOrganType()%>';
</script>
<html>
	<head>
		<title>部分烈士（错杀被平反人员）子女未提交人员列表</title>
		<next:ScriptManager/>
		<script type="text/javascript" src="martyrOffspringPenDing.js"></script>
	</head>
<body> 
<model:datasets>
	<!-- 未提交部分烈士（错杀被平反人员）子女 -->
	<model:dataset id="MartyrOffspringDataSet" cmd="com.inspur.cams.bpt.manage.cmd.BptApplyMartyrOffspringQueryCommand" method="queryUnCommitRecord" global="true">
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
	<!-- 身份类别 -->
	<model:dataset id="StatusTypeEnum" enumName="STATUS.TYPE" autoLoad="true" global="true"></model:dataset>
</model:datasets>
<next:GridPanel id="editGridPanel" name="bptMartyrOffspringGrid" clickToSelectedForChkSM="true" notSelectFirstRow="true" stripeRows="true" width="100%" height="100%" dataset="MartyrOffspringDataSet">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem symbol="-" ></next:ToolBarItem>
		<next:ToolBarItem iconCls="add"  id="add_button"  text="增加" handler="insert"/>
		<next:ToolBarItem symbol="-" ></next:ToolBarItem>
		<next:ToolBarItem iconCls="edit"  id="update_button"  text="修改" handler="update"/>
		<next:ToolBarItem symbol="-" ></next:ToolBarItem>
		<next:ToolBarItem text="查看" id="detail_button"  iconCls="detail" handler="detail"/>
		<next:ToolBarItem symbol="-" ></next:ToolBarItem>
		<next:ToolBarItem text="删除" id="del_button"  iconCls="delete" handler="del"/>
		<next:ToolBarItem symbol="-" ></next:ToolBarItem>
		<next:ToolBarItem text="审批" iconCls="view" id="submitButton" handler="sure" />
		<next:ToolBarItem symbol="-" ></next:ToolBarItem>
		<next:ToolBarItem text="批量审批" iconCls="view" id="bthSmtBtn" handler="batchSend" />
		<next:ToolBarItem symbol="-" ></next:ToolBarItem>
	</next:TopBar>
	<next:Columns>
	    <next:RowNumberColumn header="序号" width="45"/>
	     <next:CheckBoxColumn></next:CheckBoxColumn>
	    <next:Column id="fullName" header="属地行政区划" field="FULL_NAME" width="180">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="name" header="姓名" field="NAME" width="60" >
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="sex" header="性别" field="SEX" width="60" dataset="SexDataset">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="nation" header="民族" field="NATION" width="60"  dataset="NationDataset">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="idCard" header="身份证件号码" field="ID_CARD" width="135" >
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="age" header="年龄" field="AGE" width="90" align="right">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="statusType" header="身份类别" field="STATUS_TYPE" width="180" align="center" dataset="StatusTypeEnum">
			<next:TextField/>
		</next:Column>
		<next:Column id="sacrificeDate" header="牺牲时间" field="SACRIFICE_DATE" width="120" align="center">
			<next:TextField/>
		</next:Column>
		<next:Column id="lezswAppr" header="批准烈士（平反）时间" field="LEZSW_APPROVE_DATE" width="160" align="right">
			<next:TextField/>
		</next:Column>
	</next:Columns>
	<next:BottomBar> 
		<next:PagingToolBar dataset="MartyrOffspringDataSet"/>
	</next:BottomBar>
</next:GridPanel>
</body>
</html>
