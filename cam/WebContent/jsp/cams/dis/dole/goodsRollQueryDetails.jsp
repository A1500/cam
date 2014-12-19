<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
<head>
<title>救助档案物资发放流水明细</title>
<next:ScriptManager />
<script language="javascript">
	var organCode = '<%=BspUtil.getOrganCode()%>';
	var organName = '<%=BspUtil.getOrganName()%>';
	var batchId='<%=request.getParameter("batchId")%>';
	var batchDetailId='<%=request.getParameter("batchDetailId")%>';
	var reliefType='<%=request.getParameter("reliefType")%>';
</script>
<script type="text/javascript"
	src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript" src="../comm/disComm.js"></script>
<script type="text/javascript" src="goodsRollQueryDetails.js"></script>
</head>
<body>
<model:datasets>
	<!--发放流水-->
	<model:dataset id="disReliefDoleDs"
		cmd="com.inspur.cams.dis.base.cmd.DisReliefDoleQueryCmd" global="true" pageAble="false"
		sortField="FILL_TIME DESC,DOLE_ID">
		<model:record fromBean="com.inspur.cams.dis.base.data.DisReliefDole">
		</model:record>
	</model:dataset>

	<!-- 家庭类型 -->
	<model:dataset id="DisFamilyType" enumName="DIS.FAMILY_TYPE"
		autoLoad="true" global="true">
	</model:dataset>
	<!-- 房屋结构 -->
	<model:dataset id="DisHouseStructure" enumName="DIS.HOUSE_STRUCTURE"
		autoLoad="true" global="true">
	</model:dataset>
	<!-- 发放方式 -->
	<model:dataset id="DisAllocationType"
		enumName="DIS.INFO_ALLOCATION_TYPE" autoLoad="true" global="true">
	</model:dataset>
	<!-- 户口类型 -->
	<model:dataset id="DisFamilyRegister" enumName="DIS.FAMILY_REGISTER"
		autoLoad="true" global="true">
	</model:dataset>
	<!-- 发放单位  -->
	<model:dataset id="DisGrantType" enumName="DIS.GRANT_TYPE"
		autoLoad="true" global="true">
	</model:dataset>
	<!--填报状态-->
	<model:dataset id="fillstateDs" enumName="DIS.BATCHDETAIL_FILL_STATE"
		autoLoad="true" global="true">
	</model:dataset>
	<!-- 是否 -->
	<model:dataset id="commYesOrNoDS" enumName="COMM.YESORNO"
		autoLoad="true" global="true">
	</model:dataset>
	<!-- 发放类型 -->
	<model:dataset id="doleTypeDS" enumName="DIS.DOLE_TYPE"
		autoLoad="true" global="true">
	</model:dataset>
</model:datasets>
<next:Panel id="mainPanel" width="100%" height="200">
	<next:Html>
		<iframe id="mainFrame" name="mainFrame" frameborder="no" border="0"
			marginwidth="0" marginheight="0" scrolling="yes"
			allowtransparency="yes" width="100%" height="100%"> </iframe>
	</next:Html>
</next:Panel>
<next:GridPanel id="doleGrid" name="doleGrid" width="100%"
	clickToSelectedForChkSM="true" stripeRows="true" height="100%"
	dataset="disReliefDoleDs" notSelectFirstRow="true">
	<next:TopBar>
		<next:ToolBarItem text="发放流水列表"></next:ToolBarItem>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="明细" iconCls="detail" handler="detailInfo"/>
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn width="40" header="序号" />
		<next:RadioBoxColumn></next:RadioBoxColumn>
		<next:Column id="fillTime" header="发放时间" field="fillTime" width="80"></next:Column>
		<next:Column id="doleType" header="发放类型" field="doleType" width="80"
			align="center" renderer="doleTypeRenderer"></next:Column>
		<next:Column id="amount" header="发放资金金额(元)" field="amount" width="130"
			align="right" hidden="true"></next:Column>
		<next:Column id="fillPeopleName" header="发放人" field="fillPeopleName"
			width="100"></next:Column>
		<next:Column id="inConfirm" header="是否确认" field="inConfirm" width="70"
			align="center" dataset="commYesOrNoDS"></next:Column>
		<next:Column id="note" header="备注" field="note" width="220"></next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="disReliefDoleDs" />
	</next:BottomBar>
</next:GridPanel>
</body>
</html>
