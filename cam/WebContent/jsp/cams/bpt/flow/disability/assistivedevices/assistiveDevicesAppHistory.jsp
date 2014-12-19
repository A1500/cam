<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
	<head>
		<script type="text/javascript">
			var applyId ='<%=request.getParameter("applyId")%>';
		</script>
		<title>伤残辅助器械审批历史记录</title>
		<next:ScriptManager/>
		</head>
<body>
<model:datasets>
	<!-- 审批历史记录 -->
	<model:dataset id="BptApplyHistory" cmd="com.inspur.cams.bpt.manage.cmd.BptApplyHistoryQueryCommand" method="query" global="true" >
		<model:record fromBean="com.inspur.cams.bpt.base.data.BptApplyHistory">
		</model:record>
	</model:dataset>
</model:datasets>
	<next:Panel autoScroll="true" width="100%"  height="100%" id="editPanel">
		<next:Html>
			<form id="editForm" onsubmit="return false" style="padding: 5px;" class="L5form">
			<table width="99%" dataset="BptApplyHistory">
				<tr repeat="true" style="border: 0">
				   <td style="border:0">
						<table border="0" width="99%">
					   		<tr>
					   			<td class="FieldLabel" rowspan="2" style="width:12.5%"><label name="actdefName" field="actdefName"></label></td>
								<td class="FieldLabel" style="width:12.5%">负责人</td>
								<td class="FieldInput" style="width:25%"><label id="applyIncharge" name="applyIncharge" field="applyIncharge"/></td>
								<td class="FieldLabel" style="width:25%">审核时间</td>
								<td class="FieldInput" style="width:25%"><label id="applyTime" name="applyTime" field="applyTime"/></td>
							</tr>
					   		<tr>
								<td class="FieldLabel" nowrap="nowrap">审核意见</td>
								<td class="FieldInput" colspan="3"><label id="applyAdvice" name="applyAdvice" field="applyAdvice" style="width:90%"></label></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
			</form>
	   </next:Html>
	</next:Panel>
</body>
<script>
function init() {
	var BptApplyHistory = L5.DatasetMgr.lookup("BptApplyHistory");
	BptApplyHistory.setParameter("sort","create_time");
	BptApplyHistory.setParameter("dir","ASC");
	BptApplyHistory.setParameter("APPLY_ID",applyId);
	BptApplyHistory.load();
	L5.QuickTips.init();
}
</script>
</html>
