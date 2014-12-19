<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.StrUtil"%>
<%@page import="com.inspur.cams.sorg.util.SomIdHelp"%>
<%@page import="com.inspur.cams.comm.util.*"%>
<%@page import="com.inspur.cams.sorg.util.ApplyType"%>
<%@ page import="com.inspur.cams.comm.extuser.data.ComExtUser"%>
<%@ page import="com.inspur.cams.sorg.online.extuser.util.SomExtBspInfo"%>
<%@page import="com.inspur.cams.sorg.online.apply.util.SomIdHelpOnline"%>
<html>
<head>
<title>社会团体延期换届选举报批</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="groupDelayElectionDetail.js"></script>
<script type="text/javascript" src="<%=SkinUtils.getJS(request, "bpm/bpm.js")%>"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js") %>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js") %>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams/sorgComm.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams/sorgUpload.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"My97DatePicker/WdatePicker.js") %>'></script>
<script type="text/javascript">var rootPath='<%=SkinUtils.getRootUrl(request)%>';</script>
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
		var applyType='<%=ApplyType.SOM_GROUP_ELECTION_CHECK_DELAY%>';//业务类型
		var sorgId='<%=sorgId%>';
		var taskCode='<%=taskCode%>';//业务编号
		var somApplyType='<%=ApplyType.SOM_GROUP_CHANGE%>';//业务类型
		var morgArea='<%=organArea%>';
		var userId='<%=userId%>';			
</script>
</head>
<body>
<model:datasets>
	<model:dataset id="somOrganDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomOrganQueryCmd"  method="queryOrganOnline" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomOrgan">
		</model:record>
	</model:dataset>
	<model:dataset id="somElectionDataSet" cmd="com.inspur.cams.sorg.history.election.cmd.SomElectionQueryCmd" method="queryElection" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomElection">
			<model:field name="linkPeople" type="string" rule="length{72}" />
			<model:field name="linkPhone" type="string" rule="length{30}" />
			<model:field name="lastDate" type="string" rule="length{10}" />
			<model:field name="nextDate" type="string" rule="length{10}" />
			<model:field name="delayDate" type="string" rule="length{10}" />
			<model:field name="delayReason" type="string" rule="length{500}" />
			<model:field name="process" type="string" rule="length{500}" />
		</model:record>
	</model:dataset>
	<!-- 业务 -->
	<model:dataset id="somApplyDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomApplyQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomApply">
			<model:field name="curOpinionId" type="string" rule="require" />
			<model:field name="curOpinion" type="string" rule="length{200}" />
		</model:record>
	</model:dataset>
	<%--电子档案--%>
	<model:dataset id="somElectronicDataSet" cmd="com.inspur.cams.sorg.upload.cmd.SomElectronicQueryCmd" global="true" method="queryCatalog">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomElectronic">
			<model:field name="linkPeople" type="string" rule="length{72}" />
			<model:field name="linkPhone" type="string" rule="length{30}" />
			<model:field name="lastDate" type="string" rule="length{10}" />
			<model:field name="nextDate" type="string" rule="length{10}" />
			<model:field name="delayDate" type="string" rule="length{10}" />
			<model:field name="delayReason" type="string" rule="length{500}" />
			<model:field name="process" type="string" rule="length{500}" />
		</model:record>
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
	<model:dataset id="businessOrganSelect"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true" sortField="ORDER_NUMBER">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='SOM_BUSINESS_ORGAN'></model:param>
			<model:param name="value" value='BORG_CODE'></model:param>
			<model:param name="text" value='BORG_NAME'></model:param>
			<model:param name="filterSql" value='<%="MORG_CODE ="+organArea.substring(0,6)%>'></model:param>
			</model:params>
	</model:dataset>		
	<model:dataset id="yesornoDataSet" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="opinionSelect" enumName="WORKFLOW.OPINION" autoLoad="true" global="true"></model:dataset>	
	<model:dataset id="hisOpinionDataSet" enumName="WORKFLOW.OPINION" autoLoad="true" global="true"></model:dataset>

</model:datasets>
<next:Panel width="100%" autoScroll="true">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="return" text="返回" handler="returnBack"></next:ToolBarItem>
	</next:TopBar>
	<next:TabPanel id="tab" width="100%" height="100%" activeTab="0">	
		<next:Tabs>
			<next:Panel title="社会团体延期换届选举报批" width="100%" height="100%" autoScroll="true">	
					<next:Html>
						<form id="ElectionForm" method="post" dataset="somElectionDataSet" onsubmit="return false" class="L5form">
							<input type="hidden" id="sorgId" field="sorgId" value="社会团体ID">
							<fieldset>
							<legend>社会团体延期换届选举报批表</legend>
							<table width="100%">
								<tr>
									<td class="FieldLabel" style="width:16%">登记证号：</td>
									<td class="FieldInput" style="width:30%"><label type="text" name="登记证号" id="sorgCode" maxlength="32" style="width:90%"><font color="red">*</font></td>
									<td class="FieldLabel" style="width:18%">社团名称：</td>
									<td class="FieldInput" style="width:36%">
									<label type="text" name="社团名称" id="cnName" maxlength="32" style="width:90%"><font color="red">*</font>
									</td>
								</tr>
								<tr>
									<td class="FieldLabel">联系人：</td>
									<td class="FieldInput"><label type="text" name="联系人" field="linkPeople" maxlength="36" style="width:90%"></td>
									<td class="FieldLabel">联系电话：</td>
									<td class="FieldInput"><label type="text" name="联系电话" field="linkPhone" maxlength="30" style="width:90%"></td>
								</tr>
								<tr>
									<td class="FieldLabel">上次换届时间：</td>
									<td class="FieldInput"><label type="text" field="lastDate" style="width:90%" readonly="readonly" /></td>
									<td class="FieldLabel">应到届时间：</td>
									<td class="FieldInput"><label type="text" field="nextDate" style="width:90%" readonly="readonly" /></td>
								</tr>
								<tr>
									<td class="FieldLabel">延期换届时间：</td>
									<td class="FieldInput" colspan="3"><label type="text" name="延期换届时间" field="delayDate" readonly="readonly"/><font color="red">*</font></td>
									<td class="FieldLabel"></td>
									<td class="FieldInput"></td>
								</tr>
								<tr>
									<td class="FieldLabel">延期换届事由：</td>
									<td class="FieldInput" colspan="3">
										<textarea disabled field="delayReason" cols="65" rows="5" style="width:97%"></textarea>
									</td>
								</tr>
								<tr>
									<td class="FieldLabel">社团内部履行程序情况：</td>
									<td class="FieldInput" colspan="5"><textarea disabled field="process" cols="65" rows="2" style="width:97%"></textarea></td>
								</tr>
								</table>
							</fieldset>
						</form>
						<form id="form2" method="post" dataset="somApplyDataSet" onsubmit="return false" class="L5form">
						<fieldset>
						<legend>审查意见</legend>
							<table width="100%">
								<tr>
									<td class="FieldLabel" style="width:20%">业务主管单位：</td>
									<td class="FieldInput"  style="width:40%" colspan="2">
									<label type="text" id="borgNameDispaly" style="width:50%"  name="borgNameDispaly"  title="业务主管单位" />
									<div id="popup" style="width:300px; height: 150px; display: none;position: absolute;background-color: #FFFFFF;" >  
 	        							<ul></ul> 
     								</div>
     								<input type="hidden" id="borgName" name="borgName" field="borgName" title="业务主管单位代码"/>
									<span style="color:red">*</span></td>
								
									<td class="FieldLabel" style="width:20%">业务主管单位审查日期：</td>
									<td class="FieldInput" style="width:20%"><label type="text" field="borgCheckDate" readonly="readonly" format="Y-m-d"  style="width:90%"></td>
								</tr>
								<tr>
									<td class="FieldLabel"style="width:20%">业务主管单位审查意见：</td>
									<td class="FieldInput" colspan="4"><textarea disabled field="borgOpinion" cols="65" rows="2" style="width:97%"></textarea></td>
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
<jsp:include page="../../../borg/borgSelectWindow.jsp" flush="true"/>  
</body>
</html>