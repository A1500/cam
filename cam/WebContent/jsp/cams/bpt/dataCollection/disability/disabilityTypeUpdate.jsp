<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<html>
<head>
<title>伤残人员信息</title>
<next:ScriptManager />
<script>
			var peopleId=<%=request.getParameter("peopleId")%>;
		</script>
<script type="text/javascript"
	src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript" src="disabilityTypeUpdate.js"></script>
<script type="text/javascript" src="../comm/bptComm.js"></script>
</head>
<body>
<model:datasets>

	<!-- 伤残信息 -->
	<model:dataset id="BptPeopleDisabilityDataSet"
		cmd="com.inspur.cams.bpt.manage.cmd.BptPeopleDisabilityQueryCommand"
		method="queryPeopleDisabilityInfo" global="true">
		<model:record
			fromBean="com.inspur.cams.bpt.base.data.BptPeopleDisability">
			<model:field name="disabilityTypeCode" type="string" rule="require" />
			<model:field name="insanityFlag" type="string" rule="require" />
			<model:field name="oldLonelyFlag" type="string" rule="require" />
			<model:field name="toWorkDate" type="string" />
			<model:field name="retiredDate" type="string" />
			<!--model:field name="orphanFlag" type="string" rule="require" /-->
			<model:field name="workAbilityCode" type="string" rule="require" />
			<model:field name="workAbilityDescribe" type="string" />
			<model:field name="viabilityCode" type="string" rule="require" />
			<model:field name="supportPattern" type="string" rule="require" />
			<model:field name="jobStatusDescribe" type="string" />
			<model:field name="bank" type="string" />
			<model:field name="accountName" type="string" />
			<model:field name="accountCode" type="string" />
			<model:field name="disabilityStateCode" type="string" rule="require"
				rule="require" />
			<model:field name="disabilityNo" type="string" rule="require"
				rule="require" />
		</model:record>
	</model:dataset>

	<!-- 开户银行代码 -->
	<model:dataset id="BankEnum" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_BANK'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>

	<!-- 是否精神病标志 -->
	<model:dataset id="InsanityFlagEnum" enumName="COMM.YESORNO"
		autoLoad="true" global="true"></model:dataset>

	<!-- 孤老标志 -->
	<model:dataset id="OldLonelyFlagEnum" enumName="COMM.YESORNO"
		autoLoad="true" global="true"></model:dataset>

	<!-- 孤儿标志 -->
	<model:dataset id="OrphanFlagEnum" enumName="COMM.YESORNO"
		autoLoad="true" global="true"></model:dataset>

	<!-- 劳动能力代码 -->
	<model:dataset id="WorkAbilityCodeEnum" enumName="WORK.ABILITY.CODE"
		autoLoad="true" global="true"></model:dataset>

	<!-- 优抚生活能力代码 -->
	<model:dataset id="ViabilityCodeEnum" enumName="VIABILITY.CODE"
		autoLoad="true" global="true"></model:dataset>

	<!-- 优抚供养方式 -->
	<model:dataset id="SupportPatternEnum" enumName="SUPPORT.PATTERN"
		autoLoad="true" global="true"></model:dataset>

	<!-- 伤残类别代码 -->
	<model:dataset id="DisabilityTypeCodeEnum"
		enumName="DISABILITY.TYPE.CODE" autoLoad="true" global="true"></model:dataset>

	<!-- 伤残业务类型 -->
	<model:dataset id="ServiceTypeDataSet"
		enumName="DISABILITY.SERVICE.TYPE" autoLoad="true" global="true"></model:dataset>

	<!-- 优抚对象状态 -->
	<model:dataset id="ObjectStateDataset" enumName="OBJECT.STATE"
		autoLoad="true" global="true"></model:dataset>

	<!-- 伤残性质 -->
	<model:dataset id="DisabilityCaseDataset" enumName="CASE.CODE"
		autoLoad="true" global="true"></model:dataset>
	<!-- 伤残等级 -->
	<model:dataset id="DisabilityLevelDataset" enumName="LEVEL.CODE"
		autoLoad="true" global="true"></model:dataset>
	<!-- 伤残属别 -->
	<model:dataset id="DisabilityGenusDataset" enumName="GENUS.CODE"
		autoLoad="true" global="true"></model:dataset>
	<!-- 伤残时期 -->
	<model:dataset id="BptWarDataset" enumName="WAR.CODE" autoLoad="true"
		global="true"></model:dataset>
<!-- 是否抗美援朝 -->
	<model:dataset id="isKoreaWarDataset" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
</model:datasets>

<next:Panel height="100%" autoScroll="true" width="100%">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="save" text="保存" handler="save" />
		<next:ToolBarItem iconCls="disable" text="关闭" handler="func_Close" />
	</next:TopBar>
	<next:Html>
		<fieldset>
		<form id="BptPeopleDisabilityForm" method="post"
			dataset="BptPeopleDisabilityDataSet" onsubmit="return false"
			style="padding: 5px;" class="L5form">
		<table border="1" width="98%">
			<tr>
				<td class="FieldLabel">伤残类别：</td>
				<td class="FieldInput"><select name="disabilityTypeCode"
					field="disabilityTypeCode" title="伤残类别"
					onchange="fun_DisabilityType()">
					<option dataset="DisabilityTypeCodeEnum"></option>
				</select><font color="red">*</font></td>
				<td class="FieldLabel">伤残等级：</td>
				<td class="FieldInput"><select name="disabilityLevelCode"
					field="disabilityLevelCode" title="伤残等级" onchange="fun_Level()">
					<option dataset="DisabilityLevelDataset"></option>
				</select><font color="red">*</font></td>
				<td class="FieldLabel">伤残性质：</td>
				<td class="FieldInput"><select name="disabilityCaseCode"
					field="disabilityCaseCode" title="伤残性质">
					<option dataset="DisabilityCaseDataset"></option>
				</select><font color="red">*</font></td>
			</tr>
			<tr>
				<td class="FieldLabel">优抚对象状态：</td>
				<td class="FieldInput"><select name="disabilityStateCode"
					field="disabilityStateCode" title="优抚对象状态">
					<option dataset="ObjectStateDataset"></option>
				</select><font color="red">*</font></td>

				<td class="FieldLabel">证书编号：</td>
				<td class="FieldInput"><input type="text" name="disabilityNo"
					field="disabilityNo" title="证书编号" maxlength="8"/><font color="red">*</font></td>

				<td class="FieldLabel">批准日期：</td>
				<td class="FieldInput"><input type="text" title="批准日期"
					name="approveDate" field="approveDate" format="Y-m-d"maxlength="10"style="width: 100px;"  onpropertychange="changeDateStyle(this)" 
					 /><img  src="../../../../../skins/images/default/rl.gif" align="middle" onclick="getTimes(this)" ><font color="red">*</font></td>
			</tr>

			<tr>
				<td class="FieldLabel" nowrap="nowrap">入伍(参加工作)时间：</td>
				<td class="FieldInput"><input format="Y-m-d"
					 type="text" name="relationshipType"
					field="conscriptDate"maxlength="10"style="width: 100px;"  onpropertychange="changeDateStyle(this)" 
					title="入伍(参加工作)时间" /><img  src="../../../../../skins/images/default/rl.gif" align="middle" onclick="getTimes(this)" ></td>

				<td class="FieldLabel" nowrap="nowrap">退伍时间：</td>
				<td class="FieldInput"><input format="Y-m-d"
					 type="text" name="veteransDate"maxlength="10"style="width: 100px;"
					field="veteransDate"  onpropertychange="changeDateStyle(this)" 
					title="退伍时间" /><img  src="../../../../../skins/images/default/rl.gif" align="middle" onclick="getTimes(this)" ></td>
				<td class="FieldLabel" nowrap="nowrap">离退休时间：</td>
				<td class="FieldInput"><input format="Y-m-d"
					 type="text" id="retiredDate" name="retiredDate"maxlength="10"style="width: 100px;"  onpropertychange="changeDateStyle(this)" 
					field="retiredDate" title="离退休时间" /><img  src="../../../../../skins/images/default/rl.gif" align="middle" onclick="getTimes(this)" ></td>
			</tr>

			<tr>


				<td class="FieldLabel">伤残时期：</td>
				<td class="FieldInput"><select name="disabilityWarCode" onchange="KoreaWar(this)"
					field="disabilityWarCode" title="伤残时期">
					<option dataset="BptWarDataset"></option>
				</select><font color="red">*</font></td>
				<td class="FieldLabel" id="k1">是否抗美援朝：</td>
				<td class="FieldInput" id="k2"><select id="isKoreaWar" 
					name="isKoreaWar" field="isKoreaWar" title="伤残时期">
					<option dataset="isKoreaWarDataset"></option>
				</select></td>
				<td class="FieldLabel">伤残属别：</td>
				<td class="FieldInput" colspan="3"><select
					name="disabilityGenusCode" field="disabilityGenusCode" title="伤残属别">
					<option dataset="DisabilityGenusDataset"></option>
				</select><font color="red">*</font></td>
			</tr>

			<tr>
				<td class="FieldLabel">致残时间：</td>
				<td class="FieldInput"><input format="Y-m-d" type="text" name="disabilityDate"maxlength="10"style="width: 100px;"  onpropertychange="changeDateStyle(this)" 
					field="disabilityDate" title="致残时间" /><img  src="../../../../../skins/images/default/rl.gif" align="middle" onclick="getTimes(this)" ><font color="red">*</font></td>
				<td class="FieldLabel" nowrap="nowrap">致残时所在单位：</td>
				<td class="FieldInput" colspan="3"><input type="text"
					name="uinitOfDisability" field="uinitOfDisability" title="致残时所在单位"
					style="width: 86%" /></td>

			</tr>

			<tr>
				<td class="FieldLabel">致残地点：</td>
				<td class="FieldInput" colspan="5"><input type="text"
					name="disabilityAdd" field="disabilityAdd" style="width: 92%"
					title="致残地点" /><font color="red">*</font></td>
			</tr>

			<tr>
				<td class="FieldLabel">致残情况：</td>
				<td class="FieldInput" colspan="5"><input type="text"
					name="disabilityBody" field="disabilityBody" style="width: 92%"
					title="致残情况" /><font color="red">*</font></td>
			</tr>

			<tr>
				<td class="FieldLabel">致残原因：</td>
				<td class="FieldInput" colspan="5"><textarea rows="2"
					name="disabilityReason" field="disabilityReason" style="width: 92%"
					title="致残原因"></textarea><font color="red">*</font></td>
			</tr>
			<tr>
				<td class="FieldLabel">是否孤老：</td>
				<td class="FieldInput"><select name="oldLonelyFlag"
					field="oldLonelyFlag" title="是否孤老">
					<option dataset="OldLonelyFlagEnum"></option>
				</select><font color="red">*</font></td>
				
				<!--td class="FieldLabel">是否孤儿：</td>
				<td class="FieldInput"><select name="orphanFlag"
					field="orphanFlag" title="是否孤儿">
					<option dataset="OldLonelyFlagEnum"></option>
				</select></td-->
				
				<td class="FieldLabel">是否精神病：</td>
				<td class="FieldInput" colspan="3"><select name="insanityFlag"
					field="insanityFlag" title="是否精神病">
					<option dataset="InsanityFlagEnum"></option>
				</select><font color="red">*</font></td>
			</tr>

			<tr>
				<td class="FieldLabel">劳动能力：</td>
				<td class="FieldInput"><select name="workAbilityCode"
					field="workAbilityCode" title="劳动能力">
					<option dataset="WorkAbilityCodeEnum"></option>
				</select><font color="red">*</font></td>
			
				<td class="FieldLabel">生活能力：</td>
				<td class="FieldInput"><select name="viabilityCode"
					id="viabilityCode" field="viabilityCode" title="生活能力">
					<option dataset="ViabilityCodeEnum"></option>
				</select><font color="red">*</font></td>

				<td class="FieldLabel" nowrap="nowrap">供养方式：</td>
				<td class="FieldInput"><select
					name="supportPattern" field="supportPattern" title="供养方式">
					<option dataset="SupportPatternEnum"></option>
				</select><font color="red">*</font></td>

			</tr>

			<tr>
				<td class="FieldLabel">开户银行：</td>
				<td class="FieldInput"><select name="bank" field="bank" title="开户银行">
					<option dataset="BankEnum"></option>
				</select><font color="red">*</font></td>
				<td class="FieldLabel">开户名称：</td>
				<td class="FieldInput"><input type="text" name="accountName"
					field="accountName" title="开户名称"/><font color="red">*</font></td>

				<td class="FieldLabel">银行账号：</td>
				<td class="FieldInput"><input type="text" name="accountCode"
					field="accountCode" title="银行帐号" style="width: 90%"></input><font color="red">*</font></td>
			</tr>

			<tr>
				<td class="FieldLabel">备注(类别信息)：</td>
				<td class="FieldInput" colspan="5"><textarea rows="3"
					name="note" field="note" title="备注(类别信息)" style="width: 90%"></textarea></td>
			</tr>
		</table>
		</form>
		</fieldset>
	</next:Html>
</next:Panel>
</body>
</html>
