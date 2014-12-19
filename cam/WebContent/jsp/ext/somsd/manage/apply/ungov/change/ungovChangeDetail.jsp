<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.sorg.util.SomIdHelp"%>
<%@page import="com.inspur.cams.sorg.util.ApplyType"%>
<%@page import="com.inspur.cams.sorg.util.SomDutyDuties"%>
<%@page import="com.inspur.cams.comm.util.StrUtil"%>
<%@ page import="com.inspur.cams.comm.util.IdHelp"%>
<%@page import="com.inspur.cams.sorg.online.apply.util.SomIdHelpOnline"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<%@ page import="com.inspur.cams.comm.extuser.data.ComExtUser"%>
<%@ page import="com.inspur.cams.sorg.online.extuser.util.SomExtBspInfo"%>
<%@page import="com.inspur.cams.comm.util.DateUtil"%>
<html>
<!-- 民办非企业单位主体变更登记页面 -->
<head>
	<next:ScriptManager/>
	<script type="text/javascript" src="ungovChangeDetail.js"></script>
	<script type="text/javascript" src="<%=SkinUtils.getJS(request, "changeCheck.js")%>"></script>
	<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js") %>'></script>
	<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js") %>'></script>
	<script type="text/javascript">var rootPath='<%=SkinUtils.getRootUrl(request)%>';</script>
	<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams/sorgUpload.js") %>'></script>
	<script type="text/javascript" src='<%=SkinUtils.getJS(request,"My97DatePicker/WdatePicker.js") %>'></script>
	<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams/somPhoto.js") %>'></script>
	<script type="text/javascript">
		
		<%
			String legalDuties=SomDutyDuties.SOM_LEGAL_PEOPLE;
			ComExtUser comExtUser = (ComExtUser)SomExtBspInfo.getUserInfo(request).getComExtUser();
			String username = comExtUser.getUserName();
			String organArea = comExtUser.getAreaCode();//获取外部单位行政区划12位
			String userId = comExtUser.getUserId();
			String sorgId ="";
			String taskCode ="";
				sorgId = request.getParameter("sorgId");
				taskCode = request.getParameter("taskCode") ;
		%>
		var sorgId='<%=sorgId%>';
		var taskCode='<%=taskCode%>';//业务编号
		var somApplyType='<%=ApplyType.SOM_UNGOV_CHANGE%>';//业务类型
		var legalDuties='<%=legalDuties%>';//法定代表人职务代码
		var legalDutyId='<%=IdHelp.getUUID32()%>';
		var morgArea='<%=organArea%>';
		var userId='<%=userId%>';
		var curDate='<%=DateUtil.getDay()%>';
	</script>
</head>
<body>
<model:datasets>
	<!-- 变更申请dataset -->
	<model:dataset id="somOrganDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomOrganQueryCmd" global="true" method="queryOrganOnline">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomOrgan">
			<model:field name="sorgCode" type="string" rule="require" />
			<model:field name="cnName" type="string" rule="require" />
		</model:record>
	</model:dataset>
	<!-- 负责人信息 -->
	<model:dataset id="somDutyDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomDutyQueryCmd" global="true" method="queryPeople">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomDuty"></model:record>
	</model:dataset>
	<!-- 变更列表的dataset -->
	<model:dataset id="somChangeList" cmd="com.inspur.cams.sorg.manage.cmd.SomChangeQueryCommand">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomChange"></model:record>
	</model:dataset>
	<!-- 变更window的dataset -->
	<model:dataset id="somChangeDataset" cmd="com.inspur.cams.sorg.manage.cmd.SomChangeCommand">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomChange"></model:record>
	</model:dataset>
	<!-- 真正的法定代表人信息 -->
	<model:dataset id="legalPeopleDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomDutyQueryCmd" global="true" method="queryPeople">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomDuty"></model:record>
	</model:dataset>
	<!-- 法定代表人录入窗口 -->
	<model:dataset id="somLegalPeopleDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomDutyQueryCmd" global="true" method="queryPeople">
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
	<%--法定代表人人员简历 --%>
	<model:dataset id="somResumeLegalDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomPeopleResumeQueryCommand">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomPeopleResume"></model:record>
	</model:dataset>	
	<%--人员简历 --%>
	<model:dataset id="somLegalPeopleResumeDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomPeopleResumeQueryCommand">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomPeopleResume"></model:record>
	</model:dataset>		
	<%--所有符合身份证号的人员列表--%>
	<model:dataset id="winPeopleDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomPeopleQueryCmd" >
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomPeople"></model:record>
	</model:dataset>
	<%--所有符合身份证号的人员职务列表--%>
	<model:dataset id="winDutyDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomDutyQueryCmd" >
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomDuty"></model:record>
	</model:dataset>	
	<!-- 变更意见 -->
	<model:dataset id="somFlowAddDataset" cmd="com.inspur.cams.sorg.base.cmd.SomApplyQueryCmd">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomApply">
		</model:record>
	</model:dataset>
	<%--电子档案--%>
	<model:dataset id="somElectronicDataSet" cmd="com.inspur.cams.sorg.upload.cmd.SomElectronicQueryCmd" global="true" method="queryCatalog" isGroup="true" groupField="applyType" pageSize="50">
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
	<%--法定代表人员电子档案--%>
	<model:dataset id="somLegalPeopleElectronicDataSet" cmd="com.inspur.cams.sorg.upload.cmd.SomElectronicQueryCmd" global="true" method="queryPeopleCatalog" >
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomElectronic"></model:record>
	</model:dataset>
	<%--法定代表人员电子档案上传窗口--%>
	<model:dataset id="winLegalPeopleElectronicDataSet" cmd="com.inspur.cams.sorg.upload.cmd.SomElectronicQueryCmd" global="true" method="queryPeopleElectronic">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomElectronic"></model:record>
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
	<!-- 文化程度 -->
	<model:dataset id="educationSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_EDUCATION'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>	
	<!--  -->
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
	<model:dataset id="cataLogCodeSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='SOM_CATALOG'></model:param>
			<model:param name="value" value='CATALOG_CODE'></model:param>
			<model:param name="text" value='CATALOG_NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="somChangeItem" enumName="SOM.UNGOV_CHANGE.ITEM"  autoLoad="true" global="true"></model:dataset>
	<model:dataset id="comm_yesorno" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="opinionSelect" enumName="WORKFLOW.OPINION" autoLoad="true" global="true"></model:dataset>	
</model:datasets>
<next:Panel title="民办非企业单位变更登记" width="100%" height="100%" >
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="undo" text="返回" handler="goBack"></next:ToolBarItem>
	</next:TopBar>
	<next:TabPanel id="tab" activeTab="1" width="100%" height="100%" >
		<next:Tabs>
			<next:Panel title="民办非企业单位变更登记申请表" width="100%" height="100%"  autoScroll="true">
				<next:Panel>
					<next:Html>
						<fieldset><legend>变更信息</legend>
						<form method="post" onsubmit="return false" dataset="somOrganDataSet" class="L5form">
						<table width="100%">
							<tr>
								<td class="FieldLabel" style="width: 10%;"><label>登记证号：</label></td>
								<td class="FieldInput" style="width: 10%;"><label type="text" id="sorgCode" field="sorgCode" title="登记证号"/><font color="red">*</font></td>
								<td class="FieldLabel" style="width: 10%;"><label>民办非企业单位名称：</label></td>
								<td class="FieldInput" style="width: 10%;">
								<label type="text" id="cnName" field="cnName" title="民办非企业单位名称"/><font color="red">*</font>
								</td>
							</tr>
						</table>
						</form>
						</fieldset>
					</next:Html>
				</next:Panel>
				<next:EditGridPanel id="changeEdit" dataset="somChangeList" height="60%" autoScroll="true" >
					<next:TopBar>
						<next:ToolBarItem text='' id="displayItem"/>
						<next:ToolBarItem symbol="变更事项"></next:ToolBarItem>
						<next:ToolBarItem symbol="->"></next:ToolBarItem>
						<next:ToolBarItem text="查看变更" iconCls="detail" handler="forDetail"></next:ToolBarItem>
					</next:TopBar>
					<next:Columns>
						<next:RowNumberColumn/>
						<next:RadioBoxColumn></next:RadioBoxColumn>
						<next:Column header="变更事项" field="changeItem" 
							 width="19%" editable="false" dataset="somChangeItem">
							<next:TextField />
						</next:Column>
						<next:Column header="变更前" field="changeBefore" 
							 width="30%"editable="false">
							<next:TextField/>
						</next:Column>
						<next:Column header="拟变更为" field="changeAfter" 
							 width="20%" editable="false">
							<next:TextField/>
						</next:Column>
						<next:Column header="变更理由" field="changeReason" 
							 width="28%" editable="false">
							<next:TextField/>
						</next:Column>
					</next:Columns>
				</next:EditGridPanel>
			</next:Panel>
			<next:Panel title="法律要件" >
				<next:EditGridPanel id="uploadGrid" width="100%" stripeRows="true" height="100%" dataset="somElectronicDataSet" autoScroll="true">
					<next:GroupingView forceFit="true"></next:GroupingView>
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
						<next:Column header="下载附件" field="" width="10%" editable="false" renderer="clickDownloadHref"><next:TextField /></next:Column>
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

<!-- 法定代表人变更 -->
<next:Window closable="false"id="AddChange2" closeAction="hide" title="法定代表人变更" width="600"  autoScroll="true" modal="true">
	<next:TopBar>
		<next:ToolBarItem text='' id="displayItem" />
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="关闭" iconCls="return" handler="closeChangeWin"></next:ToolBarItem>
	</next:TopBar>
	<next:Html>
		<form method="post" onsubmit="return false" class="L5form"dataset="somChangeDataset">
			<table width="100%">
				<tr>
					<td class="FieldLabel" style="width:15%"><label>法定代表人姓名变更前：</label></td>
					<td class="FieldInput"style="width:15%">
						<label id='leaPeopleNameBefore' type="text"  style="width:98%"/>
					</td>
					<td class="FieldLabel"style="width:15%" style="color:blue"><label>法定代表人姓名变更为：</label></td>
					<td class="FieldInput"style="width:15%"><label id='leaPeopleNameAfter' field="changeAfter" type="text"   readonly="readonly"/></td>
				</tr>
				<tr>
					<td class="FieldLabel"><label style="color:blue">变更程序：</label></td>
					<td class="FieldInput" colspan="5"><textArea readonly id="leaPeopleDesc" cols="75" rows="4" style="width: 100%" field="changeDesc"></textArea></td>
				</tr>
				<tr>
					<td class="FieldLabel"><label style="color:blue">变更理由：</label></td>
					<td class="FieldInput" colspan="5"><textArea readonly id="leaPeopleReason" cols="75" rows="4" style="width: 100%" field="changeReason"></textArea></td>
				</tr>
			</table>
		</form>
	</next:Html>
</next:Window>
<!-- 社会团体名称变更 -->
<next:Window id="detail0" closeAction="hide" title="名称变更" modal="true" width="600"  autoScroll="true">
	<next:TopBar>
		<next:ToolBarItem text='' id="displayItem" />
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="关闭" iconCls="return" handler="closeChangeWinD"></next:ToolBarItem>
	</next:TopBar>
	<next:Html>
		<form method="post" onsubmit="return false" class="L5form" dataset="somChangeDataset">
			<table width="100%">
				<tr>
					<td class="FieldLabel" style="width:25%"><label>名称变更前：</label></td>
					<td class="FieldInput"style="width:75%"><label id="nameBefore1"/></td>
				</tr>
				<tr>
					<td class="FieldLabel"style="width:25%"><label style="color:blue">名称变更为：</label></td>
					<td class="FieldInput"style="width:75%"><label id='nameAfter1' style="color:blue"/></td>
				</tr>
				<tr>
					<td class="FieldLabel"style="width:25%"><label style="color:blue">变更程序：</label></td>
					<td class="FieldInput"style="width:75%"><textArea cols="75" rows="4" style="width: 100%;color:blue" field="changeDesc" readonly="readonly"></textArea></td>
				</tr>
				<tr>
					<td class="FieldLabel"style="width:25%"><label style="color:blue">变更理由：</label></td>
					<td class="FieldInput"style="width:75%"><textArea cols="75" rows="4" style="width: 100%;color:blue" field="changeReason" readonly="readonly"></textArea></td>
				</tr>
			</table>
		</form>
	</next:Html>
</next:Window>
<!-- 法定代表人变更 -->
<next:Window id="detail2" closeAction="hide" title="法定代表人变更" width="600"  autoScroll="true" modal="true">
	<next:TopBar>
		<next:ToolBarItem text='' id="displayItem" />
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="查看法定代表人登记表" iconCls="add" handler="detailLegalPeople" ></next:ToolBarItem>
		<next:ToolBarItem text="关闭" iconCls="return" handler="closeChangeWinD"></next:ToolBarItem>
	</next:TopBar>
	<next:Html>
		<form method="post" onsubmit="return false" class="L5form" dataset="somChangeDataset">
			<table width="100%">
				<tr>
					<td class="FieldLabel" style="width:15%"><label>法定代表人姓名变更前：</label></td>
					<td class="FieldInput"style="width:15%"><label  id="leaPeopleNameBefore1" /></td>
					<td class="FieldLabel"style="width:15%" style="color:blue"><label>法定代表人姓名变更为：</label></td>
					<td class="FieldInput"style="width:15%"><label id='leaPeopleNameAfter1' style="color:blue"/></td>
				</tr>
				<tr>
					<td class="FieldLabel"><label style="color:blue">变更程序：</label></td>
					<td class="FieldInput" colspan="5"><textArea cols="75" rows="4" style="width: 100%;color:blue" readonly="readonly" field="changeDesc"></textArea></td>
				</tr>
				<tr>
					<td class="FieldLabel"><label style="color:blue">变更理由：</label></td>
					<td class="FieldInput" colspan="5"><textArea cols="75" rows="4" style="width: 100%;color:blue" readonly="readonly"  field="changeReason"></textArea></td>
				</tr>
			</table>
		</form>
	</next:Html>
</next:Window>
<!-- 住所变更 -->
<next:Window id="detail1" closeAction="hide" title="住所变更" width="500"  autoScroll="true" modal="true">
	<next:TopBar>
		<next:ToolBarItem text='' id="displayItem" />
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="关闭" iconCls="return" handler="closeChangeWinD"></next:ToolBarItem>
	</next:TopBar>
	<next:Html>
		<form method="post" onsubmit="return false" class="L5form" dataset="somChangeDataset">
			<table width="100%">
				<tr>
					<td class="FieldLabel" style="width:25%"><label>住所名称变更前：</label></td>
					<td class="FieldInput" style="width:75%"><label id="houseNameBefore1"/></td>
				</tr>
				<tr>
					<td class="FieldLabel"><label style="color:blue">住所名称变更为：</label></td>
					<td class="FieldInput"><label id="houseNameAfter1"  style="color:blue"/></td>
				</tr>
				<tr>
					<td class="FieldLabel"><label style="color:blue">变更程序：</label></td>
					<td class="FieldInput"><textArea cols="75" readonly="readonly" rows="4" style="width: 100%;color:blue" field="changeDesc"></textArea></td>
				</tr>
				<tr>
					<td class="FieldLabel"><label style="color:blue">变更理由：</label></td>
					<td class="FieldInput"><textArea cols="75" readonly="readonly" rows="4" style="width: 100%;color:blue"  field="changeReason"></textArea></td>
				</tr>
			</table>
		</form>
	</next:Html>
</next:Window>
<!-- 业务范围变更 -->
<next:Window id="detail3" closeAction="hide" title="业务范围变更" width="600"  autoScroll="true" modal="true">
	<next:TopBar>
		<next:ToolBarItem text='' id="displayItem" />
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="关闭" iconCls="return" handler="closeChangeWinD"></next:ToolBarItem>
	</next:TopBar>
	<next:Html>
		<form method="post" onsubmit="return false" class="L5form" dataset="somChangeDataset">
			<table width="100%">
				<tr>
					<td class="FieldLabel" style="width:25%"><label>业务范围变更前：</label></td>
					<td class="FieldInput"style="width:75%"><textArea  id='areaChangeBefore' readonly="readonly" cols="75" rows="4" style="width: 100%"></textArea></td>
				</tr>
				<tr>
					<td class="FieldLabel"style="width:15%"><label style="color:blue">业务范围变更为：</label></td>
					<td class="FieldInput"style="width:15%"><textArea  id="areaChangeAfter" readonly="readonly" cols="75" rows="4" style="width: 100%;color:blue"></textArea></td>
				</tr>
				<tr>
					<td class="FieldLabel"><label style="color:blue">变更程序：</label></td>
					<td class="FieldInput" colspan="5"><textArea readonly="readonly" cols="75" rows="4" style="width: 100%;color:blue" field="changeDesc"></textArea></td>
				</tr>
				<tr>
					<td class="FieldLabel"><label style="color:blue">变更理由：</label></td>
					<td class="FieldInput" colspan="5"><textArea readonly="readonly"  cols="75" rows="4" style="width: 100%;color:blue"  field="changeReason"></textArea></td>
				</tr>
			</table>
		</form>
	</next:Html>
</next:Window>
<!-- 变更开办资金 -->
<next:Window id="detail4" closeAction="hide" title="开办资金变更" width="500"  autoScroll="true" modal="true">
	<next:TopBar>
		<next:ToolBarItem text='' id="displayItem" />
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="关闭" iconCls="return" handler="closeChangeWinD"></next:ToolBarItem>
	</next:TopBar>
	<next:Html>
		<form method="post" onsubmit="return false" class="L5form" dataset="somChangeDataset" >
			<table width="100%">
				<tr>
					<td class="FieldLabel" style="width:30%"><label>开办资金数额变更前：</label></td>
					<td class="FieldInput" style="width:70%"><label id="moneyBefore1"></label>万元</td>
				</tr>
				<tr>
					<td class="FieldLabel"><label>资金来源变更前：</label></td>
					<td class="FieldInput" colspan="3"><label id="moneySourceBefore1" /></td>
				</tr>
				<tr>
					<td class="FieldLabel"><label style="color:blue">开办资金数额变更为：</label></td>
					<td class="FieldInput"><label id="moneyAfter1" style="color:blue"></label>万元</td>
				</tr>
				<tr>
					<td class="FieldLabel"><label style="color:blue">资金来源变更为：</label></td>
					<td class="FieldInput" colspan="3"><label id="moneySourceAfter1"  style="color:blue"/></td>
				</tr>
				<tr>
					<td class="FieldLabel"><label style="color:blue">变更程序：</label></td>
					<td class="FieldInput" colspan="5"><textArea cols="75" readonly="readonly" rows="4" style="width: 100%;color:blue" field="changeDesc"></textArea></td>
				</tr>
				<tr>
					<td class="FieldLabel"><label style="color:blue">变更理由：</label></td>
					<td class="FieldInput" colspan="5"><textArea cols="75" readonly="readonly" rows="4" style="width: 100%;color:blue"  field="changeReason"></textArea></td>
				</tr>
			</table>
		</form>
	</next:Html>
</next:Window>
<!-- 业务主管单位变更 -->
<next:Window id="detail5" closeAction="hide" title="业务主管单位变更" width="600"  autoScroll="true" modal="true">
	<next:TopBar>
		<next:ToolBarItem text='' id="displayItem" />
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="关闭" iconCls="return" handler="closeChangeWinD"></next:ToolBarItem>
	</next:TopBar>
	<next:Html>
		<form method="post" onsubmit="return false" class="L5form"dataset="somChangeDataset">
			<table width="100%">
				<tr>
					<td class="FieldLabel" style="width:25%"><label>变更前业务主管单位：</label></td>
					<td class="FieldInput"style="width:75%"><select
						id="borgNameBefore1" disabled="disabled" style="width:80%">
						<option dataset="businessOrganSelect"></option>
					</select></td>
				</tr>
				<tr>
					<td class="FieldLabel"style="width:15%"><label style="color:blue">变更为业务主管单位：</label></td>
					<td class="FieldInput"style="width:15%">
					<select field="changeAfter" id='borgNameAfter1'disabled="disabled" style="width:80%;color:blue">
						<option dataset="businessOrganSelect"></option>
					</select></td>
				</tr>
				<tr>
					<td class="FieldLabel"><label style="color:blue">变更程序：</label></td>
					<td class="FieldInput" colspan="5"><textArea cols="75" readonly="readonly" rows="4" style="width: 100%;color:blue" field="changeDesc"></textArea></td>
				</tr>
				<tr>
					<td class="FieldLabel"><label style="color:blue">变更理由：</label></td>
					<td class="FieldInput" colspan="5"><textArea cols="75" readonly="readonly" rows="4" style="width: 100%;color:blue"  field="changeReason"></textArea></td>
				</tr>
			</table>
		</form>
	</next:Html>
</next:Window>
<!-- 出资人变更 -->
<next:Window id="detail7" closeAction="hide" title="出资人变更" width="600"  autoScroll="true" modal="true">
	<next:TopBar>
		<next:ToolBarItem text='' id="displayItem" />
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="关闭" iconCls="return" handler="closeChangeWinD"></next:ToolBarItem>
	</next:TopBar>
	<next:Html>
		<form method="post" onsubmit="return false" class="L5form" dataset="somChangeDataset">
			<table width="100%">
				<tr>
					<td class="FieldLabel" style="width:25%"><label>出资人变更前：</label></td>
					<td class="FieldInput"style="width:75%"><textArea id="monPeopleChangeBefore1"readonly="readonly" cols="75" rows="4" style="width: 100%"></textArea></td>
				</tr>
				<tr>
					<td class="FieldLabel"style="width:15%"><label style="color:blue">出资人变更为：</label></td>
					<td class="FieldInput"style="width:15%"><textArea  id='monPeopleChangeAfter1' readonly="readonly" cols="75" rows="4" style="width:100%;color:blue"></textArea></td>
				</tr>
				<tr>
					<td class="FieldLabel"><label style="color:blue">变更程序：</label></td>
					<td class="FieldInput" colspan="5"><textArea field="changeDesc" readonly="readonly" cols="75" rows="4" style="width: 100%;color:blue"></textArea></td>
				</tr>
				<tr>
					<td class="FieldLabel"><label style="color:blue">变更理由：</label></td>
					<td class="FieldInput" colspan="5"><textArea   field="changeReason"readonly="readonly"  cols="75" rows="4" style="width: 100%;color:blue" ></textArea></td>
				</tr>
			</table>
		</form>
	</next:Html>
</next:Window>
<!-- 法定代表人明细窗口 -->
<next:Window id="detailLegalPeopleWindow" closeAction="hide" title="法定代表人登记表" height="400" width="800" modal="true">
	<next:TabPanel  width="98%" height="84%" id="detailLegalPeopleTab">
		<next:Tabs>
			<next:Panel title="基本信息"  width="100%" height="100%" autoScroll="true">
				<next:Html>
					<form  method="post" dataset="somLegalPeopleDataSet" onsubmit="return false" class="L5form">
						<table width="100%">
							<tr>
								<td class="FieldLabel" style="width:12%">姓名：</td>
								<td class="FieldInput" style="width:12%"><label  field="name"></label></td>
								<td class="FieldLabel"style="width:12%">性别：</td>
								<td class="FieldInput"style="width:10%"><label  field="sex" dataset="sexSelect"></label>
									 </td>
								<td class="FieldLabel"style="width:10%">民族：</td>
								<td class="FieldInput"style="width:10%">
									<label  field="folk" dataset="folkSelect"></label>
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
									<label  field="politics" dataset="politicsSelect"></label>
								</td>
								<td class="FieldLabel">文化程度：</td>
								<td class="FieldInput" colspan="3">
									<label  field="education" dataset="educationSelect"></label>
								</td>
							</tr>
							<tr>
								<td class="FieldLabel">出生日期：</td>
								<td class="FieldInput">
										<label  field="birthday" ></label>
								</td>
								<td class="FieldLabel" style="width:15%">身份证号码：</td>
								<td class="FieldInput" style="width:21%" colspan="3">
									<label  field="idCard" ></label>
								</td>
								
							</tr>
							<tr>
								<td class="FieldLabel">职务：</td>
								<td class="FieldInput" >
									<label  field="sorgDuties" ></label>
								</td>
								<td class="FieldLabel">技术职称：</td>
								<td class="FieldInput" colspan="3">
									<label  field="profession" ></label>
								 </td>
							</tr>
							<tr>
								<td class="FieldLabel">户口所在地：</td>
								<td class="FieldInput" colspan="5">
									<label  field="populace" ></label>
								</td>
							</tr>
							<tr>
								<td class="FieldLabel">家庭住址：</td>
								<td class="FieldInput" colspan="2">
									<label  field="adds" ></label>
								 </td>
								<td class="FieldLabel">邮编：</td>
								<td class="FieldInput">
									<label  field="postCode" ></label>
								</td>
								<td class="FieldLabel">电话：</td>
								<td class="FieldInput">
									<label  field="phone" ></label>
								</td>
							</tr>
							<tr>
								<td class="FieldLabel">人事关系所在单位：</td>
								<td class="FieldInput" colspan="4">
									<label  field="personUnit" ></label>
								</td>
								<td class="FieldLabel">电话：</td>
								<td class="FieldInput">
									<label  field="personUnitPhone" ></label>
								</td>
							</tr>					
						</table>
					</form>
				</next:Html>
			</next:Panel>
			<next:EditGridPanel dataset="somLegalPeopleResumeDataSet" stripeRows="true" title="本人简历" width="100%" height="100%" autoScroll="true">
				<next:TopBar>
					<next:ToolBarItem symbol="->"></next:ToolBarItem>
				</next:TopBar>
				<next:Columns>
					<next:RowNumberColumn/>
					<next:Column header="内码" field="id" width="10%" editable="true" hidden="true"><next:TextField/></next:Column>
					<next:Column header="开始年月" field="startDate" width="10%" editable="false"><next:TextField/></next:Column>
					<next:Column header="结束年月" field="endDate" width="10%" editable="false"><next:TextField/></next:Column>
					<next:Column header="在何地区何单位" field="workOrgan" width="45%" editable="false"><next:TextField/></next:Column>
					<next:Column header="任（兼）何职" field="duty" width="20%" editable="false"><next:TextField/></next:Column>
				</next:Columns>
				<next:BottomBar>
					<next:PagingToolBar dataset="somLegalPeopleResumeDataSet"/>
				</next:BottomBar>
			</next:EditGridPanel>
			<next:EditGridPanel title="法律要件" stripeRows="true" dataset="somLegalPeopleElectronicDataSet" width="100%" height="100%" autoScroll="true">
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
	<next:Buttons>
		<next:ToolButton text="关闭" handler="closePeopleDetailWIn"></next:ToolButton>
	</next:Buttons>
</next:Window>
<jsp:include page="../../../../../../cams/sorg/comm/upload/uploadWindow.jsp" flush="true"/>
</body>
</html>