<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
<head>
<title>应急生活救助</title>
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
<script type="text/javascript" src="yjEdit.js"></script>
</head>
<body>
<model:datasets>
	<!-- 批次信息 -->
	<model:dataset id="batchDs"
		cmd="com.inspur.cams.dis.base.cmd.DisReliefBatchQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.dis.base.data.DisReliefBatch">
		</model:record>
	</model:dataset>
	<!-- 批次明细信息 -->
	<model:dataset id="batchDetailDs"
		cmd="com.inspur.cams.dis.base.cmd.DisReliefBatchDetailQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.dis.base.data.DisReliefBatchDetail">
		</model:record>
	</model:dataset>
	
	<!-- 档案信息 -->
	<model:dataset id="infoDs"
		cmd="com.inspur.cams.dis.base.cmd.DisReliefInfoQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.dis.base.data.DisReliefInfo">
			<model:field name="name" type="string" rule="require"></model:field>
			<model:field name="idCard" type="string" rule="require"></model:field>
			<model:field name="familyNum" type="string" rule="require"></model:field>
			<model:field name="familyType" type="string" rule="require"></model:field>
			<model:field name="familyRegister" type="string" rule="require"></model:field>
			<model:field name="acceptAreaCode" type="string" rule="require"></model:field>
			
			<model:field name="approvalMoney" type="float" rule="require"></model:field>
			
			<model:field name="approvalFood" type="float" rule="require"></model:field>
			<model:field name="approvalClothes" type="float" rule="require"></model:field>
			<model:field name="approvalWater" type="float" rule="require"></model:field>
			<model:field name="acceptPeopleName" type="string" rule="require"></model:field>
			<model:field name="acceptDate" type="string" rule="require"></model:field>
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
	<!-- 灾害种类 -->
	<model:dataset id="DisDisasterType"
		enumName="DIS.DISASTER_TYPE" autoLoad="true" global="true">
	</model:dataset>
	<!-- 户口类型 -->
	<model:dataset id="DisFamilyRegister" enumName="DIS.FAMILY_REGISTER"
		autoLoad="true" global="true">
	</model:dataset>
	<!-- 发放单位  -->
	<model:dataset id="DisGrantType" enumName="DIS.GRANT_TYPE"
		autoLoad="true" global="true">
	</model:dataset>
</model:datasets>
<next:Panel width="100%" height="100%">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="save" text="保存" handler="saveClick" />
		<next:ToolBarItem id="conBtn" iconCls="save" text="保存并继续"
			handler="saveClickContinue" />
	</next:TopBar>

	<next:Html>
		<fieldset>
		<form id="yjForm" method="post" dataset="infoDs"
			onsubmit="return false" class="L5form">
		<table border="0" width="100%" cellspacing="0" cellpadding="0">
			<tr>
				<td class="FieldLabel" style="width: 15%" nowrap>户主姓名:</td>
				<td class="FieldInput" style="width: 35%"><input type="text"
					id="name" name="name" field="name" title="户主姓名" maxlength="20" 
					onchange="checkCN('name','户主姓名');"/>
				<font color="red">*</font></td>
				<td class="FieldLabel" style="width: 15%" nowrap>身份证号码:</td>
				<td class="FieldInput" style="width: 35%"><input type="text"
					id="idCard" name="idCard" field="idCard" title="身份证号码"
					maxlength="18" style="width: 200px" onchange="CheckIdCardMessage()"/>
				<font color="red">*</font></td>
			</tr>
			<tr>
				<td class="FieldLabel" style="width: 15%" nowrap>家庭人口（人）:</td>
				<td class="FieldInput" style="width: 35%"><input type="text"
					id="familyNum" name="familyNum" field="familyNum" title="家庭人口（人）"
					maxlength="2" onchange="CheckTxt('familyNum','家庭人口');"/>
					<font color="red">*</font></td>
				<td class="FieldLabel" style="width: 15%" nowrap>家庭类型:</td>
				<td class="FieldInput" style="width: 35%"><select
					id="familyType" name="familyType" field="familyType" title="家庭类型">
					<option dataset="DisFamilyType"></option>
				</select> <font color="red">*</font></td>
			</tr>
			<tr>
				<td class="FieldLabel" style="width: 15%" nowrap>户口类型:</td>
				<td class="FieldInput" style="width: 35%"><select
					name="familyRegister" id="familyRegister" field="familyRegister"
					title="户口类型">
					<option dataset="DisFamilyRegister"></option>
				</select> <font color="red">*</font></td>
				<td class="FieldLabel" style="width: 15%" nowrap>行政村（社区）:</td>
				<td class="FieldInput" style="width: 35%"><input type="text"
					id="acceptAreaName" field="acceptAreaName" readonly="true"
					style="width: 200" title="行政村（社区）" /> <input type="hidden"
					id="acceptAreaCode" name="acceptAreaCode" field="acceptAreaCode"
					title="行政村（社区）" /> <img
					src="<%=SkinUtils.getImage(request,"l5/help.gif")%>"
					style="cursor: hand" onclick="forOrganSelect()" /><font
					color="red">*</font></td>
			</tr>
			
			<tr>
				<td class="FieldLabel" style="width: 15%" nowrap>需口粮救助（公斤）:</td>
				<td class="FieldInput" style="width: 35%"><input type="text"
					id="requiredForFood" name="requiredForFood" field="requiredForFood"
					title="需口粮救助（公斤）" onblur="appFood(this)" 
					onchange="CheckTxt('requiredForFood','需口粮救助');"/></td>
				<td class="FieldLabel" style="width: 15%" nowrap>需取暖救助（元）:</td>
				<td class="FieldInput" style="width: 35%"><input type="text"
					id="requiredForHeat" name="requiredForHeat" field="requiredForHeat"
					title="需取暖救助（元）" onblur="appMon()" 
					onchange="CheckTxt('requiredForHeat','需取暖救助');"/></td>
			</tr>
			<tr>
				<td class="FieldLabel" style="width: 15%" nowrap>需衣被救助（件）:</td>
				<td class="FieldInput" style="width: 35%"><input type="text"
					id="requiredForClothes" name="requiredForClothes"
					field="requiredForClothes" title="需衣被救助（件）"
					onblur="appClothes(this)" onchange="CheckTxt('requiredForClothes','需衣被救助');"/></td>
				<td class="FieldLabel" style="width: 15%" nowrap>需伤病救助（元）:</td>
				<td class="FieldInput" style="width: 35%"><input type="text"
					id="requiredForDisease" name="requiredForDisease"
					field="requiredForDisease" title="需伤病救助（元）" onblur="appMon()" 
					onchange="CheckTxt('requiredForDisease','需伤病救助');"/></td>
			</tr>
			<tr>
				<td class="FieldLabel" style="width: 15%" nowrap>需其他救助（元）:</td>
				<td class="FieldInput" style="width: 35%"><input type="text"
					id="requiredForOthers" name="requiredForOthers"
					field="requiredForOthers" title="需其他救助（元）" onblur="appMon()" 
					onchange="CheckTxt('requiredForOthers','需其他救助');"/></td>
				<td class="FieldLabel" style="width: 15%" nowrap>需饮水救助（元）:</td>
				<td class="FieldInput" style="width: 35%"><input type="text"
					id="requiredForWater" name="requiredForWater"
					field="requiredForWater" title="需饮水救助（元）" onblur="appWater(this);appMon()" 
					onchange="CheckTxt('requiredForWater','需饮水救助');"/>
				</td>
			</tr>
		
			<tr>
				<td class="FieldLabel" style="width: 15%" nowrap>核准救助口粮（公斤）:</td>
				<td class="FieldInput" style="width: 35%"><input type="text"
					id="approvalFood" name="approvalFood" field="approvalFood"
					title="核准救助口粮（公斤）" onchange="CheckTxt('approvalFood','核准救助口粮');"/>
					<font color="red">*</font></td>
				<td class="FieldLabel" style="width: 15%" nowrap>核准救助饮水（元）:</td>
				<td class="FieldInput" style="width: 35%"><input type="text"
					id="approvalWater" name="approvalWater" field="approvalWater"
					title="核准救助饮水（元）" onchange="CheckTxt('approvalWater','核准救助饮水');"/>
					<font color="red">*</font></td>
			</tr>
			<tr>
				<td class="FieldLabel" style="width: 15%" nowrap>核准救助衣被（件）:</td>
				<td class="FieldInput" style="width: 35%"><input type="text"
					id="approvalClothes" name="approvalClothes" field="approvalClothes"
					title="核准救助衣被（件）" onchange="CheckTxt('approvalClothes','核准救助衣被');"/>
					<font color="red">*</font></td>
				<td class="FieldLabel" style="width: 15%" nowrap>核准救助金额（元）:</td>
				<td class="FieldInput" style="width: 35%"><input type="text"
					id="approvalMoney" name="approvalMoney" field="approvalMoney"
					title="核准救助金额（元）" onchange="CheckTxt('approvalMoney','核准救助金额');"/>
					<font color="red">*</font></td>
			</tr>
			<tr>
				<td class="FieldLabel" style="width: 15%" nowrap>发放单位:</td>
				<td class="FieldInput" style="width: 35%"><select id="grantType"
					name="grantType" field="grantType" title="发放单位" disabled="disabled">
					<option dataset="DisGrantType"></option>
				</select></td>
				<td class="FieldLabel" style="width: 15%" nowrap>发放方式:</td>
				<td class="FieldInput" style="width: 35%"><select
					id="allocationType" name="allocationType" field="allocationType"
					title="发放方式" disabled="disabled">
					<option dataset="DisAllocationType"></option>
				</select> <font color="red">*</font></td>
			</tr>
			<tr id="yhTr">
				<td class="FieldLabel" style="width: 15%" nowrap>开户银行:</td>
				<td class="FieldInput" style="width: 35%"><input type="text"
					name="bank" field="bank" title="开户银行" /></td>
				<td class="FieldLabel" style="width: 15%" nowrap>开户银行帐号:</td>
				<td class="FieldInput" style="width: 35%"><input type="text"
					name="accountCode" field="accountCode" title="开户银行帐号" /></td>
			</tr>
			<tr id="yhTr2">
				<td class="FieldLabel" style="width: 15%" nowrap>开户银行地址:</td>
				<td class="FieldInput" style="width: 35%" colspan="3"><input
					type="text" name="bankAdds" field="bankAdds" title="开户银行地址"
					style="width: 71.5%" /></td>
			</tr>
			<tr>
				<td class="FieldLabel" style="width: 15%" nowrap>村级填报人姓名:</td>
				<td class="FieldInput" style="width: 35%"><input type="text"
					id="acceptPeopleName" name="acceptPeopleName" 
					field="acceptPeopleName" title="村级填报人姓名" 
					onchange="checkCN('acceptPeopleName','村级填报人姓名');"/>
				<font color="red">*</font></td>
				<td class="FieldLabel" style="width: 15%" nowrap>村级填报日期:</td>
				<td class="FieldInput" style="width: 35%"><input type="text"
					name="acceptDate" field="acceptDate" title="村级填报日期"
					format="Y-m-d" maxlength="10"
					onpropertychange="changeDateStyle(this)" style="width: 25%" /><img
					src="../../../../../skins/images/default/rl.gif" align="middle"
					onclick="getTimes(this)" /><font color="red">*</font></td>
			</tr>
			<tr>
				<td class="FieldLabel" style="width: 15%" nowrap>备注:</td>
				<td class="FieldInput" style="width: 35%" colspan="3" rowspan="2">
				<textarea name="note" field="note" title="备注"
					style="width: 71.5%"></textarea></td>
			</tr>
		</table>
		</form>
		</fieldset>
	</next:Html>
</next:Panel>
</body>
</html>
