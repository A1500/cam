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
		<title>三属定期抚恤申请审批</title>
		<next:ScriptManager/>
		<script type="text/javascript" src="dependantPenDing.js"></script>
	</head>
<body> 
<model:datasets>
	<!-- 未提交伤残人员 -->
	<model:dataset id="BptPeopleDependantDataSet" cmd="com.inspur.cams.bpt.manage.cmd.BptPeopleDependantQueryCommand" method="queryUncommitDependant" global="true">
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
<next:GridPanel id="editGridPanel" name="bptpeopledependantGrid" clickToSelectedForChkSM="true" stripeRows="true" width="100%" height="100%" dataset="BptPeopleDependantDataSet">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem symbol="-" ></next:ToolBarItem>
		<next:ToolBarItem iconCls="add"  id="add_button"  text="增加" handler="insert"/>
		<next:ToolBarItem symbol="-" ></next:ToolBarItem>
		<next:ToolBarItem iconCls="edit"  id="update_button"  text="修改" handler="update"/>
		<next:ToolBarItem symbol="-" ></next:ToolBarItem>
		<next:ToolBarItem text="查看" id="detail_button"  iconCls="detail" handler="detail"/>
		<next:ToolBarItem symbol="-" ></next:ToolBarItem>
		<next:ToolBarItem text="删除"  id="del_button" iconCls="delete" handler="del"/>
		<next:ToolBarItem symbol="-" ></next:ToolBarItem>
		<next:ToolBarItem text="审批" id="submitButton" iconCls="view" handler="sure" />
		<next:ToolBarItem symbol="-" ></next:ToolBarItem>
		<next:ToolBarItem text="批量审批" id="bthSmtBtn" iconCls="view" handler="batchSend" />
		<next:ToolBarItem symbol="-" ></next:ToolBarItem>
		
	<%--	<% 
			String[] roleId = BspUtil.getRoleId();
			for(int i=0;i<roleId.length;i++){
		   		if("898bd7306e4f8301306e8a3bb8001e".equals(roleId[i])){
		%>
				 <next:ToolBarItem iconCls="view"  text="发起" handler="createAndSend"/> -->
				 <next:ToolBarItem symbol="-" ></next:ToolBarItem> 
		<% 		
			}
			}
		%> --%>
	</next:TopBar>
	
	<next:Columns>
	    <next:RowNumberColumn header="序号" width="45"/>
	     <next:CheckBoxColumn></next:CheckBoxColumn>
	     
	    <next:Column id="domicileCode" header="属地行政区划" field="DICNAME" width="140">
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
		
		<next:Column id="disabilityStateCode" header="优抚对象类别" field="DEPENDANT_TYPE_CODE" width="90" dataset="ObjectTypeDataset">
			<next:TextField allowBlank="false" />
		</next:Column>
		
		<next:Column id="lezswName" header="烈士姓名" field="LEZSW_NAME" width="90">
			<next:TextField  />
		</next:Column>
		
		<next:Column id="lezswName" header="烈士性别" field="LEZSW_SEX" width="90" dataset="SexDataset">
			<next:TextField  /> 
		</next:Column>
		
		<next:Column id="lezswApproveDate" header="烈士批准时间" field="LEZSW_APPROVE_DATE" width="90">
			<next:TextField  />
		</next:Column>
		<next:Column id="regTime" header="录入时间" field="REG_TIME" width="140" >
			<next:TextField  allowBlank="false"/>  
		</next:Column>
		
	</next:Columns>
	<next:BottomBar> 
		<next:PagingToolBar dataset="BptPeopleDependantDataSet" />
	</next:BottomBar>
</next:GridPanel>

</body>

</html>
