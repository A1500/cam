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
<title>民非章程核准</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="ungovRuleDetail.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams/sorgUpload.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"My97DatePicker/WdatePicker.js") %>'></script>
<script type="text/javascript">
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
	var applyType='<%=ApplyType.SOM_UNGOV_RULE_CHECK%>';//业务类型
	var sorgType='<%=request.getParameter("sorgType")%>';
	var taskCode='<%=taskCode%>';
	var sorgId='<%=sorgId%>';
	var rootPath="<%=SkinUtils.getRootUrl(request)%>";
	var morgArea='<%=organArea%>';
	var userId='<%=userId%>';
	var cnName=decodeURIComponent('<%=request.getParameter("cnName")%>');
	var ruleId='<%=request.getParameter("ruleId")%>';
</script>
</head>
<body>
<model:datasets>
	<model:dataset id="somRuleDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomRuleQueryCmd" method="queryRule">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomRule">
			<model:field name="meetingName" type="string" rule="require|length{100}"/>
			<model:field name="meetingFormat" type="string" rule="require|length{30}"/>   
			<model:field name="meetingDate" type="string" rule="require"/>             
			<model:field name="shouldNum" type="string" rule="require|number"/>
			<model:field name="realNum" type="string" rule="require|number"/>
			<model:field name="passNum" type="string" rule="require|number"/>
			<model:field name="nopassNum" type="string" rule="require|number"/>
			<model:field name="giveupNum" type="string" rule="require|number"/>
			<model:field name="mainQuestion" type="string" rule="require|length{500}"/>      
		</model:record>
	</model:dataset>
	<model:dataset id="somOrganDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomOrganQueryCmd"  method="queryOrganOnline" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomOrgan">
		</model:record>
	</model:dataset>
	<model:dataset id="somApplyDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomApplyQueryCmd"  global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomApply">
			<model:field name="borgOpinion" type="string" rule="require|length{300}"/>
			<model:field name="borgName" type="string" rule="require"/>   
			<model:field name="borgCheckDate" type="string" rule="require"/>   
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
			<model:param name="filterSql" value='<%="MORG_CODE ="+organArea.substring(0,6)%>'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="yesornoDataSet" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
</model:datasets>
<next:Panel  width="100%" >
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="return" text="返回" handler="returnBackHistory"></next:ToolBarItem>
	</next:TopBar>
	<next:TabPanel id="tabSomOrgan" width="100%" height="100%">	
		<next:Tabs>
			<next:Panel id="panelSomOrgan" title="民办非企业单位章程核准表" width="100%" height="100%" autoScroll="true">		
				<next:Html>
					<form id="ruleForm" method="post" dataset="somRuleDataSet" onsubmit="return false" class="L5form">
						<fieldset>
						<legend>民办非企业单位章程</legend>
						<input type="hidden" id="sorgId" field="sorgId" value="民办非企业单位ID">
						<table width="100%">
							<tr>
								<td class="FieldLabel">单位名称：</td>
								<td class="FieldInput" colspan="3"><label id="cnName" maxlength="50" style="width:96%">
								<td class="FieldLabel">登记证号：</td>
								<td class="FieldInput"><label id="sorgCode" maxlength="20" style="width:85%">
							</tr>
							<tr>
								<td class="FieldLabel">会议名称：</td>
								<td class="FieldInput" colspan="3"><label type="text" id="meetingName" field="meetingName" maxlength="100" style="width:96%" name="会议名称"></td>
								<td class="FieldLabel">会议形式：</td>
								<td class="FieldInput"><label type="text" id="meetingFormat" field="meetingFormat" maxlength="30" style="width:85%" name="会议形式"></td>
							</tr>
							<tr>
								<td class="FieldLabel" style="width:17%">时间：</td>
								<td class="FieldInput" style="width:17%"><label type="text" id="meetingDate" field="meetingDate" readonly="readonly" style="width:85%" name="时间"></td>
								<td class="FieldLabel" style="width:17%">应到人数：</td>
								<td class="FieldInput" style="width:15%"><label type="text" name="应到人数" id="shouldNum" field="shouldNum" maxlength="6" style="width:85%"></td>
								<td class="FieldLabel" style="width:17%">实到人数：</td>
								<td class="FieldInput" style="width:17%"><label type="text" name="实到人数" id="realNum" field="realNum" maxlength="6" style="width:85%"></td>
							</tr>
							<tr>
								<td class="FieldLabel">同意人数：</td>
								<td class="FieldInput"><label type="text" name="同意人数" id="passNum" field="passNum" maxlength="6" style="width:85%"></td>
								<td class="FieldLabel">反对人数：</td>
								<td class="FieldInput"><label type="text" name="反对人数" id="nopassNum" field="nopassNum" maxlength="6" style="width:85%"></td>
								<td class="FieldLabel">弃权人数：</td>
								<td class="FieldInput"><label type="text" name="弃权人数" id="giveupNum" field="giveupNum" maxlength="6" style="width:85%"></td>
							</tr>
							<tr>
								<td class="FieldLabel">需说明的主要问题：</td>
								<td class="FieldInput" colspan="5"><textarea disabled name="需说明的主要问题" id=mainQuestion field="mainQuestion" cols="65" rows="4" style="width:97%"></textarea></td>
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
								<td class="FieldInput" colspan="5"><textarea disabled field="borgOpinion" cols="65" rows="3" style="width:97%" name="业务主管单位审查意见"></textarea></td>
							</tr>
							<tr>
								<td class="FieldLabel" style="width:17%">业务主管单位：</td>
								<td class="FieldInput" style="width:49%">
									<label name="业务主管单位" field="borgName" dataset="businessOrganSelect" style="width:96%">
									</label>
								</td>
								<td class="FieldLabel" style="width:17%">业务主管单位审查日期：</td>
								<td class="FieldInput" style="width:17%"><label type="text" field="borgCheckDate" readonly="readonly" style="width:85%" name="业务主管单位审查日期"></td>
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
		</next:Tabs>
	</next:TabPanel>	
</next:Panel>
<jsp:include page="../../../../../../cams/sorg/comm/upload/uploadWindow.jsp" flush="true"/>
</body>
</html>