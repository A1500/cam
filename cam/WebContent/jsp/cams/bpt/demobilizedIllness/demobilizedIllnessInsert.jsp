<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="com.inspur.cams.comm.util.IdHelp"%>
<%
	String familyId = IdHelp.getUUID30();
	String peopleId = IdHelp.getUUID30();
%>
<html>
<head>
<title>带病回乡退伍军人业务受理</title>
<next:ScriptManager />
		<script>
			var idField='<%=request.getParameter("dataBean")%>';
			var method='<%=request.getParameter("method")%>';
		</script>
<script type="text/javascript" src="demobilizedIllnessInsert.js"></script>
</head>
<body>
<model:datasets>
	<!-- 人员信息 --> 
	<model:dataset id="BaseinfoPeopleDataSet"  cmd="com.inspur.cams.bpt.manage.cmd.BptBaseinfoPeopleQueryCommand" global="true">
		<model:record	fromBean="com.inspur.cams.comm.baseinfo.data.BaseinfoPeople"></model:record>
	</model:dataset>
	<!-- 家庭信息 -->
	<model:dataset id="BaseinfoFamilyDataSet" cmd="com.inspur.cams.bpt.manage.cmd.BaseinfoFamilyCommand" global="true">
		<model:record fromBean="com.inspur.cams.comm.baseinfo.data.BaseinfoFamily"></model:record>
	</model:dataset>
	<!-- 带病回乡退伍军人 -->
	<model:dataset id="DemobilizedIllnessDataset" cmd="com.inspur.cams.bpt.manage.cmd.BptPeopleDemobilizedIllnessQueryCommand" method="queryDemobilizedBPTPeople" global="true">
		<model:record fromBean="com.inspur.cams.bpt.base.data.BptPeopleDemobilizedIllness">
			<model:field name="insanityFlag" type="string"/>
			<model:field name="oldLonelyFlag" type="string"/>
			<model:field name="orphanFlag" type="string"/>
			<model:field name="workAbilityCode" type="string"/>
			<model:field name="workAbilityDescribe" type="string"/>
			<model:field name="viabilityCode" type="string"/>
			<model:field name="supportPattern" type="string"/>
			<model:field name="jobStatusDescribe" type="string"/>
			<model:field name="bank" type="string"/>
			<model:field name="accountName" type="string"/>
			<model:field name="accountCode" type="string"/>
		</model:record>
	</model:dataset>
	<!-- 住房状况类型 -->
	<model:dataset id="HouseStatusEnum" enumName="HOUSE.STATUS" autoLoad="true" global="true"></model:dataset>
	<!-- 房屋结构 -->
	<model:dataset id="BuildingStructureEnum" enumName="BUILDING.STRUCTURE" autoLoad="true" global="true"></model:dataset>
	<!-- 身体状况 -->
	<model:dataset id="PhysiclalStatusEnum" enumName="PHYSICLAL.STATUS"  autoLoad="true" global="true"></model:dataset>
	<!-- 是否精神病标志 -->
	<model:dataset id="InsanityFlagEnum" enumName="COMM.YESORNO"  autoLoad="true" global="true"></model:dataset>
	<!-- 孤老标志 -->
	<model:dataset id="OldLonelyFlagEnum" enumName="COMM.YESORNO"  autoLoad="true" global="true"></model:dataset>
	<!-- 孤儿标志 -->
	<model:dataset id="OrphanFlagEnum" enumName="COMM.YESORNO"  autoLoad="true" global="true"></model:dataset>
	<!-- 劳动能力代码 -->
	<model:dataset id="WorkAbilityCodeEnum" enumName="WORK.ABILITY.CODE"  autoLoad="true" global="true"></model:dataset>
	<!-- 优抚生活能力代码 -->
	<model:dataset id="ViabilityCodeEnum" enumName="VIABILITY.CODE"  autoLoad="true" global="true"></model:dataset>
	<!-- 优抚供养方式 -->
	<model:dataset id="SupportPatternEnum" enumName="SUPPORT.PATTERN"  autoLoad="true" global="true"></model:dataset>
	<!-- 家庭经济状况 -->
	<model:dataset id="FamilyEconomicsEnum" enumName="FAMILY.ECONOMICS"  autoLoad="true" global="true"></model:dataset>
	<!-- 开户银行代码 -->
	<model:dataset id="BankEnum" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_BANK'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 与户主关系 -->
	<model:dataset id="RelationshipTypeDataset"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_RELATIONSHIP_TYPE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset> 
	<!-- 性别 -->
	<model:dataset id="SexDataset"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_SEX'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset> 
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
	<model:dataset id="EducationDataset"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_EDUCATION'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset> 
		<!-- 健康状况 -->
	<model:dataset id="HealthDataset"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_HEALTH'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset> 
	<!-- 婚姻状况 -->
	<model:dataset id="MarriageDataset"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_MARRIAGE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset> 
	<!-- 政治面貌 -->
	<model:dataset id="PoliticalDataset"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_POLITICAL'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset> 
	<!-- 户籍类别 -->
	<model:dataset id="DomicileDataset"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_DOMICILE_TYPE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 医疗保障方式 -->
	<model:dataset id="SafeguardDataset"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_SAFEGUARD_TYPE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 优抚对象类别 -->
	<model:dataset id="ObjectTypeDataset"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_BPT_OBJECT_TYPE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
			<model:param name="TYPE" value='2'></model:param>
		</model:params>
	</model:dataset>
	<!-- 职业 -->
	<model:dataset id="CareerDataset"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_CAREER'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	
		<!-- 就业状况 -->
	<model:dataset id="EmploymentCodeDataset"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_EMPLOYMENT_CODE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
</model:datasets>

		<next:Panel width="100%"  autoHeight="true" autoWidth="true">
			<next:TopBar>
				<next:ToolBarItem symbol="->"></next:ToolBarItem>
				<next:ToolBarItem iconCls="save" text="保存" handler="saveClick" />
				<next:ToolBarItem iconCls="undo" text="返回" handler="returnClick" />
			</next:TopBar>
			   <next:TabPanel>
				<next:Tabs>
					<next:Panel title="人员基本信息" autoHeight="true" autoWidth="true" id="peopleTabPanel">
						<next:Html>
							<fieldset>
							<form id="BaseinfoPeopleForm" method="post"
								dataset="BaseinfoPeopleDataSet" onsubmit="return false"
								style="padding: 5px;" class="L5form">
							<table border="0" width="90%">
								<tr>
									<td class="FieldLabel" style="width: 15%">姓名：</td>
									<td class="FieldInput" style="width: 35%"><input
										type="text" id="namebase" name="namebase" field="name"/><font color="red">*</font>
									</td>
									<td class="FieldLabel" style="width: 15%">与户主关系：</td>
									<td class="FieldInput" style="width: 35%">
										<select name="relationshipType" field="relationshipType"> 
											<option dataset="RelationshipTypeDataset"></option>
										</select>
										<font color="red">*</font>
									</td>
								</tr>

								<tr>
									<td class="FieldLabel" style="width: 15%">性别：</td>
									<td class="FieldInput" style="width: 35%">
										<select name="sex" field="sex"> 
											<option dataset="SexDataset"></option>
										</select>
										<font color="red">*</font>
									</td>
									
									<td class="FieldLabel" style="width: 15%">出生日期：</td>
									<td class="FieldInput" style="width: 35%"><input
										format="Y-m-d" onclick="LoushangDate(this)"
										type="text" name="birthday" field="birthday" /><font
										color="red">*</font></td>
								</tr>

								<tr>
									<td class="FieldLabel" style="width: 15%" nowrap>身份证件号码：</td>
									<td class="FieldInput" style="width: 35%"><input
										type="text" name="idCard" field="idCard" /><font color="red">*</font>
									</td>
									
									<td class="FieldLabel" style="width: 15%">民族：</td>
									<td class="FieldInput" style="width: 35%">
										<select name="nation" field="nation"> 
											<option dataset="NationDataset"></option>
										</select>
										<font color="red">*</font>
									</td>
								</tr>

								<tr>
									<td class="FieldLabel" style="width: 15%">属地行政区划：</td>
									<td class="FieldInput" style="width: 35%"><input
										type="text" name="domicileCode" field="domicileCode" /><font
										color="red">*</font></td>
								
									<td class="FieldLabel" style="width: 15%">住址行政区划：</td>
									<td class="FieldInput" style="width: 35%"><input
										type="text" name="apanageCode" field="apanageCode" /><font
										color="red">*</font></td>
								</tr>

								<tr>
									<td class="FieldLabel" style="width: 15%">文化程度：</td>
									<td class="FieldInput" style="width: 35%">
										<select name="eduCode" field="eduCode"> 
											<option dataset="EducationDataset"></option>
										</select>
									</td>
									<td class="FieldLabel" style="width: 15%">健康状况：</td>
									<td class="FieldInput" style="width: 35%">
										<select name="healthCode" field="healthCode"> 
											<option dataset="HealthDataset"></option>
										</select>
									</td>
								</tr>

								<tr>
									<td class="FieldLabel" style="width: 15%">婚姻状况：</td>
									<td class="FieldInput" style="width: 35%">
										<select name="marriageCode" field="marriageCode"> 
											<option dataset="MarriageDataset"></option>
										</select>
									</td>
									<td class="FieldLabel" style="width: 15%">职业：</td>
									<td class="FieldInput" style="width: 35%">
										<select name="careerCode" field="careerCode">
											<option dataset="CareerDataset"></option>
										</select>
									</td>
								</tr>

								<tr>
									<td class="FieldLabel" style="width: 15%">政治面貌：</td>
									<td class="FieldInput" style="width: 35%">
										<select name="politicalCode" field="politicalCode"> 
											<option dataset="PoliticalDataset"></option>
										</select>	
									</td>
									<td class="FieldLabel" style="width: 15%">户籍类别：</td>
									<td class="FieldInput" style="width: 35%">
										<select name="domicileType" field="domicileType"> 
											<option dataset="DomicileDataset"></option>
										</select>
									</td>
								</tr>

								<tr>
									<td class="FieldLabel" style="width: 15%">手机：</td>
									<td class="FieldInput" style="width: 35%"><input
										type="text" name="telMobile" field="telMobile" /></td>
									<td class="FieldLabel" style="width: 15%">其他联系方式：</td>
									<td class="FieldInput" style="width: 35%"><input
										type="text" name="telOther" field="telOther" /></td>
								</tr>

								<tr>
									<td class="FieldLabel" style="width: 15%">住址：</td>
									<td class="FieldInput" style="width: 100%" colspan="3"><textarea
										name="address" field="address" cols="122%" rows="2"></textarea></td>
								</tr>

								<tr>
									<td class="FieldLabel" style="width: 15%">邮政编码：</td>
									<td class="FieldInput" style="width: 35%"><input
										type="text" name="postCode" field="postCode" /></td>
									<td class="FieldLabel" style="width: 15%">年收入：</td>
									<td class="FieldInput" style="width: 35%"><input
										type="text" name="incomeYear" field="incomeYear" /></td>
								</tr>

								<tr>
									<td class="FieldLabel" style="width: 15%">月收入：</td>
									<td class="FieldInput" style="width: 35%"><input
										type="text" name="incomeMonth" field="incomeMonth" /></td>
									<td class="FieldLabel" style="width: 15%">就业状况：</td>
									<td class="FieldInput" style="width: 35%">
										<select name="employmentCode" field="employmentCode">
											<option dataset="EmploymentCodeDataset"></option>
										</select>
									</td>
								</tr>

								<tr>
									<td class="FieldLabel" style="width: 15%">工作单位名称：</td>
									<td class="FieldInput" style="width: 35%"><input
										type="text" name="workUnitName" field="workUnitName" /></td>
									<td class="FieldLabel" style="width: 15%">工作单位电话：</td>
									<td class="FieldInput" style="width: 35%"><input
										type="text" name="workUnitTel" field="workUnitTel" /></td>
								</tr>

								<tr>
									<td class="FieldLabel" style="width: 15%">工作单位地址：</td>
									<td class="FieldInput" style="width: 35%" colspan="3"><textarea
										 name="workUnitAdd" field="workUnitAdd" cols="122%" ></textarea></td>
								</tr>

								<tr>
									<td class="FieldLabel" style="width: 15%">医疗保障方式：</td>
									<td class="FieldInput" style="width: 35%">
										<select name="safeguardType" field="safeguardType"> 
											<option dataset="SafeguardDataset"></option>
										</select>
										<font color="red">*</font></td>
									<td class="FieldLabel" style="width: 15%">医疗保险号：</td>
									<td class="FieldInput" style="width: 35%"><input
										type="text" name="medicalCode" field="medicalCode" /></td>
								</tr>
									
								<tr>
									<td class="FieldLabel" style="width: 15%">备注：</td>
									<td class="FieldInput" style="width: 35%" colspan="3"><textarea
										 name="note" field="note" cols="122%" rows="3" ></textarea></td>
								</tr>
								
		  						 <!--人员ID -->
								<input type="hidden" name="peopleId" field="peopleId" id="peopleId" value="<%=peopleId%>">
								<!--家庭ID -->
								<input type="hidden" name="familyId" field="familyId" id="familyId" value="<%=familyId%>">
								<!--身份证件类型-->
								<input type="hidden" name="idCardType" field="idCardType">
								<!--城市低保标志 -->
								<input type="hidden" name="cityResiFlag" field="cityResiFlag">
								<!--农村低保标志 -->
								<input type="hidden" name="ruralResiFlag" field="ruralResiFlag">
								<!--农村五保标志 -->
								<input type="hidden" name="ruralFiveguaFlag"
									field="ruralFiveguaFlag">
								<!--伤残标志 -->
								<input type="hidden" name="disabilityFlag"
									field="disabilityFlag">
								<!--三红标志 -->
								<input type="hidden" name="redaFlag" field="redaFlag">
								<!--遗属标志 -->
								<input type="hidden" name="dependantFlag" field="dependantFlag">
								<!--在乡复员军人标志 -->
								<input type="hidden" name="demobilizedFlag"
									field="demobilizedFlag">
								<!--参战、参试标志-->
								<input type="hidden" name="warFlag" field="warFlag">
								<!--伤残证书编号-->
								<input type="hidden" name="disabilityNo" field="disabilityNo">
								<!--三红证书编号-->
								<input type="hidden" name="redaNo" field="redaNo">
								<!--遗属证书编号 -->
								<input type="hidden" name="dependantNo" field="dependantNo">
								<!--在乡复员军人证书编号-->
								<input type="hidden" name="demobilizedNo" field="demobilizedNo">
								<!--参战参试证书编号-->
								<input type="hidden" name="warNo" field="warNo">
								<!--伤残状态-->
								<input type="hidden" name="disabilityStateCode"
									field="disabilityStateCode">
								<!--伤残等级-->
								<input type="hidden" name="disabilityLevelCode"
									field="disabilityLevelCode">	
								<!--三红状态-->
								<input type="hidden" name="redaStateCode" field="redaStateCode">
								<!--遗属状态-->
								<input type="hidden" name="dependantStateCode"
									field="dependantStateCode">
								<!--在乡复员军人状态-->
								<input type="hidden" name="demobilizedStateCode"
									field="demobilizedStateCode">
								<!--参战、参试状态-->
								<input type="hidden" name="warStateCode" field="warStateCode">
								<!--个人状态-->
								<input type="hidden" name="personalStatsTag"
									field="personalStatsTag">
								<!--录入人ID-->
								<input type="hidden" name="regId" field="regId">
								<!--录入时间-->
								<input type="hidden" name="regTime" field="regTime">
								<!--修改人ID-->
								<input type="hidden" name="modId" field="modId">
								<!--修改时间:-->
								<input type="hidden" name="modTime" field="modTime">

							</table>
							</form>
							</fieldset>
						</next:Html>
					</next:Panel>
			
<next:Panel  title="家庭信息" autoHeight="true" autoWidth="true" id="familyTabPanel" >
	<next:Html>
		<form id="editForm" dataset="BaseinfoFamilyDataSet" onsubmit="return false" style="padding: 5px;" class="L5form">
		<table border="1"  width="90%" >

	   		<tr>
			
				<td  class="FieldLabel" >户主姓名：</td>
				<td class="FieldInput"><input type="text" id="patriarchName" name="patriarchName" field="patriarchName"/><font color="red">*</font> </td>
				<td  class="FieldLabel" >身份证号：</td>
				<td class="FieldInput"><input type="text" name="idCard" field="idCard"  /><font color="red">*</font> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >属地行政区划：</td>
				<td class="FieldInput"><input type="text" name="apanageCode" field="apanageCode"  /><font color="red">*</font> </td>
			
				<td  class="FieldLabel" >户籍行政区划：</td>
				<td class="FieldInput"><input type="text" name="domicileCode" field="domicileCode"  /><font color="red">*</font> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >人口数量：</td>
				<td class="FieldInput"><input type="text" name="popNum" field="popNum" /><font color="red">*</font> </td>
				
				<td  class="FieldLabel" >邮政编码：</td>
				<td class="FieldInput"><input type="text" name="postCode" field="postCode"  /> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel">家庭住址：</td>
				<td class="FieldInput"  colspan="3"><textarea rows="2" cols="122%" name="familyAdd" field="familyAdd"></textarea> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >家庭电话：</td>
				<td class="FieldInput"><input type="text" name="telFamily" field="telFamily"  /> </td>
				<td  class="FieldLabel" >手机：</td>
				<td class="FieldInput"><input type="text" name="telMobile" field="telMobile"  /> </td>
				
			</tr>
	   		<tr>
				<td  class="FieldLabel" >其他联系电话：</td>
				<td class="FieldInput"><input type="text" name="telOther" field="telOther"  /> </td>
			
				<td  class="FieldLabel" >家庭年总收入：</td>
				<td class="FieldInput"><input type="text" name="incomeTotalYear" field="incomeTotalYear"  /> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" nowrap="nowrap">家庭年人均收入：</td>
				<td class="FieldInput"><input type="text" name="incomePeopleYear" field="incomePeopleYear"  /> </td>
			
				<td  class="FieldLabel" nowrap="nowrap">家庭月总收入：</td>
				<td class="FieldInput"><input type="text" name="incomeTotalMonth" field="incomeTotalMonth"  /> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >家庭月人均收入：</td>
				<td class="FieldInput"><input type="text" name="incomePeopleMonth" field="incomePeopleMonth"  /> </td>
			
				<td  class="FieldLabel" >住房状况类型：</td>
				<td class="FieldInput">
						<select name="houseingStateType" field="houseingStateType">
							<option dataset="HouseStatusEnum"></option>
						</select>
				</td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >建筑面积：</td>
				<td class="FieldInput"><input type="text" name="floorArea" field="floorArea"  /> </td>
			
				<td  class="FieldLabel" >人均建筑面积：</td>
				<td class="FieldInput"><input type="text" name="floorAreaPeople" field="floorAreaPeople"  /> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >房屋结构：</td>
				<td class="FieldInput" colspan="3">
					<select name="houseFrame" field="houseFrame">
						<option dataset="BuildingStructureEnum"></option>
					</select>
				</td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >备注：</td>
				<td class="FieldInput" colspan="3" ><textarea rows="3" cols="122%" name="note" field="note" ></textarea> </td>
			
			</tr>
			
								<!--身份证件类型-->
								<input type="hidden" name="idCardType" field="idCardType">
								<!--家庭状态标志-->
								<input type="hidden" name="familyStateFlag" field="familyStateFlag">
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
<next:Panel  title="带病回乡退伍军人" autoHeight="true" autoWidth="true">
	<next:Html>
		<form id="editForm"   dataset="DemobilizedIllnessDataset" onsubmit="return false" style="padding: 5px;" class="L5form">
		<table border="1"  width="90%" >
		
	   		<tr>
			
				<td  class="FieldLabel" >入伍时间：</td>
				<td class="FieldInput"><input type="text" name="conscriptDate" field="conscriptDate" format="Y-m-d" onclick="LoushangDate(this)"/> </td>
			
				<td  class="FieldLabel" >退伍时间：</td>
				<td class="FieldInput"><input type="text" name="decruitmentDate" field="decruitmentDate" format="Y-m-d" onclick="LoushangDate(this)"/> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >原部队代号：</td>
				<td class="FieldInput"><input type="text" name="forcesNo" field="forcesNo"  /> </td>
			
				<td  class="FieldLabel" >职务：</td>
				<td class="FieldInput"><input type="text" name="position" field="position"  /> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >退伍证号：</td>
				<td class="FieldInput"><input type="text" name="asdpNo" field="asdpNo"  /> </td>
				<td  class="FieldLabel" >身体状况：</td>
				<td class="FieldInput">
					<select name="physiclalStatus" field="physiclalStatus">
						<option dataset="PhysiclalStatusEnum"></option>
					</select></td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >患病信息：</td>
				<td class="FieldInput" colspan="3"><textarea rows="2" cols="122%" name="illessInfo" field="illessInfo"></textarea></td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >家庭经济状况：</td>
				<td class="FieldInput">
					<select name="familyEconomics" field="familyEconomics">
						<option dataset="FamilyEconomicsEnum"></option>
					</select></td>
				<td  class="FieldLabel" >是否精神病：</td>
				<td class="FieldInput">
					<select name="insanityFlag" field="insanityFlag">
						<option dataset="InsanityFlagEnum"></option>
					</select></td>
			</tr>
			<tr>
				<td  class="FieldLabel" >孤老标志：</td>
				<td class="FieldInput">
					<select name="oldLonelyFlag" field="oldLonelyFlag">
						<option dataset="OldLonelyFlagEnum"></option>
					</select><font color="red">*</font> </td>
				<td  class="FieldLabel" >孤儿标志：</td>
				<td class="FieldInput">
					<select name="orphanFlag" field="orphanFlag">
						<option dataset="OrphanFlagEnum"></option>
					</select><font color="red">*</font> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >劳动能力：</td>
				<td class="FieldInput">
					<select name="workAbilityCode" field="workAbilityCode">
						<option dataset="WorkAbilityCodeEnum"></option>
					</select><font color="red">*</font> </td>
			
				<td  class="FieldLabel" >优抚生活能力：</td>
				<td class="FieldInput">
					<select name="viabilityCode" field="viabilityCode">
						<option dataset="ViabilityCodeEnum"></option>
					</select><font color="red">*</font> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" nowrap="nowrap">劳动能力描述：</td>
				<td  class="FieldInput" colspan="3"><textarea rows="2" cols="122%" name="workAbilityDescribe" field="workAbilityDescribe"></textarea></td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >优抚供养方式：</td>
				<td class="FieldInput" colspan="3">
					<select name="supportPattern" field="supportPattern">
						<option dataset="SupportPatternEnum"></option>
					</select><font color="red">*</font> </td>
			</tr>
			<tr>
				<td  class="FieldLabel" >就业情况描述：</td>
				<td class="FieldInput" colspan="3"><textarea rows="2" cols="122%" name="jobStatusDescribe" field="jobStatusDescribe"></textarea></td>
			</tr>
			
			<tr>
				<td  class="FieldLabel" >开户银行：</td>
				<td class="FieldInput">
					<select name="bank" field="bank">
						<option dataset="BankEnum"></option>
					</select>
				</td>
				
				<td  class="FieldLabel" >开户名称：</td>
				<td class="FieldInput"><input type="text" name="accountName" field="accountName" /> </td>
			</tr>
			
			<tr>
				<td  class="FieldLabel" >银行账号：</td>
				<td class="FieldInput" colspan="3"><input type="text" name="accountCode" field="accountCode" style="width:500" ></input></td>
			</tr>
			
			<tr>
				<td  class="FieldLabel" >批准日期：</td>
				<td class="FieldInput"><input type="text" name="approvalDate" field="approvalDate" disabled="disabled"/> </td>
				<td  class="FieldLabel" >注销日期：</td>
				<td class="FieldInput" colspan="3"><input type="text" name="cancellationDate" field="cancellationDate" disabled="disabled"/> </td>
			</tr>
	   		<tr>
				<td  class="FieldLabel" >备注：</td>
				<td class="FieldInput" colspan="3"><textarea rows="2" cols="122%" name="note" field="note"></textarea></td>
			</tr>
						
		</table>
		</form>
   </next:Html>
</next:Panel>
				</next:Tabs>
			</next:TabPanel>
		</next:Panel>

</body>
</html>
