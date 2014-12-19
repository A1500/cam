<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.bsp.security.context.GetBspInfo"%>
<script type="text/javascript">
   var applyId = '<%=request.getParameter("applyId")%>';
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
						<td  class="FieldLabel" >意见</td>  
						<td class="FieldInput" colspan="3">
						<table width="100%">
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
		var DisabilityApproveDataset = L5.DatasetMgr.lookup("DisabilityApproveDataset");
		DisabilityApproveDataset.setParameter("APPLY_ID",applyId);
		DisabilityApproveDataset.load();
		L5.QuickTips.init();
	}
</script>
</html>
