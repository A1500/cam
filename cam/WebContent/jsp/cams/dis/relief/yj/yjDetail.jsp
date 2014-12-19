<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
<head>
<title>应急生活救助明细</title>
<next:ScriptManager />
<script language="javascript">
	var organCode = '<%=BspUtil.getOrganCode()%>';
	var organName = '<%=BspUtil.getOrganName()%>';
	var method = '<%=request.getParameter("method")%>';
	var batchId='<%=request.getParameter("batchId")%>';
	var batchDetailId='<%=request.getParameter("batchDetailId")%>';
	var infoId='<%=request.getParameter("infoId")%>';
</script>
<script type="text/javascript"
	src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript" src="../../comm/disComm.js"></script>
<script type="text/javascript" src="yjDetail.js"></script>
</head>
<body>
<model:datasets>
	<!-- 批次信息 -->
	<model:dataset id="batchDs"
		cmd="com.inspur.cams.dis.base.cmd.DisReliefBatchQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.dis.base.data.DisReliefBatch">
		</model:record>
	</model:dataset>
	
	<!-- 档案信息 -->
	<model:dataset id="infoDs"
		cmd="com.inspur.cams.dis.base.cmd.DisReliefInfoQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.dis.base.data.DisReliefInfo">
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
	<!-- 灾害种类 -->
	<model:dataset id="DisDisasterType"
		enumName="DIS.DISASTER_TYPE" autoLoad="true" global="true">
	</model:dataset>
</model:datasets>
<next:Panel width="100%" height="100%" autoScroll="true">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="return" text="关闭" handler="back" />
	</next:TopBar>

	<next:Html>
		<fieldset>
		<form id="yjForm" method="post" dataset="infoDs"
			onsubmit="return false" class="L5form">
		<table border="0" width="100%" cellspacing="0" cellpadding="0">
			<tr>
				<td class="FieldLabel" style="width: 15%" nowrap>户主姓名:</td>
				<td class="FieldInput" style="width: 35%"><label field="name" /></td>
				<td class="FieldLabel" style="width: 15%" nowrap>身份证号码:</td>
				<td class="FieldInput" style="width: 35%"><label field="idCard"/></td>
			</tr>
			<tr>
				<td class="FieldLabel" style="width: 15%" nowrap>家庭人口（人）:</td>
				<td class="FieldInput" style="width: 35%"><label  field="familyNum"/></td>
				<td class="FieldLabel" style="width: 15%" nowrap>家庭类型:</td>
				<td class="FieldInput" style="width: 35%"><label field="familyType"  dataset="DisFamilyType"/></td>
			</tr>
			<tr>
				<td class="FieldLabel" style="width: 15%" nowrap>户口类型:</td>
				<td class="FieldInput" style="width: 35%"><label field="familyRegister" dataset="DisFamilyRegister" /></td>
				<td class="FieldLabel" style="width: 15%" nowrap>行政村（社区）:</td>
				<td class="FieldInput" style="width: 35%"><label field="acceptAreaName" /></td>
			</tr>
			
			<tr>
				<td class="FieldLabel" style="width: 15%" nowrap>需口粮救助（公斤）:</td>
				<td class="FieldInput" style="width: 35%"><label field="requiredForFood" /></td>
				<td class="FieldLabel" style="width: 15%" nowrap>需取暖救助（元）:</td>
				<td class="FieldInput" style="width: 35%"><label field="requiredForHeat" /></td>
			</tr>
			<tr>
				<td class="FieldLabel" style="width: 15%" nowrap>需衣被救助（件）:</td>
				<td class="FieldInput" style="width: 35%"><label field="requiredForClothes" /></td>
				<td class="FieldLabel" style="width: 15%" nowrap>需伤病救助（元）:</td>
				<td class="FieldInput" style="width: 35%"><label field="requiredForDisease" /></td>
			</tr>
			<tr>
				<td class="FieldLabel" style="width: 15%" nowrap>需其他救助（元）:</td>
				<td class="FieldInput" style="width: 35%"><label field="requiredForOthers" /></td>
				<td class="FieldLabel" style="width: 15%" nowrap>需饮水救助（元）:</td>
				<td class="FieldInput" style="width: 35%"><label field="requiredForWater" />
				</td>
			</tr>
			<tr>
				<td class="FieldLabel" style="width: 15%" nowrap>核准救助口粮（公斤）:</td>
				<td class="FieldInput" style="width: 35%"><label field="approvalFood" /></td>
				<td class="FieldLabel" style="width: 15%" nowrap>核准救助饮水（元）:</td>
				<td class="FieldInput" style="width: 35%"><label field="approvalWater" /></td>
			</tr>
			<tr>
				<td class="FieldLabel" style="width: 15%" nowrap>核准救助衣被（件）:</td>
				<td class="FieldInput" style="width: 35%"><label field="approvalClothes" /></td>
				<td class="FieldLabel" style="width: 15%" nowrap>核准救助金额（元）:</td>
				<td class="FieldInput" style="width: 35%"><label field="approvalMoney" /></td>
			</tr>
			<tr>
				<td class="FieldLabel" style="width: 15%" nowrap>发放单位:</td>
				<td class="FieldInput" style="width: 35%"><label field="grantType" dataset="DisGrantType"/></td>
				<td class="FieldLabel" style="width: 15%" nowrap>发放方式:</td>
				<td class="FieldInput" style="width: 35%"><label field="allocationType" dataset="DisAllocationType"/></td>
			</tr>
			<tr id="yhTr">
				<td class="FieldLabel" style="width: 15%" nowrap>开户银行:</td>
				<td class="FieldInput" style="width: 35%"><label field="bank"/></td>
				<td class="FieldLabel" style="width: 15%" nowrap>开户银行帐号:</td>
				<td class="FieldInput" style="width: 35%"><label field="accountCode"/></td>
			</tr>
			<tr id="yhTr2">
				<td class="FieldLabel" style="width: 15%" nowrap>开户银行地址:</td>
				<td class="FieldInput" style="width: 35%"  colspan="3"><label field="bankAdds"/></td>
			</tr>
			<tr>
				<td class="FieldLabel" style="width: 15%" nowrap>村级填报人姓名:</td>
				<td class="FieldInput" style="width: 35%"><label field="acceptPeopleName"/></td>
				<td class="FieldLabel" style="width: 15%" nowrap>村级填报日期:</td>
				<td class="FieldInput" style="width: 35%"><label field="acceptDate" /></td>
			</tr>
			<tr>
				<td class="FieldLabel" style="width: 15%" nowrap>备注:</td>
				<td class="FieldInput" style="width: 35%" colspan="3" rowspan="2">
				<textarea name="note" field="note" title="备注" style="width: 71.5%" disabled="disabled"></textarea></td>
			</tr>
		</table>
		</form>
		</fieldset>
	</next:Html>
</next:Panel>
</body>
</html>
