<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<title>家庭成员信息查看</title>
<next:ScriptManager />
		<script>
		    var familyId='<%=request.getParameter("familyId")%>';
			var peopleId='<%=request.getParameter("peopleId")%>';
			
		</script>
<script type="text/javascript" src="familyPeopleInfo.js"></script>
</head>
<body>
<model:datasets>
	<model:dataset id="queryTotalDataset" cmd="com.inspur.cams.bpt.manage.cmd.BptBaseinfoPeopleQueryCommand" method="queryPeopleNumInfo" global="true">
		<model:record fromBean="com.inspur.cams.comm.baseinfo.data.BaseinfoPeople">
				<model:field name="CHILD" type="string" />
				<model:field name="ALLPEOPLE" type="string" />
				<model:field name="OLD" type="string" />
		</model:record>
	</model:dataset>
     <!-- 家庭信息 -->
	<model:dataset id="BaseinfoFamilyDataSet" cmd="com.inspur.cams.bpt.manage.cmd.BptBaseinfoPeopleQueryCommand"
		method="queryFamilyInfo" global="true">
		<model:record fromBean="com.inspur.cams.comm.baseinfo.data.BaseinfoFamily">
		   
		</model:record>
	</model:dataset>
	<!-- 人员信息 -->
	<model:dataset id="BaseinfoPeopleDataSet" cmd="com.inspur.cams.bpt.manage.cmd.BptBaseinfoPeopleQueryCommand" method="queryPeopleInfo" global="true">
		<model:record fromBean="com.inspur.cams.comm.baseinfo.data.BaseinfoPeople">
		   <model:field name="domicileName" type="string"/>
		   <model:field name="apanageName" type="string"/>
		</model:record>
	</model:dataset>
	<!-- 在乡复员军人信息 -->
	<model:dataset id="PeopleDemobilizedDataset" cmd="com.inspur.cams.bpt.manage.cmd.BptPeopleDemobilizedQueryCommand" global="true" method="queryDemobilizedBptPeople">
		<model:record fromBean="com.inspur.cams.bpt.base.data.BptPeopleDemobilized">
			<model:field name="demobilizedStateCode" type="string" rule="require"/>
			<model:field name="demobilizedNo" type="string" rule="require"/>
			
			<model:field name="insanityFlag" type="string" rule="require"/>
			<model:field name="oldLonelyFlag" type="string" rule="require"/>
			<model:field name="orphanFlag" type="string" rule="require"/>
			<model:field name="workAbilityCode" type="string" rule="require"/>
			<model:field name="workAbilityDescribe" type="string"/>
			<model:field name="viabilityCode" type="string" rule="require"/>
			<model:field name="supportPattern" type="string" rule="require"/>
			<model:field name="jobStatusDescribe" type="string"/>
			<model:field name="bank" type="string"/>
			<model:field name="accountName" type="string"/>
			<model:field name="accountCode" type="string"/>
		</model:record>
	</model:dataset>
	
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
	<model:dataset id="KoeanwarEnum" enumName="COMM.YESORNO"  autoLoad="true" global="true"></model:dataset>
	<!-- 优抚对象状态 -->
	<model:dataset id="ObjectStateDataset" enumName="OBJECT.STATE" autoLoad="true" global="true"></model:dataset>
	
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
	<model:dataset id="HealthDataset" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_HEALTH'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	
	<!-- 婚姻状况 -->
	<model:dataset id="MarriageDataset" enumName="MARRIAGE.STATE" autoLoad="true" global="true"></model:dataset>
	
	<!-- 政治面貌 -->
	<model:dataset id="PoliticalDataset" enumName="POLITICAL.LANDSCAPE" autoLoad="true" global="true"></model:dataset>
	
	<!-- 户籍类别 -->
	<model:dataset id="DomicileDataset" enumName="DOMICILE.TYPE" autoLoad="true" global="true"></model:dataset>
	
	<!-- 医疗保障方式 -->
	<model:dataset id="SafeguardDataset" enumName="COMM.MEDICAL_STATUS" autoLoad="true" global="true"></model:dataset>
	
	<!-- 职业 -->
	<model:dataset id="CareerDataset" enumName="CAREER.TYPE" autoLoad="true" global="true"></model:dataset>
	
	<!-- 工作单位性质 -->
	<model:dataset id="WorkUnitCharacterDataset" enumName="WORKUNIT.CHARACTER" autoLoad="true" global="true"></model:dataset>
	
	<!-- 就业状况 -->
	<model:dataset id="EmploymentCodeDataset" enumName="EMPLOYMENT.CODE" autoLoad="true" global="true"></model:dataset>
	
	<!-- 属于时期-->
	<model:dataset id="warDs"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='dic_bpt_war'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
</model:datasets>
<next:Panel  height="10%" width="100%"  autoScroll="true" id="querytotal">
				<next:Html>
					<form id="queryTotalForm" method="post"
						 onsubmit="return false" dataset="queryTotalDataset"
						style="padding: 5px;" class="L5form">
					<table border="0" width="98%">
					     <tr>
							<td class="FieldLabel"  nowrap style="width:15%">家庭人口数：</td>
							<td class="FieldInput" style="width:15%" nowrap="nowrap"><label field="ALLPEOPLE" ></label></td>
						    <td class="FieldLabel" style="width:15%">18岁以下人数：</td>
							<td class="FieldInput" style="width:15%"><label field="CHILD"></label></td>
							<td class="FieldLabel" nowrap style="width:15%">60岁以上人数：</td>
							<td class="FieldInput"  style="width:15%"><label name="relationshipType" field="OLD"  ></label></td>
						</tr>
						</table>
				   </form>
			</next:Html>
		</next:Panel>
<next:Panel title="家庭成员信息"  height="100%">
   <next:GridPanel id="editGridPanel" name="baseinfopeopleGrid" dataset="BaseinfoPeopleDataSet" height="25%">
	<next:Columns>
	    <next:RowNumberColumn header="序号" width="45"/>
	    <next:Column id="domicileName" header="属地行政区划" field="domicileName" width="120" >
			<next:TextField allowBlank="false" />
		</next:Column>
        <next:Column id="name" header="姓名" field="name" width="60">
			<next:TextField allowBlank="false" />
		</next:Column>
        <next:Column id="idCard" header="身份证件号码" field="idCard" width="135" >
			<next:TextField allowBlank="false" />
		</next:Column>
	    <next:Column id="sex" header="性别" field="sex" width="35"  dataset="SexDataset" >
			<next:TextField allowBlank="false" />
		</next:Column>
	    <next:Column id="birthday" header="出生日期" field="birthday" width="90" >
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="nation" header="民族" field="nation" width="70" dataset="NationDataset" >
			<next:TextField allowBlank="false" />
		</next:Column>
		<next:Column id="relationshipType" header="与户主关系" field="relationshipType" width="90" dataset="RelationshipTypeDataset" >
			<next:TextField allowBlank="false" />
		</next:Column> 
		<next:Column id="eduCode" header="文化程度" field="eduCode" width="60"  dataset="EducationDataset">
			<next:TextField  />
		</next:Column>
	    <next:Column id="marriageCode" header="婚姻状况" field="marriageCode" width="90" hidden="true" dataset="MarriageDataset" >
			<next:TextField  />
		</next:Column>
	    <next:Column id="careerCode" header="职业" field="careerCode" width="120" dataset="CareerDataset">
			<next:TextField  />
		</next:Column>
	    <next:Column id="domicileType" header="户籍类别" field="domicileType" width="60" dataset="DomicileDataset" >
			<next:TextField  />
		</next:Column>
	    <next:Column id="telMobile" header="手机" field="telMobile" width="90" >
			<next:TextField  />
		</next:Column>
	</next:Columns>
</next:GridPanel>
<next:Panel  autoHeight="true" height="75%">
   <next:Html>
      <form id="BaseinfoPeopleForm" method="post" dataset="BaseinfoPeopleDataSet" onsubmit="return false" style="padding: 5px;" class="L5form">
					<table border="0" width="99%">
					  <tr>
							<td class="FieldLabel"  nowrap >身份证件号码：</td>
							<td class="FieldInput" ><label field="idCard" title="身份证件号码"></label></td>
						    <td class="FieldLabel" >姓名：</td>
							<td class="FieldInput" ><label field="name" title="姓名"></label></td>
							<td class="FieldLabel" nowrap>与户主关系：</td>
							<td class="FieldInput" ><label name="relationshipType" field="relationshipType" dataset="RelationshipTypeDataset"></label>
							</td>
					  </tr>
                      <tr>
							<td class="FieldLabel" >出生日期：</td>
							<td class="FieldInput" ><label name="birthday" field="birthday"></label></td>
						    <td class="FieldLabel" >性别：</td>
							<td class="FieldInput" ><label name="sex" 	field="sex" dataset="SexDataset"></label></td>
							<td class="FieldLabel" >民族：</td>
							<td class="FieldInput" ><label name="nation" field="nation" title="民族" dataset="NationDataset"></label></td>
					  </tr>
					  <tr>
						   <td class="FieldLabel" >属地行政区划：</td>
						   <td class="FieldInput" > <label name="domicileName" field="domicileName"></label></td>
						   <td class="FieldLabel" >医疗保障方式：</td>
						   <td class="FieldInput" ><label name="safeguardType" field="safeguardType"  dataset="SafeguardDataset"></label></td>
                            <td class="FieldLabel">医疗保险号：</td>
							<td class="FieldInput"><label name="medicalCode" field="medicalCode"></label>
						</tr>
						<tr>
							
						    <td class="FieldLabel" >住址(行政区划)：</td> 
							<td class="FieldInput"><label name="apanageName" field="apanageName"></label></td>
							<td class="FieldLabel">住址:</td>
							<td class="FieldInput" colspan="3"><label name="address" field="address" style="width:85%"></label></td>
						</tr>
						<tr>
							<td class="FieldLabel" nowrap="nowrap">联系方式（手机）：</td>
							<td class="FieldInput" ><label  name="telMobile" field="telMobile"></label></td>
							<td class="FieldLabel" nowrap="nowrap">其他联系方式：</td>
							<td class="FieldInput" ><label name="telOther" field="telOther"></label></td>
							<td class="FieldLabel" >邮政编码：</td>
							<td class="FieldInput" ><label name="postCode" field="postCode"></label></td>
						</tr>
						<tr>
							<td class="FieldLabel" >户籍类别：</td>
							<td class="FieldInput" ><label name="domicileType" field="domicileType" dataset="DomicileDataset"></label></td>
						    <td class="FieldLabel" >文化程度：</td>
							<td class="FieldInput" ><label name="eduCode" field="eduCode" dataset="EducationDataset"></label></td>
						    <td class="FieldLabel" >健康状况：</td>
							<td class="FieldInput" ><label name="healthCode" field="healthCode" dataset="HealthDataset"></label></td>
						</tr>
						<tr>
							<td class="FieldLabel" >婚姻状况：</td>
							<td class="FieldInput" ><label name="marriageCode" field="marriageCode" dataset="MarriageDataset"></label></td>
						<!-- 	<td class="FieldLabel" >职业：</td>
							<td class="FieldInput" ><label name="careerCode" field="careerCode" dataset="CareerDataset"></label></td> -->
                            <td class="FieldLabel" >政治面貌：</td>
							<td class="FieldInput"  colspan="3"><label name="politicalCode" field="politicalCode" dataset="PoliticalDataset"></label></td>
						</tr>
                        <tr>
							<td class="FieldLabel" >就业状况：</td>
							<td class="FieldInput" ><label name="employmentCode" field="employmentCode" dataset="EmploymentCodeDataset"></label></td>
							<td class="FieldLabel" >年收入：</td>
							<td class="FieldInput" colspan="3"><label name="incomeYear" field="incomeYear"></label></td>
						</tr>
                        <tr>
						    <td class="FieldLabel" >工作单位名称：</td>
							<td class="FieldInput" ><label name="workUnitName" field="workUnitName"></label></td>
							<td class="FieldLabel" >工作单位性质：</td>
							<td class="FieldInput" ><label name="workUnitCharacter" field="workUnitCharacter" dataset="WorkUnitCharacterDataset"></label></td>
							<td class="FieldLabel" nowrap="nowrap">工作单位电话：</td>
							<td class="FieldInput" ><label name="workUnitTel" field="workUnitTel"></label></td>
						</tr>
                        <tr>
							<td class="FieldLabel" >工作单位地址：</td>
							<td class="FieldInput"  colspan="5"><label name="workUnitAdd" field="workUnitAdd" style="width: 90%"></label></td>
						</tr>
                        <tr>
							<td class="FieldLabel" >备注：</td>
							<td class="FieldInput"  colspan="5"><label name="note" field="note" rows="3" style="width: 90%"></label></td>
						</tr>
                      </table>
					</form>
   </next:Html>
</next:Panel>

</next:Panel>
			
</body>
</html>
