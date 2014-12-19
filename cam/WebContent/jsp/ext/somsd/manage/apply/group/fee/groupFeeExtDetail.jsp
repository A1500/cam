<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.StrUtil"%>
<%@page import="com.inspur.cams.sorg.util.ApplyType"%>
<%@ page import="com.inspur.cams.comm.extuser.data.ComExtUser"%>
<%@ page import="com.inspur.cams.sorg.online.extuser.util.SomExtBspInfo"%>
<%@page import="com.inspur.cams.sorg.online.apply.util.SomIdHelpOnline"%>
<html>
<head>
<title>社会团体会费标准备案</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="groupFeeExtDetail.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams/sorgUpload.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"My97DatePicker/WdatePicker.js") %>'></script>
<%
		ComExtUser comExtUser = (ComExtUser)SomExtBspInfo.getUserInfo(request).getComExtUser();
		String username = comExtUser.getUserName();
		String organArea = comExtUser.getAreaCode();//获取外部单位行政区划12位
		String userId = comExtUser.getUserId();
		String sorgId ="";
		String taskCode ="";
			sorgId = request.getParameter("sorgId");
			taskCode = request.getParameter("taskCode") ;
	%>
<script type="text/javascript">
	var applyType='<%=ApplyType.SOM_GROUP_FEE%>';//业务类型
	var sorgType='<%=request.getParameter("sorgType")%>';
	var taskCode='<%=taskCode%>';
	var sorgId='<%=sorgId%>';
	var rootPath="<%=SkinUtils.getRootUrl(request)%>";
	var morgArea='<%=organArea%>';
	var userId='<%=userId%>';
	var cnName=decodeURIComponent('<%=request.getParameter("cnName")%>');
	var feeId='<%=request.getParameter("feeId")%>';
</script>
</head>
<body>
<model:datasets>
	<model:dataset id="somFeeDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomFeeQueryCmd" method="queryFee" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomFee">
			<model:field name="fee" type="string" rule="length{500}"/>
			<model:field name="regPeople" type="string" rule="length{32}"/>   
			<model:field name="regDate" type="string" rule="length{10}"/>
		</model:record>
	</model:dataset>
	<model:dataset id="somOrganDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomOrganQueryCmd"  method="queryOrganOnline" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomOrgan">
		</model:record>
	</model:dataset>
	<model:dataset id="somApplyDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomApplyQueryCmd"  global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomApply"> </model:record>
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
						<label type="text" id="cnName" maxlength="50" style="width:96%">
						<span style="color:red">*</span></td>
						<td class="FieldLabel">登记证号：</td>
						<td class="FieldInput">
						<label type="text" id="sorgCode" maxlength="20" style="width:85%" ">
						<span style="color:red">*</span></td>
				</tr>
				<tr>
					<td class="FieldLabel" style="width:17%">联系人：</td>
					<td class="FieldInput" style="width:17%"><label type="text" name="linkPeople" id="linkPeople" maxlength="36" field="linkPeople" style="width:90%"/></td>
					<td class="FieldLabel" style="width:17%">联系电话：</td>
					<td class="FieldInput" style="width:15%"><label type="text" name="linkPhone" id="linkPhone" field="linkPhone" maxlength="30"style="width:90%"/></td>
					<td class="FieldLabel" style="width:17%"></td>
					<td class="FieldInput" style="width:17%"></td>
				</tr>
				<tr>
					<td class="FieldLabel">会议名称：</td>
					<td class="FieldInput"><label type="text" name="meetingName" id="meetingName" maxlength="50" field="meetingName" maxlength="100" style="width:90%"/></td>
					<td class="FieldLabel">召开日期：</td>
					<td class="FieldInput"><label type="text" name="meetingDate" id="meetingDate"maxlength="10" field="meetingDate" style="width:90%"  readonly="readonly" /></td>
					<td class="FieldLabel">召开地点：</td>
					<td class="FieldInput"><label type="text" name="meetingPlace" id="meetingPlace"maxlength="50" field="meetingPlace" maxlength="100" style="width:90%"/></td>
				</tr>
				<tr>	
					<td class="FieldLabel" style="width:17%">应到人数：</td>
					<td class="FieldInput" style="width:17%"><label type="text" name="应到人数" id="shouldNum" field="shouldNum" style="width:90%" maxlength="6"/></td>
					<td class="FieldLabel" style="width:17%">实到人数：</td>
					<td class="FieldInput" style="width:15%"><label type="text" name="实到人数" id="realNum" field="realNum" style="width:90%" maxlength="6"/></td>
					<td class="FieldLabel" style="width:17%"></td>
					<td class="FieldInput" style="width:17%"></td>
				</tr>
				<tr>
					<td class="FieldLabel">同意：</td>
					<td class="FieldInput"><label type="text" name="同意" id="passNum" field="passNum" style="width:90%" maxlength="6"/></td>			
					<td class="FieldLabel">不同意：</td>
					<td class="FieldInput"><label type="text" name="不同意" id="nopassNum" field="nopassNum" style="width:90%" maxlength="6"/></td>
					<td class="FieldLabel">弃权：</td>
					<td class="FieldInput"><label type="text" name="弃权" id="giveupNum" field="giveupNum" style="width:90%" maxlength="6"/></td>
				</tr>
				<tr>
					<td class="FieldLabel"><label>会费标准：</label></td>
					<td class="FieldInput" colspan="5"><textarea disabled name="会费标准" id="fee" field="fee" cols="75" rows="12" style="width:95%"></textarea>
				</tr>
				<tr>
					<td class="FieldLabel">备案承办人：</td>
					<td class="FieldInput"><label type="text" name="备案承办人" id="regPeople" field="regPeople" maxlength="30" style="width:90%"/></td>
					<td class="FieldLabel">备案日期：</td>
					<td class="FieldInput"><label type="text" name="备案日期" id="regDate" field="regDate" readonly="readonly" style="width:100%"/></td>
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
<jsp:include page="../../../../../../cams/sorg/comm/upload/uploadWindow.jsp" flush="true"/>
</body>
</html>