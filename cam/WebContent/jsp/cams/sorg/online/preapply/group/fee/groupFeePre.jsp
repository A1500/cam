<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.StrUtil"%>
<%@page import="com.inspur.cams.sorg.util.SomIdHelp"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
<head>
<title>社会团体会费标准备案</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="groupFeePre.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams/sorgUpload.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams/sorgOnline.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"My97DatePicker/WdatePicker.js") %>'></script>
<%
	String taskCode = request.getParameter("taskCode");
%>
<script type="text/javascript">
	var sorgId='';
	var applyType="016";
	var taskCode = '<%=taskCode%>';//生成业务编号
	var sorgIdExist='';
	var morgArea='<%=BspUtil.getOrganCode()%>';
</script>
</head>
<body>
<model:datasets>
	<!-- 更改业务状态所用dataset -->
	<model:dataset id="updateStatusDataSet" cmd="com.inspur.cams.sorg.online.base.cmd.SomApplyOnlineQueryCommand"  global="true" sortField="createTime" sortDirection="DESC">
		<model:record fromBean="com.inspur.cams.sorg.online.base.data.SomApplyOnline"></model:record>
	</model:dataset>
	<model:dataset id="somApplyDataSet" cmd="com.inspur.cams.sorg.online.base.cmd.SomApplyOnlineQueryCommand">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomApply"/>
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
	<model:dataset id="somFeeDataSet" cmd="com.inspur.cams.sorg.online.base.cmd.SomFeeOnlineQueryCommand" method="queryFee">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomFee"/>
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
<next:Panel width="100%" height="100%" autoScroll="true">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="undo" text="退回" handler="updateOnlineStatusAndSeason"></next:ToolBarItem>
		<next:ToolBarItem iconCls="save" text="保存" handler="save"></next:ToolBarItem>
		<next:ToolBarItem iconCls="return" text="返回" handler="returnBack"></next:ToolBarItem>
	</next:TopBar>
	<next:TabPanel width="100%" height="100%" id="tab">
	<next:Tabs>
	<next:Panel title="社会团体会费标准备案" width="100%" >
		<next:Panel width="100%" height="100%" autoScroll="true">
		<next:Html>
		<form id="feeForm" method="post" dataset="somFeeDataSet" onsubmit="return false" class="L5form">
			<fieldset>
			<legend>社会团体会费标准备案</legend>
			<input type="hidden" id="sorgId" field="sorgId" value="社团ID">
			<table width="100%">
				<tr>
					<td class="FieldLabel">社团名称：</td>
					<td class="FieldInput" colspan="3">
					<input type="text" id="cnName"  style="width:90%">
					</td>
					<td class="FieldLabel">登记证号：</td>
					<td class="FieldInput">
					<input type="text" id="sorgCode" onchange="checkSorgCode()" style="width:90%">
					</td>
				</tr>
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
					<td class="FieldInput"><input type="text" id="meetingName" field="meetingName"  style="width:90%" onclick="showMeeting()" readonly><span style="color:red">*</span></td>
					<td class="FieldLabel">召开日期：</td>
					<td class="FieldInput"><input type="text" name="meetingDate" id="meetingDate" field="meetingDate" style="width:90%" format="Y-m-d" onclick="WdatePicker();" /></td>
					<td class="FieldLabel">召开地点：</td>
					<td class="FieldInput"><input type="text" name="meetingPlace" id="meetingPlace" field="meetingPlace" maxlength="100" style="width:90%"/></td>
				</tr>
				<tr>
					<td class="FieldLabel" style="width:17%">应到人数：</td>
					<td class="FieldInput" style="width:17%"><input type="text" name="应到人数" id="shouldNum" field="shouldNum" style="width:90%" maxlength="6"/></td>
					<td class="FieldLabel" style="width:17%">实到人数：</td>
					<td class="FieldInput" style="width:15%"><input type="text" name="实到人数" id="realNum" field="realNum" style="width:90%" maxlength="6"/></td>
					<td class="FieldLabel" style="width:17%"></td>
					<td class="FieldInput" style="width:17%"></td>
				</tr>
				<tr>
					<td class="FieldLabel">同意：</td>
					<td class="FieldInput"><input type="text" name="同意" id="passNum" field="passNum" style="width:90%" maxlength="6"/></td>
					<td class="FieldLabel">不同意：</td>
					<td class="FieldInput"><input type="text" name="不同意" id="nopassNum" field="nopassNum" style="width:90%" maxlength="6"/></td>
					<td class="FieldLabel">弃权：</td>
					<td class="FieldInput"><input type="text" name="弃权" id="giveupNum" field="giveupNum" style="width:90%" maxlength="6"/></td>
				</tr>
				<tr>
					<td class="FieldLabel"><label>会费标准：</label></td>
					<td class="FieldInput" colspan="5"><textarea name="会费标准" id="fee" field="fee" cols="75" rows="12" style="width:95%"></textarea>
				</tr>
				<tr>
					<td class="FieldLabel">备案承办人：</td>
					<td class="FieldInput"><input type="text" name="备案承办人" id="regPeople" field="regPeople" maxlength="30" style="width:90%"/></td>
					<td class="FieldLabel">备案日期：</td>
					<td class="FieldInput"><input type="text" name="备案日期" id="regDate" field="regDate" format="Y-m-d" onclick="WdatePicker();" style="width:100%"/></td>
					<td class="FieldLabel"></td>
					<td class="FieldInput"></td>
				</tr>
				<tr>
					<td class="FieldInput" colspan="6"><font color="red">说明：会费标准的内容，必须在500字符之内。</font></td>
				</tr>
		</table>
		</fieldset>
	</form>
	</next:Html>
</next:Panel>
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
						<next:Column header="下载附件"    field="" width="10%" editable="false" renderer="clickDownloadHref"><next:TextField /></next:Column>
					</next:Columns>
					<next:BottomBar>
						<next:PagingToolBar dataset="somElectronicDataSet" />
					</next:BottomBar>
				</next:EditGridPanel>
			</next:Panel>
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
			<next:Column header="是否章程核准" field="RULESATUS" width="150" editable="false"><next:TextField /></next:Column>
			<next:Column header="是否会费标准备案" field="FEESATUS" width="150" editable="false"><next:TextField /></next:Column>
			<next:Column header="是否负责人换届备案" field="SESSIONSATUS" width="150" editable="false"><next:TextField /></next:Column>
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
</body>
</html>