<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="java.util.List" %>
<%@page import="java.util.Map" %>
<%@page import="org.loushang.workflow.api.WfQuery" %>
<%@page import="org.loushang.bsp.security.context.GetBspInfo"%>
<%@page import="java.lang.StringBuffer"%>
<%@ page import="com.inspur.cams.comm.util.IdHelp"%>
<%@page import="com.inspur.cams.sorg.apply.fund.cmd.FundChangeCmd"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<%@page import="com.inspur.cams.sorg.util.SomDutyDuties"%>
<%@page import="com.inspur.cams.sorg.util.ApplyType"%>
<html>
<!-- 基金会分支/代表机构变更流程页面 -->
<head>
	<next:ScriptManager></next:ScriptManager>
	<script type="text/javascript" src="fundBranchChangePre.js"></script>
	<script type="text/javascript" src="<%=SkinUtils.getJS(request, "changeCheck.js")%>"></script>
	<script type="text/javascript" src="<%=SkinUtils.getJS(request, "bpm/bpm.js")%>"></script>
	<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js") %>'></script>
	<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js") %>'></script>
	<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams/sorgUpload.js") %>'></script>
	<script type="text/javascript">var rootPath='<%=SkinUtils.getRootUrl(request)%>';</script>
	<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams/somPhoto.js") %>'></script>
	<script type="text/javascript" src="<%=SkinUtils.getRootUrl(request)%>skins/js/ISEditPhoto.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"My97DatePicker/WdatePicker.js") %>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams/sorgOnline.js")%>'></script>
<script>
	<%
		String primaryKey=request.getParameter("primaryKey");
	    if(primaryKey==null)
	    	{
	    		primaryKey="";
	    	}
	%>
	<%
		String somApplyType=ApplyType.SOM_FUND_BRANCH_CHANGE;
		String legalDuties=SomDutyDuties.SOM_LEGAL_PEOPLE;
	%>
	var taskCode='<%=request.getParameter("taskCode")%>'
	var somApplyType='<%=somApplyType%>';//业务类型
	var applyType = "231";
	var sorgId="";
	var rootPath="<%=SkinUtils.getRootUrl(request)%>";
	var currentUserName = '<%= GetBspInfo.getBspInfo().getUserName()%>';
	var morgArea='<%=BspUtil.getOrganCode()%>';
	var legalDutyId='<%=IdHelp.getUUID32()%>';
	var legalDuties='<%=legalDuties%>';//法定代表人职务代码
	var fileCodeF="J055";
</script>
</head>
<body>
<model:datasets>
	<!-- 退回所用dataset -->
	<model:dataset id="undoDataSet" cmd="com.inspur.cams.sorg.online.base.cmd.SomApplyOnlineQueryCommand" method="queryHasAcceptStatus"  global="true" sortField="createTime" sortDirection="DESC">
		<model:record fromBean="com.inspur.cams.sorg.online.base.data.SomApplyOnline"></model:record>
	</model:dataset>
	<!-- 更改业务状态所用dataset -->
	<model:dataset id="updateStatusDataSet" cmd="com.inspur.cams.sorg.online.base.cmd.SomApplyOnlineQueryCommand"  global="true" sortField="createTime" sortDirection="DESC">
		<model:record fromBean="com.inspur.cams.sorg.online.base.data.SomApplyOnline"></model:record>
	</model:dataset>

	<model:dataset id="somOrganDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomOrganQueryCmd" method="queryOrgan">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomOrgan"></model:record>
	</model:dataset>
	<!-- 变更申请dataset -->
	<model:dataset id="somOrganDataSet1" cmd="com.inspur.cams.sorg.base.cmd.SomOrganQueryCmd" method="queryOrgan">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomOrgan"></model:record>
	</model:dataset>
		<!-- 查询用系统中是否有该人，根据人名和sorgid查询 -->
	<model:dataset id="somDutyQueryDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomDutyQueryCmd" global="true" method="queryPeopleByName">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomDuty"></model:record>
	</model:dataset>
	<!-- 真正的法定代表人信息 -->
	<model:dataset id="legalPeopleDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomDutyQueryCmd" global="true" method="queryPeople">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomDuty"></model:record>
	</model:dataset>
	<!-- 法定代表人信息 -->
	<model:dataset id="somLegalPeopleDataSet" cmd="com.inspur.cams.sorg.online.base.cmd.SomDutyOnlineQueryCommand" global="true" method="queryPeople">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomDuty"></model:record>
	</model:dataset>
	<%--法定代表人人员简历 --%>
	<model:dataset id="somResumeLegalDataSet" cmd="com.inspur.cams.sorg.online.base.cmd.SomPeopleResumeOnlineQueryCommand" global="true" sortField="startDate" sortDirection="ASC">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomPeopleResume"></model:record>
	</model:dataset>
	<!-- 查询用系统中是否有该人，根据人名和sorgid查询 -->
	<model:dataset id="somDutyQueryDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomDutyQueryCmd" global="true" method="queryPeopleByName">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomDuty"></model:record>
	</model:dataset>
	<%--负责人简历 --%>
	<model:dataset id="somResumeLegalDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomPeopleResumeQueryCommand">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomPeopleResume"></model:record>
	</model:dataset>
	<!-- 变更申请dataset -->
	<model:dataset id="somApplyDataSet" cmd="com.inspur.cams.sorg.online.base.cmd.SomApplyOnlineQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomApply"></model:record>
	</model:dataset>
	<!-- 变更window的dataset -->
	<model:dataset id="somChangeList" cmd="com.inspur.cams.sorg.online.base.cmd.SomChangeOnlineQueryCommand" method="queryAndBuildFundBranch">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomChange"></model:record>
	</model:dataset>
	<!-- 变更window的dataset -->
	<model:dataset id="somChangeDataset" cmd="com.inspur.cams.sorg.online.base.cmd.SomChangeOnlineQueryCommand">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomChange"></model:record>
	</model:dataset>
	<model:dataset id="somChangeDetail" cmd="com.inspur.cams.sorg.manage.cmd.SomChangeQueryCommand">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomChange"></model:record>
	</model:dataset>
	<!-- 变更意见 -->
	<model:dataset id="somFlowAddDataset" cmd="com.inspur.cams.sorg.base.cmd.SomApplyQueryCmd">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomApply">
			<model:field name="curOpinionId" type="string" rule="require" />
			<model:field name="curOpinion" type="string" rule="length{200}" />
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
	<model:dataset id="sorgFundKind" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_FUND_KIND'></model:param>
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
	<model:dataset id="sorgBusScope" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
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
	<model:dataset id="countrySelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true" sortField="SORT_NO">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_COUNTRY'></model:param>
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
	<model:dataset id="somChangeItem" enumName="SOM.BRANCH.CHANGE.ITEM"  autoLoad="true" global="true"></model:dataset>
	<model:dataset id="opinionSelect" enumName="WORKFLOW.OPINION" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="opinionSelect1" enumName="WORKFLOW.OPINION" autoLoad="true" global="true"></model:dataset>	
	<model:dataset id="comm_yesorno" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>	
	<model:dataset id="hisOpinionDataSet" enumName="WORKFLOW.OPINION" autoLoad="true" global="true"></model:dataset>
</model:datasets>
<next:Panel title="基金会变更" width="100%" height="100%" >
	<next:TopBar>
	<next:ToolBarItem symbol="->" ></next:ToolBarItem>			
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="undo" text="退回" handler="updateOnlineStatusAndSeason"></next:ToolBarItem>
		<next:ToolBarItem iconCls="print" text="打印受理通知书" handler="printAccept"></next:ToolBarItem>
		<next:ToolBarItem iconCls="print" text="打印不予受理通知书" handler="printNoAccept"></next:ToolBarItem>
		<next:ToolBarItem iconCls="save" text="保存" handler="saveOpinion"></next:ToolBarItem>
		<next:ToolBarItem iconCls="select" text="提交" handler="sendNext"></next:ToolBarItem>
		<next:ToolBarItem iconCls="return" text="返回" handler="goBack"></next:ToolBarItem>
	</next:TopBar>
	<next:TabPanel width="100%" height="100%" id="tab" activeTab="1">
		<next:Tabs>
			<next:Panel title="基金会分支（代表）机构变更登记申请表" width="100%" height="100%" autoScroll="true">
				<next:Panel>
					<next:Html>
					<fieldset><legend>变更信息</legend>
					<form method="post" onsubmit="return false" class="L5form">
					<table width="100%">
						<tr>
							<td class="FieldLabel" style="width: 10%;"><label>基金会分支/代表(机构)登记证号：</label></td>
							<td class="FieldInput" style="width: 10%;"><label id="sorgCodeLab"></label></td>
							<td class="FieldLabel" style="width: 10%;"><label>申请时间：</label></td>
							<td class="FieldInput" style="width: 10%;"><label  id="changeDate"></label></td>
						</tr>
						<tr>
							<td class="FieldLabel" style="width: 10%;"><label>基金会名称：</label></td>
							<td class="FieldInput" style="width: 10%;"><label id="cnNameM"></label></td>
							<td class="FieldLabel" style="width: 10%;"><label>法定代表人：</label></td>
							<td class="FieldInput" style="width: 10%;"><label id="legalPeople"></label></td>
						</tr>
						<tr>
						
							<td class="FieldLabel" style="width: 10%;"><label>分支/代表机构名称：</label></td>
							<td class="FieldInput" style="width: 10%;"><label id="cnName"></label></td>
							<td class="FieldLabel" style="width: 10%;"><label>负责人：</label></td>
							<td class="FieldInput" style="width: 10%;"><label id="charger"></label></td>
						</tr>
					</table>
					</form>
					</fieldset>
					</next:Html>
				</next:Panel>
				<next:EditGridPanel id="changeEdit" dataset="somChangeList" height="60%"  autoScroll="true">
					<next:TopBar>
						<next:ToolBarItem text='' id="displayItem"/>
						<next:ToolBarItem symbol="变更事项"></next:ToolBarItem>
						<next:ToolBarItem symbol="->"></next:ToolBarItem>
						<next:ToolBarItem text="增加变更" iconCls="add" handler="forAdd"></next:ToolBarItem>
						<next:ToolBarItem text="查看变更" iconCls="edit" handler="detailForChange"></next:ToolBarItem>
						<next:ToolBarItem text="删除变更" iconCls="remove" handler="forDelete"></next:ToolBarItem>
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
							 width="30%" editable="false">
							<next:TextField/>
						</next:Column>
					</next:Columns>
				</next:EditGridPanel>
				<next:Html>
					<fieldset><legend>基金会内部履行程序</legend>
					<form method="post" onsubmit="return false" class="L5form">
						<table width="100%">
						<tr>	
							<td class="FieldInput"colspan="3"><textarea name="基金会内部履行程序" id="process" cols="65" rows="4" style="width:95%"></textarea></td>
						</tr>
						</table>
					</form>
					</fieldset>
				</next:Html>
			</next:Panel>
			<next:Panel title="法律要件">
				<next:EditGridPanel id="uploadGrid" width="100%" stripeRows="true" height="100%" dataset="somElectronicDataSet" autoScroll="true">
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
			<next:Panel title="处理意见" id="ipinionPanel" width="100%" height="100%" autoScroll="true" style="display:block;">
				<next:Html>
				<form method="post" onsubmit="return false" class="L5form" dataset="somApplyDataSet">
				<table width="100%">
					<tr>
						<tr>
							<td class="FieldLabel" style="width:13%"><label>处理意见：</label></td>
							<td class="FieldInput" colspan="5"><select field="curOpinionId" name='处理意见' style="width:150px"><option dataset="opinionSelect1"></option></select><span style="color:red">*</span></td>	
						</tr>
						<tr>
							<td class="FieldLabel"><label>处理补充意见：</label></td>
							<td class="FieldInput" colspan="5"><textarea rows="10" name='处理补充意见' field="curOpinion" style="width:98%"></textarea></td>
						</tr>
				</table>
				</form>
				</next:Html>
			</next:Panel>
		</next:Tabs>
	</next:TabPanel>
</next:Panel>
<!-- 基金会名称变更 -->
<next:Window id="AddChange0" closeAction="hide" title="名称变更" width="600"  autoScroll="true">
	<next:TopBar>
		<next:ToolBarItem text='' id="displayItem" />
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="关闭" iconCls="return" handler="closeChangeWin"></next:ToolBarItem>
	</next:TopBar>
<next:Html>
	<form method="post" onsubmit="return false" class="L5form" dataset="somChangeDetail">

<table width="100%">
			<tr>
				<td class="FieldLabel" style="width:25%"><label>名称变更前：</label></td>
				<td class="FieldInput" style="width:75%"><label id="nameBefore1" /></td>
			</tr>
			<tr>
				<td class="FieldLabel"><label  style="color:blue">名称变更为：</label></td>
				<td class="FieldInput"><label  id="nameAfter1" style="color:blue"/></td>
			</tr>
			<tr>
				<td class="FieldLabel"><label  style="color:blue">变更理由：</label></td>
				<td class="FieldInput"><textArea cols="75" rows="4" style="width: 100%;color:blue" field="changeReason" readonly="readonly"></textArea></td>
			</tr>
		</table>

		</form>
	</next:Html>
</next:Window>

<!-- 法定代表人变更 -->
<next:Window id="AddChange2" closeAction="hide" title="负责人变更" width="600"  autoScroll="true">
	<next:TopBar>
		<next:ToolBarItem text='' id="displayItem" />
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="查看负责人" iconCls="add" handler="addLegalPeople"></next:ToolBarItem>
		<next:ToolBarItem text="关闭" iconCls="return" handler="closeChangeWin"></next:ToolBarItem>
	</next:TopBar>
	<next:Html>
	<form method="post" onsubmit="return false" class="L5form"dataset="somChangeDetail">

<table width="100%">
			<tr>
				<td class="FieldLabel" style="width:25%"><label>负责人姓名变更前：</label></td>
				<td class="FieldInput"style="width:25%"><label  id="leaPeopleNameBefore1" /></td>
				<td class="FieldLabel"style="width:25%"><label style="color:blue">负责人姓名变更为：</label></td>
				<td class="FieldInput"style="width:25%"><label field="changeAfter" style="color:blue"/></td>
			</tr>
			<tr>
				<td class="FieldLabel"><label style="color:blue">变更理由：</label></td>
				<td class="FieldInput" colspan="5"><textArea cols="75" rows="4" style="width: 100%;color:blue" readonly="readonly" field="changeReason"></textArea></td>
			</tr>
		</table>

		</form>
	</next:Html>
</next:Window>
<!-- 住所变更 -->
<next:Window id="AddChange1" closeAction="hide" title="住所变更" width="500"  autoScroll="true">
	<next:TopBar>
		<next:ToolBarItem text='' id="displayItem" />
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="关闭" iconCls="return" handler="closeChangeWin"></next:ToolBarItem>
	</next:TopBar>
	<next:Html>
	<form method="post" onsubmit="return false" class="L5form"dataset="somChangeDetail">

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
				<td class="FieldLabel"><label style="color:blue">变更理由：</label></td>
				<td class="FieldInput"><textArea cols="75" rows="4" readonly="readonly" style="width: 100%;color:blue" field="changeReason" ></textArea></td>
			</tr>
		</table>

		</form>
	</next:Html>
</next:Window>
<!-- 业务范围变更 -->
<next:Window id="AddChange3" closeAction="hide" title="业务范围变更" width="600"  autoScroll="true">
	<next:TopBar>
		<next:ToolBarItem text='' id="displayItem" />
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="关闭" iconCls="return" handler="closeChangeWin"></next:ToolBarItem>
	</next:TopBar>
	<next:Html>
	<form method="post" onsubmit="return false" class="L5form"dataset="somChangeDetail">

<table width="100%">
			<tr>
				<td class="FieldLabel" style="width:25%"><label>业务范围变更前：</label></td>
				<td class="FieldInput"style="width:75%"><textArea  field='changeBefore' disabled="disabled" cols="75" rows="4" style="width: 100%"></textArea></td>
			</tr>
			<tr>
				<td class="FieldLabel"style="width:15%"><label style="color:blue">业务范围变更为：</label></td>
				<td class="FieldInput"style="width:15%"><textArea  field="changeAfter" readonly="readonly" cols="75" rows="4" style="width: 100%;color:blue"></textArea></td>
			</tr>
			<tr>
				<td class="FieldLabel"><label style="color:blue">变更理由：</label></td>
				<td class="FieldInput" colspan="5"><textArea readonly="readonly" cols="75" rows="4" style="width: 100%;color:blue" field="changeReason"></textArea></td>
			</tr>
		</table>

		</form>
	</next:Html>
</next:Window>

<!--添加变更  -->
<next:Window id="AddChange" closeAction="hide" title="添加变更" width="400"  autoScroll="true">
<next:Html>
	<form method="post" onsubmit="return false" class="L5form">

<table width="100%">
			<tr>
				<td class="FieldLabel" style="width:15%"><label>变更事项：</label></td>
				<td class="FieldInput"style="width:15%"><select id="addChangeItem" ><option dataset="somChangeItem" ></option></select></td>
				<td class="FieldLabel"style="width:15%"><input type="button" value="确定" onclick="forChangeItem(addChangeItem.value)"/></td>
			</tr>
		</table>

		</form>
	</next:Html>
</next:Window>
<!-- 基金会名称变更 -->
<next:Window id="AddChange10" closeAction="hide" title="名称变更" width="600"  autoScroll="true">
	<next:TopBar>
		<next:ToolBarItem text='' id="displayItem" />
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="确定" iconCls="add" handler="forNameMove" ></next:ToolBarItem>
		<next:ToolBarItem text="关闭" iconCls="return" handler="closeChangeWinD"></next:ToolBarItem>
	</next:TopBar>
<next:Html>
	<form method="post" onsubmit="return false" class="L5form" dataset="somChangeDataset">

<table width="100%">
			<tr>
				<td class="FieldLabel" style="width:25%"><label>名称变更前：</label></td>
				<td class="FieldInput"style="width:75%"><label id="nameBefore"/></td>
			</tr>
			<tr>
				<td class="FieldLabel"><label style="color:blue">名称变更为：</label></td>
				<td class="FieldInput"><input id='nameAfter' type="text"  style="width:98%"/></td>
			</tr>
			<tr>
				<td class="FieldLabel"><label style="color:blue">变更理由：</label></td>
				<td class="FieldInput"><textArea id="nameReason" cols="75" rows="4" style="width: 100%" field="changeReason"></textArea></td>
			</tr>
		</table>

		</form>
	</next:Html>
</next:Window>

<!-- 法定代表人变更 -->
<next:Window id="AddChange12" closeAction="hide" title="负责人变更" width="600"  autoScroll="true">
	<next:TopBar>
		<next:ToolBarItem text='' id="displayItem" />
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="查看负责人" iconCls="add" handler="addLegalPeople"></next:ToolBarItem>
		<next:ToolBarItem text="确定" iconCls="add" handler="forLeaPeopleMove" ></next:ToolBarItem>
		<next:ToolBarItem text="关闭" iconCls="return" handler="closeChangeWinD"></next:ToolBarItem>
	</next:TopBar>
	<next:Html>
	<form method="post" onsubmit="return false" class="L5form"dataset="somChangeDataset">

<table width="100%">
			<tr>
				<td class="FieldLabel" style="width:15%"><label>负责人姓名变更前：</label></td>
				<td class="FieldInput"style="width:15%"><label  id="leaPeopleNameBefore" /></td>
				<td class="FieldLabel"style="width:15%" style="color:blue"><label>负责人姓名变更为：</label></td>
				<td class="FieldInput"style="width:15%"><input id='leaPeopleNameAfter' type="text" readonly="readonly"/></td>
			</tr>
			<tr>
				<td class="FieldLabel"><label style="color:blue">变更理由：</label></td>
				<td class="FieldInput" colspan="5"><textArea id="leaPeopleReason"cols="75" rows="4" style="width: 100%" field="changeReason"></textArea></td>
			</tr>
		</table>

		</form>
	</next:Html>
</next:Window>
<!-- 住所变更 -->
<next:Window id="AddChange11" closeAction="hide" title="住所变更" width="500"  autoScroll="true">
	<next:TopBar>
		<next:ToolBarItem text='' id="displayItem" />
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="确定" iconCls="add" handler="forHouseMove" ></next:ToolBarItem>
		<next:ToolBarItem text="关闭" iconCls="return" handler="closeChangeWinD"></next:ToolBarItem>
	</next:TopBar>
	<next:Html>
	<form method="post" onsubmit="return false" class="L5form"dataset="somChangeDataset">

<table width="100%">
			<tr>
				<td class="FieldLabel" style="width:25%"><label>住所名称变更前：</label></td>
				<td class="FieldInput" style="width:75%"><label id="houseNameBefore"/></td>
			</tr>
			<tr>
				<td class="FieldLabel"><label style="color:blue">住所名称变更为：</label></td>
				<td class="FieldInput"><input id="houseNameAfter" type="text" style="width:98%"/></td>
			</tr>
			<tr>
				<td class="FieldLabel"><label style="color:blue">变更理由：</label></td>
				<td class="FieldInput"><textArea id="houseReason" cols="75" rows="4" style="width: 100%" field="changeReason"></textArea></td>
			</tr>
		</table>

		</form>
	</next:Html>
</next:Window>
<!-- 业务范围变更 -->
<next:Window id="AddChange13" closeAction="hide" title="业务范围变更" width="600"  autoScroll="true">
	<next:TopBar>
		<next:ToolBarItem text='' id="displayItem" />
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="确定" iconCls="add" handler="forBusinessMove" ></next:ToolBarItem>
		<next:ToolBarItem text="关闭" iconCls="return" handler="closeChangeWinD"></next:ToolBarItem>
	</next:TopBar>
	<next:Html>
	<form method="post" onsubmit="return false" class="L5form"dataset="somChangeDataset">

<table width="100%">
			<tr>
				<td class="FieldLabel" style="width:25%"><label>业务范围变更前：</label></td>
				<td class="FieldInput" style="width:75%"><textArea id="businessNameBefore" disabled="disabled" field="changeBefore" cols="75" rows="4" style="width: 100%" ></textArea></td>
			</tr>
			<tr>
				<td class="FieldLabel"style="width:15%"><label style="color:blue">业务范围变更为：</label></td>
				<td class="FieldInput" style="width:15%"><textArea id="businessNameAfter" field="changeAfter" cols="75" rows="4" style="width: 100%" ></textArea></td>
			</tr>
			<tr>
				<td class="FieldLabel"><label style="color:blue">变更理由：</label></td>
				<td class="FieldInput" colspan="5"><textArea id="businessReason"cols="75" rows="4" style="width: 100%" field="changeReason"></textArea></td>
			</tr>
		</table>

		</form>
	</next:Html>
</next:Window>
<next:Window id="legalPeopleWindow" closeAction="hide" title="负责人登记表" height="400" width="800" modal="true">
	<next:TabPanel  width="98%" height="84%">
		<next:Tabs>
			<next:Panel title="基本信息"  width="100%" height="100%" autoScroll="true">
				<next:Html>
					<form  method="post" dataset="somLegalPeopleDataSet" onsubmit="return false" class="L5form">
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
									<td class="FieldLabel"><label>按照本基金会章程会议产生通过情况：</label></td>
									<td class="FieldInput" colspan="5"><textarea   rows="2" name='"按照本基金会章程会议产生通过情况"' field="sorgOpinion" style="width:97.7%"></textarea><span style="color:red">*</span></td>
								</tr>
								<tr>	
									<td class="FieldLabel"><label>签署日期：</label></td>
									<td class="FieldInput" colspan="5"><input type="text"  field="sorgCheckDate" onclick="WdatePicker()" readonly="readonly" style="width:22%"/></td>
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
					<next:Column header="内码" field="id" width="10%" editable="true" hidden="true"><next:TextField/></next:Column>
					<next:Column header="开始年月" field="startDate" width="10%" editable="false"><next:TextField/></next:Column>
					<next:Column header="结束年月" field="endDate" width="10%" editable="false"><next:TextField/></next:Column>
					<next:Column header="在何地区何单位" field="workOrgan" width="45%" editable="false"><next:TextField/></next:Column>
					<next:Column header="任（兼）何职" field="duty" width="20%" editable="false"><next:TextField/></next:Column>
				</next:Columns>
			</next:EditGridPanel>
			<next:EditGridPanel id="uploadLegalPeopleGrid" title="法律要件" stripeRows="true" dataset="somLegalPeopleElectronicDataSet" width="100%" height="100%" autoScroll="true">
				<next:TopBar>
					<next:ToolBarItem symbol="附件列表"></next:ToolBarItem>
					<next:ToolBarItem symbol="->"></next:ToolBarItem>
					<next:ToolBarItem iconCls="add" text="增加上传附件" handler="uploadLegalPeopleFile"></next:ToolBarItem>
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
		<next:ToolButton text="关闭"handler="closePeopleWIn"></next:ToolButton>
	</next:Buttons>	
</next:Window>
<!-- 上传附件列表 -->
<next:Window id="uploadList" closeAction="hide"  title="附件上传列表" width="580" height="300" autoScroll="true"modal="true">
	<next:EditGridPanel id="uploadListGrid" width="566" stripeRows="true" height="269" dataset="winElectronicDataSet">
		<next:TopBar>
			<next:ToolBarItem symbol="附件列表"></next:ToolBarItem>
			<next:ToolBarItem symbol="->"></next:ToolBarItem>
			<next:ToolBarItem iconCls="upload" text="增加上传附件" handler="addUploadFile"></next:ToolBarItem>
			<next:ToolBarItem iconCls="return" text="关闭" handler="closeUploadFile"></next:ToolBarItem>
		</next:TopBar>
		<next:Columns>
			<next:RowNumberColumn />
			<next:RadioBoxColumn></next:RadioBoxColumn>
			<next:Column header="档案目录名"  field="catalogCode" editable="false" hidden="true"><next:TextField /></next:Column>
			<next:Column header="附件名称" width="220" field="fileName" editable="false"><next:TextField /></next:Column>
			<next:Column header="附件描述" width="200" field="fileMess" editable="false"><next:TextField /></next:Column>
			<next:Column header="删除附件" field="" width="80" editable="false" renderer="delUploadFile"><next:TextField /></next:Column>
		</next:Columns>
		<next:BottomBar>
			<next:PagingToolBar dataset="winElectronicDataSet" />
		</next:BottomBar>
	</next:EditGridPanel>
</next:Window>
<!-- 上传附件窗口 -->
<next:Window id="uploadWin" closeAction="hide" title="上传附件" height="230" width="600" modal="true">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem iconCls="yes" text="上传" handler="click_upload"></next:ToolBarItem>
		<next:ToolBarItem iconCls="return" text="关闭" handler="close_upload"></next:ToolBarItem>
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
    			<td class="FieldInput" colspan="6"><span style="color:red">上传文件最大不能超过10M</span></td>
    		</tr>
		</table>
		</form>
   </next:Html>
</next:Window>
<next:Window id="downloadWin" title="附件列表" closeAction="hide" height="400" width="740"modal="true">
	<next:EditGridPanel id="downloadGrid" width="727" stripeRows="true" height="369" dataset="downloadDataSet" >
		<next:TopBar>
			<next:ToolBarItem symbol="->"></next:ToolBarItem>
			<next:ToolBarItem iconCls="return" text="关闭" handler="winClosedownload"></next:ToolBarItem>
		</next:TopBar>
		<next:Columns>
			<next:RowNumberColumn/>
			<next:RadioBoxColumn></next:RadioBoxColumn>
			<next:Column header="电子档案ID" field="electronicId" editable="false" hidden="true"><next:TextField /></next:Column>
			<next:Column header="档案目录名"  field="catalogCode" width="280" editable="false" dataset="cataLogCodeSelect" ><next:TextField /></next:Column>
			<next:Column header="附件名称" field="fileName" width="190" editable="false" renderer="winDownloadHref"><next:TextField /></next:Column>
			<next:Column header="附件描述" field="fileMess" width="190" editable="false"><next:TextField /></next:Column>
		</next:Columns>
		<next:BottomBar>
			<next:PagingToolBar dataset="downloadDataSet" />
		</next:BottomBar>
	</next:EditGridPanel>
</next:Window>	
<!-- 上传法定代表人员附件列表 -->
<next:Window id="uploadLegalPeopleList" closeAction="hide"  title="附件上传列表" width="580" height="300" autoScroll="true"modal="true">
	<next:EditGridPanel id="uploadLegalPeopleListGrid" width="566" stripeRows="true" height="269" dataset="winLegalPeopleElectronicDataSet">
		<next:TopBar>
			<next:ToolBarItem symbol="附件列表"></next:ToolBarItem>
			<next:ToolBarItem symbol="->"></next:ToolBarItem>
			<next:ToolBarItem iconCls="upload" text="增加上传附件" handler="addUploadLegalPeopleFile"></next:ToolBarItem>
			<next:ToolBarItem iconCls="return" text="关闭" handler="closeUploadLegalPeopleFile"></next:ToolBarItem>
		</next:TopBar>
		<next:Columns>
			<next:RowNumberColumn />
			<next:RadioBoxColumn></next:RadioBoxColumn>
			<next:Column header="档案目录名"  field="catalogCode" editable="false" hidden="true"><next:TextField /></next:Column>
			<next:Column header="附件名称" width="220" field="fileName" editable="false"><next:TextField /></next:Column>
			<next:Column header="附件描述" width="200" field="fileMess" editable="false"><next:TextField /></next:Column>
			<next:Column header="删除附件" field="" width="80" editable="false" renderer="delLegalPeopleUploadFile"><next:TextField /></next:Column>
		</next:Columns>
		<next:BottomBar>
			<next:PagingToolBar dataset="winLegalPeopleElectronicDataSet"/>
		</next:BottomBar>
	</next:EditGridPanel>
</next:Window>
<!-- 上传法定代表人员附件窗口 -->
<next:Window id="uploadLegalPeopleWin" closeAction="hide" title="上传附件" height="230" width="600" modal="true">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="yes" text="上传" handler="click_uploadLegalPeople"></next:ToolBarItem>
		<next:ToolBarItem iconCls="return" text="关闭" handler="close_uploadLegalPeople"></next:ToolBarItem>
	</next:TopBar>
	<next:Html>
		<form id="form_content_legalPeople" onsubmit="return false" style="padding: 5px;" class="L5form">
		<table border="1"  width="100%" >
			<tr>
				<td class="FieldLabel" style="width:20%">附件描述</td>
				<td class="FieldInput" colspan="5" style="width:80%"><textarea id="legalPeopleFileMess" rows="5" style="width:95%"></textarea></td>
			</tr>
			<tr>
				<td class="FieldLabel">附件上传：</td>
				<td class="FieldInput" colspan="5"><input class="file" type="file" id="legalPeopleFiles" name="files" style="width:95%;height:40"/></td>
    		</tr>
    		<tr>
    			<td class="FieldInput" colspan="6"><span style="color:red">上传文件最大不能超过10M</span></td>
    		</tr>
		</table>
		</form>
	</next:Html>
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
</body>
</html>