<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<title>参试人员信息</title>
<next:ScriptManager />
<script>
			var peopleId='<%=request.getParameter("peopleId")%>';
		</script>
<script type="text/javascript" src="bpttestedUpdate.js"></script>
<script type="text/javascript" src="../../comm/bptComm.js"></script>
</head>
<body>
<model:datasets>
	<model:dataset id="dsTested" cmd="com.inspur.cams.bpt.manage.cmd.BptPeopleTestedQueryCommand" global="true" method="queryPeopleTestedInfo">
		<model:record fromBean="com.inspur.cams.bpt.base.data.BptPeopleTested">
			<model:field name="insanityFlag" type="string" rule="require"/>
			<model:field name="oldLonelyFlag" type="string" rule="require"/>
			<model:field name="orphanFlag" type="string" />
			<model:field name="workAbilityCode" type="string" rule="require"/>
			<model:field name="workAbilityDescribe" type="string" />
			<model:field name="viabilityCode" type="string" rule="require"/>
			<model:field name="supportPattern" type="string" rule="require"/>
			<model:field name="jobStatusDescribe" type="string" />
			<model:field name="bank" type="string" />
			<model:field name="accountName" type="string" />
			<model:field name="accountCode" type="string" />
			<model:field name="warStateCode" type="string" />
			<model:field name="warNo" type="string"/>
			<model:field name="approvalDate" type="string" />
			<model:field name="healthType" type="string"/>
			<model:field name="healthStateName" type="string"/>
		</model:record>
	</model:dataset>

	<!-- 与户主关系 -->
	<model:dataset id="RelationshipTypeDataset" enumName="RELATIONSHIP.TYPE" autoLoad="true" global="true"></model:dataset>
    <!-- 性别 -->
	<model:dataset id="SexDataset" enumName="COMM.SEX" autoLoad="true" global="true"></model:dataset>
	<!-- 民族 -->
	<model:dataset id="NationDataset" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_NATION'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 文化程度 -->
	<model:dataset id="EducationDataset" enumName="EDUCATION.TYPE" autoLoad="true" global="true"></model:dataset>
	<!-- 婚姻状况 -->
	<model:dataset id="MarriageDataset" enumName="MARRIAGE.STATE" autoLoad="true" global="true"></model:dataset>
	<!-- 政治面貌 -->
	<model:dataset id="PoliticalDataset" enumName="POLITICAL.LANDSCAPE" autoLoad="true" global="true"></model:dataset>
	<!-- 户籍类别 -->
	<model:dataset id="DomicileDataset" enumName="DOMICILE.TYPE" autoLoad="true" global="true"></model:dataset>
	<!-- 伤残等级 -->
	<model:dataset id="DisabilityLevelDataset" enumName="LEVEL.CODE" autoLoad="true" global="true"></model:dataset>
	<!-- 职业 -->
	<model:dataset id="CareerDataset" enumName="CAREER.TYPE" autoLoad="true" global="true"></model:dataset>
   	<!-- 健康状况type -->
	<model:dataset id="dsHealth"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" method="queryType"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_HEALTH'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 健康状况code name -->
	<model:dataset id="dsHealthName"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" 
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_HEALTH'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 优抚对象状态 -->
	<model:dataset id="ObjectStateDataset" enumName="OBJECT.STATE" autoLoad="true" global="true"></model:dataset>
	<!--生活状况代码-->
	<model:dataset id="dsLife" enumName="LIFE.LIFE_STATE_CODE" autoLoad="true"></model:dataset>
	<!--参试类别代码-->
	<model:dataset id="dsTest" enumName="TESTED.TYPE" autoLoad="true"></model:dataset>
	<!--是否参加职业健康-->
	<model:dataset id="dsHestth" enumName="COMM.YESORNO" autoLoad="true"></model:dataset>
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
	<model:dataset id="InsanityFlagEnum" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
	<!-- 优抚供养方式 -->
	<model:dataset id="SupportPatternEnum" enumName="SUPPORT.PATTERN" autoLoad="true" global="true"></model:dataset>
	<!-- 孤老标志 -->
	<model:dataset id="OldLonelyFlagEnum" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
	<!-- 孤儿标志 -->
	<model:dataset id="OrphanFlagEnum" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
	<!-- 劳动能力代码 -->
	<model:dataset id="WorkAbilityCodeEnum" enumName="WORK.ABILITY.CODE" autoLoad="true" global="true"></model:dataset>
	<!-- 优抚生活能力代码 -->
	<model:dataset id="ViabilityCodeEnum" enumName="VIABILITY.CODE" autoLoad="true" global="true"></model:dataset>
	<!-- 优抚供养方式 -->
	<model:dataset id="SupportPatternEnum" enumName="SUPPORT.PATTERN" autoLoad="true" global="true"></model:dataset>
	<!-- 烈属类别代码 -->
	<model:dataset id="DependantTypeCodeEnum" enumName="DEPENDANT.CODE" autoLoad="true" global="true"></model:dataset>
	<!-- 就业状况 -->
	<model:dataset id="EmploymentCodeDataset" enumName="EMPLOYMENT.CODE" autoLoad="true" global="true"></model:dataset>
	<!-- 工作单位性质 -->
	<model:dataset id="WorkUnitCharacterDataset" enumName="WORKUNIT.CHARACTER" autoLoad="true" global="true"></model:dataset>
</model:datasets>


<next:Panel height="100%" width="100%" autoScroll="true">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="save" text="保存" handler="save" />
		<next:ToolBarItem iconCls="disable" text="关闭" handler="func_Close"/>
	</next:TopBar>
	<next:Html>
		<form id="editForm" dataset="dsTested" onsubmit="return false"
			style="padding: 5px;" class="L5form">
		<table border="0" width="100%" align="left">
			<tr>
				
				<td class="FieldLabel" nowrap>入伍(参加工作)时间：</td>
				<td class="FieldInput"><input type="text" name="conscriptcDate"
					title="入伍时间" field="conscriptcDate" format="Y-m-d"
					style="width: 100px;" maxlength="10"  onpropertychange="changeDateStyle(this)" /><img  src="../../../../../skins/images/default/rl.gif" align="middle" onclick="getTimes(this);" ><font color="red">*</font></td>
				<td class="FieldLabel" nowrap>退伍时间：</td>
				<td class="FieldInput"><input type="text"
					name="decruitmentDate" title="退伍时间" field="decruitmentDate"
					format="Y-m-d" style="width: 100px;" maxlength="10" onpropertychange="changeDateStyle(this)"  /><img  src="../../../../../skins/images/default/rl.gif" align="middle" onclick="getTimes(this);" ><font color="red">*</font></td>

				<td class="FieldLabel" nowrap>离退休时间：</td>
				<td class="FieldInput"><input type="text" name="retiredDate"
					title="离退休时间" field="retiredDate" format="Y-m-d"
					style="width: 100px;" maxlength="10"  onpropertychange="changeDateStyle(this)" /><img  src="../../../../../skins/images/default/rl.gif" align="middle" onclick="getTimes(this);" ></td>
			</tr>
			<tr>
				<td class="FieldLabel" nowrap>退伍证号：</td>
				<td class="FieldInput"><input type="text" name="asdpNo"
					title="退伍证号" field="asdpNo" /> 


				<td class="FieldLabel" nowrap>原部队代号：</td>
				<td class="FieldInput"><input type="text" name="forcesNo"
					field="forcesNo" title="原部队代号" /> 

				<td class="FieldLabel" nowrap>职务（级别）：</td>
				<td class="FieldInput"><input type="text" name="position"
					field="position" title="职务（级别）" /><font color="red">*</font></td>
			</tr>
			<tr>
				<td class="FieldLabel" nowrap>参试类别：</td>
				<td class="FieldInput"><select style="width: 180px;" 
					title="参试类别" id="testedType" field="testedType">
					<option dataset="dsTest" ></option>
				</select><font color="red">*</font></td>

				<td class="FieldLabel" nowrap>职业健康检查：</td>
				<td class="FieldInput"><select style="width: 120px;"
					title="职业健康检查" id="isHealthFlag" field="isHealthFlag" onchange="func_examination()">
					<option dataset="dsHestth"></option>
				</select><font color="red">*</font></td>
				
				<td class="FieldLabel" nowrap>健康状况：</td>
							<td class="FieldInput" ><input type="text" id="healthStateName" name="healthStateName" field="healthStateName" 
							   onfocus="func_HealthSelect()"/><input type="hidden" id="healthStateCode" field="healthStateCode" name="健康状况" title="健康状况"/><font color="red">*</font></td>
				
			</tr>
			<tr id="examinationDate">
				<td class="FieldLabel" nowrap>本次查体时间：</td>
				<td class="FieldInput"><input type="text" name="thisExaminationDate" id="thisExaminationDate"
								title="本次查体时间" field="thisExaminationDate" format="Y-m-d"
								style="width: 100px;" maxlength="10"  onpropertychange="changeDateStyle(this)" /><img  src="../../../../../skins/images/default/rl.gif" align="middle" onclick="getTimes(this);" ></td>
				<td class="FieldLabel" nowrap>上次查体时间：</td>
				<td class="FieldInput" ><input type="text" name="theExaminationDate" id="theExaminationDate"
								title="上次查体时间" field="theExaminationDate" format="Y-m-d"
								style="width: 100px;" maxlength="10"  onpropertychange="changeDateStyle(this)" /><img  src="../../../../../skins/images/default/rl.gif" align="middle" onclick="getTimes(this);" ></td>
				<td class="FieldLabel" nowrap>先天性残疾子女数：</td>
				<td class="FieldInput" ><input type="text"
					name="disabilityNum" field="disabilityNum" title="先天性残疾子女数"/></td>			
			</tr>
			<tr>
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

				<td class="FieldLabel" nowrap>劳动能力：</td>
				<td class="FieldInput" nowrap><select name="workAbilityCode"
					field="workAbilityCode" title="劳动能力">
					<option dataset="WorkAbilityCodeEnum"></option>
				</select><font color="red">*</font></td>

			</tr>
			<tr>
				<td class="FieldLabel" nowrap>生活状况：</td>
				<td class="FieldInput"><select style="width: 120px;"
					title="生活状况代码" id="lifeStateCode" field="lifeStateCode">
					<option dataset="dsLife"></option>
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
				<td class="FieldLabel" nowrap>身份认定依据：</td>
				<td class="FieldInput" colspan="5"><textarea rows="3"
					cols="120" name="identityBasis" field="identityBasis" title="身份认定依据"></textarea></td>
			</tr>
			<tr>
				<td class="FieldLabel" nowrap>开户银行：</td>
				<td class="FieldInput"><select name="bank" field="bank" title="开户银行">
					<option dataset="BankEnum"></option>
				</select></td>
				<td class="FieldLabel" nowrap>开户名称：</td>
				<td class="FieldInput"><input type="text" name="accountName"
					field="accountName" title="开户名称"/></td>
				<td class="FieldLabel" nowrap>银行账号：</td>
				<td class="FieldInput" colspan="5"><input type="text"
					name="accountCode" field="accountCode" title="银行帐号" style="width: 200"></input>
				</td>
			</tr>
			<tr>
				<td class="FieldLabel" nowrap>备注(类别信息)：</td>
				<td class="FieldInput" colspan="5"><textarea rows="3"
					cols="120" name="note" field="note" title="备注(类别信息)"></textarea></td>
			</tr>
			<!--录入人ID-->
			<input type="hidden" name="regId" field="regId">
			<!--录入时间-->
			<input type="hidden" name="regTime" field="regTime">
			<!--修改人ID-->
			<input type="hidden" name="modId" field="modId">
			<!--修改时间-->
			<input type="hidden" name="modTime" field="modTime">


		</table>
		</form>
	</next:Html>
</next:Panel>

</body>
</html>
