<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<%@page import="com.inspur.cams.comm.util.DateUtil"%>
<html>
<head>
<title>城乡居民家庭经济状况申报列表</title>
<next:ScriptManager />
<script type="text/javascript" src="esureyInfoSum.js"></script>
<script type="text/javascript"
	src='<%=SkinUtils.getJS(request,"cams.js") %>'></script>
<script type="text/javascript"
	src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript">
			<%
			String nowYear= DateUtil.getYear();
			String nowMonth= DateUtil.getMonth();
			String nowTime=DateUtil.getTime().substring(0,10);
			%>
			var familyId='<%=request.getParameter("familyId")%>';
			var surveyId='<%=request.getParameter("surveyId")%>';
		    var organCode='<%=BspUtil.getCorpOrgan().getOrganCode()%>';
		    var nowYear='<%=nowYear%>';
		    var nowMonth='<%=nowMonth%>';
		    var nowTime='<%=nowTime%>';
		    var exportOrg='<%=BspUtil.getCorpOrgan().getOrganName()%>';
	</script>
</head>
<body>
<model:datasets>
		<!-- 属地 -->
	<model:dataset id="domicileDataset" autoLoad="false" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_CITY'></model:param>
			<model:param name="value" value='ID'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!--申报家庭基本信息-->
	<model:dataset id="esureyFamilyDS"
		cmd="com.inspur.cams.drel.esurey.cmd.SamEsureyFamilyQueryCmd">
		<model:record
			fromBean="com.inspur.cams.drel.esurey.data.SamEsureyFamily"></model:record>
	</model:dataset>
	<!--申报家庭基本信息-->
	<model:dataset id="esureyFamilyDS2"
		cmd="com.inspur.cams.drel.esurey.cmd.SamEsureyFamilyQueryCmd">
		<model:record
			fromBean="com.inspur.cams.drel.esurey.data.SamEsureyFamily"></model:record>
	</model:dataset>
	<!--申报家庭基本信息-->
	<model:dataset id="esureyFamilyDS3"
		cmd="com.inspur.cams.drel.esurey.cmd.SamEsureyFamilyQueryCmd">
		<model:record
			fromBean="com.inspur.cams.drel.esurey.data.SamEsureyFamily"></model:record>
	</model:dataset>
	<!--申报家庭成员基本信息-->
	<model:dataset id="esureyPeopleDS"
		cmd="com.inspur.cams.drel.esurey.cmd.SamEsureyPeopleQueryCmd">
		<model:record
			fromBean="com.inspur.cams.drel.esurey.data.SamEsureyPeople"></model:record>
	</model:dataset>
	<!--赡养家庭Id、人口数-->
	<model:dataset id="queryRelFamiyIdNumDS"
		cmd="com.inspur.cams.drel.esurey.cmd.SamEsureyRelationQueryCmd"
		method="queryRelFamiyIdNum">

	</model:dataset>
	<!--申报家庭成员基本信息-->
	<model:dataset id="esureyPeopleDS2"
		cmd="com.inspur.cams.drel.esurey.cmd.SamEsureyPeopleQueryCmd">
		<model:record
			fromBean="com.inspur.cams.drel.esurey.data.SamEsureyPeople"></model:record>
	</model:dataset>
	<!--申报家庭成员基本信息-->
	<model:dataset id="esureyRelPeopleDS"
		cmd="com.inspur.cams.drel.esurey.cmd.SamEsureyPeopleQueryCmd">
		<model:record
			fromBean="com.inspur.cams.drel.esurey.data.SamEsureyPeople"></model:record>
	</model:dataset>
	<!--申报家庭成员基本信息-->
	<model:dataset id="esureyPeopleDS3"
		cmd="com.inspur.cams.drel.esurey.cmd.SamEsureyPeopleQueryCmd">
		<model:record
			fromBean="com.inspur.cams.drel.esurey.data.SamEsureyPeople"></model:record>
	</model:dataset>
	<!--申报家庭成员基本信息-->
	<model:dataset id="esureyPeopleDS4"
		cmd="com.inspur.cams.drel.esurey.cmd.SamEsureyPeopleQueryCmd">
		<model:record
			fromBean="com.inspur.cams.drel.esurey.data.SamEsureyPeople"></model:record>
	</model:dataset>
	<!--申报信息_抚养关系-->
	<model:dataset id="esureyRelationDS"
		cmd="com.inspur.cams.drel.esurey.cmd.SamEsureyRelationQueryCmd">
		<model:record
			fromBean="com.inspur.cams.drel.esurey.data.SamEsureyRelation"></model:record>
	</model:dataset>
	<!--申报家庭成员社保基本信息-->
	<model:dataset id="SamEsureySocialDS"
		cmd="com.inspur.cams.drel.esurey.cmd.SamEsureySocialQueryCmd">
		<model:record
			fromBean="com.inspur.cams.drel.esurey.data.SamEsureySocial"></model:record>
	</model:dataset>
	<!--申报家庭成员财产收入基本信息-->
	<model:dataset id="SamEsureyPeopleEstateDS"
		cmd="com.inspur.cams.drel.esurey.cmd.SamEsureyPeopleEstateQueryCmd">
		<model:record
			fromBean="com.inspur.cams.drel.esurey.data.SamEsureyPeopleEstate"></model:record>
	</model:dataset>
	<!--申报家庭收入信息-->
	<model:dataset id="SamEsureyFamilyIncomeDS"
		cmd="com.inspur.cams.drel.esurey.cmd.SamEsureyPeopleEstateQueryCmd"
		method="queryFamilyIncome">
	</model:dataset>
	<!--申报家庭成员收入信息-->
	<model:dataset id="SamEsureyPeoIncomeDS"
		cmd="com.inspur.cams.drel.esurey.cmd.SamEsureyPeopleEstateQueryCmd"
		method="queryFamilyIncome">
	</model:dataset>
	<!--申报家庭成员房管基本信息-->
	<model:dataset id="SamEsureyHouseDS"
		cmd="com.inspur.cams.drel.esurey.cmd.SamEsureyHouseQueryCmd">
		<model:record
			fromBean="com.inspur.cams.drel.esurey.data.SamEsureyHouse"></model:record>
	</model:dataset>
	<!--申报家庭成员工商基本信息-->
	<model:dataset id="SamEsureyBusinessDS"
		cmd="com.inspur.cams.drel.esurey.cmd.SamEsureyBusinessQueryCmd">
		<model:record
			fromBean="com.inspur.cams.drel.esurey.data.SamEsureyBusiness"></model:record>
	</model:dataset>
	<!--申报家庭成员车管基本信息-->
	<model:dataset id="SamEsureyCarDS"
		cmd="com.inspur.cams.drel.esurey.cmd.SamEsureyCarQueryCmd">
		<model:record fromBean="com.inspur.cams.drel.esurey.data.SamEsureyCar"></model:record>
	</model:dataset>
	<!--申报家庭成员国税地税基本信息-->
	<model:dataset id="SamEsureyTaxDS"
		cmd="com.inspur.cams.drel.esurey.cmd.SamEsureyTaxQueryCmd">
		<model:record fromBean="com.inspur.cams.drel.esurey.data.SamEsureyTax"></model:record>
	</model:dataset>
	<!--申报家庭成员公积金基本信息-->
	<model:dataset id="SamEsureyHousingFundDS"
		cmd="com.inspur.cams.drel.esurey.cmd.SamEsureyHousingFundQueryCmd">
		<model:record
			fromBean="com.inspur.cams.drel.esurey.data.SamEsureyHousingFund"></model:record>
	</model:dataset>
	<!--申报家庭成员人行基本信息-->
	<model:dataset id="SamEsureyBankDS"
		cmd="com.inspur.cams.drel.esurey.cmd.SamEsureyBankQueryCmd">
		<model:record
			fromBean="com.inspur.cams.drel.esurey.data.SamEsureyBank"></model:record>
	</model:dataset>
	<!--申报家庭成员证监基本信息-->
	<model:dataset id="SamEsureySecuritiesDS"
		cmd="com.inspur.cams.drel.esurey.cmd.SamEsureySecuritiesQueryCmd">
		<model:record
			fromBean="com.inspur.cams.drel.esurey.data.SamEsureySecurities"></model:record>
	</model:dataset>
	<!--申报家庭成员保监基本信息-->
	<model:dataset id="SamEsureyInsuranceDS"
		cmd="com.inspur.cams.drel.esurey.cmd.SamEsureyInsuranceQueryCmd">
		<model:record
			fromBean="com.inspur.cams.drel.esurey.data.SamEsureyInsurance"></model:record>
	</model:dataset>
	<!--申报家庭成员社保基本信息-->
	<model:dataset id="SamEsureySocialExtDS"
		cmd="com.inspur.cams.drel.esurey.cmd.SamEsureySocialQueryCmd">
		<model:record
			fromBean="com.inspur.cams.drel.esurey.data.SamEsureySocial"></model:record>
	</model:dataset>
	<!--申报家庭成员财产收入基本信息-->
	<model:dataset id="SamEsureyPeopleEstateExtDS"
		cmd="com.inspur.cams.drel.esurey.cmd.SamEsureyPeopleEstateQueryCmd">
		<model:record
			fromBean="com.inspur.cams.drel.esurey.data.SamEsureyPeopleEstate"></model:record>
	</model:dataset>
	<!--申报家庭成员房管基本信息-->
	<model:dataset id="SamEsureyHouseExtDS"
		cmd="com.inspur.cams.drel.esurey.cmd.SamEsureyHouseQueryCmd">
		<model:record
			fromBean="com.inspur.cams.drel.esurey.data.SamEsureyHouse"></model:record>
	</model:dataset>
	<!--申报家庭成员工商基本信息-->
	<model:dataset id="SamEsureyBusinessExtDS"
		cmd="com.inspur.cams.drel.esurey.cmd.SamEsureyBusinessQueryCmd">
		<model:record
			fromBean="com.inspur.cams.drel.esurey.data.SamEsureyBusiness"></model:record>
	</model:dataset>
	<!--申报家庭成员车管基本信息-->
	<model:dataset id="SamEsureyCarExtDS"
		cmd="com.inspur.cams.drel.esurey.cmd.SamEsureyCarQueryCmd">
		<model:record fromBean="com.inspur.cams.drel.esurey.data.SamEsureyCar"></model:record>
	</model:dataset>
	<!--申报家庭成员国税地税基本信息-->
	<model:dataset id="SamEsureyTaxExtDS"
		cmd="com.inspur.cams.drel.esurey.cmd.SamEsureyTaxQueryCmd">
		<model:record fromBean="com.inspur.cams.drel.esurey.data.SamEsureyTax"></model:record>
	</model:dataset>
	<!--申报家庭成员公积金基本信息-->
	<model:dataset id="SamEsureyHousingFundExtDS"
		cmd="com.inspur.cams.drel.esurey.cmd.SamEsureyHousingFundQueryCmd">
		<model:record
			fromBean="com.inspur.cams.drel.esurey.data.SamEsureyHousingFund"></model:record>
	</model:dataset>
	<!--申报家庭成员人行基本信息-->
	<model:dataset id="SamEsureyBankExtDS"
		cmd="com.inspur.cams.drel.esurey.cmd.SamEsureyBankQueryCmd">
		<model:record
			fromBean="com.inspur.cams.drel.esurey.data.SamEsureyBank"></model:record>
	</model:dataset>
	<!--申报家庭成员证监基本信息-->
	<model:dataset id="SamEsureySecuritiesExtDS"
		cmd="com.inspur.cams.drel.esurey.cmd.SamEsureySecuritiesQueryCmd">
		<model:record
			fromBean="com.inspur.cams.drel.esurey.data.SamEsureySecurities"></model:record>
	</model:dataset>
	<!--申报家庭成员保监基本信息-->
	<model:dataset id="SamEsureyInsuranceExtDS"
		cmd="com.inspur.cams.drel.esurey.cmd.SamEsureyInsuranceQueryCmd">
		<model:record
			fromBean="com.inspur.cams.drel.esurey.data.SamEsureyInsurance"></model:record>
	</model:dataset>
	<!--经济核对_家庭经济状况审核汇总-->
	<model:dataset id="SamEsureyFamilySumDS"
		cmd="com.inspur.cams.drel.esurey.cmd.SamEsureyFamilySumQueryCmd">
		<model:record
			fromBean="com.inspur.cams.drel.esurey.data.SamEsureyFamilySum"></model:record>
	</model:dataset>
	<!-- 人员汇总-->
	<model:dataset id="SamEsureyPeopleSumDS"
		cmd="com.inspur.cams.drel.esurey.cmd.SamEsureyPeopleSumQueryCmd">
		<model:record
			fromBean="com.inspur.cams.drel.esurey.data.SamEsureyPeopleSum"></model:record>
	</model:dataset>

	<!--是否为赡养义务人员-->
	<model:dataset id="isSupportDS" enumName="COMM.YESORNO" autoLoad="true"
		global="true"></model:dataset>
	<!-- 与户主关系 -->
	<model:dataset id="RelationDS" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_RELATIONSHIP_TYPE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!--经济核对_财产收入申报信息dataset-->
	<model:dataset id="estateDataset"
		cmd="com.inspur.cams.drel.esurey.cmd.SamEsureyPeopleEstateQueryCmd"
		global="true" pageSize="10">
		<model:record
			fromBean="com.inspur.cams.drel.esurey.data.SamEsureyPeopleEstate"></model:record>
	</model:dataset>
	<!--经济核对_财产收入申报信息dataset-->
	<model:dataset id="estateDatasetOther"
		cmd="com.inspur.cams.drel.esurey.cmd.SamEsureyPeopleEstateQueryCmd"
		global="true" pageSize="10">
		<model:record
			fromBean="com.inspur.cams.drel.esurey.data.SamEsureyPeopleEstate"></model:record>
	</model:dataset>
	<!--经济核对_家庭财产dataset-->
	<model:dataset id="estateDatasetWorth"
		cmd="com.inspur.cams.drel.esurey.cmd.SamEsureyPeopleEstateQueryCmd"
		global="true" pageSize="10" method="queryFamilyWorth">
	</model:dataset>
	<!--经济核对_家庭成员收入（三项和）申报信息dataset-->
	<model:dataset id="estateDatasetThree"
		cmd="com.inspur.cams.drel.esurey.cmd.SamEsureyPeopleEstateQueryCmd"
		method="queryPeopleIncom" global="true" pageSize="10">
	</model:dataset>
	<!-- 性别 -->
	<model:dataset id="sexDS" enumName="COMM.SEX" autoLoad="true"
		global="ture"></model:dataset>

	<!-- 民族 -->
	<model:dataset id="DmMzDataSet"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_NATION'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 家庭性质 -->
	<model:dataset id="familyTypeDS" enumName="FAMILY_TYPE" autoLoad="true"
		global="true"></model:dataset>
	<!-- 住房类型 -->
	 <model:dataset id="houseTypeDS" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_HOUSE_QUALITY'></model:param>
		</model:params>
	</model:dataset>
	<!-- 房屋状况 -->
	 <model:dataset id="buildingTypeDS" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_HOUSE_STATUS'></model:param>
		</model:params>
	</model:dataset>
	<!-- 救助类型 -->
	<model:dataset id="assistanceTypeDS" enumName="ASSISTANCE_TYPE"
		autoLoad="true" global="true"></model:dataset>
	<!-- 家庭诚信等级 -->
	<model:dataset id="creditRatingDS" enumName="CREDIT_RATING"
		autoLoad="true" global="true"></model:dataset>
<!-- 教育状况 -->
	<model:dataset id="DmJyzkDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_EDUCATION'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 健康状况 -->
	<model:dataset id="healthDS" enumName="HEALTH_CODE" autoLoad="true"
		global="true"></model:dataset>
<!-- 婚姻状况-->
	<model:dataset id="DmHyzkDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_MARRIAGE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 低保标准 -->
	<model:dataset id="lowStandardDs"
		cmd="com.inspur.cams.drel.esurey.cmd.SamLowStandardsQueryCmd"
		global="true">
		<model:record
			fromBean="com.inspur.cams.drel.esurey.data.SamLowStandards"></model:record>
	</model:dataset>
<!-- 职业状况-->
	<model:dataset id="DmZyDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_EMPLOYMENT_CODE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 政治面貌 -->
	<model:dataset id="politicsDS" enumName="SORG.POLITICS" autoLoad="true"
		global="true"></model:dataset>
	<!-- 年月标志 -->
	<model:dataset id="ymDS" enumName="YEAR_MONTH" autoLoad="true"
		global="true"></model:dataset>
	<!-- 工资类别 -->
	<model:dataset id="salaryDS" enumName="SALARY_TYPE" autoLoad="true"
		global="true"></model:dataset>
	<!-- 财产类别 -->
	<model:dataset id="itemDS" enumName="ITEM" autoLoad="true"
		global="true"></model:dataset>
	<!-- 房屋用途 -->
	<model:dataset id="houseUserageDataset" enumName="HOUSE.USEAGE"
		autoLoad="true" global="true"></model:dataset>
	<!-- 交易性质 -->
	<model:dataset id="businessTypeDataset" enumName="BUSINESS.TYPE"
		autoLoad="true" global="true"></model:dataset>
	<!-- 企业注册方式 -->
	<model:dataset id="compBusinessTypeDataset"
		enumName="COMP.BUSINESS.TYPE" autoLoad="true" global="true"></model:dataset>
	<!-- 公司状态 -->
	<model:dataset id="organDataset" enumName="ORGAN.STATUS"
		autoLoad="true" global="true"></model:dataset>
	<!-- 车辆用途 -->
	<model:dataset id="carUseDataset" enumName="CAR.USE" autoLoad="true"
		global="true"></model:dataset>
	<!-- 车辆类型 -->
	<model:dataset id="carTypeDS" enumName="CAR_TYPE" autoLoad="true"
		global="true"></model:dataset>
	<!-- 保险受益类型 -->
	<model:dataset id="beneDS" enumName="BENE_TYPE" autoLoad="true"
		global="true"></model:dataset>
	<!-- 低收入家庭有效期 -->
    <model:dataset id="validPeriodDs" cmd="com.inspur.cams.comm.dicm.cmd.DicDetailsQueryCmd" method="queryForDic" global="true" autoLoad="true">
        <model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
        <model:params>
            <model:param name="dicType" value="VALID_PERIOD"></model:param>
        </model:params>
    </model:dataset>
    <!-- 低收入家庭类型 -->
    <model:dataset id="lowIncomeTypeDs" cmd="com.inspur.cams.comm.dicm.cmd.DicDetailsQueryCmd" method="queryForDic" global="true" autoLoad="true">
        <model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
        <model:params>
            <model:param name="dicType" value="LOW_INCOME_TYPE"></model:param>
        </model:params>
    </model:dataset>
</model:datasets>
<next:ViewPort>
	<next:Panel name="fit-div" width="100%" height="100%" autoScroll="true">
		<next:Panel id="jtjbxxPanel" autoWidth="true" height="true"
			autoScroll="true">
			<next:TopBar>
				<next:ToolBarItem text="申报家庭基本信息"></next:ToolBarItem>
				<next:ToolBarItem symbol="->"></next:ToolBarItem>
				<next:ToolBarItem iconCls="save" text="保存核对汇总审核信息"
					handler="save_return_list" />
				<next:ToolBarItem iconCls="detail" text="打印核对报告"
					handler="printList" />
				<next:ToolBarItem iconCls="undo" text="返回" handler="return_list" />
				<next:ToolBarItem symbol=""></next:ToolBarItem>
				<next:ToolBarItem symbol="-"></next:ToolBarItem>
				<next:ToolBarItem symbol=""></next:ToolBarItem>
			</next:TopBar>
			<next:Html>
				<form id="sbjtjbxxForm" method="post" onsubmit="return false"
					style="padding: 5px;" dataset="esureyFamilyDS" class="L5form">
				<table border="0" width="99%">
					<tr>
						<td class="FieldLabel" colspan="2">户主姓名:</td>
						<td class="FieldInput"><label id="supfamilyName" name="户主姓名:"
							field="familyName"></label></td>
						<td class="FieldLabel" colspan="2">身份证号:</td>
						<td class="FieldInput"><label id="supfamilyCardNo"
							name="身份证号:" field="familyCardNo"></label></td>
					</tr>
					<tr>
						<td class="FieldLabel" colspan="2">家庭人口数量:</td>
						<td class="FieldInput"><label id="suppeopleNum" name="家庭人口数量"
							field="peopleNum"></label></td>
						<td class="FieldLabel" colspan="2">家庭性质:</td>
						<td class="FieldInput"><label id="supdomicileType"
							name="家庭性质:" field="domicileType" dataset="familyTypeDS"></label>
						</td>
					</tr>
					<tr>
						<td class="FieldLabel" colspan="2">救助类型:</td>
						<td class="FieldInput"><label name="救助类型" 
							field="assistanceType" dataset="assistanceTypeDS"></label></td>
						<td class="FieldLabel" colspan="2">邮政编码:</td>
						<td class="FieldInput"><label id="supfamilyPostcode"
							name="邮政编码: " field="familyPostcode"></label></td>
					</tr>
					<tr>
						<td class="FieldLabel" colspan="2">户籍行政区划:</td>
						<td class="FieldInput"><label id="supregAddress" name="domicileName"
							field="regAddress" dataset="domicileDataset" ></label></td>
						<td class="FieldLabel" colspan="2">属地行政区划:</td>
						<td class="FieldInput"><label id="supfamilyAddress" dataset="domicileDataset"
							field="familyAddress"></label></td>
					</tr>
					<tr>
						<td class="FieldLabel" colspan="2">家庭住址:</td>
						<td class="FieldInput" colspan="4"><label id="supaddress"
							name="家庭住址:" field="address" style="width: 99%"></label></td>
					</tr>
					<tr>
						<td class="FieldLabel" rowspan="3" width="9%">联系电话</td>
						<td class="FieldLabel" width="15%">宅电:</td>
						<td class="FieldInput" width="26%"><label id="supfamilyPhone"
							name="宅电:" field="familyPhone"></label></td>
						<td class="FieldLabel" rowspan="3" width="9%">家庭住房</td>
						<td class="FieldLabel" width="15%">住房情况:</td>
						<td class="FieldInput" width="26%"><label name="住房情况:"
							field="houseStatus" dataset="houseTypeDS"></label></td>
					</tr>
					<tr>
						<td class="FieldLabel">手机:</td>
						<td class="FieldInput"><label id="supfamilyMobile" name="手机:"
							field="familyMobile"></label></td>
						<td class="FieldLabel">房屋性质:</td>
						<td class="FieldInput"><label name="房屋性质:"
							field="buildingStructure" dataset="buildingTypeDS"></label></td>
					</tr>
					<tr>
						<td class="FieldLabel">其他:</td>
						<td class="FieldInput"><label name="其他:"
							id="supfamilyOtherPhone" field="familyOtherPhone"></label></td>
						<td class="FieldLabel" style="width: 110px;">房屋面积<br />
						(单位：平方米):</td>
						<td class="FieldInput"><label id="supbuildArea"
							name="房屋面积(平方):" field="buildArea"></label></td>
					</tr>
					<tr>
						<td class="FieldLabel" rowspan="2">收入情况</td>
						<td class="FieldLabel">家庭年：<br />
						(单位：元)</td>
						<td class="FieldInput"><label id="supyearIncome" name="家庭年:"
							field="yearIncome"></label></td>
						<td class="FieldLabel" rowspan="2">收入情况</td>
						<td class="FieldLabel">家庭月：<br />
						(单位：元)</td>
						<td class="FieldInput"><label name="家庭月:" field="monthIncome"></label>
						</td>
					</tr>
					<tr>
						<td class="FieldLabel">家庭年人均：<br />
						(单位：元)</td>
						<td class="FieldInput"><label name="家庭年人均:"
							id="supyearAverageIncome" field="yearAverageIncome"></label></td>
						<td class="FieldLabel" style="width: 110px;">家庭月人均：<br />
						(单位：元)</td>
						<td class="FieldInput"><label id="supmonthAverageIncome"
							name="家庭月人均:" field="monthAverageIncome"></label></td>
					</tr>
					<tr>
						<td class="FieldLabel" rowspan="4">外部单位核对信息</td>
						<td class="FieldLabel">家庭年总收入：<br />
						(单位：元)</td>
						<td class="FieldInput"><input type="text" id="extyearIncome"></input></td>
						<td class="FieldLabel" colspan="2">家庭年人均收入：<br />
						(单位：元)</td>
						<td class="FieldInput"><input type="text"
							id="extyearAverageIncome"></input></td>
					</tr>
					<tr>
						<td class="FieldLabel">家庭月总收入：<br />
						(单位：元)</td>
						<td class="FieldInput"><input type="text" id="extmonthIncome"></input></td>
						<td class="FieldLabel" colspan="2">家庭月人均收入：<br />
						(单位：元)</td>
						<td class="FieldInput"><input type="text"
							id="extmonthAverageIncome"></input></td>
					</tr>
					<tr>
						<td class="FieldLabel">家庭月总财产：<br />
						(单位：元)</td>
						<td class="FieldInput" colspan="4"><input type="text" id="extfamilyWorth"></input></td>
					</tr>
					<tr>
						<td class="FieldLabel">年赡养费：<br />(单位：元)</td>
						<td class="FieldInput"><input type="text"
							id="extyearSupportMon"></input></td>
						<td class="FieldLabel" colspan="2">月赡养费：<br />(单位：元)</td>
						<td class="FieldInput"><input type="text"
							id="extmonthSupportMon"></input></td>
					</tr>
					<tr>
						<td class="FieldLabel" rowspan="2">审核信息</td>
						<td class="FieldLabel">家庭诚信等级：</td>
						<td class="FieldInput"><select name="家庭诚信等级"
							id="creditRating">
							<option dataset="creditRatingDS"></option>
						</select><font color="red">*</font></td>
						<td class="FieldLabel" colspan="2">低收入家庭类型：</td>
						<td class="FieldInput"><select name="低收入家庭类型" id="lowIncomeType" onchange="checkLowIncomeType(this.value);" >
							<option dataset="lowIncomeTypeDs"></option>
						</select></td>
					</tr>
					<tr>
						<td class="FieldLabel">有效期限：</td>
						<td class="FieldInput"><select name="有效期限"
							id="validPeriod" disabled=true onchange="checkValidDate(this.value);">
							<option dataset="validPeriodDs"></option>
						</select></td>
						<td class="FieldLabel" colspan="2">有效期至</td>
						<td class="FieldInput"><input type="text"
							id="validDate" readonly ></input></td>
					</tr>
				</table>
				</form>
			</next:Html>
		</next:Panel>
		<next:GridPanel id="jtcyGridPanel" name="jtcyGridPanel" width="100%"
			stripeRows="true" height="50%" dataset="esureyPeopleDS">
			<next:TopBar>
				<next:ToolBarItem text="共同生活家庭成员列表:"></next:ToolBarItem>
				<next:ToolBarItem symbol="->"></next:ToolBarItem>
				<next:ToolBarItem iconCls="detail" text="查看明细"
					handler="detail_people()" />
				<next:ToolBarItem symbol=""></next:ToolBarItem>
				<next:ToolBarItem symbol="-"></next:ToolBarItem>
				<next:ToolBarItem symbol=""></next:ToolBarItem>
			</next:TopBar>
			<next:Columns>
				<next:RowNumberColumn width="20" />
				<next:RadioBoxColumn></next:RadioBoxColumn>
				<next:Column id="peopleId" header="人员Id" field="peopleId"
					hidden="true" width="30">
				</next:Column>
				<next:Column id="familyId" header="家庭Id" field="familyId"
					hidden="true" width="30">
				</next:Column>
				<next:Column id="name" header="成员姓名" field="name" width="20%"
					renderer="peopleDetailHref">
				</next:Column>
				<next:Column id="relationshipType" header="户主关系"
					field="relationshipType" dataset="RelationDS" width="15%">
				</next:Column>
				<next:Column id="idCard" header="身份证号" field="idCard" width="20%">
				</next:Column>
				<next:Column id="sex" header="性别" field="sex" width="10%"
					dataset="sexDS">
				</next:Column>
				<next:Column id="nation" header="民族" field="nation"
					dataset="DmMzDataSet" width="10%">
				</next:Column>
			</next:Columns>
			<next:BottomBar>
				<next:PagingToolBar dataset="esureyPeopleDS" />
			</next:BottomBar>
		</next:GridPanel>
		<next:GridPanel id="jtcysfGridPanel" name="jtcysfGridPanel"
			width="100%" stripeRows="true" height="50%" dataset="esureyPeopleDS3">
			<next:TopBar>
				<next:ToolBarItem text="赡（抚、扶）养义务人员列表:"></next:ToolBarItem>
				<next:ToolBarItem symbol="->"></next:ToolBarItem>
				<next:ToolBarItem iconCls="detail" text="查看详情"
					handler="detail_people1()" />
				<next:ToolBarItem iconCls="detail" text="相应的家庭信息"
					handler="detail_family" />
				<next:ToolBarItem symbol=""></next:ToolBarItem>
				<next:ToolBarItem symbol="-"></next:ToolBarItem>
				<next:ToolBarItem symbol=""></next:ToolBarItem>
			</next:TopBar>
			<next:Columns>
				<next:RowNumberColumn width="20" />
				<next:RadioBoxColumn></next:RadioBoxColumn>
				<next:Column id="speopleId" header="人员Id" field="peopleId"
					hidden="true" width="90">
				</next:Column>
				<next:Column id="sfamilyId" header="家庭Id" field="familyId"
					hidden="true" width="90">
				</next:Column>
				<next:Column id="sname" header="姓名" field="name" width="20%"
					renderer="peopleDetailHref">
				</next:Column>
				<next:Column id="srelationshipType" header="户主关系"
					field="relationshipType" dataset="RelationDS" width="15%">
				</next:Column>
				<next:Column id="sidCard" header="身份证号" field="idCard" width="30%">
				</next:Column>
			</next:Columns>
			<next:BottomBar>
				<next:PagingToolBar dataset="esureyPeopleDS3" />
			</next:BottomBar>
		</next:GridPanel>
	</next:Panel>
</next:ViewPort>
<next:Window id="jtcyEdit" title="编辑" titleCollapse="false"
	resizable="false" width="500" height="400" closeAction="hide">
	<next:FitLayout>
		<next:TabPanel id="jtcyTabpanel" activeTab="1" border="false">
			<next:Tabs>
				<!--	成员基本信息	-->
				<next:Panel title="成员基本信息">
					<next:Html>
						<form id="cyjbxxForm" method="post" onsubmit="return false"
							style="padding: 5px;" dataset="esureyPeopleDS2" class="L5form">
						<table border="0" width="99%">
							<tr>
								<td class="FieldLabel">是否为赡（抚、扶）养义务人员：</td>
								<td class="FieldInput" colspan="3"><label id="isSupport"
									field="isSupport" dataset="isSupportDS"></label></td>
							</tr>
							<tr>
								<td class="FieldLabel" width="20%">姓名:</td>
								<td class="FieldInput" width="30%"><label id="name"
									name="姓名:" field="name"></label></td>
								<td class="FieldLabel" width="20%">与户主关系:</td>
								<td class="FieldInput" width="30%"><label name="与户主关系:"
									id="relationshipType" field="relationshipType"
									dataset="RelationDS"></label></td>
							</tr>
							<tr>
								<td class="FieldLabel">身份证号:</td>
								<td class="FieldInput"><label name="身份证号:" id="idCard"
									field="idCard"></label></td>
								<td class="FieldLabel">性别:</td>
								<td class="FieldInput"><label name="性别" field="sex"
									dataset="sexDS"></label></td>
							</tr>
							<tr>
								<td class="FieldLabel">民族:</td>
								<td class="FieldInput"><label name="民族:" id="nation"
									field="nation" dataset="DmMzDataSet"></label></td>
								<td class="FieldLabel">文化程度:</td>
								<td class="FieldInput"><label name="文化程度:" id="eduCode"
									field="eduCode" dataset="DmJyzkDataSet"></label></td>
							</tr>
							<tr>
								<td class="FieldLabel">健康状况:</td>
								<td class="FieldInput"><label name="健康状况:" id="healthCode"
									field="healthCode" dataset="healthDS"></label></td>
								<td class="FieldLabel">婚姻状况:</td>
								<td class="FieldInput"><label name="婚姻状况:"
									id="marriageCode" field="marriageCode" dataset="DmHyzkDataSet"></label>
								</td>
							</tr>
							<tr>
								<td class="FieldLabel">职业:</td>
								<td class="FieldInput"><label name="职业:" id="careerCode"
									field="careerCode" dataset="DmZyDataSet"></label></td>
								<td class="FieldLabel">政治面貌:</td>
								<td class="FieldInput"><label name="政治面貌:"
									id="politicalCode" field="politicalCode" dataset="politicsDS"></label>
								</td>
							</tr>
							<tr>
								<td class="FieldLabel">户口性质:</td>
								<td class="FieldInput" colspan="3"><label name="户口性质"
									id="domicileType" field="domicileType" dataset="familyTypeDS"></label>
								</td>
							</tr>
							<tr>
								<td class="FieldLabel">年收入：<br />
								(单位：元)</td>
								<td class="FieldInput"><label name="年收入:" id="incomeYear"
									field="incomeYear"></label></td>
								<td class="FieldLabel">月收入：<br />
								(单位：元)</td>
								<td class="FieldInput"><label name="月收入:" id="incomeMonth"
									field="incomeMonth"></label></td>
							</tr>
							<tr>
								<td class="FieldLabel">工作单位:</td>
								<td class="FieldInput" colspan="3"><label id="workUnitName"
									field="workUnitName"></label></td>
							</tr>
							<tr>
								<td class="FieldLabel">年收入（元）（汇总）:</td>
								<td class="FieldInput"><input type="text" name="年收入:"
									id="extincomeYear" /></td>
								<td class="FieldLabel">月收入（元）（汇总）:</td>
								<td class="FieldInput"><input type="text" name="月收入:"
									id="extincomeMonth" /></td>
							</tr>
						</table>
						</form>
					</next:Html>
				</next:Panel>

				<!--	成员经济状况信息	-->
				<next:Panel title="本成员经济状况信息">
					<next:Panel>
						<next:Html>
							<form id="cyjjzkxxForm" method="post" onsubmit="return false"
								style="padding: 5px;" class="L5form">
							<table border="0" width="99%" height="100%">
								<tr>
									<td class="FieldLabel">姓名:</td>
									<td class="FieldInput" width="240"><label id="cyName"
										readonly="readonly" /></td>
									<td class="FieldLabel">身份证号:</td>
									<td class="FieldInput"><label id="cyIdCard"
										readonly="readonly" /></td>
								</tr>
							</table>
							</form>
						</next:Html>
					</next:Panel>
					<next:Panel width="100%" height="100%" autoScroll="true">
						<next:EditGridPanel id="social_grid" name="social_grid"
							width="99%" height="200" clicksToEdit="2"
							dataset="SamEsureySocialDS">
							<next:TopBar>
								<next:ToolBarItem text="本成员社保列表:"></next:ToolBarItem>
							</next:TopBar>
							<next:Columns>
								<next:RowNumberColumn width="10" />
								<next:RadioBoxColumn></next:RadioBoxColumn>
								<next:Column id="hsId" header="流水ID" field="id" hidden="true">
									<next:TextField allowBlank="false" />
								</next:Column>
								<next:Column id="hsType" header="信息类别" field="type"
									hidden="true">
									<next:TextField allowBlank="false" />
								</next:Column>
								<next:Column id="hsFeedbackId" header="填表Id" field="feedbackId"
									hidden="true">
									<next:TextField allowBlank="false" />
								</next:Column>
								<next:Column id="hsPeopleId" header="人员Id" field="peopleId"
									hidden="true">
									<next:TextField allowBlank="false" />
								</next:Column>
								<next:Column id="hsYearMonth" header="年月区分标志" field="yearMonth">
									<next:ComboBox triggerAction="all" valueField="value"
										displayField="text" dataset="ymDS" />
								</next:Column>
								<next:Column id="hsSalaryType" header="工资类别" field="salaryType">
									<next:ComboBox triggerAction="all" valueField="value"
										displayField="text" dataset="salaryDS" />
								</next:Column>
								<next:Column id="hsSalary" header="工资、养老金金额" field="salary">
									<next:NumberField allowBlank="false" />
								</next:Column>
								<next:Column id="hsPension" header="养老金缴纳金额" field="pension">
									<next:TextField allowBlank="false" />
								</next:Column>
								<next:Column id="hsPensionBalance" header="养老金余额"
									field="pensionBalance">
									<next:TextField allowBlank="false" />
								</next:Column>
							</next:Columns>
						</next:EditGridPanel>

						<next:EditGridPanel id="estate_grid" name="estate_grid"
							width="99%" height="200" clicksToEdit="2"
							dataset="SamEsureyPeopleEstateDS">
							<next:TopBar>
								<next:ToolBarItem text="本成员其他财产收入列表:"></next:ToolBarItem>
							</next:TopBar>
							<next:Columns>
								<next:RowNumberColumn width="10" />
								<next:RadioBoxColumn></next:RadioBoxColumn>
								<next:Column id="htId" header="流水ID" field="id" hidden="true">
									<next:TextField allowBlank="false" />
								</next:Column>
								<next:Column id="htType" header="信息类别" field="type"
									hidden="true">
									<next:TextField allowBlank="false" />
								</next:Column>
								<next:Column id="htFeedbackId" header="填表Id" field="feedbackId"
									hidden="true">
									<next:TextField allowBlank="false" />
								</next:Column>
								<next:Column id="htPeopleId" header="人员Id" field="peopleId"
									hidden="true">
									<next:TextField allowBlank="false" />
								</next:Column>
								<next:Column id="hperiod" header="年月区分标志" field="period">
									<next:ComboBox triggerAction="all" valueField="value"
										displayField="text" dataset="ymDS" />
								</next:Column>
								<next:Column id="hitem" header="财产、收入类别" field="item">
									<next:ComboBox triggerAction="all" valueField="value"
										displayField="text" dataset="itemDS" />
								</next:Column>
								<next:Column id="hnum" header="金额" field="num">
									<next:NumberField allowBlank="false" />
								</next:Column>
							</next:Columns>
						</next:EditGridPanel>

						<next:EditGridPanel id="house_grid" name="house_grid" width="99%"
							height="200" clicksToEdit="2" dataset="SamEsureyHouseDS">
							<next:TopBar>
								<next:ToolBarItem text="本成员房屋信息列表:"></next:ToolBarItem>
							</next:TopBar>
							<next:Columns>
								<next:RowNumberColumn width="10" />
								<next:RadioBoxColumn></next:RadioBoxColumn>
								<next:Column id="hhId" header="流水ID" field="id" hidden="true">
									<next:TextField allowBlank="false" />
								</next:Column>
								<next:Column id="hhType" header="信息类别" field="type"
									hidden="true">
									<next:TextField allowBlank="false" />
								</next:Column>
								<next:Column id="hhFeedbackId" header="填表Id" field="feedbackId"
									hidden="true">
									<next:TextField allowBlank="false" />
								</next:Column>
								<next:Column id="hhPeopleId" header="人员Id" field="peopleId"
									hidden="true">
									<next:TextField allowBlank="false" />
								</next:Column>
								<next:Column id="hhouseCardNo" header="房产证号" field="houseCardNo">
									<next:TextField allowBlank="false" />
								</next:Column>
								<next:Column id="hhouseUseage" header="房屋用途" field="houseUseage">
									<next:ComboBox triggerAction="all" valueField="value"
										displayField="text" dataset="houseUserageDataset" />
								</next:Column>
								<next:Column id="hhregValue" header="交易价值(元)" field="regValue">
									<next:NumberField allowBlank="false" />
								</next:Column>
								<next:Column id="hregDate" header="登记或交易时间" field="regDate">
									<next:DateTimeField allowBlank="false" format="Y-m-d" />
								</next:Column>
								<next:Column id="hbusinessType" header="交易性质"
									field="businessType">
									<next:ComboBox triggerAction="all" valueField="value"
										displayField="text" dataset="businessTypeDataset" />
								</next:Column>
								<next:Column id="hlocation" header="房屋坐落" field="location">
									<next:TextField allowBlank="false" />
								</next:Column>
								<next:Column id="hhouseArea" header="建筑面积(平米)" field="houseArea">
									<next:NumberField allowBlank="false" />
								</next:Column>
							</next:Columns>
						</next:EditGridPanel>

						<next:EditGridPanel id="business_grid" name="business_grid"
							width="99%" height="200" clicksToEdit="2"
							dataset="SamEsureyBusinessDS">
							<next:TopBar>
								<next:ToolBarItem text="本成员工商经营信息列表:"></next:ToolBarItem>
							</next:TopBar>
							<next:Columns>
								<next:RowNumberColumn width="10" />
								<next:RadioBoxColumn></next:RadioBoxColumn>
								<next:Column id="hbId" header="流水ID" field="id" hidden="true">
									<next:TextField allowBlank="false" />
								</next:Column>
								<next:Column id="hbType" header="信息类别" field="type"
									hidden="true">
									<next:TextField allowBlank="false" />
								</next:Column>
								<next:Column id="hbFeedbackId" header="填表Id" field="feedbackId"
									hidden="true">
									<next:TextField allowBlank="false" />
								</next:Column>
								<next:Column id="hbPeopleId" header="人员Id" field="peopleId"
									hidden="true">
									<next:TextField allowBlank="false" />
								</next:Column>
								<next:Column id="hbusinessType" header="企业注册方式"
									field="businessType">
									<next:ComboBox triggerAction="all" valueField="value"
										displayField="text" dataset="compBusinessTypeDataset" />
								</next:Column>
								<next:Column id="hlegalPerson" header="企业法人名称"
									field="legalPerson">
									<next:TextField allowBlank="false" />
								</next:Column>
								<next:Column id="horganName" header="企业名称" field="organName">
									<next:TextField allowBlank="false" />
								</next:Column>
								<next:Column id="hregAdd" header="注册地址" field="regAdd">
									<next:TextField allowBlank="false" />
								</next:Column>
								<next:Column id="hbusinessAdd" header="经营地址" field="businessAdd">
									<next:TextField allowBlank="false" />
								</next:Column>
								<next:Column id="hregFund" header="注册资金" field="regFund">
									<next:NumberField allowBlank="false" />
								</next:Column>
								<next:Column id="hbRegDate" header="注册时间" field="regDate">
									<next:DateTimeField allowBlank="false" format="Y-m-d" />
								</next:Column>
								<next:Column id="hbusinessScope" header="经营范围"
									field="businessScope">
									<next:TextField allowBlank="false" />
								</next:Column>
								<next:Column id="horganStatus" header="企业当前状态"
									field="organStatus">
									<next:ComboBox triggerAction="all" valueField="value"
										displayField="text" dataset="organDataset" />
								</next:Column>
							</next:Columns>
						</next:EditGridPanel>

						<next:EditGridPanel id="car_grid" name="car_grid" width="99%"
							height="200" clicksToEdit="2" dataset="SamEsureyCarDS">
							<next:TopBar>
								<next:ToolBarItem text="本成员车辆信息列表:"></next:ToolBarItem>
							</next:TopBar>
							<next:Columns>
								<next:RowNumberColumn width="10" />
								<next:RadioBoxColumn></next:RadioBoxColumn>
								<next:Column id="hcId" header="流水ID" field="id" hidden="true">
									<next:TextField allowBlank="false" />
								</next:Column>
								<next:Column id="hcType" header="信息类别" field="type"
									hidden="true">
									<next:TextField allowBlank="false" />
								</next:Column>
								<next:Column id="hcFeedbackId" header="填表Id" field="feedbackId"
									hidden="true">
									<next:TextField allowBlank="false" />
								</next:Column>
								<next:Column id="hcPeopleId" header="人员Id" field="peopleId"
									hidden="true">
									<next:TextField allowBlank="false" />
								</next:Column>
								<next:Column id="howner" header="车主姓名" field="owner">
									<next:TextField allowBlank="false" />
								</next:Column>
								<next:Column id="hcarNo" header="车牌号码" field="carNo">
									<next:TextField allowBlank="false" />
								</next:Column>
								<next:Column id="hcarType" header="车辆类型" field="carType">
									<next:ComboBox triggerAction="all" valueField="value"
										displayField="text" dataset="carTypeDS" />
								</next:Column>
								<next:Column id="hregValue" header="登记价值(元)" field="regValue">
									<next:NumberField allowBlank="false" />
								</next:Column>
								<next:Column id="hcRegDate" header="登记时间" field="regDate">
									<next:DateTimeField allowBlank="false" format="Y-m-d" />
								</next:Column>
								<next:Column id="hcarUse" header="用途" field="carUse">
									<next:ComboBox triggerAction="all" valueField="value"
										displayField="text" dataset="carUseDataset" />
								</next:Column>
							</next:Columns>
						</next:EditGridPanel>

						<next:EditGridPanel id="tax_grid" name="tax_grid" width="99%"
							height="200" clicksToEdit="2" dataset="SamEsureyTaxDS">
							<next:TopBar>
								<next:ToolBarItem text="本成员国税信息列表:"></next:ToolBarItem>
							</next:TopBar>
							<next:Columns>
								<next:RowNumberColumn width="10" />
								<next:RadioBoxColumn></next:RadioBoxColumn>
								<next:Column id="htId" header="流水ID" field="id" hidden="true">
									<next:TextField allowBlank="false" />
								</next:Column>
								<next:Column id="htType" header="信息类别" field="type"
									hidden="true">
									<next:TextField allowBlank="false" />
								</next:Column>
								<next:Column id="htFeedbackId" header="填表Id" field="feedbackId"
									hidden="true">
									<next:TextField allowBlank="false" />
								</next:Column>
								<next:Column id="htPeopleId" header="人员Id" field="peopleId"
									hidden="true">
									<next:TextField allowBlank="false" />
								</next:Column>
								<next:Column id="htaxesType" header="纳税类型" field="taxesType"
									hidden="true">
									<next:TextField allowBlank="false" />
								</next:Column>
								<next:Column id="htaxesPeople" header="纳税人姓名"
									field="taxesPeople">
									<next:TextField allowBlank="false" />
								</next:Column>
								<next:Column id="htaxesOrg" header="纳税企业名称" field="taxesOrg">
									<next:TextField allowBlank="false" />
								</next:Column>
								<next:Column id="hturnoverLatestYear" header="最近一年营业额"
									field="turnoverLatestYear">
									<next:NumberField allowBlank="false" />
								</next:Column>
								<next:Column id="htaxesLatestYear" header="最近一年纳税额"
									field="taxesLatestYear">
									<next:NumberField allowBlank="false" />
								</next:Column>
							</next:Columns>
						</next:EditGridPanel>

						<next:EditGridPanel id="fund_grid" name="fund_grid" width="99%"
							height="200" clicksToEdit="2" dataset="SamEsureyHousingFundDS">
							<next:TopBar>
								<next:ToolBarItem text="本成员公积金信息列表:"></next:ToolBarItem>
							</next:TopBar>
							<next:Columns>
								<next:RowNumberColumn width="10" />
								<next:RadioBoxColumn></next:RadioBoxColumn>
								<next:Column id="hfId" header="流水ID" field="id" hidden="true">
									<next:TextField allowBlank="false" />
								</next:Column>
								<next:Column id="hfType" header="信息类别" field="type"
									hidden="true">
									<next:TextField allowBlank="false" />
								</next:Column>
								<next:Column id="hfFeedbackId" header="填表Id" field="feedbackId"
									hidden="true">
									<next:TextField allowBlank="false" />
								</next:Column>
								<next:Column id="hfPeopleId" header="人员Id" field="peopleId"
									hidden="true">
									<next:TextField allowBlank="false" />
								</next:Column>
								<next:Column id="hfName" header="姓名" field="name">
									<next:TextField allowBlank="false" />
								</next:Column>
								<next:Column id="hbalance" header="公积金余额" field="balance">
									<next:NumberField allowBlank="false" />
								</next:Column>
								<next:Column id="hcollectNum" header="历史提取金额合计"
									field="collectNum">
									<next:NumberField allowBlank="false" />
								</next:Column>
							</next:Columns>
						</next:EditGridPanel>

						<next:EditGridPanel id="bank_grid" name="bank_grid" width="99%"
							height="200" clicksToEdit="2" dataset="SamEsureyBankDS">
							<next:TopBar>
								<next:ToolBarItem text="本成员人民银行信息列表:"></next:ToolBarItem>
							</next:TopBar>
							<next:Columns>
								<next:RowNumberColumn width="10" />
								<next:RadioBoxColumn></next:RadioBoxColumn>
								<next:Column id="hkId" header="流水ID" field="id" hidden="true">
									<next:TextField allowBlank="false" />
								</next:Column>
								<next:Column id="hkType" header="信息类别" field="type"
									hidden="true">
									<next:TextField allowBlank="false" />
								</next:Column>
								<next:Column id="hkFeedbackId" header="填表Id" field="feedbackId"
									hidden="true">
									<next:TextField allowBlank="false" />
								</next:Column>
								<next:Column id="hkPeopleId" header="人员Id" field="peopleId"
									hidden="true">
									<next:TextField allowBlank="false" />
								</next:Column>
								<next:Column id="haccountName" header="开户人姓名"
									field="accountName">
									<next:TextField allowBlank="false" />
								</next:Column>
								<next:Column id="htotalSavings" header="存款金额合计"
									field="totalSavings">
									<next:NumberField allowBlank="false" />
								</next:Column>
								<next:Column id="htotalBond" header="债券总金额" field="totalBond">
									<next:NumberField allowBlank="false" />
								</next:Column>
							</next:Columns>
						</next:EditGridPanel>

						<next:EditGridPanel id="securities_grid" name="securities_grid"
							width="99%" height="200" clicksToEdit="2"
							dataset="SamEsureySecuritiesDS">
							<next:TopBar>
								<next:ToolBarItem text="本成员证监列表:"></next:ToolBarItem>
							</next:TopBar>
							<next:Columns>
								<next:RowNumberColumn width="10" />
								<next:RadioBoxColumn></next:RadioBoxColumn>
								<next:Column id="heId" header="流水ID" field="id" hidden="true">
									<next:TextField allowBlank="false" />
								</next:Column>
								<next:Column id="heType" header="信息类别" field="type"
									hidden="true">
									<next:TextField allowBlank="false" />
								</next:Column>
								<next:Column id="heFeedbackId" header="填表Id" field="feedbackId"
									hidden="true">
									<next:TextField allowBlank="false" />
								</next:Column>
								<next:Column id="hePeopleId" header="人员Id" field="peopleId"
									hidden="true">
									<next:TextField allowBlank="false" />
								</next:Column>
								<next:Column id="heName" header="开户人姓名" field="name">
									<next:TextField allowBlank="false" />
								</next:Column>
								<next:Column id="hstock" header="股票市值总金额" field="stock">
									<next:NumberField allowBlank="false" />
								</next:Column>
								<next:Column id="hfund" header="基金市值总金额" field="fund">
									<next:NumberField allowBlank="false" />
								</next:Column>
								<next:Column id="hmoney" header="资金总余额" field="money">
									<next:NumberField allowBlank="false" />
								</next:Column>
							</next:Columns>
						</next:EditGridPanel>

						<next:EditGridPanel id="insurance_grid" name="insurance_grid"
							width="99%" height="200" clicksToEdit="2"
							dataset="SamEsureyInsuranceDS">
							<next:TopBar>
								<next:ToolBarItem text="本成员保险信息列表:"></next:ToolBarItem>
							</next:TopBar>
							<next:Columns>
								<next:RowNumberColumn width="10" />
								<next:RadioBoxColumn></next:RadioBoxColumn>
								<next:Column id="hiId" header="流水ID" field="id" hidden="true">
									<next:TextField allowBlank="false" />
								</next:Column>
								<next:Column id="hiType" header="信息类别" field="type"
									hidden="true">
									<next:TextField allowBlank="false" />
								</next:Column>
								<next:Column id="hiFeedbackId" header="填表Id" field="feedbackId"
									hidden="true">
									<next:TextField allowBlank="false" />
								</next:Column>
								<next:Column id="hiPeopleId" header="人员Id" field="peopleId"
									hidden="true">
									<next:TextField allowBlank="false" />
								</next:Column>
								<next:Column id="hbenefitPeople" header="保险受益人"
									field="benefitPeople">
									<next:TextField allowBlank="false" />
								</next:Column>
								<next:Column id="hbenefitType" header="保险受益种类"
									field="benefitType">
									<next:ComboBox triggerAction="all" valueField="value"
										displayField="text" dataset="beneDS" />
								</next:Column>
								<next:Column id="hbenefitDate" header="受益时间" field="benefitDate">
									<next:DateTimeField allowBlank="false" format="Y-m-d" />
								</next:Column>
								<next:Column id="hbenefitNum" header="保险受益金额(元)"
									field="benefitNum">
									<next:NumberField allowBlank="false" />
								</next:Column>
							</next:Columns>
						</next:EditGridPanel>
					</next:Panel>
				</next:Panel>
				<next:Panel title="外部单位填报本成员经济状况信息" >
					<next:Panel>
						<next:Html>
							<form id="cyjjzkxxFormExt" method="post" onsubmit="return false"
								style="padding: 5px;" class="L5form">
							<table border="0" width="99%" height="100%">
								<tr>
									<td class="FieldLabel">姓名:</td>
									<td class="FieldInput" width="240"><label id="excyName"
										readonly="readonly" /></td>
									<td class="FieldLabel">身份证号:</td>
									<td class="FieldInput"><label id="excyIdCard"
										readonly="readonly" /></td>
									<!-- <td><label id="peopleId" style="display: none"/></td> -->
									<td class="FieldLabel">
									<button onclick="exportWord()">导出</button></td>
								</tr>
							</table>
							</form>
						</next:Html>
					</next:Panel>
					<next:Panel width="100%" height="100%" autoScroll="true">
						<next:EditGridPanel id="social_gridExt" name="social_gridExt"
							width="99%" height="200" clicksToEdit="2"
							dataset="SamEsureySocialExtDS">
							<next:TopBar>
								<next:ToolBarItem text="本成员社保列表:"></next:ToolBarItem>
							</next:TopBar>
							<next:Columns>
								<next:RowNumberColumn width="10" />
								<next:RadioBoxColumn></next:RadioBoxColumn>
								
								<next:Column id="hsYearMonth" header="年月区分标志" field="yearMonth">
									<next:ComboBox triggerAction="all" valueField="value"
										displayField="text" dataset="ymDS" />
								</next:Column>
								<next:Column id="hsSalaryType" header="工资类别" field="salaryType">
									<next:ComboBox triggerAction="all" valueField="value"
										displayField="text" dataset="salaryDS" />
								</next:Column>
								<next:Column id="hsSalary" header="工资、养老金金额" field="salary">
									<next:NumberField allowBlank="false" />
								</next:Column>
								<next:Column id="hsPension" header="养老金缴纳金额" field="pension">
									<next:TextField allowBlank="false" />
								</next:Column>
								<next:Column id="hsPensionBalance" header="养老金余额"
									field="pensionBalance">
									<next:TextField allowBlank="false" />
								</next:Column>
								
								<next:Column id="hsId" header="流水ID" field="id" hidden="true">
									<next:TextField allowBlank="false" />
								</next:Column>
								<next:Column id="hsType" header="信息类别" field="type"
									hidden="true">
									<next:TextField allowBlank="false" />
								</next:Column>
								<next:Column id="hsFeedbackId" header="填表Id" field="feedbackId"
									hidden="true">
									<next:TextField allowBlank="false" />
								</next:Column>
								<next:Column id="hsPeopleId" header="人员Id" field="peopleId"
									hidden="true">
									<next:TextField allowBlank="false" />
								</next:Column>
							</next:Columns>
						</next:EditGridPanel>

						<next:EditGridPanel id="house_gridExt" name="house_gridExt"
							width="99%" height="200" clicksToEdit="2"
							dataset="SamEsureyHouseExtDS">
							<next:TopBar>
								<next:ToolBarItem text="本成员房屋信息列表:"></next:ToolBarItem>
							</next:TopBar>
							<next:Columns>
								<next:RowNumberColumn width="10" />
								<next:RadioBoxColumn></next:RadioBoxColumn>
								
								<next:Column id="hhouseCardNo" header="房产证号" field="houseCardNo">
									<next:TextField allowBlank="false" />
								</next:Column>
								<next:Column id="hhouseUseage" header="房屋用途" field="houseUseage">
									<next:ComboBox triggerAction="all" valueField="value"
										displayField="text" dataset="houseUserageDataset" />
								</next:Column>
								<next:Column id="hhregValue" header="交易价值(元)" field="regValue">
									<next:NumberField allowBlank="false" />
								</next:Column>
								<next:Column id="hregDate" header="登记或交易时间" field="regDate">
									<next:DateTimeField allowBlank="false" format="Y-m-d" />
								</next:Column>
								<next:Column id="hbusinessType" header="交易性质"
									field="businessType">
									<next:ComboBox triggerAction="all" valueField="value"
										displayField="text" dataset="businessTypeDataset" />
								</next:Column>
								<next:Column id="hlocation" header="房屋坐落" field="location">
									<next:TextField allowBlank="false" />
								</next:Column>
								<next:Column id="hhouseArea" header="建筑面积(平米)" field="houseArea">
									<next:NumberField allowBlank="false" />
								</next:Column>
								
								<next:Column id="hhId" header="流水ID" field="id" hidden="true">
									<next:TextField allowBlank="false" />
								</next:Column>
								<next:Column id="hhType" header="信息类别" field="type"
									hidden="true">
									<next:TextField allowBlank="false" />
								</next:Column>
								<next:Column id="hhFeedbackId" header="填表Id" field="feedbackId"
									hidden="true">
									<next:TextField allowBlank="false" />
								</next:Column>
								<next:Column id="hhPeopleId" header="人员Id" field="peopleId"
									hidden="true">
									<next:TextField allowBlank="false" />
								</next:Column>
							</next:Columns>
						</next:EditGridPanel>

						<next:EditGridPanel id="business_gridExt" name="business_gridExt"
							width="99%" height="200" clicksToEdit="2"
							dataset="SamEsureyBusinessExtDS">
							<next:TopBar>
								<next:ToolBarItem text="本成员工商经营信息列表:"></next:ToolBarItem>
							</next:TopBar>
							<next:Columns>
								<next:RowNumberColumn width="10" />
								<next:RadioBoxColumn></next:RadioBoxColumn>
								
								<next:Column id="hbusinessType" header="企业注册方式"
									field="businessType">
									<next:ComboBox triggerAction="all" valueField="value"
										displayField="text" dataset="compBusinessTypeDataset" />
								</next:Column>
								<next:Column id="hlegalPerson" header="企业法人名称"
									field="legalPerson">
									<next:TextField allowBlank="false" />
								</next:Column>
								<next:Column id="horganName" header="企业名称" field="organName">
									<next:TextField allowBlank="false" />
								</next:Column>
								<next:Column id="hregAdd" header="注册地址" field="regAdd">
									<next:TextField allowBlank="false" />
								</next:Column>
								<next:Column id="hbusinessAdd" header="经营地址" field="businessAdd">
									<next:TextField allowBlank="false" />
								</next:Column>
								<next:Column id="hregFund" header="注册资金" field="regFund">
									<next:NumberField allowBlank="false" />
								</next:Column>
								<next:Column id="hbRegDate" header="注册时间" field="regDate">
									<next:DateTimeField allowBlank="false" format="Y-m-d" />
								</next:Column>
								<next:Column id="hbusinessScope" header="经营范围"
									field="businessScope">
									<next:TextField allowBlank="false" />
								</next:Column>
								<next:Column id="horganStatus" header="企业当前状态"
									field="organStatus">
									<next:ComboBox triggerAction="all" valueField="value"
										displayField="text" dataset="organDataset" />
								</next:Column>
								
								<next:Column id="hbId" header="流水ID" field="id" hidden="true">
									<next:TextField allowBlank="false" />
								</next:Column>
								<next:Column id="hbType" header="信息类别" field="type"
									hidden="true">
									<next:TextField allowBlank="false" />
								</next:Column>
								<next:Column id="hbFeedbackId" header="填表Id" field="feedbackId"
									hidden="true">
									<next:TextField allowBlank="false" />
								</next:Column>
								<next:Column id="hbPeopleId" header="人员Id" field="peopleId"
									hidden="true">
									<next:TextField allowBlank="false" />
								</next:Column>
							</next:Columns>
						</next:EditGridPanel>

						<next:EditGridPanel id="car_gridExt" name="car_gridExt"
							width="99%" height="200" clicksToEdit="2"
							dataset="SamEsureyCarExtDS">
							<next:TopBar>
								<next:ToolBarItem text="本成员车辆信息列表:"></next:ToolBarItem>
							</next:TopBar>
							<next:Columns>
								<next:RowNumberColumn width="10" />
								<next:RadioBoxColumn></next:RadioBoxColumn>
							
								<next:Column id="howner" header="车主姓名" field="owner">
									<next:TextField allowBlank="false" />
								</next:Column>
								<next:Column id="hcarNo" header="车牌号码" field="carNo">
									<next:TextField allowBlank="false" />
								</next:Column>
								<next:Column id="hcarType" header="车辆类型" field="carType">
									<next:ComboBox triggerAction="all" valueField="value"
										displayField="text" dataset="carTypeDS" />
								</next:Column>
								<next:Column id="hregValue" header="登记价值(元)" field="regValue">
									<next:NumberField allowBlank="false" />
								</next:Column>
								<next:Column id="hcRegDate" header="登记时间" field="regDate">
									<next:DateTimeField allowBlank="false" format="Y-m-d" />
								</next:Column>
								<next:Column id="hcarUse" header="用途" field="carUse">
									<next:ComboBox triggerAction="all" valueField="value"
										displayField="text" dataset="carUseDataset" />
								</next:Column>
								
								<next:Column id="hcId" header="流水ID" field="id" hidden="true">
									<next:TextField allowBlank="false" />
								</next:Column>
								<next:Column id="hcType" header="信息类别" field="type"
									hidden="true">
									<next:TextField allowBlank="false" />
								</next:Column>
								<next:Column id="hcFeedbackId" header="填表Id" field="feedbackId"
									hidden="true">
									<next:TextField allowBlank="false" />
								</next:Column>
								<next:Column id="hcPeopleId" header="人员Id" field="peopleId"
									hidden="true">
									<next:TextField allowBlank="false" />
								</next:Column>
							</next:Columns>
						</next:EditGridPanel>

						<next:EditGridPanel id="tax_gridExt" name="tax_gridExt"
							width="99%" height="200" clicksToEdit="2"
							dataset="SamEsureyTaxExtDS">
							<next:TopBar>
								<next:ToolBarItem text="本成员国税/地税信息列表:"></next:ToolBarItem>
							</next:TopBar>
							<next:Columns>
								<next:RowNumberColumn width="10" />
								<next:RadioBoxColumn></next:RadioBoxColumn>
								
								<next:Column id="haxesPeoplex" header="纳税人姓名"
									field="taxesPeople">
									<next:TextField allowBlank="false" />
								</next:Column>
								<next:Column id="haxesOrgx" header="纳税企业名称" field="taxesOrg">
									<next:TextField allowBlank="false" />
								</next:Column>
								<next:Column id="hurnoverLatestYearx" header="最近一年营业额"
									field="turnoverLatestYear">
									<next:NumberField allowBlank="false" />
								</next:Column>
								<next:Column id="haxesLatestYearx" header="最近一年纳税额"
									field="taxesLatestYear">
									<next:NumberField allowBlank="false" />
								</next:Column>
								
								<next:Column id="hIdx" header="流水ID" field="id" hidden="true">
									<next:TextField allowBlank="false" />
								</next:Column>
								<next:Column id="hTypex" header="信息类别" field="type"
									hidden="true">
									<next:TextField allowBlank="false" />
								</next:Column>
								<next:Column id="hFeedbackIdx" header="填表Id" field="feedbackId"
									hidden="true">
									<next:TextField allowBlank="false" />
								</next:Column>
								<next:Column id="hPeopleIdx" header="人员Id" field="peopleId"
									hidden="true">
									<next:TextField allowBlank="false" />
								</next:Column>
								<next:Column id="haxesTypex" header="纳税类型" field="taxesType"
									hidden="true">
									<next:TextField allowBlank="false" />
								</next:Column>
							</next:Columns>
						</next:EditGridPanel>

						<next:EditGridPanel id="fund_gridExt" name="fund_gridExt"
							width="99%" height="200" clicksToEdit="2"
							dataset="SamEsureyHousingFundExtDS">
							<next:TopBar>
								<next:ToolBarItem text="本成员公积金信息列表:"></next:ToolBarItem>
							</next:TopBar>
							<next:Columns>
								<next:RowNumberColumn width="10" />
								<next:RadioBoxColumn></next:RadioBoxColumn>
							
								<next:Column id="hfName" header="姓名" field="name">
									<next:TextField allowBlank="false" />
								</next:Column>
								<next:Column id="hbalance" header="公积金余额" field="balance">
									<next:NumberField allowBlank="false" />
								</next:Column>
								<next:Column id="hcollectNum" header="历史提取金额合计"
									field="collectNum">
									<next:NumberField allowBlank="false" />
								</next:Column>
								
									<next:Column id="hfId" header="流水ID" field="id" hidden="true">
									<next:TextField allowBlank="false" />
								</next:Column>
								<next:Column id="hfType" header="信息类别" field="type"
									hidden="true">
									<next:TextField allowBlank="false" />
								</next:Column>
								<next:Column id="hfFeedbackId" header="填表Id" field="feedbackId"
									hidden="true">
									<next:TextField allowBlank="false" />
								</next:Column>
								<next:Column id="hfPeopleId" header="人员Id" field="peopleId"
									hidden="true">
									<next:TextField allowBlank="false" />
								</next:Column>
							</next:Columns>
						</next:EditGridPanel>

						<next:EditGridPanel id="bank_gridExt" name="bank_gridExt"
							width="99%" height="200" clicksToEdit="2"
							dataset="SamEsureyBankExtDS">
							<next:TopBar>
								<next:ToolBarItem text="本成员人民银行信息列表:"></next:ToolBarItem>
							</next:TopBar>
							<next:Columns>
								<next:RowNumberColumn width="10" />
								<next:RadioBoxColumn></next:RadioBoxColumn>
								
								<next:Column id="haccountName" header="开户人姓名"
									field="accountName">
									<next:TextField allowBlank="false" />
								</next:Column>
								<next:Column id="htotalSavings" header="存款金额合计"
									field="totalSavings">
									<next:NumberField allowBlank="false" />
								</next:Column>
								<next:Column id="htotalBond" header="债券总金额" field="totalBond">
									<next:NumberField allowBlank="false" />
								</next:Column>
								
								<next:Column id="hkId" header="流水ID" field="id" hidden="true">
									<next:TextField allowBlank="false" />
								</next:Column>
								<next:Column id="hkType" header="信息类别" field="type"
									hidden="true">
									<next:TextField allowBlank="false" />
								</next:Column>
								<next:Column id="hkFeedbackId" header="填表Id" field="feedbackId"
									hidden="true">
									<next:TextField allowBlank="false" />
								</next:Column>
								<next:Column id="hkPeopleId" header="人员Id" field="peopleId"
									hidden="true">
									<next:TextField allowBlank="false" />
								</next:Column>
							</next:Columns>
						</next:EditGridPanel>

						<next:EditGridPanel id="securities_gridExt"
							name="securities_gridExt" width="99%" height="200"
							clicksToEdit="2" dataset="SamEsureySecuritiesExtDS">
							<next:TopBar>
								<next:ToolBarItem text="本成员证监列表:"></next:ToolBarItem>
							</next:TopBar>
							<next:Columns>
								<next:RowNumberColumn width="10" />
								<next:RadioBoxColumn></next:RadioBoxColumn>
							
								<next:Column id="heName" header="开户人姓名" field="name">
									<next:TextField allowBlank="false" />
								</next:Column>
								<next:Column id="hstock" header="股票市值总金额" field="stock">
									<next:NumberField allowBlank="false" />
								</next:Column>
								<next:Column id="hfund" header="基金市值总金额" field="fund">
									<next:NumberField allowBlank="false" />
								</next:Column>
								<next:Column id="hmoney" header="资金总余额" field="money">
									<next:NumberField allowBlank="false" />
								</next:Column>
								
								<next:Column id="heId" header="流水ID" field="id" hidden="true">
									<next:TextField allowBlank="false" />
								</next:Column>
								<next:Column id="heType" header="信息类别" field="type"
									hidden="true">
									<next:TextField allowBlank="false" />
								</next:Column>
								<next:Column id="heFeedbackId" header="填表Id" field="feedbackId"
									hidden="true">
									<next:TextField allowBlank="false" />
								</next:Column>
								<next:Column id="hePeopleId" header="人员Id" field="peopleId"
									hidden="true">
									<next:TextField allowBlank="false" />
								</next:Column>
							</next:Columns>
						</next:EditGridPanel>

						<next:EditGridPanel id="insurance_gridExt"
							name="insurance_gridExt" width="99%" height="200"
							clicksToEdit="2" dataset="SamEsureyInsuranceExtDS">
							<next:TopBar>
								<next:ToolBarItem text="本成员保险信息列表:"></next:ToolBarItem>
							</next:TopBar>
							<next:Columns>
								<next:RowNumberColumn width="10" />
								<next:RadioBoxColumn></next:RadioBoxColumn>
								
								<next:Column id="hbenefitPeople" header="保险受益人"
									field="benefitPeople">
									<next:TextField allowBlank="false" />
								</next:Column>
								<next:Column id="hbenefitType" header="保险受益种类"
									field="benefitType">
									<next:ComboBox triggerAction="all" valueField="value"
										displayField="text" dataset="beneDS" />
								</next:Column>
								<next:Column id="hbenefitDate" header="受益时间" field="benefitDate">
									<next:DateTimeField allowBlank="false" format="Y-m-d" />
								</next:Column>
								<next:Column id="hbenefitNum" header="保险受益金额(元)"
									field="benefitNum">
									<next:NumberField allowBlank="false" />
								</next:Column>
								
								<next:Column id="hiId" header="流水ID" field="id" hidden="true">
									<next:TextField allowBlank="false" />
								</next:Column>
								<next:Column id="hiType" header="信息类别" field="type"
									hidden="true">
									<next:TextField allowBlank="false" />
								</next:Column>
								<next:Column id="hiFeedbackId" header="填表Id" field="feedbackId"
									hidden="true">
									<next:TextField allowBlank="false" />
								</next:Column>
								<next:Column id="hiPeopleId" header="人员Id" field="peopleId"
									hidden="true">
									<next:TextField allowBlank="false" />
								</next:Column>
							</next:Columns>
						</next:EditGridPanel>
					</next:Panel>
				</next:Panel>
				
			</next:Tabs>
		</next:TabPanel>
	</next:FitLayout>
	<next:Buttons>
		<next:ToolButton text="关闭" handler="hide_win"></next:ToolButton>
	</next:Buttons>
</next:Window>
<next:Window id="supFamilyEdit" title="赡（抚、扶）养义务人员家庭信息"
	titleCollapse="false" resizable="false" width="500" height="400"
	closeAction="hide" autoScroll="true">
	<next:Panel id="supFamilyPanel" autoWidth="true" height="true"
		autoScroll="true">
		<next:Html>
			<form id="supFamilyForm" method="post" onsubmit="return false"
				style="padding: 5px;" dataset="esureyFamilyDS2" class="L5form">
			<table border="0" width="99%">
				<tr>
					<td class="FieldLabel" colspan="2">户主姓名:</td>
					<td class="FieldInput"><label id="supfamilyName" name="户主姓名:"
						field="familyName"></label></td>
					<td class="FieldLabel" colspan="2">身份证号:</td>
					<td class="FieldInput"><label id="supfamilyCardNo"
						name="身份证号:" field="familyCardNo"></label></td>
				</tr>
				<tr>
					<td class="FieldLabel" colspan="2">家庭人口数量:</td>
					<td class="FieldInput"><label id="suppeopleNum" name="家庭人口数量"
						field="peopleNum"></label></td>
					<td class="FieldLabel" colspan="2">家庭性质:</td>
					<td class="FieldInput"><label id="supdomicileType"
						name="家庭性质:" field="domicileType" dataset="familyTypeDS" /></td>
				</tr>
				<tr>
					<td class="FieldLabel" colspan="2">救助类型:</td>
					<td class="FieldInput"><label name="救助类型"
						field="assistanceType" dataset="assistanceTypeDS" /></td>
					<td class="FieldLabel" colspan="2">邮政编码:</td>
					<td class="FieldInput"><label id="supfamilyPostcode"
						name="邮政编码: " field="familyPostcode"></label></td>
				</tr>
				<tr>
					<td class="FieldLabel" colspan="2">户籍行政区划:</td>
					<td class="FieldInput"><label id="supregAddress"
						field="regAddress"></label></td>
					<td class="FieldLabel" colspan="2">属地行政区划:</td>
					<td class="FieldInput"><label id="supfamilyAddress"
						field="familyAddress"></label></td>
				</tr>
				<tr>
					<td class="FieldLabel" colspan="2">家庭住址:</td>
					<td class="FieldInput" colspan="4"><label id="supaddress"
						name="家庭住址:" field="address" style="width: 99%"></label></td>
				</tr>
				<tr>
					<td class="FieldLabel" rowspan="3">联系电话</td>
					<td class="FieldLabel">宅电:</td>
					<td class="FieldInput"><label id="supfamilyPhone" name="宅电:"
						field="familyPhone"></label></td>
					<td class="FieldLabel" rowspan="3">家庭住房</td>
					<td class="FieldLabel">住房情况:</td>
					<td class="FieldInput"><label name="住房情况:" field="houseStatus"
						dataset="houseTypeDS" /></td>
				</tr>
				<tr>
					<td class="FieldLabel">手机:</td>
					<td class="FieldInput"><label id="supfamilyMobile" name="手机:"
						field="familyMobile"></label></td>
					<td class="FieldLabel">房屋性质:</td>
					<td class="FieldInput"><label name="房屋性质:"
						field="buildingStructure" dataset="buildingTypeDS" /></td>
				</tr>
				<tr>
					<td class="FieldLabel">其他:</td>
					<td class="FieldInput"><label name="其他:"
						id="supfamilyOtherPhone" field="familyOtherPhone"></label></td>
					<td class="FieldLabel" style="width: 110px;">房屋面积(平方):</td>
					<td class="FieldInput"><label id="supbuildArea"
						name="房屋面积(平方):" field="buildArea"></label></td>
				</tr>
				<tr>
					<td class="FieldLabel" rowspan="2">收入情况</td>
					<td class="FieldLabel">家庭年:</td>
					<td class="FieldInput"><label id="supyearIncome" name="家庭年:"
						field="yearIncome" disabled="disabled"></label></td>
					<td class="FieldLabel" rowspan="2">收入情况</td>
					<td class="FieldLabel">家庭月:</td>
					<td class="FieldInput"><label name="家庭月:" field="monthIncome"
						disabled="disabled"></label></td>
				</tr>
				<tr>
					<td class="FieldLabel">家庭年人均:</td>
					<td class="FieldInput"><label name="家庭年人均:"
						id="supyearAverageIncome" field="yearAverageIncome"
						disabled="disabled"></label></td>
					<td class="FieldLabel" style="width: 110px;">家庭月人均:</td>
					<td class="FieldInput"><label id="supmonthAverageIncome"
						name="家庭月人均:" field="monthAverageIncome" disabled="disabled"></label>
					</td>
				</tr>
			</table>
			</form>
		</next:Html>
	</next:Panel>
	<next:GridPanel id="supPeoplePanel" name="supPeoplePanel" width="100%"
		stripeRows="true" height="50%" dataset="esureyPeopleDS4" >
		<next:TopBar>
			<next:ToolBarItem text="家庭成员列表:"></next:ToolBarItem>
			<next:ToolBarItem symbol="->"></next:ToolBarItem>
			<next:ToolBarItem iconCls="detail" text="查看明细"
				handler="detail_people2()" />
			<next:ToolBarItem symbol=""></next:ToolBarItem>
			<next:ToolBarItem symbol="-"></next:ToolBarItem>
			<next:ToolBarItem symbol=""></next:ToolBarItem>
		</next:TopBar>
		<next:Columns>
			<next:RowNumberColumn width="20" />
			<next:RadioBoxColumn></next:RadioBoxColumn>
			<next:Column id="suppeopleId" header="人员Id" field="peopleId"
				hidden="true" width="30">
			</next:Column>
			<next:Column id="supfamilyId" header="家庭Id" field="familyId"
				hidden="true" width="30">
			</next:Column>
			<next:Column id="supname" header="成员姓名" field="name" width="20%"
				renderer="peopleDetailHref">
			</next:Column>
			<next:Column id="suprelationshipType" header="户主关系"
				field="relationshipType" dataset="RelationDS" width="15%">
			</next:Column>
			<next:Column id="supidCard" header="身份证号" field="idCard" width="20%">
			</next:Column>
			<next:Column id="supsex" header="性别" field="sex" dataset="sexDS"
				width="10%">
			</next:Column>
			<next:Column id="supnation" header="民族" field="nation"
				dataset="DmMzDataSet" width="10%">
			</next:Column>
		</next:Columns>
		<next:BottomBar>
			<next:PagingToolBar dataset="esureyPeopleDS4" />
		</next:BottomBar>
	</next:GridPanel>
	<next:Buttons>
		<next:ToolButton text="关闭" handler="suphide_win"></next:ToolButton>
	</next:Buttons>
</next:Window>

	<form method="post" onsubmit="return false" style="padding: 5px;" class="L5form" id="externalUnit">
							<table border="0" width="99%" height="100%" dataset="esureyPeopleDS2" title="基本信息：">
								<tr><td colspan="4"><div align="center"><b>城乡居民经济状况信息</b></div></td></tr>
								<tr>
									<td class="FieldLabel">姓名:</td>
									<td class="FieldInput"><label id="hName" field="name"/></td>
									<td class="FieldLabel">身份证号:</td>
									<td class="FieldInput"><label id="hIdCard" field="idCard"/></td>
								</tr>
							</table>
							<table border="0" width="99%" height="100%" dataset="SamEsureySocialExtDS" title="本成员社保列表:">
								<tr>
									<td colspan="5"><div align="left">本成员社保列表:</div></td>
								</tr>
								<tr>
									<td class="tdTitle" width="3%" align="center" style="border-bottom:none">年月区分标志</td>
									<td class="tdTitle" width="3%" align="center" style="border-bottom:none">工资类别</td>
									<td class="tdTitle" width="3%" align="center" style="border-bottom:none">工资、养老金金额</td>
									<td class="tdTitle" width="3%" align="center" style="border-bottom:none">养老金缴纳金额</td>
									<td class="tdTitle" width="3%" align="center" style="border-bottom:none">养老金余额</td>
								</tr>
								<tr  repeat="true">
									 <td class="tdTitle"><label field="yearMonth" id="hsYearMonth" dataset="ymDS"/></label></td>
									 <td class="tdTitle"><label field="salaryType" id="hsSalaryType" dataset="salaryDS"/></label></td>
									 <td class="tdTitle"><label field="salary" id="hsSalary"/></label></td>
									 <td class="tdTitle"><label field="pension" id="hsPension"/></label></td>
									 <td class="tdTitle"><label field="pensionBalance" id="hsPensionBalance"/></label></td>
								</tr>
							</table>
							<table border="0" width="99%" height="100%" dataset="SamEsureyHouseExtDS" title="本成员房屋信息列表:">
								<tr>
									<td colspan="7"><div align="left">本成员房屋信息列表:</div></td>
								</tr>
								<tr>
									<td class="tdTitle" width="3%" align="center" style="border-bottom:none">房产证号</td>
									<td class="tdTitle" width="3%" align="center" style="border-bottom:none">房屋用途</td>
									<td class="tdTitle" width="3%" align="center" style="border-bottom:none">交易价值(元)</td>
									<td class="tdTitle" width="3%" align="center" style="border-bottom:none">登记或交易时间</td>
									<td class="tdTitle" width="3%" align="center" style="border-bottom:none">交易性质</td>
									<td class="tdTitle" width="3%" align="center" style="border-bottom:none">房屋坐落</td>
									<td class="tdTitle" width="3%" align="center" style="border-bottom:none">建筑面积(平米)</td>
								</tr>
								<tr  repeat="true">
									 <td class="tdTitle"><label field="houseCardNo" id="hhouseCardNo"/></label></td>
									 <td class="tdTitle"><label field="houseUseage" id="hhouseUseage" dataset="houseUserageDataset"/></label></td>
									 <td class="tdTitle"><label field="regValue" id="hregValue"/></label></td>
									 <td class="tdTitle"><label field="regDate" id="hregDate"/></label></td>
									 <td class="tdTitle"><label field="businessType" id="hbusinessType" dataset="businessTypeDataset"/></label></td>
									 <td class="tdTitle"><label field="location" id="hlocation"/></label></td>
									 <td class="tdTitle"><label field="houseArea" id="hhouseArea"/></label></td>
								</tr>
							</table>
							<table border="0" width="99%" height="100%" dataset="SamEsureyBusinessExtDS" title="本成员工商经营信息列表:">
								<tr>
									<td colspan="9"><div align="left">本成员工商经营信息列表:</div></td>
								</tr>
								<tr>
									<td class="tdTitle" width="3%" align="center" style="border-bottom:none">企业注册方式</td>
									<td class="tdTitle" width="3%" align="center" style="border-bottom:none">企业法人名称</td>
									<td class="tdTitle" width="3%" align="center" style="border-bottom:none">企业名称</td>
									<td class="tdTitle" width="3%" align="center" style="border-bottom:none">注册地址</td>
									<td class="tdTitle" width="3%" align="center" style="border-bottom:none">经营地址</td>
									<td class="tdTitle" width="3%" align="center" style="border-bottom:none">注册资金</td>
									<td class="tdTitle" width="3%" align="center" style="border-bottom:none">注册时间</td>
									<td class="tdTitle" width="3%" align="center" style="border-bottom:none">经营范围</td>
									<td class="tdTitle" width="3%" align="center" style="border-bottom:none">企业当前状态</td>
								</tr>
								<tr  repeat="true">
									 <td class="tdTitle"><label field="businessType" id="hbusinessType" dataset="compBusinessTypeDataset"/></label></td>
									 <td class="tdTitle"><label field="legalPerson" id="hlegalPerson"/></label></td>
									 <td class="tdTitle"><label field="organName" id="horganName"/></label></td>
									 <td class="tdTitle"><label field="regAdd" id="hregAdd"/></label></td>
									 <td class="tdTitle"><label field="businessAdd" id="hbusinessAdd"/></label></td>
									 <td class="tdTitle"><label field="regFund" id="hregFund"/></label></td>
									 <td class="tdTitle"><label field="regDate" id="hbRegDate"/></label></td>
									 <td class="tdTitle"><label field="businessScope" id="hbusinessScope"/></label></td>
									 <td class="tdTitle"><label field="organStatus" id="horganStatus" dataset="organDataset"/></label></td>
								</tr>
							</table>
							<table border="0" width="99%" height="100%" dataset="SamEsureyCarExtDS" title="本成员车辆信息列表:">
								<tr>
									<td colspan="6"><div align="left">本成员车辆信息列表:</div></td>
								</tr>
								<tr>
									<td class="tdTitle" width="3%" align="center" style="border-bottom:none">车主姓名</td>
									<td class="tdTitle" width="3%" align="center" style="border-bottom:none">车牌号码</td>
									<td class="tdTitle" width="3%" align="center" style="border-bottom:none">车辆类型</td>
									<td class="tdTitle" width="3%" align="center" style="border-bottom:none">登记价值(元)</td>
									<td class="tdTitle" width="3%" align="center" style="border-bottom:none">登记时间</td>
									<td class="tdTitle" width="3%" align="center" style="border-bottom:none">用途</td>
								</tr>
								<tr  repeat="true">
									 <td class="tdTitle"><label field="owner" id="howner"/></label></td>
									 <td class="tdTitle"><label field="carNo" id="hcarNo"/></label></td>
									 <td class="tdTitle"><label field="carType" id="hcarType" dataset="carTypeDS"/></label></td>
									 <td class="tdTitle"><label field="regValue" id="hregValue"/></label></td>
									 <td class="tdTitle"><label field="regDate" id="hcRegDate"/></label></td>
									 <td class="tdTitle"><label field="carUse" id="hcarUse" dataset="carUseDataset"/></label></td>
								</tr>
							</table>
							<table border="0" width="99%" height="100%" dataset="SamEsureyTaxExtDS" title="本成员国税/地税信息列表:">
								<tr>
									<td colspan="4"><div align="left">本成员国税/地税信息列表:</div></td>
								</tr>
								<tr>
									<td class="tdTitle" width="3%" align="center" style="border-bottom:none">纳税人姓名</td>
									<td class="tdTitle" width="3%" align="center" style="border-bottom:none">纳税企业名称</td>
									<td class="tdTitle" width="3%" align="center" style="border-bottom:none">最近一年营业额</td>
									<td class="tdTitle" width="3%" align="center" style="border-bottom:none">最近一年纳税额</td>
								</tr>
								<tr  repeat="true">
									 <td class="tdTitle"><label field="taxesPeople" id="haxesPeoplex"/></label></td>
									 <td class="tdTitle"><label field="taxesOrg" id="haxesOrgx"/></label></td>
									 <td class="tdTitle"><label field="turnoverLatestYear" id="hurnoverLatestYearx"/></label></td>
									 <td class="tdTitle"><label field="taxesLatestYear" id="haxesLatestYearx"/></label></td>
								</tr>
							</table>
							<table border="0" width="99%" height="100%" dataset="SamEsureyHousingFundExtDS" title="本成员公积金信息列表:">
								<tr>
									<td colspan="3"><div align="left">本成员公积金信息列表:</div></td>
								</tr>
								<tr>
									<td class="tdTitle" width="3%" align="center" style="border-bottom:none">姓名</td>
									<td class="tdTitle" width="3%" align="center" style="border-bottom:none">公积金余额</td>
									<td class="tdTitle" width="3%" align="center" style="border-bottom:none">历史提取金额合计</td>
								</tr>
								<tr  repeat="true">
									 <td class="tdTitle"><label field="name" id="hfName"/></label></td>
									 <td class="tdTitle"><label field="balance" id="hbalance"/></label></td>
									 <td class="tdTitle"><label field="collectNum" id="hcollectNum"/></label></td>
								</tr>
							</table>
							<table border="0" width="99%" height="100%" dataset="SamEsureyBankExtDS" title="本成员人民银行信息列表:">
								<tr>
									<td colspan="3"><div align="left">本成员人民银行信息列表:</div></td>
								</tr>
								<tr>
									<td class="tdTitle" width="3%" align="center" style="border-bottom:none">开户人姓名</td>
									<td class="tdTitle" width="3%" align="center" style="border-bottom:none">存款金额合计</td>
									<td class="tdTitle" width="3%" align="center" style="border-bottom:none">债券总金额</td>
								</tr>
								<tr  repeat="true">
									 <td class="tdTitle"><label field="accountName" id="haccountName"/></label></td>
									 <td class="tdTitle"><label field="totalSavings" id="htotalSavings"/></label></td>
									 <td class="tdTitle"><label field="totalBond" id="htotalBond"/></label></td>
								</tr>
							</table>
							<table border="0" width="99%" height="100%" dataset="SamEsureySecuritiesExtDS" title="本成员证监列表:">
								<tr>
									<td colspan="4"><div align="left">本成员证监列表:</div></td>
								</tr>
								<tr>
									<td class="tdTitle" width="3%" align="center" style="border-bottom:none">开户人姓名</td>
									<td class="tdTitle" width="3%" align="center" style="border-bottom:none">股票市值总金额</td>
									<td class="tdTitle" width="3%" align="center" style="border-bottom:none">基金市值总金额</td>
									<td class="tdTitle" width="3%" align="center" style="border-bottom:none">资金总余额</td>
								</tr>
								<tr  repeat="true">
									 <td class="tdTitle"><label field="name" id="heName"/></label></td>
									 <td class="tdTitle"><label field="stock" id="hstock"/></label></td>
									 <td class="tdTitle"><label field="fund" id="hfund"/></label></td>
									 <td class="tdTitle"><label field="money" id="hmoney"/></label></td>
								</tr>
							</table>
							<table border="0" width="99%" height="100%" dataset="SamEsureyInsuranceExtDS" title="本成员保险信息列表:">
								<tr>
									<td colspan="4"><div align="left">本成员保险信息列表:</div></td>
								</tr>
								<tr>
									<td class="tdTitle" width="3%" align="center" style="border-bottom:none">保险受益人</td>
									<td class="tdTitle" width="3%" align="center" style="border-bottom:none">保险受益种类</td>
									<td class="tdTitle" width="3%" align="center" style="border-bottom:none">受益时间</td>
									<td class="tdTitle" width="3%" align="center" style="border-bottom:none">保险受益金额(元)</td>
								</tr>
								<tr  repeat="true">
									 <td class="tdTitle"><label field="benefitPeople" id="hbenefitPeople"/></label></td>
									 <td class="tdTitle"><label field="benefitType" id="hbenefitType" dataset="beneDS"/></label></td>
									 <td class="tdTitle"><label field="benefitDate" id="hbenefitDate"/></label></td>
									 <td class="tdTitle"><label field="benefitNum" id="hbenefitNum"/></label></td>
								</tr>
								<tr>
									<td colspan="4"><div align="right">单位：<label id="exportOrg"/></div></td>
								</tr>
								<tr>
									<td colspan="4"><div align="right">时间：<label id="nowTime"/></div></td>
								</tr>
							</table>
							</form>	
</body>
</html>
							
