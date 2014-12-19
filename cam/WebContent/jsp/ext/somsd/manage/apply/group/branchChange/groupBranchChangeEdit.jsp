<%@ page language="java" contentType="text/html; charset=utf-8"pageEncoding="utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.sorg.util.SomIdHelp"%>
<%@page import="com.inspur.cams.sorg.util.ApplyType"%>
<%@page import="com.inspur.cams.sorg.util.SomDutyDuties"%>
<%@page import="com.inspur.cams.comm.util.StrUtil"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<%@ page import="com.inspur.cams.comm.util.IdHelp"%>
<%@ page import="com.inspur.cams.comm.extuser.data.ComExtUser"%>
<%@ page import="com.inspur.cams.sorg.online.extuser.util.SomExtBspInfo"%>
<%@page import="com.inspur.cams.sorg.online.apply.util.SomIdHelpOnline"%>
<html>
<!-- 社会团体分支变更网上申请录入页面 -->
<head>
	<next:ScriptManager/>
	<script type="text/javascript" src="groupBranchChangeEdit.js"></script>
	<script type="text/javascript" src="<%=SkinUtils.getJS(request, "changeCheck.js")%>"></script>
	<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js") %>'></script>
	<script type="text/javascript">var rootPath='<%=SkinUtils.getRootUrl(request)%>';</script>
	<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js") %>'></script>
	<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams/sorgUpload.js") %>'></script>
	<script type="text/javascript" src='<%=SkinUtils.getJS(request,"My97DatePicker/WdatePicker.js") %>'></script>
	<script type="text/javascript">
		<%
			String legalDuties=SomDutyDuties.SOM_LEGAL_PEOPLE;
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
			String sorgCode = SomExtBspInfo.getUserInfo(request).getSorgCode();
		%>
		var rootPath="<%=SkinUtils.getRootUrl(request)%>";
		var taskCode='<%=taskCode%>';
		var sorgId='<%=sorgId%>';
		var somApplyType='<%=ApplyType.SOM_GROUP_BRANCH_CHANGE%>';//业务类型
		var legalDuties='<%=legalDuties%>';//法定代表人职务代码
		var method='<%=request.getParameter("method")%>';
		var morgArea='<%=organArea%>';
		var legalDutyId='<%=IdHelp.getUUID32()%>';
		var userId='<%=userId%>';
		var sorgCode='<%=sorgCode%>';
	</script>
</head>
<body>
<model:datasets>
	<!-- 变更申请dataset -->
	<model:dataset id="somOrganDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomOrganQueryCmd" global="true" method="queryOrganOnline">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomOrgan">
			<model:field name="sorgCode" type="string" rule="require|length{20}"/>
			<model:field name="cnName" type="string" rule="require|length{100}"/>
			<model:field name="mainSorgCode" type="string" rule="require|length{20}" />
			<model:field name="mainSorgName" type="string" rule="require|length{100}" />
		</model:record>
	</model:dataset>
	<!-- 变更申请dataset -->
	<model:dataset id="somOrganDataSet1" cmd="com.inspur.cams.sorg.base.cmd.SomOrganQueryCmd"  method="queryOrganOnline">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomOrgan"></model:record>
	</model:dataset>
	<!-- 负责人信息 -->
	<model:dataset id="somDutyDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomDutyQueryCmd" global="true" method="queryPeople">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomDuty"></model:record>
	</model:dataset>
	<!-- 分支负责人 -->
	<model:dataset id="chargerDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomDutyQueryCmd" global="true" method="queryPeople">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomDuty"></model:record>
	</model:dataset>
	<!-- 分支负责人 -->
	<model:dataset id="somLegalPeopleDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomDutyQueryCmd" global="true" method="queryPeople">
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
			<model:field name="resume" type="string" rule="length{1000}" />
			<model:field name="workOpinion" type="string" rule="length{200}" />
			<model:field name="sorgOpinion" type="string" rule="length{200}" />
			<model:field name="promiseOrgan" type="string" rule="length{100}" />
			<model:field name="promiseCode" type="string" rule="length{100}" />
			<model:field name="otherDuties" type="string" rule="length{500}" />
			<model:field name="note" type="string" rule="length{200}" />
			<model:field name="ifPartyLeader" type="string" rule="require" />
			<model:field name="startDate" type="string" rule="require" />
		</model:record>
	</model:dataset>
	<%--分支负责人简历 --%>
	<model:dataset id="somLegalPeopleResumeDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomPeopleResumeQueryCommand" sortField="startDate" sortDirection="DESC">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomPeopleResume"></model:record>
	</model:dataset>
	<!-- 变更列表的dataset -->
	<model:dataset id="somChangeList" cmd="com.inspur.cams.sorg.manage.cmd.SomChangeQueryCommand">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomChange"></model:record>
	</model:dataset>
	<!-- 变更window的dataset -->
	<model:dataset id="somChangeDataset" cmd="com.inspur.cams.sorg.manage.cmd.SomChangeQueryCommand">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomChange"></model:record>
	</model:dataset>
	<!-- 变更意见 -->
	<model:dataset id="somFlowAddDataset" cmd="com.inspur.cams.sorg.base.cmd.SomApplyQueryCmd">
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
	<model:dataset id="somChangeItem" enumName="SOM.BRANCH.CHANGE.ITEM"  autoLoad="true" global="true"></model:dataset>
	<model:dataset id="comm_yesorno" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="opinionSelect" enumName="WORKFLOW.OPINION" autoLoad="true" global="true"></model:dataset>
</model:datasets>
<next:Panel title="社会团体变更登记" width="100%" height="100%" >
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="save" text="保存" handler="saveForCreate"></next:ToolBarItem>
		<next:ToolBarItem iconCls="undo" text="返回" handler="goBack"></next:ToolBarItem>
	</next:TopBar>
	<next:TabPanel width="100%" height="100%" id="tab" activeTab="1">
		<next:Tabs>
			<next:Panel title="社会团体变更登记申请表" width="100%" height="100%"  autoScroll="true">
				<next:Panel>
					<next:Html>
					<fieldset><legend>变更信息</legend>
					<form method="post" onsubmit="return false" dataset="somOrganDataSet" class="L5form">
					<table width="100%">
						<tr>
							<td class="FieldLabel" style="width: 10%;"><label>社会团体主体名称：</label></td>
							<td class="FieldInput" style="width: 10%;">
							<label type="text" id="mainSorgName" name='登记证号' field="mainSorgName" style="width:55%"/>
							</td>
							<td class="FieldLabel" style="width: 10%;"><label>社会团体主体登记证号：</label></td>
							<td class="FieldInput" style="width: 10%;">
							<label type="text" id="mainSorgCode" name='社团主体登记证号' field="mainSorgCode" style="width:55%"/>
							</td>
						</tr>
						<tr>
							<td class="FieldLabel" style="width: 10%;"><label>分支/代表机构登记证号：</label></td>
							<td class="FieldInput" style="width: 10%;"><input type="text" id="sorgCode"  field="sorgCode" onkeyup="value=value.replace(/[^\-\\w\.\/]/ig,'').toUpperCase()" title="分支/代表机构登记证号"/><font color="red">*</font></td>
							<td class="FieldLabel" style="width: 10%;"><label>分支/代表机构名称：</label></td>
							<td class="FieldInput" style="width: 10%;"><input type="text" id="cnName" field="cnName" title="分支/代表机构名称"/><font color="red">*</font></td>
						</tr>
						<tr>
							<td class="FieldLabel" style="width: 10%;"><label>申请时间：</label></td>
							<td class="FieldInput" style="width: 10%;"><input type="text" id="appDate"  onClick="WdatePicker()"  title="申请时间"/><font color="red">*</font></td>
							<td class="FieldLabel" style="width: 10%;"><label></label></td>
							<td class="FieldInput" style="width: 10%;"><label></label></td>
						</tr>
					</table>
					</form>
					</fieldset>
					</next:Html>
				</next:Panel>
				<next:EditGridPanel id="changeEdit" dataset="somChangeList" height="60%"  autoScroll="true" >
					<next:TopBar>
						<next:ToolBarItem text='' id="displayItem"/>
						<next:ToolBarItem symbol="变更事项"></next:ToolBarItem>
						<next:ToolBarItem symbol="->"></next:ToolBarItem>
						<next:ToolBarItem text="增加变更" iconCls="add" handler="forAdd"></next:ToolBarItem>
						<next:ToolBarItem text="查看变更" iconCls="edit" handler="forDetail"></next:ToolBarItem>
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
							 width="28%" editable="false">
							<next:TextField/>
						</next:Column>
					</next:Columns>
				</next:EditGridPanel>
				<next:Html>
				<fieldset><legend>社团内部履行程序</legend>
				<form method="post" onsubmit="return false" class="L5form">
					<table width="100%">
					<tr>
						<td class="FieldInput" colspan="3"><textarea name="社团内部履行程序" id="process" cols="65" rows="4" style="width:95%"></textarea></td>
					</tr>
				</table>
				</form>
				</fieldset>
				</next:Html>
			</next:Panel>
			<next:Panel title="法律要件" >
				<next:EditGridPanel id="uploadGrid" width="100%" stripeRows="true" height="100%" dataset="somElectronicDataSet" autoScroll="true">
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
						<next:Column header="下载附件"    field="" width="10%" editable="false" renderer="clickDownloadHref"><next:TextField/></next:Column>
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






<!--添加变更  -->
<next:Window id="AddChange" closeAction="hide" title="添加变更" width="400"  autoScroll="true" modal="true">
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
<!-- 社会组织名称变更 -->
<next:Window id="AddChange0" closeAction="hide" title="名称变更" width="600"  autoScroll="true" modal="true">
	<next:TopBar>
		<next:ToolBarItem text='' id="displayItem" />
		<next:ToolBarItem symbol="名称变更"></next:ToolBarItem>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="确定" iconCls="add" handler="forNameMove" ></next:ToolBarItem>
		<next:ToolBarItem text="关闭" iconCls="return" handler="closeChangeWin"></next:ToolBarItem>
	</next:TopBar>
<next:Html>
	<form method="post" onsubmit="return false" class="L5form" dataset="somChangeDataset">

<table width="100%">
			<tr>
				<td class="FieldLabel" style="width:25%"><label>名称变更前：</label></td>
				<td class="FieldInput"style="width:75%" colspan="3">
				<input id='nameBefore' type="text"  style="width:98%"/>
				</td>
			</tr>
			<tr>
				<td class="FieldLabel" style="width:15%"><label>社会团体类别变更前：</label></td>
				<td class="FieldInput"style="width:15%"><select  id="sorgGroupKindBefore" ><option  dataset="sorgKindSelect"></option></select></td>
				<td class="FieldLabel" style="width:25%"><label>所属行（事）业变更前：</label></td>
				<td class="FieldInput"style="width:25%"><select  id="sorgBusScopeBefore"><option  dataset="busScopeSelect"></option></select></td>
			</tr>
			<tr>
				<td class="FieldLabel"style="width:15%"><label style="color:blue">名称变更为：</label></td>
				<td class="FieldInput"style="width:15%" colspan="3"><input id='nameAfter' type="text"  style="width:98%"/></td>
			</tr>
			<tr>
				<td class="FieldLabel" style="width:15%"><label style="color:blue">社会团体类别变更为：</label></td>
				<td class="FieldInput"style="width:15%"><select  id="sorgGroupKindAfter"><option  dataset="sorgKindSelect"></option></select></td>
				<td class="FieldLabel" style="width:15%"><label style="color:blue">所属行（事）业变更为：</label></td>
				<td class="FieldInput"style="width:15%"><select  id="sorgBusScopeAfter"><option  dataset="busScopeSelect"></option></select></td>
			</tr>
			<tr>
				<td class="FieldLabel"><label style="color:blue">变更理由：</label></td>
				<td class="FieldInput" colspan="5"><textArea cols="75" id="nameReason" rows="4" style="width: 100%" field="changeReason"></textArea></td>
			</tr>
		</table>

		</form>
	</next:Html>
</next:Window>

<!-- 负责人变更 -->
<next:Window id="AddChange2" closeAction="hide" title="负责人变更" width="600"  autoScroll="true" modal="true">
	<next:TopBar>
		<next:ToolBarItem text='' id="displayItem" />
		<next:ToolBarItem symbol="负责人变更"></next:ToolBarItem>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="确定" iconCls="add" handler="forLeaPeopleMove" ></next:ToolBarItem>
		<next:ToolBarItem text="关闭" iconCls="return" handler="closeChangeWin"></next:ToolBarItem>
	</next:TopBar>
	<next:Html>
	<form method="post" onsubmit="return false" class="L5form"dataset="somChangeDataset">

<table width="100%">
			<tr>
				<td class="FieldLabel" style="width:15%"><label>负责人姓名变更前：</label></td>
				<td class="FieldInput"style="width:15%"><input id='leaPeopleNameBefore' type="text"  style="width:98%"/>
				</td>
				<td class="FieldLabel"style="width:15%" style="color:blue"><label>负责人姓名变更为：</label></td>
				<td class="FieldInput"style="width:15%"><input id="leaPeopleNameAfter" type="text"  onclick="add()" readonly="readonly" /></td>
			</tr>
			<tr>
				<td class="FieldLabel"><label style="color:blue">变更理由：</label></td>
				<td class="FieldInput" colspan="5"><textArea id="leaPeopleReason" cols="75" rows="4" style="width: 100%" field="changeReason"></textArea></td>
			</tr>
		</table>

		</form>
	</next:Html>
</next:Window>
<!-- 住所变更 -->
<next:Window id="AddChange1" closeAction="hide" title="住所变更" width="500"  autoScroll="true" modal="true">
	<next:TopBar>
		<next:ToolBarItem text='' id="displayItem" />
		<next:ToolBarItem symbol="住所变更"></next:ToolBarItem>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="确定" iconCls="add" handler="forHouseMove" ></next:ToolBarItem>
		<next:ToolBarItem text="关闭" iconCls="return" handler="closeChangeWin"></next:ToolBarItem>
	</next:TopBar>
	<next:Html>
	<form method="post" onsubmit="return false" class="L5form"dataset="somChangeDataset">

<table width="100%">
			<tr>
				<td class="FieldLabel" style="width:25%"><label>住所来源变更前：</label></td>
				<td class="FieldInput"style="width:25%"><select  id="houseSourceBefore"><option  dataset="resideSourceSelect"></option></select></td>
				<td class="FieldLabel"><label>用房面积变更前：</label></td>
				<td class="FieldInput">
				<input id='houseAreaBefore' type="text"  style="width:98%"/>
				</td>
				</tr>
			<tr>
				<td class="FieldLabel"><label>住所名称变更前：</label></td>
				<td class="FieldInput" colspan="3">
				<input id='houseNameBefore' type="text"  style="width:98%"/>
				</td>
			</tr>
			<tr>
				<td class="FieldLabel"><label>产权单位变更前：</label></td>
				<td class="FieldInput" colspan="3">
				<input id='houseBorgBefore' type="text"  style="width:98%"/>
				</td>
			</tr>
			<tr>
				<td class="FieldLabel"><label>租借期限变更前：</label></td>
				<td class="FieldInput" colspan="3">
				<input id='houseDateBefore' type="text"  style="width:98%"/>
				</td>
			</tr>
			<tr>
				<td class="FieldLabel"style="width:15%"><label style="color:blue">住所来源变更为：</label></td>
				<td class="FieldInput"style="width:15%"><select id="houseSourceAfter" ><option dataset="resideSourceSelect"></option ></select></td>
				<td class="FieldLabel"><label style="color:blue">用房面积变更为：</label></td>
				<td class="FieldInput"><input type="text"  id="houseAreaAfter" /></td>
			</tr>
			<tr>
				<td class="FieldLabel"><label style="color:blue">住所名称变更为：</label></td>
				<td class="FieldInput" colspan="3"><input id="houseNameAfter" type="text" style="width:98%"/></td>
			</tr>
			<tr>
				<td class="FieldLabel"><label style="color:blue">产权单位变更为：</label></td>
				<td class="FieldInput" colspan="3"><input id="houseBorgAfter" type="text" style="width:98%"/></td>
			</tr>

			<tr>
				<td class="FieldLabel"><label style="color:blue">租借期限变更为：</label></td>
				<td class="FieldInput"><input type="text" id="houseDateAfter" /></td>
			</tr>
			<tr>
				<td class="FieldLabel"><label style="color:blue">变更理由：</label></td>
				<td class="FieldInput" colspan="5"><textArea id="houseReason" cols="75" rows="4" style="width: 100%" field="changeReason"></textArea></td>
			</tr>
		</table>

		</form>
	</next:Html>
</next:Window>
<!-- 业务范围变更 -->
<next:Window id="AddChange3" closeAction="hide" title="业务范围变更" width="600"  autoScroll="true" modal="true">
	<next:TopBar>
		<next:ToolBarItem text='' id="displayItem" />
		<next:ToolBarItem symbol="业务范围变更"></next:ToolBarItem>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="确定" iconCls="add" handler="forBusinessMove" ></next:ToolBarItem>
		<next:ToolBarItem text="关闭" iconCls="return" handler="closeChangeWin"></next:ToolBarItem>
	</next:TopBar>
	<next:Html>
	<form method="post" onsubmit="return false" class="L5form"dataset="somChangeDataset">

<table width="100%">
			<tr>
				<td class="FieldLabel" style="width:25%"><label>业务范围变更前：</label></td>
				<td class="FieldInput" style="width:75%"><textArea id="businessNameBefore" field="changeBefore" cols="75" rows="4" style="width: 100%" ></textArea></td>
			</tr>
			<tr>
				<td class="FieldLabel"style="width:15%"><label style="color:blue">业务范围变更为：</label></td>
				<td class="FieldInput" style="width:15%"><textArea id="businessNameAfter" field="changeAfter" cols="75" rows="4" style="width: 100%" ></textArea></td>
			</tr>
			<tr>
				<td class="FieldLabel"><label style="color:blue">变更理由：</label></td>
				<td class="FieldInput" colspan="5"><textArea id="businessReason" cols="75" rows="4" style="width: 100%" field="changeReason"></textArea></td>
			</tr>
		</table>

		</form>
	</next:Html>
</next:Window>


<!-- 社会团体名称变更 -->
<next:Window id="detail0" closeAction="hide" title="名称变更" width="600"  autoScroll="true" modal="true">
	<next:TopBar>
		<next:ToolBarItem text='' id="displayItem" />
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="关闭" iconCls="return" handler="closeChangeWinD"></next:ToolBarItem>
	</next:TopBar>
<next:Html>
	<form method="post" onsubmit="return false" class="L5form">

<table width="100%">
			<tr>
				<td class="FieldLabel" style="width:25%"><label>名称变更前：</label></td>
				<td class="FieldInput"style="width:75%" colspan="3"><label id="nameBefore1"/></td>
			</tr>
			<tr>
				<td class="FieldLabel" style="width:15%"><label>社会团体类别变更前：</label></td>
				<td class="FieldInput"style="width:15%"><select  id="sorgGroupKindBefore1" disabled="disabled"><option  dataset="sorgKindSelect"></option></select></td>
				<td class="FieldLabel" style="width:25%"><label>所属行（事）业变更前：</label></td>
				<td class="FieldInput"style="width:25%"><select  id="sorgBusScopeBefore1" disabled="disabled"><option  dataset="busScopeSelect"></option></select></td>
			</tr>
			<tr>
				<td class="FieldLabel"style="width:15%"><label style="color:blue">名称变更为：</label></td>
				<td class="FieldInput"style="width:15%" colspan="3"><label id='nameAfter1'/></td>
			</tr>
			<tr>
				<td class="FieldLabel" style="width:15%"><label style="color:blue">社会团体类别变更为：</label></td>
				<td class="FieldInput"style="width:15%"><select  id="sorgGroupKindAfter1" disabled="disabled"><option  dataset="sorgKindSelect"></option></select></td>
				<td class="FieldLabel" style="width:15%"><label style="color:blue">所属行（事）业变更为：</label></td>
				<td class="FieldInput"style="width:15%"><select  id="sorgBusScopeAfter1" disabled="disabled"><option  dataset="busScopeSelect"></option></select></td>
			</tr>
			<tr>
				<td class="FieldLabel"><label style="color:blue">变更理由：</label></td>
				<td class="FieldInput" colspan="5"><textArea cols="75" rows="4" style="width: 100%" id="namechangeReason" readonly="readonly"></textArea></td>
			</tr>
		</table>

		</form>
	</next:Html>
</next:Window>

<!-- 法定代表人变更 -->
<next:Window id="detail2" closeAction="hide" title="负责人变更" width="600"  autoScroll="true" modal="true">
	<next:TopBar>
		<next:ToolBarItem text='' id="displayItem" />
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="查看负责人信息" iconCls="add" handler="addLegalPeople" ></next:ToolBarItem>
		<next:ToolBarItem text="关闭" iconCls="return" handler="closeChangeWinD"></next:ToolBarItem>
	</next:TopBar>
	<next:Html>
	<form method="post" onsubmit="return false" class="L5form">

<table width="100%">
			<tr>
				<td class="FieldLabel" style="width:15%"><label>负责人姓名变更前：</label></td>
				<td class="FieldInput"style="width:15%"><label  id="leaPeopleNameBefore1" /></td>
				<td class="FieldLabel"style="width:15%" style="color:blue"><label>负责人姓名变更为：</label></td>
				<td class="FieldInput"style="width:15%"><label id='leaPeopleNameAfter1'/></td>
			</tr>
			<tr>
				<td class="FieldLabel"><label style="color:blue">变更理由：</label></td>
				<td class="FieldInput" colspan="5"><textArea cols="75" rows="4" style="width: 100%" readonly="readonly" id="peoplechangeReason"></textArea></td>
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
	<form method="post" onsubmit="return false" class="L5form">

<table width="100%">
			<tr>
				<td class="FieldLabel" style="width:25%"><label>住所来源变更前：</label></td>
				<td class="FieldInput"style="width:25%"><select  id="houseSourceBefore1" disabled="disabled"><option  dataset="resideSourceSelect"></option></select></td>
				<td class="FieldLabel"><label>用房面积变更前：</label></td>
				<td class="FieldInput"><label  id="houseAreaBefore1"  /></td>
				</tr>
			<tr>
				<td class="FieldLabel"><label>住所名称变更前：</label></td>
				<td class="FieldInput" colspan="3"><label id="houseNameBefore1"/></td>
			</tr>
			<tr>
				<td class="FieldLabel"><label>产权单位变更前：</label></td>
				<td class="FieldInput" colspan="3"><label id="houseBorgBefore1" /></td>
			</tr>
			<tr>
				<td class="FieldLabel"><label>租借期限变更前：</label></td>
				<td class="FieldInput" colspan="3"><label id="houseDateBefore1" /></td>
			</tr>
			<tr>
				<td class="FieldLabel"style="width:25%"><label style="color:blue">住所来源变更为：</label></td>
				<td class="FieldInput"style="width:25%"><select id="houseSourceAfter1" disabled="disabled"><option dataset="resideSourceSelect"></option ></select></td>
				<td class="FieldLabel"style="width:25%"><label style="color:blue">用房面积变更为：</label></td>
				<td class="FieldInput"style="width:25%"><label   id="houseAreaAfter1" /></td>
			</tr>
			<tr>
				<td class="FieldLabel"><label style="color:blue">住所名称变更为：</label></td>
				<td class="FieldInput" colspan="3"><label id="houseNameAfter1"  style="width:98%"/></td>
			</tr>
			<tr>
				<td class="FieldLabel"><label style="color:blue">产权单位变更为：</label></td>
				<td class="FieldInput" colspan="3"><label id="houseBorgAfter1"  style="width:98%"/></td>
			</tr>

			<tr>
				<td class="FieldLabel"><label style="color:blue">租借期限变更为：</label></td>
				<td class="FieldInput" colspan="3"><label type="text" id="houseDateAfter1" /></td>
			</tr>
			<tr>
				<td class="FieldLabel"><label style="color:blue">变更理由：</label></td>
				<td class="FieldInput" colspan="3"><textArea cols="75" readonly="readonly" rows="4" style="width: 100%" id="housechangeReason"></textArea></td>
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
	<form method="post" onsubmit="return false" class="L5form">

<table width="100%">
			<tr>
				<td class="FieldLabel" style="width:25%"><label>业务范围变更前：</label></td>
				<td class="FieldInput"style="width:75%"><textArea  id='areaChangeBefore' readonly="readonly" cols="75" rows="4" style="width: 100%"></textArea></td>
			</tr>
			<tr>
				<td class="FieldLabel"style="width:15%"><label style="color:blue">业务范围变更为：</label></td>
				<td class="FieldInput"style="width:15%"><textArea  id="areaChangeAfter" readonly="readonly" cols="75" rows="4" style="width: 100%"></textArea></td>
			</tr>
			<tr>
				<td class="FieldLabel"><label style="color:blue">变更理由：</label></td>
				<td class="FieldInput" colspan="5"><textArea readonly="readonly"  cols="75" rows="4" style="width: 100%" id="areaChangeReason"></textArea></td>
			</tr>
		</table>

		</form>
	</next:Html>
</next:Window>


<!-- 负责人录入窗口 -->
<next:Window id="legalPeopleWindow" title="负责人登记表" resizable="false" width="800" height="430" closeAction="hide" modal="true">
	<next:FitLayout>
	<next:TabPanel id="tabSomOrgan">
			<next:Tabs>
			<next:Panel id="panel_win" title="基本信息" autoScroll="true" width="770" height="85%">
				<next:Html>
					<form title="负责人信息" id="addForm" method="post" dataset="somLegalPeopleDataSet" onsubmit="return false" class="L5form">
						<table width="100%">
							<tr>
								<td class="FieldLabel" style="width:15%">身份证号码：</td>
								<td class="FieldInput" style="width:21%"><input type="text" id="idCard" field="idCard" name='"身份证号码"' onblur="checkPeopleInfo()" style="width:90%"/><span style="color:red">*</span></td>
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
									</select><span style="color:red">*</span>
								</td>
								<td class="FieldLabel">任职开始日期：</td>
								<td class="FieldInput"><input type="text" field="startDate" name='"任职开始日期"' onClick="WdatePicker()"style="width:90%"/><span style="color:red">*</span></td>
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
								<td class="FieldInput"><input type="text" id="promiseOrgan_add"field="promiseOrgan" style="width:90%;display:none"/></td>
								<td class="FieldLabel">批准文号：</td>
								<td class="FieldInput"><input type="text" id="promiseCode_add" field="promiseCode"style="width:90%;display:none"/></td>
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
			<next:EditGridPanel id="somResumeLegalGrid" dataset="somLegalPeopleResumeDataSet" stripeRows="true" title="本人简历" width="770" height="85%" autoScroll="true">
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
					<next:PagingToolBar dataset="somLegalPeopleResumeDataSet" />
				</next:BottomBar>
			</next:EditGridPanel>
			<next:EditGridPanel id="uploadLegalPeopleGrid" title="法律要件" stripeRows="true" dataset="somLegalPeopleElectronicDataSet" width="770" height="85%" autoScroll="true">
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
					<next:Column header="下载附件" field="" width="10%" editable="false" renderer="clickDownloadPeopleHref">
						<next:TextField />
					</next:Column>
				</next:Columns>
				<next:BottomBar>
					<next:PagingToolBar dataset="somLegalPeopleElectronicDataSet" />
				</next:BottomBar>
			</next:EditGridPanel>
		</next:Tabs>
	</next:TabPanel>
	</next:FitLayout>
	<next:Buttons>
		<next:ToolButton text="确定" handler="confirmInfo"></next:ToolButton>
		<next:ToolButton text="关闭" handler="closePeopleWin"></next:ToolButton>
	</next:Buttons>
</next:Window>
<jsp:include page="../../../../../../cams/sorg/comm/upload/uploadWindow.jsp" flush="true"/>
</body>
</html>