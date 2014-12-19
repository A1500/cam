<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.extuser.util.ExtBspInfo"%>
<html>
<head>
<title>任务查询</title>
<next:ScriptManager></next:ScriptManager>
<%
String username = ExtBspInfo.getUserInfo(request).getUserName();
String peopleId= ExtBspInfo.getUserInfo(request).getUserId();
String peopleArea= ExtBspInfo.getUserInfo(request).getAreaCode();
%>
<script language="javascript">

</script>
<script type="text/javascript" src="welfarecorpList.js"></script>
<script language="javascript" type="text/javascript">
var username='<%=username%>';
var peopleArea='<%=peopleArea%>';
</script>
</head>
<body>
<model:datasets>
	<!-- 待办业务表 -->
	<model:dataset id="daiBanDataset" cmd="com.inspur.cams.welfare.welfarecorp.apply.cmd.UnitApplyQueryCmd" method="queryQualificationList">
		<model:record fromBean="com.inspur.cams.welfare.base.data.WealUnitApply"></model:record>
	</model:dataset>
	<!-- 业务信息表 -->
	<model:dataset id="wealUnitInfoDataSet" cmd="com.inspur.cams.welfare.base.cmd.WealUnitInfoQueryCommand" >
		<model:record fromBean="com.inspur.cams.welfare.base.data.WealUnitInfo">
		<model:field name="companyName" type="string" rule="require" />	
		<model:field name="legalPeople" type="string" rule="require" />
		<model:field name="regDate" type="string" rule="require" />
		</model:record>
	</model:dataset>
	<!-- apply表 -->
	<model:dataset id="ApplyDataset" cmd="com.inspur.cams.welfare.base.cmd.WealUnitApplyQueryCommand">
		<model:record fromBean="com.inspur.cams.welfare.base.data.WealUnitApply"></model:record>
	</model:dataset>
	<!-- 职工信息表 -->
	<model:dataset id="wealWorkerDataSet" cmd="com.inspur.cams.welfare.base.cmd.WealWorkerQueryCommand" pageSize="100">
		<model:record fromBean="com.inspur.cams.welfare.base.data.WealWorker"></model:record>
		<model:params>
			<model:param name="CERT_CODE@<>" value=''></model:param>
		</model:params>
	</model:dataset>
	
	<!-- 基本意见 -->
	<model:dataset id="wealApplyStauts" enumName="WEAL.APPLY_STAUTS" autoLoad="true" global="true"></model:dataset>
</model:datasets>
<next:ViewPort>
	<next:TabPanel width="100%" height="100%">
		<next:Tabs>
				<next:GridPanel id="daiBanTaskGridPanel" name="daiBanTaskGridPanel" width="100%" height="100%" dataset="daiBanDataset" title="资格认定任务列表" notSelectFirstRow="true">
					<next:TopBar>
						<next:ToolBarItem symbol="->"></next:ToolBarItem>			
						<next:ToolBarItem iconCls="add"  text="新增" handler="add"/>
						<next:ToolBarItem iconCls="edit"  text="修改" handler="edit"/>
						<next:ToolBarItem iconCls="remove"  text="删除" handler="del"/>
						<next:ToolBarItem iconCls="detail"  text="明细" handler="detailDaiban"/>
						<next:ToolBarItem iconCls="select"  text="提交" handler="submit"/>
					</next:TopBar>
					<next:Columns>
						<next:RowNumberColumn width="30"/>
						<next:RadioBoxColumn></next:RadioBoxColumn>
						<next:Column id="TASK_CODE" header="业务编码" field="TASK_CODE" hidden="true"></next:Column>	
						<next:Column id="COMPANY_NAME" header="企业名称" field="COMPANY_NAME" width="15%" ></next:Column>
						<next:Column id="DATA_SOURCE" header="数据来源" field="DATA_SOURCE" hidden="true" ></next:Column>
						<next:Column id="APPLY_STAUTS" header="业务状态" field="APPLY_STAUTS" renderer="statusRenderer"></next:Column>
						<next:Column id="REG_DATE" header="填表时间" field="REG_DATE" width="15%" ></next:Column>
					</next:Columns>
					<next:BottomBar>
						<next:PagingToolBar dataset="daiBanDataset"/>
					</next:BottomBar>
				</next:GridPanel>
		</next:Tabs>
	</next:TabPanel>
</next:ViewPort>

</body>
</html>