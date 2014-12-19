<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
	<title>用户信息查询</title>
	<next:ScriptManager></next:ScriptManager>
	<script type="text/javascript" src="complaintCheckList.js"></script>
</head>
<body>
<model:datasets>
<model:dataset id="applywayDataset" enumName="APPLY_WAY.TYPE"  autoLoad="true" global="true"></model:dataset>
<model:dataset id="complaintDataset" cmd="com.inspur.sdmz.apply.cmd.SamApplyQueryCmd" method="samapplyshQuery" pageSize="10">
	<model:record fromBean="com.inspur.sdmz.apply.data.SamApply"></model:record>
	<model:params>
			<model:param name="APPLY_TYPE" value='2'></model:param>
	</model:params>
</model:dataset>
</model:datasets>
<next:GridPanel id="complaintGridPanel" name="complaintGrid" dataset="complaintDataset" notSelectFirstRow="true" stripeRows="true" width="100%" height="450" title="->  您的位置 : 业务管理 >> 投诉业务">>
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem text="受理业务审核" iconCls="add" handler="ywsh" ></next:ToolBarItem>
		<next:ToolBarItem text="删除" iconCls="remove" handler="del"></next:ToolBarItem>
	
		
	</next:TopBar>
	<next:Columns>
	    <next:RowNumberColumn />
	    <next:CheckBoxColumn></next:CheckBoxColumn>
		<next:Column header="投诉人" field="applyPeople"  sortable="true">
			<next:TextField allowBlank="false"/>
		</next:Column>
		
		<next:Column header="被投诉人" id="complaintedOrg" field="complaintedOrg" >
			<next:TextField allowBlank="false" />
		</next:Column>
		
		<next:Column header="投诉日期" id="applyDate" field="applyDate"  sortable="true">
			<next:TextField allowBlank="false" />
		</next:Column>
		
		<next:Column header="投诉方式" id="applyWay" dataset="applywayDataset" field="applyWay"  sortable="true">
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column header="应办截止日期" field="agendaDeadline"  sortable="true">
			<next:TextField allowBlank="false"/>
		</next:Column>
		
		<next:Column header="最初受理单位" id="acceptOrgName" field="acceptOrgName"  sortable="true">
			<next:TextField allowBlank="false" />
		</next:Column>
		
		<next:Column header="当前办理单位" id="acceptOrgName" field="acceptOrgName"  sortable="true">
			<next:TextField allowBlank="false" />
		</next:Column>
		
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="complaintDataset"></next:PagingToolBar>
	</next:BottomBar>
</next:GridPanel>
</body>
</html>
	