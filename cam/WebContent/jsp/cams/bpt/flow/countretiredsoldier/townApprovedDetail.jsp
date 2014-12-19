<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
	<head>
		<title>60周岁以上农村籍退役士兵县级审核明细</title>
	</head>
	<next:ScriptManager/>
	<script type="text/javascript">
		function init() {
			var ds = L5.DatasetMgr.lookup("ds");
			ds.setParameter("APPLY_ID",'<%=request.getParameter("applyId")%>');
			ds.load();
		}
		function func_Close(){
			window.close();
		}
		</script>
<body>
<model:datasets>
	<model:dataset id="ds" cmd="com.inspur.cams.bpt.manage.cmd.BptApplyCountrySoldierQueryCommand">
		<model:record fromBean="com.inspur.cams.bpt.base.data.BptApplyMartyrOffspring"></model:record>
	</model:dataset>
	<!--同意认定 -->
	<model:dataset id="isAgreeEnum" enumName="BPT.APPLY.CODE" autoLoad="true" global="true"></model:dataset>
</model:datasets>
 <next:Panel height="100%" width="100%" autoScroll="true" id="checkTabPanel">
 		<next:TopBar>
					<next:ToolBarItem symbol="->" ></next:ToolBarItem>
					<next:ToolBarItem iconCls="disable" text="关闭" handler="func_Close"/>
		</next:TopBar>
	<next:Html>
		<form id="editForm" dataset="ds" onsubmit="return false" style="padding: 5px;" class="L5form">
		  <table border="1" width="99%">
				<tr>
					<td class="FieldLabel" rowspan="2" style="width: 15%">村（居）委会审核</td>
					<td class="FieldLabel" >负责人</td>
					<td class="FieldInput" width="400"><label name="acceptIncharge" field="acceptIncharge" /></td>
					<td class="FieldLabel">审核日期</td>
					<td class="FieldInput" width="400"><label name="acceptDate" id="acceptDate" field="acceptDate" ></td>
				</tr>
				<tr>
					<td class="FieldLabel">审查意见</td>
					<td class="FieldInput" colspan="3"><label id="acceptAdvice" name="acceptAdvice" field="acceptAdvice" ></label></td>
				</tr>
				<tr>
					<td class="FieldLabel" rowspan="2">乡（镇、街道）审核</td>
					<td class="FieldLabel">负责人</td>
					<td class="FieldInput"><label id="checkIncharge" name="checkIncharge" field="checkIncharge"/></td>
					<td class="FieldLabel">审核日期</td>
					<td class="FieldInput"><label name="checkDate" id="checkDate" field="checkDate" ></td>
				</tr>
				<tr>
					<td class="FieldLabel">审核意见</td>
					<td class="FieldInput" colspan="3"><label id="checkAdvice" name="checkAdvice" field="checkAdvice"/></td>
				</tr>
				<tr>
					<td class="FieldLabel" rowspan="3">县（市、区）审批</td>
					<td class="FieldLabel">负责人</td>
					<td class="FieldInput"><label id="auditIncharge" name="auditIncharge" field="auditIncharge"/></td>
					<td class="FieldLabel">审核日期</td>
					<td class="FieldInput"><label name="auditDate" id="auditDate" field="auditDate"></td>
				</tr>
				<tr>
					<td class="FieldLabel">是否同意</td>
					<td class="FieldInput" colspan="3"><label name="agreeFlag" id="agreeFlag" field="agreeFlag" dataset="isAgreeEnum"/></td>
				</tr>
				<tr>
					<td class="FieldLabel">审核意见</td>
					<td class="FieldInput" colspan="3"><label id="auditAdvice" name="auditAdvice" field="auditAdvice" /></td>
				</tr>
			</table>
		</form>
   </next:Html>
 </next:Panel>
</body>
</html>