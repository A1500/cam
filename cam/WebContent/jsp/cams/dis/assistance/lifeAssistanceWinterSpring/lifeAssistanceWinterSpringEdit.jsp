<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="org.loushang.next.data.Record"%>
<html>
<head>
<title>冬春生活救助</title>
<next:ScriptManager />
<script>
	var organName = '<%=BspUtil.getOrganName()%>';
	var organCode = '<%=BspUtil.getOrganCode()%>';
	var method = '<%=request.getParameter("method")%>';
	var cx_infoId = '<%=request.getParameter("cx_infoId")%>';
	var cx_recordId = '<%=request.getParameter("cx_recordId")%>';
	var batchDetailId='<%=request.getParameter("batchDetailId")%>';
</script>
<script type="text/javascript"
	src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript" src="../../comm/disComm.js"><</script>
<script type="text/javascript" src="lifeAssistanceWinterSpringEdit.js"></script>
</head>
<body>
<model:datasets>
	<model:dataset id="familyDs"
		cmd="com.inspur.cams.dis.base.cmd.DisBaseFamilyRecordQueryCommand"
		global="true">
		<model:record
			fromBean="com.inspur.cams.dis.base.data.DisBaseFamilyRecord">
			<model:field name="organName" type="string"></model:field>
		</model:record>
	</model:dataset>
	<model:dataset id="reliefDs"
		cmd="com.inspur.cams.dis.base.cmd.DisReliefInfoQueryCommand"
		global="true">
		<model:record fromBean="com.inspur.cams.dis.base.data.DisReliefInfo">
		</model:record>
	</model:dataset>
	<!-- 身份证回填ds -->
	<model:dataset id="idCardFamilyDs"
		cmd="com.inspur.cams.dis.base.cmd.DisBaseFamilyRecordQueryCommand"
		method="loadIdCardMessage" global="true">
		<model:record
			fromBean="com.inspur.cams.dis.base.data.DisBaseFamilyRecord">
			<model:field name="NAME"></model:field>
			<model:field name="ID_CARD"></model:field>
			<model:field name="FAMILY_NUM"></model:field>
			<model:field name="FAMILY_TYPE"></model:field>
			<model:field name="FAMILY_REGISTER"></model:field>
			<model:field name="HOUSE_COUNT"></model:field>
			<model:field name="HOUSE_STRUCTURE"></model:field>
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
	<!-- 资金发放类型 -->
	<model:dataset id="DisAllocationType"
		enumName="DIS.INFO_ALLOCATION_TYPE" autoLoad="true" global="true">
	</model:dataset>
	<!-- 户口所在地 -->
	<model:dataset id="DisFamilyRegister" enumName="DIS.FAMILY_REGISTER"
		autoLoad="true" global="true">
	</model:dataset>
	<!-- 发放部门  -->
	<model:dataset id="DisGrantType" enumName="DIS.GRANT_TYPE"
		autoLoad="true" global="true">
	</model:dataset>
</model:datasets>
<next:Panel width="100%" height="100%">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="save" text="保存" handler="saveClick" />
		<next:ToolBarItem id="conBtn" iconCls="save" text="保存并继续" handler="saveClickContinue" />
	</next:TopBar>
	<next:TabPanel id="tabPanel">
		<next:Tabs>
			<next:Panel id="familyInfo" title="家庭信息" width="100%" height="100%">
				<next:Html>
					<fieldset>
					<form id="lifeAssistanceWinterSpringFamilyForm" method="post"
						dataset="familyDs" onsubmit="return false" style="padding: 5px;"
						class="L5form">
					<table border="0" width="100%">
						<input type="hidden" name="recordId" field="recordId" />
						<input type="hidden" name="organCode" field="organCode" />
						<input type="hidden" name="townCode" field="townCode" />
						<input type="hidden" id="villiageCode" name="villiageCode"
							field="villiageCode" title="行政村" />
						<tr>
							<td class="FieldLabel" style="width: 15%" nowrap>户主姓名:</td>
							<td class="FieldInput" style="width: 35%"><input type="text"
								id="name" name="name" field="name" title="户主姓名" maxlength="20" />
							<font color="red">*</font></td>
							<td class="FieldLabel" style="width: 15%" nowrap>身份证号码:</td>
							<td class="FieldInput" style="width: 35%"><input type="text"
								id="idCard" name="idCard" field="idCard" title="身份证号码"
								maxlength="18" onchange="loadIdCardMessage()" /> <font
								color="red">*</font></td>
						</tr>
						<tr>
							<td class="FieldLabel" style="width: 15%" nowrap>家庭人口（人）:</td>
							<td class="FieldInput" style="width: 35%"><input type="text"
								id="familyNum" name="familyNum" field="familyNum"
								title="家庭人口（人）" maxlength="2" /> <font color="red">*</font></td>
							<td class="FieldLabel" style="width: 15%" nowrap>家庭类型:</td>
							<td class="FieldInput" style="width: 35%"><select
								id="familyType" name="familyType" field="familyType"
								title="家庭类型">
								<option dataset="DisFamilyType"></option>
							</select> <font color="red">*</font></td>
						</tr>
						<tr>
							<td class="FieldLabel" style="width: 15%" nowrap>户口所在地:</td>
							<td class="FieldInput" style="width: 35%" colspan="3"><select
								name="familyRegister" id="familyRegister" field="familyRegister"
								title="户口所在地">
								<option dataset="DisFamilyRegister"></option>
							</select> <font color="red">*</font></td>
						</tr>
					</table>
					</form>
					</fieldset>
				</next:Html>
			</next:Panel>

			<next:Panel id="reliefInfo" title="救助信息" width="100%" height="100%">
				<next:Html>
					<fieldset>
					<form id="lifeAssistanceWinterSpringReliefForm" method="post"
						dataset="reliefDs" onsubmit="return false" style="padding: 5px;"
						class="L5form">
					<table border="0" width="100%" cellspacing="0" cellpadding="0">
						<input type="hidden" name="infoId" field="infoId" />
						<tr>
							<td class="FieldLabel" style="width: 15%" nowrap>行政村:</td>
							<td class="FieldInput" style="width: 35%" colspan="3"><input
								type="text" id="acceptAreaName" field="acceptAreaName"
								readonly="true" style="width: 68.3%" title="行政村" /> <input
								type="hidden" id="acceptAreaCode" name="acceptAreaCode"
								field="acceptAreaCode" title="行政村" /> <img
								src="<%=SkinUtils.getImage(request,"l5/help.gif")%>"
								style="cursor: hand" onclick="forOrganSelect()" /></td>
						</tr>
						<tr>
							<td class="FieldLabel" style="width: 15%" nowrap>需口粮救助（公斤）:</td>
							<td class="FieldInput" style="width: 35%"><input type="text"
								id="requiredForFood" name="requiredForFood"
								field="requiredForFood" title="需口粮救助（公斤）" onblur="appFood(this)" />
							</td>
							<td class="FieldLabel" style="width: 15%" nowrap>需取暖救助（元）:</td>
							<td class="FieldInput" style="width: 35%"><input type="text"
								id="requiredForHeat" name="requiredForHeat"
								field="requiredForHeat" title="需取暖救助（元）" onblur="appMon()" /></td>
						</tr>
						<tr>
							<td class="FieldLabel" style="width: 15%" nowrap>需衣被救助（件）:</td>
							<td class="FieldInput" style="width: 35%"><input type="text"
								id="requiredForClothes" name="requiredForClothes"
								field="requiredForClothes" title="需衣被救助（件）"
								onblur="appClothes(this)" /></td>
							<td class="FieldLabel" style="width: 15%" nowrap>需伤病救助（元）:</td>
							<td class="FieldInput" style="width: 35%"><input type="text"
								id="requiredForDisease" name="requiredForDisease"
								field="requiredForDisease" title="需伤病救助（元）" onblur="appMon()" />
							</td>
						</tr>
						<tr>
							<td class="FieldLabel" style="width: 15%" nowrap>需其他救助（元）:</td>
							<td class="FieldInput" style="width: 35%"><input type="text"
								id="requiredForOthers" name="requiredForOthers"
								field="requiredForOthers" title="需其他救助（元）" onblur="appMon()" />
							</td>
							<td class="FieldLabel" style="width: 15%" nowrap>需饮水救助（元）:</td>
							<td class="FieldInput" style="width: 35%"><input type="text"
								id="requiredForWater" name="requiredForWater"
								field="requiredForWater" title="需饮水救助（元）"  />
							</td>
						</tr>
						<tr>
							<td class="FieldLabel" style="width: 15%" nowrap>核准救助时段（月）:</td>
							<td class="FieldInput" style="width: 35%"><input type="text"
								name="approvalTimes" field="approvalTimes" title="核准救助时段" /></td>
							<td class="FieldLabel" style="width: 15%" nowrap>核准救助口粮（公斤）:</td>
							<td class="FieldInput" style="width: 35%"><input type="text"
								id="approvalFood" name="approvalFood" field="approvalFood"
								title="核准救助口粮（公斤）" /></td>
						</tr>
						<tr>
							<td class="FieldLabel" style="width: 15%" nowrap>核准救助衣被（件）:</td>
							<td class="FieldInput" style="width: 35%"><input type="text"
								id="approvalClothes" name="approvalClothes"
								field="approvalClothes" title="核准救助衣被（件）" /></td>
							<td class="FieldLabel" style="width: 15%" nowrap>核准救助金额（元）:</td>
							<td class="FieldInput" style="width: 35%"><input type="text"
								id="approvalMonry" name="approvalMonry" field="approvalMonry"
								title="核准救助金额（元）" /></td>
						</tr>
						<tr>
							<td class="FieldLabel" style="width: 15%" nowrap>发放单位类型:</td>
							<td class="FieldInput" style="width: 35%"><select id="grantType"
								name="grantType" field="grantType" title="发放单位类型">
								<option dataset="DisGrantType"></option>
							</select><font color="red">*</font></td>
							<td class="FieldLabel" style="width: 15%" nowrap>资金发放类型:</td>
							<td class="FieldInput" style="width: 35%"><select 
								id="allocationType" name="allocationType" field="allocationType"
								title="资金发放类型">
								<option dataset="DisAllocationType"></option>
							</select> <font color="red">*</font></td>
						</tr>
						<tr>
							<td class="FieldLabel" style="width: 15%" nowrap>开户银行:</td>
							<td class="FieldInput" style="width: 35%"><input type="text"
								name="bank" field="bank" title="开户银行" /></td>
							<td class="FieldLabel" style="width: 15%" nowrap>开户银行帐号:</td>
							<td class="FieldInput" style="width: 35%"><input type="text"
								name="accountCode" field="accountCode" title="开户银行帐号" style="width: 220px"/></td>
						</tr>
						<tr>
							<td class="FieldLabel" style="width: 15%" nowrap>开户银行地址:</td>
							<td class="FieldInput" style="width: 35%" colspan="3"><input type="text"
								name="bankAdds" field="bankAdds" title="开户银行地址" style="width: 80%"/></td>
						</tr>
						<tr>
							<td class="FieldLabel" style="width: 15%" nowrap>村级填报人姓名:</td>
							<td class="FieldInput" style="width: 35%"><input type="text"
								name="acceptPeopleName" field="acceptPeopleName" title="村级填报人姓名" />
							</td>
							<td class="FieldLabel" style="width: 15%" nowrap>村级填报日期:</td>
							<td class="FieldInput" style="width: 35%"><input type="text"
								name="acceptDate" field="acceptDate" title="村级填报日期"
								format="Y-m-d" maxlength="10"
								onpropertychange="changeDateStyle(this)" style="width: 25%" /><img
								src="../../../../../skins/images/default/rl.gif" align="middle"
								onclick="getTimes(this)" /></td>
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

		</next:Tabs>
	</next:TabPanel>
</next:Panel>

</body>
</html>
