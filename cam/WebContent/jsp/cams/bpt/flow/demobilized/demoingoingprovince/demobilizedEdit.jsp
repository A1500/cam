<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="com.inspur.cams.comm.util.IdHelp"%>
<html>
<head>
<title>在乡复员军人业务受理</title>
<next:ScriptManager />
<script>
			var peopleId='<%=request.getParameter("peopleId")%>';
		</script>
<script type="text/javascript" src="demobilizedEdit.js"></script>
<script type="text/javascript" src="../../../comm/bptComm.js"></script>
</head>
<body>
<model:datasets>
	<!-- 在乡复员军人类别信息 -->
	<model:dataset id="PeopleDemobilizedDataset"
		cmd="com.inspur.cams.bpt.manage.cmd.BptApplyIntoprovinceQueryCommand"global="true" method="queryDemobilizedBptPeople">
		<model:record
			fromBean="com.inspur.cams.bpt.base.data.BptPeopleDemobilized">
			<model:field name="demobilizedStateCode" type="string" rule="require" />
			<model:field name="demobilizedNo" type="string"  />
			<model:field name="insanityFlag" type="string" rule="require" />
			<model:field name="oldLonelyFlag" type="string" rule="require" />
			<model:field name="workAbilityCode" type="string" rule="require" />
			<model:field name="workAbilityDescribe" type="string" />
			<model:field name="viabilityCode" type="string" rule="require" />
			<model:field name="supportPattern" type="string" rule="require" />
			<model:field name="jobStatusDescribe" type="string" />
			<model:field name="bank" type="string" />
			<model:field name="accountName" type="string" />
			<model:field name="accountCode" type="string" />
			<!-- 外省在乡人员抚恤关系迁入我省审批表字段 -->
			<model:field name="ingoingAddress" type="string" rule="require"/>
			<model:field name="ingoingCode" type="string"  />
			<model:field name="ingoingReason" type="string" />
			<model:field name="oldPaperNo" type="string" rule="require"/>	
			<model:field name="allowanceMonth" type="string" rule="require"/>
			<model:field name="serviceType" type="string"/>
		</model:record>
	</model:dataset>

	<!-- 是否精神病标志 -->
	<model:dataset id="InsanityFlagEnum" enumName="COMM.YESORNO"
		autoLoad="true" global="true"></model:dataset>
	<!-- 孤老标志 -->
	<model:dataset id="OldLonelyFlagEnum" enumName="COMM.YESORNO"
		autoLoad="true" global="true"></model:dataset>
	<!-- 孤儿标志 -->

	<!-- 劳动能力代码 -->
	<model:dataset id="WorkAbilityCodeEnum" enumName="WORK.ABILITY.CODE"
		autoLoad="true" global="true"></model:dataset>
	<!-- 优抚生活能力代码 -->
	<model:dataset id="ViabilityCodeEnum" enumName="VIABILITY.CODE"
		autoLoad="true" global="true"></model:dataset>
	<!-- 优抚供养方式 -->
	<model:dataset id="SupportPatternEnum" enumName="SUPPORT.PATTERN"
		autoLoad="true" global="true"></model:dataset>
	<!-- 开户银行代码 -->
	<model:dataset id="BankEnum" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_BANK'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 是否抗美援朝-->
	<model:dataset id="KoeanwarEnum" enumName="COMM.YESORNO"
		autoLoad="true" global="true"></model:dataset>
	<!-- 优抚对象状态 -->
	<model:dataset id="ObjectStateDataset" enumName="OBJECT.STATE"
		autoLoad="true" global="true"></model:dataset>
	<!-- 属于时期-->
	<model:dataset id="warDs" enumName="DEMOBILIZED.BELONGDATE"
		autoLoad="true" global="true"></model:dataset>
</model:datasets>
<next:Panel height="100%" width="100%" autoScroll="true">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="save" text="保存" handler="saveClick" />
		<next:ToolBarItem iconCls="disable" text="关闭" handler="returnClick" />
	</next:TopBar>
	<next:Html>
		<form id="editForm" dataset="PeopleDemobilizedDataset"
			onsubmit="return false" style="padding: 5px;" class="L5form">
		<table border="0" width="98%">
			<tr>
				<td class="FieldLabel" nowrap>入伍时间：</td>
				<td class="FieldInput"><input type="text" name="conscriptDate"
					field="conscriptDate" format="Y-m-d" style="width: 100px;" maxlength="10"
					onblur="func_BelongDate()" title="入伍时间"  onpropertychange="changeDateStyle(this)" /><img  src="../../../../../../skins/images/default/rl.gif" align="middle" onclick="getTimes(this);" ><font color="red">*</font></td>
				<td class="FieldLabel" nowrap>复员时间：</td>
				<td class="FieldInput"><input type="text"
					name="decruitmentDate" field="decruitmentDate" format="Y-m-d"
					style="width: 100px;" maxlength="10" title="复员时间"  onpropertychange="changeDateStyle(this)" /><img  src="../../../../../../skins/images/default/rl.gif" align="middle" onclick="getTimes(this);" ><font color="red">*</font></td>
				<td class="FieldLabel" nowrap>原部队代号：</td>
				<td class="FieldInput"><input type="text" name="forcesNo"
					field="forcesNo" title="原部队代号" /></td>
			</tr>
	   		<tr>
	   		    <td  class="FieldLabel" nowrap>职务：</td><td class="FieldInput"><input type="text" name="position" field="position" title="职务"/></td>
				<td  class="FieldLabel" nowrap>是否抗美援朝：</td>
			    <td class="FieldInput" ><select name="isKoeanwar" field="isKoeanwar" title="是否抗美援朝"><option dataset="KoeanwarEnum"></option></select><font color="red">*</font></td>
				<td  class="FieldLabel" nowrap>属于时期：</td>
				<td class="FieldInput" colspan="5"><select name="belongDate" field="belongDate" title="属于时期"><option dataset="warDs"></option></select><font color="red">*</font></td>
			</tr>
		    <tr>
			  <!--   <td class="FieldLabel" nowrap>优抚对象状态：</td>
				<td class="FieldInput" >
				   <select name="demobilizedStateCode" field="demobilizedStateCode" title="优抚对象状态">
						<option dataset="ObjectStateDataset"></option>
				   </select><font color="red">*</font>
				</td>
			   <td class="FieldLabel" nowrap>定期定量补助证编号:</td>
			    <td class="FieldInput"><input type="text" name="demobilizedNo" field="demobilizedNo" title="定期定量补助证编号"/><font color="red">*</font></td>
			    -->
			 <!--     <td class="FieldLabel" nowrap>批准日期：</td>
				<td class="FieldInput" colspan="3"><input type="text" name="approvalDate" field="approvalDate" format="Y-m-d" style="width: 100px;" maxlength="10" title="批准日期"/><img  src="../../../../../../skins/images/default/rl.gif" align="middle" onclick="getTimes(this);" ><font color="red">*</font></td>
			-->
			</tr>
			<tr>
				<td class="FieldLabel" nowrap="nowrap">原残疾证件编号：</td>
							<td class="FieldInput" ><input type="text" name="oldPaperNo" field="oldPaperNo" id="oldPaperNo" title="原残疾证件编号" maxlength="20"/><font color="red">*</font></td>
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
				<td class="FieldLabel" nowrap>开户银行：</td>
				<td class="FieldInput"><select name="bank" field="bank"
					title="开户银行">
					<option dataset="BankEnum"></option>
				</select></td>
				<td class="FieldLabel" nowrap>开户名称：</td>
				<td class="FieldInput"><input type="text" name="accountName"
					field="accountName" title="开户名称" /></td>
				<td class="FieldLabel" nowrap>银行账号：</td>
				<td class="FieldInput" colspan="5"><input type="text"
					name="accountCode" field="accountCode" title="银行帐号"
					style="width: 200"></input></td>
			</tr>
			<tr>
					<td class="FieldLabel">由何地迁入</td>
					<td class="FieldInput"><input type="text" onclick="getCodeAndName()" readonly="readonly" name="ingoingAddress" field="ingoingAddress" title="由何地迁入"/><font color="red">*</font></td>
					<td class="FieldLabel">抚恤金已发至月份</td>
					<td class="FieldInput" colspan="3"><input type="text" name="allowanceMonth" field="allowanceMonth" title="抚恤金已发至月份" onblur="setMoth(this)" format="Y" style="width: 100px;" maxlength="10"/><img  src="../../../../../../skins/images/default/rl.gif" align="middle" onclick="getTimes(this);" ><font color="red">*</font></td>
			</tr>
						
			<tr>
					<td class="FieldLabel">迁入原因</td>
					<td class="FieldInput" colspan="5"><textarea type="text" rows="2" name="ingoingReason" field="ingoingReason" style="width:90%" title="迁入原因"></textarea></td>
			</tr>
			<tr>
				<td class="FieldLabel" nowrap>备注(类别信息)：</td>
				<td class="FieldInput" colspan="5"><textarea rows="3"
					cols="155" name="note" title="备注(类别信息)" field="note"></textarea></td>
			</tr>

		</table>
		<input type="hidden" name="ingoingCode" field="ingoingCode" title="由何地迁入代码">
		</form>
	</next:Html>
</next:Panel>

</body>
</html>
