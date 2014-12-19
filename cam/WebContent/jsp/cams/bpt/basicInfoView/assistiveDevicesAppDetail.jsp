<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
	<head>
		<title>优抚_申请_伤残辅助器械_审批查看</title>
		<next:ScriptManager/>
				<script>
					var applyId = '<%= (String)request.getParameter("applyId")%>';
				</script>
		</head>
<body>
<model:datasets>
	<!-- 伤残辅助器械审批 -->
	<model:dataset id="AssistiveDevicesPrDataset" cmd="com.inspur.cams.bpt.manage.cmd.BptApplyAssistiveDevicesPrQueryCommand" method="queryupdate" global="true">
		<model:record fromBean="com.inspur.cams.bpt.base.data.BptApplyAssistiveDevicesPr">
		</model:record>
	</model:dataset>
	<!-- 是否同意 -->
	<model:dataset id="AgreeEnum" enumName="COMM.AGREEORNO" autoLoad="true" global="true"></model:dataset>
	<!-- 上报标识-->
	<model:dataset id="ReportFlagEnum" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
</model:datasets>
	<next:Panel title="县级审核" autoScroll="true" width="100%"  height="100%" id="editPanel">
		<next:Html>
			<form id="editForm" dataset="AssistiveDevicesPrDataset" onsubmit="return false" style="padding: 5px;" class="L5form">
			<table border="0"  width="99%">
				<table></table>
				<div id="townCheck">
					<table border="0" width="98%">
				   	<tr>
			   			<td class="FieldLabel" rowspan="3" nowrap="nowrap" style="width:12.5%">县级审核</td>
						<td class="FieldLabel" style="width:12.5%">负责人</td>
						<td class="FieldInput" style="width:25%"><label id="checkIncharge" name="checkIncharge" field="checkIncharge"/></td>
						<td class="FieldLabel" style="width:25%">审核时间</td>
						<td class="FieldInput" style="width:25%"><label id="checkApproveDate" name="checkApproveDate" field="checkApproveDate"/></td>
					</tr>
			   		<tr>
						<td class="FieldLabel" nowrap="nowrap" rowspan="2">审核意见</td>
						<td colspan="3" style="background-color:#F5FAFA;padding: 0 0 0 0;width: 100%;height: 100%;border:0;">
								<table style="width: 100%;height: 100%;border:0;padding: 0 0 0 0;">
									<tr> 
					   					<td class="FieldLabel" style="width:25%">意见</td>
					   					<td class="FieldInput" style="width:25%">
					   						<label name="agreeFlag" id="agreeFlag" field="agreeFlag" dataset="AgreeEnum" />
					   					</td>
					   					<td id="report" style="background-color:#F5FAFA;padding: 0 0 0 0;width: 100%;height: 100%;border:0;">
					   						<table style="width: 100%;height: 100%;border:0;padding: 0 0 0 0;">
					   							<tr>
					   								<td class="FieldLabel" style="width:25%;">是否上报</td>
							   						<td class="FieldInput" style="width:25%;">
							   							<label id="reportFlag" name="reportFlag" field="reportFlag" dataset="AgreeEnum" />
													</td>
					   							</tr>
					   						</table>
					   					</td>
				   					</tr>
			   					</table>
						</td>
					</tr>
					<tr>
						<td class="FieldInput" colspan="3"><label id="checkAdvice" name="checkAdvice" field="checkAdvice"></label></td>
					</tr>
					</table>
				</div>
				<br>
				<div id="cityCheck">
					<table border="0"  width="98%">
				   		<tr>
				   			<td class="FieldLabel" rowspan="2" style="width:12.5%">市级审核</td>
							<td class="FieldLabel" style="width:12.5%">负责人</td>
							<td class="FieldInput" style="width:25%"><label id="aduitIncharge" title="负责人" name="aduitIncharge" field="aduitIncharge"/></td>
							<td class="FieldLabel" style="width:25%">审核时间</td>
							<td class="FieldInput" style="width:25%"><label id="aduitApproveDate" title="审核时间" name="aduitApproveDate" field="aduitApproveDate"/></td>
						</tr>
						<tr>
							<td class="FieldLabel">审核意见</td>
							<td class="FieldInput" colspan="3"><label id="aduitAdvice" title="审核意见" name="aduitAdvice" field="aduitAdvice"></label></td>
						</tr>
						
					</table>
				</div>
				<br>
				<div>
					<table>
						<tr border="0"  width="98%">
							<td class="FieldInput"><lable id = "assistiveDevicesPrHistory" name="assistiveDevicesPrHistory"><a href="javaScript:assistiveDevicesPr()">审批历史记录</a></lable></td>
						</tr>
					</table>
				</div>
				</table>
			</form>
	   </next:Html>
	</next:Panel>
	
</body>
<script>
function init() {
	var AssistiveDevicesPrDataset = L5.DatasetMgr.lookup("AssistiveDevicesPrDataset");
	AssistiveDevicesPrDataset.setParameter("APPLY_ID",applyId);
	AssistiveDevicesPrDataset.load();
	L5.QuickTips.init();
}

//查看人员基本信息
	function assistiveDevicesPr(){
		return openDetail(applyId);
	}
	
	function openDetail(applyId){
		var url = L5.webPath+"/jsp/cams/bpt/flow/disability/assistivedevices/assistiveDevicesAppHistory.jsp?applyId="+applyId;
		var width = screen.width-60;
		var height = 580;
		var win = window.showModalDialog (url,window,"scroll:yes;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:0");
		if (win==null) {
			return;
		}
	}

</script>
</html>
