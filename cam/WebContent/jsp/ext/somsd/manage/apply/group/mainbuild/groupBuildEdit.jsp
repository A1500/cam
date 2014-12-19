<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="com.inspur.cams.comm.util.StrUtil,org.loushang.next.skin.SkinUtils,com.inspur.cams.sorg.util.SomIdHelp"%>
<%@ page import="org.loushang.bsp.security.context.GetBspInfo"%>
<%@ taglib uri="/tags/next-web" prefix="next" %>
<%@ taglib uri="/tags/next-model" prefix="model" %>
<%@ page import="com.inspur.cams.comm.util.IdHelp"%>
<%@page import="com.inspur.cams.sorg.util.ApplyType"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<%@ page import="com.inspur.cams.comm.extuser.data.ComExtUser"%>
<%@ page import="com.inspur.cams.sorg.online.extuser.util.SomExtBspInfo"%>
<%@page import="com.inspur.cams.sorg.online.apply.util.SomIdHelpOnline"%>
<html>
<head>
<title>社会团体成立信息历史采集</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="groupBuildEdit.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js") %>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams/sorgUpload.js")%>'></script>
<script type="text/javascript">var rootPath='<%=SkinUtils.getRootUrl(request)%>';</script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"My97DatePicker/WdatePicker.js") %>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams/sorgCheck.js") %>'></script>
<script type="text/javascript">
	var applyType='<%=ApplyType.SOM_GROUP_BUILD%>';//业务类型
	<%
		ComExtUser comExtUser = (ComExtUser)SomExtBspInfo.getUserInfo(request).getComExtUser();
		String username = comExtUser.getUserName();
		String organArea = comExtUser.getAreaCode();//获取外部单位行政区划12位
		String userId = comExtUser.getUserId();
		String method=request.getParameter("method");
		String sorgId ="";
		String taskCode ="";
		if(method.equals("INSERT")){
			sorgId = SomIdHelpOnline.getGroupSorgId(organArea);
			taskCode = SomIdHelpOnline.getGroupTaskCode(organArea);
		}else{
			sorgId = request.getParameter("sorgId");
			taskCode = request.getParameter("taskCode") ;
		}
	%>
	var sorgCodeNum = "";
	var updateRecord="";
	var dutyId='';
	var legalDutyId='<%=IdHelp.getUUID32()%>';
	var fileCode="S018";//负责人fileCode
	var fileCodeF="S017";//法定代表人fileCode
	currentSorgId = '<%=StrUtil.n2b(SomIdHelpOnline.getGroupSorgId(organArea))%>';
	var method='<%=request.getParameter("method")%>';
	var sorgType='<%=request.getParameter("sorgType")%>';
	var taskCode='<%=taskCode%>';
	var sorgId='<%=sorgId%>';
	var rootPath="<%=SkinUtils.getRootUrl(request)%>";
	var morgArea='<%=organArea%>';
	var userId='<%=userId%>';
</script>
</head>
<body>

<%--定义dataset--%>
<model:datasets>
	<%--社团基本信息--%>
	<model:dataset id="somOrganDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomOrganQueryCmd"  method="queryOrganOnline" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomOrgan">
			<%--社会团体基本信息验证 --%>
			<model:field name="cnName" type="string" rule="require|length{100}" />
			<model:field name="enName" type="string" rule="length{100}" />
			<model:field name="abName" type="string" rule="length{50}" />
			<model:field name="organCode" type="string" rule="length{10}" />
			<model:field name="residence" type="string" rule="length{100}" />
			<model:field name="sorgAdds" type="string" rule="length{200}" />
			<model:field name="sorgEmail" type="string" rule="email|length{100}" />
			<model:field name="actArea" type="string" rule="length{50}" />
			<model:field name="purpose" type="string" rule="length{1000}" />
			<model:field name="business" type="string" rule="length{2000}" />
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
			<model:field name="legalPeople" type="string"/>
			<model:field name="regMon" type="string" rule="double|length{14}" />
		</model:record>
	</model:dataset>
		<%--检验登记证号是否重复--%>
	<model:dataset id="checkSorgCodeDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomOrganQueryCmd" global="true" method="queryOrgan">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomOrgan"></model:record>
	</model:dataset>
	<!-- 届次信息 -->
	<model:dataset id="somSessionDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomSessionQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomSession">
			<model:field name="sessionName" type="string" rule="length{100}" />
			<model:field name="tenure" type="string" rule="length{2}" />
		</model:record>
	</model:dataset>
	<!-- 负责人信息 -->
	<model:dataset id="somDutyDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomDutyQueryCmd" global="true"  method="queryPeople" pageSize="100">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomDuty"></model:record>
	</model:dataset>
	<!-- 法定代表人信息 -->
	<model:dataset id="LegalPeopleDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomDutyQueryCmd" global="true"  method="queryPeople">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomDuty"></model:record>
	</model:dataset>
	<!-- 负责人录入窗口 -->
	<model:dataset id="somDutyInsertDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomDutyQueryCmd" global="true"  method="queryPeople">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomDuty">
			<model:field name="idCard" type="string" rule="length{18}" />
			<model:field name="name" type="string" rule="require|length{72}" />
			<model:field name="aliasName" type="string" rule="length{72}" />
			<model:field name="phone" type="string" rule="length{30}" />
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
	<%--所有符合身份证号的人员列表--%>
	<model:dataset id="winPeopleDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomPeopleQueryCmd" >
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomPeople"></model:record>
	</model:dataset>
	<%--所有符合身份证号的人员列表--%>
	<model:dataset id="winDutyDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomDutyQueryCmd"  method="queryPeople">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomDuty"></model:record>
	</model:dataset>
	<!-- 章程核准信息 -->
	<model:dataset id="somRule"cmd="com.inspur.cams.sorg.base.cmd.SomRuleQueryCmd" global="true" method="queryRule">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomRule">
			<model:field name="shouldNum" type="string" rule="number|length{6}"/>
		    <model:field name="realNum" type="string" rule="number|length{6}"/>
		    <model:field name="passNum" type="string" rule="number|length{6}"/>
		    <model:field name="nopassNum" type="string" rule="number|length{6}"/>
		    <model:field name="giveupNum" type="string" rule="number|length{6}"/>
		    <model:field name="mainQuestion" type="string" rule="length{1000}"/>
		</model:record>
	</model:dataset>
	<%--会费标准信息--%>
	<model:dataset id="somFee" cmd="com.inspur.cams.sorg.base.cmd.SomFeeQueryCmd" global="true" method="queryFee">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomFee">
		 	<model:field name="shouldNum" type="string" rule="number"/>
	     	<model:field name="realNum" type="string" rule="number"/>
	     	<model:field name="passNum" type="string" rule="number"/>
	     	<model:field name="nopassNum" type="string" rule="number"/>
	     	<model:field name="giveupNum" type="string" rule="number"/>
	     	<model:field name="meetingName" type="string" rule="length{100}"/>
		    <model:field name="meetingFormat" type="string" rule="length{30}"/>
		    <model:field name="meetingPlace" type="string" rule="length{100}"/>
		</model:record>
	</model:dataset>
	<model:dataset id="somPartyMemberDataSet" cmd="com.inspur.cams.sorg.manage.cmd.SomPartyMemberQueryCmd" global="true" pageSize="100">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomPartyMember"></model:record>
	</model:dataset>
	<%--电子档案--%>
	<model:dataset id="somElectronicDataSet" cmd="com.inspur.cams.sorg.upload.cmd.SomElectronicQueryCmd" global="true" method="queryCatalog">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomElectronic"></model:record>
	</model:dataset>
	<%--电子档案上传窗口--%>
	<model:dataset id="winElectronicDataSet" cmd="com.inspur.cams.sorg.upload.cmd.SomElectronicQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomElectronic"></model:record>
	</model:dataset>
	<%--下载窗口--%>
	<model:dataset id="downloadDataSet" cmd="com.inspur.cams.sorg.upload.cmd.SomElectronicQueryCmd" method="queryElectronic">
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
			<model:param name="dic" value='DIC_GROUP_KIND'></model:param>
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
	<model:dataset id="peopleTypeSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_PARTY_PEOPLE_TYPE'></model:param>
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
	<!-- 党员专兼职 -->
	<model:dataset id="ifPartyMemberFulltimeSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_SOM_PARTY_IF_FULLTIME'></model:param>
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
	<model:dataset id="somDutyDataSet2" cmd="com.inspur.cams.sorg.base.cmd.SomDutyQueryCmd" global="true"  method="queryPeople">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomDuty"></model:record>
	</model:dataset>
	<model:dataset id="comm_yesorno" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="opinionSelect" enumName="WORKFLOW.OPINION" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="normalInfoSelect" enumName="SORG.PARTY.NORMAL_INFO" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="leaderLevelDataSet" enumName="SOM.LEADER_LEVEL" autoLoad="true" global="true"></model:dataset>
</model:datasets>
<%--定义界面--%>
<next:Panel width="100%" height="100%">
	<next:TopBar>
		<next:ToolBarItem symbol="社会团体成立登记"></next:ToolBarItem>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="save" text="保存" handler="saveAll"></next:ToolBarItem>
		<next:ToolBarItem iconCls="return" text="返回" handler="goBack"></next:ToolBarItem>
	</next:TopBar>
	<next:TabPanel width="100%" height="100%" id="tab">
		<next:Tabs>
			<next:Panel title="登记申请表" width="100%" >
				<next:Panel width="100%" height="100%" autoScroll="true">
					<next:Html>
					<fieldset>
						<legend>社会团体法人成立登记申请表</legend>
						<form method="post" dataset="somOrganDataSet" onsubmit="return false" class="L5form">
						<table width="100%">
							<tr>
								<td class="FieldLabel">社会团体中文名称：</td>
								<td class="FieldInput" colspan="5">
								<label type="text" id="cnName" name='社会团体中文名称' field="cnName" style="width:97%"/>
								</td>
							</tr>
							<tr>
								<td class="FieldLabel" style="width:17%">社会团体英文名称：</td>
								<td class="FieldInput"  style="width:17%"><input type="text" name='社会团体英文名称' field="enName" style="width:90%"/></td>
								<td class="FieldLabel" style="width:17%">社会团体英文名称缩写：</td>
								<td class="FieldInput" style="width:17%"><input type="text" field="abName" name='社会团体英文名称缩写' style="width:90%"/></td>
								<td class="FieldLabel">成立日期：</td>
								<td class="FieldInput"><input type="text" name='成立日期' field="buildDate" onClick="WdatePicker()" style="width:90%"/></td>
							</tr>
							<tr>
								<td class="FieldLabel" style="width:17%">组织机构代码：</td>
								<td class="FieldInput" style="width:17%"><input type="text" name='组织机构代码' field="organCode"  style="width:90%"/></td>
								<td class="FieldLabel" style="width:17%">登记日期：</td>
								<td class="FieldInput" style="width:17%"><input type="text" id="regDate" name='登记日期' field="regDate" onClick="WdatePicker()" style="width:90%"/></td>
								<td class="FieldLabel" style="width:17%"></td>
								<td class="FieldInput" style="width:17%"></td>
							</tr>
							<tr>
								<td class="FieldLabel">社会团体类型：</td>
								<td class="FieldInput"><select id="sorgKind" field="sorgKind" name='社会团体类型' style="width:90%"><option dataset="sorgKindSelect"></option></select></td>
								<td class="FieldLabel">所属行（事）业：</td>
								<td class="FieldInput"><select field="busScope" name='所属行（事）业' style="width:90%"><option  dataset="busScopeSelect"></option></select></td>
								<td class="FieldLabel" style="width:17%"></td>
								<td class="FieldInput" style="width:17%"></td>
							</tr>
							<tr>
								<td class="FieldLabel" style="width:17%">住所来源：</td>
								<td class="FieldInput" style="width:17%"><select field="resideSource" onblur="changeResideSource();" id="resideSource" name='住所来源' style="width:90%""><option dataset="resideSourceSelect"></option></select></td>
								<td class="FieldLabel">住所：</td>
								<td class="FieldInput" colspan="3"><input type="text" name='住所' field="residence" style="width:97%"/></td>
							</tr>
							<tr>
								<td class="FieldLabel" style="width:17%">社会团体邮编：</td>
								<td class="FieldInput" style="width:17%"><input type="text" id="sorgPost" name='社会团体邮编' field="sorgPost" style="width:90%"/></td>
								<td class="FieldLabel">社会团体电话：</td>
								<td class="FieldInput"><input type="text" id="sorgPhone" name='社会团体电话' field="sorgPhone" style="width:90%"/></td>
								<td class="FieldLabel">活动地域：</td>
								<td class="FieldInput"><input type="text" name='活动地域' field="actArea" style="width:90%" /></td>
							</tr>
							<tr>
								<td class="FieldLabel">业务主管单位：</td>
								<td class="FieldInput">
								<input type="text" id="borgNameDispaly" name="borgNameDispaly"  title="业务主管单位"  onkeyup="findDiv(this,'borgName','popup','','businessOrganAuto','BORG_NAME@like','borgCode','borgName','35')" onblur="clearDiv()" onchange="clearBorg(this)"/><img src="<%=SkinUtils.getImage(request,"l5/help.gif")%>" style="cursor:hand" onclick="showBorgWin()"/>
								<div id="popup" style="width:300px; height: 150px; display: none;position: absolute;background-color: #FFFFFF;" >
	        							<ul></ul>
	   								</div>
	   								<input type="hidden" id="borgName" name="borgName" field="borgName" title="业务主管单位代码"/>
								<span style="color:red">*</span></td>

								<td class="FieldLabel">业务主管单位联系人：</td>
								<td class="FieldInput"><input type="text" name='业务主管单位联系人' field="borgPeople" style="width:90%" /></td>
								<td class="FieldLabel">业务主管单位电话：</td>
								<td class="FieldInput"><input type="text" name='业务主管单位电话' field="borgPhone" style="width:90%" /></td>
							</tr>
							<tr>
								<td class="FieldLabel">社会团体宗旨：</td>
								<td class="FieldInput" colspan="5"><textarea rows="5" name='社会团体宗旨' field="purpose" style="width:98%"></textarea></td>
							</tr>
							<tr>
								<td class="FieldLabel">业务范围：</td>
								<td class="FieldInput" colspan="5"><textarea rows="5" name='业务范围' field="business" style="width:98%"></textarea></td>
							</tr>
							<tr>
								<td class="FieldLabel">单位会员数：</td>
								<td class="FieldInput"><input type="text" id="unitsNum" name='单位会员数' field="unitsNum" maxlength="6" style="width:90%"/></td>
								<td class="FieldLabel">个人会员数：</td>
								<td class="FieldInput"><input type="text" id="peopleNum" name='个人会员数' field="peopleNum" maxlength="6" style="width:90%"/></td>
								<td class="FieldLabel">理事数：</td>
								<td class="FieldInput"><input type="text" name='理事数' field="councilNum" maxlength="6" style="width:90%"></td>
							</tr>
							<tr>
								<td class="FieldLabel">常务理事数：</td>
								<td class="FieldInput"><input type="text" name='常务理事数' field="standCouncilNum" maxlength="6" style="width:90%"/></td>
								<td class="FieldLabel">活动资金数额：</td>
								<td class="FieldInput" colspan="3"><input type="text" id="regMon" name='活动资金数额' field="regMon" maxlength="10" style="width:30%"/>万元</td>
							</tr>
							<tr>
								<td class="FieldLabel">出资人：</td>
								<td class="FieldInput" colspan="5"><textarea name='出资人' field="fundingPeople" style="width:98%" ></textarea></td>
							</tr>
							<tr>
								<td class="FieldLabel">验资单位：</td>
								<td class="FieldInput" colspan="5"><input type="text" name='验资单位' field="checkCapitalOrgan" style="width:98%"></td>
							</tr>
							<tr>
								<td class="FieldLabel">经费来源：</td>
								<td class="FieldInput" colspan="5"><input type="text" name='经费来源' field="moneySource" style="width:98%"/></td>
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
								<td class="FieldLabel">社会团体通信地址：</td>
								<td class="FieldInput"><input type="text"name='社会团体通信地址' id="sorgAdds" field="sorgAdds" style="width:97%"/></td>
								<td class="FieldLabel">社会团体电子邮箱：</td>
								<td class="FieldInput"><input type="text" name='社会团体电子邮箱' field="sorgEmail" style="width:90%"/></td>
								<td class="FieldLabel" style="width:15%">社会团体传真：</td>
								<td class="FieldInput" style="width:17%"><input type="text" id="sorgFax" field="sorgFax" style="width:90%"/></td>
							</tr>
						</table>
						</form>
					</fieldset>
					</next:Html>
				</next:Panel>
			</next:Panel>
			<next:Panel title="社会团体负责人备案表">
			<next:Panel>
				<next:Html>
					<form onsubmit="return false" dataset="somSessionDataSet" class="L5form">
				<fieldset>
					<legend>社会团体信息</legend>
						<table width="100%">
							<tr>
								<td class="FieldLabel">届次名称：</td>
								<td class="FieldInput" colspan="3"><input type="text" id="sessionName" field="sessionName" style="width:97%"/></td>
								<td class="FieldLabel" style="width:17%">本届任期（年）：</td>
								<td class="FieldInput" style="width:17%"><input type="text" id="tenure" field="tenure" style="width:90%" onchange="calSessionDate()"/></td>
							</tr>
							<tr>
								<td class="FieldLabel" style="width:17%">本届开始日期：</td>
								<td class="FieldInput" style="width:17%"><input type="text" id="startDate" field="startDate"onClick="WdatePicker()" style="width:90%" onchange="calSessionDate()"/></td>
								<td class="FieldLabel" style="width:17%">规定换届日期：</td>
								<td class="FieldInput" style="width:15%"><input type="text" id="endDate" field="endDate"onClick="WdatePicker()" style="width:90%"/></td>
								<td class="FieldLabel" style="width:17%"></td>
								<td class="FieldInput" style="width:17%"></td>
							</tr>
						</table>
				</fieldset>
					</form>
				</next:Html>
			</next:Panel>
			<next:EditGridPanel id="peopleGrid" dataset="somDutyDataSet" width="100%" stripeRows="true" height="99.9%">
				<next:TopBar>
					<next:ToolBarItem symbol="->"></next:ToolBarItem>
					<next:ToolBarItem iconCls="add" text="选定为法定代表人" handler="chooseLegal"></next:ToolBarItem>
					<next:ToolBarItem iconCls="add" text="新增" handler="add"></next:ToolBarItem>
					<next:ToolBarItem iconCls="edit" text="修改" handler="update"></next:ToolBarItem>
					<next:ToolBarItem iconCls="delete" text="删除" handler="del"></next:ToolBarItem>
				</next:TopBar>
				<next:Columns>
					<next:RowNumberColumn/>
					<next:RadioBoxColumn></next:RadioBoxColumn>
					<next:Column header="内码" field="id" width="15%" editable="false" hidden="true"><next:TextField/></next:Column>
					<next:Column header="身份证号" field="idCard" width="20%" editable="false"><next:TextField/></next:Column>
					<next:Column header="姓名" field="name" width="10%" editable="false"><next:TextField/></next:Column>
					<next:Column header="性别" field="sex" width="10%" editable="false"><next:ComboBox dataset="sexSelect"/></next:Column>
					<next:Column header="出生年月" field="birthday" width="10%" editable="false"><next:TextField/></next:Column>
					<next:Column header="担任职务" field="sorgDuties" width="20%" editable="false"><next:ComboBox dataset="sorgDutiesSelect"/></next:Column>
					<next:Column header="是否在任" field="ifServe"width="10%" editable="false"><next:TextField/><next:ComboBox dataset="ifServeSelect"/></next:Column>
					<next:Column header="是否法定代表人" field="ifLegal" width="15%" editable="false"><next:TextField/><next:ComboBox dataset="comm_yesorno"/></next:Column>
					<next:Column header="任职开始日期" field="startDate" width="15%" editable="false"><next:TextField/></next:Column>
					<next:Column header="任职结束日期" field="endDate" width="15%" editable="false"><next:TextField/></next:Column>
				</next:Columns>
			</next:EditGridPanel>
		</next:Panel>
		<next:Panel title="社会团体法定代表人登记表" >
			<next:TabPanel  width="100%" height="100%">
				<next:Tabs>
					<next:Panel title="基本信息"  width="100%" height="100%" autoScroll="true">
						<next:Html>
							<form  method="post" dataset="LegalPeopleDataSet" onsubmit="return false" class="L5form">
							<table width="100%">
								<tr>
									<td class="FieldLabel" style="width:15%">身份证号码：</td>
									<td class="FieldInput" style="width:21%"><label field="idCard"/></td>
									<td class="FieldLabel" style="width:14%">姓名：</td>
									<td class="FieldInput" style="width:17%"><label id="nameLabel" field="name"/></td>
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
									<td class="FieldLabel">家庭住址：</td>
									<td class="FieldInput" colspan="3"><label field="adds"/></td>
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
									<td class="FieldLabel">社团职务：</td>
									<td class="FieldInput"><label field="sorgDuties" dataset="sorgDutiesSelect"/></td>
									<td class="FieldLabel">任职开始日期：</td>
									<td class="FieldInput"><label field="startDate"/></td>
									<td class="FieldLabel"><label>任职结束日期：</label></td>
									<td class="FieldInput"></td>
								</tr>
								<tr>
									<td class="FieldLabel">是否党政机关领导干部：</td>
									<td class="FieldInput"><label field="ifPartyLeader" dataset="comm_yesorno"/></td>
									<td class="FieldLabel">批准机关：</td>
									<td class="FieldInput"><label field="promiseOrgan"/></td>
									<td class="FieldLabel">批准文号：</td>
									<td class="FieldInput"><label field="promiseCode" /></td>
								</tr>
								<tr>
									<td class="FieldLabel">本人所在单位人事部门审查意见：</td>
									<td class="FieldInput" colspan="5"><textarea rows="2" name='"所在单位人事部门审查意见"' readonly="readonly" field="workOpinion" style="width:97.7%"></textarea><span style="color:red">*</span></td>
								</tr>
								<tr>
									<td class="FieldLabel">审查工作单位：</td>
									<td class="FieldInput" colspan="3"><label  field="workName"/></td>
									<td class="FieldLabel">审查日期：</td>
									<td class="FieldInput"><label  field="workCheckDate"/></td>
								</tr>
								<tr>
										<td class="FieldLabel"><label>按照本社会团体章程会议产生通过情况：</label></td>
										<td class="FieldInput" colspan="5"><textarea   rows="2" name='"按照本社会团体章程会议产生通过情况"' field="sorgOpinion" style="width:97.7%"></textarea><span style="color:red">*</span></td>
									</tr>
									<tr>
										<td class="FieldLabel"><label>签署日期：</label></td>
										<td class="FieldInput" colspan="5"><input type="text"  field="sorgCheckDate" onClick="WdatePicker()" style="width:22%"/></td>
								</tr>
								<tr>
									<td class="FieldLabel">备注：</td>
									<td class="FieldInput" colspan="5"><textarea rows="2" name='"备注"' readonly="readonly" field="note" style="width:97.7%"></textarea></td>
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
		<next:Panel title="社会团体章程核准表"  width="100%" autoScroll="true">
			<next:Html>
				<form id="ruleForm" method="post" dataset="somRule" onsubmit="return false" class="L5form">
					<input type="hidden" id="sorgId" field="sorgId" value="社团ID">
					<table width="100%">
						<tr>
							<td class="FieldLabel">会议名称：</td>
							<td class="FieldInput"><input type="text" id="meetingName" field="meetingName" maxlength="100" style="width:90%" onchange="meetingInteractive(this.value,'meetingNameFee','somRule','somFee','meetingName')"></td>
							<td class="FieldLabel">会议形式：</td>
							<td class="FieldInput" colspan="3"><input type="text" id="meetingFormat" field="meetingFormat" maxlength="30" style="width:90%"></td>
						</tr>
						<tr>
							<td class="FieldLabel" style="width:17%">时间：</td>
							<td class="FieldInput" style="width:17%">
							<input type="text" name='时间' id="meetingDate" field="meetingDate" onClick="WdatePicker()" style="width:90%" onchange="meetingInteractive(this.value,'meetingDateFee','somRule','somFee','meetingDate')"/>
							</td>
							<td class="FieldLabel" style="width:17%">应到人数：</td>
							<td class="FieldInput" style="width:15%"><input type="text" name="应到人数" id="shouldNum" field="shouldNum" maxlength="6" style="width:90%"  onchange="meetingInteractive(this.value,'shouldNumFee','somRule','somFee','shouldNum')"></td>
							<td class="FieldLabel" style="width:17%">实到人数：</td>
							<td class="FieldInput" style="width:17%"><input type="text" name="实到人数" id="realNum" field="realNum" maxlength="6" style="width:90%" onchange="meetingInteractive(this.value,'realNumFee','somRule','somFee','realNum')"></td>
						</tr>
						<tr>
							<td class="FieldLabel">同意人数：</td>
							<td class="FieldInput"><input type="text" name="同意人数" id="passNum" field="passNum" maxlength="6" style="width:90%" onchange="meetingInteractive(this.value,'passNumFee','somRule','somFee','passNum')"></td>
							<td class="FieldLabel">反对人数：</td>
							<td class="FieldInput"><input type="text" name="反对人数" id="nopassNum" field="nopassNum" maxlength="6" style="width:90%" onchange="meetingInteractive(this.value,'nopassNumFee','somRule','somFee','nopassNum')"></td>
							<td class="FieldLabel">弃权人数：</td>
							<td class="FieldInput"><input type="text" name="弃权人数" id="giveupNum" field="giveupNum" maxlength="6" style="width:90%" onchange="meetingInteractive(this.value,'giveupNumFee','somRule','somFee','giveupNum')"></td>
						</tr>
						<tr>
							<td class="FieldLabel">需说明的主要问题：</td>
							<td class="FieldInput" colspan="5"><textarea name="需说明的主要问题" id=mainQuestion field="mainQuestion" cols="65" rows="4" style="width:97%"></textarea></td>
						</tr>
					</table>
					</form>
				<form id="form2" method="post" dataset="somApplyDataSet" onsubmit="return false" class="L5form">
					<fieldset>
					<legend>审查意见</legend>
					<table width="100%">
						<tr>
							<td class="FieldLabel">业务主管单位审查意见：</td>
							<td class="FieldInput" colspan="5"><textarea field="borgOpinion" cols="65" rows="2" style="width:97%"></textarea></td>
						</tr>
						<tr>
							<td class="FieldLabel" style="width:17%">业务主管单位：</td>
							<td class="FieldInput" style="width:49%"><select name="业务主管单位" field="borgName" style="width:90%" ><option dataset="businessOrganSelect"></option></select></td>
							<td class="FieldLabel" style="width:17%">业务主管单位审查日期：</td>
							<td class="FieldInput" style="width:17%"><input type="text" field="borgCheckDate"onClick="WdatePicker()"style="width:90%"></td>
						</tr>
					</table>
					</fieldset>
				</form>
			</next:Html>
		</next:Panel>
		<next:Panel title="社会团体会费标准备案表"  width="100%" autoScroll="true">
			<next:Html>
				<form method="post" onsubmit="return false" dataset="somFee" class="L5form">
					<input type="hidden" id="sorgId" field="sorgId" value="社团ID">
					<table width="100%">
						<tr>
							<td class="FieldLabel" style="width:17%">联系人：</td>
							<td class="FieldInput" style="width:17%"><input type="text" name="linkPeople" id="linkPeople" maxlength="36" field="linkPeople" style="width:90%"/></td>
							<td class="FieldLabel" style="width:17%">联系电话：</td>
							<td class="FieldInput" style="width:15%"><input type="text" name="linkPhone" id="linkPhone" field="linkPhone" style="width:90%"/></td>
							<td class="FieldLabel" style="width:17%"></td>
							<td class="FieldInput" style="width:17%"></td>
						</tr>
						<tr>
							<td class="FieldLabel">会议名称：</td>
							<td class="FieldInput"><input type="text" name="meetingName" id="meetingNameFee" field="meetingName" maxlength="100" style="width:90%" onchange="meetingInteractive(this.value,'meetingName','somFee','somRule','meetingName')"/></td>
							<td class="FieldLabel">召开日期：</td>
							<td class="FieldInput">
							<input type="text" name='时间' id="meetingDateFee" field="meetingDate" onClick="WdatePicker()" style="width:90%" onchange="meetingInteractive(this.value,'meetingDate','somFee','somRule','meetingDate')"/></td>
							<td class="FieldLabel">召开地点：</td>
							<td class="FieldInput"><input type="text" name="meetingPlace" id="meetingPlace" field="meetingPlace" maxlength="100" style="width:90%"/></td>
						</tr>
						<tr>
							<td class="FieldLabel" style="width:17%">应到人数：</td>
							<td class="FieldInput" style="width:17%"><input type="text" name="应到人数" id="shouldNumFee" field="shouldNum" style="width:90%" maxlength="6" onchange="meetingInteractive(this.value,'shouldNum','somFee','somRule','shouldNum')"/></td>
							<td class="FieldLabel" style="width:17%">实到人数：</td>
							<td class="FieldInput" style="width:15%"><input type="text" name="实到人数" id="realNumFee" field="realNum" style="width:90%" maxlength="6" onchange="meetingInteractive(this.value,'realNum','somFee','somRule','realNum')"/></td>
							<td class="FieldLabel" style="width:17%"></td>
							<td class="FieldInput" style="width:17%"></td>
						</tr>
						<tr>
							<td class="FieldLabel">同意：</td>
							<td class="FieldInput"><input type="text" name="同意" id="passNumFee" field="passNum" style="width:90%" maxlength="6" onchange="meetingInteractive(this.value,'passNum','somFee','somRule','passNum')"/></td>
							<td class="FieldLabel">不同意：</td>
							<td class="FieldInput"><input type="text" name="不同意" id="nopassNumFee" field="nopassNum" style="width:90%" maxlength="6" onchange="meetingInteractive(this.value,'nopassNum','somFee','somRule','nopassNum')"/></td>
							<td class="FieldLabel">弃权：</td>
							<td class="FieldInput"><input type="text" name="弃权" id="giveupNumFee" field="giveupNum" style="width:90%" maxlength="6"/ onchange="meetingInteractive(this.value,'giveupNum','somFee','somRule','giveupNum')"></td>
						</tr>
						<tr>
							<td class="FieldLabel"><label>会费标准：</label></td>
							<td class="FieldInput" colspan="5"><textarea name="会费标准" id="fee" field="fee" cols="75" rows="12" style="width:95%"></textarea>
						</tr>
						<tr>
							<td class="FieldInput" colspan="6"><font color="red">说明：会费标准的内容，必须在500字符之内。</font></td>
						</tr>
				</table>
				</form>
			</next:Html>
			</next:Panel>
			<next:Panel title="党员情况">
				<next:EditGridPanel id="partyMemberGrid" dataset="somPartyMemberDataSet" width="100%" stripeRows="true" height="99.9%">
					<next:TopBar>
						<next:ToolBarItem symbol="社会组织党员情况调查表"></next:ToolBarItem>
						<next:ToolBarItem symbol="->"></next:ToolBarItem>
						<next:ToolBarItem iconCls="add" text="增加" handler="addPartyMember"></next:ToolBarItem>
						<next:ToolBarItem iconCls="edit" text="修改" handler="editPartyMember"></next:ToolBarItem>
						<next:ToolBarItem iconCls="delete" text="删除" handler="delPartyMember"></next:ToolBarItem>
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
						<next:ToolBarItem iconCls="add" text="增加上传附件" handler="clickUploadFile"></next:ToolBarItem>
					</next:TopBar>

					<next:Columns>
						<next:RowNumberColumn />
						<next:RadioBoxColumn></next:RadioBoxColumn>
						<next:Column header="档案目录名"  field="catalogCode" width="38%" editable="false" dataset="cataLogCodeSelect"><next:TextField /></next:Column>
						<next:Column header="附件名称"    field="fileName" width="30%" editable="false"><next:TextField /></next:Column>
						<next:Column header="附件描述"    field="fileMess" width="20%" editable="false"><next:TextField /></next:Column>
						<next:Column header="下载附件" field="" width="10%" editable="false" renderer="clickDownloadHref"><next:TextField /></next:Column>
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
<next:Window id="peopleWin" title="主要负责人" resizable="false" width="800" height="430" closeAction="hide" modal="true">
	<next:FitLayout>
	<next:TabPanel id="tabSomOrgan">
			<next:Tabs>
			<next:Panel id="panel_win" title="基本信息" autoScroll="true" width="770" height="85%">
				<next:Html>
					<form title="负责人信息" id="addForm" method="post" dataset="somDutyInsertDataSet" onsubmit="return false" class="L5form">
						<table width="100%">
							<tr>
								<td class="FieldLabel" style="width:15%">身份证号码：</td>
								<td class="FieldInput" style="width:21%"><input type="text" id="idCard" field="idCard" name='"身份证号码"' onblur="checkPeopleInfo();" style="width:90%"/></td>
								<td class="FieldLabel" style="width:14%">姓名：</td>
								<td class="FieldInput" style="width:17%"><input type="text" field="name" name='"姓名"' style="width:90%"/><span style="color:red">*</span></td>
								<td class="FieldLabel" style="width:14%">曾用名：</td>
								<td class="FieldInput" style="width:19%"><input type="text" field="aliasName" name='"曾用名"' style="width:90%"/></td>
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
								<td class="FieldLabel">年龄：</td>
								<td class="FieldInput"><label id="age" name='年龄'/></td>
							</tr>
							<tr>
								<td class="FieldLabel">政治面貌：</td>
								<td class="FieldInput">
									<select field="politics" name='"政治面貌"' style="width:90%">
										<option dataset="politicsSelect"></option>
									</select>
								</td>
								<td class="FieldLabel">民族：</td>
								<td class="FieldInput" colspan="3">
									<select field="folk" name='"民族"' style="width:90%">
										<option dataset="folkSelect"></option>
									</select>
								</td>
							</tr>
							<tr>
								<td class="FieldLabel">家庭住址：</td>
								<td class="FieldInput" colspan="3"><input type="text" field="adds" name='"家庭住址"' style="width:97%"/></td>
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
								<td class="FieldLabel">社团职务：</td>
								<td class="FieldInput">
									<select field="sorgDuties" name='"社团职务"' style="width:90%">
										<option dataset="sorgDutiesSelect"></option>
									</select>
								</td>
								<td class="FieldLabel">任职开始日期：</td>
								<td class="FieldInput"><input type="text" field="startDate" name='"任职开始日期"' onClick="WdatePicker()"style="width:90%"/></td>
								<td class="FieldLabel">任职结束日期：</td>
								<td class="FieldInput"></td>
							</tr>
							<tr>
								<td class="FieldLabel">是否党政机关领导干部：</td>
								<td class="FieldInput">
									<select field="ifPartyLeader" id="ifPartyLeader_add" name='"是否党政机关领导干部"' onchange="valid_ifPartyLeader_add();" style="width:90%">
										<option dataset="comm_yesorno"></option>
									</select><span style="color:red">*</span>
								</td>
								<td class="FieldLabel"></td>
								<td class="FieldInput"></td>
								<td class="FieldLabel"></td>
								<td class="FieldInput"></td>
							</tr>
							<tr id="leaderTr" style="display:none">
								<td class="FieldLabel">党政机关领导干部职级：</td>
								<td class="FieldInput">
									<select field="partyLeaderLevel" id="partyLeaderLevel" name='"党政机关领导干部职级"'  style="width:90%">
										<option dataset="leaderLevelDataSet"></option>
									</select>
								</td>
								<td class="FieldLabel">批准机关：</td>
								<td class="FieldInput"><input type="text" id="promiseOrgan_add" field="promiseOrgan"style="width:90%;"/></td>
								<td class="FieldLabel">批准文号：</td>
								<td class="FieldInput"><input type="text" id="promiseCode_add" field="promiseCode"style="width:90%;"/></td>
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
					<next:ToolBarItem iconCls="add" text="增加上传附件" handler="clickUploadPeopleFile"></next:ToolBarItem>
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
		<next:ToolButton text="关闭" handler="closePeopleWIn"></next:ToolButton>
	</next:Buttons>
</next:Window>
<jsp:include page="../../../../../../cams/sorg/comm/upload/uploadWindow.jsp" flush="true"/>
<jsp:include page="../../../borg/borgSelectWindow.jsp" flush="true"/>
<jsp:include page="../../../../../../cams/sorg/comm/upload/partyUpload.jsp" flush="true"/>
<jsp:include page="../../../../../../cams/sorg/comm/party/somPartyMemberEdit.jsp" flush="true"/>
<jsp:include page="../../../../../../cams/sorg/comm/people/peopleWindow.jsp" flush="true"/>
</body>
</html>