<%@ page language="java" contentType="text/html;charset=utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.*"%>
<html>
<head>
<title>家庭成员基本信息</title>
<next:ScriptManager/>
<script type="text/javascript">
<%
	String organCodeStr = UserCommand.getSubOrganCode(BspUtil.getCorpOrgan().getOrganCode()) ;
%>
var peopleId = '<%=request.getParameter("peopleId")%>' ;
var familyId = '<%=request.getParameter("familyId")%>' ;
var flag = '<%=request.getParameter("flag")%>' ;
var rootPath='<%=SkinUtils.getRootUrl(request)%>';
var applyId= '<%=request.getParameter("applyId")%>' ;
var isMod= '<%=request.getParameter("isMod")%>' ;
var isChangeUpdate= '<%=request.getParameter("isChangeUpdate")%>' ;
var assistanceModeValue='<%=request.getParameter("assistanceModeValue")%>' ;
</script>
<script type="text/javascript" src="samBasePeopleInsert.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams/somPhoto.js")%>'></script>
<script type="text/javascript" src="<%=SkinUtils.getRootUrl(request)%>skins/js/ISEditPhoto.js"></script>
<script type="text/javascript" src="<%=SkinUtils.getJS(request,"cams.js") %>"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript" src="<%=SkinUtils.getRootUrl(request)%>jsp/cams/comm/dicm/autoComplete.js"></script>
<link href="<%=SkinUtils.getRootUrl(request)%>jsp/cams/comm/dicm/autoComplete.css" rel="stylesheet" type="text/css" />


</head>
<body>
<model:datasets>
	<!-- 家庭成员基本信息 -->
	<model:dataset id="baseinfoPeopleDataSet" cmd="com.inspur.cams.drel.sam.cmd.BaseinfoPeopleQueryCmd" global="true"  >
		<model:record fromBean="com.inspur.cams.comm.baseinfo.data.BaseinfoPeople">
			<model:field name="name" type="string" rule="require|length{30}"/>
			<model:field name="idCard" type="string" rule="require"/>
			<model:field name="sex" type="string" rule="require"/>
			<model:field name="nation" type="string" rule="require"/>
		    <model:field name="apanageName" type="string" rule="require"/>
            <model:field name="apanageCode" type="string" rule="require"/>
			<model:field name="marriageCode" type="string" rule="require"/>
			<model:field name="employmentCode" type="string" rule="require"/>
			<model:field name="politicalCode" type="string" rule="require"/>
			<model:field name="healthCode" type="string" rule="require"/>
			<model:field name="domicileType" type="string" rule="require"/>
			<model:field name="eduCode" type="string" rule="require"/>
			<model:field name="incomeYear" type="string" rule="require|regex{^[0-9]{1,16}}" />
			<model:field name="relationshipType" type="string" rule="require"/>
			<model:field name="note" type="string" rule="length{200}"/>
		</model:record>
	</model:dataset>	
	<!-- 人员类型 -->
	<model:dataset id="peopleTypeDataset" cmd="com.inspur.cams.drel.sam.cmd.SamPeopleTypeQueryCmd"	global="true">
		<model:record fromBean="com.inspur.cams.drel.sam.data.SamPeopleType"></model:record>
	</model:dataset>	
	<!-- 人员扩展信息（低保用） -->
	<model:dataset id="samPeopleExtendDataSet" cmd="com.inspur.cams.drel.sam.cmd.SamPeopleExtendQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.drel.sam.data.SamPeopleExtend"></model:record>
	</model:dataset>
	<!-- 家庭成员就业信息 -->
	<model:dataset id="samPeopleJobsDataSet"
		cmd="com.inspur.cams.drel.sam.cmd.SamPeopleJobsQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.drel.sam.data.SamPeopleJobs">
			<model:field name="unitName" type="string" rule="length{100}"/>
			<model:field name="address" type="string" rule="length{100}"/>
			<model:field name="contactPeople" type="string" rule="length{32}"/>
		</model:record>
	</model:dataset>
	<!-- 家庭成员教育信息 -->
	<model:dataset id="samPeopleEduDataSet"
		cmd="com.inspur.cams.drel.sam.cmd.SamPeopleEduCmd" global="true">
		<model:record fromBean="com.inspur.cams.drel.sam.data.SamPeopleEdu">
			<model:field name="school" type="string" rule="length{100}"/>
			<model:field name="contactPeople" type="string" rule="length{32}"/>
		</model:record>
	</model:dataset>
	<!-- 家庭成员保障性支出信息 -->
	<model:dataset id="samPeopleInsuranceDataSet"
		cmd="com.inspur.cams.drel.sam.cmd.SamPeopleInsuranceQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.drel.sam.data.SamPeopleInsurance">
			<model:field name="insuranceType" type="string" rule="require"/>
			<model:field name="insuranceFee" type="string" rule="regex{^[0-9]{1,14}(\.[0-9]{1,2}){0,1}$}"/>
			<model:field name="remarks" type="string" rule="length{100}"/>
		</model:record>
	</model:dataset>
	<!-- 人员患病信息 -->
	<model:dataset id="samPeopleDiseaseDataSet"
		cmd="com.inspur.cams.drel.sam.cmd.SamPeopleDiseaseCmd" global="true">
		<model:record fromBean="com.inspur.cams.drel.sam.data.SamPeopleDisease"></model:record>
	</model:dataset>
	<!-- 人员残疾信息 -->
	<model:dataset id="samPeopleDisabilityDataSet"
		cmd="com.inspur.cams.drel.sam.cmd.SamPeopleDisabilityCmd" global="true">
		<model:record fromBean="com.inspur.cams.drel.sam.data.SamPeopleDisability"></model:record>
	</model:dataset>
	<model:dataset id="sexDataset" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_SEX'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="DmMzDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_NATION'></model:param>
		</model:params>
	</model:dataset>
	<!-- 婚姻状况-->
	<model:dataset id="DmHyzkDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_MARRIAGE'></model:param>
		</model:params>
	</model:dataset>
	<!-- 就业状况-->
   <model:dataset id="DmZyDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_EMPLOYMENT_CODE'></model:param>			
			<model:param name="includeCode" value="31,32,99"></model:param>
		</model:params>
	</model:dataset>
	<!-- 政治面貌-->
	<model:dataset id="DmZzmmDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_POLITICAL'></model:param>
		</model:params>
	</model:dataset>
	<!-- 劳动能力 -->
	<model:dataset id="laborCapacityDataset" enumName="SAM_LABOR_CAPACITY" autoLoad="true" global="true"></model:dataset>
	<!-- 健康状况 -->
	<model:dataset id="healthCodeDataset" enumName="SAM_HEALTH_CODE" autoLoad="true" global="true"></model:dataset>
	<!-- 重病病种 -->
	<model:dataset id="diseaseTypeDataset"cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='dic_sam_disease_type'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 残疾类别 -->
	<model:dataset id="disabilityTypeDataset"cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_DISABILITY_TYPE'></model:param>
		</model:params>
	</model:dataset>
	<!-- 残疾等级 -->
	<model:dataset id="DmCjdjDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_HANDICAP_LEVEL'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="DmHjxzDataSet" enumName="SAM_DOMICILE_TYPE" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="comm_yesorno" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
	<!-- 文化程度-->
	<model:dataset id="eduDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='dic_education'></model:param>
		</model:params>
	</model:dataset>
	<!-- 学业状况 -->
	<model:dataset id="eduStatusDataset" enumName="SAM_EDU_STATUS" autoLoad="true" global="true"></model:dataset>
	<!-- 与户主关系 -->
	 <model:dataset id="relationshipTypeDataset" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_RELATIONSHIP_TYPE'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="assistanceTypeSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_ASSITANCE_TYPE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>	
	<model:dataset id="medicalStatusSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_MEDICAL_STATUS'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>	
	<!-- 人员分类救助类别 -->
	<model:dataset id="traditonTypeDataset" enumName="SAM_TRADITON_TYPE" autoLoad="true" global="true"></model:dataset>
	<!-- 单位性质 -->
	<model:dataset id="unitNatureDataset" enumName="SAM_UNIT_NATURE" autoLoad="true" global="true"></model:dataset>
	<!-- 隶属关系 -->
	<model:dataset id="affiliationDataset" enumName="SAM_AFFILIATION" autoLoad="true" global="true"></model:dataset>
	<!-- 学校类别 -->
	<model:dataset id="schoolTypeDataset" enumName="SAM_SCHOOL_TYPE" autoLoad="true" global="true"></model:dataset>
	<!-- 支出类型 -->
	<model:dataset id="insuranceTypeDataset" enumName="SAM_INSURANCE_TYPE" autoLoad="true" global="true"></model:dataset>
	<!-- 缴费周期 -->
	<model:dataset id="insuranceCycleDataset" enumName="SAM_INSURANCE_CYCLE" autoLoad="true" global="true"></model:dataset>
	<!-- 人员状态 -->
	<model:dataset id="samPersonalStatsDataSet" enumName="SAM_PERSONAL_STATS_TAG" autoLoad="true" global="true"></model:dataset>
		<model:dataset id="dicCityDs" cmd="com.inspur.cams.comm.diccity.cmd.DicCityQueryCommand" global="true" pageSize="8">
		<model:record fromBean="com.inspur.cams.comm.diccity.data.DicCity"></model:record>
			<model:params>
			<model:param name="id@rlike" value='<%=organCodeStr%>'></model:param>
		</model:params>
	</model:dataset>
</model:datasets>
<!-- 人员录入窗口 -->
<next:Panel id="peopleWin" title="" height="600" width="1000" autoScroll="true">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem id="newIdCard" iconCls="add" text="生成身份代码" handler="newIdCard" hidden="true"/>
		<next:ToolBarItem iconCls="save" id="confirmPeopleId"  text="确定" handler="confirmPeople"></next:ToolBarItem>		
		<next:ToolBarItem iconCls="return" id="closePeopleId" text="关闭" handler="closePeople"></next:ToolBarItem>		
	</next:TopBar>
	<next:Panel title="家庭成员基本信息" titleCollapse="true" collapsible="true">
	<next:Html>
		<form id="BaseinfoPeopleForm" method="post" dataset="baseinfoPeopleDataSet" onsubmit="return false"
			 class="L5form">
		<table border="0" width="100%">
		<tr>
			<td class="FieldLabel" width="10%">姓名</td>
			<td class="FieldInput" width="15%"><input type="text"  id="peopleName"  name="姓名"title="姓名" field="name" style="width:90%" maxlength="25"/><font color="red">*</font>
			<td class="FieldLabel" width="10%">身份证号码</td>
			<td class="FieldInput" width="15%"><input type="text" id='idCard_people' name="身份证号码"title="身份证号码" field="idCard" style="width:90%" onchange='checkIdCard_people()' maxlength="18"/><font color="red">*</font>
			<td class="FieldLabel" width="10%">性别</td>
			<td class="FieldInput" width="15%"><select name="性别" title="性别" id='sex' field="sex" style="width:90%"> <option dataset="sexDataset"> </select><font color="red">*</font></td>
			<td class="FieldInput" width="10%" rowspan="4">
				<div id="photoDiv1">
					<img id="img1" name="RELATIONER_PHOTOC_IMG1" width=82.5 height=110 src="<%=SkinUtils.getRootUrl(request) %>jsp/cams/sorg/comm/signet/default.jpg" 
						align="top" ondblclick="editPhoto(11,'photoId1','RELATIONER_PHOTOC_IMG1');"
						onerror="javascript:this.src='<%=SkinUtils.getRootUrl(request) %>jsp/cams/sorg/comm/signet/default.jpg'" alt="暂无图片" />
					<input type="hidden" id="photoId1" name="photoId1"/>
				</div>
			</td>
			</tr>
			<tr>
				<td class="FieldLabel">出生日期</td>
				<td class="FieldInput"><input type="text"
							name="出生日期" title="出生日期" field="birthday" style="width:80%"  format="Y-m-d" onclick="LoushangDate(this)" readonly="readonly" onblur="getAge(this.value);"/><font color="red">*</font></td>
				<td class="FieldLabel">年龄</td>
				<td class="FieldInput"><label id="age"></label></td>
				<td class="FieldLabel">民族</td>
				<td class="FieldInput"><select name="民族" title="民族" field="nation" style="width:90%"><option dataset="DmMzDataSet"></option> </select><font color="red">*</font></td>
			</tr>
			<tr>

				<td class="FieldLabel">婚姻状况</td>
				<td class="FieldInput"><select name="婚姻状况" title="婚姻状况" field="marriageCode" style="width:90%"> <option dataset="DmHyzkDataSet"></option> </select><font color="red">*</font></td>
				<td class="FieldLabel">就业状况</td>
				<td class="FieldInput"><select name="就业状况" title="就业状况" field="employmentCode" style="width:90%"> <option dataset="DmZyDataSet"></option> </select><font color="red">*</font></td>
				<td class="FieldLabel">政治面貌</td>
				<td class="FieldInput"><select name="政治面貌" title="政治面貌" field="politicalCode" style="width:90%"> <option dataset="DmZzmmDataSet"> </option></select><font color="red">*</font></td>
			</tr>
			<tr>
				<td class="FieldLabel">劳动能力</td>
				<td class="FieldInput"><select name="劳动能力" title="劳动能力" id="laborCapacity" style="width:90%"> <option dataset="laborCapacityDataset"></option> </select><font color="red">*</font></td>
				<td class="FieldLabel">健康状况</td>
				<td class="FieldInput"><select name="健康状况" title="健康状况" id='healthCode' field="healthCode" style="width:90%" onblur='getDiseaseType()'> <option dataset="healthCodeDataset"></option> </select><font color="red">*</font></td>
			    <td class="FieldLabel">重病病种</td>
                <td class="FieldInput"><select name="重病病种" title="重病病种" id="diseaseType" style="width:90%"> <option dataset="diseaseTypeDataset"></option> </select></td>
			</tr>
			<tr>
				<td class="FieldLabel">残疾类别</td>
				<td class="FieldInput"><select name="残疾类别" title="残疾类别" id="disabilityType" style="width:90%" onblur='getDisabilityLevel()'> <option dataset="disabilityTypeDataset"></option> </select></td>
				<td class="FieldLabel">残疾等级</td>
				<td class="FieldInput"><select name="残疾等级" title="残疾等级" id="disabilityLevel" style="width:90%"> <option dataset="DmCjdjDataSet"></option> </select></td>
				<td class="FieldLabel">户籍类别</td>
                <td class="FieldInput"  colspan="2"><select name="户籍类别" title="户籍类别" id="domicileType" field="domicileType" style="width:90%" > <option dataset="DmHjxzDataSet"> </option></select><font color="red">*</font></td>
				
			</tr>
			<tr>
				<td class="FieldLabel">是否保障对象</td>
				<td class="FieldInput"><select name="是否保障对象" title="是否保障对象" id="isAssistance" style="width:90%"> <option dataset="comm_yesorno"></option> </select><font color="red">*</font></td>
				<td class="FieldLabel">学业状况</td>
				<td class="FieldInput"><select name="学业状况" title="学业状况" id="eduStatus" style="width:90%"> <option dataset="eduStatusDataset"></option> </select><font color="red">*</font></td>
				<td class="FieldLabel">文化程度</td>
				<td class="FieldInput" colspan="2"><select name="文化程度" title="文化程度" field="eduCode" style="width:90%"> <option dataset="eduDataSet"> </option></select><font color="red">*</font></td>
			</tr>
			<tr>
			    
				<td class="FieldLabel">年收入（元）</td>
				<td class="FieldInput"><input name="年收入（元）" id="incomeMonthD" type="text" field='incomeYear' style="width:90%" maxlength="14"/><font color="red">*</font></td>
				<td class="FieldLabel">与户主关系</td>
				<td class="FieldInput"><select id="relationshipType" style="width:90%" name="与户主关系"  title="与户主关系" field="relationshipType" style="width:90%" onblur='hasSelf()'> <option dataset="relationshipTypeDataset"></option> </select><font color="red">*</font></td>
				 <td class="FieldLabel" >户籍地址<font color="red" >(点击？选择或者输入汉字、首字母拼音检索)</font></td>
                 <td class="FieldInput" colspan='2'>
                	 <input type="text" style="width:68%" name="户籍地址" title="户籍地址" id="lrdwmc" field="apanageName" onkeyup="findDiv2(this,'lrdwId','popup','','dicCityDs','PY_CAPITAL@like','NAME@like','id','name','30')" onblur="clearDiv()"  style="width:300"/>
		                	 <div id="popup" style="width:300px; height: 150px; display: none;position: absolute;background-color: #FFFFFF;" >  
      								<ul></ul> </div>
						<input type="text" style="display: none;"  name="户籍地址代码" id="lrdwId" field="apanageCode" />
                    <img src="<%=SkinUtils.getImage(request,"l5/help.gif")%>"  style="cursor:hand" onclick="func_ForApanageSelect()" /><font color="red">*</font>   
                </td>
			</tr>
				<tr>
				<td class="FieldLabel">参保类型</td>
				<td class="FieldInput"><select name='参保类型' title='参保类型' field='safeguardType' style="width:90%"> <option dataset="medicalStatusSelect"> </option></select></td>
				<td class="FieldLabel">医疗证号</td>
				<td class="FieldInput"><input name="医疗证号" title="医疗证号" type="text" field='medicalCode' style="width:90%" maxlength="30" /></td>
				<td class="FieldInput"  colspan="3"></td>
			</tr>
			<tr>
				<td class="FieldLabel">备注</td>
				<td class="FieldInput" colspan="6"><textarea name="备注" title="备注"  rows="4" style="width:93.5%" field='note'></textarea></td>
			</tr>
			<tr>
				<td class="FieldLabel" style="width: 15%">人员类型</td>
				<td class="FieldInput" style="width: 18%" colspan="6">
			    	<input type="text" id='peopleTypeName' style="width:93.5%" readOnly="true" />
					<img src="<%=SkinUtils.getImage(request, "l5/help.gif")%>" style="cursor:hand" onclick="openTypeWin()"/>
					<input type="hidden" id='peopleType'>
				</td>
			</tr>
		</table>
		</form>
	</next:Html>
	</next:Panel>
	<next:Panel title="家庭成员就业信息" titleCollapse="true" collapsible="true"  >
		<next:Html>
			<form method="post" onsubmit="return false" class="L5form" dataset='samPeopleJobsDataSet'>
				<table width="100%">
					<tr>
						<td class="FieldLabel" style="width:10%">单位名称</td>
						<td class="FieldInput" colspan='3'><input type="text" name='单位名称' field='unitName' style="width:96%" maxlength="100"/></td>
						<td class="FieldLabel" style="width:10%">单位性质</td>
						<td class="FieldInput" style="width:25%"><select name="单位性质" field="unitNature" style="width:80%"> <option dataset='unitNatureDataset'></option> </select></td>
					</tr>
					<tr>
						<td class="FieldLabel" style="width:10%">就业地点</td>
						<td class="FieldInput" style="width:15%"><input type="text" name='就业地点' field='address' style="width:90%" maxlength="120"/></td>
						<td class="FieldLabel" style="width:10%">隶属关系</td>
						<td class="FieldInput" style="width:15%"><select name="隶属关系" field="affiliation" style="width:90%"> <option dataset='affiliationDataset'></option> </select></td>
						<td class="FieldLabel" style="width:10%">联系电话</td>
						<td class="FieldInput" style="width:25%"><input type="text" name='联系电话' field='contactPhone' id='contactPhone_jobs' style="width:80%" maxlength="20"/></td>
					</tr>
					<tr>
						<td class="FieldLabel" style="width:10%">联系人</td>
						<td class="FieldInput" style="width:15%"><input field='contactPeople' name='联系人' style="width:90%" maxlength="20"/></td>
						<td class="FieldLabel" style="width:10%"></td>
						<td class="FieldInput" style="width:15%"></td>
						<td class="FieldLabel" style="width:10%"></td>
						<td class="FieldInput" style="width:25%"></td>
					</tr>		
				</table>
			</form>
		</next:Html>
	</next:Panel>
	<next:Panel title="家庭成员教育信息" titleCollapse="true" collapsible="true"  >
		<next:Html>
			<form method="post" onsubmit="return false" class="L5form" dataset='samPeopleEduDataSet'>
				<table width="100%">
					<tr>
						<td class="FieldLabel" style="width:10%">在读学校名称</td>
						<td class="FieldInput" colspan='3'><input type="text" name="在读学校名称" title="在读学校名称" field="school" style="width:96%" maxlength="100"/></td>
						<td class="FieldLabel" style="width:10%">学校类别</td>
						<td class="FieldInput" style="width:15%"><select name="学校类别" title="学校类别" field="schoolType" style="width:80%"><option dataset='schoolTypeDataset'></option></select></td>
					</tr>
					<tr>
						<td class="FieldLabel" style="width:10%">联系人</td>
						<td class="FieldInput" style="width:15%"><input type="text" name='联系人' field='conectPeople' style="width:90%" maxlength="20"/></td>
						<td class="FieldLabel" style="width:10%">联系电话</td>
						<td class="FieldInput" style="width:15%"><input type="text" name='联系电话' field='conectPhone' id='contactPhone_edu' style="width:90%" maxlength="20"/></td>
						<td class="FieldLabel" style="width:10%">入学时间</td>
						<td class="FieldInput" style="width:25%"><input type="text" name='入学时间' style="width:80%" field='entranceDate' format="Y-m-d" onclick="LoushangDate(this);" readonly="readonly"/></td>
					</tr>
				</table>
			</form>
		</next:Html>
	</next:Panel>
	<next:EditGridPanel  titleCollapse="true" collapsible="true" id='SamPeopleInsuranceEditGridPanel'
			 stripeRows="true"autoHeight="true" dataset="samPeopleInsuranceDataSet" title="家庭成员保障性支出信息">
		<next:TopBar>
			<next:ToolBarItem symbol="->"></next:ToolBarItem>
			<next:ToolBarItem iconCls="add" id="addInsuranceId" text="新增" handler="addInsurance" />
			<next:ToolBarItem iconCls="remove" id="removeInsuranceId" text="删除" handler="removeInsurance" />
		</next:TopBar>
		<next:Columns>
			<next:RowNumberColumn />
			<next:RadioBoxColumn></next:RadioBoxColumn>
			<next:Column id="insuranceType" header="支出类型" field="insuranceType"
				width="150" >
				<next:ComboBox dataset='insuranceTypeDataset' displayField="text" valueField="value" typeAhead="true"/>
			</next:Column>
			<next:Column id="insuranceFee" header="缴纳金额（元）" field="insuranceFee" align='right'
				width="150">
				<next:TextField />
			</next:Column>

			<next:Column id="insuranceCycle" header="缴费周期" field="insuranceCycle"
				width="150" >
				<next:ComboBox dataset='insuranceCycleDataset' displayField="text" valueField="value" typeAhead="true"/>
			</next:Column>

			<next:Column id="remarks" header="备注" field="remarks" width="150">
				<next:TextField />
			</next:Column>
		</next:Columns>
	</next:EditGridPanel>
</next:Panel>

<jsp:include page="../../../comm/newPeopleIdCard.jsp" flush="true"></jsp:include>
<jsp:include page="../../../comm/assistanceType.jsp" flush="true">   
	<jsp:param name= "ifPeople" value= "1"/> 
	<jsp:param name= "assistanceType" value= "02"/> 
</jsp:include>	
</body>
</html>