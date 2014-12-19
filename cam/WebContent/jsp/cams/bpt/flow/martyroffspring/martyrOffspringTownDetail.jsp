<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<title>部分烈士（错杀被平反人员）子女受理县级审核</title>
</head>
<next:ScriptManager />
<script type="text/javascript">
		function init(){
						var ds = L5.DatasetMgr.lookup("ds");
							ds.setParameter("APPLY_ID",'<%=request.getParameter("applyId")%>');
							ds.load();
					}
</script>
<body>
<model:datasets>
	<model:dataset id="ds" cmd="com.inspur.cams.bpt.manage.cmd.BptApplyMartyrOffspringQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.bpt.base.data.BptApplyMartyrOffspring"></model:record>
	</model:dataset>
	<!--同意认定 -->
	<model:dataset id="isAgreeEnum" enumName="BPT.APPLY.CODE" autoLoad="true" global="true"></model:dataset>
</model:datasets>

<next:Panel height="100%" width="100%" autoScroll="true" id="peopleTabPanel">
	<next:Html>
		<form id="editForm" dataset="ds" onsubmit="return false"
			style="padding: 5px;" class="L5form">
			<table border="1" width="99%">
				<tr>
					<td class="FieldLabel" rowspan="2" style="width: 15%">村（居）委会审核</td>
					<td class="FieldLabel" style="width: 15%">负责人</td>
					<td class="FieldInput" style="width: 16%"><label name="acceptIncharge" field="acceptIncharge"/></td>
					<td class="FieldLabel" style="width: 15%">审核日期</td>
					<td class="FieldInput" style="width: 16%"><label name="acceptDate" id="acceptDate" field="acceptDate" format="Y-m-d"/></td>
				</tr>
				<tr>
					<td class="FieldLabel">审查意见</td>
					<td class="FieldInput" colspan="3"><label id="acceptAdvice" name="acceptAdvice" field="acceptAdvice"></label></td>
				</tr>
				<tr>
					<td class="FieldLabel" rowspan="2">乡（镇、街道）审核</td>
					<td class="FieldLabel">负责人</td>
					<td class="FieldInput"><label id="checkIncharge" name="checkIncharge" field="checkIncharge" /></td>
					<td class="FieldLabel">审核日期</td>
					<td class="FieldInput"><label name="checkDate" id="checkDate" field="checkDate"/> </td>
				</tr>
				<tr>
					<td class="FieldLabel">审核意见</td>
					<td class="FieldInput" colspan="3"><label id="checkAdvice" name="checkAdvice" field="checkAdvice" ></label></td>
				</tr>
				<tr>
					<td class="FieldLabel" rowspan="3">县（市、区）审批</td>
					<td class="FieldLabel">负责人</td>
					<td class="FieldInput"><label id="auditIncharge" name="auditIncharge" field="auditIncharge" /></td>
					<td class="FieldLabel">审核日期</td>
					<td class="FieldInput"><label name="auditDate" id="auditDate" field="auditDate" /></td>
				</tr>
				<tr>
					<td class="FieldLabel">是否同意</td>
					<td class="FieldInput" colspan="3"><label name="agreeFlag" id="agreeFlag" field="agreeFlag" dataset="isAgreeEnum" /></td>
				</tr>
				<tr>
					<td class="FieldLabel">审核意见</td>
					<td class="FieldInput" colspan="3"><label id="auditAdvice" name="auditAdvice" field="auditAdvice"></label></td>
				</tr>
			</table>
		</form>
	</next:Html>
</next:Panel>
</body>
</html>
