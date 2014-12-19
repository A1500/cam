<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<html>
<head>
	<title>城乡居民家庭经济状况申报列表</title>
	<next:ScriptManager/>
	<script type="text/javascript" src="esureyInfoSupDetail.js"></script>		
	<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js") %>'></script>
	<script type="text/javascript">
			var supfamilyId='<%=request.getParameter("supfamilyId")%>';
			var familyId='<%=request.getParameter("familyId")%>';
			var method='<%=request.getParameter("method")%>';
	</script>
</head>
<body>
<model:datasets>
<!--申报家庭基本信息-->
	<model:dataset id="esureyFamilyDS" cmd="com.inspur.cams.drel.esurey.cmd.SamEsureyFamilyQueryCmd">
		<model:record fromBean="com.inspur.cams.drel.esurey.data.SamEsureyFamily">
			<model:field name="domicileName" type="string"/>
      		<model:field name="apanageName" type="string"/>
		</model:record>
	</model:dataset>
<!--申报家庭成员基本信息-->
	<model:dataset id="esureyPeopleDS" cmd="com.inspur.cams.drel.esurey.cmd.SamEsureyPeopleQueryCmd">
		<model:record fromBean="com.inspur.cams.drel.esurey.data.SamEsureyPeople"></model:record>
	</model:dataset>	
<!--申报家庭成员基本信息-->
	<model:dataset id="esureyPeopleDS2" cmd="com.inspur.cams.drel.esurey.cmd.SamEsureyPeopleQueryCmd">
		<model:record fromBean="com.inspur.cams.drel.esurey.data.SamEsureyPeople"></model:record>
	</model:dataset>
<!--申报信息_抚养关系-->
	<model:dataset id="esureyRelationDS" cmd="com.inspur.cams.drel.esurey.cmd.SamEsureyRelationQueryCmd">
		<model:record fromBean="com.inspur.cams.drel.esurey.data.SamEsureyRelation"></model:record>
	</model:dataset>
<!--申报家庭成员社保基本信息-->
	<model:dataset id="SamEsureySocialDS" cmd="com.inspur.cams.drel.esurey.cmd.SamEsureySocialQueryCmd">
		<model:record fromBean="com.inspur.cams.drel.esurey.data.SamEsureySocial"></model:record>
	</model:dataset>
<!--申报家庭成员财产收入基本信息-->
	<model:dataset id="SamEsureyPeopleEstateDS" cmd="com.inspur.cams.drel.esurey.cmd.SamEsureyPeopleEstateQueryCmd">
		<model:record fromBean="com.inspur.cams.drel.esurey.data.SamEsureyPeopleEstate"></model:record>
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
<!--申报家庭成员国税基本信息-->
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
<!-- 家庭性质 -->
	<model:dataset id="familyTypeDS" enumName="FAMILY_TYPE" autoLoad="true"  global="true"></model:dataset>	
<!-- 救助类型 -->	
	<model:dataset id="assistanceTypeDS" enumName="ASSISTANCE_TYPE"  autoLoad="true" global="true"></model:dataset>	
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
	<next:Panel name="fit-div" width="100%" height="100%"  title="赡（扶、抚）养家庭基本信息">
			<next:TopBar>
				<next:ToolBarItem symbol="->"></next:ToolBarItem>
				<next:ToolBarItem iconCls="undo" text="返回" handler="return_list"/>
			</next:TopBar>
	<next:FitLayout>
     <next:Panel id="supFamilyPanel" width="100%" height="100%" collapsible="true" autoScroll="true">
     		<next:Panel autoWidth="true"  autoHeight="true" collapsible="true">
			<next:Html>
				<form id="supFamilyForm" method="post" onsubmit="return false"  dataset="esureyFamilyDS"
					class="L5form" >
					<table border="0"  width="100%" >
				  		<tr >
							<td class="FieldLabel" colspan="2">户主姓名:</td>
							<td class="FieldInput">
								<label id="supfamilyName" name="户主姓名:" field="familyName"  ></label>
							</td>	
							<td class="FieldLabel" colspan="2">身份证号:</td>
							<td class="FieldInput">
								<label id="supfamilyCardNo" name="身份证号:" field="familyCardNo"   ></label>
							</td>		
						</tr>
				  		<tr >	
							<td class="FieldLabel" colspan="2">家庭人口数量:</td>
							<td class="FieldInput">
								<label id="suppeopleNum" name="家庭人口数量" field="peopleNum"  ></label>
							</td>
							<td class="FieldLabel" colspan="2">家庭性质:</td>
							<td class="FieldInput">
								<label id="supdomicileType" name="家庭性质:" field="domicileType" dataset="familyTypeDS"></label>
							</td>		
						</tr>
				  		<tr >			
							<td class="FieldLabel" colspan="2">救助类型:</td>
							<td class="FieldInput">
								<label name="救助类型" field="assistanceType" dataset="assistanceTypeDS"></label>
							</td>	
							<td class="FieldLabel" colspan="2">邮政编码:</td>
							<td class="FieldInput">
								<label id="supfamilyPostcode" name="邮政编码: " field="familyPostcode"  ></label>
							</td>		
						</tr>
				  		<tr >		
							<td class="FieldLabel" colspan="2">户籍行政区划:</td>
							<td class="FieldInput">
								<label id="supregAddress"  field="domicileName"  ></label>
							</td>
							<td class="FieldLabel" colspan="2">属地行政区划:</td>
							<td class="FieldInput">
								<label id="supfamilyAddress" field="apanageName"  ></label>
							</td>	
						</tr>		
				  		<tr >	
							<td class="FieldLabel" colspan="2" >家庭住址:</td>
							<td class="FieldInput" colspan="4">
								<label id="supaddress" name="家庭住址:" field="address"  style="width: 99%"></label>
							</td>	
				  		</tr>
						<tr>
							<td class="FieldLabel" rowspan="3" width="9%">联系电话</td>
							<td class="FieldLabel" width="15%">宅电:</td>
							<td class="FieldInput" width="26%">
								<label id="supfamilyPhone" name="宅电:" field="familyPhone"  ></label>
							</td>
							<td class="FieldLabel" rowspan="3" width="9%">家庭住房</td>
							<td class="FieldLabel" width="15%">住房情况:</td>
							<td class="FieldInput" width="26%">
								<label name="住房情况:" field="houseStatus" dataset="houseTypeDS"></label>
							</td>
						</tr>
						<tr>
							<td class="FieldLabel">手机:</td>
							<td class="FieldInput">
								<label id="supfamilyMobile" name="手机:" field="familyMobile"  ></label>
							</td>
							<td class="FieldLabel">房屋性质:</td>
							<td class="FieldInput">
								<label name="房屋性质:" field="buildingStructure" dataset="buildingTypeDS"></label>
							</td>
						</tr>
						<tr>
							<td class="FieldLabel">其他:</td>
							<td class="FieldInput">
								<label name="其他:" id="supfamilyOtherPhone" field="familyOtherPhone"  ></label>
							</td>
							<td class="FieldLabel" >房屋面积<br/>(单位：平方米):</td>
							<td class="FieldInput">
								<label id="supbuildArea" name="房屋面积(平方):" field="buildArea"  ></label>
							</td>
						</tr>
						<tr>
							<td class="FieldLabel" rowspan="2">收入情况</td>
							<td class="FieldLabel" >家庭年：<br/>(单位：元)</td>
							<td class="FieldInput">
								<label id="supyearIncome" name="家庭年:" field="yearIncome"   ></label>
							</td>
							<td class="FieldLabel" rowspan="2">收入情况</td>
							<td class="FieldLabel">家庭月：<br/>(单位：元)</td>
							<td class="FieldInput">
								<label name="家庭月:" field="monthIncome"   ></label>
							</td>
						</tr>
						<tr>
							<td class="FieldLabel">家庭年人均：<br/>(单位：元)</td>
							<td class="FieldInput">
								<label name="家庭年人均:" id="supyearAverageIncome" field="yearAverageIncome"   ></label>
							</td>
							<td class="FieldLabel" >家庭月人均：<br/>(单位：元)</td>
							<td class="FieldInput">
								<label id="supmonthAverageIncome" name="家庭月人均:" field="monthAverageIncome"   ></label>
							</td>
						</tr>
					</table>
			</form>
			</next:Html>
		</next:Panel>
		<next:GridPanel id="supPeoplePanel" name="supPeoplePanel" autoWidth="true" stripeRows="true" height="200"  title="家庭成员列表"  dataset="esureyPeopleDS">
				<next:TopBar>
					<next:ToolBarItem symbol="->"></next:ToolBarItem>
					<next:ToolBarItem iconCls="detail" text="查看明细" handler="detail_people()"/>
				</next:TopBar>
				<next:Columns>
				    <next:RowNumberColumn width="10"/>
				    <next:RadioBoxColumn></next:RadioBoxColumn>
				    <next:Column id="suppeopleId" header="人员Id" field="peopleId" hidden="true"  >
					</next:Column>
					<next:Column id="supfamilyId" header="家庭Id" field="familyId" hidden="true" >
					</next:Column>
					<next:Column id="supname" header="成员姓名" field="name" width="10%" renderer="peopleDetailHref">
					</next:Column>
					<next:Column id="suprelationshipType" header="户主关系" field="relationshipType" dataset="RelationDS" width="10%" >
					</next:Column>
					<next:Column id="supidCard" header="身份证号" field="idCard" width="20%" >
					</next:Column>
					<next:Column id="sex" header="性别" field="sex" dataset="sexDS" width="10%" >
					</next:Column>
					<next:Column id="nation" header="民族" field="nation" dataset="DmMzDataSet" width="10%" >
					</next:Column>
					<next:Column id="isSupport" header="是否赡养义务人员" field="isSupport" width="20%" dataset="isSupportDS" >
					</next:Column>
				</next:Columns> 
				<next:BottomBar>
					<next:PagingToolBar dataset="esureyPeopleDS"/>
				</next:BottomBar>
		</next:GridPanel>	
		</next:Panel>
		</next:FitLayout>     
	</next:Panel>
<next:Window id="jtcyEdit" title="编辑" titleCollapse="false"  resizable="false" width="700"  height="400" closeAction="hide">
	<next:TopBar>
			<next:ToolBarItem symbol="->" ></next:ToolBarItem>
			<next:ToolBarItem iconCls="delete" text="关闭" handler="hide_win"/>
		</next:TopBar>
	<next:FitLayout>
       <next:TabPanel id="jtcyTabpanel" activeTab="1" border="false" >
           <next:Tabs>
<!--	成员基本信息	-->
              <next:Panel title="成员基本信息" width="100%" height="100%">
                  <next:Html>
                  	<form id="cyjbxxForm" method="post" onsubmit="return false"  dataset="esureyPeopleDS2" class="L5form" >
						<table border="0"  width="100%">
							<tr>		
								<td class="FieldLabel" >是否为赡（抚、扶）养义务人员：</td>
								<td class="FieldInput" colspan="3">
									<label  id="isSupport"  field="isSupport" dataset="isSupportDS"></label>
								</td>
							</tr>	
					  		<tr >
								<td class="FieldLabel" width="20%">姓名:</td>
								<td class="FieldInput" width="30%">
									<label id="name" name="姓名:" field="name"  ></label>
								</td>	
								<td class="FieldLabel" width="20%">与户主关系:</td>
								<td class="FieldInput" width="30%">
									<label name="与户主关系:" id="relationshipType" field="relationshipType" dataset="RelationDS" ></label>
								</td>		
							</tr>
					  		<tr >	
								<td class="FieldLabel">身份证号:</td>
								<td class="FieldInput">
									<label name="身份证号:" id="idCard" field="idCard" ></label>
								</td>
								<td class="FieldLabel">性别:</td>
								<td class="FieldInput">
									<label name="性别" field="sex" dataset="sexDS"></label>
								</td>		
							</tr>
					  		<tr >			
								<td class="FieldLabel">民族:</td>
								<td class="FieldInput">
									<label name="民族:" id="nation" field="nation"  dataset="DmMzDataSet"></label>
								</td>	
								<td class="FieldLabel">文化程度:</td>
								<td class="FieldInput">
									<label name="文化程度:"  id="eduCode" field="eduCode"  dataset="DmJyzkDataSet"></label>
								</td>		
							</tr>
					  		<tr >		
								<td class="FieldLabel">健康状况:</td>
								<td class="FieldInput">
									<label name="健康状况:" id="healthCode" field="healthCode" dataset="healthDS" ></label>
								</td>
								<td class="FieldLabel">婚姻状况:</td>
								<td class="FieldInput">
									<label name="婚姻状况:" id="marriageCode" field="marriageCode"  dataset="DmHyzkDataSet"></label>
								</td>	
							</tr>
					  		<tr >		
								<td class="FieldLabel">职业:</td>
								<td class="FieldInput">
									<label name="职业:"  id="careerCode" field="careerCode"  dataset="DmZyDataSet"></label>
								</td>
								<td class="FieldLabel">政治面貌:</td>
								<td class="FieldInput">
									<label name="政治面貌:" id="politicalCode" field="politicalCode"  dataset="politicsDS"></label>
								</td>	
							</tr>	
					  		<tr >		
								<td class="FieldLabel">户口性质:</td>
								<td class="FieldInput" colspan="3">
									<label name="户口性质" id="domicileType" field="domicileType" dataset="familyTypeDS"></label>
								</td>
							</tr>	
					  		<tr >		
								<td class="FieldLabel">年收入：<br/>(单位：元)</td>
								<td class="FieldInput">
									<label name="年收入:" id="incomeYear" field="incomeYear"  ></label>
								</td>
								<td class="FieldLabel">月收入：<br/>(单位：元)</td>
								<td class="FieldInput">
									<label name="月收入:" id="incomeMonth" field="incomeMonth"  ></label>
								</td>	
							</tr>	
					  		<tr >		
								<td class="FieldLabel">工作单位:</td>
								<td class="FieldInput" colspan="3">
									<label id="workUnitName" field="workUnitName"  ></label>
								</td>
							</tr>			
						</table>
					</form>
                  </next:Html>
              </next:Panel>
		
<!--	成员经济状况信息	-->
              <next:Panel title="本成员经济状况信息" width="100%" height="100%">
              <next:FitLayout>
              <next:Panel autoHeight="true" width="100%">
                  <next:Html>
                  	<form id="cyjjzkxxForm" method="post" onsubmit="return false"  class="L5form" >
						<table border="0"  width="100%" >
					  		<tr >
								<td class="FieldLabel"  width="20%">姓名:</td>
								<td class="FieldInput" width="30%">
									<label id="cyName"  />
								</td>	
								<td class="FieldLabel"  width="20%">身份证号:</td>
								<td class="FieldInput"  width="30%">
									<label id="cyIdCard" />
								</td>
							</tr>
						</table>
					</form>
                  </next:Html>
              </next:Panel>
             <next:Panel   width="100%" height="100%"  autoScroll="true">
			<next:GridPanel  id="social_grid" name="social_grid"  height="200"  title="本成员社保列表" dataset="SamEsureySocialDS">
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
						<next:Column id="hsSalaryType" header="工资类别"  field="salaryType" width="10%">
							<next:ComboBox triggerAction="all" valueField="value" displayField="text" dataset="salaryDS"/>
						</next:Column>
						<next:Column id="hsSalary" header="工资、养老金金额(/元)"  field="salary" width="20%">
							<next:NumberField allowBlank="false"/>
						</next:Column>
						<next:Column id="hsPension" header="养老金缴纳金额(/元)"  field="pension" width="10%">
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="hsPensionBalance" header="养老金余额(/元)"  field="pensionBalance" width="10%">
							<next:TextField allowBlank="false"/>
						</next:Column>
					</next:Columns>
				</next:GridPanel>
				
				<next:GridPanel  id="estate_grid" name="estate_grid" title="本成员其他财产收入列表"  height="200"  dataset="SamEsureyPeopleEstateDS">
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
						<next:Column id="hnum" header="金额"  field="num" >
							<next:NumberField  allowBlank="false"/>
						</next:Column>
					</next:Columns>
				</next:GridPanel>
				              
              <next:GridPanel  id="house_grid" name="house_grid" title="本成员房屋信息列表"  height="200"  dataset="SamEsureyHouseDS">
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
						<next:Column id="hhouseArea" header="建筑面积(/平米)"  field="houseArea" >
							<next:NumberField allowBlank="false"/>
						</next:Column>
					</next:Columns>
				</next:GridPanel>
				
				<next:GridPanel  id="business_grid" name="business_grid" title="本成员工商经营信息列表" height="200"   dataset="SamEsureyBusinessDS">
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
				</next:GridPanel>
				
				<next:GridPanel  id="car_grid" name="car_grid" title="本成员车辆信息列表"  height="200"  dataset="SamEsureyCarDS">
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
				</next:GridPanel>
				
				<next:GridPanel  id="tax_grid" name="tax_grid"  title="本成员国税信息列表" height="200"  dataset="SamEsureyTaxDS">
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
						<next:Column id="hturnoverLatestYear" header="最近一年营业额(/元)"  field="turnoverLatestYear" >
							<next:NumberField allowBlank="false"/>
						</next:Column>
						<next:Column id="htaxesLatestYear" header="最近一年纳税额(/元)"  field="taxesLatestYear" >
							<next:NumberField allowBlank="false"/>
						</next:Column>
					</next:Columns>
				</next:GridPanel>
				
				<next:GridPanel  id="tax2_grid" name="tax2_grid" title="本成员地税信息列表"  height="200"  dataset="SamEsureyTaxDS2">
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
						<next:Column id="hurnoverLatestYearx" header="最近一年营业额(/元)"  field="turnoverLatestYear" >
							<next:NumberField allowBlank="false"/>
						</next:Column>
						<next:Column id="haxesLatestYearx" header="最近一年纳税额(/元)"  field="taxesLatestYear" >
							<next:NumberField allowBlank="false"/>
						</next:Column>
					</next:Columns>
				</next:GridPanel>
				
				<next:GridPanel  id="fund_grid" name="fund_grid" title="本成员公积金信息列表" height="200"  dataset="SamEsureyHousingFundDS">
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
						<next:Column id="hbalance" header="公积金余额(/元)"  field="balance" >
							<next:NumberField allowBlank="false"/>
						</next:Column>
						<next:Column id="hcollectNum" header="历史提取金额合计(/元)"  field="collectNum" >
							<next:NumberField allowBlank="false"/>
						</next:Column>
					</next:Columns>
				</next:GridPanel>
				
				<next:GridPanel  id="bank_grid" name="bank_grid"  title="本成员人民银行信息列表" height="200"  dataset="SamEsureyBankDS">
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
				</next:GridPanel>
				
				<next:GridPanel  id="securities_grid" name="securities_grid" title="本成员证监列表"  height="200"  dataset="SamEsureySecuritiesDS">
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
						<next:Column id="hstock" header="股票市值总金额(/元)"  field="stock" >
							<next:NumberField allowBlank="false"/>
						</next:Column>
						<next:Column id="hfund" header="基金市值总金额(/元)"  field="fund" >
							<next:NumberField allowBlank="false"/>
						</next:Column>
						<next:Column id="hmoney" header="资金总余额(/元)"  field="money" >
							<next:NumberField allowBlank="false"/>
						</next:Column>
					</next:Columns>
				</next:GridPanel>
				
				<next:GridPanel  id="insurance_grid" name="insurance_grid" title="本成员保险信息列表"  height="200"  dataset="SamEsureyInsuranceDS">
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
				</next:GridPanel>
				</next:Panel>
				</next:FitLayout>
                </next:Panel>				
           </next:Tabs>
       </next:TabPanel>
    </next:FitLayout>
</next:Window>
</body>
</html>	