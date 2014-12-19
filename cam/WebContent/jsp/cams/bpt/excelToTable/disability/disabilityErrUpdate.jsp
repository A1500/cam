<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="com.inspur.cams.comm.util.IdHelp"%>
<%@ page import="org.loushang.next.skin.SkinUtils" %>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<script type="text/javascript">
   var organCode = '<%=BspUtil.getOrganCode()%>';
   var organName = '<%=BspUtil.getOrganName()%>';
   var familyId  = '<%=IdHelp.getUUID30()%>';
   var peopleId  = '<%=IdHelp.getUUID30()%>';
</script>
	<%
	response.setHeader("Expires", "Sat, 6 May 1995 12:00:00 GMT");  
	response.setHeader("Cache-Control", "no-store,no-cache,must-revalidate");  
	response.addHeader("Cache-Control", "post-check=0, pre-check=0");  
	response.setHeader("Pragma", "no-cache");  
	%>
<html>
<head>
<title>伤残人员信息</title>
<next:ScriptManager />
		<script>
			var id='<%=request.getParameter("id")%>';
		</script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js") %>'></script>
<script type="text/javascript" src="disabilityErrUpdate.js"></script>
<script type="text/javascript" src="../../dataCollection/comm/bptComm.js"></script>
</head>
<body>
<model:datasets>

	<!-- 错误信息 -->
	<model:dataset id="BaseinfoPeopleDataSet" cmd="com.inspur.cams.bpt.excelToTable.ExcelToTableQueryCommand" global="true" method="queryErrUpdate">
		<model:record  >
		 <model:field name="domicileName" type="string"/>
		    <model:field name="apanageName" mapping="APANAGE" type="string"/>
		    <model:field name="domicileCode" mapping="DOMICILE_CODE" type="string"/>
		    <model:field name="domicileName" mapping="DOMICILE" type="string"/>
			<model:field name="accountName" mapping="ACCOUNT_NAME" type="string"/>
			<model:field name="telOther" mapping="TEL_OTHER" type="string"/>
			<model:field name="retiredDate" mapping="RETIRED_DATE" type="string"/>
			<model:field name="domicileType" mapping="DOMICILE_TYPE" type="string"/>
			<model:field name="sex" mapping="SEX" type="string" rule="require"/>
			<model:field name="workAbilityCode" mapping="WORK_ABILITY_CODE" type="string" rule="require"/>
			<model:field name="idCard" mapping="ID_CARD" type="string" rule="require"/>
			<model:field name="disabilityBody" mapping="DISABILITY_BODY" type="string" rule="require"/>
			<model:field name="workUnitTel" mapping="WORK_UNIT_TEL" type="string"/>
			<model:field name="workUnitAdd" mapping="WORK_UNIT_ADD" type="string"/>
			<model:field name="bank" mapping="BANK" type="string"/>
			<model:field name="uinitOfDisability" mapping="UINIT_OF_DISABILITY" type="string"/>
			<model:field name="workUnitName" mapping="WORK_UNIT_NAME" type="string"/>
			<model:field name="pensionCode" mapping="PENSION_CODE" type="string"/>
			<model:field name="disabilityDate" mapping="DISABILITY_DATE" type="string" rule="require"/>
			<model:field name="errorMessage" mapping="ERROR_MESSAGE" type="string"/>
			<model:field name="disabilityReason" mapping="DISABILITY_REASON" type="string" rule="require"/>
			<model:field name="disabilityWarCode" mapping="DISABILITY_WAR_CODE" type="string" rule="require"/>
			<model:field name="insanityFlag" mapping="INSANITY_FLAG" type="string" rule="require"/>
			<model:field name="validateFlag" mapping="VALIDATE_FLAG" type="string"/>
			<model:field name="commitFlag" mapping="COMMIT_FLAG" type="string"/>
			<model:field name="domicileAddress" mapping="DOMICILE_ADDRESS" type="string"/>
			<model:field name="disabilityAdd" mapping="DISABILITY_ADD" type="string" rule="require"/>
			<model:field name="id" mapping="ID" type="string"/>
			<model:field name="disabilityNo" mapping="DISABILITY_NO" type="string"/>
			<model:field name="healthCode" mapping="HEALTH_CODE" type="string"/>
			<model:field name="medicalCode" mapping="MEDICAL_CODE" type="string"/>
			<model:field name="workUnitCharacter" mapping="WORK_UNIT_CHARACTER" type="string"/>
			<model:field name="employmentCode" mapping="EMPLOYMENT_CODE" type="string"/>
			<model:field name="incomeYear" mapping="INCOME_YEAR" type="string"/>
			<model:field name="oldLonelyFlag" mapping="OLD_LONELY_FLAG" type="string" rule="require"/>
			<model:field name="relationshipType" mapping="RELATIONSHIP_TYPE" type="string" rule="require"/>
			<model:field name="disabilityStateCode" mapping="DISABILITY_STATE_CODE" type="string"/>
			<model:field name="supportPattern" mapping="SUPPORT_PATTERN" type="string" rule="require"/>
			<model:field name="approveDate" mapping="APPROVE_DATE" type="string"/>
			<model:field name="note" mapping="NOTE" type="string"/>
			<model:field name="postCode" mapping="POST_CODE" type="string"/>
			<model:field name="safeguardType" mapping="SAFEGUARD_TYPE" type="string"/>
			<model:field name="accountCode" mapping="ACCOUNT_CODE" type="string"/>
			<model:field name="telMobile" mapping="TEL_MOBILE" type="string"/>
			<model:field name="birthday" mapping="BIRTHDAY" type="string" rule="require"/>
			<model:field name="politicalCode" mapping="POLITICAL_CODE" type="string"/>
			<model:field name="disabilityLevelCode" mapping="DISABILITY_LEVEL_CODE" type="string"/>
			<model:field name="nation" mapping="NATION" type="string" rule="require"/>
			<model:field name="marriageCode" mapping="MARRIAGE_CODE" type="string"/>
			<model:field name="disabilityTypeCode" mapping="DISABILITY_TYPE_CODE" type="string"/>
			<model:field name="eduCode" mapping="EDU_CODE" type="string"/>
			<model:field name="veteransDate" mapping="VETERANS_DATE" type="string"/>
			<model:field name="apanageCode" mapping="APANAGE_CODE" type="string"/>
			<model:field name="name" mapping="NAME" type="string" rule="require"/>
			<model:field name="organCode" mapping="ORGAN_CODE" type="string"/>
			<model:field name="disabilityCaseCode" mapping="DISABILITY_CASE_CODE" type="string"/>
			<model:field name="conscriptDate" mapping="CONSCRIPT_DATE" type="string"/>
			<model:field name="viabilityCode" mapping="VIABILITY_CODE" type="string" rule="require"/>
			<model:field name="address" mapping="ADDRESS" type="string"/>
			<model:field name="disabilityGenusCode" mapping="DISABILITY_GENUS_CODE" type="string" rule="require"/>
		</model:record>
	</model:dataset>
	
	
	<!-- 家庭信息 -->
	<model:dataset id="BaseinfoFamilyDataSet" cmd="com.inspur.cams.bpt.manage.cmd.BaseinfoFamilyCommand" global="true">
		<model:record fromBean="com.inspur.cams.comm.baseinfo.data.BaseinfoFamily"></model:record>
	</model:dataset>
	
	<!-- 优抚对象状态 -->
	<model:dataset id="ObjectStateDataset" enumName="OBJECT.STATE" autoLoad="true" global="true"></model:dataset>
	
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
	 
	<!-- 伤残类别代码 -->
	<model:dataset id="DisabilityTypeCodeEnum" enumName="DISABILITY.TYPE.CODE" autoLoad="true" global="true"></model:dataset>
	
	<!-- 伤残业务类型 -->
	<model:dataset id="ServiceTypeDataSet" enumName="DISABILITY.SERVICE.TYPE" autoLoad="true" global="true"></model:dataset>
		
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
	<!-- 职业 -->
	<model:dataset id="CareerDataset" enumName="CAREER.TYPE" autoLoad="true" global="true"></model:dataset>
	
	<!-- 工作单位性质 -->
	<model:dataset id="WorkUnitCharacterDataset" enumName="WORKUNIT.CHARACTER" autoLoad="true" global="true"></model:dataset>
	
	<!-- 就业状况 -->
	<model:dataset id="EmploymentCodeDataset" enumName="EMPLOYMENT.CODE" autoLoad="true" global="true"></model:dataset>
	
	<!-- 伤残性质 -->
	<model:dataset id="DisabilityCaseDataset" enumName="CASE.CODE" autoLoad="true" global="true"></model:dataset>
	<!-- 伤残等级 -->
	<model:dataset id="DisabilityLevelDataset" enumName="LEVEL.CODE" autoLoad="true" global="true"></model:dataset>
	<!-- 伤残属别 -->
	<model:dataset id="DisabilityGenusDataset" enumName="GENUS.CODE" autoLoad="true" global="true"></model:dataset>
	<!-- 伤残时期 -->
	<model:dataset id="BptWarDataset" enumName="WAR.CODE" autoLoad="true" global="true"></model:dataset>

</model:datasets>
<next:Panel height="100%"  bodyStyle="width:100%" width="100%" autoScroll="false">

	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem iconCls="save" text="保存" handler="func_SaveClick" />
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
							<td class="FieldLabel"  nowrap >身份证件号码：</td>
							<td class="FieldInput" ><input type="text"
								name="idCard" field="idCard" title="身份证件号码" style="width:135" maxlength="18" onchange="func_CheckIdCard()"/>
								<input type="hidden"	name="stype" value="01" title="身份证件号码" style="width:135"/>
								<font color="red">*</font></td>
						
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
						       <input type="text" id="domicileName" name="domicileName" field="domicileName" title="属地行政区划" style="width:90%" onclick="func_ForDomicileSelect()" readonly="readonly"/><font color="red">*</font>
						       <input type="hidden" id="domicileCode" name="domicileCode" field="domicileCode" title="属地行政区划"/></td>
						       
						   <td class="FieldLabel">户口薄住址:</td>
						   <td class="FieldInput" colspan="3"><input type="text" name="domicileAddress" onblur="changes()"  field="domicileAddress" title="户口薄住址" style="width:85%"></td>      
						</tr>
						<tr>
							<td class="FieldLabel" nowrap="nowrap">实际居住(行政区划)：</td> 
							<td class="FieldInput"><input type="text" id="apanageName" name="apanageName" field="apanageName" title="行政区划" style="width:90%" readonly="readonly" onclick="func_ForApanageSelect()"/><font color="red">*</font>
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
						       <select name="pensionCode" field="pensionCode" title="养老保障方式">
								 <option dataset="PensionDataset"></option>
							   </select>
							</td>
						</tr>
						<tr>
							<td class="FieldLabel" nowrap="nowrap">联系方式（手机）：</td>
							<td class="FieldInput" ><input type="text"
								name="telMobile" field="telMobile" title="联系方式（手机）"/></td>
								
							<td class="FieldLabel" nowrap="nowrap">其他联系方式：</td>
							<td class="FieldInput" ><input type="text"
								name="telOther" field="telOther" title="其他联系方式"/></td>
							
							<td class="FieldLabel" >邮政编码：</td>
							<td class="FieldInput" ><input type="text"
								name="postCode" field="postCode" title="邮政编码"/></td>
						</tr>
						
						<tr>
							<td class="FieldLabel" >户籍类别：</td>
							<td class="FieldInput" ><select
							id="domicileType" name="domicileType" field="domicileType" title="户籍类别" onchange="func_Type()">
								<option dataset="DomicileDataset"></option>
							</select><font color="red">*</font></td>
						
							<td class="FieldLabel" >文化程度：</td>
							<td class="FieldInput" ><select
								name="eduCode" field="eduCode">
								<option dataset="EducationDataset"></option>
							</select></td>
						
							<td class="FieldLabel" >健康状况：</td>
							<td class="FieldInput" ><select
								name="healthCode" field="healthCode" title="健康状况">
								<option dataset="HealthDataset"></option>
							</select></td>
						</tr>

						<tr>
							<td class="FieldLabel" >婚姻状况：</td>
							<td class="FieldInput" ><select
								name="marriageCode" field="marriageCode" title="婚姻状况">
								<option dataset="MarriageDataset"></option>
							</select></td>

							<td class="FieldLabel" >政治面貌：</td>
							<td class="FieldInput" colspan="3"><select
								name="politicalCode" field="politicalCode" title="政治面貌">
								<option dataset="PoliticalDataset"></option>
							</select></td>
						</tr>

						<tr>
							<td class="FieldLabel" >就业状况：</td>
							<td class="FieldInput" >
								<select name="employmentCode" field="employmentCode" id="employmentCode" title="就业状况">
										<option dataset="EmploymentCodeDataset"></option>
								</select>
							</td>
							
							<td class="FieldLabel" >年收入：</td>
							<td class="FieldInput" colspan="3"><input type="text" name="incomeYear" field="incomeYear" title="年收入"/></td>
						</tr>

						<tr id="work">
						
							<td class="FieldLabel" >工作单位名称：</td>
							<td class="FieldInput" ><input type="text"
								name="workUnitName" field="workUnitName" id="workUnitName" title="工作单位名称"/></td>
								
							<td class="FieldLabel" >工作单位性质：</td>
							<td class="FieldInput" >
									<select name="workUnitCharacter" field="workUnitCharacter" id="workUnitCharacter" title="工作单位性质">
										<option dataset="WorkUnitCharacterDataset"></option>
									</select></td>
								
							<td class="FieldLabel" nowrap="nowrap">工作单位电话：</td>
							<td class="FieldInput" ><input type="text"
								name="workUnitTel" field="workUnitTel" id="workUnitTel" title="工作单位电话"/></td>
						</tr>

						<tr id="workAddress">
							<td class="FieldLabel" >工作单位地址：</td>
							<td class="FieldInput"  colspan="5"><input type="text"
								name="workUnitAdd" field="workUnitAdd" style="width: 90%" id="workUnitAdd" title="工作单位地址"></td>
						</tr>

						<tr>
							<td class="FieldLabel" >备注(基本信息)：</td>
							<td class="FieldInput"  colspan="5"><textarea
								name="note" field="note" rows="3" style="width: 90%" title="备注(基本信息)"></textarea></td>
						</tr>

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
					       <td class="FieldLabel" >伤残类别：</td>
							<td class="FieldInput" ><select
								id="disabilityTypeCode" name="disabilityTypeCode" field="disabilityTypeCode" title="伤残类别" onchange="func_DisabilityType()">
								<option dataset="DisabilityTypeCodeEnum"></option>
							</select><font color="red">*</font></td>
							<td class="FieldLabel" >伤残等级：</td>
							<td class="FieldInput" ><select
								id="disabilityLevelCode" name="disabilityLevelCode" field="disabilityLevelCode" title="伤残等级" onchange="func_Level()">
								<option dataset="DisabilityLevelDataset"></option>
							</select><font color="red">*</font></td>
							<td class="FieldLabel" >伤残性质：</td>
							<td class="FieldInput" >
								<select name="disabilityCaseCode" field="disabilityCaseCode" title="伤残性质">
									<option dataset="DisabilityCaseDataset"></option>
								</select><font color="red">*</font></td>
					    </tr>
						<tr>
							<td class="FieldLabel" >优抚对象状态：</td>
							<td class="FieldInput" ><select
								id ="disabilityStateCode" name="disabilityStateCode" field="disabilityStateCode" title="优抚对象状态">
								<option dataset="ObjectStateDataset"></option>
							</select><font color="red">*</font></td>
							
							<td class="FieldLabel" >证书编号：</td>
							<td class="FieldInput" ><input type="text" name="disabilityNo" field="disabilityNo" id="disabilityNo" title="证书编号" maxlength="8"/><font color="red">*</font></td>
						
							<td  class="FieldLabel" >批准日期：</td>
							<td class="FieldInput"><input type="text" id="approveDate" title="批准日期" name="approveDate" field="approveDate" maxlength="10"style="width: 100px;" onpropertychange="changeDateStyle(this)"  format="Y-m-d" /><img  src="../../../../../skins/images/default/rl.gif" align="middle"  onclick="getTimes(this)" ><font color="red">*</font></td>
						</tr>

			<tr>
							<td class="FieldLabel"  nowrap="nowrap">入伍(参加工作)时间：</td>
							<td class="FieldInput" ><input
								format="Y-m-d"  type="text"
								name="relationshipType"maxlength="10"style="width: 100px;" field="conscriptDate" onpropertychange="changeDateStyle(this)"  title="入伍(参加工作时间)"/><img  src="../../../../../skins/images/default/rl.gif" align="middle"  onclick="getTimes(this)"  ></td>
								
							<td class="FieldLabel"  nowrap="nowrap">退伍时间：</td>
							<td class="FieldInput"><input
								format="Y-m-d" type="text"
								name="veteransDate" field="veteransDate"maxlength="10"style="width: 100px;"  onpropertychange="changeDateStyle(this)" title="退伍时间"/><img  src="../../../../../skins/images/default/rl.gif" align="middle"   onclick="getTimes(this)" ></td>
							<td class="FieldLabel"  nowrap="nowrap">离退休时间：</td>
							<td class="FieldInput" ><input
								format="Y-m-d" type="text"
								id ="retiredDate" name="retiredDate"maxlength="10" field="retiredDate" style="width: 100px;" onpropertychange="changeDateStyle(this)" title="离退休时间"/><img  src="../../../../../skins/images/default/rl.gif" align="middle"  onclick="getTimes(this)" ></td>
						</tr>
						<tr>
							<td class="FieldLabel" >伤残时期：</td>
							<td class="FieldInput" ><select
								name="disabilityWarCode" field="disabilityWarCode" title="伤残时期">
								<option dataset="BptWarDataset"></option>
							</select><font color="red">*</font></td>
							<td class="FieldLabel" >伤残属别：</td>
							<td class="FieldInput" colspan="3"><select
								name="disabilityGenusCode" field="disabilityGenusCode" title="伤残属别">
								<option dataset="DisabilityGenusDataset"></option>
							</select><font color="red">*</font></td>
						</tr>
						<tr>
						     <td class="FieldLabel" >致残时间：</td>
							<td class="FieldInput"><input
								format="Y-m-d" type="text"
								id="disabilityDate" name="disabilityDate" field="disabilityDate"maxlength="10"style="width: 100px;"  onpropertychange="changeDateStyle(this)" title="致残时间"/><img  src="../../../../../skins/images/default/rl.gif" align="middle" onclick="getTimes(this)" ><font
								color="red">*</font></td>
							<td class="FieldLabel" nowrap="nowrap">致残时所在单位：</td>
							<td class="FieldInput" colspan="3"><input type="text"
								name="uinitOfDisability" field="uinitOfDisability" title="致残时所在单位" style="width:86%"/></td>
						</tr>
		
		
		
						<tr>
							<td class="FieldLabel" >致残地点：</td>
							<td class="FieldInput" colspan="5"><input type="text"
								name="disabilityAdd" field="disabilityAdd" style="width:92%" title="致残地点"/><font color="red">*</font></td>
						</tr>
						<tr>		
							<td class="FieldLabel" >致残情况：</td>
							<td class="FieldInput" colspan="5"><input type="text"
								name="disabilityBody" field="disabilityBody" style="width:92%" title="致残情况"/><font color="red">*</font></td>
						</tr>
								
						<tr>
							<td class="FieldLabel" >致残原因：</td>
							<td class="FieldInput"  colspan="5"><textarea
								rows="2" name="disabilityReason"
								field="disabilityReason" style="width:92%" title="致残原因"></textarea><font color="red">*</font></td>

						</tr>
						
						<tr>
						    <td class="FieldLabel">是否孤老：</td>
							<td class="FieldInput"><select name="oldLonelyFlag"
								field="oldLonelyFlag" title="是否孤老">
								<option dataset="OldLonelyFlagEnum"></option>
							</select><font color="red">*</font></td>
							
							<!--  td class="FieldLabel">是否孤儿：</td>
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
							<td class="FieldInput"><select name="viabilityCode" id="viabilityCode"
								field="viabilityCode" title="生活能力">
								<option dataset="ViabilityCodeEnum"></option>
							</select><font color="red">*</font></td>
							
							<td class="FieldLabel" nowrap="nowrap">供养方式：</td>
							<td class="FieldInput"><select name="supportPattern"
								field="supportPattern" title="供养方式">
								<option dataset="SupportPatternEnum"></option>
							</select><font color="red">*</font></td>
						
						</tr>
						<!--
						<tr>
							<td class="FieldLabel">就业情况描述：</td>
							<td class="FieldInput" colspan="5"><textarea rows="2"
								 name="jobStatusDescribe" field="jobStatusDescribe" style="width:90%"></textarea></td>
						</tr>
                          -->
						<tr>
							<td  class="FieldLabel" >开户银行：</td>
							<td class="FieldInput">
								<select name="bank" field="bank" title="开户银行">
									<option dataset="BankEnum"></option>
								</select>
							</td>
							
							<td  class="FieldLabel" >开户名称：</td>
							<td class="FieldInput"><input type="text" name="accountName" field="accountName" title="开户名称"/></td>

							<td  class="FieldLabel" >银行账号：</td>
							<td class="FieldInput"  ><input type="text" name="accountCode" field="accountCode" style="width:90%" title="银行帐号"></input></td>
						</tr>

						<tr>
							<td class="FieldLabel">备注(类别信息)：</td>
							<td class="FieldInput" colspan="5"><textarea
								rows="3" name="note" field="note" title="备注(类别信息)" style="width:90%"></textarea></td>
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
