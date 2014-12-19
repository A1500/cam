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
							<label name="applyAdvice" field="applyAdvice"></label>
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
		
	</script>
</html>
