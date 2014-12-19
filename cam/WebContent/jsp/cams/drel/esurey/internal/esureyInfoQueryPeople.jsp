<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<html>
<head>
	<next:ScriptManager/>
	<script type="text/javascript" src="esureyInfoQueryPeople.js"></script>		
	<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js") %>'></script>
	<script type="text/javascript">
			var familyId='<%=request.getParameter("familyId")%>';
			var peopleId='<%=request.getParameter("peopleId")%>';
			var isSup='<%=request.getParameter("isSup")%>';
	</script>
</head>
<body>
<model:datasets>
<!--申报家庭成员基本信息-->
	<model:dataset id="esureyPeopleDS" cmd="com.inspur.cams.drel.esurey.cmd.SamEsureyPeopleQueryCmd" method="queryPeopleById" pageSize="10">
	</model:dataset>
	<!--申报家庭成员社保基本信息-->
	<model:dataset id="SamEsureySocialDS" cmd="com.inspur.cams.drel.esurey.cmd.SamEsureySocialQueryCmd">
		<model:record fromBean="com.inspur.cams.drel.esurey.data.SamEsureySocial"></model:record>
	</model:dataset>
<!--申报家庭成员财产收入基本信息-->
	<model:dataset id="SamEsureyPeopleEstateDS" cmd="com.inspur.cams.drel.esurey.cmd.SamEsureyPeopleEstateQueryCmd">
		<model:record fromBean="com.inspur.cams.drel.esurey.data.SamEsureyPeopleEstate"></model:record>
	</model:dataset>	
<!--申报家庭成收入信息-->
	<model:dataset id="SamEsureyFamilyIncomeDS" cmd="com.inspur.cams.drel.esurey.cmd.SamEsureyPeopleEstateQueryCmd" method="queryFamilyIncome">
	</model:dataset>		
<!--申报家庭成员房管基本信息-->
	<model:dataset id="SamEsureyHouseDS" cmd="com.inspur.cams.drel.esurey.cmd.SamEsureyHouseQueryCmd">
		<model:record fromBean="com.inspur.cams.drel.esurey.data.SamEsureyHouse"></model:record>
	</model:dataset>
<!--申报家庭成员工商基本信息-->
	<model:dataset id="SamEsureyBusinessDS" cmd="com.inspur.cams.drel.esurey.cmd.SamEsureyBusinessQueryCmd">
		<model:record fromBean="com.inspur.cams.drel.esurey.data.SamEsureyBusiness"></model:record>
	</model:dataset>
<!--申报家庭成员车管基本信息-->
	<model:dataset id="SamEsureyCarDS" cmd="com.inspur.cams.drel.esurey.cmd.SamEsureyCarQueryCmd">
		<model:record fromBean="com.inspur.cams.drel.esurey.data.SamEsureyCar"></model:record>
	</model:dataset>
<!--申报家庭成员国税地税基本信息-->
	<model:dataset id="SamEsureyTaxDS" cmd="com.inspur.cams.drel.esurey.cmd.SamEsureyTaxQueryCmd">
		<model:record fromBean="com.inspur.cams.drel.esurey.data.SamEsureyTax"></model:record>
	</model:dataset>
<!--申报家庭成员地税基本信息-->
	<model:dataset id="SamEsureyTaxDS2" cmd="com.inspur.cams.drel.esurey.cmd.SamEsureyTaxQueryCmd">
		<model:record fromBean="com.inspur.cams.drel.esurey.data.SamEsureyTax"></model:record>
	</model:dataset>
<!--申报家庭成员公积金基本信息-->
	<model:dataset id="SamEsureyHousingFundDS" cmd="com.inspur.cams.drel.esurey.cmd.SamEsureyHousingFundQueryCmd">
		<model:record fromBean="com.inspur.cams.drel.esurey.data.SamEsureyHousingFund"></model:record>
	</model:dataset>
<!--申报家庭成员人行基本信息-->
	<model:dataset id="SamEsureyBankDS" cmd="com.inspur.cams.drel.esurey.cmd.SamEsureyBankQueryCmd">
		<model:record fromBean="com.inspur.cams.drel.esurey.data.SamEsureyBank"></model:record>
	</model:dataset>	
<!--申报家庭成员证监基本信息-->
	<model:dataset id="SamEsureySecuritiesDS" cmd="com.inspur.cams.drel.esurey.cmd.SamEsureySecuritiesQueryCmd">
		<model:record fromBean="com.inspur.cams.drel.esurey.data.SamEsureySecurities"></model:record>
	</model:dataset>
<!--申报家庭成员保监基本信息-->
	<model:dataset id="SamEsureyInsuranceDS" cmd="com.inspur.cams.drel.esurey.cmd.SamEsureyInsuranceQueryCmd">
		<model:record fromBean="com.inspur.cams.drel.esurey.data.SamEsureyInsurance"></model:record>
	</model:dataset>	
	<!--申报家庭成员社保基本信息-->
	<model:dataset id="SamEsureySocialExtDS" cmd="com.inspur.cams.drel.esurey.cmd.SamEsureySocialQueryCmd">
		<model:record fromBean="com.inspur.cams.drel.esurey.data.SamEsureySocial"></model:record>
	</model:dataset>
<!--申报家庭成员财产收入基本信息-->
	<model:dataset id="SamEsureyPeopleEstateExtDS" cmd="com.inspur.cams.drel.esurey.cmd.SamEsureyPeopleEstateQueryCmd">
		<model:record fromBean="com.inspur.cams.drel.esurey.data.SamEsureyPeopleEstate"></model:record>
	</model:dataset>		
<!--申报家庭成员房管基本信息-->
	<model:dataset id="SamEsureyHouseExtDS" cmd="com.inspur.cams.drel.esurey.cmd.SamEsureyHouseQueryCmd">
		<model:record fromBean="com.inspur.cams.drel.esurey.data.SamEsureyHouse"></model:record>
	</model:dataset>
<!--申报家庭成员工商基本信息-->
	<model:dataset id="SamEsureyBusinessExtDS" cmd="com.inspur.cams.drel.esurey.cmd.SamEsureyBusinessQueryCmd">
		<model:record fromBean="com.inspur.cams.drel.esurey.data.SamEsureyBusiness"></model:record>
	</model:dataset>
<!--申报家庭成员车管基本信息-->
	<model:dataset id="SamEsureyCarExtDS" cmd="com.inspur.cams.drel.esurey.cmd.SamEsureyCarQueryCmd">
		<model:record fromBean="com.inspur.cams.drel.esurey.data.SamEsureyCar"></model:record>
	</model:dataset>
<!--申报家庭成员国税地税基本信息-->
	<model:dataset id="SamEsureyTaxExtDS" cmd="com.inspur.cams.drel.esurey.cmd.SamEsureyTaxQueryCmd">
		<model:record fromBean="com.inspur.cams.drel.esurey.data.SamEsureyTax"></model:record>
	</model:dataset>
<!--申报家庭成员地税基本信息-->
	<model:dataset id="SamEsureyTaxExtDS2" cmd="com.inspur.cams.drel.esurey.cmd.SamEsureyTaxQueryCmd">
		<model:record fromBean="com.inspur.cams.drel.esurey.data.SamEsureyTax"></model:record>
	</model:dataset>
<!--申报家庭成员公积金基本信息-->
	<model:dataset id="SamEsureyHousingFundExtDS" cmd="com.inspur.cams.drel.esurey.cmd.SamEsureyHousingFundQueryCmd">
		<model:record fromBean="com.inspur.cams.drel.esurey.data.SamEsureyHousingFund"></model:record>
	</model:dataset>
<!--申报家庭成员人行基本信息-->
	<model:dataset id="SamEsureyBankExtDS" cmd="com.inspur.cams.drel.esurey.cmd.SamEsureyBankQueryCmd">
		<model:record fromBean="com.inspur.cams.drel.esurey.data.SamEsureyBank"></model:record>
	</model:dataset>	
<!--申报家庭成员证监基本信息-->
	<model:dataset id="SamEsureySecuritiesExtDS" cmd="com.inspur.cams.drel.esurey.cmd.SamEsureySecuritiesQueryCmd">
		<model:record fromBean="com.inspur.cams.drel.esurey.data.SamEsureySecurities"></model:record>
	</model:dataset>
<!--申报家庭成员保监基本信息-->
	<model:dataset id="SamEsureyInsuranceExtDS" cmd="com.inspur.cams.drel.esurey.cmd.SamEsureyInsuranceQueryCmd">
		<model:record fromBean="com.inspur.cams.drel.esurey.data.SamEsureyInsurance"></model:record>
	</model:dataset>	
<!--经济核对_家庭经济状况审核汇总-->
	<model:dataset id="SamEsureyFamilySumDS" cmd="com.inspur.cams.drel.esurey.cmd.SamEsureyFamilySumQueryCmd">
		<model:record fromBean="com.inspur.cams.drel.esurey.data.SamEsureyFamilySum"></model:record>
	</model:dataset>	
<!-- 人员汇总-->
<!--经济核对_家庭经济状况审核汇总-->
	<model:dataset id="SamEsureyPeopleSumDS" cmd="com.inspur.cams.drel.esurey.cmd.SamEsureyPeopleSumQueryCmd">
		<model:record fromBean="com.inspur.cams.drel.esurey.data.SamEsureyPeopleSum"></model:record>
	</model:dataset>	
	
<!--是否为赡养义务人员-->	
	<model:dataset id="isSupportDS" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>	
	<!-- 与户主关系 -->
	<model:dataset id="RelationDS" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_RELATIONSHIP_TYPE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 性别 -->	
	<model:dataset id="sexDS"  enumName="COMM.SEX" autoLoad="true" global="ture"></model:dataset>
<!-- 民族代码-->
	<model:dataset id="DmMzDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_NATION'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 家庭性质 -->
	<model:dataset id="familyTypeDS" enumName="FAMILY_TYPE" autoLoad="true"  global="true"></model:dataset>	
	<!-- 救助类型 -->	
	<model:dataset id="assistanceTypeDS" enumName="ASSISTANCE_TYPE"  autoLoad="true" global="true"></model:dataset>	
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
<next:Panel id="jtjbxxPanel" width="100%" height="100%" title="人员核对信息" >
			<next:TopBar>
				<next:ToolBarItem symbol="->"></next:ToolBarItem>
				<next:ToolBarItem iconCls="undo" text="返回" handler="return_list"/>				
				<next:ToolBarItem symbol=""></next:ToolBarItem>
				<next:ToolBarItem symbol=""></next:ToolBarItem>
			</next:TopBar>		
<next:FitLayout>
       <next:TabPanel id="jtcyTabpanel" activeTab="2" border="false" >
           <next:Tabs>
<!--	成员基本信息	-->
              <next:Panel title="成员基本信息">
                  <next:Html>
                  	<form id="cyjbxxForm" method="post" onsubmit="return false" style="padding: 5px;"  dataset="esureyPeopleDS"
						class="L5form" >
						<table border="0"  width="99%">
							<tr id="sup_tr" style="display:none">		
								<td class="FieldLabel">是否为赡（抚、扶）养义务人员：</td>
								<td class="FieldInput" colspan="3">
									<label id="isSupport"  field="IS_SUPPORT" dataset="isSupportDS"/>
								</td>
							</tr>	
					  		<tr >
								<td class="FieldLabel" width="20%">姓名:</td>
								<td class="FieldInput" width="30%">
									<label id="name" name="姓名:" field="NAME"  ></label>
								</td>	
								<td class="FieldLabel" width="20%">与户主关系:</td>
								<td class="FieldInput" width="30%">
									<label name="与户主关系:" id="relationshipType" field="RELATIONSHIP_TYPE" dataset="RelationDS" ></label>
								</td>		
							</tr>
					  		<tr >	
								<td class="FieldLabel" >身份证号:</td>
								<td class="FieldInput">
									<label name="身份证号:" id="idCard" field="ID_CARD" ></label>
								</td>
								<td class="FieldLabel">性别:</td>
								<td class="FieldInput">
									<label  name="性别" field="SEX"  dataset="sexDS"/>
									
								</td>		
							</tr>
					  		<tr >			
								<td class="FieldLabel">民族:</td>
								<td class="FieldInput">
									<label name="民族:" id="nation" field="NATION" dataset="DmMzDataSet" ></label>
								</td>	
								<td class="FieldLabel">文化程度:</td>
								<td class="FieldInput">
									<label name="文化程度:" id="eduCode" field="EDU_CODE"  dataset="DmJyzkDataSet"/>
								</td>		
							</tr>
					  		<tr >		
								<td class="FieldLabel">健康状况:</td>
								<td class="FieldInput">
									<label name="健康状况:" id="healthCode" field="HEALTH_CODE" dataset="healthDS" ></label>
								</td>
								<td class="FieldLabel">婚姻状况:</td>
								<td class="FieldInput">
									<label name="婚姻状况:" id="marriageCode" field="MARRIAGE_CODE"  dataset="DmHyzkDataSet"></label>
								</td>	
							</tr>
					  		<tr >		
								<td class="FieldLabel">职业:</td>
								<td class="FieldInput">
									<label name="职业:"  id="careerCode" field="CAREER_CODE" dataset="DmZyDataSet" ></label>
								</td>
								<td class="FieldLabel">政治面貌:</td>
								<td class="FieldInput">
									<label name="政治面貌:" id="politicalCode" field="POLITICAL_CODE"  dataset="politicsDS"></label>
								</td>	
							</tr>	
					  		<tr >		
								<td class="FieldLabel">户口性质:</td>
								<td class="FieldInput" colspan="3">
									<label  name="户口性质" id="domicileType" field="DOMICILE_TYPE"  dataset="familyTypeDS"/>
									
								</td>
							</tr>	
					  		<tr >		
								<td class="FieldLabel">年收入:</td>
								<td class="FieldInput">
									<label name="年收入:"  field="INCOME_YEAR"  ></label>
								</td>
								<td class="FieldLabel">月收入:</td>
								<td class="FieldInput">
									<label name="月收入:" field="INCOME_MONTH"  ></label>
								</td>	
							</tr>
							<tr >		
								<td class="FieldLabel">年收入（根据外部单位填报信息计算）:</td>
								<td class="FieldInput">
									<label name="年收入:" id="SUM_INCOME_YEAR" field="SUM_INCOME_YEAR"  ></label>
								</td>
								<td class="FieldLabel">月收入（根据外部单位填报信息计算）:</td>
								<td class="FieldInput">
									<label  name="月收入:" id="SUM_INCOME_MONTH" field="SUM_INCOME_MONTH"></label>
								</td>	
							</tr>		
						</table>
					</form>
                  </next:Html>
              </next:Panel>
		
<!--	成员经济状况信息	-->
              <next:Panel title="本成员申报经济状况信息" >
              <next:Panel >
                  <next:Html>
                  	<form id="cyjjzkxxForm" method="post" onsubmit="return false" style="padding: 5px;" 
						class="L5form" >
						<table border="0"  width="99%" height="100%">
					  		<tr >
								<td class="FieldLabel" width="20%">姓名:</td>
								<td class="FieldInput" width="30%">
									<label id="cyName"  />
								</td>	
								<td class="FieldLabel" width="20%">身份证号:</td>
								<td class="FieldInput" width="30%">
									<label id="cyIdCard"  />
								</td>
							</tr>
						</table>
					</form>
                  </next:Html>
              </next:Panel>
             <next:Panel   width="100%" height="100%"  autoScroll="true">
				<next:GridPanel  id="social_grid" name="social_grid" width="99%" height="200" title="社保列表"  dataset="SamEsureySocialDS">
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
						<next:Column id="hsYearMonth" header="年月区分标志"  field="yearMonth" >
							<next:ComboBox triggerAction="all" valueField="value" displayField="text" dataset="ymDS"/>
						</next:Column>
						<next:Column id="hsSalaryType" header="工资类别"  field="salaryType" >
							<next:ComboBox triggerAction="all" valueField="value" displayField="text" dataset="salaryDS"/>
						</next:Column>
						<next:Column id="hsSalary" header="工资、养老金金额"  field="salary" >
							<next:NumberField allowBlank="false"/>
						</next:Column>
						<next:Column id="hsPension" header="养老金缴纳金额"  field="pension" >
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="hsPensionBalance" header="养老金余额"  field="pensionBalance" >
							<next:TextField allowBlank="false"/>
						</next:Column>
					</next:Columns>
				</next:GridPanel>
				
				<next:GridPanel  id="estate_grid" name="estate_grid" width="99%" height="200" title="其他财产收入" dataset="SamEsureyPeopleEstateDS">
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
						<next:Column id="hperiod" header="年月区分标志"  field="period" >
							<next:ComboBox triggerAction="all" valueField="value" displayField="text" dataset="ymDS"/>
						</next:Column>
						<next:Column id="hitem" header="财产、收入类别"  field="item" >
							<next:ComboBox triggerAction="all" valueField="value" displayField="text" dataset="itemDS"/>
						</next:Column>
						<next:Column id="hnum" header="金额"  field="num" >
							<next:NumberField  allowBlank="false"/>
						</next:Column>
					</next:Columns>
				</next:GridPanel>
				              
              <next:GridPanel  id="house_grid" name="house_grid" width="99%" height="200" title="房屋信息"  dataset="SamEsureyHouseDS">
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
						<next:Column id="hhregValue" header="交易价值(元)"  field="regValue" >
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
						<next:Column id="hhouseArea" header="建筑面积(平米)"  field="houseArea" >
							<next:NumberField allowBlank="false"/>
						</next:Column>
					</next:Columns>
				</next:GridPanel>
				
				<next:GridPanel  id="business_grid" name="business_grid" width="99%" height="200" title="工商经营信息"  dataset="SamEsureyBusinessDS">
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
						<next:Column id="hregFund" header="注册资金"  field="regFund" >
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
				</next:GridPanel>
				
				<next:GridPanel  id="car_grid" name="car_grid" width="99%" height="200" title="车辆信息" dataset="SamEsureyCarDS">
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
						<next:Column id="hregValue" header="登记价值(元)"  field="regValue" >
							<next:NumberField allowBlank="false"/>
						</next:Column>
						<next:Column id="hcRegDate" header="登记时间"  field="regDate" >
							<next:DateTimeField allowBlank="false" format="Y-m-d"/>
						</next:Column>
						<next:Column id="hcarUse" header="用途"  field="carUse" >
							<next:ComboBox  triggerAction="all" valueField="value" displayField="text" dataset="carUseDataset"/>
						</next:Column>
					</next:Columns>
				</next:GridPanel>
				
				<next:GridPanel  id="tax_grid" name="tax_grid" width="99%" height="200" title="国税信息"  dataset="SamEsureyTaxDS">
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
						<next:Column id="htaxesPeople" header="纳税人姓名"  field="taxesPeople" >
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="htaxesOrg" header="纳税企业名称"  field="taxesOrg" >
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="hturnoverLatestYear" header="最近一年营业额"  field="turnoverLatestYear" >
							<next:NumberField allowBlank="false"/>
						</next:Column>
						<next:Column id="htaxesLatestYear" header="最近一年纳税额"  field="taxesLatestYear" >
							<next:NumberField allowBlank="false"/>
						</next:Column>
					</next:Columns>
				</next:GridPanel>
				
				<next:GridPanel  id="tax2_grid" name="tax2_grid" width="99%" height="200" title="地税信息"  dataset="SamEsureyTaxDS2">
					<next:Columns>
						<next:RowNumberColumn width="10"/>
						<next:RadioBoxColumn></next:RadioBoxColumn>
						<next:Column id="htId2" header="流水ID"  field="id" hidden="true">
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="htType2" header="信息类别"  field="type"  hidden="true">
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="htFeedbackId2" header="填表Id"  field="feedbackId" hidden="true">
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="htPeopleId2" header="人员Id"  field="peopleId" hidden="true">
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="htaxesType2" header="纳税类型"  field="taxesType" hidden="true">
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="htaxesPeople2" header="纳税人姓名"  field="taxesPeople" >
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="htaxesOrg2" header="纳税企业名称"  field="taxesOrg" >
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="hturnoverLatestYear2" header="最近一年营业额"  field="turnoverLatestYear" >
							<next:NumberField allowBlank="false"/>
						</next:Column>
						<next:Column id="htaxesLatestYear2" header="最近一年纳税额"  field="taxesLatestYear" >
							<next:NumberField allowBlank="false"/>
						</next:Column>
					</next:Columns>
				</next:GridPanel>
				
				<next:GridPanel  id="fund_grid" name="fund_grid" width="99%" height="200" title="公积金信息" dataset="SamEsureyHousingFundDS">
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
						<next:Column id="hfName" header="姓名"  field="name" >
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="hbalance" header="公积金余额"  field="balance" >
							<next:NumberField allowBlank="false"/>
						</next:Column>
						<next:Column id="hcollectNum" header="历史提取金额合计"  field="collectNum" >
							<next:NumberField allowBlank="false"/>
						</next:Column>
					</next:Columns>
				</next:GridPanel>
				
				<next:GridPanel  id="bank_grid" name="bank_grid" width="99%" height="200" title="人民银行信息" dataset="SamEsureyBankDS">
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
						<next:Column id="htotalSavings" header="存款金额合计"  field="totalSavings" >
							<next:NumberField allowBlank="false"/>
						</next:Column>
						<next:Column id="htotalBond" header="债券总金额"  field="totalBond" >
							<next:NumberField allowBlank="false"/>
						</next:Column>
					</next:Columns>
				</next:GridPanel>
				
				<next:GridPanel  id="securities_grid" name="securities_grid" width="99%" height="200" title="证监信息"  dataset="SamEsureySecuritiesDS">
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
						<next:Column id="heName" header="开户人姓名"  field="name" >
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="hstock" header="股票市值总金额"  field="stock" >
							<next:NumberField allowBlank="false"/>
						</next:Column>
						<next:Column id="hfund" header="基金市值总金额"  field="fund" >
							<next:NumberField allowBlank="false"/>
						</next:Column>
						<next:Column id="hmoney" header="资金总余额"  field="money" >
							<next:NumberField allowBlank="false"/>
						</next:Column>
					</next:Columns>
				</next:GridPanel>
				
				<next:GridPanel  id="insurance_grid" name="insurance_grid" width="99%" height="200" title="保险信息" dataset="SamEsureyInsuranceDS">
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
						<next:Column id="hbenefitNum" header="保险受益金额(元)"  field="benefitNum" >
							<next:NumberField allowBlank="false"/>
						</next:Column>
					</next:Columns>
				</next:GridPanel>
				</next:Panel>
                </next:Panel>
			<next:Panel title="核对填报经济状况信息" >
              <next:Panel >
                  <next:Html>
                  	<form id="cyjjzkxxFormExt" method="post" onsubmit="return false" style="padding: 5px;" 
						class="L5form" >
						<table border="0"  width="99%" height="100%">
					  		<tr >
								<td class="FieldLabel" width="20%">姓名:</td>
								<td class="FieldInput" width="30%">
									<label id="excyName"  />
								</td>	
								<td class="FieldLabel" width="20%">身份证号:</td>
								<td class="FieldInput" width="30%">
									<label id="excyIdCard"  />
								</td>
							</tr>
						</table>
					</form>
                  </next:Html>
              </next:Panel>
             <next:Panel   width="100%" height="100%"  autoScroll="true">
				<next:GridPanel  id="social_gridExt" name="social_gridExt" width="99%" height="200" title="社保信息" dataset="SamEsureySocialExtDS">
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
						<next:Column id="hsYearMonth" header="年月区分标志"  field="yearMonth" >
							<next:ComboBox triggerAction="all" valueField="value" displayField="text" dataset="ymDS"/>
						</next:Column>
						<next:Column id="hsSalaryType" header="工资类别"  field="salaryType" >
							<next:ComboBox triggerAction="all" valueField="value" displayField="text" dataset="salaryDS"/>
						</next:Column>
						<next:Column id="hsSalary" header="工资、养老金金额"  field="salary" >
							<next:NumberField allowBlank="false"/>
						</next:Column>
						<next:Column id="hsPension" header="养老金缴纳金额"  field="pension" >
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="hsPensionBalance" header="养老金余额"  field="pensionBalance" >
							<next:TextField allowBlank="false"/>
						</next:Column>
					</next:Columns>
				</next:GridPanel>
				
              <next:GridPanel  id="house_gridExt" name="house_gridExt" width="99%" height="200" title="房屋信息" dataset="SamEsureyHouseExtDS">
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
						<next:Column id="hhregValue" header="交易价值(元)"  field="regValue" >
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
						<next:Column id="hhouseArea" header="建筑面积(平米)"  field="houseArea" >
							<next:NumberField allowBlank="false"/>
						</next:Column>
					</next:Columns>
				</next:GridPanel>
				
				<next:GridPanel  id="business_gridExt" name="business_gridExt" width="99%" height="200" title="工商经营信息"  dataset="SamEsureyBusinessExtDS">
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
						<next:Column id="hregFund" header="注册资金"  field="regFund" >
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
				</next:GridPanel>
				
				<next:GridPanel  id="car_gridExt" name="car_gridExt" width="99%" height="200" title="车辆信息" dataset="SamEsureyCarExtDS">
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
						<next:Column id="hregValue" header="登记价值(元)"  field="regValue" >
							<next:NumberField allowBlank="false"/>
						</next:Column>
						<next:Column id="hcRegDate" header="登记时间"  field="regDate" >
							<next:DateTimeField allowBlank="false" format="Y-m-d"/>
						</next:Column>
						<next:Column id="hcarUse" header="用途"  field="carUse" >
							<next:ComboBox  triggerAction="all" valueField="value" displayField="text" dataset="carUseDataset"/>
						</next:Column>
					</next:Columns>
				</next:GridPanel>
				
				<next:GridPanel  id="tax_gridExt" name="tax_gridExt" width="99%" height="200" title="国税信息" dataset="SamEsureyTaxExtDS">
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
						<next:Column id="haxesPeoplex" header="纳税人姓名"  field="taxesPeople" >
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="haxesOrgx" header="纳税企业名称"  field="taxesOrg" >
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="hurnoverLatestYearx" header="最近一年营业额"  field="turnoverLatestYear" >
							<next:NumberField allowBlank="false"/>
						</next:Column>
						<next:Column id="haxesLatestYearx" header="最近一年纳税额"  field="taxesLatestYear" >
							<next:NumberField allowBlank="false"/>
						</next:Column>
					</next:Columns>
				</next:GridPanel>
				
				
				<next:GridPanel  id="tax2_gridExt" name="tax2_gridExt" width="99%" height="200" title="地税信息" dataset="SamEsureyTaxExtDS2">
					<next:Columns>
						<next:RowNumberColumn width="10"/>
						<next:RadioBoxColumn></next:RadioBoxColumn>
						<next:Column id="hIdx2" header="流水ID"  field="id" hidden="true">
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="hTypex2" header="信息类别"  field="type"  hidden="true">
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="hFeedbackIdx2" header="填表Id"  field="feedbackId" hidden="true">
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="hPeopleIdx2" header="人员Id"  field="peopleId" hidden="true">
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="haxesTypex2" header="纳税类型"  field="taxesType" hidden="true" >
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="haxesPeoplex2" header="纳税人姓名"  field="taxesPeople" >
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="haxesOrgx2" header="纳税企业名称"  field="taxesOrg" >
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="hurnoverLatestYearx2" header="最近一年营业额"  field="turnoverLatestYear" >
							<next:NumberField allowBlank="false"/>
						</next:Column>
						<next:Column id="haxesLatestYearx2" header="最近一年纳税额"  field="taxesLatestYear" >
							<next:NumberField allowBlank="false"/>
						</next:Column>
					</next:Columns>
				</next:GridPanel>
				
				<next:GridPanel  id="fund_gridExt" name="fund_gridExt" width="99%" height="200" title="公积金信息" dataset="SamEsureyHousingFundExtDS">
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
						<next:Column id="hfName" header="姓名"  field="name" >
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="hbalance" header="公积金余额"  field="balance" >
							<next:NumberField allowBlank="false"/>
						</next:Column>
						<next:Column id="hcollectNum" header="历史提取金额合计"  field="collectNum" >
							<next:NumberField allowBlank="false"/>
						</next:Column>
					</next:Columns>
				</next:GridPanel>
				
				<next:GridPanel  id="bank_gridExt" name="bank_gridExt" width="99%" height="200" title="人民银行信息" dataset="SamEsureyBankExtDS">
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
						<next:Column id="htotalSavings" header="存款金额合计"  field="totalSavings" >
							<next:NumberField allowBlank="false"/>
						</next:Column>
						<next:Column id="htotalBond" header="债券总金额"  field="totalBond" >
							<next:NumberField allowBlank="false"/>
						</next:Column>
					</next:Columns>
				</next:GridPanel>
				
				<next:GridPanel  id="securities_gridExt" name="securities_gridExt" width="99%" height="200" title="证监信息"  dataset="SamEsureySecuritiesExtDS">
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
						<next:Column id="heName" header="开户人姓名"  field="name" >
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="hstock" header="股票市值总金额"  field="stock" >
							<next:NumberField allowBlank="false"/>
						</next:Column>
						<next:Column id="hfund" header="基金市值总金额"  field="fund" >
							<next:NumberField allowBlank="false"/>
						</next:Column>
						<next:Column id="hmoney" header="资金总余额"  field="money" >
							<next:NumberField allowBlank="false"/>
						</next:Column>
					</next:Columns>
				</next:GridPanel>
				
				<next:GridPanel  id="insurance_gridExt" name="insurance_gridExt" width="99%" height="200" title="保险信息"  dataset="SamEsureyInsuranceExtDS">
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
						<next:Column id="hbenefitNum" header="保险受益金额(元)"  field="benefitNum" >
							<next:NumberField allowBlank="false"/>
						</next:Column>
					</next:Columns>
				</next:GridPanel>
				</next:Panel>
                </next:Panel>
           </next:Tabs>
       </next:TabPanel>
    </next:FitLayout>
</next:Panel>	
</body>
</html>