<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="com.inspur.cams.comm.util.IdHelp"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<script type="text/javascript">
   var organCode = '<%=BspUtil.getOrganCode()%>';
   var organName = '<%=BspUtil.getOrganName()%>';
   var familyId  = '<%=IdHelp.getUUID30()%>';
   var peopleId  = '<%=IdHelp.getUUID30()%>';
</script>
<html>
<head>
<title>参试人员信息</title>
<next:ScriptManager />
<script>
			var idField='<%=request.getParameter("dataBean")%>';
			var method='<%=request.getParameter("method")%>';
			var id='<%=request.getParameter("id")%>';
		</script>
<script type="text/javascript"
	src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
	<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js") %>'></script>
<script type="text/javascript" src="<%=SkinUtils.getRootUrl(request)%>skins/js/ISEditPhoto.js"></script>
<script type="text/javascript" src="testedErrUpdate.js"></script>
<script type="text/javascript" src="../../comm/bptComm.js"></script>
</head>
<body>
<model:datasets>
	<!-- 错误信息 -->
	<model:dataset id="BaseinfoPeopleDataSet" cmd="com.inspur.cams.bpt.excelToTable.ExcelToTableQueryCommand" global="true" method="queryErrUpdate">
		<model:record  >
		 <model:field name="domicileName" type="string"/>
		    <model:field name="apanageName" mapping="APANAGE" type="string" rule="require"/>
		    <model:field name="domicileName" mapping="DOMICILE" type="string" rule="require"/>
		    <model:field name="validateFlag" mapping="VALIDATE_FLAG" type="string" />
			<model:field name="commitFlag" mapping="COMMIT_FLAG" type="string" />
			<model:field name="organCode" mapping="ORGAN_CODE" type="string" />
			<model:field name="idCard" mapping="ID_CARD" type="string" rule="require"/>
			<model:field name="name" mapping="NAME" type="string" rule="require"/>
			<model:field name="birthday" mapping="BIRTHDAY" type="string" rule="require"/>
			<model:field name="nation" mapping="NATION" type="string" rule="require"/>
			<model:field name="sex" mapping="SEX" type="string" rule="require"/>
			<model:field name="relationshipType" mapping="RELATIONSHIP_TYPE" type="string" rule="require"/>
			<model:field name="domicileType" mapping="DOMICILE_TYPE" type="string" rule="require"/>
			<model:field name="domicileCode" mapping="DOMICILE_CODE" type="string"/>
			<model:field name="domicileAddress" mapping="DOMICILE_ADDRESS" type="string"/>
			<model:field name="apanageCode" mapping="APANAGE_CODE" type="string"/>
			<model:field name="address" mapping="ADDRESS" type="string"/>
			<model:field name="safeguardType" mapping="SAFEGUARD_TYPE" type="string" rule="require"/>
			<model:field name="medicalCode" mapping="MEDICAL_CODE" type="string"/>
			<model:field name="pensionCode" mapping="PENSION_CODE" type="string"/>
			<model:field name="telMobile" mapping="TEL_MOBILE" type="string"/>
			<model:field name="telOther" mapping="TEL_OTHER" type="string"/>
			<model:field name="postCode" mapping="POST_CODE" type="string"/>
			<model:field name="marriageCode" mapping="MARRIAGE_CODE" type="string"/>
			<model:field name="eduCode" mapping="EDU_CODE" type="string"/>
			<model:field name="healthCode" mapping="HEALTH_CODE" type="string"/>
			<model:field name="politicalCode" mapping="POLITICAL_CODE" type="string"/>
			<model:field name="employmentCode" mapping="EMPLOYMENT_CODE" type="string"/>
			<model:field name="incomeYear" mapping="INCOME_YEAR" type="string"/>
			<model:field name="workUnitName" mapping="WORK_UNIT_NAME" type="string"/>
			<model:field name="workUnitCharacter" mapping="WORK_UNIT_CHARACTER" type="string"/>
			<model:field name="workUnitTel" mapping="WORK_UNIT_TEL" type="string"/>
			<model:field name="workUnitAdd" mapping="WORK_UNIT_ADD" type="string"/>
			<model:field name="warStateCode" mapping="WAR_STATE_CODE" type="string" rule="require"/>
			<model:field name="warNo" mapping="WAR_NO" type="string" />
			<model:field name="approvalDate" mapping="APPROVAL_DATE" type="string" rule="require"/>
			<model:field name="conscriptcDate" mapping="CONSCRIPTC_DATE" type="string" rule="require"/>
			<model:field name="decruitmentDate" mapping="DECRUITMENT_DATE" type="string" rule="require"/>
			<model:field name="retiredDate" mapping="RETIRED_DATE" type="string"/>
			<model:field name="asdpNo" mapping="ASDP_NO" type="string"/>
			<model:field name="forcesNo" mapping="FORCES_NO" type="string"/>
			<model:field name="position" mapping="POSITION" type="string" rule="require"/>
			<model:field name="testedType" mapping="TESTED_TYPE" type="string" rule="require"/>
			<model:field name="isHealthFlag" mapping="IS_HEALTH_FLAG" type="string" rule="require"/>
			<model:field name="healthStateCode" mapping="HEALTH_STATE_CODE" type="string" rule="require"/>
			<model:field name="thisExaminationDate" mapping="THIS_EXAMINATION_DATE" type="string"/>
			<model:field name="theExaminationDate" mapping="THE_EXAMINATION_DATE" type="string"/>
			<model:field name="oldLonelyFlag" mapping="OLD_LONELY_FLAG" type="string" rule="require"/>
			<model:field name="insanityFlag" mapping="INSANITY_FLAG" type="string" rule="require"/>
			<model:field name="workAbilityCode" mapping="WORK_ABILITY_CODE" type="string" rule="require"/>
			<model:field name="lifeStateCode" mapping="LIFE_STATE_CODE" type="string" rule="require"/>
			<model:field name="viabilityCode" mapping="VIABILITY_CODE" type="string" rule="require"/>
			<model:field name="supportPattern" mapping="SUPPORT_PATTERN" type="string" rule="require"/>
			<model:field name="disabilityLevelCode" mapping="DISABILITY_LEVEL_CODE" type="string"/>
			<model:field name="disabilityNum" mapping="DISABILITY_NUM" type="string"/>
			<model:field name="identityBasis" mapping="IDENTITY_BASIS" type="string"/>
			<model:field name="bank" mapping="BANK" type="string" rule="require"/>
			<model:field name="accountName" mapping="ACCOUNT_NAME" type="string" rule="require"/>
			<model:field name="accountCode" mapping="ACCOUNT_CODE" type="string" rule="require"/>
			<model:field name="note" mapping="NOTE" type="string"/>
			<model:field name="errorMessage" mapping="ERROR_MESSAGE" type="string"/>
			<model:field name="id" mapping="ID" type="string"/>
		</model:record>
	</model:dataset>
	<!-- 家庭信息 -->
	<model:dataset id="BaseinfoFamilyDataSet"
		cmd="com.inspur.cams.bpt.manage.cmd.BaseinfoFamilyCommand"
		global="true">
		<model:record
			fromBean="com.inspur.cams.comm.baseinfo.data.BaseinfoFamily"></model:record>
	</model:dataset>
	<!-- 与户主关系 -->
	<model:dataset id="RelationshipTypeDataset" enumName="RELATIONSHIP.TYPE" autoLoad="true" global="true"></model:dataset>

	<!-- 性别 -->
	<model:dataset id="SexDataset" enumName="COMM.SEX" autoLoad="true" global="true"></model:dataset>
	<!-- 民族 -->
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
	<!-- 文化程度 -->
	<model:dataset id="EducationDataset" enumName="EDUCATION.TYPE" autoLoad="true" global="true"></model:dataset>
	<!-- 健康状况 -->
	<model:dataset id="HealthDataset" enumName="HEALTH.TYPE" autoLoad="true" global="true"></model:dataset>
	<!-- 婚姻状况 -->
	<model:dataset id="MarriageDataset" enumName="MARRIAGE.STATE" autoLoad="true" global="true"></model:dataset>
	<!-- 政治面貌 -->
	<model:dataset id="PoliticalDataset" enumName="POLITICAL.LANDSCAPE" autoLoad="true" global="true"></model:dataset>
	<!-- 户籍类别 -->
	<model:dataset id="DomicileDataset" enumName="DOMICILE.TYPE" autoLoad="true" global="true"></model:dataset>
	<!-- 医疗保障方式 -->
	<model:dataset id="SafeguardDataset" enumName="COMM.MEDICAL_STATUS" autoLoad="true" global="true"></model:dataset>
	<!-- 养老保障方式 -->
	<model:dataset id="PensionDataset" enumName="COMM.PENSION_CODE" autoLoad="true" global="true"></model:dataset>
	<!-- 伤残等级 -->
	<model:dataset id="DisabilityLevelDataset" enumName="LEVEL.CODE" autoLoad="true" global="true"></model:dataset>

	<!-- 健康状况 -->
	<model:dataset id="dsHealth"
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
	<model:dataset id="ObjectStateDataset" enumName="OBJECT.STATE"
		autoLoad="true" global="true"></model:dataset>
	<!--生活状况代码-->
	<model:dataset id="dsLife" enumName="LIFE.LIFE_STATE_CODE"
		autoLoad="true"></model:dataset>
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
	<model:dataset id="InsanityFlagEnum" enumName="COMM.YESORNO"
		autoLoad="true" global="true"></model:dataset>
	<!-- 优抚供养方式 -->
	<model:dataset id="SupportPatternEnum" enumName="SUPPORT.PATTERN"
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
	<!-- 烈属类别代码 -->
	<model:dataset id="DependantTypeCodeEnum"
		enumName="DEPENDANT.CODE" autoLoad="true" global="true"></model:dataset>
	<!-- 就业状况 -->
	<model:dataset id="EmploymentCodeDataset" enumName="EMPLOYMENT.CODE"
		autoLoad="true" global="true"></model:dataset>
	<!-- 工作单位性质 -->
	<model:dataset id="WorkUnitCharacterDataset"
		enumName="WORKUNIT.CHARACTER" autoLoad="true" global="true"></model:dataset>
</model:datasets>

<next:Panel height="100%" bodyStyle="width:100%" width="100%" autoScroll="false">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="save" text="保存" handler="saveClick" />
		<next:ToolBarItem iconCls="disable" text="关闭" handler="func_Close" />
	</next:TopBar>
	<next:TabPanel>
		<next:Tabs>
			<next:Panel title="人员基本信息" autoHeight="true" width="100%"  autoScroll="true" id="peopleTabPanel">
				<next:Html>
				<fieldset>
					<form id="BaseinfoPeopleForm" method="post"
						dataset="BaseinfoPeopleDataSet" onsubmit="return false"
						style="padding: 5px;" class="L5form">
					<table border="0" width="98%">

						<tr>
							<td class="FieldLabel" nowrap>身份证件号码：</td>
							<td class="FieldInput"><input type="text" name="idCard"
								field="idCard" title="身份证件号码" maxlength="18"
								 onchange="func_CheckIdCard()"  style="width: 135" /><font
								color="red">*</font>
								 <input type="hidden" name="stype"
								id="stype" value="14"/>
								</td>

							<td class="FieldLabel" >姓名：</td>
							<td class="FieldInput" colspan="3"><input type="text"
								id="namebase" name="namebase" field="name" title="姓名"  /><font color="red">*</font>
								<input type="hidden"  id="phoneticCode" name="phoneticCode" field="phoneticCode" title="姓名拼音码" />
							</td>
							
						</tr>

						<tr>
							<td class="FieldLabel" >出生日期：</td>
							<td class="FieldInput" ><input type="text"
								name="birthday"  field="birthday" title="出生日期"/><font color="red">*</font></td>
						     <td class="FieldLabel" >民族：</td>
							<td class="FieldInput" colspan="3"><select
								name="nation" field="nation" title="民族">
								<option dataset="NationDataset"></option>
							</select><font color="red">*</font></td>
							 
						</tr>
						<tr>
							<td class="FieldLabel" >性别：</td>
							<td class="FieldInput" ><select name="sex"
								field="sex" title="性别">
								<option dataset="SexDataset"></option>
							</select><font color="red">*</font></td>
							<td class="FieldLabel" nowrap>与户主关系：</td>
							<td class="FieldInput" colspan="3">
							<select name="relationshipType" field="relationshipType" title="与户主关系">
								<option dataset="RelationshipTypeDataset"></option>
							</select><font color="red">*</font></td>
					   </tr>

						<tr>
						   <td class="FieldLabel" >户口薄(行政区划)：</td>
						   <td class="FieldInput" nowrap="nowrap">
						       <input type="text" id="domicileName" name="domicileName" field="domicileName" title="属地行政区划" onclick="func_ForDomicileSelect()" readonly="readonly" style="width:90%"/><font color="red">*</font>
						       <input type="hidden" id="domicileCode" name="domicileCode" field="domicileCode" title="属地行政区划"/></td>
						       
						   <td class="FieldLabel">户口薄住址:</td>
						   <td class="FieldInput" colspan="3"><input type="text" onblur="changes()" name="domicileAddress" field="domicileAddress" title="户口薄住址" style="width:85%"></td>      
						</tr>
						<tr>
							<td class="FieldLabel">实际居住(行政区划)：</td> 
							<td class="FieldInput" nowrap="nowrap"><input type="text" id="apanageName" name="apanageName" field="apanageName" title="行政区划" readonly="readonly" onclick="func_ForApanageSelect()" style="width:90%"/><font color="red">*</font>
							<input type="hidden" name="apanageCode" field="apanageCode" title="行政区划"/></td>
							<td class="FieldLabel">实际居住地址:</td>
							<td class="FieldInput" colspan="3"><input type="text" name="address" field="address" title="实际居住地址" style="width:85%"></td>
						</tr>
						<tr>
						   <td class="FieldLabel" >医疗保障方式：</td>
						   <td class="FieldInput" >
						       <select name="safeguardType" field="safeguardType" title="医疗保障方式">
								 <option dataset="SafeguardDataset"></option>
							   </select><font color="red">*</font>
							</td>
                            <td class="FieldLabel" >医疗保险号：</td>
							<td class="FieldInput"><input type="text" name="medicalCode" field="medicalCode" title="医疗保险号"/></td>
						    <td class="FieldLabel" >养老保障方式：</td>
						    <td class="FieldInput" >
						       <select name="penSionCode" field="pensionCode" title="养老保障方式">
								 <option dataset="PensionDataset"></option>
							   </select>
							</td>
						</tr>

						<tr>
							<td class="FieldLabel" nowrap="nowrap">联系方式（手机）：</td>
							<td class="FieldInput"><input type="text" name="telMobile"
								field="telMobile" title="联系方式(手机)"/></td>

							<td class="FieldLabel" nowrap="nowrap">其他联系方式：</td>
							<td class="FieldInput"><input type="text" name="telOther"
								field="telOther" title="其他联系方式"/></td>

							<td class="FieldLabel">邮政编码：</td>
							<td class="FieldInput"><input type="text" name="postCode"
								field="postCode" title="邮政编码"/></td>
						</tr>

						<tr>
							<td class="FieldLabel">户籍类别：</td>
							<td class="FieldInput"><select name="domicileType"
								field="domicileType" title="户籍类别" onchange="func_Type()">
								<option dataset="DomicileDataset"></option>
							</select><font color="red">*</font></td>

							<td class="FieldLabel">文化程度：</td>
							<td class="FieldInput"><select name="eduCode"
								field="eduCode" title="文化程度">
								<option dataset="EducationDataset"></option>
							</select></td>

							<td class="FieldLabel">健康状况：</td>
							<td class="FieldInput"><select name="healthCode"
								field="healthCode" title="健康状况">
								<option dataset="HealthDataset"></option>
							</select></td>
						</tr>

						<tr>
							<td class="FieldLabel">婚姻状况：</td>
							<td class="FieldInput"><select name="marriageCode"
								field="marriageCode" title="婚姻状况">
								<option dataset="MarriageDataset"></option>
							</select></td>
							<td class="FieldLabel">政治面貌：</td>
							<td class="FieldInput" colspan="3"><select name="politicalCode"
								field="politicalCode" title="政治面貌">
								<option dataset="PoliticalDataset"></option>
							</select></td>
						</tr>

						<tr>
							<td class="FieldLabel">就业状况：</td>
							<td class="FieldInput"><select name="employmentCode"
								field="employmentCode" title="就业状况">
								<option dataset="EmploymentCodeDataset"></option>
							</select></td>

							<td class="FieldLabel">年收入：</td>
							<td class="FieldInput" colspan="3"><input type="text"
								name="incomeYear" field="incomeYear" title="年收入"/></td>
						</tr>

						<tr id="work">

							<td class="FieldLabel">工作单位名称：</td>
							<td class="FieldInput"><input type="text"
								name="workUnitName" field="workUnitName" title="工作单位名称"/></td>

							<td class="FieldLabel">工作单位性质：</td>
							<td class="FieldInput"><select name="workUnitCharacter"
								field="workUnitCharacter" title="工作单位性质">
								<option dataset="WorkUnitCharacterDataset"></option>
							</select></td>

							<td class="FieldLabel" nowrap="nowrap">工作单位电话：</td>
							<td class="FieldInput"><input type="text"
								name="workUnitTel" field="workUnitTel" title="工作单位电话"/></td>
						</tr>

						<tr id="workAddress">
							<td class="FieldLabel">工作单位地址：</td>
							<td class="FieldInput" colspan="5"><input type="text"
								name="workUnitAdd" field="workUnitAdd" title="工作单位地址" style="width: 90%"></td>
						</tr>

						<tr>
							<td class="FieldLabel">备注(基本信息)：</td>
							<td class="FieldInput" colspan="5"><textarea name="note"
								field="note" rows="3" title="备注(基本信息)" style="width: 90%"></textarea></td>
						</tr>

						<!--人员ID -->
						<input type="hidden" name="peopleId" id="peopleId" field="peopleId"/>
						<!--家庭ID -->
						<input type="hidden" name="familyId" id="familyId" field="familyId"/>
						<input type="hidden" name="flag" id="flag" value="1"/>


					</table>
					</form>
					</fieldset>
				</next:Html>
			</next:Panel>


			<next:Panel id="typeInfo" title="类别信息" autoHeight="true" autoScroll="true" width="100%">
				<next:Html>
				<fieldset>
					<form id="BptPeopleDisabilityForm" method="post"
						dataset="BaseinfoPeopleDataSet" onsubmit="return false"
						style="padding: 5px;" class="L5form">
					<table border="1" width="98%">
						<tr>
							<td class="FieldLabel" nowrap>优抚对象状态：</td>
							<td class="FieldInput"><select name="warStateCode"
								field="warStateCode" title="优抚对象状态">
								<option dataset="ObjectStateDataset"></option>
							</select><font color="red">*</font></td>

							<td class="FieldLabel" nowrap>生活补助证编号：</td>
							<td class="FieldInput"><input type="text" name="warNo" field="warNo" title="生活补助证编号"></input></td>

							<td class="FieldLabel" nowrap>批准日期：</td>
							<td class="FieldInput"><input type="text"
								name="approvalDate" field="approvalDate" format="Y-m-d"style="width: 100px;" onpropertychange="changeDateStyle(this)" 
								maxlength="10" title="批准日期"/><img  src="../../../../../skins/images/default/rl.gif" align="middle"  onclick="getTimes(this)"  ><font color="red">*</font></td>
						</tr>
						<tr>
							<td class="FieldLabel" nowrap>入伍(参加工作)时间：</td>
							<td class="FieldInput"><input type="text"
								name="conscriptcDate" title="入伍时间" field="conscriptcDate"style="width: 100px;" onpropertychange="changeDateStyle(this)" 
								format="Y-m-d" maxlength="10"/><img  src="../../../../../skins/images/default/rl.gif" align="middle"  onclick="getTimes(this)"  ><font color="red">*</font>
							</td>
							<td class="FieldLabel" nowrap>退伍时间：</td>
							<td class="FieldInput"><input type="text"
								name="decruitmentDate" title="退伍时间" field="decruitmentDate"style="width: 100px;" onpropertychange="changeDateStyle(this)" 
								format="Y-m-d" maxlength="10" /><img  src="../../../../../skins/images/default/rl.gif" align="middle"  onclick="getTimes(this)"  ><font
								color="red">*</font></td>

							<td class="FieldLabel" nowrap>离退休时间：</td>
							<td class="FieldInput"><input type="text" name="retiredDate"
								title="离退休时间" field="retiredDate" format="Y-m-d"style="width: 100px;" onpropertychange="changeDateStyle(this)" 
								maxlength="10" /><img  src="../../../../../skins/images/default/rl.gif" align="middle"  onclick="getTimes(this)"  ></td>
						</tr>
						<tr>
							<td class="FieldLabel" nowrap>退伍证号：</td>
							<td class="FieldInput"><input type="text" name="asdpNo"
								title="退伍证号" field="asdpNo" /></td>


							<td class="FieldLabel" nowrap>原部队代号：</td>
							<td class="FieldInput"><input type="text" name="forcesNo"
								field="forcesNo" title="原部队代号" />
							</td>
						
							<td class="FieldLabel" nowrap>职务（级别）：</td>
							<td class="FieldInput"><input type="text" name="position"
								field="position" title="职务（级别）" /><font color="red">*</font></td>
						</tr>
						<tr>
							<td class="FieldLabel" nowrap>参试类别：</td>
							<td class="FieldInput"><select style="width: 120px;"
								title="参试类别" id="testedType" field="testedType">
								<option dataset="dsTest"></option>
							</select><font color="red">*</font></td>
							
							<td class="FieldLabel" nowrap>职业健康检查：</td>
							<td class="FieldInput"><select style="width: 120px;"
								title="职业健康检查" id="isHealthFlag" field="isHealthFlag" onchange="func_examination()">
								<option dataset="dsHestth"></option>
							</select><font color="red">*</font></td>
							
							<td class="FieldLabel" nowrap>健康状况：</td>
							<td class="FieldInput"><select style="width: 120px;"
								title="健康状况代码" id="healthStateCode" field="healthStateCode">
								<option dataset="dsHealth"></option>
							</select><font color="red">*</font></td>
							
						</tr>
						<tr id="examinationDate">
							<td class="FieldLabel" nowrap>本次查体时间：</td>
							<td class="FieldInput"><input type="text" name="thisExaminationDate" id="thisExaminationDate"
								title="本次查体时间" field="thisExaminationDate" format="Y-m-d"style="width: 100px;" onpropertychange="changeDateStyle(this)" 
								maxlength="10" /><img  src="../../../../../skins/images/default/rl.gif" align="middle"  onclick="getTimes(this)"  ></td>
							
							<td class="FieldLabel" nowrap>上次查体时间：</td>
							<td class="FieldInput" colspan="3"><input type="text" name="theExaminationDate" id="theExaminationDate"
								title="上次查体时间" field="theExaminationDate" format="Y-m-d"style="width: 100px;" onpropertychange="changeDateStyle(this)" 
								maxlength="10" /><img  src="../../../../../skins/images/default/rl.gif" align="middle"  onclick="getTimes(this)"  ></td>
							
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
							<td class="FieldLabel" nowrap>残疾等级：</td>
							<td class="FieldInput"><select style="width: 120px;"
								id="disabilityLevelCode" field="disabilityLevelCode" title="残疾等级">
								<option dataset="DisabilityLevelDataset"></option>
							</select></td>
							
							<td class="FieldLabel" nowrap>先天性残疾子女数：</td>
							<td class="FieldInput" colspan="3"><input type="text"
								name="disabilityNum" field="disabilityNum" title="先天性残疾子女数"/></td>
						</tr>
						<tr>
							<td class="FieldLabel" nowrap>身份认定依据：</td>
							<td class="FieldInput" colspan="5">
								<textarea rows="3"
								cols="120" name="identityBasis" field="identityBasis" title="身份认定依据"></textarea></td>		
						</tr>
						<tr>
							<td class="FieldLabel" nowrap>开户银行：</td>
							<td class="FieldInput"><select name="bank" field="bank" title="开户银行"><option dataset="BankEnum"></option></select><font color="red">*</font></td>
							<td  class="FieldLabel" nowrap>开户名称：</td>
							<td class="FieldInput"><input type="text" name="accountName" field="accountName" title="开户名称"/><font color="red">*</font> </td>
							<td  class="FieldLabel" nowrap>银行账号：</td>
							<td class="FieldInput" colspan="5"><input type="text" name="accountCode" field="accountCode" title="银行帐号" style="width:200" ></input><font color="red">*</font></td>	
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
		</next:Tabs>
	</next:TabPanel>
</next:Panel>

</body>
</html>
