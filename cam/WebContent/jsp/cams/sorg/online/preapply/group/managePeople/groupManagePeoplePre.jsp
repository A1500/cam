<%@ page language="java" contentType="text/html;charset=utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="com.inspur.cams.comm.util.StrUtil"%>
<%@ page import="com.inspur.cams.sorg.util.SomIdHelp"%>
<html>
<head>
<title>社会团体负责人备案</title> 
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="groupManagePeoplePre.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams/sorgUpload.js")%>'></script>
<script type="text/javascript">var rootPath='<%=SkinUtils.getRootUrl(request)%>';</script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams/somPhoto.js") %>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams/sorgComm.js")%>'></script>
<script type="text/javascript" src="<%=SkinUtils.getRootUrl(request)%>skins/js/ISEditPhoto.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"My97DatePicker/WdatePicker.js") %>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams/sorgOnline.js")%>'></script>

<script type="text/javascript">
	var taskCode='<%=request.getParameter("taskCode")%>'
	var applyType='017';
	var sorgId = '';	
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
	<model:dataset id="somOrganDataSet" cmd="com.inspur.cams.sorg.online.base.cmd.SomOrganOnlineQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomOrgan">
		</model:record>
	</model:dataset>
	<model:dataset id="somOrganDataSetQuery" cmd="com.inspur.cams.sorg.base.cmd.SomOrganQueryCmd"  global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomOrgan">
		</model:record>
	</model:dataset>
	<model:dataset id="somMeetingDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomMeetingQueryCmd" method="qurtyWithBeianInfo" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomMeeting"/>
	</model:dataset>
	<model:dataset id="somSessionQueryDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomSessionQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomSession"></model:record>
	</model:dataset>
	<model:dataset id="somApplyDataSet" cmd="com.inspur.cams.sorg.online.base.cmd.SomApplyOnlineQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomApply">
		</model:record>
	</model:dataset>
	<model:dataset id="somSessionDataSet" cmd="com.inspur.cams.sorg.online.base.cmd.SomSessionOnlineQueryCommand">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomSession"></model:record>
	</model:dataset>
	<model:dataset id="somResumeOnlineDataSet" cmd="com.inspur.cams.sorg.online.base.cmd.SomPeopleResumeOnlineQueryCommand" sortField="startDate" sortDirection="DESC" pageSize="-1">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomPeopleResume"></model:record>
	</model:dataset>
	<model:dataset id="somDutyDataSet" cmd="com.inspur.cams.sorg.online.base.cmd.SomDutyOnlineQueryCommand" method="queryPeople" global="true">
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
	<%--定义字典表--%>
	<model:dataset id="cataLogCodeSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='SOM_CATALOG'></model:param>
			<model:param name="value" value='CATALOG_CODE'></model:param>
			<model:param name="text" value='CATALOG_NAME'></model:param>
		</model:params>
	</model:dataset>	
</model:datasets>

<next:Panel width="100%" autoScroll="true">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="undo" text="退回" handler="updateOnlineStatusAndSeason"></next:ToolBarItem>
		<next:ToolBarItem iconCls="save" text="保存" handler="save"></next:ToolBarItem>
		<next:ToolBarItem iconCls="return" text="返回" handler="returnBack"></next:ToolBarItem>
	</next:TopBar>
	<next:TabPanel id="tabSomOrgan" width="100%" height="100%">	
		<next:Tabs>
			<next:Panel title="社会团体负责人备案表" width="100%" height="100%" autoScroll="true">	
				<next:Panel>		
					<next:Html>
						<fieldset style="overflow:visible;">
						<legend>社会团体信息</legend>
						<form id="form2" dataset="somSessionDataSet" onsubmit="return false" class="L5form">
							<input type="hidden" field="sessionId"/>
							<table width="100%">
								<tr>
									<td class="FieldLabel">登记证号：</td>
									<td class="FieldInput">
									<input type="text" id="sorgCode" name='登记证号' onblur="sorgCodeUK();" style="width:90%"/>
									</td>
									<td class="FieldLabel">社团名称：</td>
									<td class="FieldInput" colspan="3"><label id="cnName" style="width:90%"/></td>
								</tr>
								<tr>
									<td class="FieldLabel">届次名称：</td>
									<td class="FieldInput" colspan="3"><input type="text" id="sessionName" field="sessionName" name='"届次名称"' style="width:90%" onclick="showMeeting()" readonly/><span style="color:red">*</span></td>
									<td class="FieldLabel">本届任期（年）：</td>
									<td class="FieldInput"><input type="text" id="tenure" field="tenure" name='"本届任期（年）"' onblur="setEndDate()" style="width:90%"/></td>
								</tr>
								<tr>
									<td class="FieldLabel" style="width:17%">本届开始日期：</td>
									<td class="FieldInput" style="width:17%"><input type="text" id="startDate" field="startDate" name='"本届开始日期"' onblur="setEndDate()" onclick="WdatePicker()" readonly="readonly" style="width:90%"/></td>
									<td class="FieldLabel" style="width:17%">章程规定换届日期：</td>
									<td class="FieldInput" style="width:15%">
									<input type="text" id="endDate" field="endDate" name='"章程规定换届日期"'  onclick="WdatePicker()" readonly="readonly" style="width:90%"/></td>
									<td class="FieldLabel" style="width:17%"></td>
									<td class="FieldInput" style="width:17%"></td>
								</tr>
							</table>
						</form>
						</fieldset>
					</next:Html>
				</next:Panel>
				<next:EditGridPanel id="peopleGrid" dataset="somDutyDataSet" stripeRows="true" height="99.9%">
					<next:TopBar>
						<next:ToolBarItem symbol="负责人信息"></next:ToolBarItem>
						<next:ToolBarItem symbol="->"></next:ToolBarItem>
						<next:ToolBarItem iconCls="add" text="新增" handler="add"></next:ToolBarItem>
						<next:ToolBarItem iconCls="edit" text="修改" handler="update"></next:ToolBarItem>
						<next:ToolBarItem iconCls="delete" text="删除" handler="del"></next:ToolBarItem>
					</next:TopBar>
					<next:Columns>
						<next:RowNumberColumn/>
						<next:RadioBoxColumn></next:RadioBoxColumn>
						<next:Column header="身份证号" field="idCard" width="15%" editable="false"><next:TextField/></next:Column>
						<next:Column header="姓名" field="name" width="10%" editable="false"><next:TextField/></next:Column>
						<next:Column header="性别" field="sex" width="10%" editable="false"><next:ComboBox dataset="sexDataSet"/></next:Column>
						<next:Column header="出生年月" field="birthday" width="10%" editable="false"><next:TextField/></next:Column>
						<next:Column header="担任职务" field="sorgDuties" width="10%" editable="false"><next:ComboBox dataset="dutySelectDic"/></next:Column>
						<next:Column header="是否法定代表人" field="ifLegal" width="15%" editable="false"><next:ComboBox dataset="yesornoDataSet"/></next:Column>
						<next:Column header="任职状态" field="regStatus" width="10%" editable="false"><next:TextField/><next:ComboBox dataset="regStatusDataSet"/></next:Column>
						<next:Column header="任职开始日期" field="startDate" width="10%" editable="false"><next:TextField/></next:Column>
						<next:Column header="任职结束日期" field="endDate" width="10%" editable="false"><next:TextField/></next:Column>
					</next:Columns>
					<next:BottomBar>
						<next:PagingToolBar dataset="somDutyDataSet" />
					</next:BottomBar>
				</next:EditGridPanel>
			</next:Panel>
			<next:EditGridPanel id="uploadGrid" title="法律要件" width="100%" stripeRows="true" height="100%" dataset="somElectronicDataSet">
				<next:TopBar>
					<next:ToolBarItem symbol="附件列表"></next:ToolBarItem>
					<next:ToolBarItem symbol="->"></next:ToolBarItem>
					<next:ToolBarItem iconCls="add" text="增加上传附件" handler="uploadFile"></next:ToolBarItem>
				</next:TopBar>		
				<next:Columns>
					<next:RowNumberColumn/>
					<next:RadioBoxColumn></next:RadioBoxColumn>
					<next:Column header="档案目录名" field="catalogCode" width="38%" editable="false" dataset="cataLogCodeSelect"><next:TextField /></next:Column>
					<next:Column header="附件名称" field="fileName" width="30%" editable="false"><next:TextField /></next:Column>
					<next:Column header="附件描述" field="fileMess" width="20%" editable="false"><next:TextField /></next:Column>
					<next:Column header="下载附件"    field="" width="10%" editable="false" renderer="clickDownloadHref"><next:TextField /></next:Column>
				</next:Columns>
				<next:BottomBar>
					<next:PagingToolBar dataset="somElectronicDataSet" />
				</next:BottomBar>
			</next:EditGridPanel>			
		</next:Tabs>
	</next:TabPanel>
</next:Panel>	
<next:Window id="meetingWindow" title="换届召开会议信息" closeAction="hide" height="400" width="740" modal="true">
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
<jsp:include page="../../../../comm/people/groupPeopleEdit.jsp" flush="true"/>	
<jsp:include page="../../../../comm/people/peopleWindow.jsp" flush="true"/>
</body>
</html>