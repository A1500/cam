
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
	<head>
		<title>临时救助审批明细</title>
		<next:ScriptManager/>
		<script>
			var applyId='<%=request.getParameter("applyId")%>';
			var method='<%=request.getParameter("method")%>';
		</script>
		<script type="text/javascript" src="temporaryHelpApplyDetail.js"></script>
		<script type="text/javascript" src="../comm/bptComm.js"></script>
	</head>
<body>
<model:datasets>
	<!--经费发放 -->
	<model:dataset id="dsUpdateTemporaryHelp" cmd="com.inspur.cams.bpt.manage.cmd.BptTemporaryHelpQueryCommand" global="true" method="queryUpdateTemporaryHelp">
		<model:record fromBean="com.inspur.cams.bpt.base.data.BptTemporaryHelp"></model:record>
	</model:dataset>
	<!--救助类别-->
	<model:dataset id="dsHelp" enumName="HELP.TYPE" autoLoad="true"></model:dataset>
	<!-- 优抚对象类别-->
	<model:dataset id="objectDs"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_BPT_OBJECT_TYPE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 民族 -->
	<model:dataset id="NationDataset"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_NATION'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 性别 -->
	<model:dataset id="SexDataset" enumName="COMM.SEX" autoLoad="true" global="true"></model:dataset>
</model:datasets>
<next:Panel autoHeight="true" bodyStyle="width:100%" width="100%" autoScroll="false">
				<next:Html>
					<form id="editForm" dataset="dsUpdateTemporaryHelp" onsubmit="return false"
						style="padding: 5px;" class="L5form">
					<table border="1" width="100%">
						<tr>
							<td class="FieldLabel" rowspan="2" nowrap>村（居）意见:</td>
							<td class="FieldLabel" width="8%" nowrap>负责人:</td>
							<td class="FieldInput" width="30%"><label name="checkIncharge" field="checkIncharge" /></td>
						    <td  class="FieldLabel" nowrap>审核时间:</td>
							<td class="FieldInput"><label name="checkDate" id="checkDate"field="checkDate"  format="Y-m-d" style="width: 100px;" align="middle"  ><font color="red">*</font> </td>
						</tr>
						<tr>
							<td class="FieldLabel" nowrap>审核意见:</td>
							<td colspan="3"><label name="checkAdvice" field="checkAdvice"></label></td>
						</tr>
						<tr>
							<td class="FieldLabel" rowspan="2" nowrap>乡镇（街道办）意见:</td>
							<td class="FieldLabel" width="8%" nowrap>责任人:</td>
							<td class="FieldInput" width="30%"><label name="auditIncharge" field="auditIncharge" /></td>
							<td  class="FieldLabel" nowrap>审核时间:</td>
							<td class="FieldInput"><label name="auditDate"id="auditDate" field="auditDate" format="Y-m-d"> </td>
						</tr>
						<tr>
							<td class="FieldLabel" nowrap>审核意见:</td>
							<td colspan="3"><label name="auditAdvice" field="auditAdvice"></label></td>
						</tr>
						<tr>
							<td class="FieldLabel" rowspan="2" nowrap>县级民政部门意见:</td>
							<td class="FieldLabel" width="8%" nowrap>负责人:</td>
							<td class="FieldInput" width="30%"><label name="verifyIncharge" field="verifyIncharge" /></td>
							<td  class="FieldLabel" nowrap>审批时间:</td>
							<td class="FieldInput"><label name="verifyDate" id="verifyDate" field="verifyDate"  format="Y-m-d"></td>
						</tr>
						<tr>
							<td class="FieldLabel" nowrap>审批意见:</td>
							<td colspan="3"><label name="verifyAdvice" field="verifyAdvice"></label></td>
						</tr>
			            <input type="hidden" name="domicileCode" field="domicileCode" />
					</table>
					</form>
				</next:Html>
</next:Panel>
</body>
</html>