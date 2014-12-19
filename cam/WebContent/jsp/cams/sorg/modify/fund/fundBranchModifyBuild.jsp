<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="org.loushang.bsp.security.context.GetBspInfo"%>
<%@page import="com.inspur.cams.comm.util.*"%>
<%@ page import="com.inspur.cams.sorg.apply.group.cmd.GroupBuildCmd"%>
<%@page import="com.inspur.cams.sorg.util.SomIdHelp"%>
<%@page import="com.inspur.cams.sorg.util.ApplyType"%>
<html>
<head>
<title>基金会分支申请成立登记</title>
<next:ScriptManager></next:ScriptManager>
<script>
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
		sorgId = '<%=StrUtil.n2b(SomIdHelp.getFundSorgId())%>';
	}
	var taskCode='<%=taskCode%>';
	if(taskCode == ''){
		taskCode = '<%=StrUtil.n2b(SomIdHelp.getFundTaskCode())%>';
	}
	var somApplyType = '<%=ApplyType.getSOM_FUND_BRANCH_BUILD()%>';
	var rootPath="<%=SkinUtils.getRootUrl(request)%>";
	var currentUserName = '<%= GetBspInfo.getBspInfo().getUserName()%>';
	var applyType = "222,223";
	var updateRecord="";
</script>
<script type="text/javascript" src="fundBranchModifyBuild.js"></script>
<script type="text/javascript" src="<%=SkinUtils.getJS(request, "bpm/bpm.js")%>"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"My97DatePicker/WdatePicker.js") %>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams/sorgUpload.js")%>'></script>
</head>
<body>
<model:datasets>
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
	<model:dataset id="somMainOrganDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomOrganQueryCmd" method="queryMain">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomOrgan"></model:record>
	</model:dataset>
	<model:dataset id="somOrganDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomOrganQueryCmd" global="true" method="queryBranch">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomOrgan">
			<model:field name="mainSorgCode" type="string" rule="require" />
			<model:field name="cnName" type="string" rule="require|length{100}" />
			<model:field name="sorgCode" type="string" rule="require|length{20}" />
			<model:field name="residence" type="string" rule="require|length{100}" />
			<model:field name="sorgPost" type="string" rule="length{6}" />
			<model:field name="sorgKind" type="string" rule="require" />
			<model:field name="sorgPhone" type="string" rule="length{30}" />
			<model:field name="business" type="string" rule="require|length{1000}" />
			<model:field name="appReason" type="string" rule="require|length{500}" />
			<model:field name="borgName" type="string" rule="length{100}" />
			<model:field name="buildDate" type="string" rule="require" />
		</model:record>
	</model:dataset>
	<%--人员简历 --%>
	<model:dataset id="somResumeDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomPeopleResumeQueryCommand" global="true" sortField="startDate" sortDirection="DESC">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomPeopleResume"></model:record>
	</model:dataset>	
	<%--人员简历 --%>
	<model:dataset id="somResumeInsertDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomPeopleResumeQueryCommand">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomPeopleResume"></model:record>
	</model:dataset>
	<model:dataset id="somFlowDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomFlowQueryCmd" global="true" sortField="commitTime" pageSize="100">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomFlow"></model:record>
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
	<model:dataset id="cataLogCodeSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='SOM_CATALOG'></model:param>
			<model:param name="value" value='CATALOG_CODE'></model:param>
			<model:param name="text" value='CATALOG_NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="sorgKindSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_FUND_BRANCH_KIND'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="businessOrganSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true" sortField="ORDER_NUMBER">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='SOM_BUSINESS_ORGAN'></model:param>
			<model:param name="value" value='BORG_CODE'></model:param>
			<model:param name="text" value='BORG_NAME'></model:param>
			<model:param name="filterSql" value='<%="MORG_CODE ="+BspUtil.getOrganCode().substring(0,6)%>'></model:param>			
		</model:params>
	</model:dataset>
	<model:dataset id="busScopeSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_BUS_SCOPE'></model:param>
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
	<model:dataset id="pubOrganDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='PUB_ORGAN'></model:param>
			<model:param name="value" value='ORGAN_ID'></model:param>
			<model:param name="text" value='ORGAN_NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="opinionDataSet" enumName="WORKFLOW.OPINION" autoLoad="true" global="true"></model:dataset>	
	<model:dataset id="hisOpinionDataSet" enumName="WORKFLOW.OPINION" autoLoad="true" global="true"></model:dataset>	
	<!-- 届次信息 -->
	<model:dataset id="somSessionDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomSessionQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomSession">
			<model:field name="sessionName" type="string" rule="length{100}" />
			<model:field name="tenure" type="string" rule="length{2}" />
		</model:record>
	</model:dataset>
	<!-- 负责人信息 -->
	<model:dataset id="somDutyDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomDutyQueryCmd" global="true" method="queryPeople"  pageSize="100">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomDuty"></model:record>
	</model:dataset>
	<!-- 负责人录入窗口 -->
	<model:dataset id="somDutyInsertDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomDutyQueryCmd" global="true"  method="queryPeople">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomDuty">
			<model:field name="idCard" type="string" rule="require|length{18}" />
			<model:field name="name" type="string" rule="require|length{72}" />
			<model:field name="aliasName" type="string" rule="length{72}" />
			<model:field name="phone" type="string" rule="length{30}" />
			<model:field name="sorgDuties" type="string" rule="require" />
			<model:field name="adds" type="string" rule="length{100}" />
			<model:field name="populace" type="string" rule="length{100}" />
			<model:field name="postCode" type="string" rule="length{6}" />
			<model:field name="workName" type="string" rule="length{100}" />
			<model:field name="workDuties" type="string" rule="length{50}" />
			<model:field name="ifPartyLeader" type="string" rule="require" />
			<model:field name="resume" type="string" rule="length{1000}" />
			<model:field name="workOpinion" type="string" rule="length{200}" />
			<model:field name="sorgOpinion" type="string" rule="length{200}" />
			<model:field name="startDate" type="string" rule="require" />
			<model:field name="promiseOrgan" type="string" rule="length{100}" />
			<model:field name="promiseCode" type="string" rule="length{100}" />
			<model:field name="otherDuties" type="string" rule="length{500}" />
			<model:field name="note" type="string" rule="length{200}" />
		</model:record>
	</model:dataset>
	<model:dataset id="cardTypeSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_CARD_TYPE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="sexSelect" enumName="COMM.SEX" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="folkSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_NATION'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="politicsSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_POLITICAL'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="ifFulltimeSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_IF_FULLTIME'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 组织名称 -->
	<model:dataset id="sorgNameSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='SOM_ORGAN'></model:param>
			<model:param name="value" value='SORG_ID'></model:param>
			<model:param name="text" value='CN_NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="sorgDutiesSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_SOM_DUTY'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<%--所有符合身份证号的人员列表--%>
	<model:dataset id="winPeopleDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomPeopleQueryCmd" >
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomPeople"></model:record>
	</model:dataset>
	<%--所有符合身份证号的人员列表--%>
	<model:dataset id="winDutyDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomDutyQueryCmd"  method="queryPeople">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomDuty"></model:record>
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
	<model:dataset id="comm_yesorno" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
</model:datasets>
<%--定义界面--%>
<next:Panel width="100%" height="100%">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="save" text="保存" handler="save"/>
		<next:ToolBarItem iconCls="undo" text="返回" handler="goBack"/>
	</next:TopBar>
<next:Panel title="基金会分支（代表）机构设立登记申请表" width="100%" height="100%" autoScroll="true">
	<next:Html>
		<form method="post" dataset="somOrganDataSet" onsubmit="return false"class="L5form">
			<table width="100%">
				<tr>
					<td class="FieldLabel"><label>基金会登记证号：</label></td>
					<td class="FieldInput" colspan="5"><input type="text"  id="mainSorgCode" name='"主体登记证号"' field="mainSorgCode" onblur="validateSorgCode()" style="width:98%"/><label style="color:red">*</label></td>
				</tr>
				<tr>
					<td class="FieldLabel"><label>基金会名称：</label></td>
					<td class="FieldInput" colspan="5"><label id="name"  field="name" style="width:98%"></label></td>
				</tr>
				<tr>
					<td class="FieldLabel"><label>分支/代表机构名称：</label></td>
					<td class="FieldInput" colspan="5"><input type="text" id="cnName" name='"分支/代表机构名称"' field="cnName" onblur="cnNameUK()" style="width:98%"/><label style="color:red">*</label></td>
				</tr>
				<tr>
					<td class="FieldLabel"><label>分支/代表机构登记证号：</label></td>
					<td class="FieldInput" colspan="5"><input type="text" id="branchSorgCode" name='"分支/代表机构登记证号"' field="sorgCode" onblur="sorgCodeUK()" style="width:98%"/><label style="color:red">*</label></td>
				</tr>
				<tr>
					<td class="FieldLabel"><label>办公场所：</label></td>
					<td class="FieldInput" colspan="5"><input type="text" name='"办公场所"' field="residence" style="width:98%"/><label style="color:red">*</label></td>
				</tr>
				<tr>
					<td class="FieldLabel" style="width:15%"><label>分支/代表机构电话：</label></td>
					<td class="FieldInput" style="width:17%"><input type="text" id="sorgPhone" name='"机构电话"' field="sorgPhone" style="width:90%"/></td>
					<td class="FieldLabel" style="width:15%"><label>分支/代表机构邮编：</label></td>
					<td class="FieldInput" style="width:17%"><input type="text" id="sorgPost" name='"机构邮编"' field="sorgPost" style="width:90%"/></td>
					<td class="FieldLabel" style="width:15%"><label>分支/代表机构类型：</label></td>
					<td class="FieldInput" style="width:17%">
						<select name='"机构类型"' field="sorgKind" style="width:90%">
							<option dataset="sorgKindSelect"></option>
						</select><label style="color:red">*</label>
					</td>
				</tr>
				<tr>
					<td class="FieldLabel"><label>业务范围：</label></td>
					<td class="FieldInput" colspan="5"><textarea rows="10" name='"业务范围"' field="business" style="width:98%"/></textarea><label style="color:red">*</label></td>
				</tr>
				<tr>
					<td class="FieldLabel"><label>设立理由：</label></td>
					<td class="FieldInput" colspan="5"><textarea rows="5" name='"设立理由"' field="appReason" style="width:98%"></textarea><label style="color:red">*</label></td>
				</tr>
				<tr>
					<td class="FieldLabel">业务主管单位：</td>
					<td class="FieldInput" colspan="3">
					<input type="text" id="borgNameDispaly" name="borgNameDispaly"  title="业务主管单位"  onkeyup="findDiv(this,'borgName','popup','','businessOrganAuto','BORG_NAME@like','borgCode','borgName','35')" onblur="clearDiv()" onchange="clearBorg(this)"/><img src="<%=SkinUtils.getImage(request,"l5/help.gif")%>" style="cursor:hand" onclick="showBorgWin()"/>
					<div id="popup" style="width:300px; height: 150px; display: none;position: absolute;background-color: #FFFFFF;" >  
     							<ul></ul> 
								</div>
								<input type="hidden" id="borgName" name="borgName" field="borgName" title="业务主管单位代码"/>
					<span style="color:red">*</span></td>
					
					<td class="FieldLabel"><label>成立日期：</label></td>
					<td class="FieldInput"><input type="text" name='"成立日期"' field="buildDate" onClick="WdatePicker()" style="width:90%"/><span style="color:red">*</span></td>
				</tr>
				<div id="mainSorgId" title="隐藏：主体ID" style="display:none"></div>
			</table>
		</form>
		<div id="mainSorgId" title="隐藏：主体ID" style="display:none"></div>
	</next:Html>
</next:Panel>
</next:Panel>

<jsp:include page="../../comm/borg/borgSelectWindow.jsp" flush="true"/> 
</body>
</html>