<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<html> 
	<head>
		<title>审批历史记录</title>
		<next:ScriptManager/>
		<script type="text/javascript" src="<%=SkinUtils.getJS(request, "bpm/bpm.js")%>"></script>
	</head>	
	<body>
	<model:datasets>
	<model:dataset id="BptApplyHistory" cmd="com.inspur.cams.bpt.manage.cmd.BptApplyHistoryQueryCommand" method="query" global="true" >
		<model:record fromBean="com.inspur.cams.bpt.base.data.BptApplyHistory">
		</model:record>
	</model:dataset>

	<!-- 伤残性质 -->
	<model:dataset id="DisabilityCaseDataset" enumName="CASE.CODE" autoLoad="true" global="true"></model:dataset>
	
	<!-- 伤残等级 -->
	<model:dataset id="DisabilityLevelDataset" enumName="LEVEL.CODE" autoLoad="true" global="true"></model:dataset>
	
	<!-- 审批条件 -->
	<model:dataset id="ApplyContent" enumName="BPT.APPLY.CODE" autoLoad="true" global="true"></model:dataset>

	<!-- 上报标示 -->
	<model:dataset id="ReportFlagEnum" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
</model:datasets>
		<next:Panel width="100%" height="100%" autoScroll="true" id="approveTabPanel">
			<next:Html>
				<form id="editForm"   onsubmit="return false" style="padding: 5px;" class="L5form">
				<table width="99%" style="border:none;border-bottom: none;border-right: none;" dataset="BptApplyHistory">
					<tr repeat="true">  
						<td style="border: none">
							<table width="99%" > 
							<tbody  style="display:none" > 
								<tr >
									<td class="FieldLabel"  rowspan="2" nowrap="nowrap" width="80"><label name="actdefName" >乡镇优抚审核</label></td>
						   			<td class="FieldLabel">审批人</td>
									<td class="FieldInput" style="width:30%"><label name="applyTownIncharge" field="applyTownIncharge"/></td>
									<td class="FieldLabel" style="width:20%">审批时间</td>
									<td class="FieldInput" style="width:30%"><label name="applyTownTime" field="applyTownTime"/></td>
								</tr>
								<select field="applyFlag" style="display:none" onchange="hiddenRow(this)" >
											<option dataset="ApplyContent"></option>
											</select>
						   		<tr >
									<td class="FieldLabel" >意见</td>
									<td colspan="3">
										<label name="applyTownAdvice" field="applyTownAdvice"></label>
									</td>
								</tr>
								</tbody>
						   		<tr>
						   			<td class="FieldLabel"  rowspan="3" nowrap="nowrap" width="80">
						   			<label  name="actdefName"   field="actdefName"></label>
						   			</td>
						   			<td class="FieldLabel">审批人</td>
									<td class="FieldInput" style="width:30%"><label  name="applyIncharge" field="applyIncharge"/></td>
									
									<td class="FieldLabel" style="width:20%">审批时间</td>
									<td class="FieldInput" style="width:30%"><label name="applyTime" field="applyTime"/></td>
								</tr>
						   		<tr>
									<td class="FieldLabel">意见</td>
									<td class="FieldInput" colspan="3" >
									<table width="100%" >
										<tr id ="tab" >
											<td class="FieldLabel" width="20%" >审批意见：</td>
											<td class="FieldInput" width="20%" >
												<label style="width:90px;" name="applyFlag"  
												  field="applyFlag" header="test"  dataset="ApplyContent">
												</label>
											</td>
											<select field="applyFlag" style="display:none" onchange="changeDiv(this)">
											<option dataset="ApplyContent"></option>
											</select>
											<td width="17%"  class="FieldLabel" style="display:none">是否上报：</td>
											<td class="FieldInput"  style="display:none" >
												<label name="cityReport"  dataset="ReportFlagEnum" field="report" >
											</td>
										</tr>
										<tr>
											<td colspan="4">
												<label name="applyAdvice" field="applyAdvice"></label>
											</td>
										</tr>
									</table>
									</td>
								</tr>
						</table>
					</td>
				</tr>
			</table>
				</form>
			</next:Html>
		</next:Panel>      
	</body>
	<script type="text/javascript">
		var index = 0;
		var applyId = '<%=request.getParameter("applyId")%>'
		function init() {
			var BptApplyHistory = L5.DatasetMgr.lookup("BptApplyHistory");
			BptApplyHistory.setParameter("sort","create_time");
			BptApplyHistory.setParameter("dir","ASC");
			BptApplyHistory.setParameter("APPLY_ID",applyId);
			BptApplyHistory.load();
			
			L5.QuickTips.init();
		}
		function hiddenRow(obj) {
			var record = BptApplyHistory.getAllRecords()[index];
			
			var cityname = record.get("actdefName");
			if(cityname=="县优抚科审核"){
				obj.parentNode.parentNode.style.display="";
			}
		}
		function changeDiv(obj) {
			var record = BptApplyHistory.getAllRecords()[index];
			var parentObj = obj.parentNode;
			var cityname = record.get("actdefName");
			var value = obj.value;
			if(value == 0) { // 同意审批
				parentObj.previousSibling.width="80%";
			} else if(value == 1 &&cityname!="市级审核") { //不予评定
				
				parentObj.nextSibling.style.display="";
				parentObj.nextSibling.nextSibling.style.display="";
				parentObj.previousSibling.width="20%";
			}else{
				parentObj.previousSibling.width="80%";
			}
			index++;
		}
	
		 
		
		
	</script>
</html>
