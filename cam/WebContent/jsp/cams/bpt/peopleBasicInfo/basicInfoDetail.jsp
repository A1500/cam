<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
<head>
<title>优抚对象基本信息修改</title>
<next:ScriptManager />
		<script>
			var idField='<%=request.getParameter("dataBean")%>';
			var method='<%=request.getParameter("method")%>';
			var username = '<%=request.getParameter("username")%>';
			var organCode = '<%=BspUtil.getOrganCode()%>';
            var organName = '<%=BspUtil.getOrganName()%>';
		</script>
<script type="text/javascript" src="basicInfoDetail.js"></script>
</head>
<body>
<model:datasets>
	<!-- 人员信息 -->
	<model:dataset id="BaseinfoPeopleDataSet" cmd="com.inspur.cams.bpt.manage.cmd.BptBaseinfoPeopleQueryCommand"
			method="queryPeopleInfo" global="true">
		<model:record fromBean="com.inspur.cams.comm.baseinfo.data.BaseinfoPeople">
		<model:field name="domicileName" type="string"/>
		<model:field name="apanageName" type="string"/></model:record>
		<model:params>
			<model:param name="PEOPLE_ID" value='<%=request.getParameter("peopleId")%>'></model:param>
		</model:params>
	</model:dataset>
	<!-- 家庭信息 -->
	<model:dataset id="BaseinfoFamilyDataSet" cmd="com.inspur.cams.bpt.manage.cmd.BptBaseinfoPeopleQueryCommand"
		method="queryFamilyInfo" global="true">
		<model:record fromBean="com.inspur.cams.comm.baseinfo.data.BaseinfoFamily"></model:record>
		<model:params>
			<model:param name="FAMILY_ID" value='<%=request.getParameter("familyId")%>'></model:param>
		</model:params>
	</model:dataset>
	<!-- 住房状况类型 -->
	<model:dataset id="HouseStatusEnum" enumName="HOUSE.STATUS"
		autoLoad="true" global="true"></model:dataset>
	<!-- 房屋结构 -->
	<model:dataset id="BuildingStructureEnum" enumName="BUILDING.STRUCTURE"
		autoLoad="true" global="true"></model:dataset>
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
	<!-- 伤残性质 -->
	<model:dataset id="DisabilityCaseDataset"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_DISABILITY_CASE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
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
    <!-- 享受购建房补助 -->
	<model:dataset id="BuildingSubsidyDataset" enumName="BUILDINGSUBSIDY.FLAG"  autoLoad="true" global="true"></model:dataset>
</model:datasets>

<next:Panel width="100%" autoHeight="true" autoWidth="true">

	<next:TabPanel>
		<next:Tabs>
			<next:Panel title="人员基本信息" autoHeight="true" autoWidth="true"
				id="peopleTabPanel">
				<next:Html>
					<fieldset>
					<form id="BaseinfoPeopleForm" method="post" dataset="BaseinfoPeopleDataSet" onsubmit="return false" style="padding: 5px;" class="L5form">
					<table border="0" width="100%">
						<tr>
							<td class="FieldLabel" nowrap>姓名：</td>
							<td class="FieldInput"><label id="namebase" name="namebase" field="name"></label></td>
							<td class="FieldLabel" nowrap>与户主关系：</td>
							<td class="FieldInput" ><label name="relationshipType" field="relationshipType" dataset="RelationshipTypeDataset"></label></td>
							<td class="FieldLabel" nowrap>性别：</td>
							<td class="FieldInput"><label name="sex" field="sex" dataset="SexDataset"></label></td>
						</tr>
						
						<tr>
							<td class="FieldLabel" nowrap>身份证件号码：</td>
							<td class="FieldInput"><label id="idCard" name="idCard" field="idCard"></label></td>
							<td class="FieldLabel" nowrap>出生日期：</td>
							<td class="FieldInput"><label name="birthday" field="birthday"></label></td>
							<td class="FieldLabel" nowrap>民族:</td>
							<td class="FieldInput"><label name="nation" field="nation" dataset="NationDataset"></label></td>
						</tr>
						<tr>
							<td class="FieldLabel" nowrap>属地行政区划：</td>
							<td class="FieldInput"><label id="domicileName"  title="属地行政区划" field="domicileName"></label></td>
							<td class="FieldLabel" nowrap>住址行政区划：</td>
							<td class="FieldInput" colspan="3"><label id="apanageName" field="apanageName" title="行政区划"></label></td>
						</tr>
                        <tr>
                           <td class="FieldLabel" nowrap>住址：</td>
						   <td class="FieldInput" colspan="5"><label name="address" field="address" rows="2" cols="122%"></label></td>
                        </tr>
						<tr>
							<td class="FieldLabel" nowrap>文化程度：</td>
							<td class="FieldInput"><label name="eduCode" field="eduCode" dataset="EducationDataset"></label></td>
							<td class="FieldLabel" nowrap>健康状况：</td>
							<td class="FieldInput"><label name="healthCode" field="healthCode" dataset="HealthDataset"></label></td>
							<td class="FieldLabel" nowrap>婚姻状况：</td>
							<td class="FieldInput"><label name="marriageCode" field="marriageCode" dataset="MarriageDataset"></label></td>
						</tr>

						<tr>
							
							<td class="FieldLabel" nowrap>职业：</td>
							<td class="FieldInput"><label name="careerCode" field="careerCode" dataset="CareerDataset"></label></td>
							<td class="FieldLabel" nowrap>政治面貌：</td>
							<td class="FieldInput"><label name="politicalCode" field="politicalCode" dataset="PoliticalDataset"></label></td>
							<td class="FieldLabel" nowrap>户籍类别：</td>
							<td class="FieldInput"><label name="domicileType" field="domicileType" dataset="DomicileDataset"></label></td>
						</tr>
                        <tr>
							<td class="FieldLabel" nowrap>手机：</td>
							<td class="FieldInput"><label name="telMobile" field="telMobile"></label></td>
							<td class="FieldLabel" nowrap>其他联系方式：</td>
							<td class="FieldInput"><label name="telOther" field="telOther"></label></td>
							<td class="FieldLabel" nowrap>邮政编码：</td>
							<td class="FieldInput"><label name="postCode" field="postCode"></label></td>
						</tr>
                        <tr>
						    <td class="FieldLabel" nowrap>年收入：</td>
							<td class="FieldInput"><label name="incomeYear" field="incomeYear"></label></td>
							<td class="FieldLabel" nowrap>月收入：</td>
							<td class="FieldInput"><label name="incomeMonth" field="incomeMonth"></label></td>
							<td class="FieldLabel" nowrap>就业状况：</td>
							<td class="FieldInput"><label name="employmentCode" field="employmentCode" dataset="EmploymentCodeDataset"></label></td>
						</tr>
						 <tr>
							<td class="FieldLabel" nowrap>医疗保障方式：</td>
							<td class="FieldInput"><label name="safeguardType" field="safeguardType" dataset="SafeguardDataset"></label></td>
							<td class="FieldLabel" nowrap>医疗保险号：</td>
							<td class="FieldInput" colspan="3"><label name="medicalCode" field="medicalCode"></label></td>
						</tr>
                        <tr>
							<td class="FieldLabel" nowrap>工作单位名称：</td>
							<td class="FieldInput"><label name="workUnitName" field="workUnitName"></label></td>
							<td class="FieldLabel" nowrap>工作单位电话：</td>
							<td class="FieldInput" colspan="3"><label name="workUnitTel" field="workUnitTel"></label></td>
							
						</tr>
                        <tr>
                            <td class="FieldLabel" nowrap>工作单位地址：</td>
                            <td class="FieldInput" colspan="5"><label name="workUnitAdd" field="workUnitAdd" cols="122%"></label></td>
                        </tr>
                        <tr>
							<td class="FieldLabel" nowrap>备注：</td>
							<td class="FieldInput" colspan="5"><label name="note" field="note" cols="122%" rows="3"></label></td>
						</tr>
                      </table>
					</form>
				  </fieldset>
				</next:Html>
			</next:Panel>

			<next:Panel title="类别信息" autoHeight="true" autoWidth="true"
				id="familyTabPanel">
			<next:Html>
					<form id="editForm" dataset="BaseinfoFamilyDataSet" onsubmit="return false" style="padding: 5px;" class="L5form">
					<table border="1" width="100%">
					    <tr>
							<td class="FieldLabel">住房状况：</td>
							<td class="FieldInput"><label name="houseStatus" field="houseStatus" dataset="HouseStatusEnum"></label></td>
						    <td class="FieldLabel">房屋结构：</td>
							<td class="FieldInput"><label name="buildingStructure" field="buildingStructure" dataset="BuildingStructureEnum"></label></td>
							<td class="FieldLabel">房屋间数：</td>
							<td class="FieldInput"><label name="houseNumber" field="houseNumber"></label></td>	
						</tr>
						<tr>	
							<td class="FieldLabel">住房建筑时间：</td>
							<td class="FieldInput"><label name="buildingDate" field="buildingDate"></label></td>
							<td class="FieldLabel" nowrap="nowrap">人均建筑面积：</td>
							<td class="FieldInput"><label name="buildAverageArea" field="buildAverageArea"></label></td>
						    <td class="FieldLabel" nowrap="nowrap">享受购建房补助：</td>
							<td class="FieldInput" colspan="5"><label name="buildingSubsidyFlag" field="buildingSubsidyFlag" dataset="BuildingSubsidyDataset"></label></td>	
						</tr>
					</table>
				   </form>
				</next:Html>
			</next:Panel>
			<next:Panel title="状态变更" autoHeight="true" autoWidth="true"
				id="stateChangeTabPanel">
				<next:Html>
					<iframe id="instance" src="stateChangeDetail.jsp?peopleId='<%=request.getParameter("peopleId")%>'&username='<%=request.getParameter("username")%>
					'&idCard='<%=request.getParameter("idCard")%>'&objectState='<%=request.getParameter("objectState")%>'&objectType='<%=request.getParameter("objectType")%>'"
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="480">
	   				</iframe>
				</next:Html>
			</next:Panel>
			 <next:Panel title="档案管理" autoHeight="true" autoWidth="true"
				id="archiveTabPanel">
				<next:Html>
					<form id="editForm" dataset="BaseinfoFamilyDataSet"
						onsubmit="return false" style="padding: 5px;" class="L5form">
					<table border="1" width="90%">
					</table>
					</form>
				</next:Html>
			</next:Panel>
			<next:Panel title="信访管理" autoHeight="true" autoWidth="true"
				id="petitionTabPanel">
				<next:Html>
					<iframe id="instance" src="petitionDetail.jsp?peopleId='<%=request.getParameter("peopleId")%>'&username='<%=request.getParameter("username")%>
					'&idCard='<%=request.getParameter("idCard")%>'&objectType='<%=request.getParameter("objectType")%>'"
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="480">
	   				</iframe>
				</next:Html>
			</next:Panel>
			<next:Panel title="定期认证" autoHeight="true" autoWidth="true"
				id="regularIdentificationTabPanel">
				<next:Html>
					<iframe id="instance" src="regularIdentificationDetail.jsp?peopleId='<%=request.getParameter("peopleId")%>'&username='<%=request.getParameter("username")%>
					'&idCard='<%=request.getParameter("idCard")%>'&objectType='<%=request.getParameter("objectType")%>'"
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="480">
	   				</iframe>
				</next:Html>
			</next:Panel>
		</next:Tabs>
	</next:TabPanel>
</next:Panel>

</body>
</html>
