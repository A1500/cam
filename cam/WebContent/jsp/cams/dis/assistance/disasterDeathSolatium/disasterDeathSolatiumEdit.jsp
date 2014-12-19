<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<html>
<head>
<title>因灾死亡人员家庭抚慰金发放</title>
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
<script type="text/javascript" src="disasterDeathSolatiumEdit.js"></script>
<script type="text/javascript" src="../../comm/disComm.js"></script>
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
	<!-- 灾害种类 -->
	<model:dataset id="DisDisasterType" enumName="DIS.DISASTER_TYPE"
		autoLoad="true" global="true">
	</model:dataset>
	<!-- 家庭类型 -->
	<model:dataset id="DisFamilyType" enumName="DIS.FAMILY_TYPE"
		autoLoad="true" global="true">
	</model:dataset>
	<!-- 死者性别 -->
	<model:dataset id="CommSex" enumName="COMM.SEX" autoLoad="true"
		global="true">
	</model:dataset>
	<!-- 死者民族 -->
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
	</next:TopBar>
	<next:TabPanel>
		<next:Tabs>
			<next:Panel id="familyInfo" title="家庭信息" width="100%" height="100%">
				<next:Html>
					<fieldset>
					<form id="disasterDeathSolatiumFamilyForm" method="post"
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
							<td class="FieldLabel" style="width: 15%" nowrap>户主身份证号码:</td>
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
					<form id="disasterDeathSolatiumReliefForm" method="post"
						dataset="reliefDs" onsubmit="return false" style="padding: 5px;"
						class="L5form">
					<table border="0" width="100%" cellspacing="0" cellpadding="0">
						<input type="hidden" name="infoId" field="infoId" />
						<tr>
							<td class="FieldLabel" style="width: 15%" nowrap>行政村:</td>
							<td class="FieldInput" style="width: 35%" colspan="3"><input
								type="text" id="acceptAreaName" field="acceptAreaName"
								readonly="readonly" style="width: 68.3%" title="行政村" /> <input
								type="hidden" id="acceptAreaCode" name="acceptAreaCode"
								field="acceptAreaCode" title="行政村" /> <img
								src="<%=SkinUtils.getImage(request,"l5/help.gif")%>"
								style="cursor: hand" onclick="forOrganSelect()" /></td>
						</tr>
						<tr>
							<td class="FieldLabel" style="width: 15%" nowrap>死者（失踪）姓名:</td>
							<td class="FieldInput" style="width: 35%"><input type="text"
								id="deadName" name="deadName" field="deadName" title="死者姓名"
								maxlength="20" /> <font color="red">*</font></td>
							<td class="FieldLabel" style="width: 15%" nowrap>死者（失踪）性别:</td>
							<td class="FieldInput" style="width: 35%"><select
								name="deadSex" id="deadSex" field="deadSex" title="死者性别">
								<option dataset="CommSex"></option>
							</select> <font color="red">*</font></td>
						</tr>
						<tr>
							<td class="FieldLabel" style="width: 15%" nowrap>死者（失踪）年龄:</td>
							<td class="FieldInput" style="width: 35%"><input type="text"
								id="deadAge" name="deadAge" field="deadAge" title="死者年龄"
								maxlength="3" /> <font color="red">*</font></td>
							<td class="FieldLabel" style="width: 15%" nowrap>死者（失踪）民族:</td>
							<td class="FieldInput" style="width: 35%"><select
								name="deadFolk" id="deadFolk" field="deadFolk" title="死者民族">
								<option dataset="NationDataset"></option>
							</select> <font color="red">*</font></td>
						</tr>
						<tr>
							<td class="FieldLabel" style="width: 15%" nowrap>死者（失踪）户口所在地:</td>
							<td class="FieldInput" style="width: 35%"><input type="text"
								id="deadPopulace" name="deadPopulace" field="deadPopulace"
								title="死者户口所在地" /> <font color="red">*</font></td>
							<td class="FieldLabel" style="width: 15%" nowrap>死亡（失踪）时间:</td>
							<td class="FieldInput" style="width: 35%"><input type="text"
								id="deadMissingTime" name="deadMissingTime"
								field="deadMissingTime" title="死亡（失踪）时间" format="Y-m-d H:i"
								maxlength="19" style="width: 25%" /><img
								src="../../../../../skins/images/default/rl.gif" align="middle"
								onclick="getTimes19(this)" /> <font color="red">*</font></td>
						</tr>
						<tr>
							<td class="FieldLabel" style="width: 15%" nowrap>死亡（失踪）地点:</td>
							<td class="FieldInput" style="width: 35%"><input type="text"
								id="deadMissingPlace" name="deadMissingPlace"
								field="deadMissingPlace" title="死亡（失踪）地点" /> <font color="red">*</font>
							</td>
							<td class="FieldLabel" style="width: 15%" nowrap>死亡（失踪）原因:</td>
							<td class="FieldInput" style="width: 35%"><input type="text"
								id="deadMissingReason" name="deadMissingReason"
								field="deadMissingReason" title="死亡（失踪）原因" /> <font color="red">*</font>
							</td>
						</tr>
						<tr>
							<td class="FieldLabel" style="width: 15%" nowrap>灾害种类:</td>
							<td class="FieldInput" style="width: 35%"><select
								id="disasterType" name="disasterType" field="disasterType"
								title="灾害种类">
								<option dataset="DisDisasterType"></option>
							</select> <font color="red">*</font></td>
							<td class="FieldLabel" style="width: 15%" nowrap>核准救助资金（元）:</td>
							<td class="FieldInput" style="width: 35%"><input type="text"
								name="approvalMonry" field="approvalMonry" title="核准救助资金（元）" />
							</td>
						</tr>
						<tr>
							<td class="FieldLabel" style="width: 15%" nowrap>发放单位类型:</td>
							<td class="FieldInput" style="width: 35%" colspan="3"><select id="grantType"
								name="grantType" field="grantType" title="发放单位类型">
								<option dataset="DisGrantType"></option>
							</select></td>
						</tr>
						<tr>
							<td class="FieldLabel" style="width: 15%" nowrap>资金发放类型:</td>
							<td class="FieldInput" style="width: 35%"><select
								name="allocationType" field="allocationType" title="资金发放类型">
								<option dataset="DisAllocationType"></option>
							</select></td>
							<td class="FieldLabel" style="width: 15%" nowrap>开户银行:</td>
							<td class="FieldInput" style="width: 35%"><input type="text"
								name="bank" field="bank" title="开户银行" /></td>
						</tr>
						<tr>
							<td class="FieldLabel" style="width: 15%" nowrap>开户银行帐号:</td>
							<td class="FieldInput" style="width: 35%"><input type="text"
								name="accountCode" field="accountCode" title="开户银行帐号" /></td>
							<td class="FieldLabel" style="width: 15%" nowrap>开户银行地址:</td>
							<td class="FieldInput" style="width: 35%" colspan="3"><input
								type="text" name="bankAdds" field="bankAdds" title="开户银行地址"
								style="width: 71.5%" /></td>
						</tr>
						<tr>
							<td class="FieldLabel" style="width: 15%" nowrap>村级填报人姓名:</td>
							<td class="FieldInput" style="width: 35%"><input type="text"
								name="acceptPeopleName" field="acceptPeopleName" title="村级填报人姓名" />
							</td>
							<td class="FieldLabel" style="width: 15%" nowrap>村级填报日期:</td>
							<td class="FieldInput" style="width: 35%"><input type="text"
								id="acceptDate" name="acceptDate" format="Y-m-d"
								field="acceptDate" maxlength="10"
								onpropertychange="changeDateStyle(this)" title="村级填报日期"
								style="width: 25%" /><img
								src="../../../../../skins/images/default/rl.gif" align="middle"
								onclick="getTimes(this)" /></td>
						</tr>
						<tr>
							<td class="FieldLabel" style="width: 15%" nowrap>备注:</td>
							<td class="FieldInput" style="width: 35%" colspan="3" rowspan="2"><textarea
								name="note" field="note" title="备注" style="width: 71.5%"></textarea>
							</td>
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
