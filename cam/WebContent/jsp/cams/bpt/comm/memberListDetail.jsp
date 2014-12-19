<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<html>
	<head>
		<title>家庭成员列表</title>
		<next:ScriptManager/>
		<script language="javascript">
			var familyId='<%=request.getParameter("familyId")%>';
		</script>
		<script type="text/javascript" src="memberList.js"></script>
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
	<!-- 人员信息 -->
	<model:dataset id="BaseinfoPeopleDataSet" cmd="com.inspur.cams.bpt.manage.cmd.BptBaseinfoPeopleQueryCommand" method="queryPeopleInfo" global="true">
		<model:record fromBean="com.inspur.cams.comm.baseinfo.data.BaseinfoPeople">
			<model:field name="domicileName" type="string" />
			<model:field name="apanageName" type="string" />	
		</model:record>
	</model:dataset>
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
	<!-- 户籍类别 -->
	<model:dataset id="DomicileDataset" enumName="DOMICILE.TYPE" autoLoad="true" global="true"></model:dataset>
	<!-- 与户主关系 -->
	<model:dataset id="RelationshipTypeDataset" enumName="RELATIONSHIP.TYPE" autoLoad="true" global="true"></model:dataset>
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
	<!-- 工作单位性质 -->
	<model:dataset id="WorkUnitCharacterDataset" enumName="WORKUNIT.CHARACTER" autoLoad="true" global="true"></model:dataset>
	<!-- 就业状况 -->
	<model:dataset id="EmploymentCodeDataset" enumName="EMPLOYMENT.CODE" autoLoad="true" global="true"></model:dataset>
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
<next:Panel height="100%" width="100%">
<next:GridPanel id="editGridPanel" name="baseinfopeopleGrid" width="100%" height="21%" stripeRows="true" dataset="BaseinfoPeopleDataSet" >
	<next:Columns>
	    <next:RowNumberColumn header="序号" width="45"/>
	    <next:RadioBoxColumn></next:RadioBoxColumn>
	    
	    <next:Column id="domicileCode" header="属地行政区划" field="domicileName" width="130" >
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
		    
		<next:Column id="relationshipType" header="与户主关系" field="relationshipType" width="120" dataset="RelationshipTypeDataset" >
			<next:TextField allowBlank="false" />
		</next:Column>

		<next:Column id="eduCode" header="文化程度" field="eduCode" width="120"  dataset="EducationDataset">
			<next:TextField  />
		</next:Column>
	

		<next:Column id="marriageCode" header="婚姻状况" field="marriageCode" width="90" hidden="true" dataset="MarriageDataset" >
			<next:TextField  />
		</next:Column>

		<next:Column id="domicileType" header="户籍类别" field="domicileType" width="90" dataset="DomicileDataset" >
			<next:TextField  />
		</next:Column>
	
		<next:Column id="telMobile" header="手机" field="telMobile" width="90" >
			<next:TextField  />
		</next:Column>
	
	</next:Columns>
</next:GridPanel>

<next:Panel  width="100%"  autoScroll="true" id="peopleTabPanel">
				<next:Html>
					<fieldset>
					<form id="BaseinfoPeopleForm" method="post" dataset="BaseinfoPeopleDataSet" onsubmit="return false" style="padding: 5px;" class="L5form">
					<table border="0" width="98%">
					    <tr>
							<td class="FieldLabel"  nowrap style="width:15%">身份证件号码：</td>
							<td class="FieldInput" style="width:15%" nowrap="nowrap"><label field="idCard" title="身份证件号码"></label></td>
						    <td class="FieldLabel" style="width:15%">姓名：</td>
							<td class="FieldInput" style="width:15%"><label field="name" title="姓名"></label></td>
							<td class="FieldLabel" nowrap style="width:15%">与户主关系：</td>
							<td class="FieldInput"  style="width:15%"><label name="relationshipType" field="relationshipType" dataset="RelationshipTypeDataset" title="与户主关系"></label></td>
						</tr>
                        <tr>
							<td class="FieldLabel" >出生日期：</td>
							<td class="FieldInput" ><label name="birthday" field="birthday" title="出生日期"></label></td>
						    <td class="FieldLabel" >性别：</td>
							<td class="FieldInput" ><label name="sex" 	field="sex" dataset="SexDataset" title="性别"></label></td>
							<td class="FieldLabel" >民族：</td>
							<td class="FieldInput" ><label name="nation" field="nation" title="民族" dataset="NationDataset"></label></td>
						</tr>
						<tr>
							<td class="FieldLabel" >属地行政区划：</td>
							<td class="FieldInput" ><label name="domicileName" field="domicileName" title="属地行政区划"></label></td>
						    <td class="FieldLabel" >医疗保障方式：</td>
							<td class="FieldInput" ><label name="safeguardType" field="safeguardType" dataset="SafeguardDataset" title="医疗保障方式"></label></td>
                            <td class="FieldLabel" >医疗保险号：</td>
							<td class="FieldInput"  ><label name="medicalCode" field="medicalCode" title="医疗保险号"></label></td>
						</tr>
                        <tr>
							<td class="FieldLabel" >住址行政区划：</td>
							<td class="FieldInput" ><label name="apanageName" field="apanageName" title="住址行政区划"></label></td>
							<td class="FieldLabel" >地址：</td>
							<td class="FieldInput" colspan="3"><label  name="address" field="address" title="地址"></label></td>
						</tr>
						<tr>
							<td class="FieldLabel" nowrap="nowrap">联系方式（手机）：</td>
							<td class="FieldInput" ><label  name="telMobile" field="telMobile" title="联系方式(手机)"></label>	</td>
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
							<td class="FieldInput" ><label name="workUnitCharacter" field="workUnitCharacter" dataset="WorkUnitCharacterDataset" title="工作单位性质"></label></td>
							<td class="FieldLabel" nowrap="nowrap">工作单位电话：</td>
							<td class="FieldInput" ><label name="workUnitTel" field="workUnitTel" title="工作单位电话"></label></td>
						</tr>
                        <tr>
							<td class="FieldLabel" >工作单位地址：</td>
							<td class="FieldInput"  colspan="5"><label name="workUnitAdd" field="workUnitAdd" title="工作单位地址" style="width: 90%"></label></td>
						</tr>
                        <tr>
							<td class="FieldLabel" >备注：</td>
							<td class="FieldInput"  colspan="5"><label name="note" field="note" rows="3" title="备注"  style="width: 90%"></label></td>
						</tr>
                      </table>
					</form>
				 </fieldset>
				</next:Html>
			</next:Panel>
</next:Panel>
</body>
<script type="text/javascript">
	function init(){
		var BaseinfoPeopleDataSet = L5.DatasetMgr.lookup("BaseinfoPeopleDataSet");
		BaseinfoPeopleDataSet.setParameter("BASEINFO_PEOPLE.FAMILY_ID@=",familyId);
		//BaseinfoPeopleDataSet.setParameter("BASEINFO_PEOPLE.PERSONAL_STATS_TAG@=","0");
		BaseinfoPeopleDataSet.load();
		var queryTotalDataset = L5.DatasetMgr.lookup("queryTotalDataset");
		queryTotalDataset.setParameter("familyId",familyId);
		queryTotalDataset.load();
		L5.QuickTips.init();
	}
</script>
</html>
