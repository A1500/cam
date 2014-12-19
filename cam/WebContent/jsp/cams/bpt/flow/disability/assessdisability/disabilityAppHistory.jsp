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
	<model:dataset id="BptApplyHistory" cmd="com.inspur.cams.bpt.manage.cmd.BptApplyHistoryQueryCommand" method="query" global="true" pageSize="100">
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
		<next:Panel width="100%" height="100%" autoScroll="true">
			<next:Html>
				<form id="editForm"   onsubmit="return false" style="padding: 5px;" class="L5form">
				<table width="99%" style="border:none;border-bottom: none;border-right: none;" dataset="BptApplyHistory">
					<tr repeat="true">  
						<td style="border: none">
							<table width="99%" >  
			   		<tr>
			   			<td class="FieldLabel"  rowspan="3" nowrap="nowrap"><label name="actdefName" field="actdefName"/></td>
			   			<td class="FieldLabel">审批人</td>
						<td class="FieldInput" style="width:30%"><label name="applyIncharge" field="applyIncharge"/></td>
						
						<td class="FieldLabel" style="width:20%">审批时间</td>
						<td class="FieldInput" style="width:30%"><label name="applyTime" field="applyTime"/></td>
					</tr>
			   		<tr>
						<td class="FieldLabel">意见</td>
						<td class="FieldInput" colspan="3">
						<table width="100%">
							<tr>
								<td width="70px;"  class="FieldLabel">审批意见：
								</td>
								<td class="FieldInput">
									<label style="width:90px;" name="applyFlag"  
									  field="applyFlag" header="test"  dataset="ApplyContent">
									</label>
								</td>  
								<td class="FieldInput">
									<div name="passDiv" style="display:none">伤残性质：
										<label name="disabilityCase" dataset="DisabilityCaseDataset"  field="disabilityCase">
										</label>
										&nbsp;&nbsp;&nbsp;
										申报等级：
											<label name="disabilityLevel" dataset="DisabilityLevelDataset"  field="disabilityLevel">
										</label>
										<select style="display:none" field="applyFlag" onchange="changeDiv(this)">
											<option dataset="ApplyContent"></option>
										</select>
									</div>
									<div name="endDiv" style="display:none">  
										是否上报：
										<label name="cityReport"  dataset="ReportFlagEnum" field="report" >
										</label>
									</div>
								</td>
							</tr>
							<tr>
								<td colspan="3">
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
		
		function changeDiv(obj) {
			var records = BptApplyHistory.getAllRecords();
			var parentObj = obj.parentNode;
			var value = obj.value;
			if(value == 0) { // 同意审批
				parentObj.style.display="";
			} else if(value == 1) { //不予评定
				var report = records[index].get("report");
				if(report != null && report != "") {
					parentObj.nextSibling.style.display="";
				}	
			}
			parentObj.parentNode.previousSibling.previousSibling.innerHTML=records[index].get("actdefName").substring(2)+"意见："
			index++;
		}
	</script>
</html>