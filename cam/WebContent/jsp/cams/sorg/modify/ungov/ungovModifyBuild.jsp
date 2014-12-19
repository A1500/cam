<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="com.inspur.cams.sorg.util.ApplyType"%>
<%@ page import="com.inspur.cams.sorg.util.SomIdHelp"%>
<%@ page import="com.inspur.cams.comm.util.IdHelp"%>
<%@ page import="com.inspur.cams.sorg.util.SomDutyDuties"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
<head>
<title>民办非企业单位信息修订</title>
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
	var applyType='<%=ApplyType.SOM_UNGOV_BUILD_LEGAL%>';//业务类型
	var taskCode='<%=taskCode%>';//业务编号
	var method='<%=request.getParameter("method")%>';
	var fileCodeF = "M004";//法定代表人法律要件
	var legalDutyId = '<%=IdHelp.getUUID32()%>';//法定代表人dutyId
	var searchSorgCode = '<%=searchSorgCode%>';
	var searchCnName = '<%=searchCnName%>';
	var legalDuties = '<%=legalDuties%>';
</script>
<script type="text/javascript" src="ungovModifyBuild.js"></script>
<script type="text/javascript"
	src='<%=SkinUtils.getJS(request,"cams.js") %>'></script>
<script type="text/javascript"
	src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript"
	src='<%=SkinUtils.getJS(request,"cams/sorgUpload.js")%>'></script>
<script type="text/javascript">var rootPath='<%=SkinUtils.getRootUrl(request)%>';</script>
<script type="text/javascript"
	src='<%=SkinUtils.getJS(request,"My97DatePicker/WdatePicker.js") %>'></script>
<script type="text/javascript"
	src='<%=SkinUtils.getJS(request,"cams/somPhoto.js") %>'></script>
<script type="text/javascript"
	src="<%=SkinUtils.getRootUrl(request)%>skins/js/ISEditPhoto.js"></script>
</head>
<body>
<%--定义dataset--%>
<model:datasets>
	<%--民办非企业基本信息--%>
	<model:dataset id="somOrganDataSet"
		cmd="com.inspur.cams.sorg.base.cmd.SomOrganQueryCmd" global="true"
		method="queryOrgan">
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
			<model:field name="checkCapitalOrgan" type="string"
				rule="length{100}" />
			<model:field name="moneySource" type="string" rule="length{500}" />
			<model:field name="housingOrgan" type="string" rule="length{100}" />
			<model:field name="leasePeriod" type="string" rule="length{100}" />
		</model:record>
	</model:dataset>
	<%--举办人情况--%>
	<model:dataset id="somHeldPeopleDataSet"
		cmd="com.inspur.cams.sorg.base.cmd.SomHeldPeopleQueryCmd"
		global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomHeldPeople">
			<model:field name="idCard" type="string" rule="length{18}" />
			<model:field name="name" type="string" rule="length{72}" />
			<model:field name="sex" type="string" rule="length{1}" />
			<model:field name="birthday" type="string" rule="length{10}" />
			<model:field name="politics" type="string" rule="length{2}" />
			<model:field name="workName" type="string" rule="length{100}" />
			<model:field name="workDuties" type="string" rule="length{100}" />
			<model:field name="ifChief" type="string" rule="length{1}" />
		</model:record>
	</model:dataset>
	<%--举办单位情况--%>
	<model:dataset id="somHeldOrganDataSet"
		cmd="com.inspur.cams.sorg.base.cmd.SomHeldOrganQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomHeldOrgan">
			<model:field name="name" type="string" rule="require|length{100}" />
			<model:field name="heldorganPeople" type="string" rule="length{72}" />
			<model:field name="phone" type="string" rule="length{30}" />
		</model:record>
	</model:dataset>
	<!-- 负责人信息 -->
	<model:dataset id="somDutyDataSet"
		cmd="com.inspur.cams.sorg.base.cmd.SomDutyQueryCmd" global="true"
		method="queryPeople" pageSize="100">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomDuty"></model:record>
	</model:dataset>
	<!-- 法定代表人信息 -->
	<model:dataset id="LegalPeopleDataSet"
		cmd="com.inspur.cams.sorg.base.cmd.SomDutyQueryCmd" global="true"
		method="queryPeople">
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
	<model:dataset id="somSessionDataSet"
		cmd="com.inspur.cams.sorg.base.cmd.SomSessionQueryCmd">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomSession"></model:record>
	</model:dataset>
	<!-- 负责人录入窗口 -->
	<model:dataset id="somDutyInsertDataSet"
		cmd="com.inspur.cams.sorg.base.cmd.SomDutyQueryCmd" global="true"
		method="queryPeople">
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
	<model:dataset id="somResumeDataSet"
		cmd="com.inspur.cams.sorg.base.cmd.SomPeopleResumeQueryCommand"
		sortField="startDate" sortDirection="DESC">
		<model:record
			fromBean="com.inspur.cams.sorg.base.data.SomPeopleResume"></model:record>
	</model:dataset>
	<%--法定代表人人员简历 --%>
	<model:dataset id="somResumeLegalDataSet"
		cmd="com.inspur.cams.sorg.base.cmd.SomPeopleResumeQueryCommand">
		<model:record
			fromBean="com.inspur.cams.sorg.base.data.SomPeopleResume"></model:record>
	</model:dataset>
	<%--人员简历 --%>
	<model:dataset id="somResumeInsertDataSet"
		cmd="com.inspur.cams.sorg.base.cmd.SomPeopleResumeQueryCommand">
		<model:record
			fromBean="com.inspur.cams.sorg.base.data.SomPeopleResume"></model:record>
	</model:dataset>
	<%--内设机构--%>
	<model:dataset id="somOfficeDataSet"
		cmd="com.inspur.cams.sorg.base.cmd.SomOfficeQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomOffice">
		</model:record>
	</model:dataset>
	<model:dataset id="winOfficeDataSet"
		cmd="com.inspur.cams.sorg.base.cmd.SomOfficeQueryCmd">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomOffice">
		</model:record>
	</model:dataset>
	<%--所有符合身份证号的人员列表--%>
	<model:dataset id="winPeopleDataSet"
		cmd="com.inspur.cams.sorg.base.cmd.SomPeopleQueryCmd">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomPeople"></model:record>
	</model:dataset>
	<%--所有符合身份证号的人员列表--%>
	<model:dataset id="winDutyDataSet"
		cmd="com.inspur.cams.sorg.base.cmd.SomDutyQueryCmd">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomDuty"></model:record>
	</model:dataset>
	<!-- 章程核准信息 -->
	<model:dataset id="somRuleDataSet"
		cmd="com.inspur.cams.sorg.base.cmd.SomRuleQueryCmd" global="true"
		method="queryRule">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomRule">
			<model:field name="shouldNum" type="string" rule="number|length{6}" />
			<model:field name="realNum" type="string" rule="number|length{6}" />
			<model:field name="passNum" type="string" rule="number|length{6}" />
			<model:field name="nopassNum" type="string" rule="number|length{6}" />
			<model:field name="giveupNum" type="string" rule="number|length{6}" />
			<model:field name="mainQuestion" type="string" rule="length{1000}" />
		</model:record>
	</model:dataset>
	<%--电子档案--%>
	<model:dataset id="somElectronicDataSet"
		cmd="com.inspur.cams.sorg.upload.cmd.SomElectronicQueryCmd"
		global="true" method="queryCatalog">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomElectronic"></model:record>
	</model:dataset>
	<%--下载窗口--%>
	<model:dataset id="downloadDataSet"
		cmd="com.inspur.cams.sorg.upload.cmd.SomElectronicQueryCmd"
		method="queryElectronic">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomElectronic"></model:record>
	</model:dataset>
	<%--电子档案上传窗口--%>
	<model:dataset id="winElectronicDataSet"
		cmd="com.inspur.cams.sorg.upload.cmd.SomElectronicQueryCmd"
		global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomElectronic"></model:record>
	</model:dataset>
	<%--法定代表人员电子档案--%>
	<model:dataset id="somLegalPeopleElectronicDataSet"
		cmd="com.inspur.cams.sorg.upload.cmd.SomElectronicQueryCmd"
		global="true" method="queryPeopleCatalog">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomElectronic"></model:record>
	</model:dataset>
	<%--法定代表人员电子档案上传窗口--%>
	<model:dataset id="winLegalPeopleElectronicDataSet"
		cmd="com.inspur.cams.sorg.upload.cmd.SomElectronicQueryCmd"
		global="true" method="queryPeopleElectronic">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomElectronic"></model:record>
	</model:dataset>
	<%--业务意见--%>
	<model:dataset id="somApplyDataSet"
		cmd="com.inspur.cams.sorg.base.cmd.SomApplyQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomApply">
		</model:record>
	</model:dataset>

	<%--定义字典表--%>
	<model:dataset id="cataLogCodeSelect"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='SOM_CATALOG'></model:param>
			<model:param name="value" value='CATALOG_CODE'></model:param>
			<model:param name="text" value='CATALOG_NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 社会组织种类 -->
	<model:dataset id="sorgKindSelect"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_UNGOV_KIND'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 政治面貌 -->
	<model:dataset id="politicsSelect"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_POLITICAL'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 住所来源 -->
	<model:dataset id="resideSourceSelect"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_RESIDE_SOURCE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 住所来源 -->
	<model:dataset id="sorgNameSelect"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='SOM_ORGAN'></model:param>
			<model:param name="value" value='SORG_ID'></model:param>
			<model:param name="text" value='CN_NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 所属行事业 -->
	<model:dataset id="busScopeSelect"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_BUS_SCOPE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 社会组织职务 -->
	<model:dataset id="sorgDutiesSelect"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_SOM_DUTY'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 专兼职 -->
	<model:dataset id="ifFulltimeSelect"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_IF_FULLTIME'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 民族 -->
	<model:dataset id="folkSelect"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_NATION'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 是否在任 -->
	<model:dataset id="ifServeSelect"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_DUTY_IF_SERVE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 业务主管单位 -->
	<model:dataset id="businessOrganSelect"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true" sortField="ORDER_NUMBER">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='SOM_BUSINESS_ORGAN'></model:param>
			<model:param name="value" value='BORG_CODE'></model:param>
			<model:param name="text" value='BORG_NAME'></model:param>
			<model:param name="filterSql"
				value='<%="MORG_CODE ="+BspUtil.getOrganCode().substring(0,6)%>'></model:param>
		</model:params>
	</model:dataset>
	<!-- 证件类型 -->
	<model:dataset id="cardTypeSelect"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_CARD_TYPE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 会议类型 -->
	<model:dataset id="meetingType"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_SOM_MEETING_TYPE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 性别 -->
	<model:dataset id="sexSelect"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_SEX'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 文化程度 -->
	<model:dataset id="educationSelect"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_EDUCATION'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="comm_yesorno" enumName="COMM.YESORNO"
		autoLoad="true" global="true"></model:dataset>
	<model:dataset id="opinionSelect" enumName="WORKFLOW.OPINION"
		autoLoad="true" global="true"></model:dataset>
</model:datasets>
<%--定义界面--%>
<next:Panel width="100%" height="100%">
	<next:TopBar>
		<next:ToolBarItem symbol="民办非企业单位信息修订"></next:ToolBarItem>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="save" text="保存" handler="save"></next:ToolBarItem>
		<next:ToolBarItem iconCls="return" text="返回" handler="goBack"></next:ToolBarItem>
	</next:TopBar>
	<next:Panel title="基础信息" width="100%">
		<next:Panel width="100%" height="100%" autoScroll="true">
			<next:Html>
				<fieldset>
				<form method="post" dataset="somOrganDataSet"
					onsubmit="return false" class="L5form">
				<table width="100%">
					<tr>
						<td class="FieldLabel" style="width: 17%">民办非企业中文名称：</td>
						<td class="FieldInput" style="width: 51%" colspan="3"><input
							type="text" id="cnName" name='民办非企业中文名称' field="cnName"
							style="width: 97%" onblur="cnNameUK()" /><span style="color: red">*</span></td>
						<td class="FieldLabel" style="width: 17%">电话：</td>
						<td class="FieldInput" style="width: 17%"><input type="text"
							id="sorgPhone" name='民办非企业电话' field="sorgPhone"
							style="width: 90%" /></td>
					</tr>
					<tr>
						<td class="FieldLabel" style="width: 17%">登记证号：</td>
						<td class="FieldInput" style="width: 17%"><input type="text"
							id="sorgCode" name='登记证号' field="sorgCode" style="width: 90%" 
							onkeyup="value=value.replace(/[^\\w\.\/]/ig,'').toUpperCase()"
							onblur="sorgCodeUK()" /><span style="color: red">*</span></td>
						<td class="FieldLabel" style="width: 17%">组织机构代码：</td>
						<td class="FieldInput" style="width: 17%"><input type="text"
							id="organCode" name='登记证号' field="organCode" style="width: 90%" /></td>
						<td class="FieldLabel" style="width: 15%">邮编：</td>
						<td class="FieldInput" style="width: 17%"><input type="text"
							id="sorgPost" name='民办非企业邮编' field="sorgPost" style="width: 90%" /></td>
					</tr>
					<tr>
						<td class="FieldLabel" style="width: 17%">登记日期：</td>
						<td class="FieldInput" style="width: 17%"><input type="text"
							name='登记日期' id="regDate" field="regDate" onClick="WdatePicker()"
							style="width: 90%" /><span style="color: red">*</span></td>
						<td class="FieldLabel" style="width: 17%">成立日期：</td>
						<td class="FieldInput" style="width: 17%"><input type="text"
							name='成立日期' field="buildDate" onClick="WdatePicker()"
							style="width: 90%" /></td>
						<td class="FieldLabel">业务主管单位：</td>
						<td class="FieldInput"  >
						<input type="text" id="borgNameDispaly" name="borgNameDispaly"  title="业务主管单位"  onkeyup="findDiv(this,'borgName','popup','','businessOrganAuto','BORG_NAME@like','borgCode','borgName','35')" onblur="clearDiv()" onchange="clearBorg(this)"/><img src="<%=SkinUtils.getImage(request,"l5/help.gif")%>" style="cursor:hand" onclick="showBorgWin()"/>
						<div id="popup" style="width:300px; height: 150px; display: none;position: absolute;background-color: #FFFFFF;" >  
       							<ul></ul> 
  								</div>
  								<input type="hidden" id="borgName" name="borgName" field="borgName" title="业务主管单位代码"/>
						<span style="color:red">*</span></td>
					</tr>
					<tr>
						<td class="FieldLabel" style="width: 17%">住所来源：</td>
						<td class="FieldInput" style="width: 17%"><select
							field="resideSource" onchange="changeResideSource();"
							id="resideSource" name='住所来源' style="width: 90%"">
							<option dataset="resideSourceSelect"></option>
						</select></td>
						<td class="FieldLabel" style="width: 17%">住所：</td>
						<td class="FieldInput" style="width: 17%"><input type="text"
							name='住所' field="residence" style="width: 90%" /></td>
						<td class="FieldLabel" style="width:17%">法定代表人：</td>
						<td class="FieldInput" style="width:17%"><input type="text" name='法定代表人' field="legalPeople"  style="width:90%"/></td>
					</tr>
					<tr>
						<td class="FieldLabel" style="width: 17%">所属行（事）业：</td>
						<td class="FieldInput"><select field="busScope"
							name='所属行（事）业' style="width: 90%">
							<option dataset="busScopeSelect"></option>
						</select></td>
						<td class="FieldLabel" style="width: 17%">从业人员数：</td>
						<td class="FieldInput"><input type="text" id="unitsNum"
							name='从业人员数' field="engagedNum" maxlength="6" style="width: 90%" /></td>
						<td class="FieldLabel" style="width: 15%">其中执业人员数：</td>
						<td class="FieldInput"><input type="text" id="peopleNum"
							name='其中执业人员数' field="practiceNum" maxlength="6"
							style="width: 90%" /></td>
					</tr>
					<tr>
						<td class="FieldLabel">宗旨：</td>
						<td class="FieldInput" colspan="5"><textarea rows="5"
							name='民办非企业宗旨' field="purpose" style="width: 98%"></textarea></td>
					</tr>
					<tr>
						<td class="FieldLabel">业务范围：</td>
						<td class="FieldInput" colspan="5"><textarea rows="5"
							name='业务范围' field="business" style="width: 98%"></textarea></td>
					</tr>
					<tr>
						<td class="FieldLabel">基本设备、设施：</td>
						<td class="FieldInput" colspan="5"><textarea rows="5"
							name='基本设备、设施' field="facilities" style="width: 98%"></textarea></td>
					</tr>
					<tr>
						<td class="FieldLabel">开办资金数额：</td>
						<td class="FieldInput"><input type="text" id="regMon"
							name='开办资金数额' field="regMon" maxlength="10" style="width: 68%" />万元</td>
						<td class="FieldLabel">验资单位：</td>
						<td class="FieldInput" colspan="3"><input type="text"
							name='验资单位' field="checkCapitalOrgan" style="width: 97%"></td>
					</tr>
					<tr>
						<td class="FieldLabel">开办资金来源：</td>
						<td class="FieldInput" colspan="5"><input type="text"
							name='开办资金来源' field="moneySource" style="width: 98%" /></td>
					</tr>
					<tr>
						<td class="FieldLabel">住所产权单位：</td>
						<td class="FieldInput" colspan="3"><input type="text"
							name='住所产权单位' field="housingOrgan" style="width: 97%" /></td>
						<td class="FieldLabel">用房面积：</td>
						<td class="FieldInput"><input type="text" id="housingArea"
							name='用房面积' field="housingArea" maxlength="10" style="width: 65%" />平方米</td>
					</tr>
					<tr id="leasePeriod" style="display: none">
						<td class="FieldLabel">租（借）期限：</td>
						<td class="FieldInput" colspan="5"><input type="text"
							field="leasePeriod" style="width: 98%" /></td>
					</tr>
					<tr>
						<td class="FieldLabel">民办非企业通信地址：</td>
						<td class="FieldInput"><input type="text" name='民办非企业通信地址'
							id="sorgAdds" field="sorgAdds" style="width: 90%" /></td>
						<td class="FieldLabel">民办非企业电子邮箱：</td>
						<td class="FieldInput"><input type="text" name='民办非企业电子邮箱'
							field="sorgEmail" style="width: 90%" /></td>
						<td class="FieldLabel" style="width: 15%">民办非企业传真：</td>
						<td class="FieldInput" style="width: 17%"><input type="text"
							id="sorgFax" field="sorgFax" style="width: 90%" /></td>
					</tr>
				</table>
				</form>
				</fieldset>
				<fieldset>
				<form method="post"  onsubmit="return false" class="L5form" style="border-width:0px" dataset=somOrganDataSet>
				<legend>联系人信息</legend>
				<table width="100%">
					<tr>
						<td class="FieldLabel" style="width:17%">联系人：</td>
						<td class="FieldInput" style="width:17%"><input type="text" name='"申请人"' field="sorgPeople" style="width:90%"/></td>
						<td class="FieldLabel" style="width:17%">联系人电话：</td>
						<td class="FieldInput" style="width:17%"><input type="text" id="sorgPeoplePhone" name='"申请人电话"' field="sorgPeoplePhone" style="width:90%"/></td>
					</tr>
				</table>
				</form>
				</fieldset>
			</next:Html>
		</next:Panel>
	</next:Panel>
	</next:Panel>
<jsp:include page="../../comm/borg/borgSelectWindow.jsp" flush="true"/> 
</body>
</html>