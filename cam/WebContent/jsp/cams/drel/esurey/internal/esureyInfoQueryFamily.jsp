<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<html>
<head>
	<title>城乡居民家庭经济状况申报列表</title>
	<next:ScriptManager/>
	<script type="text/javascript" src="esureyInfoQueryFamily.js"></script>		
	<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js") %>'></script>
	<script type="text/javascript">
			var familyId='<%=request.getParameter("familyId")%>';
			var fromPage='<%=request.getParameter("fromPage")%>';
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
	<model:dataset id="esureyPeopleDS2" cmd="com.inspur.cams.drel.esurey.cmd.SamEsureyPeopleQueryCmd" method="querySupportPeo">
	</model:dataset>
<!--申报信息_抚养关系-->
	<model:dataset id="esureyRelationDS" cmd="com.inspur.cams.drel.esurey.cmd.SamEsureyRelationQueryCmd">
		<model:record fromBean="com.inspur.cams.drel.esurey.data.SamEsureyRelation"></model:record>
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
	
	<!--经济核对_家庭经济状况审核汇总-->
	<model:dataset id="SamEsureyFamilySumDS"
		cmd="com.inspur.cams.drel.esurey.cmd.SamEsureyFamilySumQueryCmd">
		<model:record
			fromBean="com.inspur.cams.drel.esurey.data.SamEsureyFamilySum"></model:record>
	</model:dataset>
	<!-- 家庭诚信等级 -->
	<model:dataset id="creditRatingDS" enumName="CREDIT_RATING"
		autoLoad="true" global="true"></model:dataset>
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
<next:ViewPort>
<next:Panel name="fit-div" width="100%" height="100%" autoScroll="true">
		<next:Panel id="jtjbxxPanel" autoWidth="true" height="true"  autoScroll="true" title="申报家庭基本信息">
		<next:TopBar>
				<next:ToolBarItem symbol="->"></next:ToolBarItem>
				<next:ToolBarItem  id="undoButtonId" iconCls="undo" text="返回" handler="return_list"/>
				<next:ToolBarItem symbol=""></next:ToolBarItem>
				<next:ToolBarItem symbol="-"></next:ToolBarItem>
				<next:ToolBarItem symbol=""></next:ToolBarItem>
			</next:TopBar>
			<next:Html>
				<form id="sbjtjbxxForm" method="post" onsubmit="return false" style="padding: 5px;" dataset="esureyFamilyDS"
					class="L5form" >
					<table border="0"  width="99%" >
				  		<tr >
							<td class="FieldLabel" colspan="2">户主姓名:</td>
							<td class="FieldInput">
								<label id="familyName" name="户主姓名:" field="familyName"  ></label>
							</td>	
							<td class="FieldLabel" colspan="2">身份证号:</td>
							<td class="FieldInput">
								<label id="familyCardNo" name="身份证号:" field="familyCardNo"   ></label>
							</td>		
						</tr>
				  		<tr >	
							<td class="FieldLabel" colspan="2">家庭人口数量:</td>
							<td class="FieldInput">
								<label id="peopleNum" name="家庭人口数量" field="peopleNum"  ></label>
							</td>
							<td class="FieldLabel" colspan="2">家庭性质:</td>
							<td class="FieldInput">
								<label id="domicileType" name="家庭性质:" field="domicileType" dataset="familyTypeDS" ></label>
							</td>		
						</tr>
				  		<tr >			
							<td class="FieldLabel" colspan="2">救助类型:</td>
							<td class="FieldInput">
								<label name="救助类型" field="assistanceType" dataset="assistanceTypeDS"></label>
							</td>	
							<td class="FieldLabel" colspan="2">邮政编码:</td>
							<td class="FieldInput">
								<label id="familyPostcode" name="邮政编码: " field="familyPostcode"  ></label>
							</td>		
						</tr>
				  		<tr >		
							<td class="FieldLabel" colspan="2">户籍行政区划:</td>
							<td class="FieldInput">
								<label id="regAddress"  field="domicileName"  ></label>
							</td>
							<td class="FieldLabel" colspan="2">属地行政区划:</td>
							<td class="FieldInput">
								<label id="familyAddress" field="apanageName"  ></label>
							</td>	
						</tr>		
				  		<tr >	
							<td class="FieldLabel" colspan="2">家庭住址:</td>
							<td class="FieldInput" colspan="4">
								<label id="address" name="家庭住址:" field="address"  style="width: 99%"></label>
							</td>	
				  		</tr>
						<tr>
							<td class="FieldLabel" rowspan="3">联系电话</td>
							<td class="FieldLabel" >宅电:</td>
							<td class="FieldInput">
								<label id="familyPhone" name="宅电:" field="familyPhone"  ></label>
							</td>
							<td class="FieldLabel" rowspan="3">家庭住房</td>
							<td class="FieldLabel">住房情况:</td>
							<td class="FieldInput">
								<label name="住房情况:" field="houseStatus" dataset="houseTypeDS"></label>
							</td>
						</tr>
						<tr>
							<td class="FieldLabel">手机:</td>
							<td class="FieldInput">
								<label id="familyMobile" name="手机:" field="familyMobile"  ></label>
							</td>
							<td class="FieldLabel">房屋性质:</td>
							<td class="FieldInput">
								<label name="房屋性质:" field="buildingStructure" dataset="buildingTypeDS"></label>
							</td>
						</tr>
						<tr>
							<td class="FieldLabel">其他:</td>
							<td class="FieldInput">
								<label name="其他:" id="familyOtherPhone" field="familyOtherPhone"  ></label>
							</td>
							<td class="FieldLabel" style="width: 110px;">房屋面积(平方):</td>
							<td class="FieldInput">
								<label id="buildArea" name="房屋面积(平方):" field="buildArea"  ></label>
							</td>
						</tr>
						<tr>
							<td class="FieldLabel" rowspan="2">收入情况</td>
							<td class="FieldLabel" >家庭年:</td>
							<td class="FieldInput">
								<label id="yearIncome" name="家庭年:" field="yearIncome"   ></label>
							</td>
							<td class="FieldLabel" rowspan="2">收入情况</td>
							<td class="FieldLabel">家庭月:</td>
							<td class="FieldInput">
								<label name="家庭月:" field="monthIncome"   ></label>
							</td>
						</tr>
						<tr>
							<td class="FieldLabel">家庭年人均:</td>
							<td class="FieldInput">
								<label name="家庭年人均:" id="yearAverageIncome" field="yearAverageIncome"   ></label>
							</td>
							<td class="FieldLabel" style="width: 110px;">家庭月人均:</td>
							<td class="FieldInput">
								<label id="monthAverageIncome" name="家庭月人均:" field="monthAverageIncome"   ></label>
							</td>
						</tr>
						<tr >	
							<td class="FieldLabel" colspan="2">年赡（抚、扶）养费:</td>
							<td class="FieldInput">
								<label id="yearSupportMon" name="年赡（抚、扶）养费:" field="yearSupportMon"   ></label>
							</td>
							<td class="FieldLabel" colspan="2">月赡（抚、扶）养费:</td>
							<td class="FieldInput">
								<label id="monthSupportMonon" name="月赡（抚、扶）养费:" field="monthSupportMonon"  ></label>
							</td>		
						</tr>
						<tr>
						<td class="FieldLabel" rowspan="4">外部单位核对信息</td>
						<td class="FieldLabel">家庭年总收入：<br />
						(单位：元)</td>
						<td class="FieldInput"><label id="extyearIncome"/></td>
						<td class="FieldLabel" colspan="2">家庭年人均收入：<br />
						(单位：元)</td>
						<td class="FieldInput"><label
							id="extyearAverageIncome"/></td>
					</tr>
					<tr>
						<td class="FieldLabel">家庭月总收入：<br />
						(单位：元)</td>
						<td class="FieldInput"><label id="extmonthIncome"/></td>
						<td class="FieldLabel" colspan="2">家庭月人均收入：<br />
						(单位：元)</td>
						<td class="FieldInput"><label
							id="extmonthAverageIncome"/></td>
					</tr>
					<tr>
						<td class="FieldLabel">家庭月总财产：<br />
						(单位：万元)</td>
						<td class="FieldInput" colspan="4"><label id="extfamilyWorth"/></td>
					</tr>
					<tr>
						<td class="FieldLabel">年赡养费：<br />(单位：元)</td>
						<td class="FieldInput"><label
							id="extyearSupportMon"/></td>
						<td class="FieldLabel" colspan="2">月赡养费：<br />(单位：元)</td>
						<td class="FieldInput"><label
							id="extmonthSupportMon"/></td>
					</tr>
					<tr>
						<td class="FieldLabel">审核信息</td>
						<td class="FieldLabel">家庭诚信等级：</td>
						<td class="FieldInput"><select disabled="disabled" name="家庭诚信等级"
							id="creditRating">
							<option dataset="creditRatingDS"></option>
						</select></td>
						<td class="FieldLabel" colspan="2"></td>
						<td class="FieldInput"></td>
					</tr>
					</table>
			</form>

			</next:Html>
		</next:Panel>
		<next:GridPanel id="jtcyGridPanel" name="jtcyGridPanel" width="100%" stripeRows="true" height="45%" title="共同生活家庭成员列表"
				dataset="esureyPeopleDS">
				<next:TopBar>
					<next:ToolBarItem symbol="->"></next:ToolBarItem>
					<next:ToolBarItem iconCls="detail" text="核对详情" handler="detail_people"/>
					<next:ToolBarItem symbol=""></next:ToolBarItem>
					<next:ToolBarItem symbol="-"></next:ToolBarItem>
					<next:ToolBarItem symbol=""></next:ToolBarItem>
					</next:TopBar>
				<next:Columns>
				    <next:RowNumberColumn width="10"/>
				    <next:RadioBoxColumn></next:RadioBoxColumn>
				    <next:Column id="peopleId" header="人员Id" field="peopleId" hidden="true" width="30" >
					</next:Column>
					<next:Column id="familyId" header="家庭Id" field="familyId" hidden="true" width="30" >
					</next:Column>
					<next:Column id="name" header="成员姓名" field="name" width="20%" >
					</next:Column>
					<next:Column id="relationshipType" header="户主关系" field="relationshipType" dataset="RelationDS" width="15%" >
					</next:Column>
					<next:Column id="idCard" header="身份证号" field="idCard" width="20%" >
					</next:Column>
					<next:Column id="sex" header="性别" field="sex" width="10%" dataset="sexDS" >
					</next:Column>
					<next:Column id="nation" header="民族" field="nation" width="10%" dataset="DmMzDataSet" >
					</next:Column>
				</next:Columns> 
				<next:BottomBar>
					<next:PagingToolBar dataset="esureyPeopleDS"/>
				</next:BottomBar>
		</next:GridPanel>	
		<next:GridPanel id="jtcysfGridPanel" name="jtcysfGridPanel" width="100%" stripeRows="true" height="45%" title="赡（抚、扶）养义务人员列表"
				dataset="esureyPeopleDS2">
				<next:TopBar>
					<next:ToolBarItem symbol="->"></next:ToolBarItem>
					<next:ToolBarItem iconCls="detail" text="核对详情" handler="detail_supPeople"/>
					<next:ToolBarItem symbol=""></next:ToolBarItem>
					<next:ToolBarItem symbol="-"></next:ToolBarItem>
					<next:ToolBarItem symbol=""></next:ToolBarItem>
				</next:TopBar>
				<next:Columns>
				    <next:RowNumberColumn width="10"/>
				    <next:RadioBoxColumn></next:RadioBoxColumn>
				    <next:Column id="speopleId" header="人员Id" field="PEOPLE_ID" hidden="true" width="90" >
					</next:Column>
					<next:Column id="sfamilyId" header="家庭Id" field="FAMILY_ID" hidden="true" width="90" >
					</next:Column>
					<next:Column id="sisSupport" header="家庭Id" field="IS_SUPPORT" hidden="true" width="90" >
					</next:Column>
					<next:Column id="sname" header="姓名" field="NAME"   width="20%"  >
					</next:Column>
					<next:Column id="srelationshipType" header="户主关系" field="RELATIONSHIP_TYPE" dataset="RelationDS" width="15%"  >
					</next:Column>
					<next:Column id="sidCard" header="身份证号" field="ID_CARD" width="30%" >
					</next:Column>
					<next:Column id="ssex" header="性别" field="SEX" width="10%" dataset="sexDS" >
					</next:Column>
					<next:Column id="snation" header="民族" field="NATION" width="10%" dataset="DmMzDataSet" >
					</next:Column>
				</next:Columns> 
				<next:BottomBar>
					<next:PagingToolBar dataset="esureyPeopleDS2"/>
				</next:BottomBar>
		</next:GridPanel>		
		</next:Panel>
</next:ViewPort>
</body>
</html>	