<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
	<title>救助业务申请</title>
	<next:ScriptManager></next:ScriptManager>
	<script type="text/javascript" src="assistanceCheckList.js"></script>
</head>
<body>
<model:datasets>
	<model:dataset id="applyDataset" cmd="com.inspur.sdmz.apply.cmd.SamApplyQueryCmd" method="samapplyshQuery"  pageSize="10">
		<model:record fromBean="com.inspur.sdmz.apply.data.SamApply"></model:record>
		<model:params>
			<model:param name="APPLY_TYPE" value='1'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="applywayDataset" enumName="APPLY_WAY.TYPE"  autoLoad="true" global="true"></model:dataset>
</model:datasets>

<next:GridPanel id="applyGridPanel" name="applyGrid" dataset="applyDataset" notSelectFirstRow="true"  stripeRows="true" width="100%" height="450" title="->  您的位置 : 业务管理 >> 救助业务">
	
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem text="受理业务审核" iconCls="add" handler="ywsh" ></next:ToolBarItem>
		<next:ToolBarItem text="删除" iconCls="remove" handler="del"></next:ToolBarItem>
		
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn width="30"/>
		<next:CheckBoxColumn></next:CheckBoxColumn>
		<next:Column header="业务申请ID"  field="applyId" id="applyId" hidden="true"/>
		<next:Column header="申请人"  field="applyPeople" id="applyPeople" sortable="true"/>
		<next:Column header="家庭成员"  field="familyMember" id="familyMember"/>
		<next:Column header="申请日期"  field="applyDate" id="applyDate" sortable="true"/>
		<next:Column header="申请方式"  field="applyWay" id="applyWay" dataset="applywayDataset" sortable="true"/>
		<next:Column header="应办截止日期"  field="agendaDeadline" id="agendaDeadline" sortable="true"/>
		<next:Column header="最初受理单位"  field="acceptOrgName" id="acceptOrgName" sortable="true"/>
		<next:Column header="当前受理单位"  field="currentOrgName" id="currentOrgName" sortable="true"/>
		
		
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="applyDataset"></next:PagingToolBar>
	</next:BottomBar>
</next:GridPanel>
</body>
</html>
	