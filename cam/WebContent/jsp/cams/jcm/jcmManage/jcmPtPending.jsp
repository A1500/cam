<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>

<html>
<head>
<title>人员调动管理</title>
<next:ScriptManager></next:ScriptManager>

<script type="text/javascript" src="jcmPtPending.js">
</script>
</head>
<body>
<model:datasets>
	<!-- 人员调动管理 -->
	<model:dataset id="jcmPtPendingDataSet" cmd="com.inspur.cams.jcm.cmd.JcmPeopleTransferManageQueryCmd" pageSize="200">
		<model:record fromBean="com.inspur.cams.jcm.data.JcmPeopleTransferManage">
		</model:record>
	</model:dataset>
	<model:dataset id="jcmPeopleInfoDataSet" autoLoad="true" cmd="com.inspur.cams.jcm.cmd.JcmPeopleInfoQueryCmd" global="true" pageSize="20">
		<model:record fromBean="com.inspur.cams.jcm.data.JcmPeopleInfo"/>
	</model:dataset>
	<model:dataset id="jcmCompanyProfileDataSet" autoLoad="true" cmd="com.inspur.cams.jcm.cmd.JcmCompanyProfileQueryCmd" global="true" pageSize="20">
		<model:record fromBean="com.inspur.cams.jcm.data.JcmCompanyProfile"/>
	</model:dataset>
	<model:dataset id="jcmTransferStatus" enumName="JCM.TRANSFER_STATUS" autoLoad="true"></model:dataset>;
</model:datasets>
<next:Panel width="100%" border="0">
<next:TopBar>
	<next:ToolBarItem symbol="->"></next:ToolBarItem>
	<next:ToolBarItem iconCls="save" text="保存" handler="save"></next:ToolBarItem>
	<next:ToolBarItem iconCls="return" text="返回" handler="returnBack"/>
</next:TopBar>
<next:EditGridPanel id="grid" dataset="jcmPtPendingDataSet" width="100%" stripeRows="true" height="99.9%">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn></next:RowNumberColumn>
		<next:RadioBoxColumn></next:RadioBoxColumn>
		<next:Column field="transferPeopleId" header="被调动人" width="135" sortable="false">
			<next:ComboBox triggerAction="all" valueField="peopleId"
					displayField="peopleName" dataset="jcmPeopleInfoDataSet"></next:ComboBox>
		</next:Column>
		<next:Column field="fromDeptId" header="所在单位" width="135" sortable="false">
			<next:ComboBox triggerAction="all" valueField="companyId"
					displayField="companyName" dataset="jcmCompanyProfileDataSet"></next:ComboBox>
		</next:Column>
		<next:Column field="toDeptId" header="调往单位" width="135" sortable="false">
			<next:TextField></next:TextField>
		</next:Column>
		<next:Column field="transferType" header="调动类型" width="135" sortable="false">
			<next:TextField></next:TextField>
		</next:Column>
		<next:Column field="applyDate" header="申请时间" width="135" sortable="false">
			<next:TextField></next:TextField>
		</next:Column>
		<next:Column field="applyPeopleId" header="发起申请人" width="135" sortable="false">
			<next:TextField></next:TextField>
		</next:Column>
		<next:Column field="status" header="状态" width="135" sortable="false">
			<next:ComboBox  dataset="jcmTransferStatus" displayField="text" valueField="value" typeAble="false"/>
		</next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="jcmPtPendingDataSet"/>
	</next:BottomBar>
	
</next:EditGridPanel>
</next:Panel>
</body>
</html>