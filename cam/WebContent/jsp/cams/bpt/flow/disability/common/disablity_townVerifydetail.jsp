<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<script type="text/javascript">
   var applyId = '<%=request.getParameter("applyId")%>';
   var serviceType = '<%=request.getParameter("serviceType")%>';
</script>
<html>
	<head>
		<title>伤残人员县级审核信息</title>
		<next:ScriptManager/>
	</head>
<body>
<model:datasets>
	<model:dataset id="DisabilityApproveDataset" cmd="com.inspur.cams.bpt.manage.cmd.BptApplyDisabilityQueryCommand" method="queryApplyInfo" global="true">
		<model:record fromBean="com.inspur.cams.bpt.base.data.BptApplyDisability"></model:record>
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
<next:Panel height="100%" autoScroll="true" width="100%" id="typeInfo">
				<next:Html>
					<fieldset>
					<form id="editForm"   dataset="DisabilityApproveDataset" onsubmit="return false" style="padding: 5px;" class="L5form">
					<div id="TownVerify">
				<table width="99%">
			   		<tr>
			   			<td  class="FieldLabel" rowspan="4" nowrap="nowrap">县级审核</td>
			   			<td  class="FieldLabel">负责人</td>
						<td class="FieldInput" style="width:30%"><label name="townAduitIncharge" field="townAduitIncharge"  /> </td>
						
						<td  class="FieldLabel" style="width:20%">时间</td>
						<td class="FieldInput" style="width:30%"><label name="townAduitApproveDate" readonly="readonly"  format="Y-m-d"  field="townAduitApproveDate"    /> </td>
					</tr>
					
			   		<tr>
						<td  class="FieldLabel" nowrap="nowrap">伤残性质</td>
						<td class="FieldInput">
							<label   name="townAduitDisabilityNature" field="townAduitDisabilityNature" dataset="DisabilityCaseDataset">
							</label></td>
					
						<td  class="FieldLabel" >申报等级</td>
						<td class="FieldInput">
							<label name="townAduitDisabilityLevel" dataset="DisabilityLevelDataset" field="townAduitDisabilityLevel">
							</label></td>
					</tr>
			   		<tr id="publicity">
			   			<td class="FieldLabel" >公示结果</td>
						<td class="FieldInput" colspan="3"><label name="townAduitBulletinResult" field="townAduitBulletinResult" style="width:80%" rows="2"></label> </td>
			   		</tr>
			   		<tr>	
						<td  class="FieldLabel" >意见</td>  
						<td class="FieldInput" colspan="3">
						<table width="100%">
							<tr>
								<td width="70px;"  class="FieldLabel">审核意见：
								</td>
								<td class="FieldInput">
									<label name="townFlag" id="townFlag" field="townFlag" dataset="ApplyContent"/>
								</td>
								<td class="FieldInput">
									<div id="pass" style="display:none">伤残性质：<label name="townAduitDisabilityNature" field="townAduitDisabilityNature" dataset="DisabilityCaseDataset"></label> 
										&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
										申报等级：<label name="townAduitDisabilityLevel" field="townAduitDisabilityLevel" dataset="DisabilityLevelDataset"></label> 
									</div>
									<div id="end" style="display:none">
										是否上报：
										<label name="townReport"  field="townReport" dataset="ReportFlagEnum"></label>
									</div>
								</td>
							</tr>
							<tr>
								<td colspan="3">
									<label   name="townAduitAdvice" field="townAduitAdvice" style="width:80%" rows="2"></label> 
								</td>
							</tr>
						</table>
						</td>
					</tr>
				</table>
			</div>
			</form>
					</fieldset>
				</next:Html>
			</next:Panel>
</body>

<script type="text/javascript">
	function init() {
		if(serviceType=='14'){
			document.getElementById("publicity").style.display="none";
		}
		var DisabilityApproveDataset = L5.DatasetMgr.lookup("DisabilityApproveDataset");
		DisabilityApproveDataset.setParameter("APPLY_ID",applyId);
		DisabilityApproveDataset.load();
		DisabilityApproveDataset.on("load",function() {
			var townFlag = DisabilityApproveDataset.get("townFlag");
			if(townFlag == 0) {
				document.getElementById("pass").style.display="";
			} else if(townFlag == 1) {
				document.getElementById("end").style.display="";
			}
		
		}); 
	}
</script>
</html>
