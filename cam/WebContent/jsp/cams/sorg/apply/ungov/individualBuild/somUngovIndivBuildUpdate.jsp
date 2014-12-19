<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="com.inspur.cams.comm.util.StrUtil,org.loushang.next.skin.SkinUtils"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="org.loushang.workflow.api.WfQuery" %>
<%@ page import="org.loushang.bsp.security.context.GetBspInfo"%>
<%@ page import="com.inspur.cams.sorg.apply.group.cmd.GroupBuildCmd"%>
<%@ taglib uri="/tags/next-web" prefix="next" %>
<%@ taglib uri="/tags/next-model" prefix="model" %>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
<head>
<title>民办非企业信息管理</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="somUngovIndivBuildUpdate.js"></script>
<script type="text/javascript" src="<%=SkinUtils.getJS(request, "bpm/bpm.js")%>"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js") %>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams/sorgUpload.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"My97DatePicker/WdatePicker.js") %>'></script>
<script type="text/javascript">
<%
	String primaryKey=request.getParameter("primaryKey");
    if(primaryKey==null){
    	primaryKey="";
    }
	String assignmentId=(String)request.getParameter("assignmentId");
	String procDefUniqueId=(String)request.getParameter("procDefUniqueId");
	String actDefUniqueId=(String)request.getParameter("actDefUniqueId");
	String act=(String)request.getParameter("act");
	//然调用接口
	List<Map> list = new WfQuery().getActButtons(actDefUniqueId);
	String method = request.getParameter("method");
	Boolean flag = false;
	if("yiban".equals(method) || "jieshu".equals(method)){
		Map<String,String> map = new HashMap<String,String>();
		map.put("buttonName","返回");
		map.put("buttonFunName","goBack()");
		List<Map> lists = new ArrayList<Map>();
		lists.add(map);
		list = lists;
		flag = true;
	}
	List<Map> list1=new WfQuery().getActFields(actDefUniqueId);
	//遍历list，如果该页面上某个域是需要隐藏的，则设置该域为不显示
	//如果域是只读的则显示为只读
	//如果是非空的，则在点击按钮时进行校验 ，若为空弹出提示框
	String fieldId,fieldName,isHidden,isReadOnly,isNotNull;
	//boolean isHidden,isReadOnly,isNotNull;
	String processId=(String)request.getParameter("processId");
	if(processId == null){
		processId = new GroupBuildCmd().getProcessId(assignmentId);
	}
	String taskCode = "";
	if(new GroupBuildCmd().getTaskCode(processId) != null){
		taskCode = (new GroupBuildCmd().getTaskCode(processId)).getTaskCode();
	}

%>
	var processId = '<%=processId%>';
	var procDefUniqueId = '<%=(String)request.getParameter("procDefUniqueId")%>';
	var assignmentId="<%=assignmentId%>";
	var currentUserName = '<%=GetBspInfo.getBspInfo().getUserName()%>';
	var actDefUniqueId ="<%=actDefUniqueId%>";
	var sorgId='<%=primaryKey%>';
	var taskCode = '<%=taskCode%>';
	var actname='<%=act%>';
	var flag = <%=flag%>;
	var applyType = "106";
</script>
</head>
<body>
<%--定义dataset--%>
<model:datasets>
	<!-- 更改业务状态所用dataset -->
	<model:dataset id="updateStatusDataSet" cmd="com.inspur.cams.sorg.online.base.cmd.SomApplyOnlineQueryCommand"  global="true" >
		<model:record fromBean="com.inspur.cams.sorg.online.base.data.SomApplyOnline"></model:record>
	</model:dataset>
	<%--民办非企业基本信息--%>
	<model:dataset id="somOrganDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomOrganQueryCmd"  method="queryOrgan">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomOrgan">
			<%--民办非企业基本信息验证 --%>
			<model:field name="cnName" type="string" rule="require|length{100}" />
			<model:field name="enName" type="string" rule="length{100}" />
			<model:field name="abName" type="string" rule="length{50}" />
			<model:field name="sorgKind" type="string" rule="require" />
			<model:field name="regMon" type="string" rule="double|require" />
			<model:field name="residence" type="string" rule="require|length{100}" />
			<model:field name="sorgAdds" type="string" rule="length{200}" />
			<model:field name="sorgEmail" type="string" rule="email|length{100}" />
			<model:field name="actArea" type="string" rule="length{50}" />
			<model:field name="purpose" type="string" rule="length{1000}" />
			<model:field name="business" type="string" rule="length{1000}" />
			<model:field name="busScope" type="string" rule="require"/>
			<model:field name="unitsNum" type="string" rule="integer" />
			<model:field name="peopleNum" type="string" rule="integer" />
			<model:field name="councilNum" type="string" rule="integer" />
			<model:field name="standCouncilNum" type="string" rule="integer" />
			<model:field name="fundingPeople" type="string" rule="length{500}" />
			<model:field name="checkCapitalOrgan" type="string" rule="length{100}" />
			<model:field name="moneySource" type="string" rule="length{500}" />
			<model:field name="housingOrgan" type="string" rule="length{100}" />
			<model:field name="resideSource" type="string" rule="require" />
			<model:field name="leasePeriod" type="string" rule="length{100}" />
			<model:field name="legalPeople" type="string"/>
		</model:record>
	</model:dataset>
	<!-- 届次信息 -->
	<model:dataset id="somSessionDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomSessionQueryCmd">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomSession">
		<model:field name="tenure" type="string" rule="integer|length{2}" />
		</model:record>
	</model:dataset>
	<!-- 负责人信息 -->
	<model:dataset id="somDutyDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomDutyQueryCmd" method="queryPeople" global="true" pageSize="100">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomDuty"></model:record>
	</model:dataset>
	<!-- 法定代表人信息 -->
	<model:dataset id="LegalPeopleDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomDutyQueryCmd" global="true" method="queryPeople">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomDuty"></model:record>
	</model:dataset>
	<model:dataset id="somFlowListDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomFlowQueryCmd"  sortField="COMMIT_TIME">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomFlow"></model:record>
	</model:dataset>
	<!-- 负责人录入窗口 -->
	<model:dataset id="somDutyInsertDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomDutyQueryCmd"  method="queryPeople">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomDuty">
			<model:field name="idCard" type="string" rule="require" />
			<model:field name="name" type="string" rule="require|length{72}" />
			<model:field name="aliasName" type="string" rule="length{72}" />
			<model:field name="phone" type="string" rule="length{30}" />
			<model:field name="sorgDuties" type="string" rule="require" />
			<model:field name="adds" type="string" rule="length{100}" />
			<model:field name="populace" type="string" rule="length{100}" />
			<model:field name="workName" type="string" rule="length{100}" />
			<model:field name="ifPartyLeader" type="string" rule="require" />
			<model:field name="resume" type="string" rule="length{1000}" />
			<model:field name="workOpinion" type="string" rule="length{200}" />
			<model:field name="sorgOpinion" type="string" rule="length{200}" />
		</model:record>
	</model:dataset>
	<%--人员简历 --%>
	<model:dataset id="somResumeDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomPeopleResumeQueryCommand" sortField="startDate" sortDirection="DESC" pageSize="-1">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomPeopleResume"></model:record>
	</model:dataset>
	<%--法定代表人人员简历 --%>
	<model:dataset id="somResumeLegalDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomPeopleResumeQueryCommand" pageSize="-1">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomPeopleResume"></model:record>
	</model:dataset>
	<%--人员简历 --%>
	<model:dataset id="somResumeInsertDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomPeopleResumeQueryCommand">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomPeopleResume"></model:record>
	</model:dataset>
	<%--内设机构--%>
	<model:dataset id="somOfficeDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomOfficeQueryCmd"  pageSize="100">
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
	<model:dataset id="winDutyDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomDutyQueryCmd"  >
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomDuty"></model:record>
	</model:dataset>
	<!-- 章程核准信息 -->
	<model:dataset id="somRuleDataSet"cmd="com.inspur.cams.sorg.base.cmd.SomRuleQueryCmd" method="queryRule">
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
	<model:dataset id="somElectronicDataSet" cmd="com.inspur.cams.sorg.upload.cmd.SomElectronicQueryCmd" global="true"  method="queryCatalog">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomElectronic"></model:record>
	</model:dataset>
	<%--电子档案上传窗口--%>
	<model:dataset id="winElectronicDataSet" cmd="com.inspur.cams.sorg.upload.cmd.SomElectronicQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomElectronic"></model:record>
	</model:dataset>
	<%--业务意见--%>
	<model:dataset id="somApplyDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomApplyQueryCmd">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomApply"></model:record>
	</model:dataset>

	<model:dataset id="pubOrganDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd"  autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='PUB_ORGAN'></model:param>
			<model:param name="value" value='ORGAN_ID'></model:param>
			<model:param name="text" value='ORGAN_NAME'></model:param>
		</model:params>
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
	<model:dataset id="workFlowOpinionSelect" enumName="WORKFLOW.OPINION" autoLoad="true" global="true"></model:dataset>
</model:datasets>
<%--定义界面--%>
<next:Panel width="100%" height="100%">
	<next:TopBar>
		<next:ToolBarItem symbol="民办非企业成立登记"></next:ToolBarItem>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="save" text="保存" handler="saveAll"></next:ToolBarItem>
		<next:ToolBarItem iconCls="select" text="提交" handler="saveAndSend"></next:ToolBarItem>
		<next:ToolBarItem iconCls="return" text="返回" handler="goBack"></next:ToolBarItem>
	</next:TopBar>
	<next:TabPanel width="100%" height="100%" id="tab">
		<next:Tabs>
			<next:Panel title="成立登记详细信息" width="100%" >
				<next:TabPanel width="100%" height="100%" id="sorgTab" activeTab="1">
					<next:Tabs>
						<next:Panel title="登记申请表" width="100%" >
							<next:Panel width="100%" height="100%" autoScroll="true">
								<next:Html>
									<fieldset>
										<form method="post" dataset="somOrganDataSet" onsubmit="return false" class="L5form">
											<table width="100%">
												<tr>
													<td class="FieldLabel">民办非企业中文名称：</td>
													<td class="FieldInput" colspan="3"><input type="text" id="cnName" name='民办非企业中文名称' field="cnName" onblur="" style="width:96%"/><span style="color:red">*</span></td>
													<td class="FieldLabel" style="width:17%">电话：</td>
													<td class="FieldInput" style="width:17%"><input type="text" id="sorgPhone" name='民办非企业电话' field="sorgPhone" style="width:90%"/></td>
												</tr>
												<tr>
													<td class="FieldLabel" style="width:17%">住所来源：</td>
													<td class="FieldInput" style="width:17%"><select field="resideSource" onchange="changeResideSource();" id="resideSource" name='住所来源' style="width:97%""><option dataset="resideSourceSelect"></option></select><span style="color:red">*</span></td>
													<td class="FieldLabel" style="width:17%">住所：</td>
													<td class="FieldInput" colspan="3"><input type="text" name='住所' field="residence" style="width:95%"/><span style="color:red">*</span></td>
												</tr>
												<tr>
													<td class="FieldLabel" style="width:17%">邮编：</td>
													<td class="FieldInput" style="width:17%"><input type="text" id="sorgPost" name='民办非企业邮编' field="sorgPost" style="width:90%"/></td>
													<td class="FieldLabel" style="width:17%">民办非企业类型：</td>
													<td class="FieldInput"><select id="sorgKind" field="sorgKind" name='民办非企业类型' style="width:90%"><option dataset="sorgKindSelect"></option></select><span style="color:red">*</span></td>
													<td class="FieldLabel" style="width:17%">所属行（事）业：</td>
													<td class="FieldInput"><select field="busScope" name='所属行（事）业' style="width:90%"><option  dataset="busScopeSelect"></option></select><span style="color:red">*</span></td>
												</tr>
												<tr>
													<td class="FieldLabel" style="width:17%">从业人员数：</td>
													<td class="FieldInput"><input type="text" id="unitsNum" name='从业员数' field="engagedNum" maxlength="6" style="width:90%"/></td>
													<td class="FieldLabel" style="width:17%">其中执业人员数：</td>
													<td class="FieldInput"><input type="text" id="peopleNum" name='其中执业人员数' field="practiceNum" maxlength="6" style="width:90%"/></td>
												</tr>
												<tr>
													<td class="FieldLabel">宗旨：</td>
													<td class="FieldInput" colspan="5"><textarea rows="5" name='民办非企业宗旨' field="purpose" style="width:98%"></textarea><span style="color:red">*</span></td>
												</tr>
												<tr>
													<td class="FieldLabel">业务范围：</td>
													<td class="FieldInput" colspan="5"><textarea rows="5" name='业务范围' field="business" style="width:98%"></textarea><span style="color:red">*</span></td>
												</tr>
												<tr>
													<td class="FieldLabel">基本设备、设施：</td>
													<td class="FieldInput" colspan="5"><textarea rows="5" name='基本设备、设施' field="facilities" style="width:98%"></textarea><span style="color:red">*</span></td>
												</tr>
												<tr>
													<td class="FieldLabel">开办资金数额：</td>
													<td class="FieldInput"><input type="text" id="regMon" name='开办资金数额' field="regMon" maxlength="10" style="width:68%"/>万元<span style="color:red">*</span></td>
													<td class="FieldLabel">验资单位：</td>
													<td class="FieldInput" colspan="3"><input type="text" name='验资单位' field="checkCapitalOrgan" style="width:98%"></td>
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
													<td class="FieldInput"><input type="text"name='民办非企业通信地址' id="sorgAdds" field="sorgAdds" style="width:97%"/></td>
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
													<td class="FieldLabel" style="width:17%">业务主管单位：</td>
													<td class="FieldInput" style="width:17%"><select name="业务主管单位" field="borgName" style="width:90%" ><option dataset="businessOrganSelect"></option></select><span style="color:red">*</span></td>
													<td class="FieldLabel" style="width:17%">单位负责人：</td>
													<td class="FieldInput" style="width:17%"><input type="text" id="borgPeople" field="borgPeople" style="width:90%"/></td>
													<td class="FieldLabel" style="width:17%">单位电话：</td>
													<td class="FieldInput" style="width:17%"><input type="text" id="borgPhone" field="borgPhone" style="width:90%"/></td>
												</tr>
												<tr>
													<td class="FieldLabel" style="width:15%">业务主管单位审查同意日期：</td>
													<td class="FieldInput" style="width:17%"><input type="text" name='业务主管单位审查同意日期' field="borgCheckDate" format="Y-m-d" onclick="WdatePicker()" style="width:90%"/></td>
													<td class="FieldLabel" style="width:15%"></td>
													<td class="FieldInput" style="width:17%"></td>
													<td class="FieldLabel" style="width:15%"></td>
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
									<next:ToolBarItem iconCls="add" text="选定为负责人" handler="chooseLegal"></next:ToolBarItem>
									<next:ToolBarItem iconCls="add" text="新增" handler="add"></next:ToolBarItem>
									<next:ToolBarItem iconCls="edit" text="修改" handler="update"></next:ToolBarItem>
									<next:ToolBarItem iconCls="delete" text="删除" handler="del"></next:ToolBarItem>
								</next:TopBar>
								<next:Columns>
									<next:RowNumberColumn/>
									<next:RadioBoxColumn></next:RadioBoxColumn>
									<next:Column header="内码" field="id" width="15%" editable="false" hidden="true"><next:TextField/></next:Column>
									<next:Column header="身份证号" field="idCard" width="15%" editable="false"><next:TextField/></next:Column>
									<next:Column header="姓名" field="name" width="10%" editable="false"><next:TextField/></next:Column>
									<next:Column header="性别" field="sex" width="10%" editable="false"><next:ComboBox dataset="sexSelect"/></next:Column>
									<next:Column header="出生年月" field="birthday" width="10%" editable="false"><next:TextField/></next:Column>
									<next:Column header="担任职务" field="sorgDuties" width="10%" editable="false"><next:ComboBox dataset="sorgDutiesSelect"/></next:Column>
									<next:Column header="是否在任" field="ifServe"width="10%" editable="false"><next:TextField/><next:ComboBox dataset="ifServeSelect"/></next:Column>
									<next:Column header="是否负责人" field="ifLegal" width="15%" editable="false"><next:TextField/><next:ComboBox dataset="comm_yesorno"/></next:Column>
									<next:Column header="任职开始日期" field="startDate" width="10%" editable="false"><next:TextField/></next:Column>
									<next:Column header="任职结束日期" field="endDate" width="10%" editable="false"><next:TextField/></next:Column>
								</next:Columns>
							</next:EditGridPanel>
						</next:Panel>
						<next:Panel title="负责人登记表"  width="100%" autoScroll="true">
							<next:Panel  width="100%" autoScroll="true">
							<next:Html>
								<form  method="post" dataset="LegalPeopleDataSet" onsubmit="return false" class="L5form">
									<table width="100%">
										<tr>
											<td class="FieldLabel" style="width:15%">身份证号码：</td>
											<td class="FieldInput" style="width:21%"><label id="labelIdCard" field="idCard"/></td>
											<td class="FieldLabel" style="width:14%">姓名：</td>
											<td class="FieldInput" style="width:17%"><label field="name"/></td>
											<td class="FieldLabel" style="width:14%">曾用名：</td>
											<td class="FieldInput" style="width:19%"><label field="aliasName"/></td>
										</tr>
										<tr>
											<td class="FieldLabel">性别：</td>
											<td class="FieldInput"><label field="sex" dataset="sexSelect"/></td>
											<td class="FieldLabel">出生年月：</td>
											<td class="FieldInput"><label field="birthday"/></td>
											<td class="FieldLabel">年龄：</td>
											<td class="FieldInput"><label id="labelAge" name='年龄'/></td>
										</tr>
										<tr>
											<td class="FieldLabel">政治面貌：</td>
											<td class="FieldInput"><label field="politics" dataset="politicsSelect"/></td>
											<td class="FieldLabel">民族：</td>
											<td class="FieldInput" colspan="3"><label field="folk" dataset="folkSelect"/></td>
										</tr>
										<tr>
											<td class="FieldLabel">文化程度：</td>
											<td class="FieldInput"><label field="education" dataset="educationSelect"/>
											</td>
											<td class="FieldLabel">技术职称：</td>
											<td class="FieldInput" colspan="3"><label field="profession"/></td>
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
											<td class="FieldLabel">人事关系所在单位：</td>
											<td class="FieldInput" colspan="3"><label field="personUnit"/></td>
											<td class="FieldLabel">人事关系所在单位电话：</td>
											<td class="FieldInput"><label field="personUnitPhone"/></td>
										</tr>
										<tr>
											<td class="FieldLabel">工作单位：</td>
											<td class="FieldInput" colspan="3"><label field="workName"/></td>
											<td class="FieldLabel">工作单位职务：</td>
											<td class="FieldInput"><label field="workDuties"/></td>
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
												<td class="FieldLabel"><label>按照本民办非企业章程会议产生通过情况：</label></td>
												<td class="FieldInput" colspan="5"><textarea   rows="2" name='"按照本民办非企业章程会议产生通过情况"' field="sorgOpinion" style="width:97.7%"></textarea><span style="color:red">*</span></td>
											</tr>
											<tr>
												<td class="FieldLabel"><label>签署日期：</label></td>
												<td class="FieldInput" colspan="5"><input type="text"  field="sorgCheckDate" format="Y-m-d" onclick="WdatePicker()" style="width:22%"/></td>
										</tr>
										<tr>
											<td class="FieldLabel">备注：</td>
											<td class="FieldInput" colspan="5"><textarea rows="2" name='"备注"' readonly="readonly" field="note" style="width:97.7%"></textarea></td>
										</tr>
									</table>
								</form>
							</next:Html>
							</next:Panel>
							<next:EditGridPanel id="somResumeLegalGrid" dataset="somResumeLegalDataSet" width="99%" stripeRows="true" height="250" title="本人简历">
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
							</next:EditGridPanel>
						</next:Panel>

						<next:Panel title="内设机构">
							<next:EditGridPanel id="officeGrid" width="100%" stripeRows="true" height="100%" dataset="somOfficeDataSet">
								<next:TopBar>
									<next:ToolBarItem symbol="内设办事机构列表"></next:ToolBarItem>
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
									<next:Column header="场所"    field="place" width="45%" editable="false"><next:TextField /></next:Column>
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
												<td class="FieldInput" colspan="5"><input type="text" id="meetingName" field="meetingName" maxlength="100" style="width:90%"></td>
											</tr>
											<tr>
												<td class="FieldLabel" style="width:17%">时间：</td>
												<td class="FieldInput" style="width:17%"><input type="text" id="meetingDate" field="meetingDate" format="Y-m-d" onclick="WdatePicker();" style="width:90%"></td>
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
									<next:ToolBarItem iconCls="add" text="增加上传附件" handler="clickUploadFile"></next:ToolBarItem>
								</next:TopBar>

								<next:Columns>
									<next:RowNumberColumn />
									<next:RadioBoxColumn></next:RadioBoxColumn>
									<next:Column header="档案目录名"  field="catalogCode" width="40%" editable="false" dataset="cataLogCodeSelect"><next:TextField /></next:Column>
									<next:Column header="附件名称"    field="fileName" width="30%" editable="false"><next:TextField /></next:Column>
									<next:Column header="附件描述"    field="fileMess" width="30%" editable="false"><next:TextField /></next:Column>
								</next:Columns>
								<next:BottomBar>
									<next:PagingToolBar dataset="somElectronicDataSet" />
								</next:BottomBar>
							</next:EditGridPanel>
						</next:Panel>
					</next:Tabs>
				</next:TabPanel>
			</next:Panel>
			<next:Panel title="流程历史意见" width="100%" >
				<next:GridPanel id="flowGrid" width="100%" stripeRows="true" height="100%" dataset="somFlowListDataSet" >
					<next:Columns>
						<next:RowNumberColumn/>
						<next:Column id="activity" header="流程环节" field="activity" width="10%" editable="false"></next:Column>
						<next:Column id="organId" header="处理单位" field="organId" width="10%" editable="false" dataset="pubOrganDataSet"></next:Column>
						<next:Column id="deptId" header="处理部门" field="deptId" width="10%" editable="false" dataset="pubOrganDataSet"></next:Column>
						<next:Column id="actorId" header="处理人" field="actorId" width="10%" editable="false" dataset="pubOrganDataSet"></next:Column>
						<next:Column id="commitTime" header="处理时间" field="commitTime" width="13%" editable="false"></next:Column>
						<next:Column id="opinionId" header="处理意见" field="opinionId" width="7%" editable="false" dataset="workFlowOpinionSelect"></next:Column>
						<next:Column id="opinion" header="处理补充意见" field="opinion" width="40%" editable="false"></next:Column>
					</next:Columns>
					<next:BottomBar>
						<next:PagingToolBar dataset="somFlowListDataSet" />
					</next:BottomBar>
				</next:GridPanel>
			</next:Panel>
			<next:Panel title="处理意见" width="100%" >
				<next:Html>
					<form method="post" onsubmit="return false" class="L5form" dataset="somApplyDataSet">
						<fieldset style="width:100%">
							<legend>处理意见</legend>
							<table width="100%">
								<tr>
									<td class="FieldLabel" style="width:13%"><label>处理意见：</label></td>
									<td class="FieldInput" colspan="5">
									<select field="curOpinionId" name='"处理意见"' style="width:150px" default="0">
										<option dataset="opinionSelect"></option>
									</select><span style="color:red">*</span>
									</td>

								</tr>
								<tr>
									<td class="FieldLabel"><label>处理补充意见：</label></td>
									<td class="FieldInput" colspan="5">
										<textarea rows="10" name='"处理补充意见"' field="curOpinion" style="width:98%"></textarea>
									</td>
								</tr>
							</table>
						</fieldset>
					</form>
				</next:Html>
			</next:Panel>
		</next:Tabs>
	</next:TabPanel>
</next:Panel>

<!-- 下载附件窗口 -->
<next:Window id="uploadWin" closeAction="hide" title="上传附件" height="230" width="600">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem iconCls="yes" text="上传" handler="click_upload"></next:ToolBarItem>
		<next:ToolBarItem xtype="tbseparator"/>
	</next:TopBar>
	<next:Html>
		<form id="form_content" onsubmit="return false" style="padding: 5px;" class="L5form">
		<table border="1"  width="100%" >
			<tr>
				<td class="FieldLabel" style="width:20%">附件描述</td>
				<td class="FieldInput" colspan="5" style="width:80%"><textarea id="fileMess" rows="5" style="width:95%"></textarea></td>
			</tr>
			<tr>
				<td class="FieldLabel">附件上传：</td>
				<td class="FieldInput" colspan="5"><input class="file" type="file" id="files" name="files" style="width:95%;height:40"/></td>
    		</tr>
    		<tr>
    			<td class="FieldInput" colspan="6"><span style="color:red">上传文件最大不能超过5M</span></td>
    		</tr>
		</table>
		</form>
   </next:Html>
</next:Window>
<!-- 下载附件列表 -->
<next:Window id="uploadList" closeAction="hide" title="附件上传列表" width="580" height="300" autoScroll="true">
	<next:EditGridPanel id="uploadListGrid" width="98%" stripeRows="true" height="88%" dataset="winElectronicDataSet">
		<next:TopBar>
			<next:ToolBarItem symbol="附件列表"></next:ToolBarItem>
			<next:ToolBarItem symbol="->"></next:ToolBarItem>
			<next:ToolBarItem iconCls="upload" text="增加上传附件" handler="addUploadFile"></next:ToolBarItem>
		</next:TopBar>
		<next:Columns>
			<next:RowNumberColumn />
			<next:RadioBoxColumn></next:RadioBoxColumn>
			<next:Column header="档案目录名"  width="18%" field="catalogCode" editable="false" hidden="true"><next:TextField /></next:Column>
			<next:Column header="附件名称" width="18%" field="fileName" editable="false"><next:TextField /></next:Column>
			<next:Column header="附件描述" width="15%" field="fileMess" editable="false"><next:TextField /></next:Column>
			<next:Column header="删除附件" field="" width="10%" editable="false" renderer="delUploadFile"><next:TextField /></next:Column>
		</next:Columns>
		<next:BottomBar>
			<next:PagingToolBar dataset="winElectronicDataSet" />
		</next:BottomBar>
	</next:EditGridPanel>
</next:Window>
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
<next:Window id="peopleWin" title="负责人情况" resizable="false" width="800" height="400" closeAction="hide" autoScroll="true">
	<next:Panel id="panel_win">
		<next:Html>
			<form title="" id="addForm" method="post" dataset="somDutyInsertDataSet" onsubmit="return false" class="L5form">
				<table width="100%">
					<tr>
						<td class="FieldLabel" style="width:15%">身份证号码：</td>
						<td class="FieldInput" style="width:21%"><input type="text" id="idCard" field="idCard" name='"身份证号码"' onblur="checkPeopleInfo();" style="width:90%"/><span style="color:red">*</span></td>
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
						<td class="FieldInput"><input type="text" id="birthday" field="birthday" name='"出生年月"' format="Y-m-d" onclick="WdatePicker()" style="width:90%"/></td>
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
						<td class="FieldLabel">文化程度：</td>
						<td class="FieldInput">
							<select field="education" name='"文化程度"' style="width:90%">
								<option dataset="educationSelect"></option>
							</select>
						</td>
						<td class="FieldLabel">技术职称：</td>
						<td class="FieldInput" colspan="3"><input type="text" field="profession" name='"技术职称"' style="width:97%"/></td>
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
						<td class="FieldLabel">人事关系所在单位：</td>
						<td class="FieldInput" colspan="3"><input type="text" id="personUnit" field="personUnit" name='"人事关系所在单位"' style="width:90%" /></td>
						<td class="FieldLabel">人事关系所在单位电话：</td>
						<td class="FieldInput"><input type="text" id="personUnitPhone" field="personUnitPhone" name='"人事关系所在单位电话"' style="width:90%"/></td>
					</tr>
					<tr>
						<td class="FieldLabel">工作单位：</td>
						<td class="FieldInput" colspan="3"><input type="text" field="workName" name='"工作单位"' style="width:90%"/></td>
						<td class="FieldLabel">工作单位职务：</td>
						<td class="FieldInput"><input type="text" field="workDuties" name='"单位职务"' style="width:90%"/></td>
					</tr>
					<tr>
						<td class="FieldLabel">是否党政机关领导干部：</td>
						<td class="FieldInput">
							<select field="ifPartyLeader" id="ifPartyLeader_add" name='"是否党政机关领导干部"' onchange="valid_ifPartyLeader_add();" style="width:90%">
								<option dataset="comm_yesorno"></option>
							</select><span style="color:red">*</span>
						</td>
						<td class="FieldLabel">批准机关：</td>
						<td class="FieldInput"><input type="text" id="promiseOrgan_add" style="width:90%;display:none"/></td>
						<td class="FieldLabel">批准文号：</td>
						<td class="FieldInput"><input type="text" id="promiseCode_add" style="width:90%;display:none"/></td>
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
						<td class="FieldInput"><input type="text" field="workCheckDate" format="Y-m-d" onclick="WdatePicker()" style="width:90%"/></td>
					</tr>
					<tr>
						<td class="FieldLabel">备注：</td>
						<td class="FieldInput" colspan="5"><textarea rows="2" name='"备注"' field="note" style="width:97.7%"></textarea></td>
					</tr>
				</table>
			</form>
		</next:Html>
	</next:Panel>
	<next:EditGridPanel id="somResumeGrid" dataset="somResumeInsertDataSet" width="765" stripeRows="true" height="250" title="本人简历">
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
	</next:EditGridPanel>
	<next:Buttons>
		<next:ToolButton text="确定" handler="confirm"></next:ToolButton>
		<next:ToolButton text="关闭" handler="closePeopleWIn"></next:ToolButton>
	</next:Buttons>
</next:Window>
<next:Window id="officeWin" title="民办非企业单位内设机构备案表" closeAction="hide" height="400" width="740">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="save" text="确定" handler="winInsertOffice"></next:ToolBarItem>
		<next:ToolBarItem iconCls="return" text="关闭" handler="winCloseOffice"></next:ToolBarItem>
	</next:TopBar>
	<next:Html>
		<form dataset="winOfficeDataSet"  onsubmit="return false" style="padding: 5px;" class="L5form">
		<table border="1" >
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
			<tr>
				<td  class="FieldInput" colspan="6"><font color="red">
				说明：<br/>
					&nbsp;&nbsp;&nbsp;&nbsp;1)工作职责的内容，必须在500字符之内！<br/>
					&nbsp;&nbsp;&nbsp;&nbsp;2)设立理由的内容，必须在500字符之内！<br/>
					&nbsp;&nbsp;&nbsp;&nbsp;3)社团履行内部程序的内容，必须在500字符之内！

				</font></td>
			</tr>
		</table>
		</form>
   </next:Html>
</next:Window>
</body>
</html>