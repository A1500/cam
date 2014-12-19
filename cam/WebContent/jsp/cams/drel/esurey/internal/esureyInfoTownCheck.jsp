<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<html>
<head>
<title>城乡居民家庭经济状况审核</title>
<next:ScriptManager />
<script type="text/javascript" src="esureyInfoTownCheck.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js") %>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript">
			var familyId='<%=request.getParameter("familyId")%>';
	</script>
</head>
<body>
<model:datasets>
	<!--申报家庭基本信息-->
	<model:dataset id="esureyFamilyDS"
		cmd="com.inspur.cams.drel.esurey.cmd.SamEsureyFamilyQueryCmd">
		<model:record
			fromBean="com.inspur.cams.drel.esurey.data.SamEsureyFamily">
			<model:field name="checkOpinion" rule="require"/>
			<model:field name="domicileName" type="string"/>
      		<model:field name="apanageName" type="string"/>
			</model:record>
	</model:dataset>
	<!--申报家庭成员基本信息-->
	<model:dataset id="esureyPeopleDS"
		cmd="com.inspur.cams.drel.esurey.cmd.SamEsureyPeopleQueryCmd">
		<model:record
			fromBean="com.inspur.cams.drel.esurey.data.SamEsureyPeople"></model:record>
	</model:dataset>
	<!--申报家庭赡养成员基本信息-->
	<model:dataset id="esureyPeopleRelationDS"
		cmd="com.inspur.cams.drel.esurey.cmd.SamEsureyPeopleQueryCmd">
		<model:record
			fromBean="com.inspur.cams.drel.esurey.data.SamEsureyPeople"></model:record>
	</model:dataset>
	<!--申报家庭成员基本信息-->
	<model:dataset id="esureyPeopleDS2"
		cmd="com.inspur.cams.drel.esurey.cmd.SamEsureyPeopleQueryCmd">
		<model:record
			fromBean="com.inspur.cams.drel.esurey.data.SamEsureyPeople"></model:record>
	</model:dataset>
	<!--申报家庭成员基本信息-->
	<model:dataset id="esureyPeopleDS3"
		cmd="com.inspur.cams.drel.esurey.cmd.SamEsureyPeopleQueryCmd" method="querySupportPeo" pageSize="5">
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
	<!--申报家庭成员国税基本信息-->
	<model:dataset id="SamEsureyTaxDS" cmd="com.inspur.cams.drel.esurey.cmd.SamEsureyTaxQueryCmd">
		<model:record fromBean="com.inspur.cams.drel.esurey.data.SamEsureyTax"></model:record>
	</model:dataset>
<!--申报家庭成员地税基本信息-->
	<model:dataset id="SamEsureyTaxDS2" cmd="com.inspur.cams.drel.esurey.cmd.SamEsureyTaxQueryCmd">
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
	<!--赡养人员姓名  -->
	<model:dataset id="NameDS" cmd="com.inspur.cams.comm.dicm.DicQueryCmd"
		global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value="SAM_ESUREY_PEOPLE"></model:param>
			<model:param name="value" value="PEOPLE_ID"></model:param>
			<model:param name="text" value="NAME"></model:param>
		</model:params>
	</model:dataset>
	<!-- 与户主关系 -->
	<model:dataset id="RelationDS" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_RELATIONSHIP_TYPE'></model:param>
		</model:params>
	</model:dataset>
	<!--赡养人员身份证号  -->
	<model:dataset id="IdCardDS"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value="SAM_ESUREY_PEOPLE"></model:param>
			<model:param name="value" value="PEOPLE_ID"></model:param>
			<model:param name="text" value="ID_CARD"></model:param>
		</model:params>
	</model:dataset>	
<!--是否为赡养义务人员-->	
	<model:dataset id="isSupportDS" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>		
<!-- 性别 -->	
	<model:dataset id="sexDS"  enumName="COMM.SEX" autoLoad="true" global="ture"></model:dataset>	
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
<!-- 家庭性质 -->
	<model:dataset id="familyTypeDS" enumName="FAMILY_TYPE" autoLoad="true"  global="true"></model:dataset>	
<!-- 救助类型 -->	
	<model:dataset id="assistanceTypeDS" enumName="ASSISTANCE_TYPE"  autoLoad="true" global="true"></model:dataset>	
<!-- 审核意见 -->
	<model:dataset id="checkOpinionDS" enumName="CHECK_OPINION" autoLoad="true"></model:dataset>
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
<next:Panel name="fit-div" width="100%" height="100%"  collapsible="true">
			<next:TopBar>
				<next:ToolBarItem symbol="->"></next:ToolBarItem>
				<next:ToolBarItem text="保存" iconCls="save" handler="save_onclick"></next:ToolBarItem>
				<next:ToolBarItem text="返回" iconCls="return" handler="return_onclick"></next:ToolBarItem>
			</next:TopBar>
			<next:Panel id="jtjbxxPanel" width="100%" height="100%"  collapsible="true"  autoScroll="true" title="申报家庭基本信息">
			<next:Panel id="family_detail" autoWidth="true" autoHeight="true" collapsible="true">
				<next:Html>
				<form id="sbjtjbxxForm" method="post" onsubmit="return false" dataset="esureyFamilyDS" class="L5form">
				<table border="0" width="100%">
					<tr>
						<td class="FieldLabel" width="15%">户主姓名:</td>
						<td class="FieldInput" width="20%"><label id="familyName" name="户主姓名:" field="familyName" /></td>
						<td class="FieldLabel" width="15%">身份证号:</td>
						<td class="FieldInput" width="20%"><label id="familyCardNo" name="身份证号:" field="familyCardNo" /></td>
						<td class="FieldLabel" width="15%">家庭人口数量:</td>
						<td class="FieldInput" width="15%"><label id="peopleNum" name="家庭人口数量" field="peopleNum" /></td>
					</tr>
					<tr>
						<td class="FieldLabel">家庭性质:</td>
						<td class="FieldInput"><label id="domicileType" name="家庭性质:" field="domicileType" dataset="familyTypeDS" /></td>
						<td class="FieldLabel">救助类型:</td>
						<td class="FieldInput"><label name="救助类型" field="assistanceType" dataset="assistanceTypeDS" /></td>
						<td class="FieldLabel">邮政编码:</td>
						<td class="FieldInput"><label id="familyPostcode" name="邮政编码: " field="familyPostcode" /></td>
					</tr>
					<tr>
						<td class="FieldLabel" >户籍行政区划:</td>
						<td class="FieldInput">
							<label id="regAddress"  field="domicileName"  ></label>
						</td>
						<td class="FieldLabel" >属地行政区划:</td>
						<td class="FieldInput">
							<label id="familyAddress" field="apanageName"  ></label>
						</td>	
						<td class="FieldLabel"></td>
						<td class="FieldInput"></td>
					</tr>
					<tr>
						<td class="FieldLabel">家庭住址:</td>
						<td class="FieldInput" colspan="5"><label id="address" name="家庭住址:" field="address" style="width: 82%" /></td>
					</tr>
					<tr>
						<td class="FieldLabel">宅电:</td>
						<td class="FieldInput"><label id="familyPhone" name="宅电:" field="familyPhone" /></td>
						<td class="FieldLabel">手机:</td>
						<td class="FieldInput"><label id="familyMobile" name="手机:" field="familyMobile" /></td>
						<td class="FieldLabel">其他:</td>
						<td class="FieldInput"><label name="其他:" id="familyOtherPhone" field="familyOtherPhone" /></td>
					</tr>
					<tr>
						<td class="FieldLabel">住房情况:</td>
						<td class="FieldInput"><label name="住房情况:" field="houseStatus" dataset="houseTypeDS" /></td>
						<td class="FieldLabel">房屋性质:</td>
						<td class="FieldInput"><label name="房屋性质:" field="buildingStructure" dataset="buildingTypeDS" /></td>
						<td class="FieldLabel">房屋面积:<br/>(单位:平方米):</td>
						<td class="FieldInput"><label id="buildArea" name="房屋面积:" field="buildArea" /></td>
					</tr>
					<tr>
						<td class="FieldLabel">家庭年:<br/>(单位：元)</td>
						<td class="FieldInput"><label id="yearIncome" name="家庭年:" field="yearIncome" ></label></td>
						<td class="FieldLabel">家庭月:<br/>(单位：元)</td>
						<td class="FieldInput"><label name="家庭月:" field="monthIncome" /></td>
						<td class="FieldLabel">年赡（抚、扶）养费:<br/>(单位：元)</td>
						<td class="FieldInput"><label id="yearSupportMon" name="年赡（抚、扶）养费:" field="yearSupportMon"  /></td>
					</tr>
					<tr>
						<td class="FieldLabel">家庭年人均:<br/>(单位：元)</td>
						<td class="FieldInput"><label name="家庭年人均:" id="yearAverageIncome" field="yearAverageIncome"/></td>
						<td class="FieldLabel">家庭月人均:<br/>(单位：元)</td>
						<td class="FieldInput"><label id="monthAverageIncome" name="家庭月人均:" field="monthAverageIncome" /></td>
						<td class="FieldLabel">月赡（抚、扶）养费:<br/>(单位：元)</td>
						<td class="FieldInput"><label id="monthSupportMonon" name="月赡（抚、扶）养费:" field="monthSupportMonon" /></td>
					</tr>
					<tr>
						<td class="FieldLabel">审核意见</td>
						<td class="FieldInput">
							<select id="checkOpinion" field="checkOpinion" style="width:85%"><option dataset="checkOpinionDS"></option></select>
							<font color=red>*</font>
						</td>
						<td class="FieldLabel">补充意见</td>
						<td class="FieldInput" colspan="3"><textarea cols="65%"
							field="checkNote" class="TextEditor"></textarea></td>
					</tr>
				</table>
				</form>
			</next:Html>
		</next:Panel>
		<next:Panel id="funCreate"  collapsible="true" autoWidth="true" height="200">
			<next:FitLayout>
			<next:TabPanel id="tabpanel-div" name="tabpanel-div"  activeTab="1">
				<next:Tabs>
						<next:GridPanel id="jtcyGridPanel" name="jtcyGridPanel"  stripeRows="true" title="共同生活家庭成员列表" height="100%" collapsible="true" dataset="esureyPeopleDS">
							<next:TopBar>
								<next:ToolBarItem symbol="->"></next:ToolBarItem>
								<next:ToolBarItem iconCls="detail" text="查看明细" handler="detail_people()"/>
							</next:TopBar>
							<next:Columns>
								<next:RowNumberColumn width="10" />
								<next:RadioBoxColumn></next:RadioBoxColumn>
								<next:Column id="peopleId" header="人员Id" field="peopleId" hidden="true" >
								</next:Column>
								<next:Column id="familyId" header="家庭Id" field="familyId"	hidden="true" >
								</next:Column>
								<next:Column id="name" header="姓名" field="name" renderer="peopleDetailHref" width="10%" >
								</next:Column>
								<next:Column id="relationshipType" header="户主关系" dataset="RelationDS" field="relationshipType" width="10%">
								</next:Column>
								<next:Column id="idCard" header="身份证号" field="idCard" width="20%">
								</next:Column>
								<next:Column id="sex" header="性别" field="sex" dataset="sexDS" width="5%">
								</next:Column>
								<next:Column id="nation" header="民族" field="nation" dataset="DmMzDataSet" width="15%">
								</next:Column>
							</next:Columns>
							<next:BottomBar>
								<next:PagingToolBar dataset="esureyPeopleDS" />
							</next:BottomBar>
						</next:GridPanel>
				<next:GridPanel id="jtcysfGridPanel" name="jtcysfGridPanel"  stripeRows="true" height="100%" title="赡（抚、扶）养义务人员列表" collapsible="true" dataset="esureyPeopleDS3">
				<next:TopBar>
					<next:ToolBarItem symbol="->"></next:ToolBarItem>
					<next:ToolBarItem iconCls="detail" text="查看详情" handler="detail_people1()"/>
					<next:ToolBarItem iconCls="detail" text="相应的家庭信息" handler="detail_family"/>
				</next:TopBar>
				<next:Columns>
				     <next:RadioBoxColumn></next:RadioBoxColumn>
				    <next:Column id="speopleId" header="人员Id" field="PEOPLE_ID" hidden="true" width="10%" >
					</next:Column>
					<next:Column id="sfamilyId" header="家庭Id" field="FAMILY_ID" hidden="true" width="10%" >
					</next:Column>
					<next:Column id="sname" header="姓名" field="NAME"   width="15%" renderer="suppeopleDetailHref" >
					</next:Column>
					<next:Column id="srelationshipType" header="户主关系" field="RELATION_TYPE" dataset="RelationDS" hidden="true" width="10%"  >
					</next:Column>
					<next:Column id="sidCard" header="身份证号" field="ID_CARD" width="20%" >
					</next:Column>
					<next:Column id="ssex" header="性别" field="SEX" width="10%" dataset="sexDS" >
					</next:Column>
					<next:Column id="snation" header="民族" field="NATION" width="10%" dataset="DmMzDataSet" >
					</next:Column>
				</next:Columns> 
				<next:BottomBar>
					<next:PagingToolBar dataset="esureyPeopleDS3"/>
				</next:BottomBar>
				</next:GridPanel>	
				</next:Tabs>
			</next:TabPanel>
			</next:FitLayout>
		</next:Panel>
		</next:Panel>
</next:Panel>
<next:Window id="jtcyEdit" title="编辑" titleCollapse="false" resizable="false" width="700" height="400" closeAction="hide">
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
                  	<form id="cyjbxxForm" method="post" onsubmit="return false"   dataset="esureyPeopleDS2"
						class="L5form" >
						<table border="0"  width="100%">
							<tr id="sup_tr" style="display:none;">		
								<td class="FieldLabel">是否为赡（抚、扶）养义务人员：</td>
								<td class="FieldInput" colspan="3">
									<label id="isSupport"  field="isSupport" dataset="isSupportDS"></label>
								</td>
							</tr>	
					  		<tr >
								<td class="FieldLabel" width="20%">姓名:</td>
								<td class="FieldInput" width="30%">
									<label id="name" field="name"  ></label>
								</td>	
								<td class="FieldLabel" width="20%">与户主关系:</td>
								<td class="FieldInput" width="30%">
									<label  id="relationshipType" field="relationshipType" dataset="RelationDS" ></label>
								</td>		
							</tr>
					  		<tr >	
								<td class="FieldLabel">身份证号:</td>
								<td class="FieldInput">
									<label  id="idCard" field="idCard" ></label>
								</td>
								<td class="FieldLabel">性别:</td>
								<td class="FieldInput">
									<label field="sex" dataset="sexDS"></label>
								</td>		
							</tr>
					  		<tr >			
								<td class="FieldLabel">民族:</td>
								<td class="FieldInput">
									<label  id="nation" field="nation"  dataset="DmMzDataSet"></label>
								</td>	
								<td class="FieldLabel">文化程度:</td>
								<td class="FieldInput">
									<label   id="eduCode" field="eduCode" dataset="DmJyzkDataSet" ></label>
								</td>		
							</tr>
					  		<tr >		
								<td class="FieldLabel">健康状况:</td>
								<td class="FieldInput">
									<label  id="healthCode" field="healthCode"  dataset="healthDS"></label>
								</td>
								<td class="FieldLabel">婚姻状况:</td>
								<td class="FieldInput">
									<label  id="marriageCode" field="marriageCode" dataset="DmHyzkDataSet" ></label>
								</td>	
							</tr>
					  		<tr >		
								<td class="FieldLabel">职业:</td>
								<td class="FieldInput">
									<label   id="careerCode" field="careerCode"  dataset="DmZyDataSet"></label>
								</td>
								<td class="FieldLabel">政治面貌:</td>
								<td class="FieldInput">
									<label  id="politicalCode" field="politicalCode"  dataset="politicsDS"></label>
								</td>	
							</tr>	
					  		<tr >		
								<td class="FieldLabel">户口性质:</td>
								<td class="FieldInput" colspan="3">
									<label  id="domicileType" field="domicileType" dataset="familyTypeDS"></label>
								</td>
							</tr>	
					  		<tr >		
								<td class="FieldLabel">年收入：<br/>(单位：元)</td>
								<td class="FieldInput">
									<label  id="incomeYear" field="incomeYear"  ></label>
								</td>
								<td class="FieldLabel">月收入：<br/>(单位：元)</td>
								<td class="FieldInput">
									<label  id="incomeMonth" field="incomeMonth"  ></label>
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
								<td class="FieldLabel" width="20%">姓名:</td>
								<td class="FieldInput" width="30%">
									<label id="cyName"  />
								</td>	
								<td class="FieldLabel" width="20%">身份证号:</td>
								<td class="FieldInput" width="30%">
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
						<next:Column id="hsSalaryType" header="工资类别"  field="salaryType" width="20%">
							<next:ComboBox triggerAction="all" valueField="value" displayField="text" dataset="salaryDS"/>
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
						<next:Column id="hnum" header="金额(/元)"  field="num" >
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
						<next:Column id="hhouseArea" header="建筑面积(/平方米)"  field="houseArea" >
							<next:NumberField allowBlank="false"/>
						</next:Column>
					</next:Columns>
				</next:GridPanel>
				
				<next:GridPanel  id="business_grid" name="business_grid" title="本成员工商经营信息列表"  height="200"   dataset="SamEsureyBusinessDS">
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
						<next:Column id="htaxesPeople" header="纳税人姓名"  field="taxesPeople" width="10%">
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
				</next:GridPanel>
				
				<next:GridPanel  id="fund_grid" name="fund_grid"  title="本成员公积金信息列表" height="200"  dataset="SamEsureyHousingFundDS">
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
						<next:Column id="hcollectNum" header="历史提取金额合计(/元)"  field="collectNum" width="24%">
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
				</next:GridPanel>
				
				<next:GridPanel  id="insurance_grid" name="insurance_grid"  title="本成员保险信息列表" height="200"  dataset="SamEsureyInsuranceDS">
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
	<next:Buttons>
		<next:ToolButton text="关闭" handler="hide_win"></next:ToolButton>
	</next:Buttons>
</next:Window>
</body>
</html>
