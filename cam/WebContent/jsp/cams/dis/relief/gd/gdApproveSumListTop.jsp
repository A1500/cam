<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
<head>
<title>过渡性生活补助-分析汇总</title>
<next:ScriptManager />
<script language="javascript">
	var organCode = '<%=BspUtil.getOrganCode()%>';
	var organName = '<%=BspUtil.getOrganName()%>';
	var ifApprove='<%=request.getParameter("ifApprove")%>';
	var batchId='<%=request.getParameter("batchId")%>';
	var batchDetailId='<%=request.getParameter("batchDetailId")%>';
</script>
<script type="text/javascript"
	src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript" src="../../comm/disComm.js"></script>
<script type="text/javascript" src="gdApproveSumListTop.js"></script>
</head>
<body>
<model:datasets>
	<!--批次明细-->
	<model:dataset id="batchDetailTitleds"
		cmd="com.inspur.cams.dis.base.cmd.DisReliefBatchDetailQueryCmd" global="true">
		<model:record
			fromBean="com.inspur.cams.dis.base.data.DisReliefBatchDetail">
		</model:record>
	</model:dataset>
	<!--批次明细-以乡镇为单位(单条)-->
	<model:dataset id="batchDetailds"
		cmd="com.inspur.cams.dis.base.cmd.DisReliefBatchDetailQueryCmd"
		method="queryBatchDetailSums" global="true">
		<model:record
			fromBean="com.inspur.cams.dis.base.data.DisReliefBatchDetail">
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
</model:datasets>
<next:Panel width="100%">
	<next:TopBar>
		<next:ToolBarItem id="qrToolbar"></next:ToolBarItem>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
	</next:TopBar>
	<next:Html>
		<fieldset>
		<form id="gdForm" method="post" dataset="batchDetailds"
			onsubmit="return false" class="L5form">
		<table border="0" width="100%" cellspacing="0" cellpadding="0">
			<tr>
				<td class="FieldLabel" style="width: 15%" nowrap>救助家庭人口数量:</td>
				<td class="FieldInput" style="width: 35%" colspan="3"><label
					field="FAMILY_NUM" /></td>
			</tr>
			<tr>
				<td class="FieldLabel" style="width: 15%" nowrap>核准救助口粮（公斤）:</td>
				<td class="FieldInput" style="width: 35%"><label
					field="APPROVAL_FOOD" renderer="formatMoneyForDis" /></td>
				<td class="FieldLabel" style="width: 15%" nowrap>人均核准救助口粮（公斤）:</td>
				<td class="FieldInput" style="width: 35%"><label
					field="APPROVAL_FOOD_AVG" renderer="formatMoneyForDis" /></td>
			</tr>
			<tr>
				<td class="FieldLabel" style="width: 15%" nowrap>核准救助衣被（件）:</td>
				<td class="FieldInput" style="width: 35%"><label
					field="APPROVAL_CLOTHES" /></td>
				<td class="FieldLabel" style="width: 15%" nowrap>人均核准救助衣被（件）:</td>
				<td class="FieldInput" style="width: 35%"><label
					field="APPROVAL_CLOTHES_AVG" renderer="formatMoneyForDis"/></td>
			</tr>
			<tr>
				<td class="FieldLabel" style="width: 15%" nowrap>核准救助资金（元）:</td>
				<td class="FieldInput" style="width: 35%"><label
					field="APPROVAL_MONEY" renderer="formatMoneyForDis" /></td>
				<td class="FieldLabel" style="width: 15%" nowrap>人均核准救助资金（元）:</td>
				<td class="FieldInput" style="width: 35%"><label
					field="APPROVAL_MONEY_AVG" renderer="formatMoneyForDis" /></td>
			</tr>
		</table>
		</form>
		</fieldset>
	</next:Html>
</next:Panel>
</body>
</html>
