<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.*"%>
<%@page import="com.inspur.cams.sorg.util.SomIdHelp"%>
<html>
<head>
<title>基金会章程核准</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="fundRuleEdit.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams/sorgUpload.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"My97DatePicker/WdatePicker.js") %>'></script>
<%
	String taskCode = request.getParameter("taskCode");
	String method=request.getParameter("method");
	if("insert".equals(method)){
		taskCode = StrUtil.n2b(SomIdHelp.getFundTaskCode());
	}
%>
<script type="text/javascript">
	var method='<%=method%>';
	var sorgId='<%=request.getParameter("sorgId")%>';
	var cnName=decodeURIComponent('<%=request.getParameter("cnName")%>');
	var sorgCode='<%=request.getParameter("sorgCode")%>';
	var borgName='<%=request.getParameter("borgName")%>';
	var ruleId='<%=request.getParameter("ruleId")%>';
	var applyType="208";
	var taskCode = '<%=taskCode%>';//生成业务编号
	var searchCnName=decodeURIComponent('<%=request.getParameter("searchCnName")%>');
	var searchSorgCode='<%=request.getParameter("searchSorgCode")%>';
</script>
</head>
<body>
<model:datasets>
	<model:dataset id="somRuleDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomRuleQueryCmd" method="queryRule">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomRule">
			<model:field name="shouldNum" type="string" rule="number"/>
			<model:field name="realNum" type="string" rule="number"/>
			<model:field name="passNum" type="string" rule="number"/>
			<model:field name="nopassNum" type="string" rule="number"/>
			<model:field name="giveupNum" type="string" rule="number"/>
			<model:field name="meetingContent" type="string" rule="length{500}"/>
			<model:field name="borgOpinion" type="string" rule="length{200}"/>
			<model:field name="meetingName" type="string" rule="length{100}"/>
			<model:field name="meetingFormat" type="string" rule="length{30}"/>
		</model:record>
	</model:dataset>
	<model:dataset id="somApplyDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomApplyQueryCmd">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomApply"/>
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
	<model:dataset id="yesornoDataSet" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
</model:datasets>
<next:Panel  width="100%" >
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="save" text="保存" handler="save"></next:ToolBarItem>
		<next:ToolBarItem iconCls="return" text="返回" handler="returnBack"></next:ToolBarItem>
	</next:TopBar>
	<next:TabPanel id="tabSomOrgan" width="100%" height="100%">
		<next:Tabs>
			<next:Panel id="panelSomOrgan" title="基金会章程核准表" width="100%" height="100%" autoScroll="true">
				<next:Html>
					<form id="ruleForm" method="post" dataset="somRuleDataSet" onsubmit="return false" class="L5form">
						<fieldset>
						<legend>基金会章程</legend>
						<input type="hidden" id="sorgId" field="sorgId" value="基金会ID">
						<table width="100%">
							<tr>
								<td class="FieldLabel">基金会名称：</td>
								<td class="FieldInput" colspan="3"><label id="cnName"/></td>
								<td class="FieldLabel">登记证号：</td>
								<td class="FieldInput"><label id="sorgCode"/></td>
							</tr>
							<tr>
								<td class="FieldLabel">会议名称：</td>
								<td class="FieldInput"><input type="text" id="meetingName" field="meetingName" maxlength="100" style="width:90%"></td>
								<td class="FieldLabel">会议形式：</td>
								<td class="FieldInput" colspan="3"><input type="text" id="meetingFormat" field="meetingFormat" maxlength="30" style="width:90%"></td>
							</tr>
							<tr>
								<td class="FieldLabel" style="width:17%">时间：</td>
								<td class="FieldInput" style="width:17%"><input type="text" id="meetingDate" field="meetingDate" format="Y-m-d" onclick="WdatePicker();" style="width:90%"></td>
								<td class="FieldLabel" style="width:17%">应到人数：</td>
								<td class="FieldInput" style="width:15%"><input type="text" name="应到人数" id="shouldNum" field="shouldNum" maxlength="6" style="width:90%"></td>
								<td class="FieldLabel" style="width:17%">实到人数：</td>
								<td class="FieldInput" style="width:17%"><input type="text" name="实到人数" id="realNum" field="realNum" maxlength="6" style="width:90%"></td>
							</tr>
							<tr>
								<td class="FieldLabel">同意人数：</td>
								<td class="FieldInput"><input type="text" name="同意人数" id="passNum" field="passNum" maxlength="6" style="width:90%"></td>
								<td class="FieldLabel">反对人数：</td>
								<td class="FieldInput"><input type="text" name="反对人数" id="nopassNum" field="nopassNum" maxlength="6" style="width:90%"></td>
								<td class="FieldLabel">弃权人数：</td>
								<td class="FieldInput"><input type="text" name="弃权人数" id="giveupNum" field="giveupNum" maxlength="6" style="width:90%"></td>
							</tr>
							<tr>
								<td class="FieldLabel">章程修改内容及说明：</td>
								<td class="FieldInput" colspan="5"><textarea name="章程修改内容及说明" id=mainQuestion field="mainQuestion" cols="65" rows="4" style="width:97%"></textarea></td>
							</tr>
						</table>
						</fieldset>
					</form>
					<form id="form2" method="post" dataset="somApplyDataSet" onsubmit="return false" class="L5form">
						<fieldset>
						<legend>业务主管单位意见</legend>
						<table width="100%">
							<tr>
								<td class="FieldLabel">业务主管单位审查意见：</td>
								<td class="FieldInput" colspan="5"><textarea field="borgOpinion" cols="65" rows="2" style="width:97%"></textarea></td>
							</tr>
							<tr>
								<td class="FieldLabel" style="width:17%">业务主管单位：</td>
								<td class="FieldInput" style="width:17%"><select name="业务主管单位" field="borgName" style="width:90%" disabled="disabled"><option dataset="businessOrganSelect"></option></select></td>
								<td class="FieldLabel" style="width:17%">业务主管单位审查日期：</td>
								<td class="FieldInput" style="width:49%"><input type="text" field="borgCheckDate" format="Y-m-d" onclick="WdatePicker();" style="width:90%"></td>
							</tr>
							</table>
							</fieldset>
							<fieldset>
							<legend>审查意见</legend>
							<table width="100%">
							<tr>
								<td class="FieldLabel" style="width:17%">初审意见：</td>
								<td class="FieldInput" colspan="5"><textarea field="examinOpinion" cols="65" rows="2" style="width:97%"></textarea></td>
							</tr>
							<tr>
								<td class="FieldLabel" style="width:17%">承办人：</td>
								<td class="FieldInput"><input type="text" field="acceptPeopleName" maxlength="6" style="width:90%"></td>
								<td class="FieldLabel" style="width:17%">承办日期：</td>
								<td class="FieldInput" style="width:49%"><input type="text"  field="acceptTime" format="Y-m-d" onclick="WdatePicker();" style="width:90%"></td>
							</tr>
							<tr>
								<td class="FieldLabel" style="width:17%">审核人：</td>
								<td class="FieldInput"><input type="text" field="examinPeopleName" maxlength="6" style="width:90%"></td>
								<td class="FieldLabel" style="width:17%">初审日期：</td>
								<td class="FieldInput" style="width:49%"><input type="text" field="examinTime" format="Y-m-d" onclick="WdatePicker();" style="width:90%"></td>
							</tr>
							<tr>
								<td class="FieldLabel">批准意见：</td>
								<td class="FieldInput" colspan="5"><textarea field="auditOpinion" cols="65" rows="2" style="width:97%"></textarea></td>
							</tr>
							<tr>
								<td class="FieldLabel">审批人：</td>
								<td class="FieldInput"><input type="text" field="auditPeopleName" maxlength="6" style="width:90%"></td>
								<td class="FieldLabel" style="width:17%">批准日期：</td>
								<td class="FieldInput" style="width:49%"><input type="text" field="auditTime" format="Y-m-d" onclick="WdatePicker();" style="width:90%"></td>
							</tr>
						</table>
						</fieldset>
					</form>
				</next:Html>
			</next:Panel>

			<next:EditGridPanel id="uploadGrid" title="法律要件" width="100%" stripeRows="true" height="100%" dataset="somElectronicDataSet">
				<next:TopBar>
					<next:ToolBarItem symbol="附件列表"></next:ToolBarItem>
					<next:ToolBarItem symbol="->"></next:ToolBarItem>
					<next:ToolBarItem iconCls="add" text="增加上传附件" handler="clickUploadFile"></next:ToolBarItem>
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
		</next:Tabs>
	</next:TabPanel>
</next:Panel>
<jsp:include page="../../comm/upload/uploadWindow.jsp" flush="true"/>
</body>
</html>