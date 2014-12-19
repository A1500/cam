<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="com.inspur.cams.comm.util.StrUtil,org.loushang.next.skin.SkinUtils,com.inspur.cams.sorg.util.SomIdHelp"%>
<%@ page import="org.loushang.bsp.security.context.GetBspInfo"%>
<%@ taglib uri="/tags/next-web" prefix="next" %>
<%@ taglib uri="/tags/next-model" prefix="model" %>
<html>
<head>
<title>基金会设立登记预受理</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="fundBuildPre.js"></script>
<script type="text/javascript" src="<%=SkinUtils.getJS(request, "bpm/bpm.js")%>"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js") %>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams/sorgUpload.js")%>'></script>
<script type="text/javascript">var rootPath='<%=SkinUtils.getRootUrl(request)%>';</script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams/somPhoto.js") %>'></script>
<script type="text/javascript" src="<%=SkinUtils.getRootUrl(request)%>skins/js/ISEditPhoto.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"My97DatePicker/WdatePicker.js") %>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams/sorgOnline.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"My97DatePicker/WdatePicker.js") %>'></script>
<script type="text/javascript">
	var somApplyType = "201";
	var applyType="220";
	var updateRecord="";
	var rootPath="<%=SkinUtils.getRootUrl(request)%>";
	var currentUserName = '<%= GetBspInfo.getBspInfo().getUserName()%>';
	var sorgId="";
	var method='<%=request.getParameter("method")%>';
	var taskCode='<%=request.getParameter("taskCode")%>';
	var cnName='';
</script>
</head>
<body>
<%--定义dataset--%>
<model:datasets>
	<!-- 退回所用dataset -->
	<model:dataset id="undoDataSet" cmd="com.inspur.cams.sorg.online.base.cmd.SomApplyOnlineQueryCommand" method="queryHasAcceptStatus"  global="true" sortField="createTime" sortDirection="DESC">
		<model:record fromBean="com.inspur.cams.sorg.online.base.data.SomApplyOnline"></model:record>
	</model:dataset>
	<!-- 更改业务状态所用dataset -->
	<model:dataset id="updateStatusDataSet" cmd="com.inspur.cams.sorg.online.base.cmd.SomApplyOnlineQueryCommand"  global="true" sortField="createTime" sortDirection="DESC">
		<model:record fromBean="com.inspur.cams.sorg.online.base.data.SomApplyOnline"></model:record>
	</model:dataset>

	<model:dataset id="somOrganDataSet" cmd="com.inspur.cams.sorg.online.base.cmd.SomOrganOnlineQueryCommand" global="true" >
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomOrgan">
			<%--基金会基本信息验证 --%>
			<model:field name="appReason" type="string" rule="length{500}" />
			<model:field name="borgName" type="string" rule="require" />
			<model:field name="cnName" type="string" rule="require|length{100}" />
			<model:field name="residence" type="string" rule="require|length{100}" />
			<model:field name="purpose" type="string" rule="require|length{1000}" />
			<model:field name="business" type="string" rule="require|length{1000}" />
			<model:field name="sorgKind" type="string" rule="require" />
			<model:field name="currency" type="string" rule="length{50}" />
			<model:field name="regMon" type="string" rule="double|require|length{14}" />
			<model:field name="moneySource" type="string" rule="length{500}" />
		</model:record>
	</model:dataset>
	<model:dataset id="somOrganDataSetQuery" cmd="com.inspur.cams.sorg.base.cmd.SomOrganQueryCmd"  global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomOrgan">
		</model:record>
	</model:dataset>
	<!-- 发起人 -->
	<model:dataset id="somHeldPeopleDataSet" cmd="com.inspur.cams.sorg.online.base.cmd.SomHeldPeopleOnlineQueryCommand" pageSize="100" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomHeldPeople">
			<model:field name="ifChief" type="string" rule="" />
			<model:field name="name" type="string" rule="require|length{72}" />
			<model:field name="birthday" type="string" rule="length{10}" />
			<model:field name="workName" type="string" rule="length{100}" />
			<model:field name="workDuties" type="string" rule="length{100}" />
		</model:record>
	</model:dataset>
	<!-- 届次信息 -->
	<model:dataset id="somSessionDataSet" cmd="com.inspur.cams.sorg.online.base.cmd.SomSessionOnlineQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomSession">
			<model:field name="tenure" type="string" rule="integer|length{2}" />
			<model:field name="sessionName" type="string" rule="length{100}"/>
		</model:record>
	</model:dataset>
	<!-- 监事备案 -->
	<model:dataset id="aspForJianShi" cmd="com.inspur.cams.sorg.online.base.cmd.SomAspchiefOnlineQueryCommand" pageSize="100" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomAspchief">
			<model:field name="name" type="string" rule="require|length{72}" />
			<model:field name="sorgDuties" type="string" rule="require" />
			<model:field name="populace" type="string" rule="length{100}" />
			<model:field name="workOpinion" type="string" rule="length{200}" />
			<model:field name="citizenship" type="string" rule="length{100}" />
			<model:field name="otherDuties" type="string" rule="length{500}" />
			<model:field name="idCard" type="string" rule="length{18}" />
		</model:record>
	</model:dataset>
	<!-- 理事备案 -->
	<model:dataset id="aspForLiShi" cmd="com.inspur.cams.sorg.online.base.cmd.SomAspchiefOnlineQueryCommand" pageSize="100" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomAspchief">
			<model:field name="name" type="string" rule="require|length{72}" />
			<model:field name="sorgDuties" type="string" rule="require" />
			<model:field name="populace" type="string" rule="length{100}" />
			<model:field name="workOpinion" type="string" rule="length{200}" />
			<model:field name="citizenship" type="string" rule="length{100}" />
			<model:field name="otherDuties" type="string" rule="length{500}" />
			<model:field name="idCard" type="string" rule="length{18}" />
		</model:record>
	</model:dataset>
	<!-- 理事备案 -->
	<model:dataset id="peopleInsertDataset" cmd="com.inspur.cams.sorg.online.base.cmd.SomAspchiefOnlineQueryCommand" pageSize="100" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomAspchief">
			<model:field name="name" type="string" rule="require|length{72}" />
			<model:field name="sorgDuties" type="string" rule="require" />
			<model:field name="populace" type="string" rule="length{100}" />
			<model:field name="workOpinion" type="string" rule="length{200}" />
			<model:field name="citizenship" type="string" rule="length{100}" />
			<model:field name="otherDuties" type="string" rule="length{500}" />
			<model:field name="idCard" type="string" rule="length{18}" />
		</model:record>
	</model:dataset>
	<model:dataset id="aspChiefDataset" cmd="com.inspur.cams.sorg.online.base.cmd.SomAspchiefOnlineQueryCommand" pageSize="100" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomAspchief">
			<model:field name="name" type="string" rule="require|length{72}" />
			<model:field name="workDuties" type="string" rule="length{50}" />
			<model:field name="workName" type="string" rule="length{100}" />
			<model:field name="otherDuties" type="string" rule="length{500}" />
		</model:record>
	</model:dataset>
	<!-- 人员简历 -->
	<model:dataset id="somResumeInsertDataSet" cmd="com.inspur.cams.sorg.online.base.cmd.SomPeopleResumeOnlineQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomPeopleResume">
			<model:field name="workOrgan" type="string" rule="length{200}" />
			<model:field name="duty" type="string" rule="length{100}" />
		</model:record>
	</model:dataset>
	<!-- 发起组织 -->
	<model:dataset id="somHeldOrganDataSet" cmd="com.inspur.cams.sorg.online.base.cmd.SomHeldOrganOnlineQueryCommand" pageSize="100" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomHeldOrgan">
			<model:field name="name" type="string" rule="require|length{100}" />
			<model:field name="heldorganPeople" type="string" rule="length{72}" />
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
	<%--业务意见--%>
	<model:dataset id="somApplyDataSet" cmd="com.inspur.cams.sorg.online.base.cmd.SomApplyOnlineQueryCommand"  global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomApply">
		<%--业务意见信息验证--%>
		<model:field name="curOpinionId" type="string" rule="require"/>
		  <model:field name="curOpinion" type="string" rule="length{200}"/>
		  <model:field name="borgOpinion" type="string" rule="length{100}"/>
		</model:record>
	</model:dataset>
	<%--历史意见 --%>
	<model:dataset id="somFlowDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomFlowQueryCmd" global="true" sortField="COMMIT_TIME" pageSize="100">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomFlow"></model:record>
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
	<!-- 社会组织职务 -->
	<model:dataset id="sorgDutiesDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_SOM_DUTY'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
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
			<model:param name="dic" value='DIC_FUND_KIND'></model:param>
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
	<!-- 政治面貌 -->
	<model:dataset id="politicsDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_POLITICAL'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 专兼职 -->
	<model:dataset id="ifFulltimeDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_IF_FULLTIME'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 民族 -->
	<model:dataset id="folkDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_NATION'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 证件类型 -->
	<model:dataset id="cardTypeDS" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_CARD_TYPE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="somMeetingDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomMeetingQueryCmd" method="qurtyWithBeianInfo" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomMeeting"/>
	</model:dataset>
	<model:dataset id="somSessionQueryDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomSessionQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomSession"></model:record>
	</model:dataset>
	<model:dataset id="pubOrganDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='PUB_ORGAN'></model:param>
			<model:param name="value" value='ORGAN_ID'></model:param>
			<model:param name="text" value='ORGAN_NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="sexDataSet" enumName="COMM.SEX" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="comm_yesorno" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="opinionSelect" enumName="WORKFLOW.OPINION" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="hisOpinionDataSet" enumName="WORKFLOW.OPINION" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="yesornoDataSet" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
</model:datasets>
<%--定义界面--%>
<next:Panel width="100%" height="100%">
	<next:TopBar>
		<next:ToolBarItem symbol="基金会设立登记"></next:ToolBarItem>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="undo" text="退回" handler="updateOnlineStatusAndSeason"></next:ToolBarItem>
		<next:ToolBarItem iconCls="print" text="打印受理通知书" handler="printAccept"></next:ToolBarItem>
		<next:ToolBarItem iconCls="print" text="打印不予受理通知书" handler="printNoAccept"></next:ToolBarItem>
		<next:ToolBarItem iconCls="edit" text="名称变更" handler="changeName"></next:ToolBarItem>
		<next:ToolBarItem iconCls="save" text="保存" handler="save"></next:ToolBarItem>
		<next:ToolBarItem iconCls="select" text="提交" handler="submit"></next:ToolBarItem>
		<next:ToolBarItem iconCls="return" text="返回" handler="returnClick"></next:ToolBarItem>
	</next:TopBar>
	<next:TabPanel width="100%" height="100%" id="tab">
		<next:Tabs>
			<next:Panel title="基金会设立申请表" width="100%">
				<next:Panel width="100%" height="100%" id="tab1" autoScroll="true">
					<next:Html>
						<form method="post" dataset="somOrganDataSet"
							onsubmit="return false" class="L5form">
						<fieldset><legend>基金会设立申请表</legend>
						<table width="100%">
							<tr>
								<td class="FieldLabel" style="width: 17%">名称：</td>
								<td class="FieldInput" colspan="3">
								<input type="text" field="cnName" id="sorgName" name='"基金会名称"' style="width:90%" onblur="fillOrganInfo(this.value);"/>
								<span style="color: red">*</span></td>
							</tr>
							<tr>
								<td class="FieldLabel" style="width: 17%">住所：</td>
								<td class="FieldInput" colspan="3"><input type="text"
									name='住所' field="residence" style="width: 97%" /><span
									style="color: red">*</span></td>
							</tr>
							<tr>
								<td class="FieldLabel" style="width: 17%">电话：</td>
								<td class="FieldInput" style="width: 17%"><input
									type="text" name='电话' id='sorgPhone'field="sorgPhone"
									 style="width: 90%" /></td>
								<td class="FieldLabel" style="width: 17%">邮编：</td>
								<td class="FieldInput" style="width: 17%"><input
									type="text" name='邮编'id='sorgPost' field="sorgPost"
									style="width: 90%" /></td>
							</tr>
							<tr>
								<td class="FieldLabel">原始基金币种：</td>
								<td class="FieldInput"><input
									type="text" id="currency" name='原始基金币种' field="currency"
									style="width: 90%" /></td>
								<td class="FieldLabel">类型：</td>
								<td class="FieldInput"><select id="sorgKind"
									field="sorgKind" name='基金会类型'>
									<option dataset="sorgKindSelect"></option>
								</select><span style="color: red">*</span></td>

							</tr>
							<tr>
							<td class="FieldLabel">原始基金数额：</td>
							<td class="FieldInput" colspan="3"><textarea rows="3" field="regMon" name='"原始基金数额"' style="width:85%"></textarea>万元</td>
						</tr>
							<tr>
								<td class="FieldLabel">宗旨(20字以内)：</td>
								<td class="FieldInput" colspan="3"><textarea rows="5"
									name="宗旨" field="purpose" style="width: 97%"></textarea><span
									style="color: red">*</span></td>
							</tr>
							<tr>
								<td class="FieldLabel">业务范围：</td>
								<td class="FieldInput" colspan="3"><textarea rows="5"
									name="业务范围" field="business" style="width: 97%"></textarea><span
									style="color: red">*</span></td>
							</tr>
							<tr>
								<td class="FieldLabel">申请理由：</td>
								<td class="FieldInput" colspan="3"><textarea rows="5"
									name="申请理由" field="appReason" style="width: 97%"></textarea></td>
							</tr>
						</table>
						</fieldset>
						</form>
						<form id="form2" method="post" dataset="somApplyDataSet"
							onsubmit="return false" class="L5form">
						<fieldset><legend>业务主管单位审查意见</legend>
						<table width="100%">
							<tr>
								<td class="FieldLabel" style="width: 17%">业务主管单位审查意见：</td>
								<td class="FieldInput" colspan="3"><textarea
									field="borgOpinion" cols="65" rows="2" style="width: 97%"></textarea></td>
							</tr>
							<tr>
								<td class="FieldLabel" style="width: 17%">业务主管单位：</td>
								<td class="FieldInput" style="width: 17%">
								<input type="text" id="borgNameDispaly" name="borgNameDispaly"  title="业务主管单位"  onkeyup="findDiv(this,'borgName','popup','','businessOrganAuto','BORG_NAME@like','borgCode','borgName','35')" onblur="clearDiv()" onchange="clearBorg(this)"/><img src="<%=SkinUtils.getImage(request,"l5/help.gif")%>" style="cursor:hand" onclick="showBorgWin()"/>
								<div id="popup" style="width:300px; height: 150px; display: none;position: absolute;background-color: #FFFFFF;" >
 	        						<ul></ul>
     							</div>
     							<input type="hidden" id="borgName" name="borgName" field="borgName" title="业务主管单位代码"/>
								<span style="color:red">*</span></td>

								<td class="FieldLabel" style="width: 17%">业务主管单位审查日期：</td>
								<td class="FieldInput" style="width: 17%"><input
									type="text" field="borgCheckDate"
									onclick="WdatePicker()" style="width: 90%"></td>
							</tr>
						</table>
						</fieldset>
						</form>
					<form method="post" dataset="aspChiefDataset" onsubmit="return false" class="L5form" style="border-width:0px">
						<fieldset>
					<legend>拟任法定代表人情况</legend>
					<table width="100%">
						<tr>
							<td class="FieldLabel" style="width:20%">姓名：</td>
							<td class="FieldInput" style="width:13%"><input type="text" name='"拟任法定代表人姓名"' field="name" style="width:90%"/><span style="color: red">*</span></td>
							<td class="FieldLabel" style="width:20%">性别：</td>
							<td class="FieldInput" style="width:13%"><select field="sex"><option dataset="sexDataSet"></option></select></td>
							<td class="FieldLabel" style="width:20%">出生年月：</td>
							<td class="FieldInput" style="width:13%"><input type="text" name='出生年月' field="birthday" format="Y-m" onclick="WdatePicker()" style="width:90%"/></td>
						</tr>
						<tr>
							<td class="FieldLabel" >工作单位：</td>
							<td class="FieldInput" colspan="3"><input type="text" name='"工作单位"' field="workName" style="width:90%"/></td>
							<td class="FieldLabel" style="width:20%" >工作单位职务：</td>
							<td class="FieldInput" style="width:13%"><input type="text"  name='"工作单位职务"' field="workDuties" style="width:90%"/></td>
						</tr>
						<tr>
							<td class="FieldLabel" style="width:20%">联系电话：</td>
							<td class="FieldInput" colspan="3"><input type="text" name='"联系电话"' id='phone'field="phone" style="width:90%"/></td>
							<td class="FieldLabel" style="width:20%">有无担任其他组织法人：</td>
							<td class="FieldInput" style="width:13%"><input type="text" name='"有无担任其他组织法人"' field="otherDuties" style="width:90%"/></td>
						</tr>
					</table>
					</fieldset>
					</form>
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
				</next:EditGridPanel>
			</next:Panel>
	<next:Panel title="基金会理事、监事备案申请表" autoScroll="true">
	<next:Panel>
	<next:Html>
	<fieldset>
		<legend>基金会信息</legend>
		<form onsubmit="return false" class="L5form" dataset="somSessionDataSet">
			<table width="100%">
				<tr>
					<td class="FieldLabel">届次名称：</td>
					<td class="FieldInput" colspan="3"><input type="text" id="sessionName"   field="sessionName" style="width:97%"/></td>
					<td class="FieldLabel" style="width:17%">本届任期（年）：</td>
					<td class="FieldInput" style="width:17%"><input type="text" id="tenure" field="tenure" style="width:90%"/></td>
				</tr>
				<tr>
					<td class="FieldLabel" style="width:17%">本届开始日期：</td>
					<td class="FieldInput" style="width:17%"><input type="text" id="startDate" field="startDate"onclick="WdatePicker()" style="width:90%"/></td>
					<td class="FieldLabel" style="width:17%">规定换届日期：</td>
					<td class="FieldInput" style="width:15%"><input type="text" id="endDate" field="endDate"onclick="WdatePicker()" readonly="readonly" style="width:90%"/></td>
					<td class="FieldLabel" style="width:17%"></td>
					<td class="FieldInput" style="width:17%"></td>
				</tr>
			</table>
		</form>
		</fieldset>
	</next:Html>
</next:Panel>
<next:Panel height="300" >
<next:EditGridPanel id="peopleGrid" dataset="aspForLiShi"  stripeRows="true" height="99.9%" hasSum="true" title="理事备案申请表">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="add" text="新增" handler="addL"></next:ToolBarItem>
		<next:ToolBarItem iconCls="edit" text="修改" handler="updateL"></next:ToolBarItem>
		<next:ToolBarItem iconCls="delete" text="删除" handler="delL"></next:ToolBarItem>
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn/>
		<next:RadioBoxColumn></next:RadioBoxColumn>
		<next:Column header="证件类型" field="cardType" width="10%" editable="false" summaryType="count">
			<next:ExtendConfig>
				summaryRenderer : countRender
			</next:ExtendConfig>
		<next:ComboBox dataset="cardTypeDS"/></next:Column>
		<next:Column header="证件编号" field="idCard" width="20%" editable="false"><next:TextField/></next:Column>
		<next:Column header="姓名" field="name" width="10%" editable="false"><next:TextField/></next:Column>
		<next:Column header="性别" field="sex" width="10%" editable="false"><next:ComboBox dataset="sexSelect"/></next:Column>
		<next:Column header="出生年月" field="birthday" width="10%" editable="false"><next:TextField/></next:Column>
		<next:Column header="拟任职务" field="sorgDuties" width="10%" editable="false"><next:ComboBox dataset="dutySelectDic"/></next:Column>
		<next:Column header="是否是拟任法定代表人" field="ifLegal" width="15%" editable="false"><next:ComboBox dataset="yesornoDataSet"></next:ComboBox></next:Column>
	</next:Columns>
</next:EditGridPanel>
</next:Panel>
<next:Panel height="250" >
<next:EditGridPanel id="peopleGrid1" dataset="aspForJianShi"  stripeRows="true" hasSum="true" height="99.9%" title="监事备案申请表">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="add" text="新增" handler="addS"></next:ToolBarItem>
		<next:ToolBarItem iconCls="edit" text="修改" handler="updateS"></next:ToolBarItem>
		<next:ToolBarItem iconCls="delete" text="删除" handler="delS"></next:ToolBarItem>
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn/>
		<next:RadioBoxColumn></next:RadioBoxColumn>
		<next:Column header="证件类型" field="cardType" width="10%" editable="false" summaryType="count">
			<next:ExtendConfig>
				summaryRenderer : countRenderS
			</next:ExtendConfig>
		<next:ComboBox dataset="cardTypeDS"/></next:Column>
		<next:Column header="证件编号" field="idCard" width="20%" editable="false"><next:TextField/></next:Column>
		<next:Column header="姓名" field="name" width="10%" editable="false"><next:TextField/></next:Column>
		<next:Column header="性别" field="sex" width="10%" editable="false"><next:ComboBox dataset="sexSelect"/></next:Column>
		<next:Column header="出生年月" field="birthday" width="10%" editable="false"><next:TextField/></next:Column>
		<next:Column header="拟任职务" field="sorgDuties" width="10%" editable="false"><next:ComboBox dataset="dutySelectDic"/></next:Column>
	</next:Columns>
</next:EditGridPanel>
</next:Panel>
			</next:Panel>
			<next:Panel title="法律要件" >
				<next:EditGridPanel id="uploadGrid" width="100%" stripeRows="true" height="100%" dataset="somElectronicDataSet">
					<next:GroupingView forceFit="true"></next:GroupingView>
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
			<next:Panel title="处理意见" width="100%" >
					<next:Html>
					<form method="post" onsubmit="return false" class="L5form" dataset="somApplyDataSet">
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
					</form>
					</next:Html>
			</next:Panel>
		</next:Tabs>
	</next:TabPanel>
</next:Panel>

<next:Window id="peopleWin"title="人员备案表"resizable="false" width="800" height="400" modal="true" closeAction="hide" autoScroll="true">
	<next:TopBar>
		<next:ToolBarItem text='' id="displayItem" />
		<next:ToolBarItem symbol="人员备案表"></next:ToolBarItem>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
	</next:TopBar>
	<next:Panel id="peoplePanel">
		<next:Html>
			<form id="peopleFrom" method="post" dataset="peopleInsertDataset" onsubmit="return false" class="L5form">

				<table width="100%">
					<tr>
						<td class="FieldLabel" style="width:15%">姓名：</td>
						<td class="FieldInput"  style="width:15%"><input type="text" id="name" field="name" name='"姓名"' style="width:90%"/><span style="color: red">*</span></td>
						<td class="FieldLabel" style="width:15%">性别：</td>
						<td class="FieldInput" style="width:15%">
							<select id="sex" field="sex" name='"性别"' style="width:90%">
								<option dataset="sexSelect"></option>
							</select>
						</td>
						<td class="FieldLabel" style="width:15%">出生年月：</td>
						<td class="FieldInput" style="width:15%"><input type="text" id="birthday" field="birthday" name='出生年月' format="Y-m" onclick="WdatePicker()" style="width:90%"/></td>
					</tr>
					<tr>
						<td class="FieldLabel">政治面貌：</td>
						<td class="FieldInput">
							<select field="politics" name='"政治面貌"' style="width:90%">
								<option dataset="politicsDataSet"></option>
							</select>
						</td>
						<td class="FieldLabel" style="width:15%">民族：</td>
						<td class="FieldInput" style="width:15%">
							<select field="folk" name='民族' style="width:90%">
								<option dataset="folkDataSet"></option>
							</select>
						</td>
						<td class="FieldLabel">国籍：</td>
						<td class="FieldInput">
							<input type="text" id="nationDispaly" name="countryNameDispaly"  title="国籍"  onkeyup="findDiv(this,'nation','countryDiv','','countryQueryDic','text@like','value','text','35')" onblur="clearCountryDiv()" onchange="clearCountry(this)"/><img src="<%=SkinUtils.getImage(request,"l5/help.gif")%>" style="cursor:hand" onclick="showCountryWin()"/>
							<div id="countryDiv" style="width:300px; height: 150px; display: none;position: absolute;background-color: #FFFFFF;" >
      								<ul></ul>
 									</div>
 									<input type="hidden" id="nation" name="nation" field="citizenship" title="国籍"/>
						</td>
					</tr>
					<tr>
						<td class="FieldLabel">证件类型：</td>
						<td class="FieldInput">
							<select field="cardType" name='证件类型' style="width:90%">
								<option dataset="cardTypeDS"></option>
							</select>
						</td>
						<td class="FieldLabel" style="width:15%">证件编号：</td>
						<td class="FieldInput" style="width:21%"colspan="3"><input type="text" field="idCard" name='证件编号'style="width:90%"/></td>
					</tr>
					<tr>
						<td class="FieldLabel">邮编：</td>
						<td class="FieldInput"><input type="text" id="postCode" field="postCode" name='"邮编"' maxlength="6" style="width:90%"/></td>
						<td class="FieldLabel">家庭住址：</td>
						<td class="FieldInput"colspan="3"><input type="text" field="populace" name='"家庭住址"' style="width:90%"/></td>
					</tr>
					<tr>
						<td class="FieldLabel">拟任职务：</td>
						<td class="FieldInput">
										<input type="text" id="sorgDutiesNameDispaly" style="width:60%" name="sorgDutiesNameDispaly"  title="社团职务"  onkeyup="findDiv(this,'sorgDuties','dutyPopup','','dutyQueryDic','text@like','value','text','70')" onblur="cleardutyDiv()" onchange="clearduty(this)"/><img src="<%=SkinUtils.getImage(request,"l5/help.gif")%>" style="cursor:hand" onclick="showdutyWin()"/>
										<div id="dutyPopup" style="width:300px; height: 150px; display: none;position: absolute;background-color: #FFFFFF;" >
 	        								<ul></ul>
     									</div>
     							<input type="hidden" id="sorgDuties" name="sorgDuties" field="sorgDuties" title="社团职务代码"/>
     							<span style="color:red">*</span></td>
						<td class="FieldLabel" id="ifLegalLabel">是否是拟任法定代表人：</td>
						<td class="FieldInput" id="ifLegalInput">
							<select field="ifLegal" name='是否是拟任法定代表人'>
								<option dataset="comm_yesorno"></option>
							</select>
						</td>
						<td class="FieldLabel">专职/兼职：</td>
						<td class="FieldInput"  id="ifFulltime">
							<select field="ifFulltime" name='专职/兼职'>
								<option dataset="ifFulltimeDataSet"></option>
							</select>
						</td>
					</tr>
					<tr>
						<td class="FieldLabel">联系电话：</td>
						<td class="FieldInput"><input type="text" id="phone" field="phone" name='"联系电话"' style="width:90%"/></td>
						<td class="FieldLabel">其他社会职务：</td>
						<td class="FieldInput" colspan="3"><input type="text" field="otherDuties" name='"其他社会职务"' style="width:90%"/></td>
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
			<next:Column header="开始年月" field="startDate" width="10%" editable="true" ><next:TextField/></next:Column>
			<next:Column header="结束年月" field="endDate" width="10%" editable="true"><next:TextField/></next:Column>
			<next:Column header="在何地区何单位" field="workOrgan" width="45%" editable="true"><next:TextField/></next:Column>
			<next:Column header="任（兼）何职" field="duty" width="20%" editable="true"><next:TextField/></next:Column>
		</next:Columns>
		<next:BottomBar>
			<next:PagingToolBar dataset="somResumeInsertDataSet"/>
		</next:BottomBar>
	</next:EditGridPanel>
	<next:Buttons>
		<next:ToolButton text="确定" handler="confirm"></next:ToolButton>
		<next:ToolButton text="关闭" handler="closePeopleWIn"></next:ToolButton>
	</next:Buttons>
</next:Window>
<next:Window id="changeName" closeAction="hide" title="名称变更" height="160" width="450" modal="true">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem iconCls="save" text="确定" handler="confirmWin"></next:ToolBarItem>
		<next:ToolBarItem iconCls="return" text="关闭" handler="closeWin"></next:ToolBarItem>
	</next:TopBar>
	<next:Html>
		<form id="form_content2" onsubmit="return false" style="padding: 5px;" class="L5form">
		<table border="1"  width="100%" >
			<tr>
				<td class="FieldLabel" style="width:20%">变更前名称：</td>
				<td class="FieldInput" style="width:80%"><input type="text" id="oldName"  style="width:95%" disabled="disabled" readonly="readonly"/></td>
			</tr>
			<tr>
				<td class="FieldLabel" style="width:20%">变更后名称：</td>
				<td class="FieldInput" style="width:80%"><input type="text" id="newName"  style="width:95%"/></td>
    		</tr>

		</table>
		</form>
   </next:Html>
</next:Window>
<next:Window id="meetingWindow" title="成立召开会议信息" closeAction="hide" height="400" width="740" modal="true">
	<next:EditGridPanel id="meetingGrid" width="727" stripeRows="true" height="369" dataset="somMeetingDataSet" >
		<next:TopBar>
			<next:ToolBarItem symbol="->"></next:ToolBarItem>
			<next:ToolBarItem iconCls="locate" text="选择" handler="chooseMeeting"></next:ToolBarItem>
			<next:ToolBarItem iconCls="return" text="关闭" handler="winCloseMeeting"></next:ToolBarItem>
		</next:TopBar>
		<next:Columns>
			<next:RowNumberColumn/>
			<next:RadioBoxColumn></next:RadioBoxColumn>
			<next:Column header="会议ID" field="MEETINGID" editable="false" hidden="true"><next:TextField /></next:Column>
			<next:Column header="会议名称"  field="MEETINGNAME" width="240" editable="false" ><next:TextField /></next:Column>
			<next:Column header="会议时间" field="MEETINGDATE" width="150" editable="false"><next:TextField /></next:Column>
			<next:Column header="录入时间" field="CREATETIME" width="150" editable="false"><next:TextField /></next:Column>
			<next:Column header="是否负责人换届备案" field="SESSIONSATUS" width="150" editable="false"><next:TextField /></next:Column>
			<next:Column header="是否会费标准备案" field="FEESATUS" width="150" editable="false"><next:TextField /></next:Column>
			<next:Column header="是否章程核准" field="RULESATUS" width="150" editable="false"><next:TextField /></next:Column>
		</next:Columns>
		<next:BottomBar>
			<next:PagingToolBar dataset="somMeetingDataSet" />
		</next:BottomBar>
	</next:EditGridPanel>
</next:Window>
<next:Window id="undoWin" closeAction="hide" title="回退原因窗口" width="500"  autoScroll="true" modal="true">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="save" text="确定" handler="confirmUndo"></next:ToolBarItem>
		<next:ToolBarItem iconCls="return" text="关闭" handler="closeUndo"></next:ToolBarItem>
	</next:TopBar>
	<next:Html>
		<form method="post"  onsubmit="return false" class="L5form" >
			<table width="100%">
				<tr>
					<td class="FieldLabel" style="width: 20%">回退原因：</td>
					<td class="FieldInput" style="width: 80%"><textarea id="undoSeason" rows="3" style="width: 98%" name='回退原因' ></textarea></td>
				</tr>
			</table>
		</form>
	</next:Html>
</next:Window>
<jsp:include page="../../../../comm/upload/uploadWindow.jsp" flush="true"/>
<jsp:include page="../../../../comm/borg/borgSelectWindow.jsp" flush="true"/>
<jsp:include page="../../../../comm/country/countrySelectWindow.jsp" flush="true"/>
<jsp:include page="../../../../comm/selectWindow/duty/dutySelectWindow.jsp" flush="true"/>
</body>
</html>