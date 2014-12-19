<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<title>参战人员信息</title>
<next:ScriptManager />
		<script>
			var peopleId='<%=request.getParameter("peopleId")%>';
		</script>
<script type="text/javascript" src="bptwarUpdate.js"></script>
<script type="text/javascript" src="../comm/bptComm.js"> </script>
</head>
<body>
<model:datasets>
	<!-- 参战人员信息 -->
	<model:dataset id="dsWar"
		cmd="com.inspur.cams.bpt.manage.cmd.BptPeopleWarQueryCommand"
		global="true" method="queryPeopleWarInfo">
		<model:record fromBean="com.inspur.cams.bpt.base.data.BptPeopleWar">
			<model:field name="warNo" type="string"/>
			<model:field name="insanityFlag" type="string" rule="require"/>
			<model:field name="oldLonelyFlag" type="string" rule="require"/>
			<model:field name="workAbilityCode" type="string" rule="require"/>
			<model:field name="viabilityCode" type="string" rule="require"/>
			<model:field name="supportPattern" type="string" rule="require"/>
			<model:field name="bank" type="string" />
			<model:field name="accountName" type="string" />
			<model:field name="accountCode" type="string" />
			<model:field name="warStateCode" type="string" />
		</model:record>
	</model:dataset>
	<!--生活状况代码-->
	<model:dataset id="dsLife" enumName="LIFE.LIFE_STATE_CODE"
		autoLoad="true"></model:dataset>
	<!-- 开户银行代码 -->
	<model:dataset id="BankEnum" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_BANK'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>

	<!--参战类别代码-->
	<model:dataset id="dsWarData" enumName="WARTYPE.CODE" autoLoad="true" global="true"></model:dataset>
	<!-- 优抚对象状态 -->
	<model:dataset id="ObjectStateDataset" enumName="OBJECT.STATE"
		autoLoad="true" global="true"></model:dataset>
	<!-- 优抚供养方式 -->
	<model:dataset id="SupportPatternEnum" enumName="SUPPORT.PATTERN"
		autoLoad="true" global="true"></model:dataset>
	<!-- 孤老标志 -->
	<model:dataset id="OldLonelyFlagEnum" enumName="COMM.YESORNO"
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
	<!-- 健康状况 -->
	<model:dataset id="HealthDataset" enumName="HEALTH.TYPE"
		autoLoad="true" global="true"></model:dataset>
	<!-- 是否精神病标志 -->
	<model:dataset id="InsanityFlagEnum" enumName="COMM.YESORNO"
		autoLoad="true" global="true"></model:dataset>
</model:datasets>
<next:Panel title="参战基本信息" height="100%" width="100%" autoScroll="true">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="save" text="保存" handler="save" />
		<next:ToolBarItem iconCls="disable" text="关闭" handler="func_Close"/>
	</next:TopBar>
	<next:Html>
		<form id="editForm" dataset="dsWar" onsubmit="return false"
			style="padding: 5px;" class="L5form">
		<table border="0" width="100%" align="left">
			<tr>
				<td class="FieldLabel" nowrap>优抚对象状态：</td>
				<td class="FieldInput"><label name="warStateCode" field="warStateCode" title="优抚对象状态" dataset="ObjectStateDataset" /></td>
				<td class="FieldLabel" nowrap>生活补助证编号：</td>
				<td class="FieldInput"><label name="warNo" field="warNo" title="生活补助证编号"></label></td>
				<td class="FieldLabel" nowrap>批准日期：</td>
				<td class="FieldInput"><label name="approvalDate"style="width: 100px;" field="approvalDate"/></td>
			</tr>
			<tr>
				<td class="FieldLabel" nowrap>入伍（参加工作）时间：</td>
				<td class="FieldInput"><input type="text" name="conscriptcDate"
					title="入伍时间" field="conscriptcDate" format="Y-m-d"style="width: 100px;"onpropertychange="changeDateStyle(this)"
					maxlength="10" title="入伍(参加)时间"/><img  src="../../../../skins/images/default/rl.gif" align="middle"  onclick="getTimes(this)"  ><font color="red">*</font></td>
				<td class="FieldLabel" nowrap>退伍时间：</td>
				<td class="FieldInput"><input type="text"
					name="decruitmentDate" title="退伍时间" field="decruitmentDate"style="width: 100px;"onpropertychange="changeDateStyle(this)"
					format="Y-m-d" maxlength="10" /><img  src="../../../../skins/images/default/rl.gif" align="middle"  onclick="getTimes(this)"  ><font color="red">*</font></td>

				<td class="FieldLabel" nowrap>离退休时间：</td>
				<td class="FieldInput"><input type="text" name="retiredDate"
					title="离退休时间" field="retiredDate" format="Y-m-d"style="width: 100px;"onpropertychange="changeDateStyle(this)"
					maxlength="10" /><img  src="../../../../skins/images/default/rl.gif" align="middle"  onclick="getTimes(this)"  ></td>
			</tr>
			<tr>
				<td class="FieldLabel" nowrap>退伍证号：</td>
				<td class="FieldInput"><input type="text" name="asdpNo"
					field="asdpNo" title="退伍证号" /></td>

				<td class="FieldLabel" nowrap>原部队代号：</td>
				<td class="FieldInput"><input type="text" name="forcesNo"
					field="forcesNo" title="原部队代号" onblur="func_blur()"/></td>

				<td class="FieldLabel" nowrap>职务（级别）：</td>
				<td class="FieldInput"><input type="text" name="position"
					field="position" title="职务(级别)"/></td>
			</tr>

			<tr>
				<td class="FieldLabel" nowrap>参战类别：</td>
				<td class="FieldInput"><select style="width: 120px;"
					id="warTypeCode" field="warTypeCode" title="参战类别">
					<option dataset="dsWarData"></option>
				</select><font color="red">*</font></td>

				<td class="FieldLabel" nowrap>是否孤老：</td>
				<td class="FieldInput"><select name="oldLonelyFlag"
					field="oldLonelyFlag" title="是否孤老">
					<option dataset="OldLonelyFlagEnum"></option>
				</select><font color="red">*</font></td>

				<td class="FieldLabel" nowrap>是否精神病：</td>
				<td class="FieldInput"><select name="insanityFlag"
					field="insanityFlag" title="是否精神病">
					<option dataset="InsanityFlagEnum"></option>
				</select><font color="red">*</font></td>
			</tr>
			<tr>
				<td class="FieldLabel" nowrap>劳动能力：</td>
				<td class="FieldInput"><select name="workAbilityCode"
					field="workAbilityCode" title="劳动能力">
					<option dataset="WorkAbilityCodeEnum"></option>
				</select><font color="red">*</font></td>



				<td class="FieldLabel" nowrap>生活能力：</td>
				<td class="FieldInput"><select name="viabilityCode"
					field="viabilityCode" title="生活能力">
					<option dataset="ViabilityCodeEnum"></option>
				</select><font color="red">*</font></td>
				<td class="FieldLabel" nowrap>供养方式：</td>
				<td class="FieldInput"><select name="supportPattern"
					field="supportPattern" title="供养方式">
					<option dataset="SupportPatternEnum"></option>
				</select><font color="red">*</font></td>
			</tr>
			<tr>
				<td class="FieldLabel" nowrap>健康状况：</td>
				<td class="FieldInput"><select style="width: 120px;"
					id="healthStateCode" field="healthStateCode" title="健康状况">
					<option dataset="HealthDataset"></option>
				</select><font color="red">*</font></td>

				<td class="FieldLabel" nowrap>生活状况：</td>
				<td class="FieldInput" colspan="3"><select
					style="width: 120px;" id="lifeStateCode" field="lifeStateCode"
					title="生活状况">
					<option dataset="dsLife"></option>
				</select><font color="red">*</font></td>
			</tr>
			<tr>
				<td class="FieldLabel" nowrap>开户银行：</td>
				<td class="FieldInput"><select name="bank" field="bank" title="开户银行">
					<option dataset="BankEnum"></option>
				</select><font color="red">*</font></td>
				<td class="FieldLabel" nowrap>开户名称：</td>
				<td class="FieldInput"><input type="text" name="accountName"
					field="accountName" title="开户名称"/><font color="red">*</font></td>
				<td class="FieldLabel" nowrap>银行账号：</td>
				<td class="FieldInput" colspan="5"><input type="text"
					name="accountCode" field="accountCode" title="银行帐号" style="width: 200"></input><font
					color="red">*</font></td>
			</tr>
			<tr>
				<td class="FieldLabel" nowrap>备注(类别信息)：</td>
				<td class="FieldInput" colspan="5"><textarea rows="3"
					cols="120" name="note" field="note" title="备注(类别)"></textarea></td>

			</tr>
		</table>
		</form>
	</next:Html>
</next:Panel>


</body>
</html>
