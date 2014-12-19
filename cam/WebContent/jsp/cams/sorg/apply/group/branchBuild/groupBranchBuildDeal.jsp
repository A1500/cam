<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="java.util.*" %>
<%@page import="org.loushang.workflow.api.WfQuery" %>
<%@page import="java.lang.StringBuffer"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<%@ page import="com.inspur.cams.sorg.apply.group.cmd.GroupBuildCmd"%>
<html>
<head>
<title>社会团体分支申请成立登记明细查看</title>
<next:ScriptManager></next:ScriptManager>
<%
	String processId = (String) request.getParameter("processId");
	String assignmentId = (String) request.getParameter("assignmentId");
	if (processId == null || "".equals(processId)) {
		processId = new GroupBuildCmd().getProcessId(assignmentId);
	}
	String actDefUniqueId = (String) request.getParameter("actDefUniqueId");
	String act = request.getParameter("act");
	String method = request.getParameter("method");

	StringBuffer localStringBuffer = new StringBuffer();
    localStringBuffer.append(request.getScheme());
    localStringBuffer.append("://");
    localStringBuffer.append(request.getServerName());
    localStringBuffer.append(":");
    localStringBuffer.append(request.getServerPort());
    localStringBuffer.append(request.getContextPath());
    String url= localStringBuffer.toString();
%>
<script>
	var processId="<%=processId %>";
	var actDefUniqueId="<%=actDefUniqueId %>";
	var assignmentId="<%=assignmentId %>";
	var act="<%=act %>";
	var method="<%=method %>";
	var applyType = "005";
	var sorgId='';
	var taskCode = '';
	var fileCode="S059";
	var url='<%=url%>';
</script>
<script type="text/javascript" src="groupBranchBuild.js"></script>
<script type="text/javascript" src="<%=SkinUtils.getJS(request, "bpm/bpm.js")%>"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams/sorgUpload.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams/sorgOnline.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"My97DatePicker/WdatePicker.js") %>'></script>
</head>
<body>
<model:datasets>
	<!-- 更改业务状态所用dataset -->
	<model:dataset id="updateStatusDataSet" cmd="com.inspur.cams.sorg.online.base.cmd.SomApplyOnlineQueryCommand"  global="true" >
		<model:record fromBean="com.inspur.cams.sorg.online.base.data.SomApplyOnline"></model:record>
	</model:dataset>
	<model:dataset id="somApplyDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomApplyQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomApply"></model:record>
	</model:dataset>
	<model:dataset id="somOrganDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomOrganQueryCmd" global="true" method="queryBranch">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomOrgan"></model:record>
	</model:dataset>
	<model:dataset id="somFlowDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomFlowQueryCmd" global="true" sortField="COMMIT_TIME" pageSize="100">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomFlow"></model:record>
	</model:dataset>
	<model:dataset id="somFlowQuery" cmd="com.inspur.cams.sorg.base.cmd.SomFlowQueryCmd" >
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomFlow"></model:record>
	</model:dataset>
	<model:dataset id="borgDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='SOM_BUSINESS_ORGAN'></model:param>
			<model:param name="value" value='BORG_CODE'></model:param>
			<model:param name="text" value='BORG_NAME'></model:param>
			<model:param name="filterSql" value='<%="MORG_CODE ="+BspUtil.getOrganCode().substring(0,6)%>'></model:param>

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
	<model:dataset id="pubOrganDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='PUB_ORGAN'></model:param>
			<model:param name="value" value='ORGAN_ID'></model:param>
			<model:param name="text" value='ORGAN_NAME'></model:param>
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
	<model:dataset id="businessOrganSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
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
	<!-- 届次信息 -->
	<model:dataset id="somSessionDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomSessionQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomSession">
		</model:record>
	</model:dataset>
	<!-- 负责人信息 -->
	<model:dataset id="somDutyDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomDutyQueryCmd" global="true"  method="queryPeople">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomDuty"></model:record>
	</model:dataset>
	<%--电子档案--%>
	<model:dataset id="somElectronicDataSet" cmd="com.inspur.cams.sorg.upload.cmd.SomElectronicQueryCmd" global="true" method="queryCatalog">
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
	<!-- 负责人详情窗口 -->
	<model:dataset id="somDutyInsertDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomDutyQueryCmd" global="true"  method="queryPeople">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomDuty"></model:record>
	</model:dataset>
	<%--人员简历 --%>
	<model:dataset id="somResumeDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomPeopleResumeQueryCommand" sortField="startDate" sortDirection="DESC">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomPeopleResume"></model:record>
	</model:dataset>
	<%--人员简历 --%>
	<model:dataset id="somResumeInsertDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomPeopleResumeQueryCommand">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomPeopleResume"></model:record>
	</model:dataset>
	<model:dataset id="comm_yesorno" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="sexSelect" enumName="COMM.SEX" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="opinionDataSet" enumName="WORKFLOW.OPINION" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="hisOpinionDataSet" enumName="WORKFLOW.OPINION" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="politicsSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_POLITICAL'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="resideSourceSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_RESIDE_SOURCE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
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
	<model:dataset id="sorgDutiesSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_SOM_DUTY'></model:param>
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
	<model:dataset id="folkSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_NATION'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="businessOrganSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='SOM_BUSINESS_ORGAN'></model:param>
			<model:param name="value" value='BORG_CODE'></model:param>
			<model:param name="text" value='BORG_NAME'></model:param>
			<model:param name="filterSql" value='<%="MORG_CODE ="+BspUtil.getOrganCode().substring(0,6)%>'></model:param>

		</model:params>
	</model:dataset>
	<model:dataset id="certTypeSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_CERT_TYPE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="cardTypeSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_CARD_TYPE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 状态 -->
	<model:dataset id="ifServeSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_DUTY_IF_SERVE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
</model:datasets>
<%--定义界面--%>
<next:ViewPort>
<next:Panel width="100%" height="100%">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<%
		List<Map> list = new ArrayList<Map>();
		if ("yiban".equals(method)||"end".equals(method)) {
			Map<String, String> map = new HashMap<String, String>();
			map.put("buttonName", "返回");
			map.put("buttonFunName", "goBack()");
			List<Map> lists = new ArrayList<Map>();
			lists.add(map);
			list = lists;
		} else {
			list = new WfQuery().getActButtons(actDefUniqueId);
		}
		//从后台获取环节按钮权限，显示要显示按钮
		for(int i=0;i<list.size();i++){
			Map map=(Map)list.get(i);
			String buttonName=(String)map.get("buttonName");
			String buttonFunName=(String)map.get("buttonFunName");
			String buttonIcon = "";
			if("saveApply()".equals(buttonFunName)){
				buttonIcon = "save";
			}
			if("send()".equals(buttonFunName)){
				buttonIcon = "select";
			}
			if("sendForPrint()".equals(buttonFunName)){
				buttonIcon = "select";
			}
			if("printNoAccept()".equals(buttonFunName)){
				buttonIcon = "print";
			}
			if("printAccept()".equals(buttonFunName)){
				buttonIcon = "print";
			}
			if("printCert()".equals(buttonFunName)){
				buttonIcon = "print";
			}
			if("choseIssuePeople()".equals(buttonFunName)){
				buttonIcon = "select";
			}
			if("goBack()".equals(buttonFunName)){
				buttonIcon = "return";
			}
		%>
			<next:ToolBarItem iconCls="<%=buttonIcon%>" text="<%=buttonName%>" handler="<%=buttonFunName%>" />
		<%
		}
		%>
	</next:TopBar>
	<next:TabPanel id="tab" width="100%" height="100%" activeTab="4">
		<next:Tabs>
			<next:Panel title="社团分支/代表机构明细查看" width="100%" autoScroll="true">
				<next:Html>
				<fieldset>
				<legend>社团分支/代表机构明细信息</legend>
					<form method="post" dataset="somOrganDataSet" onsubmit="return false"class="L5form">
						<table width="100%">
							<tr>
								<td class="FieldLabel"><label>社会团体登记证号：</label></td>
								<td class="FieldInput" colspan="5"><label  field="mainSorgCode" style="width:98%"/></td>
							</tr>
							<tr>
								<td class="FieldLabel"><label>社会团体名称：</label></td>
								<td class="FieldInput" colspan="5"><label id="name" style="width:98%"></label></td>
							</tr>
							<tr>
								<td class="FieldLabel"><label>分支/代表机构名称：</label></td>
								<td class="FieldInput" colspan="5"><label field="cnName" style="width:98%"/></td>
							</tr>
							<tr>
								<td class="FieldLabel"><label>办公场所：</label></td>
								<td class="FieldInput" colspan="5"><label field="residence" style="width:98%"/></td>
							</tr>
							<tr>
								<td class="FieldLabel" style="width:17%"><label>分支/代表机构电话：</label></td>
								<td class="FieldInput" style="width:17%"><label field="sorgPhone" style="width:90%"/></td>
								<td class="FieldLabel" style="width:17%"><label>分支/代表机构邮编：</label></td>
								<td class="FieldInput" style="width:17%"><label field="sorgPost" style="width:90%"/></td>
								<td class="FieldLabel" style="width:17%"><label>分支/代表机构类型：</label></td>
								<td class="FieldInput" style="width:17%"><label field="sorgKind" dataset="sorgKindSelect" style="width:90%"/></td>
							</tr>
							<tr>
								<td class="FieldLabel"><label>业务范围：</label></td>
								<td class="FieldInput" colspan="5"><textarea rows="10" field="business" style="width:98%;background-color:#F5FAFA;border:0;overflow:auto;" readonly="readonly"></textarea></td>
							</tr>
							<tr>
								<td class="FieldLabel"><label>设立理由：</label></td>
								<td class="FieldInput" colspan="5"><textarea rows="5" field="appReason" style="width:98%;background-color:#F5FAFA;border:0;overflow:auto;" readonly="readonly"></textarea></td>
							</tr>
							<tr>
								<td class="FieldLabel"><label>业务主管单位：</label></td>
								<td class="FieldInput" colspan="3"><label field="borgName" style="width:97%" dataset="businessOrganSelect"/></td>
								<td class="FieldLabel"><label>成立日期：</label></td>
								<td class="FieldInput"><label field="buildDate" format="Y-m-d" style="width:90%"/></td>
							</tr>
						</table>
						<div id="mainSorgId" title="隐藏：主体ID" style="display:none"></div>
					</form>
					</fieldset>
					<fieldset>
					<legend>历史处理意见</legend>
					<form method="post" dataset="somApplyDataSet" onsubmit="return false" class="L5form" >
					<table width="100%">
						<tr>
							<td class="FieldLabel" style="width:17%">承办人意见：</td>
							<td class="FieldInput" style="width:17%">
								<label field="acceptOpinionId" name='"承办人意见"' style="width:90%" dataset="hisOpinionDataSet" default="0" />
							</td>
							<td class="FieldLabel" style="width:17%">承办人：</td>
							<td class="FieldInput" style="width:17%"><label type="text" field="acceptPeopleName" name='承办人'  style="width:90%" />
							</td>
							<td class="FieldLabel" style="width:17%">承办时间：</td>
							<td class="FieldInput" style="width:17%"><label type="text" name='承办时间' field="acceptTime" style="width:90%" />
							</td>
						</tr>
						<tr>
							<td class="FieldLabel">承办补充意见：</td>
							<td class="FieldInput" colspan="5"><textarea rows="3" name='承办补充意见' field="acceptOpinion" style="width:98%;background-color:#F5FAFA;border:0;overflow:auto;" readonly></textarea>
							</td>
						</tr>
						<tr>
							<td class="FieldLabel" style="width:17%">现场勘查意见：</td>
							<td class="FieldInput" style="width:17%">
								<label type="text"  field="prospectOpinionId" name='"现场勘查意见"' style="width:90%" dataset="hisOpinionDataSet"  />
							</td>
							<td class="FieldLabel" style="width:17%">现场勘查承办人：</td>
							<td class="FieldInput" style="width:17%"><label type="text" field="prospectPeopleName" name='现场勘查承办人'  style="width:90%" /></td>
							<td class="FieldLabel" style="width:17%">现场勘查日期：</td>
							<td class="FieldInput" style="width:17%"><label type="text" name='现场勘查日期' field="prospectDate" style="width:90%" /></td>
						</tr>
						<tr>
							<td class="FieldLabel" style="width:17%">现场勘查双方参加人员：</td>
							<td class="FieldInput" colspan="5">
								<label type="text"  field="prospectAttendPeople" name='"现场勘查双方参加人员"' style="width:90%"/>
							</td>
						</tr>
						<tr>
							<td class="FieldLabel" style="width:17%">现场勘查地点：</td>
							<td class="FieldInput" colspan="5"><label type="text" field="prospectPlace" name='现场勘查地点'  style="width:90%" /></td>
						</tr>
						<tr>
							<td class="FieldLabel">现场勘查补充意见：</td>
							<td class="FieldInput" colspan="5"><textarea rows="3" name='现场勘查补充意见' field="prospectOpinion" style="width:98%;background-color:#F5FAFA;border:0;overflow:auto;" readonly></textarea>
							</td>
						</tr>
						<tr>
							<td class="FieldLabel" style="width:17%">初审意见：</td>
							<td class="FieldInput" style="width:17%">
								<label field="examinOpinionId" name='"初审意见"' style="width:90%" dataset="hisOpinionDataSet" default="0" />
							</td>
							<td class="FieldLabel" style="width:17%">初审负责人：</td>
							<td class="FieldInput" style="width:17%"><label type="text" field="examinPeopleName" name='初审负责人'  style="width:90%" />
							</td>
							<td class="FieldLabel" style="width:17%">初审时间：</td>
							<td class="FieldInput" style="width:17%"><label type="text" name='初审时间' field="examinTime" style="width:90%" />
							</td>
						</tr>
						<tr>
							<td class="FieldLabel">初审补充意见：</td>
							<td class="FieldInput" colspan="5"><textarea rows="3" name='初审补充意见' field="examinOpinion" style="width:98%;background-color:#F5FAFA;border:0;overflow:auto;" readonly></textarea>
							</td>
						</tr>
						<tr>
							<td class="FieldLabel" style="width:17%">审核意见：</td>
							<td class="FieldInput" style="width:17%">
								<label field="checkOpinionId" name='"审核意见"' style="width:90%" dataset="hisOpinionDataSet" default="0" />
							</td>
							<td class="FieldLabel" style="width:17%">审核人：</td>
							<td class="FieldInput" style="width:17%"><label type="text" field="checkPeopleName" name='审核人' style="width:90%" />
							</td>
							<td class="FieldLabel" style="width:17%">审核时间：</td>
							<td class="FieldInput" style="width:17%"><label type="text" name='审核时间' field="checkTime" style="width:90%" />
							</td>
						</tr>
						<tr>
							<td class="FieldLabel">审核补充意见：</td>
							<td class="FieldInput" colspan="5"><textarea rows="3" name='审核补充意见' field="checkOpinion" style="width:98%;background-color:#F5FAFA;border:0;overflow:auto;" readonly></textarea>
							</td>
						</tr>
						<tr>
							<td class="FieldLabel" style="width:17%">批准意见：</td>
							<td class="FieldInput" style="width:17%">
								<label field="auditOpinionId" name='"批准意见"' style="width:90%" dataset="hisOpinionDataSet" default="0" />
							</td>
							<td class="FieldLabel" style="width:17%">批准人：</td>
							<td class="FieldInput" style="width:17%"><label type="text" field="auditPeopleName" name='批准人' style="width:90%" />
							</td>
							<td class="FieldLabel" style="width:17%">批准时间：</td>
							<td class="FieldInput" style="width:17%"><label type="text" name='批准时间' field="auditTime" style="width:90%" />
							</td>
						</tr>
						<tr>
							<td class="FieldLabel">批准补充意见：</td>
							<td class="FieldInput" colspan="5"><textarea rows="3" name='批准补充意见' field="auditOpinion" style="width:98%;background-color:#F5FAFA;border:0;overflow:auto;" readonly></textarea>
							</td>
						</tr>
					</table>
					</form>
					</fieldset>
				</next:Html>
			</next:Panel>
			<next:Panel title="社团负责人备案表">
					<next:Panel>
					<next:Html>
					<fieldset>
						<legend>社会团体信息</legend>
						<form onsubmit="return false" dataset="somSessionDataSet" class="L5form">
							<table width="100%">
								<tr>
									<td class="FieldLabel">届次名称：</td>
									<td class="FieldInput" colspan="3"><label field="sessionName" style="width:90%"/></td>
									<td class="FieldLabel" style="width:17%">本届任期（年）：</td>
									<td class="FieldInput" style="width:17%"><label field="tenure" style="width:90%"/></td>
								</tr>
								<tr>
									<td class="FieldLabel" style="width:17%">本届开始日期：</td>
									<td class="FieldInput" style="width:17%"><label field="startDate" style="width:90%"/></td>
									<td class="FieldLabel" style="width:17%">规定换届日期：</td>
									<td class="FieldInput" style="width:15%"><label field="endDate" style="width:90%"/></td>
									<td class="FieldLabel" style="width:17%"></td>
									<td class="FieldInput" style="width:17%"></td>
								</tr>
							</table>
						</form>
						</fieldset>
					</next:Html>
				</next:Panel>
					<next:EditGridPanel id="peopleGrid" width="100%" stripeRows="true" height="100%" dataset="somDutyDataSet">
						<next:TopBar>
							<next:ToolBarItem symbol="->"></next:ToolBarItem>
							<next:ToolBarItem iconCls="detail" text="查看" handler="detailPeople"></next:ToolBarItem>
						</next:TopBar>
						<next:Columns>
							<next:RowNumberColumn />
							<next:RadioBoxColumn></next:RadioBoxColumn>
							<next:Column header="内码" field="id" width="15%" editable="false" hidden="true"><next:TextField/></next:Column>
							<next:Column header="身份证号" field="idCard" width="20%" editable="false"><next:TextField/></next:Column>
							<next:Column header="姓名" field="name" width="10%" editable="false"><next:TextField/></next:Column>
							<next:Column header="性别" field="sex" width="10%" editable="false"><next:ComboBox dataset="sexSelect"/></next:Column>
							<next:Column header="出生年月" field="birthday" width="10%" editable="false"><next:TextField/></next:Column>
							<next:Column header="担任职务" field="sorgDuties" width="20%" editable="false"><next:ComboBox dataset="sorgDutiesSelect"/></next:Column>
							<next:Column header="是否在任" field="ifServe"width="10%" editable="false"><next:TextField/><next:ComboBox dataset="ifServeSelect"/></next:Column>
							<next:Column header="任职开始日期" field="startDate" width="15%" editable="false"><next:TextField/></next:Column>
							<next:Column header="任职结束日期" field="endDate" width="15%" editable="false"><next:TextField/></next:Column>
						</next:Columns>
						<next:BottomBar>
							<next:PagingToolBar dataset="somDutyDataSet"/>
						</next:BottomBar>
					</next:EditGridPanel>
			</next:Panel>

			<next:Panel title="法律要件">
					<next:EditGridPanel id="uploadGrid" width="100%" stripeRows="true" height="100%" dataset="somElectronicDataSet">
						<next:TopBar>
							<next:ToolBarItem symbol="附件列表"></next:ToolBarItem>
							<next:ToolBarItem symbol="->"></next:ToolBarItem>
						</next:TopBar>

						<next:Columns>
							<next:RowNumberColumn />
							<next:RadioBoxColumn></next:RadioBoxColumn>
							<next:Column header="档案目录名"  field="catalogCode" width="38%" editable="false" dataset="cataLogCodeSelect" ><next:TextField /></next:Column>
							<next:Column header="附件名称"    field="fileName" width="30%" editable="false"><next:TextField /></next:Column>
							<next:Column header="附件描述"    field="fileMess" width="20%" editable="false"><next:TextField /></next:Column>
							<next:Column header="下载附件"    field="" width="10%" editable="false" renderer="clickDownloadHref"><next:TextField /></next:Column>
						</next:Columns>
						<next:BottomBar>
							<next:PagingToolBar dataset="somElectronicDataSet" />
						</next:BottomBar>
				    </next:EditGridPanel>
			</next:Panel>

			<next:Panel title="流程历史意见">
				<next:EditGridPanel id="somFlowGrid" dataset="somFlowDataSet" width="100%" stripeRows="true" height="100%">
					<next:Columns>
						<next:RowNumberColumn/>
						<next:Column header="处理环节" field="activity" width="13%" editable="false"><next:TextField/></next:Column>
						<next:Column header="处理单位" field="organId" width="13%" editable="false"><next:ComboBox dataset="pubOrganDataSet"/></next:Column>
						<next:Column header="处理部门" field="deptId" width="13%" editable="false"><next:ComboBox dataset="pubOrganDataSet"/></next:Column>
						<next:Column header="处理人" field="actorId" width="10%" editable="false"><next:ComboBox dataset="pubOrganDataSet"/></next:Column>
						<next:Column header="处理时间" field="commitTime" width="18%" editable="false"><next:TextField/></next:Column>
						<next:Column header="意见" field="opinionId" width="10%" editable="false"><next:ComboBox dataset="hisOpinionDataSet"/></next:Column>
						<next:Column header="补充意见" field="opinion" width="40%" editable="false"><next:TextField/></next:Column>
					</next:Columns>
					<next:BottomBar>
						<next:PagingToolBar dataset="somFlowDataSet"/>
					</next:BottomBar>
				</next:EditGridPanel>
			</next:Panel>
			<next:Panel title="处理意见" hidden="true" width="1000">
				<next:Html>
					<form method="post" dataset="somApplyDataSet" onsubmit="return false" class="L5form">
					<table width="100%">
						<tr>
							<td class="FieldLabel" style="width:13%">处理意见：</td>
							<td class="FieldInput" colspan="5">
								<select id='curOpinionId'field="curOpinionId" name='"处理意见"' style="width:150px" default="0">
									<option dataset="opinionDataSet"></option>
								</select><span style="color:red">*</span>
							</td>
						</tr>
						<tr id="watchInfo1" style="display:none">
							<td class="FieldLabel" style="width:13%">现场勘查双方参加人员：</td>
							<td class="FieldInput" colspan="5"><input type="text"  id="prospectAttendPeople" name='"现场勘查双方参加人员"' style="width:98%"/></td>
						</tr>
						<tr id="watchInfo2" style="display:none">
							<td class="FieldLabel" style="width:13%">现场勘查地点：</td>
							<td class="FieldInput" colspan="3"><input type="text" id="prospectPlace" name='现场勘查地点'  style="width:90%" /></td>
							<td class="FieldLabel" style="width:13%">现场勘查日期：</td>
							<td class="FieldInput" style="width:17%"><input type="text" id="prospectDate" name='现场勘查日期' format="Y-m-d" onclick="WdatePicker()" style="width:90%" /></td>
						</tr>
						<tr>
							<td class="FieldLabel">处理补充意见：</td>
							<td class="FieldInput" colspan="5"><textarea rows="10" name='"处理补充意见"' field="curOpinion" style="width:98%"></textarea></td>
						</tr>
					</table>
					</form>
				</next:Html>
			</next:Panel>
		</next:Tabs>
	</next:TabPanel>
</next:Panel>
</next:ViewPort>
<!-- 负责人信息窗口 -->
<next:Window id="peopleWin" title="主要负责人" resizable="false" width="800" height="430" closeAction="hide" modal="true">
	<next:TabPanel id="peoplePanel1">
		<next:Tabs>
			<next:Panel id="panel_win" title="基本信息" autoScroll="true" width="770" height="85%">
				<next:Html>
					<form title="负责人信息" id="addForm" method="post" dataset="somDutyInsertDataSet" onsubmit="return false" class="L5form">
						<table width="100%">
							<tr>
								<td class="FieldLabel" style="width:15%">身份证号码：</td>
								<td class="FieldInput" style="width:21%"><label  field="idCard"/></td>
								<td class="FieldLabel" style="width:14%">姓名：</td>
								<td class="FieldInput" style="width:17%"><label  field="name"/></td>
								<td class="FieldLabel" style="width:14%">曾用名：</td>
								<td class="FieldInput" style="width:19%"><label  field="aliasName"/></td>
							</tr>
							<tr>
								<td class="FieldLabel">性别：</td>
								<td class="FieldInput"><label  field="sex" dataset="sexSelect"/></td>
								<td class="FieldLabel">出生年月：</td>
								<td class="FieldInput"><label  field="birthday"/></td>
								<td class="FieldLabel">年龄：</td>
								<td class="FieldInput"><label id="peopleAge" name='年龄'/></td>
							</tr>
							<tr>
								<td class="FieldLabel">政治面貌：</td>
								<td class="FieldInput"><label  field="politics" dataset="politicsSelect"/></td>
								<td class="FieldLabel">民族：</td>
								<td class="FieldInput" colspan="3"><label  field="folk" dataset="folkSelect"/></td>
							</tr>
							<tr>
								<td class="FieldLabel">家庭住址：</td>
								<td class="FieldInput" colspan="3"><label  field="adds"/></td>
								<td class="FieldLabel">户口所在地：</td>
								<td class="FieldInput"><label  field="populace"/></td>
							</tr>
							<tr>
								<td class="FieldLabel">邮编：</td>
								<td class="FieldInput"><label  field="postCode"/></td>
								<td class="FieldLabel">电话：</td>
								<td class="FieldInput"><label  field="phone"/></td>
								<td class="FieldLabel">专/兼职：</td>
								<td class="FieldInput"><label  field="ifFulltime" dataset="ifFulltimeSelect"/></td>
							</tr>
							<tr>
								<td class="FieldLabel">工作单位：</td>
								<td class="FieldInput" colspan="3"><label  field="workName"/></td>
								<td class="FieldLabel">工作单位职务：</td>
								<td class="FieldInput"><label  field="workDuties"/></td>
							</tr>
							<tr>
								<td class="FieldLabel">社团职务：</td>
								<td class="FieldInput"><label  field="sorgDuties" dataset="sorgDutiesSelect"/></td>
								<td class="FieldLabel">任职开始日期：</td>
								<td class="FieldInput"><label  field="startDate"/></td>
								<td class="FieldLabel">任职结束日期：</td>
								<td class="FieldInput"><label  field="endDate"/></td>
							</tr>
							<tr>
								<td class="FieldLabel">是否党政机关领导干部：</td>
								<td class="FieldInput"><label  field="ifPartyLeader" dataset="comm_yesorno" /></td>
								<td class="FieldLabel">批准机关：</td>
								<td class="FieldInput"><label  field="promiseOrgan"/></td>
								<td class="FieldLabel">批准文号：</td>
								<td class="FieldInput"><label  field="promiseCode"/></td>
							</tr>
							<tr>
								<td class="FieldLabel">其他社会职务：</td>
								<td class="FieldInput" colspan="5"><textarea rows="3" field="otherDuties" readonly="readonly" name='"其他社会职务"' style="width:98%;background-color:#F5FAFA;border:0;overflow:auto;"></textarea></td>
							</tr>
							<tr>
								<td class="FieldLabel">本人所在单位人事部门审查意见：</td>
								<td class="FieldInput" colspan="5"><textarea rows="2" name='"所在单位人事部门审查意见"' readonly="readonly" field="workOpinion" style="width:98%;background-color:#F5FAFA;border:0;overflow:auto;" ></textarea></td>
							</tr>
							<tr>
								<td class="FieldLabel">审查工作单位：</td>
								<td class="FieldInput" colspan="3"><label  field="workName"/></td>
								<td class="FieldLabel">审查日期：</td>
								<td class="FieldInput"><label  field="workCheckDate"/></td>
							</tr>
							<tr>
								<td class="FieldLabel">备注：</td>
								<td class="FieldInput" colspan="5"><textarea rows="2" name='"备注"' field="note" style="width:98%;background-color:#F5FAFA;border:0;overflow:auto;" readonly="readonly"></textarea></td>
							</tr>
						</table>
					</form>
				</next:Html>
			</next:Panel>
			<next:EditGridPanel id="somResumeGrid" dataset="somResumeInsertDataSet" stripeRows="true" title="本人简历" width="770" height="85%" autoScroll="true">
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
					<next:PagingToolBar dataset="somResumeInsertDataSet"/>
				</next:BottomBar>
			</next:EditGridPanel>
			<next:EditGridPanel id="uploadPeopleGrid" title="法律要件" stripeRows="true" dataset="somPeopleElectronicDataSet" width="770" height="85%" autoScroll="true">
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
	<next:Buttons>
		<next:ToolButton text="关闭" handler="winClosePeople"></next:ToolButton>
	</next:Buttons>
</next:Window>
<next:Window id="forchoseIssuePeople" closeAction="hide" title="填写领证信息" width="500"  autoScroll="true" modal="true">
	<next:TopBar>
		<next:ToolBarItem symbol="填写领证信息"></next:ToolBarItem>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="确定" iconCls="detail" handler="buttonForFetch"></next:ToolBarItem>
		<next:ToolBarItem text="关闭" iconCls="return" handler="closeForFetch"></next:ToolBarItem>
	</next:TopBar>
	<next:Html>
		<form method="post" onsubmit="return false" class="L5form">
			<table width="100%">
				<tr>
					<td class="FieldLabel" style="width:15%"><label>领证人：</label></td>
					<td class="FieldInput"style="width:15%"><input type="text" id="fetchPeople"/></td>
					<td class="FieldLabel" style="width:15%"><label>领证日期：</label></td>
					<td class="FieldInput"style="width:15%"><input type="text" id="fetchDate"  style="width:100%" format="Y-m-d" onclick="WdatePicker()" ></td>
				</tr>
				<tr>
					<td class="FieldLabel" style="width:15%"><label>领证人联系电话：</label></td>
					<td class="FieldInput"style="width:15%" colspan="3"><input type="text" id="fetchPhone"/></td>
				</tr>
			</table>
		</form>
	</next:Html>
</next:Window>
<next:Window id="forPrint" closeAction="hide" title="打印证书" width="500"  autoScroll="true" modal="true">
<next:TopBar>
		<next:ToolBarItem text='' id="displayItem" />
		<next:ToolBarItem symbol="打印证书"></next:ToolBarItem>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="确定" iconCls="detail" handler="forCertType"></next:ToolBarItem>
		<next:ToolBarItem text="关闭" iconCls="return" handler="winCloseCert"></next:ToolBarItem>
	</next:TopBar>
	<next:Html>
		<form method="post" onsubmit="return false" class="L5form">
			<table width="100%">
				<tr>
					<td class="FieldLabel" style="width:15%"><label>分支（代表）机构登记证号：</label></td>
					<td class="FieldInput"style="width:15%"><input id="branchSorgCode" name="分支（代表）机构登记证号" style="width:100%" onblur='sorgCodeUK()'/></td>
					<td class="FieldLabel" style="width:15%"><label>选择证书类型：</label></td>
					<td class="FieldInput"style="width:15%"><select id="certType" ><option dataset="certTypeSelect" ></option></select></td>
				</tr>
				<tr>
					<td class="FieldLabel" style="width:15%"><label>活动地域：</label></td>
					<td class="FieldInput"style="width:15%"><input id="actArea" name="活动地域" style="width:100%" maxlength="25"/></td>
					<td class="FieldLabel" style="width:15%"><label>发证日期：</label></td>
					<td class="FieldInput"style="width:15%"><input type="text" id="PrintDate"  style="width:100%" format="Y-m-d" onclick="WdatePicker()" ></td>
				</tr>
				<tr>
					<td class="FieldLabel" style="width:15%"><label>有效期限起：</label></td>
					<td class="FieldInput"style="width:15%"><input type="text" id="beginDate"  style="width:100%" format="Y-m-d" onclick="WdatePicker()" ></td>
					<td class="FieldLabel" style="width:15%"><label>有效期限止：</label></td>
					<td class="FieldInput"style="width:15%"><input type="text" id="endDate"  style="width:100%" format="Y-m-d" onclick="WdatePicker()" ></td>
				</tr>
				<tr>
					<td class="FieldLabel" style="width:15%"><label>业务范围：</label></td>
					<td class="FieldInput" style="width:15%" colspan="3"><textarea  rows="3" id="business"  style="width:100%" ></textarea></td>
				</tr>
				<tr>
					<td class="FieldLabel" style="width:15%"><label>发证原因描述：</label></td>
					<td class="FieldInput" style="width:15%" colspan="3"><textarea  rows="2" id="issueReasonDesc"  style="width:100%" ></textarea></td>
				</tr>

			</table>
		</form>
	</next:Html>
</next:Window>
<jsp:include page="../../../comm/upload/uploadWindow.jsp" flush="true"/>
</body>
</html>
<script language="javascript">
function returnBack(){
	history.go(-1);
}
</script>