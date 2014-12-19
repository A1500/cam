<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
	<head>
		<title>在乡复员军人业务待办</title>
		<next:ScriptManager/>
		<script type="text/javascript" src="demobilizedPending.js"></script>
	</head>
<body>
<model:datasets>
	<!-- 未提交在乡复员军人 -->
	<model:dataset id="DemobilizedPeopleDataSet" cmd="com.inspur.cams.bpt.manage.cmd.BptPeopleDemobilizedQueryCommand" method="queryUnCimDemPeo" global="true">
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
	<model:dataset id="SexDataset"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_SEX'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	
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
	
</model:datasets>


<next:GridPanel id="editGridPanel" name="bptpetitionGrid"   stripeRows="true" width="100%" height="100%" dataset="DemobilizedPeopleDataSet">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem symbol="-" ></next:ToolBarItem>
		<next:ToolBarItem iconCls="add"  text="增加" handler="insert"/>
		<next:ToolBarItem symbol="-" ></next:ToolBarItem>
		<next:ToolBarItem iconCls="edit"  text="修改" handler="update"/>
		<next:ToolBarItem symbol="-" ></next:ToolBarItem>
		<next:ToolBarItem iconCls="view"  text="发起" handler="createAndSend"/>
		<next:ToolBarItem symbol="-" ></next:ToolBarItem>
	</next:TopBar>
	
	<next:Columns>
	    <next:RowNumberColumn header="序号" width="45"/>
	     <next:CheckBoxColumn></next:CheckBoxColumn>
	
		<next:Column id="name" header="姓名" field="NAME" width="60" >
			<next:TextField allowBlank="false" />
		</next:Column>
		
		<next:Column id="sex" header="性别" field="SEX" width="60" dataset="SexDataset">
			<next:TextField allowBlank="false" />
		</next:Column>
		
		<next:Column id="nation" header="民族" field="NATION" width="60" dataset="NationDataset" >
			<next:TextField allowBlank="false" />
		</next:Column>
	
		<next:Column id="idCard" header="身份证件号码" field="ID_CARD" width="150" >
			<next:TextField allowBlank="false" />
		</next:Column>
	
		<next:Column id="objectType" header="优抚对象类别" field="DEMOBILIZED_TYEP_CODE" width="130" dataset="ObjectTypeDataset">
			<next:TextField allowBlank="false" />
		</next:Column>
		
		<next:Column id="regTime" header="录入时间" field="REG_TIME" width="140" >
			<next:TextField allowBlank="false" />
		</next:Column>
		
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="DemobilizedPeopleDataSet" />
	</next:BottomBar>
</next:GridPanel>

</body>

</html>
