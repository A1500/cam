<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next" %>
<%@ taglib uri="/tags/next-model" prefix="model" %>
<%@ page import="com.inspur.cams.comm.util.StrUtil,org.loushang.next.skin.SkinUtils"%>
<%@ page import="com.inspur.cams.sorg.util.ApplyType"%>
<%@ page import="com.inspur.cams.sorg.util.SomIdHelp"%>
<%@ page import="com.inspur.cams.comm.util.IdHelp"%>
<%@ page import="com.inspur.cams.sorg.util.SomDutyDuties"%>
<%@page import="com.inspur.cams.sorg.util.ApplyType"%>
<%@ page import="com.inspur.cams.comm.extuser.data.ComExtUser"%>
<%@ page import="com.inspur.cams.sorg.online.extuser.util.SomExtBspInfo"%>
<%@page import="com.inspur.cams.sorg.online.apply.util.SomIdHelpOnline"%>
<html>
<head>
<title>民办非企业单位（法人）成立登记网上申请</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript">
	<%
		ComExtUser comExtUser = (ComExtUser)SomExtBspInfo.getUserInfo(request).getComExtUser();
		String username = comExtUser.getUserName();
		String organArea = comExtUser.getAreaCode();//获取外部单位行政区划12位
		String userId = comExtUser.getUserId();
		String sorgId ="";
		String taskCode ="";
			sorgId = request.getParameter("sorgId");
			taskCode = request.getParameter("taskCode") ;
		String legalDuties=SomDutyDuties.SOM_LEGAL_PEOPLE;
	%>
	var applyType='<%=ApplyType.SOM_UNGOV_BUILD_LEGAL%>';//业务类型
	var legalDutyId='<%=IdHelp.getUUID32()%>';
	var fileCodeF = "M004";//法定代表人法律要件
	currentSorgId = '<%=StrUtil.n2b(SomIdHelpOnline.getGroupSorgId(organArea))%>';
	var taskCode='<%=taskCode%>';
	var sorgId='<%=sorgId%>';
	var rootPath="<%=SkinUtils.getRootUrl(request)%>";
	var morgArea='<%=organArea%>';
	var userId='<%=userId%>';
	var legalDuties = '<%=legalDuties%>';
	var legalRecord="";
	var dutyId='';
</script>
<script type="text/javascript" src="ungovBuildLegalDetail.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js") %>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams/sorgUpload.js")%>'></script>
<script type="text/javascript">var rootPath='<%=SkinUtils.getRootUrl(request)%>';</script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"My97DatePicker/WdatePicker.js") %>'></script>
</head>
<body>
<%--定义dataset--%>
<model:datasets>
	<%--民办非企业基本信息--%>
	<model:dataset id="somOrganDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomOrganQueryCmd" global="true" method="queryOrganOnline">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomOrgan">
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
	<%--举办人情况--%>
	<model:dataset id="somHeldPeopleDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomHeldPeopleQueryCmd" global="true" pageSize="100">
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
	<model:dataset id="somHeldOrganDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomHeldOrganQueryCmd" global="true" pageSize="100">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomHeldOrgan">
			<model:field name="name" type="string" rule="require|length{100}" />
			<model:field name="heldorganPeople" type="string" rule="length{72}" />
			<model:field name="phone" type="string" rule="length{30}" />
		</model:record>
	</model:dataset>
	<!-- 负责人信息 -->
	<model:dataset id="somDutyDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomDutyQueryCmd" global="true" method="queryPeople" pageSize="100">
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
	<model:dataset id="somOfficeDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomOfficeQueryCmd" global="true" pageSize="100">
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
			<model:param name="filterSql" value='<%="MORG_CODE ="+organArea.substring(0,6)%>'></model:param>
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
	<%--党员情况--%>
	<model:dataset id="peopleTypeSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_PARTY_PEOPLE_TYPE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="somPartyMemberDataSet" cmd="com.inspur.cams.sorg.manage.cmd.SomPartyMemberQueryCmd" global="true" pageSize="100">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomPartyMember"></model:record>
	</model:dataset>
	<!-- 党员专兼职 -->
	<model:dataset id="ifPartyMemberFulltimeSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_SOM_PARTY_IF_FULLTIME'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="somDutyDataSet2" cmd="com.inspur.cams.sorg.base.cmd.SomDutyQueryCmd" global="true"  method="queryPeople">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomDuty"></model:record>
	</model:dataset>
	<model:dataset id="normalInfoSelect" enumName="SORG.PARTY.NORMAL_INFO" autoLoad="true" global="true"></model:dataset>
	<%--党员情况结束--%>

	<model:dataset id="comm_yesorno" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="opinionSelect" enumName="WORKFLOW.OPINION" autoLoad="true" global="true"></model:dataset>
</model:datasets>
<%--定义界面--%>
<next:Panel width="100%" height="100%">
	<next:TopBar>
		<next:ToolBarItem symbol="民办非企业单位（法人）成立登记"></next:ToolBarItem>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="return" text="返回" handler="goBack"></next:ToolBarItem>
	</next:TopBar>
	<next:TabPanel width="100%" height="100%" id="tab">
		<next:Tabs>
			<next:Panel title="登记申请表" width="100%" >
				<next:Panel width="100%" height="100%" autoScroll="true">
					<next:Html>
						<fieldset>
							<form method="post" dataset="somOrganDataSet" onsubmit="return false" class="L5form" >
							<table width="100%">
								<tr>
									<td class="FieldLabel"style="width:17%">民办非企业中文名称：</td>
									<td class="FieldInput" style="width:51%"colspan="3"><label type="text" id="cnName" name='民办非企业中文名称' field="cnName"  style="width:97%"/><span style="color:red">*</span></td>
									<td class="FieldLabel" style="width:17%">电话：</td>
									<td class="FieldInput" style="width:17%"><label type="text" id="sorgPhone" name='民办非企业电话' field="sorgPhone" style="width:90%"/></td>
								</tr>
								<tr>
									<td class="FieldLabel" style="width:17%">组织机构代码：</td>
									<td class="FieldInput" style="width:17%"><label type="text" id="organCode" name='登记证号' field="organCode" style="width:90%"/></td>
									<td class="FieldLabel" style="width:15%">邮编：</td>
									<td class="FieldInput" style="width:17%"><label type="text" id="sorgPost" name='民办非企业邮编' field="sorgPost" style="width:90%"/></td>
									<td class="FieldLabel" style="width:17%">成立日期：</td>
									<td class="FieldInput" style="width:17%"><label type="text" name='成立日期' field="buildDate" style="width:90%"/></td>
								</tr>
								<tr>
									<td class="FieldLabel" style="width:17%">住所来源：</td>
									<td class="FieldInput" style="width:17%"><label field="resideSource"  id="resideSource" name='住所来源' dataset="resideSourceSelect" style="width:90%""></label></td>
									<td class="FieldLabel" style="width:17%">住所：</td>
									<td class="FieldInput" colspan="3"><label type="text" name='住所' field="residence" style="width:97%"/></td>
								</tr>
								<tr>
									<td class="FieldLabel" style="width:17%">所属行（事）业：</td>
									<td class="FieldInput"><label field="busScope" name='所属行（事）业' dataset="busScopeSelect" style="width:90%"></label></td>
									<td class="FieldLabel" style="width:17%">从业人员数：</td>
									<td class="FieldInput"><label type="text" id="unitsNum" name='从业人员数' field="engagedNum" maxlength="6" style="width:90%"/></td>
									<td class="FieldLabel" style="width:15%">其中执业人员数：</td>
									<td class="FieldInput"><label type="text" id="peopleNum" name='其中执业人员数' field="practiceNum" maxlength="6" style="width:90%"/></td>
								</tr>
								<tr>
									<td class="FieldLabel">宗旨：</td>
									<td class="FieldInput" colspan="5"><textarea disabled rows="5" name='民办非企业宗旨' field="purpose" style="width:98%"></textarea></td>
								</tr>
								<tr>
									<td class="FieldLabel">业务范围：</td>
									<td class="FieldInput" colspan="5"><textarea disabled rows="5" name='业务范围' field="business" style="width:98%"></textarea></td>
								</tr>
								<tr>
									<td class="FieldLabel">基本设备、设施：</td>
									<td class="FieldInput" colspan="5"><textarea disabled rows="5" name='基本设备、设施' field="facilities" style="width:98%"></textarea></td>
								</tr>
								<tr>
									<td class="FieldLabel">开办资金数额：</td>
									<td class="FieldInput"><label type="text" id="regMon" name='开办资金数额' field="regMon" maxlength="10" style="width:68%"/>万元</td>
									<td class="FieldLabel">验资单位：</td>
									<td class="FieldInput" colspan="3"><label type="text" name='验资单位' field="checkCapitalOrgan" style="width:97%"></td>
								</tr>
								<tr>
									<td class="FieldLabel">开办资金来源：</td>
									<td class="FieldInput" colspan="5"><label type="text" name='开办资金来源' field="moneySource" style="width:98%"/></td>
								</tr>
								<tr>
									<td class="FieldLabel">住所产权单位：</td>
									<td class="FieldInput" colspan="3"><label type="text" name='住所产权单位' field="housingOrgan" style="width:97%"/></td>
									<td class="FieldLabel">用房面积：</td>
									<td class="FieldInput"><label type="text" id="housingArea" name='用房面积' field="housingArea" maxlength="10" style="width:65%"/>平方米</td>
								</tr>
								<tr id="leasePeriod" style="display:none">
									<td class="FieldLabel">租（借）期限：</td>
									<td class="FieldInput" colspan="5"><label type="text" field="leasePeriod" style="width:98%"/></td>
								</tr>
								<tr>
									<td class="FieldLabel">民办非企业通信地址：</td>
									<td class="FieldInput"><label type="text"name='民办非企业通信地址' id="sorgAdds" field="sorgAdds" style="width:90%"/></td>
									<td class="FieldLabel">民办非企业电子邮箱：</td>
									<td class="FieldInput"><label type="text" name='民办非企业电子邮箱' field="sorgEmail" style="width:90%"/></td>
									<td class="FieldLabel" style="width:15%">民办非企业传真：</td>
									<td class="FieldInput" style="width:17%"><label type="text" id="sorgFax" field="sorgFax" style="width:90%"/></td>
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
									<label type="text" id="borgNameDispaly" name="borgNameDispaly"  title="业务主管单位"/>
									<div id="popup" style="width:300px; height: 150px; display: none;position: absolute;background-color: #FFFFFF;" >
        								<ul></ul>
   									</div>
   									<label type="hidden" id="borgName" name="borgName" field="borgName" title="业务主管单位代码"/>
									<span style="color:red">*</span></td>

									<td class="FieldLabel" style="width:17%">业务主管单位审查同意日期：</td>
									<td class="FieldInput" style="width:17%"><label type="text" name='业务主管单位审查同意日期' field="borgCheckDate" style="width:90%"/></td>
								</tr>
								<tr>
									<td class="FieldLabel" style="width:17%">单位负责人：</td>
									<td class="FieldInput" style="width:17%"><label type="text" id="borgPeople" field="borgPeople" style="width:90%"/></td>
									<td class="FieldLabel" style="width:17%">单位电话：</td>
									<td class="FieldInput" style="width:17%"><label type="text" id="borgPhone" field="borgPhone" style="width:90%"/></td>
									<td class="FieldLabel" style="width:17%"></td>
									<td class="FieldInput" style="width:17%"></td>
								</tr>
							</table>
							</form>
						</fieldset>
					</next:Html>
				</next:Panel>
			</next:Panel>
			<next:Panel title="负责人情况">
				<next:EditGridPanel id="peopleGrid" dataset="somDutyDataSet" width="100%" stripeRows="true" height="99.9%">
					<next:TopBar>
						<next:ToolBarItem symbol="->"></next:ToolBarItem>
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
			<next:Panel title="法定代表人登记表" >
				<next:TabPanel  width="100%" height="100%">
					<next:Tabs>
						<next:Panel  title="基本信息"  width="100%" height="100%" autoScroll="true">
							<next:Html>
								<form  method="post" dataset="LegalPeopleDataSet" onsubmit="return false" class="L5form">
								<table width="100%">
								<tr>
									<td class="FieldLabel" style="width:12%">姓名：</td>
									<td class="FieldInput" style="width:12%"> <label type="text"  id='legalName' style="width:90%"  field="name" name="姓名"></td>
									<td class="FieldLabel"style="width:12%">性别：</td>
									<td class="FieldInput"style="width:10%">
										<label field="sex" name='"性别"' dataset="sexSelect" style="width:90%">
										</label></td>
									<td class="FieldLabel"style="width:10%">民族：</td>
									<td class="FieldInput"style="width:10%">
									<label field="folk" name='"民族"' dataset="folkSelect" style="width:90%">
										</label>
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
										<label field="politics" dataset="politicsSelect" name='"政治面貌"' style="width:90%">
										</label>
									</td>
									<td class="FieldLabel">文化程度：</td>
									<td class="FieldInput" colspan="3"><label dataset="educationSelect" field="education" name='"文化程度"' style="width:90%">
										</label>
									</td>
								</tr>
								<tr>
									<td class="FieldLabel">出生日期：</td>
									<td class="FieldInput">
										<label type="text" id="birthday" field="birthday"  name='"出生日期"' format="Y-m-d"  readonly="readonly" style="width:90%"/>
									</td>
									<td class="FieldLabel" style="width:15%">身份证号码：</td>
									<td class="FieldInput" style="width:21%" colspan="3"><label type="text"  field="idCard" name="身份证号码" style="width:90%" maxlength="18"></td>

								</tr>
								<tr>
									<td class="FieldLabel">职务：</td>
									<td class="FieldInput" ><label type="text" style="width:90%" field="sorgDuties" name="职务"></td>
									<td class="FieldLabel">技术职称：</td>
									<td class="FieldInput" colspan="3"><label type="text"style="width:90%"  field="profession" name="技术职称" maxlength="50"> </td>
								</tr>
								<tr>
									<td class="FieldLabel">户口所在地：</td>
									<td class="FieldInput" colspan="5"><label type="text" style="width:90%" field="populace" name="户口所在地" maxlength="100"> </td>
								</tr>
								<tr>
									<td class="FieldLabel">家庭住址：</td>
									<td class="FieldInput" colspan="2"><label type="text"style="width:90%"  field="adds" name="家庭住址" maxlength="100"> </td>
									<td class="FieldLabel">邮编：</td>
									<td class="FieldInput"><label type="text" style="width:90%" field="postCode" name="邮编" maxlength="6"> </td>
									<td class="FieldLabel">电话：</td>
									<td class="FieldInput"><label type="text"style="width:90%"  field="phone" name="电话" maxlength="30">  </td>
								</tr>
								<tr>
									<td class="FieldLabel">人事关系所在单位：</td>
									<td class="FieldInput" colspan="4"><label type="text"style="width:90%"  field="personUnit" maxlength="100" name="人事关系所在单位"> </td>
									<td class="FieldLabel">电话：</td>
									<td class="FieldInput"><label type="text" style="width:90%" field="personUnitPhone" maxlength="30" name="人事关系所在单位电话"> </td>
								</tr>
							</table>
								</form>
							</next:Html>
						</next:Panel>
						<next:EditGridPanel id="somResumeLegalGrid" dataset="somResumeDataSet" stripeRows="true" title="本人简历" width="100%" height="100%" autoScroll="true">
							<next:TopBar>
								<next:ToolBarItem symbol="->"></next:ToolBarItem>
							</next:TopBar>
							<next:Columns>
								<next:RowNumberColumn/>
								<next:RadioBoxColumn></next:RadioBoxColumn>
								<next:Column header="内码" field="id" width="15%" editable="true" hidden="true"><next:TextField/></next:Column>
								<next:Column header="开始年月" field="startDate" width="10%" editable="false"><next:TextField/></next:Column>
								<next:Column header="结束年月" field="endDate" width="10%" editable="false"><next:TextField/></next:Column>
								<next:Column header="在何地区何单位" field="workOrgan" width="30%" editable="false"><next:TextField/></next:Column>
								<next:Column header="任（兼）何职" field="duty" width="20%" editable="false"><next:TextField/></next:Column>
							</next:Columns>
							<next:BottomBar>
								<next:PagingToolBar dataset="somResumeDataSet" />
							</next:BottomBar>
						</next:EditGridPanel>
						<next:EditGridPanel id="uploadLegalPeopleGrid" title="法律要件" stripeRows="true" dataset="somLegalPeopleElectronicDataSet" width="100%" height="100%" autoScroll="true">
							<next:TopBar>
								<next:ToolBarItem symbol="附件列表"></next:ToolBarItem>
								<next:ToolBarItem symbol="->"></next:ToolBarItem>
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
			<next:Panel title="举办人情况" width="100%" >
				<next:TabPanel width="100%" height="100%" id="tab1">
					<next:Tabs>
						<next:Panel title="举办人（自然人）">
							<next:EditGridPanel id="heldPeopleGrid" dataset="somHeldPeopleDataSet" width="100%" stripeRows="true" height="100%">
								<next:TopBar>
									<next:ToolBarItem symbol="->"></next:ToolBarItem>
								</next:TopBar>
								<next:Columns>
									<next:RowNumberColumn/>
									<next:RadioBoxColumn></next:RadioBoxColumn>
									<next:Column header="内码" field="id" width="15%" editable="false" hidden="true"><next:TextField/></next:Column>
									<next:Column header="姓名" field="name" width="10%" editable="false"><next:TextField/></next:Column>
									<next:Column header="出生年月" field="birthday" width="10%" editable="false"><next:TextField /></next:Column>
									<next:Column header="户口所在地" field="populace" width="20%" editable="false"><next:TextField/></next:Column>
									<next:Column header="政治面貌" field="politics" width="20%" editable="false"><next:ComboBox dataset="politicsSelect"></next:ComboBox></next:Column>
									<next:Column header="人事关系所在单位" field="personUnit" width="25%" editable="false"><next:TextField/></next:Column>
									<next:Column header="工作单位" field="workName" width="25%" editable="false"><next:TextField/></next:Column>
									<next:Column header="工作单位职务" field="workDuties" width="15%" editable="false"><next:TextField/></next:Column>
									<next:Column header="联系电话" field="phone" width="20%" editable="false"><next:TextField/></next:Column>
								</next:Columns>
							</next:EditGridPanel>
						</next:Panel>

						<next:Panel title="举办人（单位）">
							<next:EditGridPanel id="heldOrganGrid" dataset="somHeldOrganDataSet" width="100%" stripeRows="true" height="100%">
								<next:TopBar>
									<next:ToolBarItem symbol="->"></next:ToolBarItem>
								</next:TopBar>
								<next:Columns>
									<next:RowNumberColumn/>
									<next:RadioBoxColumn></next:RadioBoxColumn>
									<next:Column header="内码" field="id" width="15%" editable="true" hidden="true"><next:TextField/></next:Column>
									<next:Column header="举办单位名称" field="name" width="40%" editable="false"><next:TextField/></next:Column>
									<next:Column header="举办单位主要负责人" field="heldorganPeople" width="15%" editable="false"><next:TextField/></next:Column>
									<next:Column header="联系电话" field="phone" width="20%" editable="false"><next:TextField/></next:Column>
								</next:Columns>
							</next:EditGridPanel>
						</next:Panel>
					</next:Tabs>
				</next:TabPanel>
			</next:Panel>
			<next:Panel title="内设机构">
				<next:EditGridPanel id="officeGrid" width="100%" stripeRows="true" height="100%" dataset="somOfficeDataSet">
					<next:TopBar>
						<next:ToolBarItem symbol="内设机构列表"></next:ToolBarItem>
						<next:ToolBarItem symbol="->"></next:ToolBarItem>
						<next:ToolBarItem iconCls="detail" text="查看" handler="editOffice"></next:ToolBarItem>
					</next:TopBar>

					<next:Columns>
						<next:RowNumberColumn />
						<next:RadioBoxColumn></next:RadioBoxColumn>
						<next:Column header="内设机构名称" field="name" width="25%" editable="false" ><next:TextField /></next:Column>
						<next:Column header="机构负责人" field="officeChief" width="15%" editable="false"><next:TextField /></next:Column>
						<next:Column header="场所"    field="place" width="43%" editable="false"><next:TextField /></next:Column>
						<next:Column header="电话" 	  field="phone"      width="15%" editable="false" ><next:TextField /></next:Column>
					</next:Columns>
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
								<td class="FieldInput" colspan="5"><label type="text" id="meetingName" field="meetingName" maxlength="100" style="width:90%"></td>
							</tr>
							<tr>
								<td class="FieldLabel" style="width:17%">时间：</td>
								<td class="FieldInput" style="width:17%"><label type="text" id="meetingDate" field="meetingDate" style="width:90%"></td>
								<td class="FieldLabel" style="width:17%">应到人数：</td>
								<td class="FieldInput" style="width:15%"><label type="text" name="应到人数" id="shouldNum" field="shouldNum" maxlength="6" style="width:90%"></td>
								<td class="FieldLabel" style="width:17%">实到人数：</td>
								<td class="FieldInput" style="width:17%"><label type="text" name="实到人数" id="realNum" field="realNum" maxlength="6" style="width:90%"></td>
							</tr>
							<tr>
								<td class="FieldLabel">同意人数：</td>
								<td class="FieldInput"><label type="text" name="同意人数" id="passNum" field="passNum" maxlength="6" style="width:90%"></td>
								<td class="FieldLabel">反对人数：</td>
								<td class="FieldInput"><label type="text" name="反对人数" id="nopassNum" field="nopassNum" maxlength="6" style="width:90%"></td>
								<td class="FieldLabel">弃权人数：</td>
								<td class="FieldInput"><label type="text" name="弃权人数" id="giveupNum" field="giveupNum" maxlength="6" style="width:90%"></td>
							</tr>
							<tr>
								<td class="FieldLabel">需说明的主要问题：</td>
								<td class="FieldInput" colspan="5"><textarea disabled name="需说明的主要问题" id="mainQuestion" field="mainQuestion" cols="65" rows="4" style="width:97%"></textarea></td>
							</tr>
						</table>
						</fieldset>
					</form>
				</next:Html>
			</next:Panel>
			<next:Panel title="党员情况">
				<next:EditGridPanel id="partyMemberGrid" dataset="somPartyMemberDataSet" width="100%" stripeRows="true" height="99.9%">
					<next:TopBar>
						<next:ToolBarItem symbol="社会组织党员情况调查表"></next:ToolBarItem>
						<next:ToolBarItem symbol="->"></next:ToolBarItem>
						<next:ToolBarItem iconCls="detail" text="查看" handler="editPartyMember"></next:ToolBarItem>
					</next:TopBar>
					<next:Columns>
						<next:RowNumberColumn/>
						<next:RadioBoxColumn></next:RadioBoxColumn>
						<next:Column header="内码" field="memberId" width="15%" editable="false" hidden="true"><next:TextField/></next:Column>
						<next:Column header="身份证号" field="idCard" width="20%" editable="false"><next:TextField/></next:Column>
						<next:Column header="姓名" field="name" width="10%" editable="false"><next:TextField/></next:Column>
						<next:Column header="人员类别" field="peopleType" width="10%" editable="false"><next:ComboBox dataset="peopleTypeSelect"/></next:Column>
						<next:Column header="性别" field="sex" width="10%" editable="false"><next:ComboBox dataset="sexSelect"/></next:Column>
						<next:Column header="出生日期" field="birthday" width="10%" editable="false"><next:TextField/></next:Column>
						<next:Column header="社会组织职务" field="sorgDuties" width="20%" editable="false"><next:ComboBox dataset="sorgDutiesSelect"/></next:Column>
						<next:Column header="主要任职单位" field="workName" width="20%" editable="false"><next:TextField/></next:Column>
						<next:Column header="主要任职单位职务" field="workDuties" width="20%" editable="false"><next:TextField /></next:Column>
					</next:Columns>
				</next:EditGridPanel>
			</next:Panel>
			<next:Panel title="法律要件" >
				<next:EditGridPanel id="uploadGrid" width="100%" stripeRows="true" height="100%" dataset="somElectronicDataSet">
					<next:TopBar>
						<next:ToolBarItem symbol="附件列表"></next:ToolBarItem>
						<next:ToolBarItem symbol="->"></next:ToolBarItem>
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
		</next:Tabs>
	</next:TabPanel>
</next:Panel>
<next:Window id="officeWin" title="民办非企业单位内设机构备案表" closeAction="hide"  width="740"modal='true'>
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="return" text="关闭" handler="winCloseOffice"></next:ToolBarItem>
	</next:TopBar>
	<next:Html>
		<form dataset="winOfficeDataSet"  onsubmit="return false"  class="L5form">
		<table border="1" width='100%'>
			<tr>
				<td class="FieldLabel" ><label>内设机构名称：</label></td>
				<td class="FieldInput"><label type="text" name="内设机构名称" id="name" field="name" style="width:90%"/></td>
				<td class="FieldLabel"><label>场所：</label></td>
				<td class="FieldInput" colspan="3"><label type="text" name="场所" id="place" field="place" style="width:96.5%" /></td>
			</tr>
			<tr>
				<td class="FieldLabel" style="width:13%"><label>机构负责人：</label></td>
				<td class="FieldInput" style="width:20%"><label type="text" name="机构负责人" id="officeChief" field="officeChief" style="width:90%"/></td>
				<td class="FieldLabel" style="width:13%"><label>电话：</label></td>
				<td class="FieldInput" style="width:20%"><label type="text" name="phone" id="phone_office" field="phone" style="width:90%"/></td>
				<td class="FieldLabel" style="width:13%"><label>邮编：</label></td>
				<td class="FieldInput" style="width:20%"><label type="text" name="postCode" id="postCode_office" field="postCode"  style="width:90%"/></td>
			</tr>

			<tr>
				<td class="FieldLabel"><label>职能：</label></td>
				<td class="FieldInput" colspan="5"><textarea disabled type="text" name="职能" id="dutiesDesc" field="dutiesDesc" rows="5" style="width:98%"></textarea></td>
			</tr>
			<tr>
				<td class="FieldLabel"><label>设立理由：</label></td>
				<td class="FieldInput" colspan="5"><textarea disabled type="text" name="设立理由" id="reason" field="reason" cols="75" rows="4" style="width:98%"></textarea></td>
			</tr>
		</table>
		</form>
   </next:Html>
</next:Window>



<jsp:include page="../../../../../../cams/sorg/comm/upload/uploadWindow.jsp" flush="true"/>
<jsp:include page="../../../borg/borgSelectWindow.jsp" flush="true"/>
<jsp:include page="../../../../../../cams/sorg/comm/upload/partyUpload.jsp" flush="true"/>
<jsp:include page="../../../../../../cams/sorg/comm/party/somPartyMemberDetail.jsp" flush="true"/>
<jsp:include page="../../../../../../cams/sorg/comm/people/peopleWindow.jsp" flush="true"/>
</body>
</html>
