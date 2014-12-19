<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="com.inspur.cams.comm.util.StrUtil,org.loushang.next.skin.SkinUtils,com.inspur.cams.sorg.util.SomIdHelp"%>
<%@ page import="org.loushang.bsp.security.context.GetBspInfo"%>
<%@ taglib uri="/tags/next-web" prefix="next" %>
<%@ taglib uri="/tags/next-model" prefix="model" %>
<%@ page import="com.inspur.cams.comm.util.*"%>
<%@page import="com.inspur.cams.sorg.util.ApplyType"%>
<%@page import="com.inspur.cams.sorg.online.apply.util.SomIdHelpOnline"%>
<%@ page import="com.inspur.cams.comm.extuser.data.ComExtUser"%>
<%@ page import="com.inspur.cams.sorg.online.extuser.util.SomExtBspInfo"%>
<html>
<head>
<title>基金会设立登记页面</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="fundBuildEdit.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js") %>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams/sorgUpload.js")%>'></script>
<script type="text/javascript">var rootPath='<%=SkinUtils.getRootUrl(request)%>';</script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams/somPhoto.js") %>'></script>
<script type="text/javascript" src="<%=SkinUtils.getRootUrl(request)%>skins/js/ISEditPhoto.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"My97DatePicker/WdatePicker.js") %>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams/sorgCheck.js") %>'></script>

<%
	ComExtUser comExtUser = (ComExtUser)SomExtBspInfo.getUserInfo(request).getComExtUser();
	String username = comExtUser.getUserName();
	String organArea = comExtUser.getAreaCode();//获取外部单位行政区划12位
	String userId = comExtUser.getUserId();
%>
<script type="text/javascript">
	var somApplyType='<%=ApplyType.SOM_FUND_BUILD%>';
	var currentUserName = '<%= username%>';
	var legalDutyId='<%=IdHelp.getUUID32()%>';
	var method='<%=request.getParameter("method")%>';
	<%
		String sorgId=request.getParameter("sorgId");
		if(sorgId==null){
			sorgId="";
		}
		String taskCode=request.getParameter("taskCode");
		if(taskCode==null){
			taskCode="";
		}
	%>
	var sorgId='<%=sorgId%>';
	if(sorgId == ''){
		sorgId = '<%=SomIdHelpOnline.getFundSorgId(organArea)%>';//生成业务编号
	}
	var taskCode='<%=taskCode%>';
	if(taskCode == ''){
		taskCode = '<%=SomIdHelpOnline.getFundTaskCode(organArea)%>';//生成业务编号
	}
	var morgArea='<%=organArea%>';
	var userId='<%=userId%>';
</script>
</head>
<body>
<%--定义dataset--%>
<model:datasets>
	<%--基金会基本信息--%>
	<model:dataset id="somOrganDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomOrganQueryCmd" global="true" method="queryOrganOnline">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomOrgan">
			<%--基金会基本信息验证 --%>
			<model:field name="cnName" type="string" rule="require|length{100}" />
			<model:field name="enName" type="string" rule="length{100}" />
			<model:field name="abName" type="string" rule="length{50}" />
			<model:field name="sorgKind" type="string" rule="require" />
			<model:field name="residence" type="string" rule="require|length{100}" />
			<model:field name="sorgPost" type="string" rule="length{6}" />
			<model:field name="sorgAdds" type="string" rule="length{200}" />
			<model:field name="sorgEmail" type="string" rule="email|length{100}" />
			<model:field name="actArea" type="string" rule="length{50}" />
			<model:field name="purpose" type="string" rule="length{1000}" />
			<model:field name="business" type="string" rule="length{1000}" />
			<model:field name="borgName" type="string" rule="length{100}" />
			<model:field name="unitsNum" type="string" rule="integer" />
			<model:field name="peopleNum" type="string" rule="integer" />
			<model:field name="councilNum" type="string" rule="integer" />
			<model:field name="standCouncilNum" type="string" rule="integer" />
			<model:field name="fundingPeople" type="string" rule="length{500}" />
			<model:field name="checkCapitalOrgan" type="string" rule="length{100}" />
			<model:field name="moneySource" type="string" rule="length{500}" />
			<model:field name="housingOrgan" type="string" rule="length{100}" />
			<model:field name="leasePeriod" type="string" rule="length{100}" />
			<model:field name="regMon" type="string" rule="double|length{14}" />
		</model:record>
	</model:dataset>
	<!-- 届次信息 -->
	<model:dataset id="somSessionDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomSessionQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomSession">
			<model:field name="tenure" type="string" rule="integer|length{2}" />
			<model:field name="sessionName" type="string" rule="length{100}"/>
		</model:record>
	</model:dataset>
	<!-- 监事备案 -->
	<model:dataset id="aspForJianShi" cmd="com.inspur.cams.sorg.base.cmd.SomDutyQueryCmd" global="true" method="queryAspchief" pageSize="100">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomDuty">
			<model:field name="idCard" type="string" rule="length{18}" />
			<model:field name="name" type="string" rule="require|length{72}" />
			<model:field name="aliasName" type="string" rule="length{72}" />
			<model:field name="phone" type="string" rule="length{30}" />
			<model:field name="sorgDuties" type="string" rule="require" />
			<model:field name="adds" type="string" rule="length{100}" />
			<model:field name="populace" type="string" rule="length{100}" />
			<model:field name="postCode" type="string" rule="length{6}" />
			<model:field name="workName" type="string" rule="length{100}" />
			<model:field name="workDuties" type="string" rule="length{50}" />
			<model:field name="resume" type="string" rule="length{1000}" />
			<model:field name="workOpinion" type="string" rule="length{200}" />
			<model:field name="sorgOpinion" type="string" rule="length{200}" />
			<model:field name="promiseOrgan" type="string" rule="length{100}" />
			<model:field name="promiseCode" type="string" rule="length{100}" />
			<model:field name="otherDuties" type="string" rule="length{500}" />
			<model:field name="note" type="string" rule="length{200}" />
		</model:record>
	</model:dataset>
	<!-- 理事备案 -->
	<model:dataset id="aspForLiShi" cmd="com.inspur.cams.sorg.base.cmd.SomDutyQueryCmd" method="queryAspchief" global="true" pageSize="100">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomDuty">
			<model:field name="idCard" type="string" rule="length{18}" />
			<model:field name="name" type="string" rule="require|length{72}" />
			<model:field name="aliasName" type="string" rule="length{72}" />
			<model:field name="phone" type="string" rule="length{30}" />
			<model:field name="sorgDuties" type="string" rule="require" />
			<model:field name="adds" type="string" rule="length{100}" />
			<model:field name="populace" type="string" rule="length{100}" />
			<model:field name="postCode" type="string" rule="length{6}" />
			<model:field name="workName" type="string" rule="length{100}" />
			<model:field name="workDuties" type="string" rule="length{50}" />
			<model:field name="resume" type="string" rule="length{1000}" />
			<model:field name="workOpinion" type="string" rule="length{200}" />
			<model:field name="sorgOpinion" type="string" rule="length{200}" />
			<model:field name="promiseOrgan" type="string" rule="length{100}" />
			<model:field name="promiseCode" type="string" rule="length{100}" />
			<model:field name="otherDuties" type="string" rule="length{500}" />
			<model:field name="note" type="string" rule="length{200}" />
		</model:record>
	</model:dataset>
	<!-- 法定代表人信息 -->
	<model:dataset id="LegalPeopleDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomDutyQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomDuty">

		</model:record>
	</model:dataset>
	<!-- 负责人录入窗口 -->
	<model:dataset id="peopleInsertDataset" cmd="com.inspur.cams.sorg.base.cmd.SomDutyQueryCmd" global="true" pageSize="100">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomDuty">
			<model:field name="idCard" type="string" rule="length{18}" />
			<model:field name="name" type="string" rule="require|length{72}" />
			<model:field name="aliasName" type="string" rule="length{72}" />
			<model:field name="phone" type="string" rule="length{30}" />
			<model:field name="sorgDuties" type="string" rule="require" />
			<model:field name="ifPartyLeader" type="string" rule="require" />
			<model:field name="startDate" type="string" rule="require" />
			<model:field name="adds" type="string" rule="length{100}" />
			<model:field name="populace" type="string" rule="length{100}" />
			<model:field name="postCode" type="string" rule="length{6}" />
			<model:field name="workName" type="string" rule="length{100}" />
			<model:field name="workDuties" type="string" rule="length{50}" />
			<model:field name="resume" type="string" rule="length{1000}" />
			<model:field name="workOpinion" type="string" rule="length{200}" />
			<model:field name="sorgOpinion" type="string" rule="length{200}" />
			<model:field name="promiseOrgan" type="string" rule="length{100}" />
			<model:field name="promiseCode" type="string" rule="length{100}" />
			<model:field name="otherDuties" type="string" rule="length{500}" />
			<model:field name="note" type="string" rule="length{200}" />
		</model:record>
	</model:dataset>
	<%--所有符合身份证号的人员列表--%>
	<model:dataset id="winPeopleDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomPeopleQueryCmd" >
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomPeople"></model:record>
	</model:dataset>
	<%--所有符合身份证号的人员列表--%>
	<model:dataset id="winDutyDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomDutyQueryCmd"  method="queryPeople">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomDuty"></model:record>
	</model:dataset>
	<%-- 章程核准信息 --%>
	<model:dataset id="somRuleDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomRuleQueryCmd" method="queryRule" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomRule">
			<model:field name="shouldNum" type="string" rule="number"/>
			<model:field name="realNum" type="string" rule="number"/>
			<model:field name="passNum" type="string" rule="number"/>
			<model:field name="nopassNum" type="string" rule="number"/>
			<model:field name="giveupNum" type="string" rule="number"/>
			<model:field name="meetingContent" type="string" rule="length{500}"/>
			<model:field name="borgOpinion" type="string" rule="length{200}"/>
			<model:field name="meetingName" type="string" rule="length{100}"/>
			<model:field name="meetingFormat" type="string" rule="length{30}"/>
			<model:field name="mainQuestion" type="string" rule="length{1000}"/>
		</model:record>
	</model:dataset>
	<%--电子档案--%>
	<model:dataset id="somElectronicDataSet" cmd="com.inspur.cams.sorg.upload.cmd.SomElectronicQueryCmd" global="true" method="queryCatalog" isGroup="true" groupField="applyType" pageSize="50">
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
	<%--人员电子档案--%>
	<model:dataset id="somPeopleElectronicDataSet" cmd="com.inspur.cams.sorg.upload.cmd.SomElectronicQueryCmd" global="true" method="queryPeopleCatalog">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomElectronic"></model:record>
	</model:dataset>
	<%--人员电子档案上传窗口--%>
	<model:dataset id="winPeopleElectronicDataSet" cmd="com.inspur.cams.sorg.upload.cmd.SomElectronicQueryCmd" global="true" method="queryPeopleElectronic">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomElectronic"></model:record>
	</model:dataset>
	<!-- 发起人 -->
	<model:dataset id="somHeldPeopleDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomHeldPeopleQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomHeldPeople">
			<model:field name="ifChief" type="string" rule="" />
			<model:field name="name" type="string" rule="require|length{72}" />
			<model:field name="birthday" type="string" rule="length{10}" />
			<model:field name="workName" type="string" rule="length{100}" />
			<model:field name="workDuties" type="string" rule="length{100}" />
		</model:record>
	</model:dataset>
	<!-- 发起组织 -->
	<model:dataset id="somHeldOrganDataSet"cmd="com.inspur.cams.sorg.base.cmd.SomHeldOrganQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomHeldOrgan">
			<model:field name="name" type="string" rule="require|length{100}" />
			<model:field name="heldorganPeople" type="string" rule="length{72}" />
		</model:record>
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
	<model:dataset id="somApplyDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomApplyQueryCmd"  global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomApply">
		<%--业务意见信息验证--%>
			<model:field name="appPeople" type="string" rule="length{72}" />
			<model:field name="appPhone" type="string" rule="length{30}" />
			<model:field name="acceptPeopleName" type="string" rule="length{100}" />
			<model:field name="acceptOpinion" type="string" rule="length{500}"/>
			<model:field name="examinPeopleName" type="string" rule="length{30}" />
			<model:field name="examinOpinion" type="string" rule="length{30}" />
			<model:field name="checkPeopleName" type="string" rule="length{30}" />
			<model:field name="checkOpinion" type="string" rule="length{30}" />
			<model:field name="auditPeopleName" type="string" rule="length{30}" />
			<model:field name="auditOpinion" type="string" rule="length{30}" />
		 	<model:field name="sorgPhone" type="string" rule="length{30}"/>
		 	<model:field name="borgOpinion" type="string" rule="length{100}"/>
		</model:record>
	</model:dataset>
	<%--人员简历 --%>
	<model:dataset id="somResumeInsertDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomPeopleResumeQueryCommand" sortField="startDate" sortDirection="DESC" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomPeopleResume">
			<model:field name="startDate" type="string" rule="length{8}" />
			<model:field name="endDate" type="string" rule="length{8}" />
			<model:field name="workOrgan" type="string" rule="length{200}" />
			<model:field name="duty" type="string" rule="length{100}" />
		</model:record>
	</model:dataset>
	<%--法定代表人人员简历 --%>
	<model:dataset id="somResumeLegalDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomPeopleResumeQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomPeopleResume"></model:record>
	</model:dataset>
	<!-- 处理单位 -->
	<model:dataset id="pubOrganDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='PUB_ORGAN'></model:param>
			<model:param name="value" value='ORGAN_ID'></model:param>
			<model:param name="text" value='ORGAN_NAME'></model:param>
		</model:params>
	</model:dataset>

	<%--定义字典表--%>
	<model:dataset id="certTypeSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_CERT_TYPE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
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
			<model:param name="dic" value='DIC_FUND_KIND'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="countrySelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true" sortField="SORT_NO">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_COUNTRY'></model:param>
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
	<!-- 民族 -->
	<model:dataset id="ifServeSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_DUTY_IF_SERVE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
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
	<!-- 性别 -->
	<model:dataset id="sexSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_SEX'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 社会组织职务 -->
	<model:dataset id="sorgDutiesDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_SOM_DUTY'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="comm_yesorno" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="yesornoDataSet" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
</model:datasets>
<%--定义界面--%>
<next:Panel width="100%" height="100%">
	<next:TopBar>
		<next:ToolBarItem symbol="基金会成立登记"></next:ToolBarItem>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="select" text="保存" handler="save"></next:ToolBarItem>
		<next:ToolBarItem iconCls="return" text="返回" handler="returnClick"></next:ToolBarItem>
	</next:TopBar>
	<next:TabPanel width="100%" height="100%" id="tab">
		<next:Tabs>
			<next:Panel title="基金会法人设立申请表" width="100%" >
				<next:Panel width="100%" height="100%" id="tab1" autoScroll="true">
						<next:Html>
							<fieldset>
							<legend>基金会法人设立申请表</legend>
							<form method="post" onsubmit="return false" class="L5form" dataset="somOrganDataSet">
							<table width="100%">
								<tr>
									<td class="FieldLabel">基金会中文名称：</td>
									<td class="FieldInput" colspan="3">
									<label type="text" id="cnName" name='基金会中文名称' field="cnName" style="width:55%"/>
									</td>
								</tr>
								<tr>
									<td class="FieldLabel" style="width:17%">基金会英文名称：</td>
									<td class="FieldInput"  style="width:17%"><input type="text" name='基金会英文名称' field="enName" style="width:90%"/></td>
									<td class="FieldLabel" style="width:17%">基金会英文名称缩写：</td>
									<td class="FieldInput" style="width:17%"><input type="text" field="abName" name='基金会英文名称缩写' style="width:90%"/></td>
								</tr>
								<tr>
									<td class="FieldLabel" style="width:17%">登记时间：</td>
									<td class="FieldInput" style="width:17%"><input type="text" name='登记时间' id="regDate" field="regDate" onClick="WdatePicker()" style="width:90%"/><span style="color:red">*</span></td>
									<td class="FieldLabel">基金会类型：</td>
									<td class="FieldInput"><select id="sorgKind" field="sorgKind" name='基金会类型' style="width:90%"><option dataset="sorgKindSelect"></option></select><span style="color:red">*</span></td>
								</tr>
								<tr>
									<td class="FieldLabel">原始基金币种：</td>
									<td class="FieldInput"><input
									type="text" id="currency" name='原始基金币种' field="currency"
									style="width: 90%" /></td>
									<td class="FieldLabel">原始基金：</td>
									<td class="FieldInput"><input type="text" id="regMon" name='活动资金数额' field="regMon" maxlength="10" style="width:30%"/>万元</td>
								</tr>
								<tr>
									<td class="FieldLabel">法定代表人：</td>
									<td class="FieldInput" colspan="3"><label id="legalPeople"/></td>
								</tr>
								<tr>
									<td class="FieldLabel">理事数：</td>
									<td class="FieldInput"><label id="councilNum" /></td>
									<td class="FieldLabel">监事数：</td>
									<td class="FieldInput"><label id="standCouncilNum" /></td>
								</tr>
								<tr>
									<td class="FieldLabel">宗旨(20字以内)：</td>
									<td class="FieldInput" colspan="3"><textarea rows="5"
										name="宗旨" field="purpose" style="width: 97%"></textarea><span style="color:red">*</span></td>
								</tr>
								<tr>
									<td class="FieldLabel">业务范围：</td>
									<td class="FieldInput" colspan="3"><textarea rows="5"
										name="业务范围" field="business" style="width: 97%"></textarea><span style="color:red">*</span></td>
								</tr>
								<tr>
									<td class="FieldLabel">申请理由：</td>
									<td class="FieldInput" colspan="3"><textarea rows="5"
										name="申请理由" field="appReason" style="width: 97%"></textarea></td>
								</tr>
								<tr>
									<td class="FieldLabel">业务主管单位：</td>
									<td class="FieldInput">
										<input type="text" id="borgNameDispaly" name="borgNameDispaly" style="width:65%"  title="业务主管单位"  onkeyup="findDiv(this,'borgName','popup','','businessOrganAuto','BORG_NAME@like','borgCode','borgName','35')" onblur="clearDiv();" onchange="clearBorg(this);"/><img src="<%=SkinUtils.getImage(request,"l5/help.gif")%>" style="cursor:hand" onclick="showBorgWin()"/>
										<div id="popup" style="width:300px; height: 150px; display: none;position: absolute;background-color: #FFFFFF;" >
	        								<ul></ul>
	   									</div>
	   									<input type="hidden" id="borgName" name="borgName" field="borgName" title="业务主管单位代码"/>
										<span style="color:red">*</span></td>
									<td class="FieldLabel"  >电话：</td>
									<td class="FieldInput" ><input
										type="text" name='电话' id='sorgPhone'field="sorgPhone"
										 style="width: 90%" /></td>
								</tr>
								<tr>
									<td class="FieldLabel">住所：</td>
									<td class="FieldInput"><input type="text" name='住所' field="residence" style="width:90%"/><span style="color:red">*</span></td>
									<td class="FieldLabel" style="width:17%">邮编：</td>
									<td class="FieldInput" style="width:17%"><input type="text" id="sorgPost" name='基金会邮编' field="sorgPost" style="width:90%"/></td>
								</tr>
							</table>
							</form>
							</fieldset>
							<fieldset>
							<form method="post"  onsubmit="return false" class="L5form" style="border-width:0px" dataset="somApplyDataSet">
							<legend>联系人信息</legend>
							<table width="100%">
								<tr>
									<td class="FieldLabel" style="width:17%">联系人：</td>
									<td class="FieldInput" style="width:17%"><input type="text" name='"申请人"' field="appPeople" style="width:90%"/></td>
									<td class="FieldLabel" style="width:17%">联系人电话：</td>
									<td class="FieldInput" style="width:17%"><input type="text" id="sorgPhone" name='"申请人电话"' field="appPhone" style="width:90%"/></td>
								</tr>
							</table>
							</form>
							</fieldset>
					</next:Html>
				</next:Panel>
			</next:Panel>
			<next:Panel title="发起人情况">
				<next:EditGridPanel id="heldPeopleGrid"
					dataset="somHeldPeopleDataSet" width="100%" stripeRows="true"
					height="100%">
					<next:TopBar>
						<next:ToolBarItem symbol="->"></next:ToolBarItem>
						<next:ToolBarItem iconCls="add" text="增加" handler="addHeldPeople"></next:ToolBarItem>
						<next:ToolBarItem iconCls="delete" text="删除"
							handler="delHelpPeople"></next:ToolBarItem>
					</next:TopBar>
					<next:Columns>
						<next:RowNumberColumn />
						<next:RadioBoxColumn></next:RadioBoxColumn>
						<next:Column header="内码" field="id" width="15%" editable="true"
							hidden="true">
							<next:TextField />
						</next:Column>
						<next:Column header="身份证号" field="idCard" width="20%" editable="true"><next:TextField/></next:Column>
						<next:Column header="姓名" field="name" width="10%" editable="true">
							<next:TextField />
						</next:Column>
						<next:Column header="出生年月" field="birthday" width="10%" editable="true"><next:TextField /></next:Column>
						<next:Column header="工作单位" field="workName" width="25%"
							editable="true">
							<next:TextField />
						</next:Column>
						<next:Column header="工作单位职务" field="workDuties" width="15%"
							editable="true">
							<next:TextField />
						</next:Column>
						<next:Column header="联系电话" field="phone" width="20%"
							editable="true">
							<next:TextField />
						</next:Column>
					</next:Columns>
					<next:BottomBar>
						<next:PagingToolBar dataset="somHeldPeopleDataSet"/>
					</next:BottomBar>
				</next:EditGridPanel>
			</next:Panel>
			<next:Panel title="发起单位情况">
				<next:EditGridPanel id="heldOrganGrid" dataset="somHeldOrganDataSet"
					width="100%" stripeRows="true" height="100%">
					<next:TopBar>
						<next:ToolBarItem symbol="->"></next:ToolBarItem>
						<next:ToolBarItem iconCls="add" text="增加" handler="addHeldOrgan"></next:ToolBarItem>
						<next:ToolBarItem iconCls="delete" text="删除"
							handler="delHeldOrgan"></next:ToolBarItem>
					</next:TopBar>
					<next:Columns>
						<next:RowNumberColumn />
						<next:RadioBoxColumn></next:RadioBoxColumn>
						<next:Column header="内码" field="id" width="15%" editable="true"
							hidden="true">
							<next:TextField />
						</next:Column>
						<next:Column header="发起单位名称" field="name" width="40%"
							editable="true">
							<next:TextField />
						</next:Column>
						<next:Column header="发起单位主要负责人" field="heldorganPeople"
							width="25%" editable="true">
							<next:TextField />
						</next:Column>
						<next:Column header="联系电话" field="phone" width="20%"
							editable="true">
							<next:TextField />
						</next:Column>
					</next:Columns>
					<next:BottomBar>
						<next:PagingToolBar dataset="somHeldOrganDataSet"/>
					</next:BottomBar>
				</next:EditGridPanel>
			</next:Panel>
<next:Panel title="基金会理事、监事备案表" width='100%'autoScroll="true" >
<next:Panel>
	<next:Html>
	<fieldset>
		<legend>基金会信息</legend>
		<form onsubmit="return false"  class="L5form" dataset="somSessionDataSet">
			<table width="100%">
				<tr>
					<td class="FieldLabel">届次名称：</td>
					<td class="FieldInput" colspan="3"><input type="text" id="sessionName" field="sessionName" style="width:97%"/></td>
					<td class="FieldLabel" style="width:17%">本届任期（年）：</td>
					<td class="FieldInput" style="width:17%"><input type="text" id="tenure" field="tenure" style="width:90%" onchange="calSessionDate()" /></td>
				</tr>
				<tr>
					<td class="FieldLabel" style="width:17%">本届开始日期：</td>
					<td class="FieldInput" style="width:17%"><input type="text" id="startDate" onchange="calSessionDate()" field="startDate"onClick="WdatePicker()" style="width:90%"/></td>
					<td class="FieldLabel" style="width:17%">规定换届日期：</td>
					<td class="FieldInput" style="width:15%"><input type="text"  id="endDate" field="endDate" onClick="WdatePicker()" style="width:90%"/></td>
					<td class="FieldLabel" style="width:17%"></td>
					<td class="FieldInput" style="width:17%"></td>
				</tr>
			</table>
		</form>
		</fieldset>
	</next:Html>
</next:Panel>
<next:Panel height="300" >
<next:EditGridPanel id="peopleGrid" dataset="aspForLiShi"  stripeRows="true" height="99.9%" hasSum="true" title="理事备案表">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="add" text="新增" handler="addL"></next:ToolBarItem>
		<next:ToolBarItem iconCls="edit" text="修改" handler="updateL"></next:ToolBarItem>
		<next:ToolBarItem iconCls="delete" text="删除" handler="delL"></next:ToolBarItem>
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn/>
		<next:RadioBoxColumn></next:RadioBoxColumn>
		<next:Column header="身份证号" field="idCard" width="20%" editable="false"summaryType="count">
			<next:ExtendConfig>
				summaryRenderer : countRender
			</next:ExtendConfig>
		<next:TextField/></next:Column>
		<next:Column header="姓名" field="name" width="10%" editable="false"><next:TextField/></next:Column>
		<next:Column header="性别" field="sex" width="10%" editable="false"><next:ComboBox dataset="sexSelect"/></next:Column>
		<next:Column header="出生年月" field="birthday" width="10%" editable="false"><next:TextField/></next:Column>
		<next:Column header="担任职务" field="sorgDuties" width="10%" editable="false"><next:ComboBox dataset="sorgDutiesSelect"/></next:Column>
		<next:Column header="是否在任" field="ifServe"width="10%" editable="false"><next:TextField/><next:ComboBox dataset="ifServeSelect"/></next:Column>
		<next:Column header="任职开始日期" field="startDate" width="15%" editable="false"><next:TextField/></next:Column>
		<next:Column header="任职结束日期" field="endDate" width="15%" editable="false"><next:TextField/></next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="aspForLiShi" />
	</next:BottomBar>
</next:EditGridPanel>
</next:Panel>
<next:Panel height="250" >
<next:EditGridPanel id="peopleGrid1" dataset="aspForJianShi"  stripeRows="true" hasSum="true" height="99.9%" title="监事备案表">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="add" text="新增" handler="addS"></next:ToolBarItem>
		<next:ToolBarItem iconCls="edit" text="修改" handler="updateS"></next:ToolBarItem>
		<next:ToolBarItem iconCls="delete" text="删除" handler="delS"></next:ToolBarItem>
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn/>
		<next:RadioBoxColumn></next:RadioBoxColumn>
		<next:Column header="身份证号" field="idCard" width="20%" editable="false"summaryType="count">
			<next:ExtendConfig>
				summaryRenderer : countRenderS
			</next:ExtendConfig>
		<next:TextField/></next:Column>
		<next:Column header="姓名" field="name" width="10%" editable="false"><next:TextField/></next:Column>
		<next:Column header="性别" field="sex" width="10%" editable="false"><next:ComboBox dataset="sexSelect"/></next:Column>
		<next:Column header="出生年月" field="birthday" width="10%" editable="false"><next:TextField/></next:Column>
		<next:Column header="担任职务" field="sorgDuties" width="10%" editable="false"><next:ComboBox dataset="sorgDutiesSelect"/></next:Column>
		<next:Column header="是否在任" field="ifServe"width="10%" editable="false"><next:TextField/><next:ComboBox dataset="ifServeSelect"/></next:Column>
		<next:Column header="任职开始日期" field="startDate" width="15%" editable="false"><next:TextField/></next:Column>
		<next:Column header="任职结束日期" field="endDate" width="15%" editable="false"><next:TextField/></next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="aspForJianShi" />
	</next:BottomBar>
</next:EditGridPanel>
</next:Panel>
</next:Panel>
			<next:Panel title="法定代表人登记表" >
				<next:TabPanel  width="100%" height="100%">
					<next:Tabs>
						<next:Panel title="基本信息"  width="100%" height="100%" autoScroll="true">
							<next:Html>
								<form  method="post" dataset="LegalPeopleDataSet" onsubmit="return false" class="L5form">
									<table width="100%">
										<tr>
											<td class="FieldLabel" style="width:15%">身份证号码：</td>
											<td class="FieldInput" style="width:21%"><label id="labelIdCard" field="idCard"/></td>
											<td class="FieldLabel" style="width:14%">姓名：</td>
											<td class="FieldInput" style="width:17%"><label field="name"/></td>
											<td class="FieldLabel" style="width:14%" rowspan="4">照片:</td>
											<td class="FieldInput" style="width:19%" nowrap colspan="1" rowspan="4">
											<div id="photoDiv">
												<img id="img" name="RELATIONER_PHOTOC_IMG" width=82.5 height=110 src="<%=SkinUtils.getRootUrl(request) %>jsp/cams/sorg/comm/signet/default.jpg"
												align="top" ondblclick="editPhoto(1,'photoId','RELATIONER_PHOTOC_IMG');"
												onerror="javascript:this.src='<%=SkinUtils.getRootUrl(request) %>jsp/cams/sorg/comm/signet/default.jpg'" alt="暂无图片" />
												<input type="hidden" id="photoId" name="photoId"/>
											</div>
											</td>
										</tr>
										<tr>
											<td class="FieldLabel">曾用名：</td>
											<td class="FieldInput"><label field="aliasName"/></td>
											<td class="FieldLabel">年龄：</td>
											<td class="FieldInput"><label id="labelAge" name='年龄'/></td>
										</tr>
										<tr>
											<td class="FieldLabel">性别：</td>
											<td class="FieldInput"><label field="sex" dataset="sexSelect"/></td>
											<td class="FieldLabel">出生年月：</td>
											<td class="FieldInput"><label field="birthday"/></td>
										</tr>
										<tr>
											<td class="FieldLabel">政治面貌：</td>
											<td class="FieldInput"><label field="politics" dataset="politicsSelect"/></td>
											<td class="FieldLabel">民族：</td>
											<td class="FieldInput"><label field="folk" dataset="folkSelect"/></td>
										</tr>
										<tr>
											<td class="FieldLabel">国籍：</td>
											<td class="FieldInput"><label field="nation" dataset="countrySelect"/></td>
											<td class="FieldLabel">家庭住址：</td>
											<td class="FieldInput"><label field="adds"/></td>
											<td class="FieldLabel">户口所在地：</td>
											<td class="FieldInput"><label field="populace"/></td>
										</tr>
										<tr>
											<td class="FieldLabel">邮编：</td>
											<td class="FieldInput"><label field="postCode"/></td>
											<td class="FieldLabel">电话：</td>
											<td class="FieldInput"><label field="phone"/></td>
											<td class="FieldLabel">专/兼职：</td>
											<td class="FieldInput"><label field="ifFulltime" dataset="ifFulltimeSelect" /></td>
										</tr>
										<tr>
											<td class="FieldLabel">工作单位：</td>
											<td class="FieldInput" colspan="3"><label field="workName"/></td>
											<td class="FieldLabel">工作单位职务：</td>
											<td class="FieldInput"><label field="workDuties"/></td>
										</tr>
										<tr>
											<td class="FieldLabel">基金会职务：</td>
											<td class="FieldInput"><label field="sorgDuties" dataset="sorgDutiesDataSet"/></td>
											<td class="FieldLabel">任职开始日期：</td>
											<td class="FieldInput"><label field="startDate"/></td>
											<td class="FieldLabel"><label>任职结束日期：</label></td>
											<td class="FieldInput"></td>
										</tr>
										<tr>
											<td class="FieldLabel">是否党政机关领导干部：</td>
											<td class="FieldInput"><label field="ifPartyLeader" name='是否党政机关领导干部' dataset="comm_yesorno"/></td>
											<td class="FieldLabel">批准机关：</td>
											<td class="FieldInput"><label field="promiseOrgan"/></td>
											<td class="FieldLabel">批准文号：</td>
											<td class="FieldInput"><label field="promiseCode" /></td>
										</tr>
										<tr>
											<td class="FieldLabel">其他社会职务：</td>
											<td class="FieldInput" colspan="5"><textarea rows="3" field="otherDuties" name='"其他社会职务"' style="width:98%;background-color:#F5FAFA;border:0" readonly></textarea></td>
										</tr>
										<tr>
											<td class="FieldLabel">本人所在单位人事部门审查意见：</td>
											<td class="FieldInput" colspan="5"><textarea rows="2" name='"所在单位人事部门审查意见"'field="workOpinion" style="width:98%;background-color:#F5FAFA;border:0" readonly></textarea></td>
										</tr>
										<tr>
											<td class="FieldLabel">审查工作单位：</td>
											<td class="FieldInput" colspan="3"><label  field="workName"/></td>
											<td class="FieldLabel">审查日期：</td>
											<td class="FieldInput"><label  field="workCheckDate"/></td>
										</tr>
										<tr>
												<td class="FieldLabel"><label>按照本基金会章程会议产生通过情况：</label></td>
												<td class="FieldInput" colspan="5"><textarea   rows="2" name='"按照本基金会章程会议产生通过情况"' field="sorgOpinion" style="width:97.7%"></textarea></td>
										</tr>
										<tr>
												<td class="FieldLabel"><label>签署日期：</label></td>
												<td class="FieldInput" colspan="5"><input type="text"  field="sorgCheckDate" onClick="WdatePicker()" style="width:22%"/></td>
										</tr>
										<tr>
											<td class="FieldLabel">备注：</td>
											<td class="FieldInput" colspan="5"><textarea rows="2" name='"备注"' field="note"style="width:98%;background-color:#F5FAFA;border:0" readonly></textarea></td>
										</tr>
									</table>
								</form>
							</next:Html>
					</next:Panel>
					<next:EditGridPanel id="somResumeLegalGrid" dataset="somResumeLegalDataSet" stripeRows="true" title="本人简历" width="100%" height="100%" autoScroll="true">
						<next:TopBar>
							<next:ToolBarItem symbol="->"></next:ToolBarItem>
						</next:TopBar>
						<next:Columns>
							<next:RowNumberColumn/>
							<next:Column header="内码" field="id" width="15%" editable="true" hidden="true"><next:TextField/></next:Column>
							<next:Column header="开始年月" field="startDate" width="10%" editable="false"><next:TextField/></next:Column>
							<next:Column header="结束年月" field="endDate" width="10%" editable="false"><next:TextField/></next:Column>
							<next:Column header="在何地区何单位" field="workOrgan" width="45%" editable="false"><next:TextField/></next:Column>
							<next:Column header="任（兼）何职" field="duty" width="20%" editable="false"><next:TextField/></next:Column>
						</next:Columns>
						<next:BottomBar>
							<next:PagingToolBar dataset="somResumeLegalDataSet" />
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
<next:Panel title="章程核准表"  width="100%" autoScroll="true">
		<next:Html>
			<form id="ruleForm" method="post"  onsubmit="return false" class="L5form" dataset="somRuleDataSet">
			<fieldset>
			<legend>章程核准表</legend>
			<input type="hidden" id="sorgId" field="sorgId" value="社团ID">
			<table width="100%">

				<tr>
					<td class="FieldLabel">会议名称：</td>
					<td class="FieldInput"><input type="text" id="meetingName" field="meetingName" maxlength="100" style="width:90%"></td>
					<td class="FieldLabel">表决形式：</td>
					<td class="FieldInput" colspan="3"><input type="text" id="meetingFormat" field="meetingFormat" maxlength="30" style="width:90%"></td>
				</tr>
				<tr>
					<td class="FieldLabel" style="width:17%">时间：</td>
					<td class="FieldInput" style="width:17%"><input type="text" id="meetingDate" field="meetingDate" readonly="readonly" onclick="WdatePicker()" style="width:90%"></td>
					<td class="FieldLabel" style="width:17%">应到人数：</td>
					<td class="FieldInput" style="width:15%"><input type="text" name="应到人数" id="shouldNum" field="shouldNum" maxlength="6" style="width:90%"></td>
					<td class="FieldLabel" style="width:17%">实到人数：</td>
					<td class="FieldInput" style="width:17%"><input type="text" name="实到人数" id="realNum" field="realNum" maxlength="6" style="width:90%"></td>
				</tr>
				<tr>
					<td class="FieldLabel">赞同人数：</td>
					<td class="FieldInput"><input type="text" name="赞同人数" id="passNum" field="passNum" maxlength="6" style="width:90%"></td>
					<td class="FieldLabel">反对人数：</td>
					<td class="FieldInput"><input type="text" name="反对人数" id="nopassNum" field="nopassNum" maxlength="6" style="width:90%"></td>
					<td class="FieldLabel">弃权人数：</td>
					<td class="FieldInput"><input type="text" name="弃权人数" id="giveupNum" field="giveupNum" maxlength="6" style="width:90%"></td>
				</tr>
				<tr>
					<td class="FieldLabel">修改说明：</td>
					<td class="FieldInput" colspan="5"><textarea name="需说明的主要问题" id=mainQuestion field="mainQuestion" cols="65" rows="4" style="width:97%"></textarea></td>
				</tr>
			</table>
			</fieldset>
		</form>
		<form id="form2" method="post"  onsubmit="return false" class="L5form" dataset="somApplyDataSet">
			<fieldset>
			<legend>审查意见</legend>
			<table width="100%">
				<tr>
					<td class="FieldLabel">业务主管单位审查意见：</td>
					<td class="FieldInput" colspan="5"><textarea field="borgOpinion" cols="65" rows="2" style="width:97%"></textarea></td>
				</tr>
				<tr>
					<td class="FieldLabel" style="width:17%">业务主管单位审查日期：</td>
					<td class="FieldInput"  colspan="4"><input type="text" field="borgCheckDate" readonly="readonly" onclick="WdatePicker()"></td>
				</tr>
				<tr>
					<td class="FieldLabel">承办人：</td>
					<td class="FieldInput"><input type="text" field="acceptPeopleName"  style="width:90%"></td>
					<td class="FieldLabel">承办日期：</td>
					<td class="FieldInput"><input type="text"  field="acceptTime" readonly="readonly" onclick="WdatePicker()" style="width:90%"></td>
				</tr>
			</table>
			</fieldset>
		</form>
	</next:Html>
		</next:Panel>

			<next:Panel title="法律要件" >
				<next:EditGridPanel id="uploadGrid" width="100%" stripeRows="true" height="100%" dataset="somElectronicDataSet">
					<next:GroupingView forceFit="true"></next:GroupingView>
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
						<next:Column header="业务类型"    field="applyType" hidden="true">
							<next:ExtendConfig>
								groupRenderer:grender,groupName:"法律要件目录"
							</next:ExtendConfig>
						</next:Column>
					</next:Columns>
					<next:BottomBar>
						<next:PagingToolBar dataset="somElectronicDataSet" />
					</next:BottomBar>
				</next:EditGridPanel>
			</next:Panel>
		</next:Tabs>
	</next:TabPanel>
</next:Panel>
<!-- 负责人身份验证 -->
<next:Window id="win_peopleValidate" title="人员身份验证"  resizable="false" width="500" height="403" closeAction="hide" modal="true">
		<next:EditGridPanel id="gridPeople" width="486" stripeRows="true" height="170" dataset="winPeopleDataSet">
			<next:TopBar>
				<next:ToolBarItem symbol="人员列表"></next:ToolBarItem>
				<next:ToolBarItem symbol="->"></next:ToolBarItem>
				<next:ToolBarItem iconCls="add" text="增加新人" handler="addItem"></next:ToolBarItem>
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
				<next:RadioBoxColumn></next:RadioBoxColumn>
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
<next:Window id="peopleWin" title="人员备案表" resizable="false" width="800" height="430" closeAction="hide" modal="true">
	<next:TopBar>
		<next:ToolBarItem text='' id="displayItem" />
		<next:ToolBarItem symbol="人员备案表"></next:ToolBarItem>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
	</next:TopBar>
	<next:FitLayout>
	<next:TabPanel id="tabSomOrgan">
		<next:Tabs>
			<next:Panel id="panel_win" title="基本信息" autoScroll="true" width="770" height="85%">
				<next:Html>
					<form title="负责人信息" id="addForm" method="post" dataset="peopleInsertDataset" onsubmit="return false" class="L5form">
						<table width="100%">
							<tr>
								<td class="FieldLabel" style="width:15%">身份证号码：</td>
								<td class="FieldInput" style="width:21%"><input type="text" id="idCard" field="idCard" name='"身份证号码"' onblur="checkPeopleInfo();" style="width:90%"/></td>
								<td class="FieldLabel" style="width:14%">姓名：</td>
								<td class="FieldInput" style="width:17%"><input type="text" field="name" name='"姓名"' style="width:90%"/><span style="color:red">*</span></td>
								<td class="FieldLabel" style="width:14%" rowspan="4">照片:</td>
								<td class="FieldInput" style="width:19%" nowrap colspan="1" rowspan="4">
								<div id="photoDiv1">
									<img id="img1" name="RELATIONER_PHOTOC_IMG1" width=82.5 height=110 src="<%=SkinUtils.getRootUrl(request) %>jsp/cams/sorg/comm/signet/default.jpg"
									align="top" ondblclick="editPhoto(11,'photoId1','RELATIONER_PHOTOC_IMG1');"
									onerror="javascript:this.src='<%=SkinUtils.getRootUrl(request) %>jsp/cams/sorg/comm/signet/default.jpg'" alt="暂无图片" />
									<input type="hidden" id="photoId1" name="photoId1"/>
								</div>
								</td>
							</tr>
							<tr>
								<td class="FieldLabel">曾用名：</td>
								<td class="FieldInput"><input type="text" field="aliasName" name='"曾用名"' style="width:90%"/></td>
								<td class="FieldLabel">年龄：</td>
								<td class="FieldInput"><label id="age" name='年龄'/></td>
							</tr>
							<tr>
								<td class="FieldLabel">性别：</td>
								<td class="FieldInput">
									<select field="sex" name='"性别"' style="width:90%">
										<option dataset="sexSelect"></option>
									</select>
								</td>
								<td class="FieldLabel">出生年月：</td>
								<td class="FieldInput"><input type="text" id="birthday" field="birthday" name='"出生年月"'onClick="WdatePicker()" style="width:90%"/></td>
							</tr>
							<tr>
								<td class="FieldLabel">政治面貌：</td>
								<td class="FieldInput">
									<select field="politics" name='"政治面貌"' style="width:90%">
										<option dataset="politicsSelect"></option>
									</select>
								</td>
								<td class="FieldLabel">民族：</td>
								<td class="FieldInput">
									<select field="folk" name='"民族"' style="width:90%">
										<option dataset="folkSelect"></option>
									</select>
								</td>
							</tr>
							<tr>
								<td class="FieldLabel">国籍：</td>
								<td class="FieldInput">
									<input type="text" id="nationDispaly" name="countryNameDispaly"  title="国籍"  onkeyup="findDiv(this,'nation','countryDiv','','countryQueryDic','text@like','value','text','35')" onblur="clearCountryDiv()" onchange="clearCountry(this)"/><img src="<%=SkinUtils.getImage(request,"l5/help.gif")%>" style="cursor:hand" onclick="showCountryWin()"/>
									<div id="countryDiv" style="width:300px; height: 150px; display: none;position: absolute;background-color: #FFFFFF;" >
        								<ul></ul>
   									</div>
   									<input type="hidden" id="nation" name="nation" field="nation" title="国籍"/>
								</td>
								<td class="FieldLabel">家庭住址：</td>
								<td class="FieldInput"><input type="text" field="adds" name='"家庭住址"' style="width:90%"/></td>
								<td class="FieldLabel">户口所在地：</td>
								<td class="FieldInput"><input type="text" field="populace" name='"户口所在地"' style="width:90%"/></td>

							</tr>
							<tr>
								<td class="FieldLabel">邮编：</td>
								<td class="FieldInput"><input type="text" id="postCode" field="postCode" name='邮编' style="width:90%"/></td>
								<td class="FieldLabel">电话：</td>
								<td class="FieldInput"><input type="text" id="phone" field="phone" name='"电话"' style="width:90%"/></td>
								<td class="FieldLabel">专/兼职：</td>
								<td class="FieldInput">
									<select field="ifFulltime" name='"专/兼职"' style="width:90%">
										<option dataset="ifFulltimeSelect"></option>
									</select>
								</td>
							</tr>
							<tr>
								<td class="FieldLabel">工作单位：</td>
								<td class="FieldInput" colspan="3"><input type="text" field="workName" name='"工作单位"' style="width:90%"/></td>
								<td class="FieldLabel">工作单位职务：</td>
								<td class="FieldInput"><input type="text" field="workDuties" name='"单位职务"' style="width:90%"/></td>
							</tr>
							<tr>
								<td class="FieldLabel">基金会职务：</td>
								<td class="FieldInput">
									<select field="sorgDuties" name='"基金会职务"' style="width:90%">
										<option dataset="sorgDutiesDataSet"></option>
									</select><span style="color:red">*</span>
								</td>
								<td class="FieldLabel">任职开始日期：</td>
								<td class="FieldInput"><input type="text" field="startDate" name='"任职开始日期"' onClick="WdatePicker()" style="width:90%"/><span style="color: red">*</span></td>
								<td class="FieldLabel">任职结束日期：</td>
								<td class="FieldInput"></td>
							</tr>
							<tr>
								<td class="FieldLabel">是否党政机关领导干部：</td>
								<td class="FieldInput">
									<select field="ifPartyLeader" id="ifPartyLeader_add" name='"是否党政机关领导干部"' onchange="valid_ifPartyLeader_add();" style="width:90%">
										<option dataset="comm_yesorno"></option>
									</select><span style="color: red">*</span>
								</td>
								<td class="FieldLabel">批准机关：</td>
								<td class="FieldInput"><input type="text" id="promiseOrgan_add"field='promiseOrgan' style="width:90%;display:none"/></td>
								<td class="FieldLabel">批准文号：</td>
								<td class="FieldInput"><input type="text" id="promiseCode_add"field='promiseCode' style="width:90%;display:none"/></td>
							</tr>
							<tr>
								<td class="FieldLabel">其他社会职务：</td>
								<td class="FieldInput" colspan="5"><textarea rows="3" field="otherDuties" name='"其他社会职务"' style="width:97.7%"></textarea></td>
							</tr>
							<tr>
								<td class="FieldLabel">本人所在单位人事部门审查意见：</td>
								<td class="FieldInput" colspan="5"><textarea rows="2" name='"所在单位人事部门审查意见"' field="workOpinion" style="width:97.7%"></textarea></td>
							</tr>
							<tr>
								<td class="FieldLabel">审查工作单位：</td>
								<td class="FieldInput" colspan="3"><input type="text" field="workName" name='"工作单位"' style="width:90%"/></td>
								<td class="FieldLabel">审查日期：</td>
								<td class="FieldInput"><input type="text" field="workCheckDate" onClick="WdatePicker()" style="width:90%"/></td>
							</tr>
							<tr>
								<td class="FieldLabel">备注：</td>
								<td class="FieldInput" colspan="5"><textarea rows="2" name='"备注"' field="note" style="width:97.7%"></textarea></td>
							</tr>
						</table>
					</form>
				</next:Html>
			</next:Panel>
			<next:EditGridPanel id="somResumeGrid" dataset="somResumeInsertDataSet" stripeRows="true" title="本人简历" width="770" height="85%" autoScroll="true">
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
					<next:Column header="在何地区何单位" field="workOrgan" width="45%" editable="true"><next:TextField/></next:Column>
					<next:Column header="任（兼）何职" field="duty" width="20%" editable="true"><next:TextField/></next:Column>
				</next:Columns>
				<next:BottomBar>
					<next:PagingToolBar dataset="somResumeInsertDataSet" />
				</next:BottomBar>
			</next:EditGridPanel>
			<next:EditGridPanel id="uploadPeopleGrid" title="法律要件" stripeRows="true" dataset="somPeopleElectronicDataSet" width="770" height="85%" autoScroll="true">
				<next:TopBar>
					<next:ToolBarItem symbol="附件列表"></next:ToolBarItem>
					<next:ToolBarItem symbol="->"></next:ToolBarItem>
					<next:ToolBarItem iconCls="add" text="增加上传附件" handler="uploadPeopleFile"></next:ToolBarItem>
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
					<next:Column header="下载附件" field="" width="10%" editable="false" renderer="clickDownloadPeopleHref">
						<next:TextField />
					</next:Column>
				</next:Columns>
				<next:BottomBar>
					<next:PagingToolBar dataset="somPeopleElectronicDataSet" />
				</next:BottomBar>
			</next:EditGridPanel>
		</next:Tabs>
	</next:TabPanel>
	</next:FitLayout>
	<next:Buttons>
		<next:ToolButton text="确定" handler="confirm"></next:ToolButton>
		<next:ToolButton text="关闭" handler="closeWin"></next:ToolButton>
	</next:Buttons>
</next:Window>
<jsp:include page="../../../../../../cams/sorg/comm/upload/uploadWindow.jsp" flush="true"/>
<jsp:include page="../../../borg/borgSelectWindow.jsp" flush="true"/>
<jsp:include page="../../../country/countrySelectWindow.jsp" flush="true"/>
</body>
</html>