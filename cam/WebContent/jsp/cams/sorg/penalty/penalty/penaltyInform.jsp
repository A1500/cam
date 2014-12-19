<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="com.inspur.cams.sorg.util.SomIdHelp"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<title>社会组织行政处罚告知当事人</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="penalty.js"></script>
<script type="text/javascript" src="<%=SkinUtils.getJS(request,"bpm/bpm.js")%>"></script>
<script type="text/javascript" src="<%=SkinUtils.getJS(request,"cams.js") %>"></script>
<script type="text/javascript" src="<%=SkinUtils.getJS(request,"camsCheck.js") %>"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams/sorgUpload.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"My97DatePicker/WdatePicker.js") %>'></script>
<script type="text/javascript">
	var processId = '<%=request.getParameter("processId")%>';
	var actDefUniqueId='<%=request.getParameter("actDefUniqueId")%>';
	var assignmentId='<%=request.getParameter("assignmentId")%>';
	var act="<%=request.getParameter("act") %>";
	var method="<%=request.getParameter("method") %>";
	var rootPath="<%=SkinUtils.getRootUrl(request)%>";
	var sorgId="";
	var applyType="303,304";
	function validAvermentReason(args){
       var val=args[0].toUpperCase();
       if(_$("ifAverment")=="1"){
       		if(val=="" ) return "不能为空";
      		 return true ;
       }
       return true ;
	}
	function validIfHearing(args){
       var val=args[0].toUpperCase();
       if(_$("ifHearing")=="1"){
       		if(val=="" ) return "不能为空";
      		 return true ;
       }
       return true ;
	}

</script>
</head>
<body>
<model:datasets>
	<model:dataset id="somPenaltyDataSet" cmd="com.inspur.cams.sorg.penalty.base.cmd.SomPenaltyQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.sorg.penalty.base.data.SomPenalty">
			<model:field name="informDate" type="string" rule="require" />
			<model:field name="informContent" type="string" rule="require" />
			<model:field name="ifAverment" type="string" rule="require" />
			<model:field name="ifHearing" type="string" rule="require" />
			<model:field name="avermentReason" type="string" rule="require" rule="custom{fn:validAvermentReason,min:2}" />
			<model:field name="hearingApplyDate" type="string" rule="require" rule="custom{fn:validIfHearing,min:2}" />
			<model:field name="hearingApplyType" type="string" rule="require" rule="custom{fn:validIfHearing,min:2}" />
			avermentReason
		</model:record>
	</model:dataset>
	<model:dataset id="somPenaltyApplyDataSet" cmd="com.inspur.cams.sorg.penalty.base.cmd.SomPenaltyApplyQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.sorg.penalty.base.data.SomPenaltyApply">
			<model:field name="curOpinionId" type="string" rule="require" />
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
	<model:dataset id="cataLogCodeSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value="SOM_CATALOG"></model:param>
			<model:param name="value" value="CATALOG_CODE"></model:param>
			<model:param name="text" value="CATALOG_NAME"></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="opinionSelect" enumName="WORKFLOW.OPINION" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="comm_yesorno" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
	<!-- 案件来源 -->
	<model:dataset id="caseSourceSelect" enumName="SOM.PENALTY.CASE_SOURCE" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="hearingApplyTypeSelect" enumName="SOM.PENALTY.HEARING_APPLY_TYPE" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="hearingTypeSelect" enumName="SOM.PENALTY.HEARING_TYPE" autoLoad="true" global="true"></model:dataset>
	<!-- 听证参加人 -->
	<model:dataset id="hearingPartyChargerSelect" enumName="SOM.PENALTY.HEARING_PARTY_CHARGER" autoLoad="true" global="true"></model:dataset>
</model:datasets>

<next:Panel width="100%" height="100%">
	<next:TopBar>
		<next:ToolBarItem symbol="社会组织行政处罚"></next:ToolBarItem>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="打印文书" iconCls="print" handler="forPrint"></next:ToolBarItem>
		<next:ToolBarItem iconCls="save" text="保存" handler="save" />
		<next:ToolBarItem iconCls="select" text="提交" handler="submit" />
		<next:ToolBarItem iconCls="return" text="返回" handler="goBack"></next:ToolBarItem>
	</next:TopBar>
	<next:TabPanel  id="tab" width="100%" height="100%">
		<next:Tabs>
			<next:Panel title="案件调查终结报告" width="100%" height="100%" autoScroll="true">
				<next:Html>
					<fieldset>
						<form method="post" dataset="somPenaltyDataSet" onsubmit="return false" class="L5form">
							<table width="100%">
								<tr>
									<td class="FieldLabel" width="20%"><label>案号：</label></td>
									<td class="FieldInput" width="30%"><label field="caseCode" /></td>
									<td class="FieldLabel" width="20%"><label>调查人：</label></td>
									<td class="FieldInput" width="30%"><label field="invPerson" /></td>
								</tr>
								<tr>
									<td class="FieldLabel"><label>当事人名称：</label></td>
									<td class="FieldInput"><label field="partyName" /></td>
									<td class="FieldLabel"><label>当事人住所：</label></td>
									<td class="FieldInput"><label field="partyAdd" /></td>
								</tr>
								<tr>
									<td class="FieldLabel"><label>当事人法定代表人（负责人）或发起人：</label></td>
									<td class="FieldInput"><label field="partyCharger" /></td>
									<td class="FieldLabel"><label>当事人电话：</label></td>
									<td class="FieldInput"><label field="partyPhone" /></td>
								</tr>
								<tr>
									<td class="FieldLabel" width="20%"><label>调查开始时间：</label></td>
									<td class="FieldInput" width="30%">
										<label field="invStartDate" format="Y-m-d" style="width:100"/>
									</td>
									<td class="FieldLabel" width="20%"><label>调查结束时间：</label></td>
									<td class="FieldInput" width="30%">
										<label field="invEndDate" format="Y-m-d" style="width:100"/>
									</td>
								</tr>
								<tr>
									<td class="FieldLabel"><label>案由及调查经过：</label></td>
									<td class="FieldInput" colspan="3"><textarea rows="5" field="invProcess" name='"案由及调查经过"' style="width:93%" readonly></textarea></td>
								</tr>
								<tr>
									<td class="FieldLabel"><label>违法事实：</label></td>
									<td class="FieldInput" colspan="3"><textarea rows="5" field="invInfact" name='"违法事实"' style="width:93%" readonly></textarea></td>
								</tr>
								<tr>
									<td class="FieldLabel"><label>证据证明：</label></td>
									<td class="FieldInput" colspan="3"><textarea rows="5" field="invProve" name='"证据证明"' style="width:93%" readonly></textarea></td>
								</tr>
								<tr>
									<td class="FieldLabel"><label>案件性质：</label></td>
									<td class="FieldInput" colspan="3"><textarea rows="5" field="invCaseNature" name='"案件性质"' style="width:93%" readonly></textarea></td>
								</tr>
								<tr>
									<td class="FieldLabel"><label>处罚依据：</label></td>
									<td class="FieldInput" colspan="3"><textarea rows="5" field="invProof" name='"处罚依据"' style="width:93%" readonly></textarea></td>
								</tr>
								<tr>
									<td class="FieldLabel"><label>处罚建议：</label></td>
									<td class="FieldInput" colspan="3"><textarea rows="5" field="invPunSuggestions" name='"处罚建议"' style="width:93%" readonly></textarea></td>
								</tr>
							</table>
						</form>
					</fieldset>
					<fieldset>
						<legend>处理意见</legend>
						<form method="post" dataset="somPenaltyApplyDataSet" onsubmit="return false" class="L5form">
							<table width="100%">
								<tr>
									<td class="FieldLabel" width="20%"><label>承办人意见：</label></td>
									<td class="FieldInput" width="30%"><label field="invAcceptOpinionId" dataset="opinionSelect"/></td>
									<td class="FieldLabel" width="20%"><label>承办登记人</label></td>
									<td class="FieldInput" width="30%"><label field="invAcceptPeopleName" /></td>
								</tr>
								<tr>
									<td class="FieldLabel" width="20%"><label>承办人：</label></td>
									<td class="FieldInput" width="30%"><label field="invAcceptDealPeople" /></td>
									<td class="FieldLabel" width="20%"><label>承办时间：</label></td>
									<td class="FieldInput" width="30%"><label field="invAcceptTime" /></td>
								</tr>
								<tr>
									<td class="FieldLabel"><label>承办人补充意见：</label></td>
									<td class="FieldInput" colspan="3"><textarea rows="3" field="invAcceptOpinion" style="width:93%" readonly></textarea></td>
								</tr>
								<tr>
									<td class="FieldLabel" width="20%"><label>审核人意见：</label></td>
									<td class="FieldInput" width="30%" colspan="3"><label field="invCheckOpinionId" dataset="opinionSelect"/></td>
								</tr>
								<tr>
									<td class="FieldLabel" width="20%"><label>审核人：</label></td>
									<td class="FieldInput" width="30%"><label field="invCheckPeopleName" /></td>
									<td class="FieldLabel" width="20%"><label>审核时间：</label></td>
									<td class="FieldInput" width="30%"><label field="invCheckTime" /></td>
								</tr>
								<tr>
									<td class="FieldLabel"><label>审核人补充意见：</label></td>
									<td class="FieldInput" colspan="3"><textarea rows="3" field="invCheckOpinion" style="width:93%" readonly></textarea></td>
								</tr>
								<tr>
									<td class="FieldLabel" width="20%"><label>审批人意见：</label></td>
									<td class="FieldInput" width="30%" colspan="3"><label field="invAuditOpinionId" dataset="opinionSelect"/></td>
								</tr>
								<tr>
									<td class="FieldLabel" width="20%"><label>审批人：</label></td>
									<td class="FieldInput" width="30%"><label field="invAuditPeopleName" /></td>
									<td class="FieldLabel" width="20%"><label>审批时间：</label></td>
									<td class="FieldInput" width="30%"><label field="invAuditTime" /></td>
								</tr>
								<tr>
									<td class="FieldLabel"><label>审批人补充意见：</label></td>
									<td class="FieldInput" colspan="3"><textarea rows="3" field="invAuditOpinion" style="width:93%" readonly></textarea></td>
								</tr>
							</table>
						</form>
					</fieldset>
				</next:Html>
			</next:Panel>
			<next:Panel title="行政处罚事先/听证告知书" width="100%" height="100%" autoScroll="true">
				<next:Html>
					<fieldset>
						<form method="post" onsubmit="return false" class="L5form" dataset="somPenaltyDataSet">
							<table width="100%">
								<tr>
									<td class="FieldLabel" width="20%"><label>事先/听证告知书发出日期：</label></td>
									<td class="FieldInput" width="30%"><input id="informDate" field="informDate" name='"事先/听证告知书发出日期"' style="width:80%" format="Y-m-d" onclick="WdatePicker()" /><span style="color:red">*</span></td>
									<td class="FieldLabel" width="20%"><label></label></td>
									<td class="FieldInput" width="30%"></td>
								</tr>
								<tr>
									<td class="FieldLabel"><label>事先/听证告知处罚的内容：</label></td>
									<td class="FieldInput" colspan="3"><textarea rows="5" id="informContent" field="informContent" name='"事先/听证告知处罚的内容"' style="width:93%"></textarea><span style="color:red">*</span></td>
								</tr>
								<tr>
									<td class="FieldLabel"><label>当事人是否陈述、申辩：</label></td>
									<td class="FieldInput"><select id="ifAverment" field="ifAverment" name='"当事人是否陈述、申辩"' style="width:80%" onchange="loadAvermentReason()" ><option dataset="comm_yesorno"/></select><span style="color:red">*</span></td>
									<td class="FieldLabel"><label>当事人是否申请听证：</label></td>
									<td class="FieldInput"><select id="ifHearing" field="ifHearing" name='"当事人是否申请听证"' style="width:80%" onchange="loadHearingApply()" ><option dataset="comm_yesorno"/></select><span style="color:red">*</span></td>
								</tr>
								<tr id="avermentReasonTr" style="display:none;">
									<td class="FieldLabel"><label>当事人陈述、申辩的意见和理由：</label></td>
									<td class="FieldInput" colspan="3"><textarea rows="5" field="avermentReason" name='"当事人陈述、申辩的意见和理由"' style="width:93%"></textarea><span style="color:red">*</span></td>
								</tr>
								<tr id="hearingApplyTr" style="display:none;">
									<td class="FieldLabel"><label>申请听证日期：</label></td>
									<td class="FieldInput"><input id="hearingApplyDate" field="hearingApplyDate" name='"申请听证日期"' style="width:80%" format="Y-m-d" onclick="WdatePicker()" /><span style="color:red">*</span></td>
									<td class="FieldLabel"><label>申请听证方式：</label></td>
									<td class="FieldInput">
										<select id="hearingApplyType" field="hearingApplyType" name='"申请听证方式"' style="width:80%">
											<option dataset="hearingApplyTypeSelect">
										</select><span style="color:red">*</span>
									</td>
								</tr>
								<tr id="hearingTr" style="display:none">
									<td class="FieldLabel"><label>听证会当事人参加人：</label></td>
									<td class="FieldInput"><select id="hearingPartyCharger" field="hearingPartyCharger" name='"听证会当事人参加人"' style="width:80%" onchange="loadHearingPartyChargerName()"><option dataset="hearingPartyChargerSelect"/></select></td>
									<td class="FieldLabel"><label>听证会当事人参加人名称：</label></td>
									<td class="FieldInput"><input id="hearingPartyChargerName" field="hearingPartyChargerName" name='"听证会当事人参加人名称"' style="width:80%"/>	</td>
								</tr>
							</table>
						</form>
					</fieldset>
					<fieldset>
						<legend>本机关联系方式</legend>
						<form method="post" dataset="somPenaltyDataSet" onsubmit="return false" class="L5form">
							<table width="100%">
								<tr>
									<td class="FieldLabel" width="20%"><label>地址：</label></td>
									<td class="FieldInput" width="30%"><input id="linkmanAdd" field="linkmanAdd" name='"地址"' style="width:80%"/></td>
									<td class="FieldLabel" width="20%"><label>邮政编码：</label></td>
									<td class="FieldInput" width="30%"><input id="linkmanPost" field="linkmanPost" name='"邮政编码"' style="width:80%"/></td>
								</tr>
								<tr>
									<td class="FieldLabel" width="20%"><label>联系人：</label></td>
									<td class="FieldInput" width="30%"><input id="linkmanName" field="linkmanName" name='"联系人"' style="width:80%"/></td>
									<td class="FieldLabel" width="20%"><label>电话：</label></td>
									<td class="FieldInput" width="30%"><input id="linkmanPhone" field="linkmanPhone" name='"电话"' style="width:80%"/></td>
								</tr>
							</table>
						</form>
					</fieldset>
				</next:Html>
			</next:Panel>
			<next:Panel title="法律要件" >
				<next:EditGridPanel id="uploadGrid" width="100%" stripeRows="true" height="100%" dataset="somElectronicDataSet">
					<next:GroupingView forceFit="true"></next:GroupingView>
					<next:TopBar>
						<next:ToolBarItem symbol="附件列表"></next:ToolBarItem>
						<next:ToolBarItem symbol="->"></next:ToolBarItem>
						<next:ToolBarItem iconCls="add" text="增加上传附件" handler="uploadFile"></next:ToolBarItem>
					</next:TopBar>
					<next:Columns>
						<next:RowNumberColumn />
						<next:RadioBoxColumn></next:RadioBoxColumn>
						<next:Column header="档案目录名"  field="catalogCode" width="280" editable="false" dataset="cataLogCodeSelect"><next:TextField /></next:Column>
						<next:Column header="附件名称"    field="fileName" width="200" editable="false"><next:TextField /></next:Column>
						<next:Column header="附件描述"    field="fileMess" width="200" editable="false"><next:TextField /></next:Column>
						<next:Column header="下载附件"    field="" width="80" editable="false" renderer="clickDownloadHref"><next:TextField /></next:Column>
						<next:Column header="业务类型"    field="applyType" hidden="true">
							<next:ExtendConfig>groupRenderer:grender,groupName:"法律要件目录"</next:ExtendConfig>
						</next:Column>
					</next:Columns>
					<next:BottomBar>
						<next:PagingToolBar dataset="somElectronicDataSet" />
					</next:BottomBar>
				</next:EditGridPanel>
			</next:Panel>
			<next:Panel title="请填写流程处理意见" width="100%">
				<next:Html>
					<form method="post" onsubmit="return false" class="L5form" dataset="somPenaltyApplyDataSet">
						<table width="100%">
							<tr>
								<td class="FieldLabel" style="width:13%"><label>处理意见：</label></td>
								<td class="FieldInput" colspan="5">
									<select field="curOpinionId" name='"处理意见"' style="width:150px" default="0">
										<option dataset="opinionSelect"></option>
									</select><span style="color:red">*</span>
								</td>
							</tr>
							<tr>
								<td class="FieldLabel"><label>处理补充意见：</label></td>
								<td class="FieldInput" colspan="5">
									<textarea rows="10" name='"处理补充意见"' field="curOpinion" style="width:93%"></textarea>
								</td>
							</tr>
						</table>
					</form>
				</next:Html>
			</next:Panel>
		</next:Tabs>
	</next:TabPanel>
</next:Panel>

<!--打印文书  -->
<next:Window id="printWin" closeAction="hide" title="打印文书" width="400" autoScroll="true" modal="true">
	<next:TopBar>
		<next:ToolBarItem symbol="打印文书"></next:ToolBarItem>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="确定" iconCls="detail" handler="forPrintItem"></next:ToolBarItem>
		<next:ToolBarItem text="关闭" iconCls="return" handler="closePrint"></next:ToolBarItem>
	</next:TopBar>
	<next:Html>
		<form method="post" onsubmit="return false" class="L5form">
			<table width="100%">
				<tr>
					<td class="FieldLabel" style="width:20%"><label>打印事项：</label></td>
					<td class="FieldInput" style="width:80%">
						<select id="printItem" style="width:90%">
							<option>请选择...</option>
							<option value="1">行政处罚事先告知书</option>
							<option value="2">《行政处罚事先告知书》送达公告</option>
							<option value="3">《行政处罚事先告知书》送达回证</option>
							<option value="4">行政处罚听证告知书</option>
							<option value="5">《行政处罚听证告知书》送达公告</option>
							<option value="6">《行政处罚听证告知书》送达回证</option>
							<option value="7">行政处罚听证通知书</option>
						</select>
					</td>
				</tr>
			</table>
		</form>
	</next:Html>
</next:Window>
<!-- 行政处罚事先告知书 -->
<next:Window id="printWin1" closeAction="hide" title="行政处罚事先告知书" width="300"  autoScroll="true" modal="true">
	<next:TopBar>
		<next:ToolBarItem symbol="行政处罚事先告知书"></next:ToolBarItem>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="确定" iconCls="detail" handler="forPrintBeforeInform"></next:ToolBarItem>
		<next:ToolBarItem text="关闭" iconCls="return" handler="closePrintWin"></next:ToolBarItem>
	</next:TopBar>
	<next:Html>
		<form method="post" onsubmit="return false" class="L5form">
			<table width="100%">
				<tr>
					<td class="FieldLabel" style="width:150"><label>责令改正日期：</label></td>
					<td class="FieldInput" ><input id="informDayNum" name='"责令改正日期"' style="width:80%"/>天</td>
				</tr>
			</table>
		</form>
	</next:Html>
</next:Window>
<!-- 听证通知书 -->
<next:Window id="printWin7" closeAction="hide" title="行政处罚听证通知书" width="800"  autoScroll="true" modal="true">
	<next:TopBar>
		<next:ToolBarItem symbol="行政处罚听证通知书"></next:ToolBarItem>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="确定" iconCls="detail" handler="forPrintHearingNotice"></next:ToolBarItem>
		<next:ToolBarItem text="关闭" iconCls="return" handler="closePrintWin"></next:ToolBarItem>
	</next:TopBar>
	<next:Html>
		<form method="post" dataset="somPenaltyDataSet" onsubmit="return false" class="L5form">
			<table width="100%">
				<tr>
					<td class="FieldLabel" style="width:20%"><label>听证会日期：</label></td>
					<td class="FieldInput" style="width:30%"><input id="hearingDate" field="hearingDate" name='"听证会日期"' style="width:100%" format="Y-m-d" onclick="WdatePicker()" /></td>
					<td class="FieldLabel" style="width:20%"><label>听证会地点：</label></td>
					<td class="FieldInput" style="width:30%"><input id="hearingAdd" field="hearingAdd" name='"听证会地点"' style="width:100%"/></td>
				</tr>
				<tr>
					<td class="FieldLabel"><label>听证会详细地点：</label></td>
					<td class="FieldInput"><input id="hearingAddDetail" name='"听证会详细地点"' style="width:100%"/></td>
					<td class="FieldLabel"><label>是否公开听证：</label></td>
					<td class="FieldInput"><select field="hearingType" name='"是否公开听证"' style="width:100%"><option dataset="hearingTypeSelect"/></select></td>
				</tr>
				<tr>
					<td class="FieldLabel"><label>听证主持人：</label></td>
					<td class="FieldInput"><input id="hearingPresenter" field="hearingPresenter" name='"听证主持人"' style="width:100%" /></td>
					<td class="FieldLabel"><label>听证主持人单位：</label></td>
					<td class="FieldInput"><input field="hearingPresenterOrgan" name='"听证主持人单位"' style="width:100%" /></td>
				</tr>
				<tr>
					<td class="FieldLabel"><label>听证主持人职务：</label></td>
					<td class="FieldInput"><input field="hearingPresenterDuties" name='"听证主持人职务"' style="width:100%" /></td>
					<td class="FieldLabel"><label>记录人：</label></td>
					<td class="FieldInput"><input field="hearingRecorder" name='"记录人"' style="width:100%" /></td>
				</tr>
				<tr>
					<td class="FieldLabel"><label>记录人单位：</label></td>
					<td class="FieldInput"><input field="hearingRecorderOrgan" name='"记录人单位"' style="width:100%" /></td>
					<td class="FieldLabel"><label>记录人职务：</label></td>
					<td class="FieldInput"><input field="hearingRecorderDuties" name='"记录人职务"' style="width:100%" /></td>
				</tr>
				<tr>
					<td class="FieldLabel"><label>申请延期听证截止日期：</label></td>
					<td class="FieldInput"><input id="hearingDelayEndDate" name='"申请延期听证截止日期"' style="width:100%" format="Y-m-d" onclick="WdatePicker()" /></td>
					<td class="FieldLabel"><label>申请主持人回避截止日期：</label></td>
					<td class="FieldInput"><input id="hearingPresenterAvoidEndDate" name='"申请主持人回避截止日期"' style="width:100%" format="Y-m-d" onclick="WdatePicker()" /></td>
				</tr>
			</table>
		</form>
	</next:Html>
</next:Window>
<jsp:include page="../../comm/upload/uploadWindow.jsp" flush="true"/>
</body>
</html>