 <%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils" %>
<%@ page import="com.inspur.cams.bpt.manage.cmd.BptBaseinfoPeopleCommand"%>
<%
BptBaseinfoPeopleCommand command = new BptBaseinfoPeopleCommand();
String photoId = command.findPhotoId(request.getParameter("peopleId"));
String photoTable = "COM_PHOTO";
if(photoId!=null && photoId.length()>0){
photoTable = photoTable+"_"+photoId.substring(0,6);
}
%>
<html>
<head>
<title>查看人员基本信息</title>
<next:ScriptManager />
		<script>
			var peopleId='<%=request.getParameter("peopleId")%>';
			var familyId='<%=request.getParameter("familyId")%>';
			var objectType='<%=request.getParameter("objectType")%>';
		</script>
<script type="text/javascript" src="peopleInfoDetail.js"></script>
</head>
<body>
<model:datasets>
    <!-- 人员信息 -->
	<model:dataset id="BaseinfoPeopleDataSet" cmd="com.inspur.cams.bpt.manage.cmd.BptBaseinfoPeopleQueryCommand" method="queryPeopleInfo" global="true">
		<model:record fromBean="com.inspur.cams.comm.baseinfo.data.BaseinfoPeople">
				<model:field name="domicileName" type="string" />
				<model:field name="apanageName" type="string" />
		</model:record>
	</model:dataset>
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

	<!-- 伤残信息 -->
	<model:dataset id="BptPeopleDisabilityDataSet" cmd="com.inspur.cams.bpt.manage.cmd.BptPeopleDisabilityQueryCommand" method="queryPeopleDisabilityInfo" global="true">
		<model:record fromBean="com.inspur.cams.bpt.base.data.BptPeopleDisability">
			<model:field name="disabilityTypeCode" type="string" rule="require"/>
			<model:field name="insanityFlag" type="string" rule="require"/>
			<model:field name="oldLonelyFlag" type="string" rule="require"/>
			<model:field name="toWorkDate" type="string" />
			<model:field name="retiredDate" type="string" />
			<!--model:field name="orphanFlag" type="string" rule="require"/-->
			<model:field name="workAbilityCode" type="string" rule="require"/>
			<model:field name="workAbilityDescribe" type="string" />
			<model:field name="viabilityCode" type="string" rule="require"/>
			<model:field name="supportPattern" type="string" rule="require"/>
			<model:field name="jobStatusDescribe" type="string" rule="require"/>
			<model:field name="bank" type="string"/>
			<model:field name="accountName" type="string" />
			<model:field name="accountCode" type="string" />
			<model:field name="disabilityStateCode" type="string" rule="require" rule="require"/>
			<model:field name="disabilityNo" type="string" rule="require" rule="require"/>
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
	
	<!-- 优抚对象状态 -->
	<model:dataset id="ObjectStateDataset" enumName="OBJECT.STATE" autoLoad="true" global="true"></model:dataset>
	
	<!-- 伤残性质 -->
	<model:dataset id="DisabilityCaseDataset" enumName="CASE.CODE" autoLoad="true" global="true"></model:dataset>
	<!-- 伤残等级 -->
	<model:dataset id="DisabilityLevelDataset" enumName="LEVEL.CODE" autoLoad="true" global="true"></model:dataset>
	<!-- 伤残属别 -->
	<model:dataset id="DisabilityGenusDataset" enumName="GENUS.CODE" autoLoad="true" global="true"></model:dataset>
	<!-- 伤残时期 -->
	<model:dataset id="BptWarDataset" enumName="WAR.CODE" autoLoad="true" global="true"></model:dataset>
	<!-- 是否抗美援朝 -->
	<model:dataset id="isKoreaWarDataset" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
	
	<!-- 遗属信息 -->
	<model:dataset id="DependantDataset" cmd="com.inspur.cams.bpt.manage.cmd.BptPeopleDependantQueryCommand" method="queryDependantInfo" global="true">
		<model:record fromBean="com.inspur.cams.bpt.base.data.BptPeopleDependant">
			<model:field name="dependantStateCode" type="string" rule="require"/>
			<model:field name="dependantNo" type="string" rule="require"/>
			<model:field name="handicapFlag" type="string" rule="require"/>
			<model:field name="dependantTypeCode" type="string" rule="require"/>
			<model:field name="oldLonelyFlag" type="string" rule="require"/>
			<model:field name="orphanFlag" type="string" rule="require"/>
			<model:field name="workAbilityCode" type="string" rule="require"/>
			<model:field name="workAbilityDescribe" type="string" />
			<model:field name="viabilityCode" type="string" rule="require"/>
			<model:field name="supportPattern" type="string" rule="require"/>
			<model:field name="jobStatusDescribe" type="string" />
			<model:field name="bank" type="string"/>
			<model:field name="accountName" type="string"/>
			<model:field name="accountCode" type="string" rule="number"/>
		</model:record>
	</model:dataset>
	
	<!-- 优抚对象状态 -->
	<model:dataset id="ObjectStateDataset" enumName="OBJECT.STATE" autoLoad="true" global="true"></model:dataset>
	<!-- 三属类别 -->
	<model:dataset id="DependantTypeDataset" enumName="DEPENDANT.CODE" autoLoad="true" global="true"></model:dataset>
	<!-- 与牺牲病故军人关系 -->
	<model:dataset id="RelationTypeEnum" enumName="RELATIONSHIP.TYPE" autoLoad="true" global="true"></model:dataset>
	<!-- 是否残疾 -->
	<model:dataset id="HandicapFlagEnum" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
	<!-- 是否正在上学 -->
	<model:dataset id="StudnetFlagEnum" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
	<!-- 是否持证人 -->
	<model:dataset id="HolderFlagEnum" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
	
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
	<!-- 是否抗美援朝-->
	<model:dataset id="KoeanwarEnum" enumName="COMM.YESORNO"  autoLoad="true" global="true"></model:dataset>
	<!-- 优抚对象状态 -->
	<model:dataset id="ObjectStateDataset" enumName="OBJECT.STATE" autoLoad="true" global="true"></model:dataset>
	<!-- 属于时期-->
	<model:dataset id="warDs" enumName="DEMOBILIZED.BELONGDATE" autoLoad="true" global="true"></model:dataset>
	
	<!-- 带病回乡退伍军人 -->
	<model:dataset id="DemobilizedIllnessDataset" cmd="com.inspur.cams.bpt.manage.cmd.BptPeopleDemobilizedIllnessQueryCommand" method="queryDemobilizedIllnessBPTPeople" global="true">
		<model:record fromBean="com.inspur.cams.bpt.base.data.BptPeopleDemobilizedIllness">
			<model:field name="demobilizedStateCode" type="string" rule="require" />
			<model:field name="demobilizedNo" type="string" rule="require" />

			<model:field name="insanityFlag" type="string" rule="require" />
			<model:field name="oldLonelyFlag" type="string" rule="require" />
			<model:field name="orphanFlag" type="string" rule="require" />
			<model:field name="workAbilityCode" type="string" rule="require" />
			<model:field name="workAbilityDescribe" type="string" />
			<model:field name="viabilityCode" type="string" rule="require" />
			<model:field name="supportPattern" type="string" rule="require" />
			<model:field name="jobStatusDescribe" type="string" />
			<model:field name="bank" type="string" />
			<model:field name="accountName" type="string" />
			<model:field name="accountCode" type="string" />
			<model:field name="healthStateName" type="string"/>
		</model:record>
	</model:dataset>
	<!-- 身体状况 -->
	<model:dataset id="PhysiclalStatusEnum" enumName="PHYSICLAL.STATUS" autoLoad="true" global="true"></model:dataset>
	<!-- 家庭经济状况 -->
	<model:dataset id="FamilyEconomicsEnum" enumName="FAMILY.ECONOMICS" autoLoad="true" global="true"></model:dataset>
	<!-- 是否参战 -->
	<model:dataset id="isWarEnum" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
	<!-- 是否涉核 -->
	<model:dataset id="isInnuclearEnum" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
	
	<!-- 参战人员信息 -->
	<model:dataset id="dsWar" cmd="com.inspur.cams.bpt.manage.cmd.BptPeopleWarQueryCommand" global="true" method="queryPeopleWarInfo">
		<model:record fromBean="com.inspur.cams.bpt.base.data.BptPeopleWar">
			<model:field name="warNo" type="string" />
			<model:field name="approveDate" type="string" />
			<model:field name="insanityFlag" type="string" />
			<model:field name="oldLonelyFlag" type="string" />
			<model:field name="orphanFlag" type="string" />
			<model:field name="workAbilityCode" type="string" />
			<model:field name="workAbilityDescribe" type="string" />
			<model:field name="viabilityCode" type="string" />
			<model:field name="supportPattern" type="string" />
			<model:field name="jobStatusDescribe" type="string" />
			<model:field name="bank" type="string" />
			<model:field name="accountName" type="string" />
			<model:field name="accountCode" type="string" />
			<model:field name="warStateCode" type="string" />
			 <model:field name="healthStateName" type="string"/>
		</model:record>
	</model:dataset>
	<!--生活状况代码-->
	<model:dataset id="dsLife" enumName="LIFE.LIFE_STATE_CODE" autoLoad="true"></model:dataset>

	<!--参战类别代码-->
	<model:dataset id="dsWarData" cmd="com.inspur.cams.bpt.manage.cmd.DicHealthQueryCommand" global="true" autoLoad="true" method="getAllWaraData">
		<model:record fromBean="com.inspur.cams.bpt.base.data.DicHealth">
			<model:field name="value" mapping="CODE" />
			<model:field name="text" mapping="NAME" />
		</model:record>
	</model:dataset>
	<!-- 健康状况 -->
	<model:dataset id="HealthDataset" enumName="HEALTH.TYPE"
		autoLoad="true" global="true"></model:dataset>
	<model:dataset id="dsTested"
		cmd="com.inspur.cams.bpt.manage.cmd.BptPeopleTestedQueryCommand"
		global="true" method="queryPeopleTestedInfo" >
		<model:record fromBean="com.inspur.cams.bpt.base.data.BptPeopleTested">
			<model:field name="insanityFlag" type="string" />
			<model:field name="oldLonelyFlag" type="string" />
			<model:field name="orphanFlag" type="string" />
			<model:field name="workAbilityCode" type="string" />
			<model:field name="workAbilityDescribe" type="string" />
			<model:field name="viabilityCode" type="string" />
			<model:field name="supportPattern" type="string" />
			<model:field name="jobStatusDescribe" type="string" />
			<model:field name="bank" type="string" />
			<model:field name="accountName" type="string" />
			<model:field name="accountCode" type="string" />
			<model:field name="warStateCode" type="string" />
			<model:field name="warNo" type="string" />
			<model:field name="healthStateName" type="string"/>
		</model:record>
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
	<!-- 婚姻状况 -->
	<model:dataset id="MarriageDataset" enumName="MARRIAGE.STATE" autoLoad="true" global="true"></model:dataset>
	<!-- 政治面貌 -->
	<model:dataset id="PoliticalDataset" enumName="POLITICAL.LANDSCAPE" autoLoad="true" global="true"></model:dataset>
	<!-- 户籍类别 -->
	<model:dataset id="DomicileDataset" enumName="DOMICILE.TYPE" autoLoad="true" global="true"></model:dataset>
	<!-- 医疗保障方式 -->
	<model:dataset id="SafeguardDataset" enumName="COMM.MEDICAL_STATUS" autoLoad="true" global="true"></model:dataset>
	
	<!-- 伤残等级 -->
	<model:dataset id="DisabilityLevelDataset" enumName="LEVEL.CODE" autoLoad="true" global="true"></model:dataset>
	
	
	<!-- 职业 -->
	<model:dataset id="CareerDataset" enumName="CAREER.TYPE"
		autoLoad="true" global="true"></model:dataset>

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
	<!--生活状况代码-->
	<model:dataset id="dsLife" enumName="LIFE.LIFE_STATE_CODE"
		autoLoad="true"></model:dataset>
	<!--参试类别代码-->
	<model:dataset id="dsTest" enumName="TESTED.TYPE" autoLoad="true"></model:dataset>
	<!--是否参加职业健康-->
	<model:dataset id="dsHestth" enumName="COMM.YESORNO" autoLoad="true"></model:dataset>
	<!-- 烈属类别代码 -->
	<model:dataset id="DependantTypeCodeEnum"
		enumName="DEPENDANT.CODE" autoLoad="true" global="true"></model:dataset>
	<!-- 就业状况 -->
	<model:dataset id="EmploymentCodeDataset" enumName="EMPLOYMENT.CODE"
		autoLoad="true" global="true"></model:dataset>
	<!-- 工作单位性质 -->
	<model:dataset id="WorkUnitCharacterDataset"
		enumName="WORKUNIT.CHARACTER" autoLoad="true" global="true"></model:dataset>
		
	<!-- 部分烈士（错杀被平反人员）子女信息 -->  
	<model:dataset id="MartyrOffspringDataSet" cmd="com.inspur.cams.bpt.manage.cmd.BptPeopleMartyrOffspringQueryCommand" method="getMartyrOffsprinInforCollection" global="true">
		<model:record fromBean="com.inspur.cams.bpt.base.data.BptPeopleMartyrOffspring">
			<model:field name="oldLonelyFlag" type="string" rule="require"/>
			<model:field name="orphanFlag" type="string" rule="require"/>
			<model:field name="workAbilityCode" type="string" rule="require"/>
			<model:field name="viabilityCode" type="string" rule="require"/>
			<model:field name="supportPattern" type="string" rule="require"/>
			<model:field name="bank" type="string" />
			<model:field name="accountName" type="string"/>
			<model:field name="accountCode" type="string"/> 
			<model:field name="martyrOffspringNo" type="string"/> 
			<model:field name="martyrOffspringStateCode" type="string"/> 
		</model:record>
	</model:dataset>
	<!-- 与牺牲者关系 -->
	<model:dataset id="RelationShipEnum" enumName="RELATION.SHIP" autoLoad="true" global="true"></model:dataset>
    <!-- 是否持证人 -->
	<model:dataset id="HolderFlagEnum" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
	<!-- 生活状况-->
    <model:dataset id="lifeStateEnum" enumName="LIFE.LIFE_STATE_CODE" autoLoad="true" global="true"></model:dataset>
	<!-- 身份类别 -->
	<model:dataset id="StatusTypeEnum" enumName="STATUS.TYPE" autoLoad="true" global="true"></model:dataset>
	
	
	<model:dataset id="RetiredSoldierDataSet" cmd="com.inspur.cams.bpt.manage.cmd.BptCountRetiredSoldierQueryCommand" global="true" method="queryBptRetiredSoldierCollection">
		<model:record fromBean="com.inspur.cams.bpt.base.data.BptCountRetiredSoldier">
		    <model:field name="accountName" type="string" />
			<model:field name="accountCode" type="string" />
			
			<model:field name="workAbilityCode" type="string" rule="require"/>
			<model:field name="bank" type="string" />
			<model:field name="oldLonelyFlag" type="string" rule="require"/>
			
			<model:field name="pretiredNo" type="string"/> 
			<model:field name="retiredStateCode" type="string"/> 
		</model:record>
	</model:dataset>
	<!-- 是否享受低保待遇-->
	<model:dataset id="dsGuarant" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
	<!-- 是否享受五保待遇-->
	<model:dataset id="dsFiveGuarant" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
	<!-- 是否具有其他优抚对象身份 -->
	<model:dataset id="OtherBptObjectEnum" enumName="COMM.YESORNO"  autoLoad="true" global="true"></model:dataset>
	<!-- 优抚对象类型 -->
	<model:dataset id="ObjectTypeDataset" enumName="OBJECT.TYPE.PART" autoLoad="true" global="true"></model:dataset>
	<!-- 劳动能力-->
	<model:dataset id="workAbilityEnum" enumName="WORK.ABILITY.CODE" autoLoad="true" global="true"></model:dataset>
	<!-- 生活状况-->
    <model:dataset id="lifeStateEnum" enumName="LIFE.LIFE_STATE_CODE" autoLoad="true" global="true"></model:dataset>
    <!-- 身份认定依据-->
    <model:dataset id="identityEnum" enumName="IDENTITY.CODE" autoLoad="true" global="true"></model:dataset>
    
   <!-- 家庭信息 -->
	<model:dataset id="BaseinfoFamilyDataSet" cmd="com.inspur.cams.bpt.manage.cmd.BptBaseinfoPeopleQueryCommand" method="queryFamilyInfo" global="true">
		<model:record fromBean="com.inspur.cams.comm.baseinfo.data.BaseinfoFamily"></model:record>
	</model:dataset>
	<!-- 建购房补助 -->
	<model:dataset id="HouseSubsidyInfoDataset" cmd="com.inspur.cams.bpt.manage.cmd.BptHouseSubsidyInfoQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.bpt.base.data.BptHouseSubsidyInfo"></model:record>
	</model:dataset>
	<!-- 住房状况 --> 
	<model:dataset id="HouseStatusDataset" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_HOUSESTATUS'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
			<model:param name="includeCode" value='1,3'></model:param>
		</model:params>
	</model:dataset>
	 <!-- 住房性质 -->
	<model:dataset id="HouseQualityDataset" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_HOUSEQUALITY'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	 <!-- 房屋结构类型 --> 
	<model:dataset id="HouseStructureTypeDataset"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_HOUSE_STRUCTURE_TYPE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	 <!-- 房屋结构 --> 
	<model:dataset id="HouseStructureDataset"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_HOUSE_STRUCTURE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 享受购建房补助 -->
	<model:dataset id="BuildingSubsidyDataset" enumName="BUILDINGSUBSIDY.FLAG"  autoLoad="true" global="true"></model:dataset>
	<!-- 房屋状况 -->
	<model:dataset id="HousingStatusEnum" enumName="HOUSING.STATUS"  autoLoad="true" global="true"></model:dataset>
	<!-- 享受购建房补助类型 -->
	<model:dataset id="HouseSubsidyTypeEnum" enumName="HOUSE.SUBSIDYTYPE"  autoLoad="true" global="true"></model:dataset>
</model:datasets>
    <next:Panel  height="100%" width="100%"  autoScroll="true" id="peopleTabPanel">
    <next:TopBar>
					<next:ToolBarItem symbol="->" ></next:ToolBarItem>
					<next:ToolBarItem iconCls="save" text="导出档案" handler="method" />
				</next:TopBar>
				<next:Html>
					<fieldset>
					<form id="BaseinfoPeopleForm" method="post" dataset="BaseinfoPeopleDataSet" onsubmit="return false" style="padding: 5px;" class="L5form">
					  <table border="0" width="98%" id="baseinfotable">
					   	<tr>
							<td   colspan="6" align="center"><font size="5" >优抚人员档案信息表</font></td>
						 </tr>
					   <tr>
							<td   colspan="6">人员基本信息</td>
						 </tr>
					     <tr>
							<td class="FieldLabel"  nowrap style="width:17%">身份证件号码：</td>
							<td class="FieldInput" style="width:17%" nowrap="nowrap">&nbsp;<label field="idCard" title="身份证件号码"></label></td>
						    <td class="FieldLabel" style="width:17%">姓名：</td>
							<td class="FieldInput" style="width:17%"><label field="name" title="姓名"></label></td>
							<td class="FieldLabel" style="width:17%" rowspan="3">照片:</td>
							<td nowrap  rowspan="3" style="width:17%">
							<div id="RELATIONER_PHOTOC_IMG_DIV" style="width:0px;">
							<img name="RELATIONER_PHOTOC_IMG" width=70  src="<%=SkinUtils.getRootUrl(request) %>download?table=<%=photoTable %>&column=PHOTO_CONTENT&pk=PHOTO_ID&PHOTO_ID='<%=photoId %>'" style="float:left"
								onerror="javascript:this.src='../dataCollection/comm/default.jpg'" alt="暂无图片" />
							
							</div>
						 </tr>
                         <tr>
							<td class="FieldLabel" >出生日期：</td>
							<td class="FieldInput" ><label name="birthday" field="birthday" title="出生日期"></label></td>
						    <td class="FieldLabel" >民族：</td>
							<td class="FieldInput" ><label name="nation" field="nation" title="民族" dataset="NationDataset"></label></td>
						</tr>
						<tr>
						    <td class="FieldLabel" >性别：</td>
							<td class="FieldInput" ><label name="sex" 	field="sex" dataset="SexDataset" title="性别"></label></td>
							<td class="FieldLabel" nowrap style="width:17%">与户主关系：</td>
							<td class="FieldInput" style="width:17%"><label name="relationshipType" field="relationshipType" dataset="RelationshipTypeDataset" title="与户主关系"></label></td>
						</tr>
						<tr>
						   <td class="FieldLabel" >户口薄(行政区划)：</td>
						   <td class="FieldInput" >
						       <label id="domicileName" name="domicileName" field="domicileName" title="属地行政区划"></label>
						   <td class="FieldLabel">户口薄住址:</td>
						   <td class="FieldInput" colspan="3">
						       <label name="domicileAddress" field="domicileAddress" title="户口薄住址" style="width:85%">
						   </td>      
						</tr>
						<tr>
							<td class="FieldLabel" >实际居住(行政区划)：</td> 
							<td class="FieldInput">
							    <label id="apanageName" name="apanageName" field="apanageName" title="行政区划"></td>
							<td class="FieldLabel">实际居住地址:</td>
							<td class="FieldInput" colspan="3"><label name="address" field="address" title="实际居住地址" style="width:85%"></td>
						</tr>
						<tr>
						   <td class="FieldLabel" >医疗保障方式：</td>
						   <td class="FieldInput" >
						       <label name="safeguardType" field="safeguardType" title="医疗保障方式" dataset="SafeguardDataset">
						    </td>
                            <td class="FieldLabel" >医疗保险号：</td>
							<td class="FieldInput">
							    <label name="medicalCode" field="medicalCode" title="医疗保险号">
							</td>
						    <td class="FieldLabel" >养老保障方式：</td>
						    <td class="FieldInput" >
						       <label name="penSionCode" field="penSionCode" title="养老保障方式" dataset="PensionDataset">
						    </td>
						</tr>
						<tr>
							<td class="FieldLabel" nowrap="nowrap">联系方式（手机）：</td>
							<td class="FieldInput" ><label  name="telMobile" field="telMobile" title="联系方式(手机)"></label></td>
							<td class="FieldLabel" nowrap="nowrap">其他联系方式：</td>
							<td class="FieldInput" ><label name="telOther" field="telOther" title="其他联系方式"></label></td>
							<td class="FieldLabel" >邮政编码：</td>
							<td class="FieldInput" ><label name="postCode" field="postCode" title="邮政编码"></label></td>
						</tr>
						<tr>
							<td class="FieldLabel" >户籍类别：</td>
							<td class="FieldInput" ><label name="domicileType" field="domicileType" dataset="DomicileDataset" title="户籍类别"></label></td>
						    <td class="FieldLabel" >文化程度：</td>
							<td class="FieldInput" ><label name="eduCode" field="eduCode" dataset="EducationDataset" title="文化程度"></label></td>
						    <td class="FieldLabel" >健康状况：</td>
							<td class="FieldInput" ><label name="healthCode" field="healthCode" dataset="HealthDataset" title="健康状况"></label></td>
						</tr>
                        <tr>
							<td class="FieldLabel" >婚姻状况：</td>
							<td class="FieldInput" ><label name="marriageCode" field="marriageCode" dataset="MarriageDataset" title="婚姻状况"></label></td>
							<!--td class="FieldLabel" >职业：</td>
							<td class="FieldInput" >
							    <label name="careerCode" field="careerCode" dataset="CareerDataset"></label>
							</td-->
                            <td class="FieldLabel" >政治面貌：</td>
							<td class="FieldInput" colspan="3"><label name="politicalCode" field="politicalCode" dataset="PoliticalDataset" title="政治面貌"></label></td>
						</tr>
                        <tr>
							<td class="FieldLabel" >就业状况：</td>
							<td class="FieldInput" ><label name="employmentCode" field="employmentCode" dataset="EmploymentCodeDataset" title="就业状况"></label></td>
							<td class="FieldLabel" >年收入：</td>
							<td class="FieldInput" colspan="3"><label name="incomeYear" field="incomeYear" title="年收入"></label></td>
						</tr>
                        <tr>
						    <td class="FieldLabel" >工作单位名称：</td>
							<td class="FieldInput" ><label name="workUnitName" field="workUnitName" title="工作单位名称"></label></td>
							<td class="FieldLabel" >工作单位性质：</td>
							<td class="FieldInput" ><label name="workUnitCharacter" field="workUnitCharacter" dataset="WorkUnitCharacterDataset" title="工作单位性质"></label>	</td>
							<td class="FieldLabel" nowrap="nowrap">工作单位电话：</td>
							<td class="FieldInput" ><label name="workUnitTel" field="workUnitTel" title="工作单位电话"></label></td>
						</tr>
                        <tr>
							<td class="FieldLabel" >工作单位地址：</td>
							<td class="FieldInput"  colspan="5"><label name="workUnitAdd" field="workUnitAdd" title="工作单位地址" style="width: 90%"></label></td>
						</tr>
                        <tr>
							<td class="FieldLabel" >备注(基本信息)：</td>
							<td class="FieldInput"  colspan="5"><label name="note" field="note" rows="3" title="备注(基本信息)" style="width: 90%"></label></td>
						</tr>
                     </table>
					</form>
					<div id='disdiv' style="display:none">
					<form id="disForm" method="post"
						dataset="BptPeopleDisabilityDataSet" onsubmit="return false" 
						style="padding: 5px;" class="L5form">
					<table border="1" width="98%" id="distable" style="display:none">
						<tr>
							<td   colspan="6">伤残人员类别信息</td>
						 </tr>
						<tr>
							<td class="FieldLabel" style="width:17%">伤残类别：</td>
							<td class="FieldInput" style="width:17%"><label name="disabilityTypeCode" field="disabilityTypeCode" dataset="DisabilityTypeCodeEnum" title="伤残类别"></label></td>
							
							<td class="FieldLabel" style="width:17%">伤残等级：</td>
							<td class="FieldInput" style="width:17%"><label name="disabilityLevelCode" field="disabilityLevelCode" dataset="DisabilityLevelDataset" title="伤残等级"></label></td>
							
							<td class="FieldLabel" style="width:17%">伤残性质：</td>
							<td class="FieldInput" style="width:17%"><label name="disabilityCaseCode" field="disabilityCaseCode" dataset="DisabilityCaseDataset" title="伤残性质"></label></td>
						</tr>
						
						<tr>
							<td class="FieldLabel" >优抚对象状态：</td>
							<td class="FieldInput" ><label name="disabilityStateCode" field="disabilityStateCode" dataset="ObjectStateDataset" title="优抚对象状态"></label></td>
							
							<td class="FieldLabel" >证书编号：</td>
							<td class="FieldInput" ><label name="disabilityNo" field="disabilityNo" title="证书编号"/></td>
						
							<td  class="FieldLabel" >批准日期：</td>
							<td class="FieldInput"><label name="approveDate" field="approveDate" title="批准日期"/></td>
						</tr>

						<tr>
							<td class="FieldLabel"  nowrap="nowrap">入伍(参加工作)时间：</td>
							<td class="FieldInput" ><label name="relationshipType" field="conscriptDate" title="入伍(参加工作)时间"/></td>
								
							<td class="FieldLabel"  nowrap="nowrap">退伍时间：</td>
							<td class="FieldInput" ><label name="veteransDate" field="veteransDate" title="退伍时间"/></td>
						
							<td class="FieldLabel"  nowrap="nowrap">离退休时间：</td>
							<td class="FieldInput" ><label name="retiredDate" field="retiredDate" title="离退休时间"/></td>
						</tr>
						<tr>
							<td class="FieldLabel" >伤残时期：</td>
							<td class="FieldInput" >
							<label name="disabilityWarCode" field="disabilityWarCode" dataset="BptWarDataset"></label></td>
							<td class="FieldLabel" id="k1">是否抗美援朝：</td>
							<td class="FieldInput" id="k2">
							<label name="isKoreaWar" field="isKoreaWar" dataset="isKoreaWarDataset"></label>
							</td>
							<td class="FieldLabel" >伤残属别：</td>
							<td class="FieldInput" ><label name="disabilityGenusCode" field="disabilityGenusCode" dataset="DisabilityGenusDataset" title="伤残属别"></label></td>
							
						</tr>
						<tr>
							<td class="FieldLabel" >致残时间：</td>
							<td class="FieldInput" ><label name="disabilityDate" field="disabilityDate" title="致残时间"/></td>
							
							<td class="FieldLabel" nowrap="nowrap">致残时所在单位：</td>
							<td class="FieldInput" colspan="3"><label name="uinitOfDisability" field="uinitOfDisability" title="致残时所在单位"/></td>
							
						</tr>
						
						<tr>
							<td class="FieldLabel" >致残地点：</td>
							<td class="FieldInput" colspan="5"><label name="disabilityAdd" field="disabilityAdd" title="致残地点"/></td>
						</tr>
						
						<tr>		
							<td class="FieldLabel" >致残情况：</td>
							<td class="FieldInput" colspan="5"><label name="disabilityBody" field="disabilityBody" title="致残情况"/></td>
						</tr>
								
						<tr>
							<td class="FieldLabel" >致残原因：</td>
							<td class="FieldInput"  colspan="5"><label name="disabilityReason" field="disabilityReason" title="致残原因"></label></td>

						</tr>
						
						<tr>
							<td class="FieldLabel">是否孤老:</td>
							<td class="FieldInput"><label name="oldLonelyFlag" field="oldLonelyFlag" dataset="OldLonelyFlagEnum" title="是否孤老"></label></td>
							
							<td class="FieldLabel">是否精神病：</td>
							<td class="FieldInput" colspan="3"><label name="insanityFlag" field="insanityFlag" dataset="InsanityFlagEnum" title="是否精神病"></label></td>
						</tr>
						
						<tr>
							<td class="FieldLabel">劳动能力：</td>
							<td class="FieldInput"><label name="workAbilityCode" field="workAbilityCode" dataset="WorkAbilityCodeEnum" title="劳动能力"></label></td>

							<td class="FieldLabel">生活能力：</td>
							<td class="FieldInput"><label name="viabilityCode" field="viabilityCode" dataset="ViabilityCodeEnum" title="生活能力"></label></td>
							
							<td class="FieldLabel" nowrap="nowrap">供养方式：</td>
							<td class="FieldInput"><label name="supportPattern" field="supportPattern" dataset="SupportPatternEnum" title="供养方式"></label></td>
						
						</tr>
						<tr>
							<td  class="FieldLabel" >开户银行：</td>
							<td class="FieldInput"><label name="bank" field="bank" dataset="BankEnum" title="开户银行"></label></td>
							
							<td  class="FieldLabel" >开户名称：</td>
							<td class="FieldInput"><label name="accountName" field="accountName" title="开户名称"/> </td>

							<td  class="FieldLabel" >银行账号：</td>
							<td class="FieldInput"  ><label name="accountCode" field="accountCode" title="银行帐号"></label></td>
						</tr>
						
						<tr>
							<td class="FieldLabel">备注(类别信息)：</td>
							<td class="FieldInput" colspan="5"><label name="note" field="note" title="备注(类别信息)"></label></td>
						</tr>

					</table>
					</form>
					</div>
					<div id='depdiv' style="display:none">
					<form id="editdForm" dataset="DependantDataset"
						onsubmit="return false" style="padding: 5px;" class="L5form" >
					<table border="1" width="98%" id="deptable" style="display:none">
						<tr>
							<td   colspan="6">三属人员类别信息</td>
						 </tr>
						<tr>
							<td class="FieldLabel" nowrap style="width:17%">优抚对象类别：</td>
							<td class="FieldInput" style="width:17%"><label name="dependantTypeCode" field="dependantTypeCode" title="优抚对象类别" dataset="DependantTypeDataset"></label></td>
							
							<td class="FieldLabel" nowrap style="width:17%">与牺牲病故军人关系：</td>
							<td class="FieldInput" style="width:17%"><label name="relationship" field="relationship" title="与牺牲病毒故军人关系" dataset="RelationTypeEnum"/></td>
							
							<td class="FieldLabel" nowrap style="width:17%">优抚对象状态：</td>
							<td class="FieldInput" style="width:17%"><label name="dependantStateCode" field="dependantStateCode" title="优抚对象状态" dataset="ObjectStateDataset"></label></td>
							
						</tr>
						
						<tr>	
							<td class="FieldLabel" nowrap>定期抚恤证编号：</td>
							<td class="FieldInput"><label name="dependantNo" field="dependantNo" title="定期抚恤证编号"/></td>
						
							<td class="FieldLabel" >批准日期：</td>
							<td class="FieldInput" ><label name="approvalDate" field="approvalDate" title="批准日期"></td>
						
							<td class="FieldLabel" nowrap>是否正在上学：</td>
							<td class="FieldInput"><label name="studentFlag" field="studentFlag" title="是否正在上学" dataset="StudnetFlagEnum"></label></td>
						</tr>
						<tr>
							<td class="FieldLabel">是否残疾：</td>
							<td class="FieldInput"><label name="handicapFlag" field="handicapFlag" title="是否残疾" dataset="HandicapFlagEnum"></label></td>
							
							<td class="FieldLabel" >是否孤老：</td>
							<td class="FieldInput"><label name="oldLonelyFlag" field="oldLonelyFlag" title="是否孤老" dataset="OldLonelyFlagEnum"></label></td>
						
							<td class="FieldLabel">是否孤儿：</td>
							<td class="FieldInput"><label name="orphanFlag" field="orphanFlag" title="是否孤儿" dataset="OrphanFlagEnum"></label></td>
						
						</tr>
						
						<tr>
							<td class="FieldLabel">劳动能力：</td>
							<td class="FieldInput"><label name="workAbilityCode" field="workAbilityCode" title="劳动能力" dataset="WorkAbilityCodeEnum"></label></td>
						
							<td class="FieldLabel">生活能力：</td>
							<td class="FieldInput"><label name="viabilityCode" field="viabilityCode" title="生活能力" dataset="ViabilityCodeEnum"></label></td>
							
							<td class="FieldLabel">供养方式：</td>
							<td class="FieldInput" nowrap="nowrap"><label name="supportPattern" field="supportPattern" title="供养方式" dataset="SupportPatternEnum"></label></td>
						</tr>
						<tr>
							<td class="FieldLabel" >是否持证人：</td>
							<td class="FieldInput"><label name="holderFlag" field="holderFlag" dataset="HolderFlagEnum" title="是否持证人"></label></td>
						
							<td class="FieldLabel" nowrap="nowrap">烈士（牺牲，病故军人）证书字号：</td>
							<td class="FieldInput"><label name="lezswCertificateId" field="lezswCertificateId" title="烈士（牺牲、病故军人）证书字号"/></td>
						
							<td class="FieldLabel" nowrap="nowrap">烈士（牺牲、病故军人）姓名：</td>
							<td class="FieldInput"><label name="lezswName" field="lezswName" title="烈士（牺牲、病故军人）姓名"/></td>
						</tr>
						
						<tr>
							<td class="FieldLabel">性别：</td>
							<td class="FieldInput"><label name="lezswSex" field="lezswSex" dataset="SexDataset" title="性别"></label></td>
						
							<td class="FieldLabel">出生日期：</td>
							<td class="FieldInput"><label name="lezswBirthday" field="lezswBirthday" title="出生日期"/></td>

							<td class="FieldLabel">入伍（工作）时间：</td>
							<td class="FieldInput"><label name="conscriptDate" field="conscriptDate" title="入伍(工作)时间"/></td>
						</tr>
						
						<tr>
							<td class="FieldLabel" >生前所在单位：</td>
							<td class="FieldInput"><label name="workUnit" field="workUnit" title="生前所在单位"/></td>
						
							<td class="FieldLabel">生前职务：</td>
							<td class="FieldInput"><label name="position" field="position" title="生前职务"/></td>
						 
							<td class="FieldLabel" >牺牲病故时间：</td>
							<td class="FieldInput"><label name="deathDate" field="deathDate" title="牺牲病毒故时间"/>
							</td>
						</tr>
						
						<tr>
							<td class="FieldLabel">牺牲病故地点：</td>
							<td class="FieldInput"><label name="deathAddress" field="deathAddress" title="牺牲病毒故地点"/></td>
						
							<td class="FieldLabel"nowrap="nowrap">烈士（牺牲、病故军人）批准时间：</td>
							<td class="FieldInput" colspan="3"><label name="lezswApproveDate" field="lezswApproveDate" title="烈士（牺牲、病故军人）批准时间"/></td>
						</tr>
						
						<tr>
							<td class="FieldLabel">牺牲病故原因：</td>
							<td class="FieldInput" colspan="5"><label name="deathReason" field="deathReason" title="牺牲病故原因"></label></td>
						</tr>
						
						<tr>
							<td  class="FieldLabel">开户银行：</td>
							<td class="FieldInput"><label name="bank" field="bank" dataset="BankEnum" title="开户银行"></label></td>
				
							<td  class="FieldLabel" >开户名称：</td>
							<td class="FieldInput"><label name="accountName" field="accountName" title="开户名称"/></td>
 
 							<td  class="FieldLabel" >银行账号：</td>
							<td class="FieldInput" ><label name="accountCode" field="accountCode" title="银行帐号"></label></td>
						</tr>
						
						<tr>
							<td class="FieldLabel">备注(类别信息)：</td>
							<td class="FieldInput" colspan="5"><label name="note" field="note" title="备注(类别信息)"></label></td>
						</tr>
					</table>
					</form>
					</div>
					<div id="demodiv" style="display:none">
					<form id="edetForm"  dataset="PeopleDemobilizedDataset"  onsubmit="return false" style="padding: 5px;" class="L5form" >
			<table border="1"  border="0" width="98%" id="demotable" style="display:none">
				<tr>
							<td   colspan="6">在乡复员人员类别信息</td>
				 </tr>
			   <tr>
					<td  class="FieldLabel" nowrap width="17%" >入伍时间：</td>
					<td class="FieldInput" style="width:17%"><label name="conscriptDate" field="conscriptDate" title="入伍时间"></label></td>
					<td  class="FieldLabel" nowrap width="17%" >复员时间：</td>
					<td class="FieldInput" style="width:17%"><label name="decruitmentDate" field="decruitmentDate" title="复员时间"></label></td>
				    <td  class="FieldLabel" nowrap width="17%" >原部队代号：</td>
				    <td class="FieldInput" style="width:17%"><label  type="text" name="forcesNo" field="forcesNo" title="原部队代号"></label></td>
				</tr>
		   		<tr>
		   		    <td  class="FieldLabel" nowrap>职务：</td>
		   		    <td class="FieldInput"><label name="position" field="position" title="职务"></label></td>
					<td  class="FieldLabel" nowrap>属于时期：</td>
					<td class="FieldInput"><label name="belongDate" field="belongDate" dataset="warDs" title="属于时期"></label></td>
				    <td  class="FieldLabel" nowrap>是否抗美援朝：</td>
				    <td class="FieldInput"><label name="isKoeanwar" field="isKoeanwar" dataset="KoeanwarEnum" title="是否抗美援朝"></label></td>
					
				</tr>
				<tr>
				   <td class="FieldLabel" >优抚对象状态：</td>
				   <td class="FieldInput"><label name="demobilizedStateCode" field="demobilizedStateCode" dataset="ObjectStateDataset" title="优抚对象状态"></label></td>
				   <td class="FieldLabel" >定期定量补助证编号:</td>
				    <td class="FieldInput"><label name="demobilizedNo" field="demobilizedNo" title="定期定量补助证编号"></label></td>
				    <td  class="FieldLabel" nowrap>批准日期：</td>
					<td class="FieldInput"><label name="approvalDate" field="approvalDate" title="批准日期"></label></td>
				</tr>
		   		<tr>
					<td  class="FieldLabel" nowrap>复员证号：</td><td class="FieldInput"><label name="asdpNo" field="asdpNo" title="复员证号"></label></td>
					<td  class="FieldLabel" nowrap>是否孤老：</td>
					<td class="FieldInput"><label name="oldLonelyFlag" field="oldLonelyFlag" dataset="OldLonelyFlagEnum" title="是否孤老"></label></td>
					<td  class="FieldLabel" nowrap>是否精神病：</td>
					<td class="FieldInput"><label name="insanityFlag" field="insanityFlag" dataset="InsanityFlagEnum" title="是否精神病"></label></td>
				</tr>
				<tr>
					<td  class="FieldLabel" nowrap>劳动能力：</td>
					<td class="FieldInput"><label name="workAbilityCode" field="workAbilityCode" dataset="WorkAbilityCodeEnum" title="劳动能力"></label></td>
					<td class="FieldLabel" nowrap>生活能力：</td>
					<td class="FieldInput"><label name="viabilityCode" field="viabilityCode" dataset="ViabilityCodeEnum" title="生活能力"></label></td>
					<td  class="FieldLabel"nowrap>供养方式:</td>
					<td class="FieldInput"><label name="supportPattern" field="supportPattern" dataset="SupportPatternEnum" title="供养方式"></label></td>
				</tr>
		   		<tr>
					<td class="FieldLabel" nowrap>开户银行：</td>
					<td class="FieldInput"><label name="bank" field="bank" dataset="BankEnum" title="开户银行"></label></td>
					<td  class="FieldLabel" nowrap>开户名称：</td>
					<td class="FieldInput"><label name="accountName" field="accountName" title="开户名称"></label></td>
					<td  class="FieldLabel" nowrap>银行账号：</td>
					<td class="FieldInput"><label name="accountCode" field="accountCode" title="银行帐号" style="width:200" ></label></td>	
				</tr>
				<tr>
					<td  class="FieldLabel" nowrap>备注(类别信息)：</td>
					<td class="FieldInput" colspan="5"><label name="note" field="note" title="备注(类别信息)" style="width:200"></label></td>
				</tr>
			</table>
			</form>
			</div>
			<div id="demoilldiv" style="display:none">
			<form id="editForqm" dataset="DemobilizedIllnessDataset" onsubmit="return false" style="padding: 5px;"  class="L5form">
					<table border="1" border="0" width="98%" id='demoilltable' style="display:none">
						<tr>
							<td   colspan="6">带病回乡人员类别信息</td>
						 </tr>
						<tr>
							<td class="FieldLabel" width="17%" >优抚对象状态：</td>
							<td class="FieldInput" style="width:17%"><label name="demobilizedStateCode" field="demobilizedStateCode" dataset="ObjectStateDataset" title="优抚对象状态"></label></td>
							<td class="FieldLabel" width="17%" >生活补助证编号:</td>
							<td class="FieldInput" style="width:17%"><label name="demobilizedNo" field="demobilizedNo" title="生活补助证编号"></label></td>
							<td class="FieldLabel" nowrap width="17%" >批准日期：</td>
							<td class="FieldInput" style="width:17%"><label name="approvalDate" field="approvalDate" title="批准日期"></label></td>
						</tr>
						<tr>
							<td class="FieldLabel" nowrap>入伍时间：</td>
							<td class="FieldInput"><label name="conscriptDate" 	field="conscriptDate" title="入伍时间"></label></td>
							<td class="FieldLabel" nowrap>退伍时间：</td>
							<td class="FieldInput"><label name="decruitmentDate" field="decruitmentDate" title="退伍时间"></label></td>
							<td class="FieldLabel" nowrap>退伍证号：</td>
							<td class="FieldInput"><label name="asdpNo" field="asdpNo" title="退伍证号"></label></td>
						</tr>
						<tr>
							<td class="FieldLabel" nowrap>职务：</td>
							<td class="FieldInput"><label name="position" field="position" title="职务"></label></td>
							<td class="FieldLabel" nowrap>是否参战：</td>
							<td class="FieldInput"><label name="isWar" field="isWar" dataset="isWarEnum" title="是否参战"></label></td>
							<td class="FieldLabel" nowrap>是否参试：</td>
							<td class="FieldInput"><label name="isInnuclear" field="isInnuclear" dataset="isInnuclearEnum" title="是否参试"></label></td>
                       </tr>
                       <tr>
							<td class="FieldLabel" nowrap>是否孤老：</td>
							<td class="FieldInput"><label name="oldLonelyFlag" field="oldLonelyFlag" dataset="OldLonelyFlagEnum" title="是否孤老"></label></td>
                            <td class="FieldLabel" nowrap>是否精神病：</td>
							<td class="FieldInput"><label name="insanityFlag" field="insanityFlag" dataset="InsanityFlagEnum" title="是否精神病"></label></td>
                            <td class="FieldLabel" nowrap>劳动能力：</td>
							<td class="FieldInput"><label name="workAbilityCode" field="workAbilityCode" dataset="WorkAbilityCodeEnum" title="劳动能力"></label></td>
						</tr>
						<tr>
                            <td class="FieldLabel" nowrap>生活能力：</td>
							<td class="FieldInput"><label name="viabilityCode" field="viabilityCode" dataset="ViabilityCodeEnum" title="生活能力"></label></td>
                            <td class="FieldLabel" nowrap>供养方式：</td>
							<td class="FieldInput"><label name="supportPattern" field="supportPattern" dataset="SupportPatternEnum" title="供养方式"></label></td>
                            <td class="FieldLabel" nowrap>身体状况：</td>
							<td class="FieldInput"><label name="physiclalStatus" field="physiclalStatus" dataset="PhysiclalStatusEnum" title="身体状况"></label></td>
						</tr>
						<tr>
                            <td class="FieldLabel" nowrap>开户银行：</td>
							<td class="FieldInput"><label name="bank" field="bank" dataset="BankEnum" title="开户银行"></label></td>
							<td class="FieldLabel" nowrap>开户名称：</td>
							<td class="FieldInput"><label name="accountName" field="accountName" title="开户名称"></label></td>
							<td class="FieldLabel" nowrap>银行账号：</td>
							<td class="FieldInput"><label name="accountCode" field="accountCode" title="银行帐号" style="width: 200"></label></td>
						</tr>
						<tr>
							<td class="FieldLabel" nowrap>家庭经济状况：</td>
							<td class="FieldInput" ><label name="familyEconomics" field="familyEconomics" dataset="FamilyEconomicsEnum" title="家庭经济状况"></label></td>
							<td class="FieldLabel" nowrap>健康状况：</td>
							<td class="FieldInput" colspan="3"><label type="text" id="healthStateName" name="healthStateName" field="healthStateName" title="健康状况" 
							   /><input type="hidden" id="healthStateCode"/><font color="red">*</font></td>
				
						</tr>
						<tr>
							<td class="FieldLabel" nowrap>在部队期间患病信息：</td>
							<td class="FieldInput" colspan="5"><label name="illessInfo" field="illessInfo" title="在部队期间患病信息"></label></td>
						</tr>
                        <tr>
							<td class="FieldLabel" nowrap>备注(类别信息)：</td>
							<td class="FieldInput" colspan="5"><label name="note" field="note"  title="备注(类别信息)" style="width: 200" /></td>
						</tr>
				</table>
			</form>
			</div>
			<div id="wardiv" style="display:none">
			<form id="editFeorm" dataset="dsWar" onsubmit="return false" 
			style="padding: 5px;" class="L5form">
			<table border="0" width="98%" id="wartable" style="display:none">
				<tr>
					<td   colspan="6">参战人员类别信息</td>
				 </tr>
				<tr>
					<td class="FieldLabel" nowrap width="17%" >优抚对象状态：</td>
					<td class="FieldInput" style="width:17%"><label name="warStateCode"
						field="warStateCode" dataset="ObjectStateDataset" title="优抚对象状态"/></td>
	
					<td class="FieldLabel" nowrap width="17%" >生活补助证编号：</td>
					<td class="FieldInput" style="width:17%"><label name="warNo" field="warNo" title="生活补助证编号"/></td>
	
					<td class="FieldLabel" nowrap width="17%" >批准日期：</td>
					<td class="FieldInput" style="width:17%"><label name="approvalDate"
						field="approvalDate" title="批准日期"/></td>
				</tr>
				<tr>
					<td class="FieldLabel" nowrap>入伍（参加工作）时间：</td>
					<td class="FieldInput"><label name="conscriptcDate"
						field="conscriptcDate" title="入伍(参加工作)时间"/></td>
	
					<td class="FieldLabel" nowrap>退伍时间：</td>
					<td class="FieldInput"><label name="decruitmentDate"
						field="decruitmentDate" title="退伍时间"/></td>
	
					<td class="FieldLabel" nowrap>离退休时间：</td>
					<td class="FieldInput"><label name="retiredDate"
						field="retiredDate" title="离退休时间"/></td>
				</tr>
				<tr>
					<td class="FieldLabel" nowrap>退伍证号：</td>
					<td class="FieldInput"><label name="asdpNo" field="asdpNo" title="退伍证号"/></td>
	
					<td class="FieldLabel" nowrap>原部队代号：</td>
					<td class="FieldInput"><label name="forcesNo" field="forcesNo" title="原部队代号"/></td>
	
					<td class="FieldLabel" nowrap>职务（级别）：</td>
					<td class="FieldInput"><label name="position" field="position" title="职务(级别)"/></td>
				</tr>
				<tr>
					<td class="FieldLabel" nowrap>参战类别：</td>
					<td class="FieldInput"><label name="warTypeCode"
						field="warTypeCode" dataset="dsWarData" title="参战类别"/></td>
	
					<td class="FieldLabel" nowrap>是否孤老：</td>
					<td class="FieldInput"><label name="oldLonelyFlag"
						field="oldLonelyFlag" dataset="OldLonelyFlagEnum" title="是否孤老"/></td>
	
					<td class="FieldLabel" nowrap>是否精神病：</td>
					<td class="FieldInput"><label name="insanityFlag"
						field="insanityFlag" dataset="InsanityFlagEnum" title="是否精神病"/></td>
				</tr>
				<tr>
	
					<td class="FieldLabel" nowrap>劳动能力：</td>
					<td class="FieldInput"><label name="workAbilityCode"
						field="workAbilityCode" dataset="WorkAbilityCodeEnum" title="劳动能力"/></td>
	
					<td class="FieldLabel" nowrap>生活能力：</td>
					<td class="FieldInput"><label name="viabilityCode"
						field="viabilityCode" dataset="ViabilityCodeEnum" title="生活能力"/></td>
	
	
					<td class="FieldLabel" nowrap>供养方式：</td>
					<td class="FieldInput"><label name="supportPattern"
						field="supportPattern" dataset="SupportPatternEnum" title="供养方式"/></td>
				</tr>
	
				<tr>
					<td class="FieldLabel" nowrap>健康状况：</td>
								<td class="FieldInput" ><label type="text" id="healthStateName" name="healthStateName" field="healthStateName" title="健康状况" 
								   /><input type="hidden" id="healthStateCode"/></td>
					
					<td class="FieldLabel" nowrap>生活状况：</td>
					<td class="FieldInput" colspan="3"><label name="lifeStateCode"
						field="lifeStateCode" dataset="dsLife" title="生活状况"/></td>
				</tr>
				<tr>
					<td class="FieldLabel" nowrap>开户银行：</td>
					<td class="FieldInput"><label name="bank" field="bank"
						dataset="BankEnum" title="开户银行"/></td>
					<td class="FieldLabel" nowrap>开户名称：</td>
					<td class="FieldInput"><label name="accountName"
						field="accountName" title="开户名称"/></td>
					<td class="FieldLabel" nowrap>银行账号：</td>
					<td class="FieldInput" ><label name="accountCode"
						field="accountCode" title="银行账号"/></td>
				</tr>
				<tr>
					<td class="FieldLabel" nowrap>备注(基本信息)：</td>
					<td class="FieldInput" colspan="5"><label name="note"
						field="note" title="备注(类别信息)"/></td>
	
				</tr>
			</table>
			</form>
			</div>
			<div id="testdiv" style="display:none">
		<form id="editFormw" dataset="dsTested" onsubmit="return false" 
			style="padding: 5px;" class="L5form">
		<table border="0" width="98%" id="testtable" style="display:none">
			<tr>
				<td   colspan="6">参试人员类别信息</td>
			 </tr>
			<tr>	
				<td class="FieldLabel" style="width:17%">优抚对象状态：</td>
				<td class="FieldInput" style="width:17%">
				<label name="warStateCode" field="warStateCode"  dataset="ObjectStateDataset" title="优抚对象状态"/>
				</td>
			
				<td class="FieldLabel" style="width:17%">生活补助证编号：</td>
				<td class="FieldInput" style="width:17%">
				<label name="warNo" field="warNo" title="生活补助证编号"/>
				</td>

				<td class="FieldLabel" style="width:17%">批准日期：</td>
				<td class="FieldInput" style="width:17%">
				<label name="approvalDate" field="approvalDate" title="批准日期"/>
				</td>
			</tr>
			<tr>
				<td class="FieldLabel" nowrap>入伍(参加工作)时间：</td>
				<td class="FieldInput">
				<label name="conscriptcDate" field="conscriptcDate" title="入伍(参加工作)时间"/>
				</td>
				<td class="FieldLabel" nowrap>退伍时间：</td>
				<td class="FieldInput">
				<label name="decruitmentDate" field="decruitmentDate" title="退伍时间"/>
				</td>

				
			
				<td class="FieldLabel" nowrap>离退休时间：</td>
				<td class="FieldInput">
				<label name="retiredDate" field="retiredDate" title="离退休时间"/>
				</td>
			</tr>
			<tr>
				<td class="FieldLabel" nowrap>退伍证号：</td>
				<td class="FieldInput">
				<label name="asdpNo" field="asdpNo" title="退伍证号"/>
				</td>

				<td class="FieldLabel" nowrap>原部队代号：</td>
				<td class="FieldInput">
				<label name="forcesNo" field="forcesNo" title="原部队代号"/>
				</td>
			
				<td class="FieldLabel">职务（级别）：</td>
				<td class="FieldInput">
				<label name="position" field="position" title="职务(级别)"/>
				</td>
			</tr>
			<tr>
				<td class="FieldLabel">参试类别：</td>
				<td class="FieldInput">
				<label name="testedType" field="testedType"  dataset="dsTest" title="参试类别"/>
				</td>
				
				<td class="FieldLabel">职业健康检查：</td>
				<td class="FieldInput">
				<label name="isHealthFlag" field="isHealthFlag" dataset="dsHestth" title="职业健康检查"/>
				</td>
				
				<td class="FieldLabel" nowrap>健康状况：</td>
							<td class="FieldInput" ><label type="text" id="healthStateName" name="healthStateName" field="healthStateName" title="健康状况" 
							   /><input type="hidden" id="healthStateCode"/></td>
				
			</tr>
			<tr id="examinationDate">
				<td class="FieldLabel" nowrap>本次查体时间：</td>
				<td class="FieldInput"><label  name="thisExaminationDate" title="本次查体时间" field="thisExaminationDate" /></td>
				<td class="FieldLabel" nowrap>上次查体时间：</td>
				<td class="FieldInput" colspan="3"><label name="theExaminationDate" title="上次查体时间" field="theExaminationDate" /></td>
							
			</tr>
			<tr>
				<td class="FieldLabel">是否孤老：</td>
				<td class="FieldInput">
				<label name="oldLonelyFlag" field="oldLonelyFlag"  dataset="OldLonelyFlagEnum" title="是否孤老"/>
				</td>
				
				<td class="FieldLabel">是否精神病：</td>
				<td class="FieldInput">
				<label name="insanityFlag" field="insanityFlag"  dataset="InsanityFlagEnum" title="是否精神病"/>
				</td>
				
				<td class="FieldLabel">劳动能力：</td>
				<td class="FieldInput">
				<label name="workAbilityCode" field="workAbilityCode"  dataset="WorkAbilityCodeEnum" title="劳动能力"/>
				</td>
			</tr>
			<tr>
				<td class="FieldLabel">生活状况：</td>
				<td class="FieldInput">
				<label name="lifeStateCode" field="lifeStateCode"  dataset="dsLife" title="生活状况"/>
				</td>

				<td class="FieldLabel">生活能力：</td>
				<td class="FieldInput">
				<label name="viabilityCode" field="viabilityCode"  dataset="ViabilityCodeEnum" title="生活能力"/>
				</td>
			
				<td class="FieldLabel">供养方式：</td>
				<td class="FieldInput">
				<label name="supportPattern" field="supportPattern"  dataset="SupportPatternEnum" title="供养方式"/>
				</td>	
			</tr>
			<tr>
				<td class="FieldLabel">残疾等级：</td>
				<td class="FieldInput">
				<label name="disabilityLevelCode" field="disabilityLevelCode" dataset="DisabilityLevelDataset" title="残疾等级"/>
				</td>
				
				<td class="FieldLabel">先天性残疾子女数：</td>
				<td class="FieldInput"  colspan="3">
				<label name="disabilityNum" field="disabilityNum" title="先天性残疾子女数"/>
				</td>
				
			</tr>
			<tr>
				<td class="FieldLabel">身份认定依据：</td>
				<td class="FieldInput" colspan="5">
				<label name="identityBasis" field="identityBasis" title="身份认定依据"/>
				</td>
			</tr>
			<tr>
				<td class="FieldLabel" nowrap>开户银行：</td>
				<td class="FieldInput">
				<label name="bank"
					field="bank" dataset="BankEnum" title="开户银行"/>
				</td>
				<td  class="FieldLabel" nowrap>开户名称：</td>
				<td class="FieldInput">
				<label name="accountName"
					field="accountName" title="开户名称"/>
				</td>
				<td  class="FieldLabel" nowrap>银行账号：</td>
				<td class="FieldInput" >
				<label name="accountCode"
					field="accountCode" title="银行帐号"/>
				</td>	
			</tr>
			<tr>
				<td class="FieldLabel">备注(类别信息)：</td>
				<td class="FieldInput" colspan="5">
				<label name="note" field="note" title="备注(类别信息)"/>
				</td>
			</tr>
		</table>
		</form>
		</div>
		<div id="mardiv" style="display:none">
		<form id="editFormd" dataset="MartyrOffspringDataSet" 
						onsubmit="return false" style="padding: 5px;" class="L5form">
					<table border="1" id="martable" width="98%" style="display:none">
						<tr>
							<td   colspan="6">老烈子女类别信息</td>
						 </tr>
						<tr>
							<td class="FieldLabel" nowrap="nowrap" style="width: 17%">身份类别：</td>
								<td class="FieldInput" style="width:17%"><label id="statusType" name="statusType"
									field="statusType" title="身份类别" dataset="StatusTypeEnum"></label></td>
							<td class="FieldLabel" style="width: 17%">牺牲者姓名：</td>
							<td class="FieldInput" style="width: 17%"><label id="lezswName" name="lezswName" field="lezswName" title="牺牲者姓名" /></td>
							<td class="FieldLabel" style="width: 17%">牺牲时间：</td>
							<td class="FieldInput" style="width: 17%"><label id="sacrificeDate" name="sacrificeDate" field="sacrificeDate"/></td>
						</tr>
						<tr>
							<td class="FieldLabel">优抚对象状态：</td>
							<td class="FieldInput"><label name="martyrOffspringStateCode"
								field="martyrOffspringStateCode" dataset="ObjectStateDataset" title="优抚对象状态"></label></td>
			
							<td class="FieldLabel">证书编号：</td>
							<td class="FieldInput"><label name="martyrOffspringNo"
								field="martyrOffspringNo" title="证书编号" /></label></td>
			
							<td class="FieldLabel">批准日期：</td>
							<td class="FieldInput"><label title="批准日期"
								name="approvalDate" field="approvalDate" format="Y-m-d" style="width: 100px;"  /></label></td>
						</tr>
						<tr>
							<td class="FieldLabel">批准烈士（平反）时间：</td>
							<td class="FieldInput"><label id="lezswApproveDate" name="lezswApproveDate" field="lezswApproveDate" title="批准烈士（平反）时间"/></td>
							<td class="FieldLabel" nowrap>与牺牲者关系：</td>
							<td class="FieldInput"><label id="relationship" name="relationship" field="relationship" title="与牺牲者关系" dataset="RelationShipEnum" /></td>
							<td class="FieldLabel">是否持证人：</td>
							<td class="FieldInput"><label id="holderFlag" name="holderFlag" field="holderFlag" title="是否持证人" dataset="HolderFlagEnum" /></td>
						</tr>
						<tr>	
							<td class="FieldLabel">是否孤老：</td>
							<td class="FieldInput"><label id="oldLonelyFlag" name="oldLonelyFlag"
								field="oldLonelyFlag" title="是否孤老" dataset="OldLonelyFlagEnum" /></td>
							<td class="FieldLabel">是否孤儿：</td>
							<td class="FieldInput"><label id="orphanFlag" name="orphanFlag"
								field="orphanFlag" title="是否孤儿" dataset="OrphanFlagEnum" /></td>
							<td class="FieldLabel" nowrap>生活状况：</td>
							<td class="FieldInput"><label id="lifeStateCode" name="lifeStateCode" field="lifeStateCode" title="生活状况" dataset="lifeStateEnum" /></td>
						</tr>
						<tr>
							<td class="FieldLabel">劳动能力：</td>
							<td class="FieldInput"><label id="workAbilityCode" name="workAbilityCode"
								field="workAbilityCode" title="劳动能力" dataset="WorkAbilityCodeEnum" /></td>
							<td class="FieldLabel">生活能力：</td>
							<td class="FieldInput"><label id="viabilityCode" name="viabilityCode"
								field="viabilityCode" title="生活能力" dataset="ViabilityCodeEnum" /></td>

							<td class="FieldLabel">供养方式：</td>
							<td class="FieldInput"><label name="supportPattern"
								field="supportPattern" title="供养方式" dataset="SupportPatternEnum" /></td>
						</tr>
						<tr>
							<td  class="FieldLabel" nowrap>享受低保待遇：</td>
							<td class="FieldInput">
				     			<label id="guarantFlag" name="guarantFlag" field="guarantFlag" title="享受低保待遇" dataset="HolderFlagEnum" />
							</td>
							<td  class="FieldLabel" nowrap>享受五保待遇：</td>
							<td class="FieldInput">
				     			<label id="fiveGuarantFlag" name="fiveGuarantFlag" field="fiveGuarantFlag" title="享受五保待遇" dataset="HolderFlagEnum" />
							</td>
							<td  class="FieldLabel" nowrap>享受过抚恤金：</td>
							<td class="FieldInput">
				     			<label id="enjoyedTreatFlag" name="enjoyedTreatFlag" field="enjoyedTreatFlag" title="享受过抚恤金" dataset="HolderFlagEnum" />
							</td>
						</tr>
						<tr>
							<td class="FieldLabel">开户银行：</td>
							<td class="FieldInput">
							    <label name="bank" field="bank" title="开户银行" dataset="BankEnum" /> </td>
							<td class="FieldLabel">开户名称：</td>
							<td class="FieldInput"><label name="accountName" field="accountName" title="开户名称" /></td>

							<td class="FieldLabel">银行账号：</td>
							<td class="FieldInput"><label name="accountCode" field="accountCode" title="银行账号"></label></td>
						</tr>
						<tr>
							<td class="FieldLabel">备注(类别信息)：</td>
							<td class="FieldInput" colspan="5"><label name="note" field="note"></label></td>
						</tr>
					</table>
					</form>
					</div>
				<div id="retdiv" style="display:none">
					<form id="editFofrm"   dataset="RetiredSoldierDataSet" onsubmit="return false" style="padding: 5px;"  class="L5form">
				<table border="1" id="rettable" width="98%" style="display:none">
					<tr>
							<td   colspan="6">60周岁人员类别信息</td>
						 </tr>
					<tr>
						<td class="FieldLabel" width="17%" >优抚对象状态：</td>
						<td class="FieldInput" style="width:17%"><label name="retiredStateCode"
							field="retiredStateCode" dataset="ObjectStateDataset" title="优抚对象状态"></label></td>
		
						<td class="FieldLabel" width="17%" >证书编号：</td>
						<td class="FieldInput" style="width:17%"><label name="pretiredNo"
							field="pretiredNo" title="证书编号" /></label></td>
		
						<td class="FieldLabel" width="17%" >批准日期：</td>
						<td class="FieldInput" style="width:17%"><label title="批准日期"
							name="approvalDate" field="approvalDate" format="Y-m-d" style="width: 100px;"  /></label></td>
					</tr>
					<tr>
			   		    <td class="FieldLabel" nowrap>入伍时间：</td>
						<td class="FieldInput">
						    <label name="conscriptDate" field="conscriptDate" format="Y-m-d">
						</td>
			   		    <td class="FieldLabel" nowrap>退役时间：</td>
						<td class="FieldInput">
						    <label name="decruitmentDate" field="decruitmentDate" format="Y-m-d">
						</td>
						<td class="FieldLabel" nowrap>退役证件号：</td>
						<td class="FieldInput">
						     <label name="retiredNo" field="retiredNo"></label>
						</td>
					</tr>
					<tr>
				        <td class="FieldLabel" nowrap>服役部队名称(番号)：</td>
						<td class="FieldInput">
						    <label name="forcesName" field="forcesName">
						</td>
						<td class="FieldLabel" nowrap>服役部队代号：</td>
						<td class="FieldInput" colspan="3">
						    <label name="forcesNo" field="forcesNo">
						</td>
				    </tr>
			   		<tr>
			   		    <td class="FieldLabel" nowrap>服义务兵(开始时间)：</td>
						<td class="FieldInput">
						    <label name="soldierStartDate" field="soldierStartDate" format="Y-m-d">
						</td>
						<td class="FieldLabel" nowrap>服义务兵(结束时间)：</td>
						<td class="FieldInput">
						    <label name="soldierEndDate" field="soldierEndDate" format="Y-m-d">
						</td>
			   		    <td class="FieldLabel" nowrap>所服义务兵役折算年限：</td>
						<td class="FieldInput">
						    <label id="soldierYears" name="soldierYears" field="soldierYears">
						 </td>
			   		</tr>
				    <tr>
						<td class="FieldLabel" nowrap>家庭人口：</td>
						<td class="FieldInput">
						     <label name="familyNum" field="familyNum">
						</td>
						<td class="FieldLabel" nowrap>18岁(含)以下：</td>
						<td class="FieldInput">
						    <label name="youngNum" field="youngNum">
						 </td>
					    <td class="FieldLabel" nowrap>60岁(含)以上：</td>
						<td class="FieldInput">
						    <label name="oldNum" field="oldNum">
						 </td>
					</tr>
			   		<tr>
						<td class="FieldLabel" nowrap>是否孤老：</td>
						<td class="FieldInput">
						    <label name="oldLonelyFlag" field="oldLonelyFlag" dataset="OldLonelyFlagEnum">
						</td>
					    <td class="FieldLabel" nowrap>劳动能力：</td>
						<td class="FieldInput">
						    <label name="workAbilityCode" field="workAbilityCode" dataset="workAbilityEnum">
						</td>
						<td class="FieldLabel" nowrap>生活状况：</td>
						<td class="FieldInput">
						     <label name="lifeStateCode" field="lifeStateCode" dataset="lifeStateEnum">
						</td>
					</tr>
			   		<tr>
						<td class="FieldLabel" nowrap>是否享受低保待遇：</td>
						<td class="FieldInput">
						     <label  name="isGuarant" field="isGuarant" dataset="dsGuarant"></label>
						</td>
					    <td class="FieldLabel" nowrap>是否享受五保待遇：</td>
						<td class="FieldInput">
						     <label  name="isFiveGuarant" field="isFiveGuarant" dataset="dsFiveGuarant"></label>
					    </td>
						<td class="FieldLabel" nowrap>身份认定依据：</td>
						<td class="FieldInput">
						    <label  name="identityBasis" field="identityBasis" dataset="identityEnum"></label>
						</td>
					</tr>
					<tr>
						<td class="FieldLabel">开户银行：</td>
						<td class="FieldInput">
						    <label name="bank" field="bank" title="开户银行" dataset="BankEnum" /> </td>
						<td class="FieldLabel">开户名称：</td>
						<td class="FieldInput"><label name="accountName" field="accountName" title="开户名称" /></td>
		
						<td class="FieldLabel">银行账号：</td>
						<td class="FieldInput"><label name="accountCode" field="accountCode" title="银行账号"></label></td>
					</tr>
					<tr>
						<td class="FieldLabel" nowrap>备注(类别信息)：</td>
						<td class="FieldInput" class="FieldInput" colspan="5">
						    <label  name="note" field="note"></label>
						</td>
					</tr>				
				</table>
				</form>
				</div>
				<form id="editFowrm" dataset="BaseinfoFamilyDataSet" 
						onsubmit="return false" style="padding: 5px;" class="L5form">
					<table border="1" width="98%">
						<tr>
							<td   colspan="6">住房信息</td>
						 </tr>
					    <tr>
							<td class="FieldLabel" nowrap="nowrap">住房状况及性质：</td>
							<td class="FieldInput" colspan="3"><label name="houseStatus" field="houseStatus" dataset="HouseStatusDataset"></label>
										&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										<label name="houseQuality" field="houseQuality" dataset="HouseQualityDataset"></label>
										&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										<label name="houseStatus2" field="houseStatus2" dataset="HousingStatusEnum"></label></td>
							
							<td class="FieldLabel">房屋结构：</td>
							<td class="FieldInput"><label name="houseStructureType" field="houseStructureType" dataset="HouseStructureTypeDataset"></label>
										&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										<label name="buildingStructure" field="buildingStructure" dataset="HouseStructureDataset"></label></td>
						</tr>
						<tr>
							<td class="FieldLabel" style="width:15%">房屋间数：</td>
							<td class="FieldInput" style="width:15%"><label name="houseNumber" field="houseNumber" /></td>	
							
							<td class="FieldLabel" nowrap="nowrap" style="width:15%">住房建筑时间：</td>
							<td class="FieldInput" style="width:15%"><label name="buildingDate" field="buildingDate"/></td>
										
							<td class="FieldLabel" nowrap="nowrap" style="width:15%">家庭人口数：</td>
							<td class="FieldInput" style="width:15%"><label name="peopleNum" field="peopleNum"/></td>	
						</tr>
						<tr>
							<td class="FieldLabel">总建筑面积：</td>
							<td class="FieldInput"><label name="buildArea" field="buildArea"/></td>	
						
							<td class="FieldLabel" nowrap="nowrap">人均建筑面积：</td>
							<td class="FieldInput" nowrap="nowrap" colspan="3"><label name="buildAverageArea" field="buildAverageArea"/></td>
						
						</tr>
					 </table>
				   </form>
				  </fieldset>
				</next:Html>
		</next:Panel>
</body>
</html>
