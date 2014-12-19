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
<script type="text/javascript" src="fundBranchHistoryBuild.js"></script>
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
	
	<next:TabPanel id="tab" width="100%" height="100%" activeTab="0">
		<next:Tabs>
			<next:Panel title="基金会分支（代表）机构设立登记申请表" width="100%" height="100%" autoScroll="true">
				<next:Html>
					<form method="post" dataset="somOrganDataSet" onsubmit="return false"class="L5form">
						<table width="100%">
							<tr>
								<td class="FieldLabel"><label>基金会登记证号：</label></td>
								<td class="FieldInput" colspan="5"><input type="text"  id="mainSorgCode" name='"主体登记证号"' field="mainSorgCode" onkeyup="value=value.replace(/[^\\w\.\/]/ig,'').toUpperCase()"  onblur="validateSorgCode()" style="width:98%"/><label style="color:red">*</label></td>
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
								<td class="FieldInput" colspan="5"><input type="text" id="branchSorgCode" name='"分支/代表机构登记证号"' field="sorgCode" onkeyup="value=value.replace(/[^\-\\w\.\/]/ig,'').toUpperCase()" onblur="sorgCodeUK()" style="width:98%"/><label style="color:red">*</label></td>
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
			<next:Panel title="基金会负责人备案表">
				<next:Panel>
					<next:Html>
					<fieldset>
						<legend>基金会信息</legend>
						<form onsubmit="return false" dataset="somSessionDataSet" class="L5form">
							<table width="100%">
								<tr>
									<td class="FieldLabel">届次名称：</td>
									<td class="FieldInput" colspan="3"><input type="text" id="sessionName" field="sessionName" style="width:97%"/></td>
									<td class="FieldLabel" style="width:17%">本届任期（年）：</td>
									<td class="FieldInput" style="width:17%"><input type="text" id="tenure" field="tenure" style="width:90%"/></td>
								</tr>
								<tr>
									<td class="FieldLabel" style="width:17%">本届开始日期：</td>
									<td class="FieldInput" style="width:17%"><input type="text" id="startDate" field="startDate"onClick="WdatePicker()" style="width:90%"/></td>
									<td class="FieldLabel" style="width:17%">规定换届日期：</td>
									<td class="FieldInput" style="width:15%"><input type="text" id="endDate" field="endDate"onClick="WdatePicker()" style="width:90%"/></td>
									<td class="FieldLabel" style="width:17%"></td>
									<td class="FieldInput" style="width:17%"></td>
								</tr>
							</table>
						</form>
						</fieldset>
					</next:Html>
				</next:Panel>
				<next:EditGridPanel id="peopleGrid" dataset="somDutyDataSet" width="100%" stripeRows="true" height="99.9%">
					<next:TopBar>
						<next:ToolBarItem symbol="->"></next:ToolBarItem>
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
						<next:Column header="担任职务" field="sorgDuties" width="10%" editable="false"><next:ComboBox dataset="dutySelectDic"/></next:Column>
						<next:Column header="是否在任" field="ifServe"width="10%" editable="false"><next:TextField/><next:ComboBox dataset="ifServeSelect"/></next:Column>
						<next:Column header="任职开始日期" field="startDate" width="10%" editable="false"><next:TextField/></next:Column>
						<next:Column header="任职结束日期" field="endDate" width="10%" editable="false"><next:TextField/></next:Column>
					</next:Columns>
				</next:EditGridPanel>
			</next:Panel>
			
			<next:Panel title="法律要件">
				<next:EditGridPanel id="uploadGrid" dataset="somElectronicDataSet" width="100%" stripeRows="true" height="100%">
					<next:GroupingView forceFit="true"></next:GroupingView>
					<next:TopBar>
						<next:ToolBarItem symbol="附件列表"></next:ToolBarItem>
						<next:ToolBarItem symbol="->"></next:ToolBarItem>
						<next:ToolBarItem iconCls="upload" text="增加上传附件" handler="uploadFile"></next:ToolBarItem>
					</next:TopBar>
					<next:Columns>
						<next:RowNumberColumn/>
						<next:RadioBoxColumn></next:RadioBoxColumn>
						<next:Column header="档案目录名" field="catalogCode" width="38%" editable="false" dataset="cataLogCodeSelect"><next:TextField /></next:Column>
						<next:Column header="附件名称" field="fileName" width="30%" editable="false"><next:TextField /></next:Column>
						<next:Column header="附件描述" field="fileMess" width="20%" editable="false"><next:TextField /></next:Column>
						<next:Column header="下载附件"    field="" width="10%" editable="false" renderer="clickDownloadHref"><next:TextField /></next:Column>
						<next:Column header="业务类型"    field="applyType" hidden="true">
							<next:ExtendConfig>
								groupRenderer:grender,groupName:"法律要件目录"
							</next:ExtendConfig>
						</next:Column>
					</next:Columns>
					<next:BottomBar>
						<next:PagingToolBar dataset="somElectronicDataSet"/>
					</next:BottomBar>
				</next:EditGridPanel>
			</next:Panel>
			<next:Panel title="处理意见">
				<next:Html>
					<fieldset>
						<form method="post" dataset="somApplyDataSet" onsubmit="return false" class="L5form" >
							<table width="100%">
								<tr>
									<td class="FieldLabel" style="width:15%">承办人意见：</td>
									<td class="FieldInput" style="width:15%">
										<select field="acceptOpinionId" name='"承办人意见"' >
											<option dataset="opinionDataSet"/>
										</select>
									</td>
									<td class="FieldLabel" style="width:15%">承办人：</td>
									<td class="FieldInput" style="width:15%"><input type="text" field="acceptPeopleName" name='承办人'  style="width:90%" />
									</td>
									<td class="FieldLabel" style="width:15%">承办时间：</td>
									<td class="FieldInput" style="width:25%"><input type="text" name='承办时间' field="acceptTime"onClick="WdatePicker()"/>
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
											<option dataset="opinionDataSet"/>
										</select>
									</td>
									<td class="FieldLabel" >初审负责人：</td>
									<td class="FieldInput" ><input type="text" field="examinPeopleName" name='初审负责人'  style="width:90%" />
									</td>
									<td class="FieldLabel" >初审时间：</td>
									<td class="FieldInput" ><input type="text" name='初审时间' field="examinTime"onClick="WdatePicker()" />
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
											<option dataset="opinionDataSet"/>
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
											<option dataset="opinionDataSet"/>
										</select>
									</td>
									<td class="FieldLabel" >批准人：</td>
									<td class="FieldInput" ><input type="text" field="auditPeopleName" name='批准人' style="width:90%" />
									</td>
									<td class="FieldLabel" >批准时间：</td>
									<td class="FieldInput" ><input type="text" name='批准时间' field="auditTime" onClick="WdatePicker()" />
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
<next:Window id="win_peopleValidate" title="人员身份验证"  resizable="false" width="500" height="403" closeAction="hide" modal="true">
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
								<td class="FieldLabel">国籍：</td>
								<td class="FieldInput">
									<input type="text" id="nationDispaly" name="countryNameDispaly"  title="国籍"  onkeyup="findDiv(this,'nation','countryDiv','','countryQueryDic','text@like','value','text','35')" onblur="clearCountryDiv()" onchange="clearCountry(this)"/><img src="<%=SkinUtils.getImage(request,"l5/help.gif")%>" style="cursor:hand" onclick="showCountryWin()"/>
									<div id="countryDiv" style="width:300px; height: 150px; display: none;position: absolute;background-color: #FFFFFF;" >  
        								<ul></ul> 
   									</div>
   									<input type="hidden" id="nation" name="nation" field="nation" title="国籍"/>
								</td>
								<td class="FieldLabel">家庭住址：</td>
								<td class="FieldInput"><input type="text" field="adds" name='"家庭住址"' style="width:97%"/></td>
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
								<td class="FieldLabel">职务：</td>
								<td class="FieldInput">
										<input type="text" id="sorgDutiesNameDispaly" style="width:60%" name="sorgDutiesNameDispaly"  title="社团职务"  onkeyup="findDiv(this,'sorgDuties','dutyPopup','','dutyQueryDic','text@like','value','text','70')" onblur="cleardutyDiv()" onchange="clearduty(this)"/><img src="<%=SkinUtils.getImage(request,"l5/help.gif")%>" style="cursor:hand" onclick="showdutyWin()"/>
										<div id="dutyPopup" style="width:300px; height: 150px; display: none;position: absolute;background-color: #FFFFFF;" >  
 	        								<ul></ul> 
     									</div>
     							<input type="hidden" id="sorgDuties" name="sorgDuties" field="sorgDuties" title="社团职务代码"/>
     							<span style="color:red">*</span></td>
								<td class="FieldLabel">任职开始日期：</td>
								<td class="FieldInput"><input type="text" field="startDate" name='"任职开始日期"' onClick="WdatePicker()" style="width:90%"/><span style="color:red">*</span></td>
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
								<td class="FieldLabel">批准机关：</td>
								<td class="FieldInput"><input type="text" id="promiseOrgan_add"  field="promiseOrgan" style="width:90%;display:none"/></td>
								<td class="FieldLabel">批准文号：</td>
								<td class="FieldInput"><input type="text" id="promiseCode_add" field="promiseCode" style="width:90%;display:none"/></td>
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
								<td class="FieldInput"><input type="text" field="workCheckDate" onClick="WdatePicker()"style="width:90%"/></td>
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
		<next:ToolButton text="关闭" handler="closePeopleWIn"></next:ToolButton>
	</next:Buttons>
</next:Window>
<jsp:include page="../../../comm/upload/uploadWindow.jsp" flush="true"/>
<jsp:include page="../../../comm/borg/borgSelectWindow.jsp" flush="true"/> 
<jsp:include page="../../../comm/country/countrySelectWindow.jsp" flush="true"/> 
<jsp:include page="../../../comm/selectWindow/duty/dutySelectWindow.jsp" flush="true"/>
</body>
</html>