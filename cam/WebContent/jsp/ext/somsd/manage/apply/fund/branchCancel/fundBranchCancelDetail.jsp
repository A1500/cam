<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="com.inspur.cams.sorg.util.SomIdHelp"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<%@page import="com.inspur.cams.sorg.util.ApplyType"%>
<%@ page import="com.inspur.cams.comm.extuser.data.ComExtUser"%>
<%@ page import="com.inspur.cams.sorg.online.extuser.util.SomExtBspInfo"%>
<%@page import="com.inspur.cams.sorg.online.apply.util.SomIdHelpOnline"%>
<html>
<head>
<title>基金会分支/代表机构注销登记录入</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="fundBranchCancelDetail.js"></script>
<script type="text/javascript"
	src="<%=SkinUtils.getJS(request,"cams.js") %>"></script>
<script type="text/javascript"
	src="<%=SkinUtils.getJS(request,"camsCheck.js") %>"></script>
<script type="text/javascript"
	src='<%=SkinUtils.getJS(request,"cams/sorgUpload.js")%>'></script>
<script type="text/javascript"
	src='<%=SkinUtils.getJS(request,"My97DatePicker/WdatePicker.js") %>'></script>
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
	var method='<%=request.getParameter("method")%>';
	var taskCode='<%=taskCode%>';
	var sorgId='<%=sorgId%>';
	var rootPath="<%=SkinUtils.getRootUrl(request)%>";
	var morgArea='<%=organArea%>';
	var userId='<%=userId%>';
	var applyType='<%=ApplyType.SOM_FUND_BRANCH_CANCEL%>';//业务类型

</script>
</head>
<body>

<model:datasets>
	<model:dataset id="somApplyDataSet"
		cmd="com.inspur.cams.sorg.base.cmd.SomApplyQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomApply">
			<model:field name="process" type="string" rule="require|length{300}" />
			<model:field name="borgOpinion" type="string"
				rule="require|length{300}" />
		</model:record>
	</model:dataset>
	<model:dataset id="somOrganDataSet"
		cmd="com.inspur.cams.sorg.base.cmd.SomOrganQueryCmd"
		method="queryOrganOnline" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomOrgan">
			<model:field name="sorgCode" type="string" rule="require|length{20}" />
			<model:field name="branchCharger" type="string" rule="require|length{30}" />
			<model:field name="cnName" type="string" rule="require|length{50}" />
			<model:field name="buildDate" type="string" rule="require" />
			<model:field name="mainSorgName" type="string" rule="require|length{50}" />
			<model:field name="mainSorgCode" type="string" rule="require|length{20}" />
			<model:field name="residence" type="string" rule="require|length{50}" />
			<model:field name="sorgPhone" type="string" rule="require|length{30}" />
			<model:field name="cancelDate" type="string" rule="require" />
			<model:field name="borgName" type="string" rule="require|length{100}" />
			<model:field name="cancelReason" type="string" rule="require|length{500}" />
		</model:record>
	</model:dataset>
	<%--电子档案--%>
	<model:dataset id="somElectronicDataSet"
		cmd="com.inspur.cams.sorg.upload.cmd.SomElectronicQueryCmd"
		method="queryCatalog" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomElectronic"></model:record>
	</model:dataset>
	<%--电子档案上传窗口--%>
	<model:dataset id="winElectronicDataSet"
		cmd="com.inspur.cams.sorg.upload.cmd.SomElectronicQueryCmd"
		global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomElectronic"></model:record>
	</model:dataset>
	<%--下载窗口--%>
	<model:dataset id="downloadDataSet"
		cmd="com.inspur.cams.sorg.upload.cmd.SomElectronicQueryCmd"
		method="queryElectronic">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomElectronic"></model:record>
	</model:dataset>
	<model:dataset id="somOrganQueryDataSet"
		cmd="com.inspur.cams.sorg.base.cmd.SomOrganQueryCmd"
		method="queryOrganOnline">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomOrgan">
		</model:record>
	</model:dataset>
	<model:dataset id="sorgKindSelect"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value="DIC_FUND_KIND"></model:param>
			<model:param name="value" value="CODE"></model:param>
			<model:param name="text" value="NAME"></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="cataLogCodeSelect"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value="SOM_CATALOG"></model:param>
			<model:param name="value" value="CATALOG_CODE"></model:param>
			<model:param name="text" value="CATALOG_NAME"></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="cancelReasonSelect"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_CANCEL_REASON'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="opinionSelect" enumName="WORKFLOW.OPINION"
		autoLoad="true" global="true"></model:dataset>
</model:datasets>

<next:ViewPort>
	<next:Panel width="100%" height="100%">
		<next:TopBar>
			<next:ToolBarItem symbol="基金会分支/代表机构注销登记"></next:ToolBarItem>
			<next:ToolBarItem symbol="->"></next:ToolBarItem>
			<next:ToolBarItem iconCls="return" text="返回" handler="goBack"></next:ToolBarItem>
		</next:TopBar>
		<next:TabPanel id="tabSomOrgan" width="100%" height="100%">
			<next:Tabs>
				<next:Panel id="panelSomOrgan" title="基金会分支/代表机构注销登记表" width="100%"
					height="100%" autoScroll="true">
					<next:Html>
						<fieldset>
						<form id="cbForm" method="post" dataset="somOrganDataSet"
							onsubmit="return false" class="L5form">
						<table width="100%">
							<tr>
								<td class="FieldLabel" width="20%"><label>分支/代表机构登记证号：</label></td>
								<td class="FieldInput" width="30%"><label id="sorgCode"
									field="sorgCode" name='"分支/代表机构登记证号"' style="width: 80%"
									maxlength="20" /><font color="red">*</font></td>
								<td class="FieldLabel" width="20%"><label>分支负责人：</label></td>
								<td class="FieldInput" width="30%"><label
									id="branchCharger" field="branchCharger" name='"分支负责人"'
									style="width: 80%" maxlength="30" /><font color="red">*</font></td>
							</tr>
							<tr>
								<td class="FieldLabel"><label>分支/代表机构名称：</label></td>
								<td class="FieldInput"><label field="cnName"
									name='"分支/代表机构名称"' style="width: 80%" maxlength="50" /><font
									color="red">*</font></td>
								<td class="FieldLabel"><label>成立日期：</label></td>
								<td class="FieldInput"><label field="buildDate"
									name='"成立日期"' style="width: 80%" /><font
									color="red">*</font></td>
							</tr>
							<tr>
								<td class="FieldLabel"><label>基金会名称：</label></td>
								<td class="FieldInput"><label id='name'
									field="mainSorgName" name='"基金会名称"' style="width: 80%"
									maxlength="50" /><font color="red">*</font></td>
								<td class="FieldLabel"><label>基金会登记证号：</label></td>
								<td class="FieldInput"><label field="mainSorgCode"
									name='"登记证号"' style="width: 80%" maxlength="20" /><font
									color="red">*</font></td>
							</tr>
							<tr>
								<td class="FieldLabel"><label>住所：</label></td>
								<td class="FieldInput"><label field="residence" name='"住所"'
									style="width: 80%" maxlength="50" /><font color="red">*</font></td>
								<td class="FieldLabel"><label>基金会电话：</label></td>
								<td class="FieldInput"><label field="sorgPhone"
									name='"基金会电话"' style="width: 80%" maxlength="15" /></td>
							</tr>
							<tr>
								<td class="FieldLabel"><label>注销日期：</label></td>
								<td class="FieldInput"><label id="cancelDate"
									field="cancelDate" name='"注销日期"'
									style="width: 80%" /><font color="red">*</font></td>
								<td class="FieldLabel"><label>业务主管单位：</label></td>
								<td class="FieldInput">
										<label type="text" id="borgNameDispaly" name="borgNameDispaly" style="width:65%"  title="业务主管单位" />
										<div id="popup" style="width:300px; height: 150px; display: none;position: absolute;background-color: #FFFFFF;" >  
	        								<ul></ul> 
	   									</div>
	   									<input type="hidden" id="borgName" name="borgName" field="borgName" title="业务主管单位代码"/>
										<span style="color:red">*</span></td>
							</tr>
							<tr>
								<td class="FieldLabel"><label>注销原因：</label></td>
								<td class="FieldInput" colspan="3"><textarea rows="3" disabled="disabled"
									id="cancelReason" field="cancelReason" name='"注销原因"'
									style="width: 93%"></textarea><font color="red">*</font></td>
							</tr>
						</table>
						</form>
						</fieldset>
						<fieldset><legend>履行内部程序</legend>
						<form method="post" dataset="somApplyDataSet"
							onsubmit="return false" class="L5form">
						<table width="100%">
							<tr>
								<td class="FieldLabel" style="width: 20%"><label>履行内部程序：</label></td>
								<td class="FieldInput" colspan="3"><textarea rows="3" disabled="disabled"
									id="process" name='"基金会履行内部程序"' field="process"
									style="width: 93%"></textarea></td>
							</tr>
						</table>
						</form>
						</fieldset>
						<fieldset><legend>业务主管单位审查意见</legend>
						<form method="post" dataset="somApplyDataSet"
							onsubmit="return false" class="L5form">
						<table width="100%">
							<tr>
								<td class="FieldLabel" style="width: 20%">业务主管单位审查意见：</td>
								<td class="FieldInput" colspan="3"><textarea rows="3" disabled="disabled"
									id="borgOpinion" name="业务主管单位审查意见" field="borgOpinion"
									style="width: 93%"></textarea></td>
							</tr>
						</table>
						</form>
						</fieldset>
					</next:Html>
				</next:Panel>

				<next:Panel title="法律要件">
					<next:EditGridPanel id="uploadGrid" width="100%" stripeRows="true"
						height="100%" dataset="somElectronicDataSet">
						<next:TopBar>
							<next:ToolBarItem symbol="附件列表"></next:ToolBarItem>
							<next:ToolBarItem symbol="->"></next:ToolBarItem>
						</next:TopBar>

						<next:Columns>
							<next:RowNumberColumn />
							<next:RadioBoxColumn></next:RadioBoxColumn>
							<next:Column header="档案目录名" field="catalogCode" width="38%"
								editable="false" dataset="cataLogCodeSelect">
								<next:TextField />
							</next:Column>
							<next:Column header="附件名称" field="fileName" width="30%"
								editable="false">
								<next:TextField />
							</next:Column>
							<next:Column header="附件描述" field="fileMess" width="20%"
								editable="false">
								<next:TextField />
							</next:Column>
							<next:Column header="下载附件" field="" width="10%" editable="false"
								renderer="clickDownloadHref">
								<next:TextField />
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
</next:ViewPort>
<jsp:include page="../../../../../../cams/sorg/comm/upload/uploadWindow.jsp" flush="true" />
<jsp:include page="../../../borg/borgSelectWindow.jsp" flush="true"/>  
</body>
</html>