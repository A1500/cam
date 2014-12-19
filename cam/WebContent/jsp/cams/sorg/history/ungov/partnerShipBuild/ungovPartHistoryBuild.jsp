<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next" %>
<%@ taglib uri="/tags/next-model" prefix="model" %>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="com.inspur.cams.sorg.util.ApplyType"%>
<%@ page import="com.inspur.cams.sorg.util.SomIdHelp"%>
<%@ page import="com.inspur.cams.comm.util.IdHelp"%>
<%@ page import="com.inspur.cams.sorg.util.SomDutyDuties"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
<head>
<title>历史数据采集-民办非企业单位（合伙）成立登记</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript">
	<%
		String sorgId=request.getParameter("sorgId");
		if(sorgId==null){
			sorgId=SomIdHelp.getUngovSorgId();
		}
		String taskCode=request.getParameter("taskCode");
		if(taskCode==null){
			taskCode=SomIdHelp.getUngovTaskCode();
		}
		String searchSorgCode = request.getParameter("searchSorgCode");
		if(searchSorgCode==null){
			searchSorgCode="";
		}
		String searchCnName = request.getParameter("searchCnName");
		if(searchCnName==null){
			searchCnName="";
		}
		String legalDuties=SomDutyDuties.SOM_LEGAL_PEOPLE;
	%>
	var sorgId='<%=sorgId%>';
	var applyType='<%=ApplyType.SOM_UNGOV_BUILD_PARTNERSHIP%>';//业务类型
	var taskCode='<%=taskCode%>';//业务编号
	var method='<%=request.getParameter("method")%>';
	var fileCodeF = "M015";//法定代表人法律要件
	var legalDutyId = '<%=IdHelp.getUUID32()%>';//法定代表人dutyId
	var searchSorgCode = '<%=searchSorgCode%>';
	var searchCnName = '<%=searchCnName%>';
	var legalDuties = '<%=legalDuties%>';
</script>
<script type="text/javascript" src="ungovPartHistoryBuild.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js") %>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams/sorgUpload.js")%>'></script>
<script type="text/javascript">var rootPath='<%=SkinUtils.getRootUrl(request)%>';</script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"My97DatePicker/WdatePicker.js") %>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams/somPhoto.js") %>'></script>
<script type="text/javascript" src="<%=SkinUtils.getRootUrl(request)%>skins/js/ISEditPhoto.js"></script>
</head>
<body>
<%--定义dataset--%>
<model:datasets>
	<%--民办非企业基本信息--%>
	<model:dataset id="somOrganDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomOrganQueryCmd" global="true" method="queryOrgan">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomOrgan">
			<model:field name="sorgCode" type="string" rule="require|length{20}" />
			<model:field name="organCode" type="string" rule="length{10}" />
			<model:field name="cnName" type="string" rule="require|length{100}" />
			<model:field name="enName" type="string" rule="length{100}" />
			<model:field name="abName" type="string" rule="length{50}" />
			<model:field name="regMon" type="string" rule="double|length{100}" />
			<model:field name="residence" type="string" rule="length{100}" />
			<model:field name="sorgAdds" type="string" rule="length{200}" />
			<model:field name="sorgEmail" type="string" rule="length{100}" />
			<model:field name="actArea" type="string" rule="length{50}" />
			<model:field name="purpose" type="string" rule="length{1000}" />
			<model:field name="business" type="string" rule="length{1000}" />
			<model:field name="unitsNum" type="string" rule="integer" />
			<model:field name="peopleNum" type="string" rule="integer" />
			<model:field name="councilNum" type="string" rule="integer" />
			<model:field name="standCouncilNum" type="string" rule="integer" />
			<model:field name="fundingPeople" type="string" rule="length{500}" />
			<model:field name="checkCapitalOrgan" type="string" rule="length{100}" />
			<model:field name="moneySource" type="string" rule="length{500}" />
			<model:field name="housingOrgan" type="string" rule="length{100}" />
			<model:field name="leasePeriod" type="string" rule="length{100}" />
		</model:record>
	</model:dataset>
	<!-- 负责人信息 -->
	<model:dataset id="somDutyDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomDutyQueryCmd" global="true" method="queryPeople"  pageSize="100">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomDuty"></model:record>
	</model:dataset>
	<!-- 法定代表人信息 -->
	<model:dataset id="LegalPeopleDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomDutyQueryCmd" global="true" method="queryPeople">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomDuty">
			<model:field name="name" type="string" rule="require|length{72}" />
			<model:field name="idCard" type="string" rule="require|length{18}" />
			<model:field name="profession" type="string" rule="length{50}" />
			<model:field name="populace" type="string" rule="length{100}" />
			<model:field name="adds" type="string" rule="length{100}" />
			<model:field name="postCode" type="string" rule="length{6}" />
			<model:field name="phone" type="string" rule="length{30}" />
			<model:field name="sorgDuties" type="string" rule="length{100}" />
			<model:field name="populace" type="string" rule="length{100}" />
			<model:field name="personUnit" type="string" rule="length{100}" />
			<model:field name="personUnitPhone" type="string" rule="length{100}" />
			<model:field name="workDuties" type="string" rule="length{50}" />
			<model:field name="resume" type="string" rule="length{1000}" />
		</model:record>
	</model:dataset>
	<!-- 届次信息 -->
	<model:dataset id="somSessionDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomSessionQueryCmd">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomSession"></model:record>
	</model:dataset>
	<!-- 负责人录入窗口 -->
	<model:dataset id="somDutyInsertDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomDutyQueryCmd" global="true" method="queryPeople">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomDuty">
			<model:field name="name" type="string" rule="require|length{72}" />
			<model:field name="phone" type="string" rule="length{30}" />
			<model:field name="sorgDuties" type="string" rule="length{100}" />
			<model:field name="populace" type="string" rule="length{100}" />
			<model:field name="personUnit" type="string" rule="length{100}" />
			<model:field name="workDuties" type="string" rule="length{50}" />
			<model:field name="resume" type="string" rule="length{1000}" />
		</model:record>
	</model:dataset>
	<%--人员简历 --%>
	<model:dataset id="somResumeDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomPeopleResumeQueryCommand" sortField="startDate" sortDirection="DESC">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomPeopleResume"></model:record>
	</model:dataset>
	<%--法定代表人人员简历 --%>
	<model:dataset id="somResumeLegalDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomPeopleResumeQueryCommand">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomPeopleResume"></model:record>
	</model:dataset>
	<%--人员简历 --%>
	<model:dataset id="somResumeInsertDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomPeopleResumeQueryCommand">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomPeopleResume"></model:record>
	</model:dataset>
	<%--内设机构--%>
	<model:dataset id="somOfficeDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomOfficeQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomOffice">
		</model:record>
	</model:dataset>
	<model:dataset id="winOfficeDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomOfficeQueryCmd">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomOffice">
		</model:record>
	</model:dataset>
	<%--所有符合身份证号的人员列表--%>
	<model:dataset id="winPeopleDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomPeopleQueryCmd" >
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomPeople"></model:record>
	</model:dataset>
	<%--所有符合身份证号的人员列表--%>
	<model:dataset id="winDutyDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomDutyQueryCmd" >
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomDuty"></model:record>
	</model:dataset>
	<!-- 章程核准信息 -->
	<model:dataset id="somRuleDataSet"cmd="com.inspur.cams.sorg.base.cmd.SomRuleQueryCmd" global="true" method="queryRule">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomRule">
			<model:field name="shouldNum" type="string" rule="number|length{6}"/>
		    <model:field name="realNum" type="string" rule="number|length{6}"/>
		    <model:field name="passNum" type="string" rule="number|length{6}"/>
		    <model:field name="nopassNum" type="string" rule="number|length{6}"/>
		    <model:field name="giveupNum" type="string" rule="number|length{6}"/>
		    <model:field name="mainQuestion" type="string" rule="length{1000}"/>
		</model:record>
	</model:dataset>
	<%--电子档案--%>
	<model:dataset id="somElectronicDataSet" cmd="com.inspur.cams.sorg.upload.cmd.SomElectronicQueryCmd" global="true" method="queryCatalog">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomElectronic"></model:record>
	</model:dataset>
	<%--下载窗口--%>
	<model:dataset id="downloadDataSet" cmd="com.inspur.cams.sorg.upload.cmd.SomElectronicQueryCmd" method="queryElectronic">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomElectronic"></model:record>
	</model:dataset>
	<%--电子档案上传窗口--%>
	<model:dataset id="winElectronicDataSet" cmd="com.inspur.cams.sorg.upload.cmd.SomElectronicQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomElectronic"></model:record>
	</model:dataset>
	<%--法定代表人员电子档案--%>
	<model:dataset id="somLegalPeopleElectronicDataSet" cmd="com.inspur.cams.sorg.upload.cmd.SomElectronicQueryCmd" global="true" method="queryPeopleCatalog" >
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomElectronic"></model:record>
	</model:dataset>
	<%--法定代表人员电子档案上传窗口--%>
	<model:dataset id="winLegalPeopleElectronicDataSet" cmd="com.inspur.cams.sorg.upload.cmd.SomElectronicQueryCmd" global="true" method="queryPeopleElectronic">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomElectronic"></model:record>
	</model:dataset>
	<%--业务意见--%>
	<model:dataset id="somApplyDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomApplyQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomApply">
		</model:record>
	</model:dataset>

	<%--定义字典表--%>
	<model:dataset id="cataLogCodeSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='SOM_CATALOG'></model:param>
			<model:param name="value" value='CATALOG_CODE'></model:param>
			<model:param name="text" value='CATALOG_NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 社会组织种类 -->
	<model:dataset id="sorgKindSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_UNGOV_KIND'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 政治面貌 -->
	<model:dataset id="politicsSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_POLITICAL'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 住所来源 -->
	<model:dataset id="resideSourceSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_RESIDE_SOURCE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 住所来源 -->
	<model:dataset id="sorgNameSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='SOM_ORGAN'></model:param>
			<model:param name="value" value='SORG_ID'></model:param>
			<model:param name="text" value='CN_NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 所属行事业 -->
	<model:dataset id="busScopeSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_BUS_SCOPE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 社会组织职务 -->
	<model:dataset id="sorgDutiesSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_SOM_DUTY'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 专兼职 -->
	<model:dataset id="ifFulltimeSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_IF_FULLTIME'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 民族 -->
	<model:dataset id="folkSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_NATION'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 是否在任 -->
	<model:dataset id="ifServeSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_DUTY_IF_SERVE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 业务主管单位 -->
	<model:dataset id="businessOrganSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true" sortField="ORDER_NUMBER">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='SOM_BUSINESS_ORGAN'></model:param>
			<model:param name="value" value='BORG_CODE'></model:param>
			<model:param name="text" value='BORG_NAME'></model:param>
			<model:param name="filterSql" value='<%="MORG_CODE ="+BspUtil.getOrganCode().substring(0,6)%>'></model:param>
		</model:params>
	</model:dataset>
	<!-- 证件类型 -->
	<model:dataset id="cardTypeSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_CARD_TYPE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 会议类型 -->
	<model:dataset id="meetingType" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_SOM_MEETING_TYPE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 性别 -->
	<model:dataset id="sexSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_SEX'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 文化程度 -->
	<model:dataset id="educationSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_EDUCATION'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="comm_yesorno" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="opinionSelect" enumName="WORKFLOW.OPINION" autoLoad="true" global="true"></model:dataset>
</model:datasets>
<%--定义界面--%>
<next:Panel width="100%" height="100%">
	<next:TopBar>
		<next:ToolBarItem symbol="历史数据采集-民办非企业单位（合伙）成立登记"></next:ToolBarItem>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="save" text="保存" handler="save"></next:ToolBarItem>
		<next:ToolBarItem iconCls="return" text="返回" handler="goBack"></next:ToolBarItem>
	</next:TopBar>
	<next:TabPanel width="100%" height="100%" id="tab">
		<next:Tabs>
			<next:Panel title="登记申请表" width="100%" >
				<next:Panel width="100%" height="100%" autoScroll="true">
					<next:Html>
						<fieldset>
							<form method="post" dataset="somOrganDataSet" onsubmit="return false" class="L5form">
							<table width="100%">
								<tr>
									<td class="FieldLabel"style="width:17%">民办非企业中文名称：</td>
									<td class="FieldInput" style="width:51%"colspan="3"><input type="text" id="cnName" name='民办非企业中文名称' field="cnName"  style="width:97%"onblur="cnNameUK()"/><span style="color:red">*</span></td>
									<td class="FieldLabel" style="width:17%">电话：</td>
									<td class="FieldInput" style="width:17%"><input type="text" id="sorgPhone" name='民办非企业电话' field="sorgPhone" style="width:90%"/></td>
								</tr>
								<tr>
									<td class="FieldLabel" style="width:17%">登记证号：</td>
									<td class="FieldInput" style="width:17%"><input type="text" id="sorgCode"  name='登记证号' field="sorgCode" onkeyup="value=value.replace(/[^\\w\.\/]/ig,'').toUpperCase()"  style="width:90%"/><span style="color:red">*</span></td>
									<td class="FieldLabel" style="width:17%">组织机构代码：</td>
									<td class="FieldInput" style="width:17%"><input type="text" id="organCode" name='登记证号' field="organCode" style="width:90%"/></td>
									<td class="FieldLabel" style="width:15%">邮编：</td>
									<td class="FieldInput" style="width:17%"><input type="text" id="sorgPost" name='民办非企业邮编' field="sorgPost" style="width:90%"/></td>
								</tr>
								<tr>
									<td class="FieldLabel" style="width:17%">登记日期：</td>
									<td class="FieldInput" style="width:17%"><input type="text" name='登记日期' id="regDate" field="regDate" onClick="WdatePicker()" style="width:90%"/><span style="color:red">*</span></td>
									<td class="FieldLabel" style="width:17%">成立日期：</td>
									<td class="FieldInput" style="width:17%"><input type="text" name='成立日期' field="buildDate" onClick="WdatePicker()" style="width:90%"/></td>
									<td class="FieldLabel" style="width:15%"></td>
									<td class="FieldInput" style="width:17%"></td>
								</tr>
								<tr>
									<td class="FieldLabel" style="width:17%">住所来源：</td>
									<td class="FieldInput" style="width:17%"><select field="resideSource" onchange="changeResideSource();" id="resideSource" name='住所来源' style="width:90%""><option dataset="resideSourceSelect"></option></select></td>
									<td class="FieldLabel" style="width:17%">住所：</td>
									<td class="FieldInput" colspan="3"><input type="text" name='住所' field="residence" style="width:97%"/></td>
								</tr>
								<tr>
									<td class="FieldLabel" style="width:17%">所属行（事）业：</td>
									<td class="FieldInput"><select field="busScope" name='所属行（事）业' style="width:90%"><option  dataset="busScopeSelect"></option></select></td>
									<td class="FieldLabel" style="width:17%">从业人员数：</td>
									<td class="FieldInput"><input type="text" id="unitsNum" name='从业人员数' field="engagedNum" maxlength="6" style="width:90%"/></td>
									<td class="FieldLabel" style="width:15%">其中执业人员数：</td>
									<td class="FieldInput"><input type="text" id="peopleNum" name='其中执业人员数' field="practiceNum" maxlength="6" style="width:90%"/></td>
								</tr>
								<tr>
									<td class="FieldLabel">宗旨：</td>
									<td class="FieldInput" colspan="5"><textarea rows="5" name='民办非企业宗旨' field="purpose" style="width:98%"></textarea></td>
								</tr>
								<tr>
									<td class="FieldLabel">业务范围：</td>
									<td class="FieldInput" colspan="5"><textarea rows="5" name='业务范围' field="business" style="width:98%"></textarea></td>
								</tr>
								<tr>
									<td class="FieldLabel">基本设备、设施：</td>
									<td class="FieldInput" colspan="5"><textarea rows="5" name='基本设备、设施' field="facilities" style="width:98%"></textarea></td>
								</tr>
								<tr>
									<td class="FieldLabel">开办资金数额：</td>
									<td class="FieldInput"><input type="text" id="regMon" name='开办资金数额' field="regMon" maxlength="10" style="width:68%"/>万元</td>
									<td class="FieldLabel">验资单位：</td>
									<td class="FieldInput" colspan="3"><input type="text" name='验资单位' field="checkCapitalOrgan" style="width:97%"></td>
								</tr>
								<tr>
									<td class="FieldLabel">开办资金来源：</td>
									<td class="FieldInput" colspan="5"><input type="text" name='开办资金来源' field="moneySource" style="width:98%"/></td>
								</tr>
								<tr>
									<td class="FieldLabel">住所产权单位：</td>
									<td class="FieldInput" colspan="3"><input type="text" name='住所产权单位' field="housingOrgan" style="width:97%"/></td>
									<td class="FieldLabel">用房面积：</td>
									<td class="FieldInput"><input type="text" id="housingArea" name='用房面积' field="housingArea" maxlength="10" style="width:65%"/>平方米</td>
								</tr>
								<tr id="leasePeriod" style="display:none">
									<td class="FieldLabel">租（借）期限：</td>
									<td class="FieldInput" colspan="5"><input type="text" field="leasePeriod" style="width:98%"/></td>
								</tr>
								<tr>
									<td class="FieldLabel">民办非企业通信地址：</td>
									<td class="FieldInput"><input type="text"name='民办非企业通信地址' id="sorgAdds" field="sorgAdds" style="width:90%"/></td>
									<td class="FieldLabel">民办非企业电子邮箱：</td>
									<td class="FieldInput"><input type="text" name='民办非企业电子邮箱' field="sorgEmail" style="width:90%"/></td>
									<td class="FieldLabel" style="width:15%">民办非企业传真：</td>
									<td class="FieldInput" style="width:17%"><input type="text" id="sorgFax" field="sorgFax" style="width:90%"/></td>
								</tr>
							</table>
							</form>
						</fieldset>
						<fieldset>
							<legend>业务主管单位意见</legend>
							<form method="post" dataset="somApplyDataSet" onsubmit="return false" class="L5form" >
							<table width="100%">
								<tr>
									<td class="FieldLabel">业务主管单位：</td>
									<td class="FieldInput" colspan="3">
									<input type="text" id="borgNameDispaly" name="borgNameDispaly"  title="业务主管单位"  onkeyup="findDiv(this,'borgName','popup','','businessOrganAuto','BORG_NAME@like','borgCode','borgName','35')" onblur="clearDiv()" onchange="clearBorg(this)"/><img src="<%=SkinUtils.getImage(request,"l5/help.gif")%>" style="cursor:hand" onclick="showBorgWin()"/>
									<div id="popup" style="width:300px; height: 150px; display: none;position: absolute;background-color: #FFFFFF;" >
        								<ul></ul>
   									</div>
   									<input type="hidden" id="borgName" name="borgName" field="borgName" title="业务主管单位代码"/>
									<span style="color:red">*</span></td>

									<td class="FieldLabel" style="width:17%">业务主管单位审查同意日期：</td>
									<td class="FieldInput" style="width:17%"><input type="text" name='业务主管单位审查同意日期' field="borgCheckDate" onClick="WdatePicker()" style="width:90%"/></td>
								</tr>
								<tr>
									<td class="FieldLabel" style="width:17%">单位负责人：</td>
									<td class="FieldInput" style="width:17%"><input type="text" id="borgPeople" field="borgPeople" style="width:90%"/></td>
									<td class="FieldLabel" style="width:17%">单位电话：</td>
									<td class="FieldInput" style="width:17%"><input type="text" id="borgPhone" field="borgPhone" style="width:90%"/></td>
									<td class="FieldLabel" style="width:17%"></td>
									<td class="FieldInput" style="width:17%"></td>
								</tr>
							</table>
							</form>
						</fieldset>
					</next:Html>
				</next:Panel>
			</next:Panel>
			<next:Panel title="全体合伙人情况">
				<next:EditGridPanel id="peopleGrid" dataset="somDutyDataSet" width="100%" stripeRows="true" height="99.9%">
					<next:TopBar>
						<next:ToolBarItem symbol="->"></next:ToolBarItem>
						<next:ToolBarItem iconCls="add" text="选定为负责人" handler="chooseLegal"></next:ToolBarItem>
						<next:ToolBarItem iconCls="add" text="新增" handler="add"></next:ToolBarItem>
						<next:ToolBarItem iconCls="edit" text="修改" handler="update"></next:ToolBarItem>
						<next:ToolBarItem iconCls="delete" text="删除" handler="del"></next:ToolBarItem>
					</next:TopBar>
					<next:Columns>
						<next:RowNumberColumn/>
						<next:RadioBoxColumn></next:RadioBoxColumn>
						<next:Column header="内码" field="id" width="15%" editable="false" hidden="true"><next:TextField/></next:Column>
						<next:Column header="姓名" field="name" align="center" width="10%" editable="false"><next:TextField/></next:Column>
						<next:Column header="性别" field="sex" width="10%"  align="center"editable="false"><next:ComboBox dataset="sexSelect"/></next:Column>
						<next:Column header="出生年月" field="birthday" align="center" width="10%" editable="false"><next:TextField/></next:Column>
						<next:Column header="人事关系所在单位" field="personUnit" align="center"width="20%" editable="false"><next:TextField/></next:Column>
						<next:Column header="职务及职称" field="sorgDuties" align="center"width="10%" editable="false"><next:TextField/></next:Column>
						<next:Column header="政治面貌" field="politics"  align="center"width="15%" editable="false"><next:TextField/><next:ComboBox dataset="politicsSelect"/></next:Column>
						<next:Column header="电话" field="phone"width="10%"  align="center"editable="false"><next:TextField/></next:Column>
					</next:Columns>
				</next:EditGridPanel>
			</next:Panel>
			<next:Panel title="负责人登记表" >
				<next:TabPanel  width="100%" height="100%">
					<next:Tabs>
						<next:Panel  title="基本信息"  width="100%" height="100%" autoScroll="true">
							<next:Html>
								<form  method="post" dataset="LegalPeopleDataSet" onsubmit="return false" class="L5form">
								<table width="100%">
								<tr>
									<td class="FieldLabel" style="width:12%">姓名：</td>
									<td class="FieldInput" style="width:12%"> <input type="text"style="width:90%"  id='legalName' field="name" name="姓名"></td>
									<td class="FieldLabel"style="width:12%">性别：</td>
									<td class="FieldInput"style="width:10%">
										<select field="sex" name='"性别"' style="width:90%">
											<option dataset="sexSelect"></option>
										</select></td>
									<td class="FieldLabel"style="width:10%">民族：</td>
									<td class="FieldInput"style="width:10%">
									<select field="folk" name='"民族"' style="width:90%">
											<option dataset="folkSelect"></option>
										</select>
									 </td>
									<td class="FieldInput" style="width:10%" nowrap colspan="1" rowspan="5">
									<div id="photoDiv" align="center">
										<img id="img" name="RELATIONER_PHOTOC_IMG" width=82.5 height=110 src="<%=SkinUtils.getRootUrl(request) %>jsp/cams/sorg/comm/signet/default.jpg"
										align="top" ondblclick="editPhoto(1,'photoId','RELATIONER_PHOTOC_IMG');"
										onerror="javascript:this.src='<%=SkinUtils.getRootUrl(request) %>jsp/cams/sorg/comm/signet/default.jpg'" alt="暂无图片" />
										<input type="hidden" id="photoId" name="photoId"/>
									</div>
									</td>
								</tr>
								<tr>
									<td class="FieldLabel">政治面貌：</td>
									<td class="FieldInput">
										<select field="politics" name='"政治面貌"' style="width:90%">
											<option dataset="politicsSelect"></option>
										</select>
									</td>
									<td class="FieldLabel">文化程度：</td>
									<td class="FieldInput" colspan="3"><select field="education" name='"文化程度"' style="width:90%">
											<option dataset="educationSelect"></option>
										</select>
									</td>
								</tr>
								<tr>
									<td class="FieldLabel">出生日期：</td>
									<td class="FieldInput">
										<input type="text" id="birthday" field="birthday"  name='"出生日期"' format="Y-m-d" onclick="WdatePicker()" style="width:90%"/>
									</td>
									<td class="FieldLabel" style="width:15%">身份证号码：</td>
									<td class="FieldInput" style="width:21%" colspan="3"><input type="text"  field="idCard" name="身份证号码" style="width:90%" maxlength="18"></td>

								</tr>
								<tr>
									<td class="FieldLabel">职务：</td>
									<td class="FieldInput" ><input type="text" style="width:90%" field="sorgDuties" name="职务"></td>
									<td class="FieldLabel">技术职称：</td>
									<td class="FieldInput" colspan="3"><input type="text"style="width:90%"  field="profession" name="技术职称" maxlength="50"> </td>
								</tr>
								<tr>
									<td class="FieldLabel">户口所在地：</td>
									<td class="FieldInput" colspan="5"><input type="text" style="width:90%" field="populace" name="户口所在地" maxlength="100"> </td>
								</tr>
								<tr>
									<td class="FieldLabel">家庭住址：</td>
									<td class="FieldInput" colspan="2"><input type="text"style="width:90%"  field="adds" name="家庭住址" maxlength="100"> </td>
									<td class="FieldLabel">邮编：</td>
									<td class="FieldInput"><input type="text" style="width:90%" field="postCode" name="邮编" maxlength="6"> </td>
									<td class="FieldLabel">电话：</td>
									<td class="FieldInput"><input type="text"style="width:90%"  field="phone" name="电话" maxlength="30">  </td>
								</tr>
								<tr>
									<td class="FieldLabel">人事关系所在单位：</td>
									<td class="FieldInput" colspan="4"><input type="text"style="width:90%"  field="personUnit" maxlength="100" name="人事关系所在单位"> </td>
									<td class="FieldLabel">电话：</td>
									<td class="FieldInput"><input type="text" style="width:90%" field="personUnitPhone" maxlength="30" name="人事关系所在单位电话"> </td>
								</tr>
							</table>
								</form>
							</next:Html>
						</next:Panel>
						<next:EditGridPanel id="somResumeLegalGrid" dataset="somResumeDataSet" stripeRows="true" title="本人简历" width="100%" height="100%" autoScroll="true">
						<next:TopBar>
							<next:ToolBarItem symbol="->"></next:ToolBarItem>
							<next:ToolBarItem iconCls="add" text="增加" handler="addResume"></next:ToolBarItem>
							<next:ToolBarItem iconCls="delete" text="删除" handler="delResume"></next:ToolBarItem>
						</next:TopBar>
						<next:Columns>
							<next:RowNumberColumn/>
							<next:RadioBoxColumn></next:RadioBoxColumn>
							<next:Column header="内码" field="id" width="15%" editable="true" hidden="true"><next:TextField/></next:Column>
							<next:Column header="开始年月" field="startDate" width="10%" editable="true" renderer="renderDate"><next:TextField/></next:Column>
							<next:Column header="结束年月" field="endDate" width="10%" editable="true" renderer="renderDate"><next:TextField/></next:Column>
							<next:Column header="在何地区何单位" field="workOrgan" width="25%" editable="true"><next:TextField/></next:Column>
							<next:Column header="任（兼）何职" field="duty" width="20%" editable="true"><next:TextField/></next:Column>
						</next:Columns>
						<next:BottomBar>
							<next:PagingToolBar dataset="somResumeDataSet"/>
						</next:BottomBar>
					</next:EditGridPanel>
						<next:EditGridPanel id="uploadLegalPeopleGrid" title="法律要件" stripeRows="true" dataset="somLegalPeopleElectronicDataSet" width="100%" height="100%" autoScroll="true">
							<next:TopBar>
								<next:ToolBarItem symbol="附件列表"></next:ToolBarItem>
								<next:ToolBarItem symbol="->"></next:ToolBarItem>
								<next:ToolBarItem iconCls="add" text="增加上传附件" handler="clickUploadLegalPeopleFile"></next:ToolBarItem>
							</next:TopBar>
							<next:Columns>
								<next:RowNumberColumn />
								<next:RadioBoxColumn></next:RadioBoxColumn>
								<next:Column header="档案目录名" field="catalogCode" width="38%" editable="false" dataset="cataLogCodeSelect">
									<next:TextField />
								</next:Column>
								<next:Column header="附件名称" field="fileName" width="30%" editable="false">
									<next:TextField />
								</next:Column>
								<next:Column header="附件描述" field="fileMess" width="20%" editable="false">
									<next:TextField />
								</next:Column>
								<next:Column header="下载附件" field="" width="10%" editable="false" renderer="clickDownloadLegalPeopleHref">
									<next:TextField />
								</next:Column>
							</next:Columns>
							<next:BottomBar>
								<next:PagingToolBar dataset="somLegalPeopleElectronicDataSet" />
							</next:BottomBar>
						</next:EditGridPanel>
					</next:Tabs>
				</next:TabPanel>
			</next:Panel>
			<next:Panel title="内设机构">
				<next:EditGridPanel id="officeGrid" width="100%" stripeRows="true" height="100%" dataset="somOfficeDataSet">
					<next:TopBar>
						<next:ToolBarItem symbol="内设机构列表"></next:ToolBarItem>
						<next:ToolBarItem symbol="->"></next:ToolBarItem>
						<next:ToolBarItem iconCls="add" text="增加" handler="addOffice"></next:ToolBarItem>
						<next:ToolBarItem iconCls="edit" text="修改" handler="editOffice"></next:ToolBarItem>
						<next:ToolBarItem iconCls="remove" text="删除" handler="deleteOffice"></next:ToolBarItem>
					</next:TopBar>

					<next:Columns>
						<next:RowNumberColumn />
						<next:RadioBoxColumn></next:RadioBoxColumn>
						<next:Column header="内设机构名称" field="name" width="25%" editable="false" ><next:TextField /></next:Column>
						<next:Column header="机构负责人" field="officeChief" width="15%" editable="false"><next:TextField /></next:Column>
						<next:Column header="场所"    field="place" width="43%" editable="false"><next:TextField /></next:Column>
						<next:Column header="电话" 	  field="phone"      width="15%" editable="false" ><next:TextField /></next:Column>
					</next:Columns>
					<next:BottomBar>
						<next:PagingToolBar dataset="somOfficeDataSet" />
					</next:BottomBar>
				</next:EditGridPanel>
			</next:Panel>
			<next:Panel title="章程核准表"  width="100%" autoScroll="true">
				<next:Html>
					<form method="post" onsubmit="return false" dataset="somRuleDataSet" class="L5form">
					<fieldset>
						<legend>民办非企业单位章程</legend>
						<input type="hidden" id="sorgId" field="sorgId" value="社团ID">
						<table width="100%">
							<tr>
								<td class="FieldLabel">会议名称：</td>
								<td class="FieldInput" colspan="5"><input type="text" id="meetingName" field="meetingName" maxlength="100" style="width:90%"></td>
							</tr>
							<tr>
								<td class="FieldLabel" style="width:17%">时间：</td>
								<td class="FieldInput" style="width:17%"><input type="text" id="meetingDate" field="meetingDate"onClick="WdatePicker()" style="width:90%"></td>
								<td class="FieldLabel" style="width:17%">应到人数：</td>
								<td class="FieldInput" style="width:15%"><input type="text" name="应到人数" id="shouldNum" field="shouldNum" maxlength="6" style="width:90%"></td>
								<td class="FieldLabel" style="width:17%">实到人数：</td>
								<td class="FieldInput" style="width:17%"><input type="text" name="实到人数" id="realNum" field="realNum" maxlength="6" style="width:90%"></td>
							</tr>
							<tr>
								<td class="FieldLabel">同意人数：</td>
								<td class="FieldInput"><input type="text" name="同意人数" id="passNum" field="passNum" maxlength="6" style="width:90%"></td>
								<td class="FieldLabel">反对人数：</td>
								<td class="FieldInput"><input type="text" name="反对人数" id="nopassNum" field="nopassNum" maxlength="6" style="width:90%"></td>
								<td class="FieldLabel">弃权人数：</td>
								<td class="FieldInput"><input type="text" name="弃权人数" id="giveupNum" field="giveupNum" maxlength="6" style="width:90%"></td>
							</tr>
							<tr>
								<td class="FieldLabel">需说明的主要问题：</td>
								<td class="FieldInput" colspan="5"><textarea name="需说明的主要问题" id=mainQuestion field="mainQuestion" cols="65" rows="4" style="width:97%"></textarea></td>
							</tr>
						</table>
						</fieldset>
					</form>
				</next:Html>
			</next:Panel>
			<next:Panel title="法律要件" >
				<next:EditGridPanel id="uploadGrid" width="100%" stripeRows="true" height="100%" dataset="somElectronicDataSet">
					<next:TopBar>
						<next:ToolBarItem symbol="附件列表"></next:ToolBarItem>
						<next:ToolBarItem symbol="->"></next:ToolBarItem>
						<next:ToolBarItem iconCls="add" text="增加上传附件" handler="uploadFile"></next:ToolBarItem>
					</next:TopBar>

					<next:Columns>
						<next:RowNumberColumn />
						<next:RadioBoxColumn></next:RadioBoxColumn>
						<next:Column header="档案目录名"  field="catalogCode" width="38%" editable="false" dataset="cataLogCodeSelect"><next:TextField /></next:Column>
						<next:Column header="附件名称"    field="fileName" width="30%" editable="false"><next:TextField /></next:Column>
						<next:Column header="附件描述"    field="fileMess" width="20%" editable="false"><next:TextField /></next:Column>
						<next:Column header="下载附件"    field="" width="10%" editable="false" renderer="clickDownloadHref"><next:TextField /></next:Column>
					</next:Columns>
					<next:BottomBar>
						<next:PagingToolBar dataset="somElectronicDataSet" />
					</next:BottomBar>
				</next:EditGridPanel>
			</next:Panel>
			<next:Panel title="处理意见" width="100%" >
				<next:Html>
					<fieldset>
						<form method="post" dataset="somApplyDataSet" onsubmit="return false" class="L5form" >
							<table width="100%">
								<tr>
									<td class="FieldLabel" style="width:15%">承办人意见：</td>
									<td class="FieldInput" style="width:15%">
										<select field="acceptOpinionId" name='"承办人意见"' >
											<option dataset="opinionSelect"/>
										</select>
									</td>
									<td class="FieldLabel" style="width:15%">承办人：</td>
									<td class="FieldInput" style="width:15%"><input type="text" field="acceptPeopleName" name='承办人'  style="width:90%" />
									</td>
									<td class="FieldLabel" style="width:15%">承办时间：</td>
									<td class="FieldInput" style="width:25%"><input type="text" name='承办时间' field="acceptTime" onClick="WdatePicker()" />
									</td>
								</tr>
								<tr>
									<td class="FieldLabel">承办补充意见：</td>
									<td class="FieldInput" colspan="5"><textarea rows="3" name='承办补充意见' field="acceptOpinion" style="width:90%" ></textarea>
									</td>
								</tr>
								<tr>
									<td class="FieldLabel" >初审意见：</td>
									<td class="FieldInput" >
										<select field="examinOpinionId" name='"初审意见"' >
											<option dataset="opinionSelect"/>
										</select>
									</td>
									<td class="FieldLabel" >初审负责人：</td>
									<td class="FieldInput" ><input type="text" field="examinPeopleName" name='初审负责人'  style="width:90%" />
									</td>
									<td class="FieldLabel" >初审时间：</td>
									<td class="FieldInput" ><input type="text" name='初审时间' field="examinTime" onClick="WdatePicker()" />
									</td>
								</tr>
								<tr>
									<td class="FieldLabel">初审补充意见：</td>
									<td class="FieldInput" colspan="5"><textarea rows="3" name='初审补充意见' field="examinOpinion" style="width:90%" ></textarea>
									</td>
								</tr>
								<tr>
									<td class="FieldLabel" >审核意见：</td>
									<td class="FieldInput" >
										<select field="checkOpinionId" name='"审核意见"' >
											<option dataset="opinionSelect"/>
										</select>
									</td>
									<td class="FieldLabel" >审核人：</td>
									<td class="FieldInput" ><input type="text" field="checkPeopleName" name='审核人' style="width:90%" />
									</td>
									<td class="FieldLabel" >审核时间：</td>
									<td class="FieldInput" ><input type="text" name='审核时间' field="checkTime" onClick="WdatePicker()"  />
									</td>
								</tr>
								<tr>
									<td class="FieldLabel">审核补充意见：</td>
									<td class="FieldInput" colspan="5"><textarea rows="3" name='审核补充意见' field="checkOpinion" style="width:90%" ></textarea>
									</td>
								</tr>
								<tr>
									<td class="FieldLabel" >批准意见：</td>
									<td class="FieldInput" >
										<select field="auditOpinionId" name='"批准意见"' >
											<option dataset="opinionSelect"/>
										</select>
									</td>
									<td class="FieldLabel" >批准人：</td>
									<td class="FieldInput" ><input type="text" field="auditPeopleName" name='批准人' style="width:90%" />
									</td>
									<td class="FieldLabel" >批准时间：</td>
									<td class="FieldInput" ><input type="text" name='批准时间' field="auditTime" onClick="WdatePicker()"  />
									</td>
								</tr>
								<tr>
									<td class="FieldLabel">批准补充意见：</td>
									<td class="FieldInput" colspan="5"><textarea rows="3" name='批准补充意见' field="auditOpinion" style="width:90%" ></textarea>
									</td>
								</tr>
							</table>
						</form>
					</fieldset>
				</next:Html>
			</next:Panel>
		</next:Tabs>
	</next:TabPanel>
</next:Panel>
<!-- 负责人身份验证 -->
<next:Window id="win_peopleValidate" title="人员身份验证"  resizable="false" width="500" height="403" closeAction="hide">
		<next:EditGridPanel id="gridPeople" width="486" stripeRows="true" height="170" dataset="winPeopleDataSet">
			<next:TopBar>
				<next:ToolBarItem symbol="人员列表"></next:ToolBarItem>
				<next:ToolBarItem symbol="->"></next:ToolBarItem>
				<next:ToolBarItem iconCls="edit" text="回填信息" handler="editItem"></next:ToolBarItem>
				<next:ToolBarItem iconCls="delete" text="关闭窗口" handler="closeItem"></next:ToolBarItem>
			</next:TopBar>
			<next:Columns>
				<next:RowNumberColumn />
				<next:RadioBoxColumn></next:RadioBoxColumn>
				<next:Column header="姓名" field="name" width="150" sortable="true" editable="false"><next:TextField /></next:Column>
				<next:Column header="出生年月" field="birthday" width="142" sortable="true" editable="false"><next:DateField format="Y-m-d" /></next:Column>
				<next:Column header="性别" field="sex" width="142" sortable="true" editable="false" dataset="sexSelect" ><next:TextField /></next:Column>
			</next:Columns>
			<next:BottomBar>
				<next:PagingToolBar dataset="winPeopleDataSet" />
			</next:BottomBar>
		</next:EditGridPanel>
		<next:EditGridPanel id="gridDuty" width="486" stripeRows="true" height="202" dataset="winDutyDataSet">
			<next:TopBar>
				<next:ToolBarItem symbol="所在社会组织信息"></next:ToolBarItem>
				<next:ToolBarItem symbol="->"></next:ToolBarItem>
			</next:TopBar>
			<next:Columns>
				<next:RowNumberColumn />
				<next:Column header="组织名称" field="sorgId" width="165" dataset="sorgNameSelect" sortable="false" editable="false"><next:TextField /></next:Column>
				<next:Column header="职务" field="sorgDuties" width="120" dataset="sorgDutiesSelect" sortable="false" editable="false"><next:TextField /></next:Column>
				<next:Column header="状态" field="ifServe" width="80" dataset="ifServeSelect" sortable="false" editable="false"><next:TextField /></next:Column>
			</next:Columns>
			<next:BottomBar>
				<next:PagingToolBar dataset="winDutyDataSet" />
			</next:BottomBar>
		</next:EditGridPanel>
</next:Window>
<!-- 负责人录入窗口 -->
<next:Window id="peopleWin" title="合伙人情况" resizable="false" width="800" height="200" closeAction="hide" autoScroll="true">
	<next:Panel id="panel_win">
		<next:Html>
			<form title="" id="addForm" method="post" dataset="somDutyInsertDataSet" onsubmit="return false" class="L5form">
				<table width="100%">
					<tr>
						<td class="FieldLabel" style="width:25%">姓名：</td>
						<td class="FieldInput" style="width:25%"><input type="text" field="name" name='"姓名"' style="width:90%"/><span style="color:red">*</span></td>

						<td class="FieldLabel"style="width:25%">出生日期：</td>
						<td class="FieldInput"style="width:25%"><input type="text" id="birthday" field="birthday" name='"出生日期"' format="Y-m-d" onclick="WdatePicker()" style="width:90%"/></td>

					</tr>
					<tr>
						<td class="FieldLabel" style="width:25%">性别：</td>
						<td class="FieldInput"style="width:25%">
							<select field="sex" name='"性别"' style="width:90%">
								<option dataset="sexSelect"></option>
							</select>
						</td>
						<td class="FieldLabel">电话：</td>
						<td class="FieldInput"><input type="text" id="phone" field="phone" name='"电话"' style="width:90%"/></td>
					</tr>
					<tr>
						<td class="FieldLabel">政治面貌：</td>
						<td class="FieldInput">
							<select field="politics" name='"政治面貌"' style="width:90%">
								<option dataset="politicsSelect"></option>
							</select>
						</td>
						<td class="FieldLabel">职务及职称：</td>
						<td class="FieldInput" >
							<input type="text"   field="sorgDuties" name='"职务及职称"' style="width:90%"/>
						</td>
					</tr>
					<tr>
						<td class="FieldLabel">人事关系所在单位：</td>
						<td class="FieldInput" colspan="3"><input type="text" id="personUnit" field="personUnit" name='"人事关系所在单位"' style="width:90%" /></td>
					</tr>
				</table>
			</form>
		</next:Html>
	</next:Panel>
	<next:Buttons>
		<next:ToolButton text="确定" handler="confirm"></next:ToolButton>
		<next:ToolButton text="关闭" handler="closePeopleWIn"></next:ToolButton>
	</next:Buttons>
</next:Window>
<next:Window id="officeWin" title="民办非企业单位内设机构备案表" closeAction="hide"  width="740"modal='true'>
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="save" text="确定" handler="winInsertOffice"></next:ToolBarItem>
		<next:ToolBarItem iconCls="return" text="关闭" handler="winCloseOffice"></next:ToolBarItem>
	</next:TopBar>
	<next:Html>
		<form dataset="winOfficeDataSet"  onsubmit="return false"  class="L5form">
		<table border="1" width='100%'>
			<tr>
				<td class="FieldLabel" ><label>内设机构名称：</label></td>
				<td class="FieldInput"><input type="text" name="内设机构名称" id="name" field="name" style="width:90%"/></td>
				<td class="FieldLabel"><label>场所：</label></td>
				<td class="FieldInput" colspan="3"><input type="text" name="场所" id="place" field="place" style="width:96.5%" /></td>
			</tr>
			<tr>
				<td class="FieldLabel" style="width:13%"><label>机构负责人：</label></td>
				<td class="FieldInput" style="width:20%"><input type="text" name="机构负责人" id="officeChief" field="officeChief" style="width:90%"/></td>
				<td class="FieldLabel" style="width:13%"><label>电话：</label></td>
				<td class="FieldInput" style="width:20%"><input type="text" name="phone" id="phone_office" field="phone" style="width:90%"/></td>
				<td class="FieldLabel" style="width:13%"><label>邮编：</label></td>
				<td class="FieldInput" style="width:20%"><input type="text" name="postCode" id="postCode_office" field="postCode"  style="width:90%"/></td>
			</tr>

			<tr>
				<td class="FieldLabel"><label>职能：</label></td>
				<td class="FieldInput" colspan="5"><textarea type="text" name="职能" id="dutiesDesc" field="dutiesDesc" rows="5" style="width:98%"></textarea></td>
			</tr>
			<tr>
				<td class="FieldLabel"><label>设立理由：</label></td>
				<td class="FieldInput" colspan="5"><textarea type="text" name="设立理由" id="reason" field="reason" cols="75" rows="4" style="width:98%"></textarea></td>
			</tr>
		</table>
		</form>
   </next:Html>
</next:Window>
<jsp:include page="../../../comm/upload/uploadWindow.jsp" flush="true"/>
<jsp:include page="../../../comm/borg/borgSelectWindow.jsp" flush="true"/>
</body>
</html>