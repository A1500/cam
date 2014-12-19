<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="org.loushang.bsp.id.util.MaxValueUtil"%>
<%@page import="com.inspur.cams.comm.util.BspUtil" %>
<%
	String familyId = MaxValueUtil.nextStringValue("JTID");
	String peopleId = MaxValueUtil.nextStringValue("CYID");
%>
<html>
<head>
<title>申报家庭赡（抚、扶）养信息录入</title>
<next:ScriptManager></next:ScriptManager>
<script>
	var struId='<%=BspUtil.getStruId()%>';
	var organArea='<%=BspUtil.getCorpOrgan().getOrganCode()%>';
	var organName='<%=BspUtil.getCorpOrgan().getOrganName()%>';
	var idFeld='<%=request.getParameter("BeanId")%>';
	var supFamilyId='<%=request.getParameter("supFamilyId") %>';
	var method='<%=request.getParameter("method")%>';
</script>
<script type="text/javascript" src="esureyInfoSFInsert.js"></script>
<script type="text/javascript" src="esureyInfoEconomics.js"></script>
<script type="text/javascript" src="esureyInfoComm.js"></script>
<script type="text/javascript" src="esureyInfoBackfill.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
</head>

<body>
<model:datasets>
<!--申报家庭基本信息-->
	<model:dataset id="esureyFamilyDS" cmd="com.inspur.cams.drel.esurey.cmd.SamEsureyFamilyQueryCmd">
		<model:record fromBean="com.inspur.cams.drel.esurey.data.SamEsureyFamily">
			<model:field name="domicileName" type="string" />
      		<model:field name="apanageName" type="string" />
			<model:field name="familyName" type="string" rule="require"/>
      		<model:field name="familyCardNo" type="string" rule="require"/>
      		<model:field name="domicileType" type="string" rule="require"/>
      		<model:field name="regAddress" type="string" rule="require"/>
      		<model:field name="familyAddress" type="string" rule="require"/>
		</model:record>
	</model:dataset>
<!--申报家庭基本信息-->
	<model:dataset id="esureyFamilyDS3" cmd="com.inspur.cams.drel.esurey.cmd.SamEsureyFamilyQueryCmd">
		<model:record fromBean="com.inspur.cams.drel.esurey.data.SamEsureyFamily">
		</model:record>
	</model:dataset>
<!-- 家庭信息 -->
	<model:dataset id="baseFamilyDS" cmd="com.inspur.sdmz.jtxx.cmd.YgjzJtxxQueryCommand" >
		<model:record fromBean="com.inspur.sdmz.jtxx.data.BaseinfoFamily"></model:record>
	</model:dataset>
	<!-- 家庭成员信息 -->
	<model:dataset id="baseinfoPeopleDS" cmd="com.inspur.sdmz.jtxx.cmd.YgjzJtxxCyxxCommand">
		<model:record fromBean="com.inspur.sdmz.jtxx.data.BaseinfoPeople"></model:record>
	</model:dataset>
<!--申报家庭成员基本信息-->
	<model:dataset id="esureyPeopleDS" cmd="com.inspur.cams.drel.esurey.cmd.SamEsureyPeopleQueryCmd">
		<model:record fromBean="com.inspur.cams.drel.esurey.data.SamEsureyPeople">	
		</model:record>
	</model:dataset>	
<!--申报家庭成员基本信息-->
	<model:dataset id="esureyPeopleDS2" cmd="com.inspur.cams.drel.esurey.cmd.SamEsureyPeopleQueryCmd">
		<model:record fromBean="com.inspur.cams.drel.esurey.data.SamEsureyPeople">
			<model:field name="name" type="string" rule="require"/>
			<model:field name="relationshipType" type="string" rule="require"/>
			<model:field name="idCard" type="string" rule="require"/>
			<model:field name="sex" type="string" rule="require"/>
			<model:field name="nation" type="string" rule="require"/>
			<model:field name="domicileType" type="string" rule="require"/>
			<model:field name="isSupport" type="string" rule="require"/>
		</model:record>
	</model:dataset>
<!--申报家庭成员基本信息-->
	<model:dataset id="esureyPeopleDS3" cmd="com.inspur.cams.drel.esurey.cmd.SamEsureyPeopleQueryCmd">
		<model:record fromBean="com.inspur.cams.drel.esurey.data.SamEsureyPeople">
			<model:field name="sex" type="string" rule="require"/>
			<model:field name="nation" type="string" rule="require"/>
		</model:record>
	</model:dataset>
<!--申报家庭成员基本信息-->
	<model:dataset id="esureyPeopleDS4" cmd="com.inspur.cams.drel.esurey.cmd.SamEsureyPeopleQueryCmd">
		<model:record fromBean="com.inspur.cams.drel.esurey.data.SamEsureyPeople">
		</model:record>
	</model:dataset>		
<!--申报信息_抚养关系-->
	<model:dataset id="esureyRelationDS" cmd="com.inspur.cams.drel.esurey.cmd.SamEsureyRelationQueryCmd">
		<model:record fromBean="com.inspur.cams.drel.esurey.data.SamEsureyRelation"></model:record>
	</model:dataset>
<!--是否为赡养义务人员-->	
	<model:dataset id="isSupportDS" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>	
<!--申报家庭成员社保基本信息-->
	<model:dataset id="SamEsureySocialDS" cmd="com.inspur.cams.drel.esurey.cmd.SamEsureySocialQueryCmd">
		<model:record fromBean="com.inspur.cams.drel.esurey.data.SamEsureySocial">
			<model:field  name="yearMonth" type="string" rule="require"/>
			<model:field  name="salaryType" type="string" rule="require"/>
			<model:field  name="salary" type="string" rule="require|regex{^[0-9]{1,12}(\.[0-9]{1,2}){0,1}$}|length{14}"/>
			<model:field  name="pension" type="string" rule="require|regex{^[0-9]{1,12}(\.[0-9]{1,2}){0,1}$}|length{14}"/>
			<model:field  name="pensionBalance" type="string" rule="require|regex{^[0-9]{1,12}(\.[0-9]{1,2}){0,1}$}|length{14}"/>
		</model:record>
	</model:dataset>
<!--申报家庭成员财产收入基本信息-->
	<model:dataset id="SamEsureyPeopleEstateDS" cmd="com.inspur.cams.drel.esurey.cmd.SamEsureyPeopleEstateQueryCmd">
		<model:record fromBean="com.inspur.cams.drel.esurey.data.SamEsureyPeopleEstate">
			<model:field  name="period" type="string" rule="require"/>
			<model:field  name="item" type="string" rule="require"/>
			<model:field  name="num" type="string" rule="require|regex{^[0-9]{1,12}(\.[0-9]{1,2}){0,1}$}|length{14}"/>
		</model:record>
	</model:dataset>		
<!--申报家庭成员房管基本信息-->
	<model:dataset id="SamEsureyHouseDS" cmd="com.inspur.cams.drel.esurey.cmd.SamEsureyHouseQueryCmd">
		<model:record fromBean="com.inspur.cams.drel.esurey.data.SamEsureyHouse">
			<model:field  name="houseProp" type="string" rule="require"/>
			<model:field  name="houseType" type="string" rule="require"/>
			<model:field  name="houseUseage" type="string" rule="require"/>
			<model:field  name="regValue" type="string" rule="require|regex{^[0-9]{1,12}(\.[0-9]{1,2}){0,1}$}|length{14}"/>
			<model:field  name="regDate" type="string" rule="require"/>
		</model:record>
	</model:dataset>
<!--申报家庭成员工商基本信息-->
	<model:dataset id="SamEsureyBusinessDS" cmd="com.inspur.cams.drel.esurey.cmd.SamEsureyBusinessQueryCmd">
		<model:record fromBean="com.inspur.cams.drel.esurey.data.SamEsureyBusiness">
			<model:field  name="businessType" type="string" rule="require"/>
			<model:field  name="organName" type="string" rule="require|length{25}"/>
			<model:field  name="regAdd" type="string" rule="require|length{50}"/>
			<model:field  name="businessAdd" type="string" rule="length{50}"/>
			<model:field  name="regFund" type="string" rule="require|length{14}"/>
			<model:field  name="regDate" type="string" rule="require"/>
			<model:field  name="organStatus" type="string" rule="require"/>
		</model:record>
	</model:dataset>
<!--申报家庭成员车管基本信息-->
	<model:dataset id="SamEsureyCarDS" cmd="com.inspur.cams.drel.esurey.cmd.SamEsureyCarQueryCmd">
		<model:record fromBean="com.inspur.cams.drel.esurey.data.SamEsureyCar">
			<model:field  name="carNo" type="string" rule="require|length{30}"/>
			<model:field  name="regValue" type="string" rule="require|regex{^[0-9]{1,12}(\.[0-9]{1,2}){0,1}$}|length{14}"/>
			<model:field  name="regDate" type="string" rule="require"/>
			<model:field  name="carUse" type="string" rule="require"/>
		</model:record>
	</model:dataset>
<!--申报家庭成员国税地税基本信息-->
	<model:dataset id="SamEsureyTaxDS" cmd="com.inspur.cams.drel.esurey.cmd.SamEsureyTaxQueryCmd">
		<model:record fromBean="com.inspur.cams.drel.esurey.data.SamEsureyTax">
			<model:field  name="turnoverLatestYear" type="string" rule="require|regex{^[0-9]{1,12}(\.[0-9]{1,2}){0,1}$}|length{14}"/>
			<model:field  name="taxesLatestYear" type="string" rule="require|regex{^[0-9]{1,12}(\.[0-9]{1,2}){0,1}$}|length{14}"/>
			<model:field  name="taxesOrg" type="string" rule="require|length{10}"/>
			<model:field  name="taxesPeople" type="string" rule="require|length{25}"/>
		</model:record>
	</model:dataset>
	<!--申报家庭成员地税基本信息-->
	<model:dataset id="SamEsureyTaxDS2" cmd="com.inspur.cams.drel.esurey.cmd.SamEsureyTaxQueryCmd">
		<model:record fromBean="com.inspur.cams.drel.esurey.data.SamEsureyTax">
			<model:field  name="turnoverLatestYear" type="string" rule="require|regex{^[0-9]{1,12}(\.[0-9]{1,2}){0,1}$}|length{14}"/>
			<model:field  name="taxesLatestYear" type="string" rule="require|regex{^[0-9]{1,12}(\.[0-9]{1,2}){0,1}$}|length{14}"/>
			<model:field  name="taxesOrg" type="string" rule="require|length{10}"/>
			<model:field  name="taxesPeople" type="string" rule="require|length{25}"/>
		</model:record>
	</model:dataset>
<!--申报家庭成员公积金基本信息-->
	<model:dataset id="SamEsureyHousingFundDS" cmd="com.inspur.cams.drel.esurey.cmd.SamEsureyHousingFundQueryCmd">
		<model:record fromBean="com.inspur.cams.drel.esurey.data.SamEsureyHousingFund">
			<model:field  name="balance" type="string" rule="require|regex{^[0-9]{1,12}(\.[0-9]{1,2}){0,1}$}|length{14}"/>
			<model:field  name="collectNum" type="string" rule="require|length{14}"/>
		</model:record>
	</model:dataset>
<!--申报家庭成员人行基本信息-->
	<model:dataset id="SamEsureyBankDS" cmd="com.inspur.cams.drel.esurey.cmd.SamEsureyBankQueryCmd">
		<model:record fromBean="com.inspur.cams.drel.esurey.data.SamEsureyBank">
			<model:field  name="totalSavings" type="string" rule="require|length{14}"/>
			<model:field  name="totalBond" type="string" rule="require|length{14}"/>
		</model:record>
	</model:dataset>	
<!--申报家庭成员证监基本信息-->
	<model:dataset id="SamEsureySecuritiesDS" cmd="com.inspur.cams.drel.esurey.cmd.SamEsureySecuritiesQueryCmd">
		<model:record fromBean="com.inspur.cams.drel.esurey.data.SamEsureySecurities">
			<model:field  name="stock" type="string" rule="require|length{14}"/>
			<model:field  name="fund" type="string" rule="require|length{14}"/>
			<model:field  name="money" type="string" rule="require|length{14}"/>
		</model:record>
	</model:dataset>
<!--申报家庭成员保监基本信息-->
	<model:dataset id="SamEsureyInsuranceDS" cmd="com.inspur.cams.drel.esurey.cmd.SamEsureyInsuranceQueryCmd">
		<model:record fromBean="com.inspur.cams.drel.esurey.data.SamEsureyInsurance">
			<model:field  name="benefitPeople" type="string" rule="require|length{15}"/>
			<model:field  name="benefitType" type="string" rule="require"/>
			<model:field  name="benefitDate" type="string" rule="require"/>
			<model:field  name="benefitNum" type="string" rule="require|length{14}"/>
		</model:record>
	</model:dataset>	
<!-- 性别 -->	
	<model:dataset id="sexDS"  enumName="COMM.SEX" autoLoad="true" global="ture"></model:dataset>
<!-- 家庭性质 -->
	<model:dataset id="familyTypeDS" enumName="FAMILY_TYPE" autoLoad="true"  global="true"></model:dataset>	
<!-- 救助类型 -->	
	<model:dataset id="assistanceTypeDS" enumName="ASSISTANCE_TYPE"  autoLoad="true" global="true"></model:dataset>	
<!-- 与户主关系 -->
	<model:dataset id="RelationDS" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_RELATIONSHIP_TYPE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
<!-- 民族代码-->
	<model:dataset id="DmMzDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_NATION'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
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
	<model:dataset id="healthDS" enumName="HEALTH_CODE"  autoLoad="true" global="true"></model:dataset>	
<!-- 婚姻状况-->
	<model:dataset id="DmHyzkDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_MARRIAGE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
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
	<model:dataset id="politicsDS" enumName="SORG.POLITICS" autoLoad="true" global="true"></model:dataset>
<!-- 年月标志 -->	
	<model:dataset id="ymDS" enumName="YEAR_MONTH" autoLoad="true" global="true"></model:dataset>
<!-- 工资类别 -->
	<model:dataset id="salaryDS" enumName="SALARY_TYPE" autoLoad="true" global="true"></model:dataset>
<!-- 财产类别 -->
	<model:dataset id="itemDS" enumName="ITEM" autoLoad="true" global="true"></model:dataset>
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
	<!-- 房屋用途 -->
	<model:dataset id="houseUserageDataset" enumName="HOUSE.USEAGE" autoLoad="true" global="true"></model:dataset>
	<!-- 交易性质 -->
	<model:dataset id="businessTypeDataset" enumName="BUSINESS.TYPE" autoLoad="true" global="true"></model:dataset>	
	<!-- 企业注册方式 -->
	<model:dataset id="compBusinessTypeDataset" enumName="COMP.BUSINESS.TYPE" autoLoad="true" global="true"></model:dataset>
<!-- 公司状态 -->
	<model:dataset id="organDataset" enumName="ORGAN.STATUS" autoLoad="true" global="true"></model:dataset>
	<!-- 车辆用途 -->
	<model:dataset id="carUseDataset" enumName="CAR.USE" autoLoad="true" global="true"></model:dataset>
	<!-- 车辆类型 -->
	<model:dataset id="carTypeDS" enumName="CAR_TYPE" autoLoad="true" global="true"></model:dataset>
	<!-- 保险受益类型 -->
	<model:dataset id="beneDS" enumName="BENE_TYPE" autoLoad="true" global="true"></model:dataset>
										
</model:datasets>
<next:ViewPort>
<next:Panel name="fit-div" width="100%" height="100%">
	<next:FitLayout>
<!--	申报家庭赡（抚、扶）养义务人员家庭基本信息	-->
		<next:Panel id="jtsfxxPanel" autoWidth="true" height="100%" title="申报家庭赡（抚、扶）养义务人员家庭基本信息" autoScroll="true">
			<next:TopBar>
				<next:ToolBarItem symbol="->"></next:ToolBarItem>
				<next:ToolBarItem iconCls="save" text="保存至下一步(维护赡（抚、扶）养义务人员信息)" handler="nextJtsfcy()"/>
				<next:ToolBarItem iconCls="undo" text="返回主页" handler="return_list"/>				
				<next:ToolBarItem symbol=""></next:ToolBarItem>
				<next:ToolBarItem symbol="-"></next:ToolBarItem>
				<next:ToolBarItem symbol=""></next:ToolBarItem>
			</next:TopBar>
		<next:TabPanel id="tabPanels" autoHeight="true" width="100%" activeTab="2">
		<next:Tabs>
			<next:Panel title="赡（抚、扶）养义务人员家庭基本信息"   autoHeight="true">
				<next:AnchorLayout>
					<next:Panel title="家庭基本信息"  width="100%" height="100%" collapsible="true" autoScroll="true" >
					<next:Html>
					<form id="sbjtjbxxForm" method="post" onsubmit="return false"  dataset="esureyFamilyDS" class="L5form" >
					<table border="0"  width="100%" >
				  		<tr >
				  			<td class="FieldLabel" colspan="2">身份证号:</td>
							<td class="FieldInput">
								<input type="text" id="familyCardNo" name="身份证号:" field="familyCardNo" onchange="check_FamilyCard();" style="width:70%"  maxlength="18" class="TextEditor" />
								<font color="red">*</font>
								<br/><button onclick="forHistoryInfo();">信息检索</button>
							</td>
							<td class="FieldLabel" colspan="2">户主姓名:</td>
							<td class="FieldInput">
								<input type="text" id="familyName" name="户主姓名:" field="familyName" onchange="back_name(this.value);" maxlength="25" style="width:70%" class="TextEditor" />
								<font color="red">*</font>
							</td>	
						</tr>
				  		<tr >	
							<td class="FieldLabel" colspan="2">家庭人口数量:</td>
							<td class="FieldInput">
								<input type="text" id="peopleNum" name="家庭人口数量" field="peopleNum" disabled="disabled" class="TextEditor"  />
								<span><font color=green>自动生成</font></span>
							</td>
							<td class="FieldLabel" colspan="2">家庭性质:</td>
							<td class="FieldInput">
								<select id="domicileType" name="家庭性质:" field="domicileType" onchange="backType(this.options[this.options.selectedIndex]);" style="width:70%"><option dataset="familyTypeDS"></option></select>
								<font color="red">*</font>
							</td>		
						</tr>
				  		<tr >			
							<td class="FieldLabel" colspan="2">救助类型:</td>
							<td class="FieldInput">
								<select id="assistanceType" name="救助类型" field="assistanceType" style="width:70%">
									<option dataset="assistanceTypeDS"></option>
								</select>
							</td>	
							<td class="FieldLabel" colspan="2">邮政编码:</td>
							<td class="FieldInput">
								<input type="text" id="familyPostcode" name="邮政编码: " field="familyPostcode" class="TextEditor" style="width:70%" maxlength="6" />
							</td>		
						</tr>
				  		<tr >		
							<td class="FieldLabel" colspan="2">户籍行政区划:</td>
							<td class="FieldInput">
								<input type="text" name="户籍行政区划:" id="regAddress" field="domicileName"  onclick="func_ForDomicileSelect()" style="width:70%" readonly="readonly" class="TextEditor" />
								<font color="red">*</font>
								<input type="hidden" name="户籍行政区划:" id="regAddressh" field="regAddress"/>
							</td>
							<td class="FieldLabel" colspan="2">属地行政区划:</td>
							<td class="FieldInput">
								<label name="属地行政区划:" id="familyAddress" field="apanageName" ></label>
							</td>	
						</tr>		
				  		<tr >	
							<td class="FieldLabel" colspan="2">家庭住址:</td>
							<td class="FieldInput" colspan="4">
								<input type="text" id="address" name="家庭住址:" field="address" class="TextEditor" maxlength="100" style="width: 90%"/>
							</td>	
				  		</tr>
						<tr>
							<td class="FieldLabel" rowspan="3" width="9%">联系电话</td>
							<td class="FieldLabel" width="15%">宅电:</td>
							<td class="FieldInput" width="26%">
								<input type="text" id="familyPhone" name="宅电:" field="familyPhone" class="TextEditor" style="width:70%" maxlength="20"/>
							</td>
							<td class="FieldLabel" rowspan="3" width="9%">家庭住房</td>
							<td class="FieldLabel" width="15%">住房情况:</td>
							<td class="FieldInput" width="26%">
								<select id="houseStatus" name="住房情况:" field="houseStatus" style="width:70%">
									<option dataset="houseTypeDS"></option>
								</select>
							</td>
						</tr>
						<tr>
							<td class="FieldLabel">手机:</td>
							<td class="FieldInput">
								<input type="text" id="familyMobile" name="手机:" field="familyMobile"  maxlength="20" class="TextEditor" style="width:70%"/>
							</td>
							<td class="FieldLabel">房屋性质:</td>
							<td class="FieldInput">
								<select id="buildingStructure" name="房屋性质:" field="buildingStructure" style="width:70%" >
									<option dataset="buildingTypeDS"></option>
								</select>
							</td>
						</tr>
						<tr>
							<td class="FieldLabel">其他:</td>
							<td class="FieldInput">
								<input type="text" name="其他:" id="familyOtherPhone" field="familyOtherPhone" style="width:70%" maxlength="50" class="TextEditor" />
							</td>
							<td class="FieldLabel" style="width: 110px;">房屋面积：<br/>(单位：平方米)</td>
							<td class="FieldInput">
								<input type="text" id="buildArea" name="房屋面积:" field="buildArea"  maxlength="16" style="width:70%" class="TextEditor" />
							</td>
						</tr>
						<tr>
							<td class="FieldLabel" rowspan="2">收入情况</td>
							<td class="FieldLabel" >家庭年：<br/>(单位：元)</td>
							<td class="FieldInput">
								<input type="text" id="yearIncome" name="家庭年:" field="yearIncome" disabled="disabled" class="TextEditor" />
								<span><font color=green>自动生成</font></span>
							</td>
							<td class="FieldLabel" rowspan="2">收入情况</td>
							<td class="FieldLabel">家庭月：<br/>(单位：元)</td>
							<td class="FieldInput">
								<input type="text" id="monthIncome" name="家庭月:" field="monthIncome" disabled="disabled" class="TextEditor" />
								<span><font color=green>自动生成</font></span>
							</td>
						</tr>
						<tr>
							<td class="FieldLabel">家庭年人均：<br/>(单位：元)</td>
							<td class="FieldInput">
								<input type="text" name="家庭年人均:" id="yearAverageIncome" field="yearAverageIncome" disabled="disabled" />
								<span><font color=green>自动生成</font></span>
							</td>
							<td class="FieldLabel" style="width: 110px;">家庭月人均：<br/>(单位：元)</td>
							<td class="FieldInput">
								<input type="text" id="monthAverageIncome" name="家庭月人均:" field="monthAverageIncome" disabled="disabled" class="TextEditor" />
								<span><font color=green>自动生成</font></span>
							</td>
						</tr>
						<input type="hidden" name="familyId" id="jfamilyId" value="<%=familyId%>" />
						<input type="hidden" name="peopleId" id="jpeopleId" value="<%=peopleId%>" />
						<input type="hidden" name="parentFamilyId" id="parentFamilyId" />							
					</table>
			</form>
			</next:Html>
			</next:Panel>
		</next:AnchorLayout>
		</next:Panel>
			<next:Panel title="户主基本信息" id = "host_panel"   autoHeight="true" >
			  <next:AnchorLayout>
				<next:Panel title="基本信息" collapsible="true"  width="100%" height="100%" autoScroll="true" >
			     <next:Html>
                  	<form id="cyjbxxForm" method="post" onsubmit="return false" dataset="esureyPeopleDS3"
						class="L5form" >
						<table border="0"  width="100%">
						<tr >		
								<td class="FieldLabel">是否为赡（抚、扶）养义务人员：</td>
								<td class="FieldInput" colspan="3">
									<select  id="hisSupport"  field="isSupport" style="width:25%"><option dataset="isSupportDS"></option></select>
									<font color="red">*</font>
								</td>
							</tr>	
					  		<tr >
								<td class="FieldLabel" width="20%">姓名:</td>
								<td class="FieldInput" width="30%">
									<input type="text" id="hname" name="姓名:" field="name" readonly="readonly" style="width:65%" class="TextEditor" />
									<font color="red">*</font>
								</td>	
								<td class="FieldLabel" width="20%">与户主关系:</td>
								<td class="FieldInput" width="30%">
									<select name="与户主关系:" id="hrelationshipType" field="relationshipType" readonly="readonly" style="width:65%" ><option dataset="RelationDS"></option></select>
									<font color="red">*</font>
								</td>		
							</tr>
					  		<tr >	
								<td class="FieldLabel">身份证号:</td>
								<td class="FieldInput">
									<input type="text" name="身份证号:" id="hidCard" field="idCard" readonly="readonly" style="width:65%" class="TextEditor" />
									<font color="red">*</font>
								</td>
								<td class="FieldLabel">性别:</td>
								<td class="FieldInput">
									<select name="性别" id="hsex" field="sex" style="width:65%" ><option dataset="sexDS"></option></select>
									<font color="red">*</font>
								</td>		
							</tr>
					  		<tr >			
								<td class="FieldLabel">民族:</td>
								<td class="FieldInput">
									<select  name="民族:" id="hnation" field="nation" style="width:65%" ><option  dataset="DmMzDataSet" ></option></select>
									<font color="red">*</font>
								</td>	
								<td class="FieldLabel">文化程度:</td>
								<td class="FieldInput">
									<select name="文化程度:"  id="heduCode" field="eduCode" style="width:65%" ><option dataset="DmJyzkDataSet"></option></select>
								</td>		
							</tr>
					  		<tr >		
								<td class="FieldLabel">健康状况:</td>
								<td class="FieldInput">
									<select  name="健康状况:" id="hhealthCode" field="healthCode" style="width:65%" ><option dataset="healthDS"></option></select>
								</td>
								<td class="FieldLabel">婚姻状况:</td>
								<td class="FieldInput">
									<select  name="婚姻状况:" id="hmarriageCode" field="marriageCode"  style="width:65%"><option dataset="DmHyzkDataSet"></option></select>
								</td>	
							</tr>
					  		<tr >		
								<td class="FieldLabel">职业:</td>
								<td class="FieldInput">
									<select  name="职业:"  id="hcareerCode" field="careerCode" style="width:65%" ><option dataset="DmZyDataSet"></option></select>
								</td>
								<td class="FieldLabel">政治面貌:</td>
								<td class="FieldInput">
									<select  name="政治面貌:" id="hpoliticalCode" field="politicalCode" style="width:65%"><option dataset="politicsDS"></option></select>
								</td>	
							</tr>	
					  		<tr >		
								<td class="FieldLabel">户口性质:</td>
								<td class="FieldInput" colspan="3">
									<select name="户口性质" id="hdomicileType" field="domicileType"  disabled="disabled" style="width:25%" ><option dataset="familyTypeDS"></option></select>
									<font color="red">*</font>
								</td>
							</tr>	
					  		<tr >		
								<td class="FieldLabel">年收入：<br/>(单位：元)</td>
								<td class="FieldInput">
									<input type="text" name="年收入：" id="hincomeYear" field="incomeYear" disabled="disabled" onchange="workOutMIncome();"  maxlength="16" style="width:65%" class="TextEditor" />
									<br/><span><font color=green>农村户籍填写</font></span>
								</td>
								<td class="FieldLabel">月收入：<br/>(单位：元)</td>
								<td class="FieldInput">
									<input type="text" name="月收入：" id="hincomeMonth" field="incomeMonth" disabled="disabled" onchange="workOutYIncome();"  maxlength="16" style="width:65%" class="TextEditor" />
									<br/><span><font color=green>城市户籍填写</font></span>
								</td>	
							</tr>	
					  		<tr >		
								<td class="FieldLabel">工作单位:</td>
								<td class="FieldInput" colspan="3">
									<input type="text" id="hworkUnitName" field="workUnitName" class="TextEditor" maxlength="50" style="width:85%"/>
								</td>
							</tr>	
						</table>
					</form>
                  </next:Html>
			</next:Panel>
		</next:AnchorLayout>
		</next:Panel>
		<next:Panel title="户主经济信息" id="peopleEsur_panel"  name="peopleEsur_panel" height="100%" >
			  <next:FitLayout>
				<next:Panel title="经济信息" collapsible="true" name="tabPanels3" animCollapse="true" height="100%"  width="100%"   >
			    <next:Panel autoWidth="true" autoHeight="true">
                  <next:Html>
                  	<form id="cyjjzkxxForm1" method="post" onsubmit="return false" style="padding: 5px;" 
						class="L5form" >
						<table border="0"  width="100%" height="100%">
					  		<tr >
								<td class="FieldLabel" width="20%">姓名:</td>
								<td class="FieldInput" width="25%">
									<label id="hcyName"   />
								</td>	
								<td class="FieldLabel" width="20%">身份证号:</td>
								<td class="FieldInput" width="20%">
									<label id="hcyIdCard" />
								</td>
							</tr>
						</table>
					</form>
                  </next:Html>
              </next:Panel>
              <next:Panel   width="100%" height="100%"  autoScroll="true">
				<next:EditGridPanel  id="social_grid" name="social_grid" width="99%" height="200" title="社保列表" clicksToEdit="2" dataset="SamEsureySocialDS">
					<next:TopBar>
						<next:ToolBarItem symbol="->" ></next:ToolBarItem>
						<next:ToolBarItem iconCls="add" text="添加" handler="addSocial"/>
						<next:ToolBarItem iconCls="remove" text="删除" handler="deleteSocial"/>
					</next:TopBar>
					<next:Columns>
						<next:RowNumberColumn width="10"/>
						<next:RadioBoxColumn></next:RadioBoxColumn>
						<next:Column id="hsId" header="流水ID"  field="id" hidden="true">    
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="hsType" header="信息类别"  field="type"  hidden="true">
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="hsFeedbackId" header="填表Id"  field="feedbackId" hidden="true">
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="hsPeopleId" header="人员Id"  field="peopleId" hidden="true">
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="hsYearMonth" header="年月标志"  field="yearMonth" width="10%">
							<next:ComboBox triggerAction="all" valueField="value" displayField="text" dataset="ymDS"/>
						</next:Column>
						<next:Column id="hsSalaryType" header="工资类别"  field="salaryType" width="15%">
							<next:ComboBox triggerAction="all" valueField="value" displayField="text" dataset="salaryDS" />
						</next:Column>
						<next:Column id="hsSalary" header="工资、养老金金额(/元)"  field="salary" width="20%">
							<next:NumberField allowBlank="false"/>
						</next:Column>
						<next:Column id="hsPension" header="养老金缴纳金额(/元)"  field="pension" width="20%">
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="hsPensionBalance" header="养老金余额(/元)"  field="pensionBalance" width="20%">
							<next:TextField allowBlank="false"/>
						</next:Column>
					</next:Columns>
				</next:EditGridPanel>
				
				<next:EditGridPanel  id="estate_grid" name="estate_grid" width="99%" height="200"  title="其他财产收入列表" clicksToEdit="2" dataset="SamEsureyPeopleEstateDS">
					<next:TopBar>
						<next:ToolBarItem symbol="->" ></next:ToolBarItem>
						<next:ToolBarItem iconCls="add" text="添加" handler="add_estate"/>
						<next:ToolBarItem iconCls="remove" text="删除" handler="delete_estate" />
					</next:TopBar>
					<next:Columns>
						<next:RowNumberColumn width="10"/>
						<next:RadioBoxColumn></next:RadioBoxColumn>
						<next:Column id="htId" header="流水ID"  field="id" hidden="true">
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="htType" header="信息类别"  field="type" hidden="true" >
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="htFeedbackId" header="填表Id"  field="feedbackId" hidden="true">
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="htPeopleId" header="人员Id"  field="peopleId" hidden="true">
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="hperiod" header="年月标志"  field="period" >
							<next:ComboBox triggerAction="all" valueField="value" displayField="text" dataset="ymDS"/>
						</next:Column>
						<next:Column id="hitem" header="财产、收入类别"  field="item" >
							<next:ComboBox triggerAction="all" valueField="value" displayField="text" dataset="itemDS"/>
						</next:Column>
						<next:Column id="hnum" header="金额(/元)"  field="num" >
							<next:NumberField  allowBlank="false"/>
						</next:Column>
					</next:Columns>
				</next:EditGridPanel>
				              
              <next:EditGridPanel  id="house_grid" name="house_grid" width="99%" height="200" title="房屋信息列表" clicksToEdit="2" dataset="SamEsureyHouseDS">
					<next:TopBar>
						<next:ToolBarItem symbol="->" ></next:ToolBarItem>
						<next:ToolBarItem iconCls="add" text="添加" handler="add_house"/>
						<next:ToolBarItem iconCls="remove" text="删除" handler="delete_house"/>
					</next:TopBar>
					<next:Columns>
						<next:RowNumberColumn width="10"/>
						<next:RadioBoxColumn></next:RadioBoxColumn>
						<next:Column id="hhId" header="流水ID"  field="id" hidden="true">
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="hhType" header="信息类别"  field="type" hidden="true" >
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="hhFeedbackId" header="填表Id"  field="feedbackId" hidden="true">
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="hhPeopleId" header="人员Id"  field="peopleId" hidden="true">
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="hhouseCardNo" header="房产证号"  field="houseCardNo" >
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="hhouseUseage" header="房屋用途"  field="houseUseage" >
							<next:ComboBox triggerAction="all" valueField="value" displayField="text" dataset="houseUserageDataset"/>
						</next:Column>
						<next:Column id="hhregValue" header="交易价值(/元)"  field="regValue" >
							<next:NumberField  allowBlank="false"/>
						</next:Column>
						<next:Column id="hregDate" header="登记或交易时间"  field="regDate" >
							<next:DateTimeField allowBlank="false" format="Y-m-d"/>
						</next:Column>
						<next:Column id="hbusinessType" header="交易性质"  field="businessType" >
							<next:ComboBox triggerAction="all" valueField="value" displayField="text" dataset="businessTypeDataset"/>
						</next:Column>
						<next:Column id="hlocation" header="房屋坐落"  field="location" >
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="hhouseArea" header="建筑面积(/平方米)"  field="houseArea" >
							<next:NumberField allowBlank="false"/>
						</next:Column>
					</next:Columns>
				</next:EditGridPanel>
				
				<next:EditGridPanel  id="business_grid" name="business_grid" width="99%" height="200" title="工商经营信息列表" clicksToEdit="2"  dataset="SamEsureyBusinessDS">
					<next:TopBar>
						<next:ToolBarItem symbol="->" ></next:ToolBarItem>
						<next:ToolBarItem iconCls="add" text="添加" handler="add_business"/>
						<next:ToolBarItem iconCls="remove" text="删除" handler="delete_business"/>
					</next:TopBar>
					<next:Columns>
						<next:RowNumberColumn width="10"/>
						<next:RadioBoxColumn></next:RadioBoxColumn>
						<next:Column id="hbId" header="流水ID"  field="id" hidden="true">
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="hbType" header="信息类别"  field="type"  hidden="true">
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="hbFeedbackId" header="填表Id"  field="feedbackId" hidden="true">
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="hbPeopleId" header="人员Id"  field="peopleId" hidden="true">
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="hbusinessType" header="企业注册方式"  field="businessType" >
							<next:ComboBox triggerAction="all" valueField="value" displayField="text" dataset="compBusinessTypeDataset"/>
						</next:Column>
						<next:Column id="hlegalPerson" header="企业法人名称"  field="legalPerson" >
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="horganName" header="企业名称"  field="organName" >
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="hregAdd" header="注册地址"  field="regAdd" >
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="hbusinessAdd" header="经营地址"  field="businessAdd" >
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="hregFund" header="注册资金(/元)"  field="regFund" >
							<next:NumberField allowBlank="false" />
						</next:Column>
						<next:Column id="hbRegDate" header="注册时间"  field="regDate" >
							<next:DateTimeField allowBlank="false" format="Y-m-d"/>
						</next:Column>
						<next:Column id="hbusinessScope" header="经营范围"  field="businessScope" >
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="horganStatus" header="企业当前状态"  field="organStatus" >
							<next:ComboBox triggerAction="all" valueField="value" displayField="text" dataset="organDataset"/>
						</next:Column>
					</next:Columns>
				</next:EditGridPanel>
				
				<next:EditGridPanel  id="car_grid" name="car_grid" width="99%" height="200" title="车辆信息列表" clicksToEdit="2" dataset="SamEsureyCarDS">
					<next:TopBar>
						<next:ToolBarItem symbol="->" ></next:ToolBarItem>
						<next:ToolBarItem iconCls="add" text="添加" handler="add_car"/>
						<next:ToolBarItem iconCls="remove" text="删除" handler="delete_car"/>
					</next:TopBar>
					<next:Columns>
						<next:RowNumberColumn width="10"/>
						<next:RadioBoxColumn></next:RadioBoxColumn>
						<next:Column id="hcId" header="流水ID"  field="id" hidden="true">
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="hcType" header="信息类别"  field="type"  hidden="true">
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="hcFeedbackId" header="填表Id"  field="feedbackId" hidden="true">
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="hcPeopleId" header="人员Id"  field="peopleId" hidden="true">
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="howner" header="车主姓名"  field="owner" >
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="hcarNo" header="车牌号码"  field="carNo" >
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="hcarType" header="车辆类型"  field="carType" >
							<next:ComboBox triggerAction="all" valueField="value" displayField="text" dataset="carTypeDS"/>
						</next:Column>
						<next:Column id="hregValue" header="登记价值(/元)"  field="regValue" >
							<next:NumberField allowBlank="false"/>
						</next:Column>
						<next:Column id="hcRegDate" header="登记时间"  field="regDate" >
							<next:DateTimeField allowBlank="false" format="Y-m-d"/>
						</next:Column>
						<next:Column id="hcarUse" header="用途"  field="carUse" >
							<next:ComboBox  triggerAction="all" valueField="value" displayField="text" dataset="carUseDataset"/>
						</next:Column>
					</next:Columns>
				</next:EditGridPanel>
				
				<next:EditGridPanel  id="tax_grid" name="tax_grid" width="99%" height="200" title="国税信息" clicksToEdit="2" dataset="SamEsureyTaxDS">
					<next:TopBar>
						<next:ToolBarItem symbol="->" ></next:ToolBarItem>
						<next:ToolBarItem iconCls="add" text="添加" handler="add_tax"/>
						<next:ToolBarItem iconCls="remove" text="删除" handler="delete_tax"/>
					</next:TopBar>
					<next:Columns>
						<next:RowNumberColumn width="10"/>
						<next:RadioBoxColumn></next:RadioBoxColumn>
						<next:Column id="htId" header="流水ID"  field="id" hidden="true">
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="htType" header="信息类别"  field="type"  hidden="true">
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="htFeedbackId" header="填表Id"  field="feedbackId" hidden="true">
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="htPeopleId" header="人员Id"  field="peopleId" hidden="true">
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="htaxesType" header="纳税类型"  field="taxesType" hidden="true">
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="htaxesPeople" header="纳税人姓名"  field="taxesPeople" width="15%">
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="htaxesOrg" header="纳税企业名称"  field="taxesOrg" width="20%">
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="hturnoverLatestYear" header="最近一年营业额(/元)"  field="turnoverLatestYear" width="20%">
							<next:NumberField allowBlank="false"/>
						</next:Column>
						<next:Column id="htaxesLatestYear" header="最近一年纳税额(/元)"  field="taxesLatestYear" width="20%">
							<next:NumberField allowBlank="false"/>
						</next:Column>
					</next:Columns>
				</next:EditGridPanel>
				
				<next:EditGridPanel  id="tax2_grid" name="tax2_grid" width="99%" height="200" title="地税信息" clicksToEdit="2" dataset="SamEsureyTaxDS2">
					<next:TopBar>
						<next:ToolBarItem symbol="->" ></next:ToolBarItem>
						<next:ToolBarItem iconCls="add" text="添加" handler="add_tax2"/>
						<next:ToolBarItem iconCls="remove" text="删除" handler="delete_tax2"/>
					</next:TopBar>
					<next:Columns>
						<next:RowNumberColumn width="10"/>
						<next:RadioBoxColumn></next:RadioBoxColumn>
						<next:Column id="hIdx" header="流水ID"  field="id" hidden="true">
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="hTypex" header="信息类别"  field="type"  hidden="true">
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="hFeedbackIdx" header="填表Id"  field="feedbackId" hidden="true">
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="hPeopleIdx" header="人员Id"  field="peopleId" hidden="true">
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="haxesTypex" header="纳税类型"  field="taxesType" hidden="true" >
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="haxesPeoplex" header="纳税人姓名"  field="taxesPeople" width="10%">
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="haxesOrgx" header="纳税企业名称"  field="taxesOrg" width="20%">
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="hurnoverLatestYearx" header="最近一年营业额(/元)"  field="turnoverLatestYear" width="20%">
							<next:NumberField allowBlank="false"/>
						</next:Column>
						<next:Column id="haxesLatestYearx" header="最近一年纳税额(/元)"  field="taxesLatestYear" width="20%">
							<next:NumberField allowBlank="false"/>
						</next:Column>
					</next:Columns>
				</next:EditGridPanel>
				
				<next:EditGridPanel  id="fund_grid" name="fund_grid" width="99%" height="200" title="公积金信息" clicksToEdit="2" dataset="SamEsureyHousingFundDS">
					<next:TopBar>
						<next:ToolBarItem symbol="->" ></next:ToolBarItem>
						<next:ToolBarItem iconCls="add" text="添加" handler="add_fund"/>
						<next:ToolBarItem iconCls="remove" text="删除" handler="delete_fund"/>
					</next:TopBar>
					<next:Columns>
						<next:RowNumberColumn width="10"/>
						<next:RadioBoxColumn></next:RadioBoxColumn>
						<next:Column id="hfId" header="流水ID"  field="id" hidden="true">
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="hfType" header="信息类别"  field="type"  hidden="true">
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="hfFeedbackId" header="填表Id"  field="feedbackId" hidden="true">
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="hfPeopleId" header="人员Id"  field="peopleId" hidden="true">
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="hfName" header="姓名"  field="name" width="10%">
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="hbalance" header="公积金余额(/元)"  field="balance" width="20%">
							<next:NumberField allowBlank="false"/>
						</next:Column>
						<next:Column id="hcollectNum" header="历史提取金额合计(/元)"  field="collectNum" width="20%">
							<next:NumberField allowBlank="false"/>
						</next:Column>
					</next:Columns>
				</next:EditGridPanel>
				
				<next:EditGridPanel  id="bank_grid" name="bank_grid" width="99%" height="200" title="人民银行信息" clicksToEdit="2" dataset="SamEsureyBankDS">
					<next:TopBar>
						<next:ToolBarItem symbol="->" ></next:ToolBarItem>
						<next:ToolBarItem iconCls="add" text="添加" handler="add_bank"/>
						<next:ToolBarItem iconCls="remove" text="删除" handler="delete_bank"/>
					</next:TopBar>
					<next:Columns>
						<next:RowNumberColumn width="10"/>
						<next:RadioBoxColumn></next:RadioBoxColumn>
						<next:Column id="hkId" header="流水ID"  field="id" hidden="true">
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="hkType" header="信息类别"  field="type"  hidden="true">
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="hkFeedbackId" header="填表Id"  field="feedbackId" hidden="true">
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="hkPeopleId" header="人员Id"  field="peopleId" hidden="true">
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="haccountName" header="开户人姓名"  field="accountName" >
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="htotalSavings" header="存款金额合计(/元)"  field="totalSavings" >
							<next:NumberField allowBlank="false"/>
						</next:Column>
						<next:Column id="htotalBond" header="债券总金额(/元)"  field="totalBond" >
							<next:NumberField allowBlank="false"/>
						</next:Column>
					</next:Columns>
				</next:EditGridPanel>
				
				<next:EditGridPanel  id="securities_grid" name="securities_grid" width="99%" height="200" title="证监列表" clicksToEdit="2" dataset="SamEsureySecuritiesDS">
					<next:TopBar>
						<next:ToolBarItem symbol="->" ></next:ToolBarItem>
						<next:ToolBarItem iconCls="add" text="添加" handler="add_securities"/>
						<next:ToolBarItem iconCls="remove" text="删除" handler="delete_securities"/>
					</next:TopBar>
					<next:Columns>
						<next:RowNumberColumn width="10"/>
						<next:RadioBoxColumn></next:RadioBoxColumn>
						<next:Column id="heId" header="流水ID"  field="id" hidden="true">
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="heType" header="信息类别"  field="type"  hidden="true">
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="heFeedbackId" header="填表Id"  field="feedbackId" hidden="true">
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="hePeopleId" header="人员Id"  field="peopleId" hidden="true">
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="heName" header="开户人姓名"  field="name" width="10%">
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="hstock" header="股票市值总金额(/元)"  field="stock" width="20%">
							<next:NumberField allowBlank="false"/>
						</next:Column>
						<next:Column id="hfund" header="基金市值总金额(/元)"  field="fund" width="20%">
							<next:NumberField allowBlank="false"/>
						</next:Column>
						<next:Column id="hmoney" header="资金总余额(/元)"  field="money" width="20%">
							<next:NumberField allowBlank="false"/>
						</next:Column>
					</next:Columns>
				</next:EditGridPanel>
				
				<next:EditGridPanel  id="insurance_grid" name="insurance_grid" width="99%" height="200" title="保险信息列表" clicksToEdit="2" dataset="SamEsureyInsuranceDS">
					<next:TopBar>
						<next:ToolBarItem symbol="->" ></next:ToolBarItem>
						<next:ToolBarItem iconCls="add" text="添加" handler="add_insurance"/>
						<next:ToolBarItem iconCls="remove" text="删除" handler="delete_insurance"/>
					</next:TopBar>
					<next:Columns>
						<next:RowNumberColumn width="10"/>
						<next:RadioBoxColumn></next:RadioBoxColumn>
						<next:Column id="hiId" header="流水ID"  field="id" hidden="true">
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="hiType" header="信息类别"  field="type"  hidden="true">
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="hiFeedbackId" header="填表Id"  field="feedbackId" hidden="true">
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="hiPeopleId" header="人员Id"  field="peopleId" hidden="true">
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="hbenefitPeople" header="保险受益人"  field="benefitPeople" >
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="hbenefitType" header="保险受益种类"  field="benefitType" >
							<next:ComboBox triggerAction="all" valueField="value" displayField="text" dataset="beneDS"/>
						</next:Column>
						<next:Column id="hbenefitDate" header="受益时间"  field="benefitDate" >
							<next:DateTimeField allowBlank="false" format="Y-m-d"/>
						</next:Column>
						<next:Column id="hbenefitNum" header="保险受益金额(/元)"  field="benefitNum" >
							<next:NumberField allowBlank="false"/>
						</next:Column>
					</next:Columns>
				</next:EditGridPanel>
				</next:Panel>				
                </next:Panel>
               </next:FitLayout>
			</next:Panel>
			
		</next:Tabs>		
	</next:TabPanel>
		</next:Panel>		
		
<!--	申报家庭赡（抚、扶）养义务人员信息	-->		
		<next:Panel id="jtsffxxPanel" width="100%" height="100%" title="申报家庭赡（抚、扶）养义务人员信息" autoScroll="true">
			<next:TopBar>
				<next:ToolBarItem symbol="->"></next:ToolBarItem>
				<next:ToolBarItem iconCls="save" text="录入完成保存" handler="allSave()"/>
			</next:TopBar>
			
			<next:GridPanel id="ywcyGridPanel" name="ywcyGridPanel" autoWidth="true" stripeRows="true" height="100%" title="共同生活家庭成员列表" collapsible="true" dataset="esureyPeopleDS">
				<next:TopBar>
					<next:ToolBarItem symbol="->" ></next:ToolBarItem>
					<next:ToolBarItem iconCls="add" text="添加" handler="addSfFamilyMember()"/>
					<next:ToolBarItem iconCls="edit" text="修改" handler="editSfFamilyMember()"/>
					<next:ToolBarItem iconCls="remove" text="删除" handler="deleteSfFamilyMember()"/>
				</next:TopBar>
				<next:Columns>
				    <next:RowNumberColumn width="10"/>
				    <next:Column id="peopleId" header="人员Id" field="peopleId" hidden="true" width="90" >
						<next:TextField  />
					</next:Column>
					<next:Column id="familyId" header="家庭Id" field="familyId" hidden="true" width="90" >
						<next:TextField  />
					</next:Column>
					<next:Column id="name" header="成员姓名" field="name" width="15%" >
						<next:TextField  />
					</next:Column>
					<next:Column id="relationshipType" header="户主关系" field="relationshipType" dataset="RelationDS" width="10%" >
						<next:TextField  />
					</next:Column>
					<next:Column id="idCard" header="身份证号" field="idCard" width="20%" >
						<next:TextField  />
					</next:Column>
					<next:Column id="sex" header="性别" field="sex" dataset="sexDS" width="10%" >
						<next:TextField  />
					</next:Column>
					<next:Column id="nation" header="民族" field="nation" dataset="DmMzDataSet" width="10%" >
						<next:TextField  />
					</next:Column>
					<next:Column id="domicileType" header="户口性质" field="domicileType" dataset="familyTypeDS" width="10%" >
						<next:TextField  />
					</next:Column>
					<next:Column id="isSupport" header="是否赡养义务人员" field="isSupport" dataset="isSupportDS" width="20%" >
						<next:TextField  />
					</next:Column>
				</next:Columns> 
				<next:BottomBar>
					<next:PagingToolBar dataset="esureyPeopleDS"/>
				</next:BottomBar>
			</next:GridPanel>
		</next:Panel>
	</next:FitLayout>
</next:Panel>
</next:ViewPort>


<next:Window id="jtcyEdit" title="编辑" titleCollapse="false"  resizable="false" width="700" height="400" closeAction="hide">
	 <next:TopBar>
	      	<next:ToolBarItem symbol="->"></next:ToolBarItem>
			<next:ToolBarItem iconCls="select" text="确定" handler="add_people"/>
			<next:ToolBarItem iconCls="delete" text="关闭" handler="hide_win"/>
      </next:TopBar>
	<next:FitLayout>
       <next:TabPanel id="jtcyTabpanel" activeTab="1" border="false" >
           <next:Tabs>
<!--	成员基本信息	-->
              <next:Panel title="成员基本信息">
                  <next:Html>
                  	<form id="cyjbxxForm" method="post" onsubmit="return false"  dataset="esureyPeopleDS2"
						class="L5form" >
						<table border="0"  width="100%">
							<tr >		
								<td class="FieldLabel">是否为赡（抚、扶）养义务人员：</td>
								<td class="FieldInput" colspan="3">
									<select name="是否为赡（抚、扶）养义务人员：" id="isSupport"  field="isSupport" style="width:32%"><option dataset="isSupportDS"></option></select><font color="red">*</font>
								</td>
							</tr>		
					  		<tr >
								<td class="FieldLabel" width="20%">姓名:</td>
								<td class="FieldInput" width="30%">
									<input type="text" id="name" name="姓名:" field="name" onchange="backfillName(this.value)" maxlength="25" style="width:90%" class="TextEditor" />
									<font color="red">*</font>
								</td>	
								<td class="FieldLabel" width="20%">与户主关系:</td>
								<td class="FieldInput" width="30%">
									<select  name="与户主关系:" id="relationshipType" field="relationshipType" disabled="disabled"  style="width:90%"><option dataset="RelationDS"></option></select>
									<font color="red">*</font>
								</td>		
							</tr>
					  		<tr >	
								<td class="FieldLabel">身份证号:</td>
								<td class="FieldInput">
									<input type="text" name="身份证号:" id="idCard" field="idCard" onchange="check_peopleIdCard();" disabled="disabled" maxlength="18" style="width:90%" class="TextEditor" />
									<font color="red">*</font>
								</td>
								<td class="FieldLabel">性别:</td>
								<td class="FieldInput">
									<select name="性别" field="sex" style="width:90%"><option dataset="sexDS"></option></select>
									<font color="red">*</font>
								</td>		
							</tr>
					  		<tr>			
								<td class="FieldLabel">民族:</td>
								<td class="FieldInput">
									<select  name="民族:" id="nation" field="nation" style="width:90%"><option  dataset="DmMzDataSet" style="width:70%"></option></select>
									<font color="red">*</font>
								</td>	
								<td class="FieldLabel">文化程度:</td>
								<td class="FieldInput">
									<select name="文化程度:"  id="eduCode" field="eduCode" style="width:90%"><option dataset="DmJyzkDataSet"></option></select>
								</td>		
							</tr>
					  		<tr >		
								<td class="FieldLabel">健康状况:</td>
								<td class="FieldInput">
									<select  name="健康状况:" id="healthCode" field="healthCode" style="width:90%"><option dataset="healthDS"></option></select>
								</td>
								<td class="FieldLabel">婚姻状况:</td>
								<td class="FieldInput">
									<select  name="婚姻状况:" id="marriageCode" field="marriageCode" style="width:90%"><option dataset="DmHyzkDataSet"></option></select>
								</td>	
							</tr>
					  		<tr >		
								<td class="FieldLabel">职业:</td>
								<td class="FieldInput">
									<select  name="职业:"  id="careerCode" field="careerCode" style="width:90%"><option dataset="DmZyDataSet"></option></select>
								</td>
								<td class="FieldLabel">政治面貌:</td>
								<td class="FieldInput">
									<select  name="政治面貌:" id="politicalCode" field="politicalCode" style="width:90%"><option dataset="politicsDS"></option></select>
								</td>	
							</tr>	
					  		<tr >		
								<td class="FieldLabel">户口性质:</td>
								<td class="FieldInput" colspan="3">
									<select name="户口性质" id="domicileType" field="domicileType" onchange="backType2(this.options[this.options.selectedIndex]);" style="width:32%"><option dataset="familyTypeDS"></option></select>
									<font color="red">*</font>
								</td>
							</tr>	
					  		<tr >		
								<td class="FieldLabel">年收入：<br/>(单位：元)</td>
								<td class="FieldInput">
									<input type="text" name="年收入：" id="incomeYear" field="incomeYear"  onchange="workOutMIncome2();" style="width:90%" class="TextEditor" />
									<br/><span><font color=red>农村户籍必须填写*</font></span>
								</td>
								<td class="FieldLabel">月收入：<br/>(单位：元)</td>
								<td class="FieldInput">
									<input type="text" name="月收入：" id="incomeMonth" field="incomeMonth" disabled="disabled" onchange="workOutYIncome2();" style="width:90%" class="TextEditor" />
									<br/><span><font color=red>城市户籍必须填写*</font></span>
								</td>	
							</tr>	
					  		<tr >		
								<td class="FieldLabel">工作单位:</td>
								<td class="FieldInput" colspan="3">
									<input type="text" id="workUnitName" field="workUnitName" class="TextEditor" style="width:96%"/>
								</td>
							</tr>			
						</table>
					</form>
                  </next:Html>
              </next:Panel>
		
<!--	成员经济状况信息	-->
              <next:Panel title="本成员经济状况信息" width="100%"  height="100%">
              <next:FitLayout>
              <next:Panel width="100%" autoHeight="true">
                  <next:Html>
                  	<form id="cyjjzkxxForm" method="post" onsubmit="return false" style="padding: 5px;" 
						class="L5form" >
						<table border="0"  width="100%" >
					  		<tr >
								<td class="FieldLabel" width="20%">姓名:</td>
								<td class="FieldInput" width="30%">
									<label id="cyName"  />
								</td>	
								<td class="FieldLabel" width="20%">身份证号:</td>
								<td class="FieldInput" width="30%">
									<label id="cyIdCard"/>
								</td>
							</tr>
						</table>
					</form>
                  </next:Html>
              </next:Panel>
               <next:Panel  width="100%" height="100%"  autoScroll="true">
				<next:EditGridPanel  id="wsocial_grid" name="wsocial_grid"  height="150" collapsible="true" title="本成员社保列表" clicksToEdit="2" dataset="SamEsureySocialDS">
					<next:TopBar>
						<next:ToolBarItem symbol="->" ></next:ToolBarItem>
						<next:ToolBarItem iconCls="add" text="添加" handler="addSocial"/>
						<next:ToolBarItem iconCls="remove" text="删除" handler="deleteSocial2"/>
					</next:TopBar>
					<next:Columns>
						<next:RowNumberColumn width="10"/>
						<next:RadioBoxColumn></next:RadioBoxColumn>
						<next:Column id="sId" header="流水ID"  field="id" hidden="true" width="10%">    
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="sType" header="信息类别"  field="type"  hidden="true" width="10%">
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="sFeedbackId" header="填表Id"  field="feedbackId" hidden="true" width="10%">
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="sPeopleId" header="人员Id"  field="peopleId" hidden="true" width="10%">
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="sYearMonth" header="年月标志"  field="yearMonth" width="10%">
							<next:ComboBox triggerAction="all" valueField="value" displayField="text" dataset="ymDS" />
						</next:Column>
						<next:Column id="sSalaryType" header="工资类别"  field="salaryType"  width="15%">
							<next:ComboBox triggerAction="all" valueField="value" displayField="text" dataset="salaryDS"/>
						</next:Column>
						<next:Column id="sSalary" header="工资、养老金金额(/元)"  field="salary" width="20%">
							<next:NumberField allowBlank="false"/>
						</next:Column>
						<next:Column id="sPension" header="养老金缴纳金额(/元)"  field="pension" width="20%">
							<next:NumberField allowBlank="false"/>
						</next:Column>
						<next:Column id="sPensionBalance" header="养老金余额(/元)"  field="pensionBalance" width="20%">
							<next:NumberField allowBlank="false"/>
						</next:Column>
					</next:Columns>
				</next:EditGridPanel>
				
				<next:EditGridPanel  id="westate_grid" name="westate_grid"  height="150" collapsible="true" title="本成员其他财产收入列表" clicksToEdit="2" dataset="SamEsureyPeopleEstateDS">
					<next:TopBar>
						<next:ToolBarItem symbol="->" ></next:ToolBarItem>
						<next:ToolBarItem iconCls="add" text="添加" handler="add_estate"/>
						<next:ToolBarItem iconCls="remove" text="删除" handler="delete_estate2" />
					</next:TopBar>
					<next:Columns>
						<next:RowNumberColumn width="10"/>
						<next:RadioBoxColumn></next:RadioBoxColumn>
						<next:Column id="tId" header="流水ID"  field="id" hidden="true">
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="tType" header="信息类别"  field="type" hidden="true" >
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="tFeedbackId" header="填表Id"  field="feedbackId" hidden="true">
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="tPeopleId" header="人员Id"  field="peopleId" hidden="true">
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="period" header="年月标志"  field="period" >
							<next:ComboBox triggerAction="all" valueField="value" displayField="text" dataset="ymDS"/>
						</next:Column>
						<next:Column id="item" header="财产、收入类别"  field="item" >
							<next:ComboBox triggerAction="all" valueField="value" displayField="text" dataset="itemDS"/>
						</next:Column>
						<next:Column id="num" header="金额(/元)"  field="num" >
							<next:NumberField  allowBlank="false"/>
						</next:Column>
					</next:Columns>
				</next:EditGridPanel>
				              
              <next:EditGridPanel  id="whouse_grid" name="whouse_grid"  height="150" collapsible="true" title="本成员房屋信息列表" clicksToEdit="2" dataset="SamEsureyHouseDS">
					<next:TopBar>
						<next:ToolBarItem symbol="->" ></next:ToolBarItem>
						<next:ToolBarItem iconCls="add" text="添加" handler="add_house"/>
						<next:ToolBarItem iconCls="remove" text="删除" handler="delete_house2"/>
					</next:TopBar>
					<next:Columns>
						<next:RowNumberColumn width="10"/>
						<next:RadioBoxColumn></next:RadioBoxColumn>
						<next:Column id="hId" header="流水ID"  field="id" hidden="true">
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="hType" header="信息类别"  field="type" hidden="true" >
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="hFeedbackId" header="填表Id"  field="feedbackId" hidden="true">
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="hPeopleId" header="人员Id"  field="peopleId" hidden="true">
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="houseCardNo" header="房产证号"  field="houseCardNo" >
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="houseUseage" header="房屋用途"  field="houseUseage" >
							<next:ComboBox triggerAction="all" valueField="value" displayField="text" dataset="houseUserageDataset"/>
						</next:Column>
						<next:Column id="regValuef" header="交易价值(/元)"  field="regValue" >
							<next:NumberField  allowBlank="false"/>
						</next:Column>
						<next:Column id="regDate" header="登记或交易时间"  field="regDate" >
							<next:DateTimeField allowBlank="false" format="Y-m-d"/>
						</next:Column>
						<next:Column id="businessType" header="交易性质"  field="businessType" >
							<next:ComboBox triggerAction="all" valueField="value" displayField="text" dataset="businessTypeDataset"/>
						</next:Column>
						<next:Column id="location" header="房屋坐落"  field="location" >
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="houseArea" header="建筑面积(平方米)"  field="houseArea" >
							<next:NumberField  allowBlank="false"/>
						</next:Column>
					</next:Columns>
				</next:EditGridPanel>
				
				<next:EditGridPanel  id="wbusiness_grid" name="wbusiness_grid" height="150" collapsible="true" title="本成员工商经营信息列表" clicksToEdit="2"  dataset="SamEsureyBusinessDS">
					<next:TopBar>
						<next:ToolBarItem symbol="->" ></next:ToolBarItem>
						<next:ToolBarItem iconCls="add" text="添加" handler="add_business"/>
						<next:ToolBarItem iconCls="remove" text="删除" handler="delete_business2"/>
					</next:TopBar>
					<next:Columns>
						<next:RowNumberColumn width="10"/>
						<next:RadioBoxColumn></next:RadioBoxColumn>
						<next:Column id="bId" header="流水ID"  field="id" hidden="true">
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="bType" header="信息类别"  field="type"  hidden="true">
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="bFeedbackId" header="填表Id"  field="feedbackId" hidden="true">
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="bPeopleId" header="人员Id"  field="peopleId" hidden="true">
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="businessType" header="企业注册方式"  field="businessType" >
							<next:ComboBox triggerAction="all" valueField="value" displayField="text" dataset="compBusinessTypeDataset"/>
						</next:Column>
						<next:Column id="legalPerson" header="企业法人名称"  field="legalPerson" >
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="organName" header="企业名称"  field="organName" >
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="regAdd" header="注册地址"  field="regAdd" >
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="businessAdd" header="经营地址"  field="businessAdd" >
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="regFund" header="注册资金"  field="regFund" >
							<next:NumberField allowBlank="false" />
						</next:Column>
						<next:Column id="bRegDate" header="注册时间"  field="regDate" >
							<next:DateTimeField allowBlank="false" format="Y-m-d"/>
						</next:Column>
						<next:Column id="businessScope" header="经营范围"  field="businessScope" >
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="organStatus" header="企业当前状态"  field="organStatus" >
							<next:ComboBox triggerAction="all" valueField="value" displayField="text" dataset="organDataset"/>
						</next:Column>
					</next:Columns>
				</next:EditGridPanel>
				
				<next:EditGridPanel  id="wcar_grid" name="wcar_grid" height="150"  collapsible="true" title="本成员车辆信息列表" clicksToEdit="2" dataset="SamEsureyCarDS">
					<next:TopBar>
						<next:ToolBarItem symbol="->" ></next:ToolBarItem>
						<next:ToolBarItem iconCls="add" text="添加" handler="add_car"/>
						<next:ToolBarItem iconCls="remove" text="删除" handler="delete_car2"/>
					</next:TopBar>
					<next:Columns>
						<next:RowNumberColumn width="10"/>
						<next:RadioBoxColumn></next:RadioBoxColumn>
						<next:Column id="cId" header="流水ID"  field="id" hidden="true">
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="cType" header="信息类别"  field="type"  hidden="true">
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="cFeedbackId" header="填表Id"  field="feedbackId" hidden="true">
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="cPeopleId" header="人员Id"  field="peopleId" hidden="true">
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="owner" header="车主姓名"  field="owner" >
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="carNo" header="车牌号码"  field="carNo" >
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="carType" header="车辆类型"  field="carType" >
							<next:ComboBox triggerAction="all" valueField="value" displayField="text" dataset="carTypeDS"/>
						</next:Column>
						<next:Column id="regValue" header="登记价值(/元)"  field="regValue" >
							<next:NumberField allowBlank="false"/>
						</next:Column>
						<next:Column id="cRegDate" header="登记时间"  field="regDate" >
							<next:DateTimeField allowBlank="false" format="Y-m-d"/>
						</next:Column>
						<next:Column id="carUse" header="用途"  field="carUse" >
							<next:ComboBox  triggerAction="all" valueField="value" displayField="text" dataset="carUseDataset"/>
						</next:Column>
					</next:Columns>
				</next:EditGridPanel>
				
				<next:EditGridPanel  id="wtax_grid" name="wtax_grid"  height="150"  collapsible="true" title="本成员国税信息列表" clicksToEdit="2" dataset="SamEsureyTaxDS">
					<next:TopBar>
						<next:ToolBarItem symbol="->" ></next:ToolBarItem>
						<next:ToolBarItem iconCls="add" text="添加" handler="add_tax"/>
						<next:ToolBarItem iconCls="remove" text="删除" handler="delete_tax22"/>
					</next:TopBar>
					<next:Columns>
						<next:RowNumberColumn width="10"/>
						<next:RadioBoxColumn></next:RadioBoxColumn>
						<next:Column id="tId" header="流水ID"  field="id" hidden="true">
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="tType" header="信息类别"  field="type"  hidden="true">
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="tFeedbackId" header="填表Id"  field="feedbackId" hidden="true">
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="tPeopleId" header="人员Id"  field="peopleId" hidden="true">
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="taxesType" header="纳税类型"  field="taxesType" hidden="true">
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="taxesPeople" header="纳税人姓名"  field="taxesPeople" width="15%">
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="taxesOrg" header="纳税企业名称"  field="taxesOrg" width="30%">
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="turnoverLatestYear" header="最近一年营业额(/元)"  field="turnoverLatestYear" width="20%">
							<next:NumberField allowBlank="false"/>
						</next:Column>
						<next:Column id="taxesLatestYear" header="最近一年纳税额(/元)"  field="taxesLatestYear" width="20%">
							<next:NumberField allowBlank="false"/>
						</next:Column>
					</next:Columns>
				</next:EditGridPanel>
				
				<next:EditGridPanel  id="wdtax_grid" name="wdtax_grid"  height="150"  collapsible="true" title="本成员地税信息列表" clicksToEdit="2" dataset="SamEsureyTaxDS2">
					<next:TopBar>
						<next:ToolBarItem symbol="->" ></next:ToolBarItem>
						<next:ToolBarItem iconCls="add" text="添加" handler="add_tax2"/>
						<next:ToolBarItem iconCls="remove" text="删除" handler="delete_tax22"/>
					</next:TopBar>
					<next:Columns>
						<next:RowNumberColumn width="10"/>
						<next:RadioBoxColumn></next:RadioBoxColumn>
						<next:Column id="tdId" header="流水ID"  field="id" hidden="true">
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="tdType" header="信息类别"  field="type"  hidden="true">
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="tdFeedbackId" header="填表Id"  field="feedbackId" hidden="true">
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="tdPeopleId" header="人员Id"  field="peopleId" hidden="true">
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="dtaxesType" header="纳税类型"  field="taxesType" hidden="true">
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="dtaxesPeople" header="纳税人姓名"  field="taxesPeople" width="10%">
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="dtaxesOrg" header="纳税企业名称"  field="taxesOrg" width="30%">
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="dturnoverLatestYear" header="最近一年营业额(/元)"  field="turnoverLatestYear" width="20%">
							<next:NumberField allowBlank="false"/>
						</next:Column>
						<next:Column id="dtaxesLatestYear" header="最近一年纳税额(/元)"  field="taxesLatestYear" width="20%">
							<next:NumberField allowBlank="false"/>
						</next:Column>
					</next:Columns>
				</next:EditGridPanel>
				
				<next:EditGridPanel  id="wfund_grid" name="wfund_grid"  height="150"  collapsible="true" title="本成员公积金信息列表" clicksToEdit="2" dataset="SamEsureyHousingFundDS">
					<next:TopBar>
						<next:ToolBarItem symbol="->" ></next:ToolBarItem>
						<next:ToolBarItem iconCls="add" text="添加" handler="add_fund"/>
						<next:ToolBarItem iconCls="remove" text="删除" handler="delete_fund"/>
					</next:TopBar>
					<next:Columns>
						<next:RowNumberColumn width="10"/>
						<next:RadioBoxColumn></next:RadioBoxColumn>
						<next:Column id="fId" header="流水ID"  field="id" hidden="true">
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="fType" header="信息类别"  field="type"  hidden="true">
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="fFeedbackId" header="填表Id"  field="feedbackId" hidden="true">
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="fPeopleId" header="人员Id"  field="peopleId" hidden="true">
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="fName" header="姓名"  field="name" width="10%">
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="balance" header="公积金余额(/元)"  field="balance" width="20%">
							<next:NumberField allowBlank="false"/>
						</next:Column>
						<next:Column id="collectNum" header="历史提取金额合计(/元)"  field="collectNum" width="20%">
							<next:NumberField allowBlank="false"/>
						</next:Column>
					</next:Columns>
				</next:EditGridPanel>
				
				<next:EditGridPanel  id="wbank_grid" name="wbank_grid"  height="150"  collapsible="true" title="本成员人民银行信息列表" clicksToEdit="2" dataset="SamEsureyBankDS">
					<next:TopBar>
						<next:ToolBarItem symbol="->" ></next:ToolBarItem>
						<next:ToolBarItem iconCls="add" text="添加" handler="add_bank"/>
						<next:ToolBarItem iconCls="remove" text="删除" handler="delete_bank"/>
					</next:TopBar>
					<next:Columns>
						<next:RowNumberColumn width="10"/>
						<next:RadioBoxColumn></next:RadioBoxColumn>
						<next:Column id="kId" header="流水ID"  field="id" hidden="true">
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="kType" header="信息类别"  field="type"  hidden="true">
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="kFeedbackId" header="填表Id"  field="feedbackId" hidden="true">
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="kPeopleId" header="人员Id"  field="peopleId" hidden="true">
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="accountName" header="开户人姓名"  field="accountName" >
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="totalSavings" header="存款金额合计(/元)"  field="totalSavings" >
							<next:NumberField allowBlank="false"/>
						</next:Column>
						<next:Column id="totalBond" header="债券总金额(/元)"  field="totalBond" >
							<next:NumberField allowBlank="false"/>
						</next:Column>
					</next:Columns>
				</next:EditGridPanel>
				
				<next:EditGridPanel  id="wsecurities_grid" name="wsecurities_grid"  height="150"  collapsible="true" title="本成员证监列表" clicksToEdit="2" dataset="SamEsureySecuritiesDS">
					<next:TopBar>
						<next:ToolBarItem symbol="->" ></next:ToolBarItem>
						<next:ToolBarItem iconCls="add" text="添加" handler="add_securities"/>
						<next:ToolBarItem iconCls="remove" text="删除" handler="delete_securities"/>
					</next:TopBar>
					<next:Columns>
						<next:RowNumberColumn width="10"/>
						<next:RadioBoxColumn></next:RadioBoxColumn>
						<next:Column id="eId" header="流水ID"  field="id" hidden="true">
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="eType" header="信息类别"  field="type"  hidden="true">
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="eFeedbackId" header="填表Id"  field="feedbackId" hidden="true">
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="ePeopleId" header="人员Id"  field="peopleId" hidden="true">
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="eName" header="开户人姓名"  field="name" width="10%">
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="stock" header="股票市值总金额(/元)"  field="stock" width="20%">
							<next:NumberField allowBlank="false"/>
						</next:Column>
						<next:Column id="fund" header="基金市值总金额(/元)"  field="fund" width="20%">
							<next:NumberField allowBlank="false"/>
						</next:Column>
						<next:Column id="money" header="资金总余额(/元)"  field="money" width="20%">
							<next:NumberField allowBlank="false"/>
						</next:Column>
					</next:Columns>
				</next:EditGridPanel>
				
				<next:EditGridPanel  id="winsurance_grid" name="winsurance_grid" height="200"  collapsible="true" title="本成员保险信息列表" clicksToEdit="2" dataset="SamEsureyInsuranceDS">
					<next:TopBar>
						<next:ToolBarItem symbol="->" ></next:ToolBarItem>
						<next:ToolBarItem iconCls="add" text="添加" handler="add_insurance"/>
						<next:ToolBarItem iconCls="remove" text="删除" handler="delete_insurance"/>
					</next:TopBar>
					<next:Columns>
						<next:RowNumberColumn width="10"/>
						<next:RadioBoxColumn></next:RadioBoxColumn>
						<next:Column id="iId" header="流水ID"  field="id" hidden="true">
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="iType" header="信息类别"  field="type"  hidden="true">
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="iFeedbackId" header="填表Id"  field="feedbackId" hidden="true">
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="iPeopleId" header="人员Id"  field="peopleId" hidden="true">
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="benefitPeople" header="保险受益人"  field="benefitPeople" >
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="benefitType" header="保险受益种类"  field="benefitType" >
							<next:NumberField allowBlank="false"/>
						</next:Column>
						<next:Column id="benefitDate" header="受益时间"  field="benefitDate" >
							<next:NumberField allowBlank="false"/>
						</next:Column>
						<next:Column id="benefitNum" header="保险受益金额(/元)"  field="benefitNum" >
							<next:NumberField allowBlank="false"/>
						</next:Column>
					</next:Columns>
				</next:EditGridPanel>
				</next:Panel>
				</next:FitLayout>
                </next:Panel>
           </next:Tabs>
       </next:TabPanel>
    </next:FitLayout>
</next:Window>

<next:Window id="family_help" title="帮助信息"  width="410" height="370" collapsible="true" closeAction="hide" animCollapse="true" resizable="true">
	<next:Panel id="backfill_panel"  autoWidth="true" autoHeight="true" collapsible="true" autoScroll="true">
		<next:TopBar>
			<next:ToolBarItem symbol="->"></next:ToolBarItem>
			<next:ToolBarItem iconCls="add" text="确定" handler="add_Family"/>
			<next:ToolBarItem iconCls="undo" text="关闭" handler="close_win"/>
		</next:TopBar>
	<next:GridPanel id="base_family" name="base_family" autoWidth="true" height="160" disableSelection="true" title="困难户家庭" stripeRows="true" notSelectFirstRow="true" collapsible="true"  autoScroll="true" dataset="baseFamilyDS">
				<next:Columns>		
					<next:CheckBoxColumn></next:CheckBoxColumn>	 
					<next:Column id="bfamilyId" header="家庭Id" field="familyId" hidden="true" width="10%" >
					</next:Column>
					<next:Column id="bfamilyName" header="户主姓名" field="familyName"   width="9%"  >
					</next:Column>
					<next:Column id="bfamilyCardNo" header="身份证号" field="familyCardNo" width="20%" >
					</next:Column>
					<next:Column id="bregTime" header="录入时间" field="regTime" width="20%"  >
					</next:Column>		
				</next:Columns> 
				<next:BottomBar>
					<next:PagingToolBar dataset="baseFamilyDS"/>
				</next:BottomBar>
		</next:GridPanel>
		<next:GridPanel id="esurey_family" name="esurey_family" autoWidth="true" height="160" disableSelection="true" title="经济核对家庭" stripeRows="true" notSelectFirstRow="true" collapsible="true"  autoScroll="true" dataset="esureyFamilyDS3">
				<next:Columns>		
					<next:CheckBoxColumn></next:CheckBoxColumn>		 
					<next:Column id="efamilyId" header="家庭Id" field="familyId" hidden="true" width="10%" >
					</next:Column>
					<next:Column id="efamilyName" header="户主姓名" field="familyName"   width="9%"  >
					</next:Column>
					<next:Column id="efamilyCardNo" header="身份证号" field="familyCardNo" width="20%" >
					</next:Column>
					<next:Column id="eregTime" header="录入时间" field="regTime" width="20%"  >
					</next:Column>		
				</next:Columns> 
				<next:BottomBar>
					<next:PagingToolBar dataset="esureyFamilyDS3"/>
				</next:BottomBar>
		</next:GridPanel>
		</next:Panel>
</next:Window>
</body>
</html>
