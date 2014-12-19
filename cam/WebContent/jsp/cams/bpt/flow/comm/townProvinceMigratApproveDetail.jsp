<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="org.loushang.workflow.api.WfQuery"%>
<%@ page import="org.loushang.bsp.security.context.GetBspInfo"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Map"%>
<%@page import="com.inspur.cams.bpt.manage.cmd.BptBaseinfoPeopleQueryCommand" %>
<%@page import="java.util.HashMap" %>
<html>
	<head>
		<title>伤残人员省内迁移</title>
		<next:ScriptManager/>
		<script type="text/javascript" src="<%=SkinUtils.getJS(request, "bpm/bpm.js")%>"></script>
		<script type="text/javascript">
			var currentUserName = '<%= GetBspInfo.getBspInfo().getUserName()%>';
			var applyId='<%= request.getParameter("applyId")%>';
		</script>
	</head>
<body>
<model:datasets>
	<model:dataset id="ProvinceMigratDataSet" cmd="com.inspur.cams.bpt.manage.cmd.BptProvinceMigrateQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.bpt.base.data.BptProvinceMigrate">
			<model:field name="ingoingName" type="string"/>
		</model:record>
	</model:dataset>
</model:datasets>


<next:Panel  title="县级审核"   id="approveTabPanel" width="100%" height="100%" autoScroll="true">
	<next:Html>
		<form id="editForm" dataset="ProvinceMigratDataSet" onsubmit="return false" style="padding: 5px;" class="L5form">
   			<table width="99%">
   				<tr>
   					<td class="FieldLabel" rowspan="2" style="width:8%" nowrap="nowrap">迁出地县级审核</td>
					<td class="FieldLabel" style="width:8%">负责人</td>
					<td class="FieldInput" style="width:16%"><label name="outTownAduitIncharge" field="outTownAduitIncharge" /></td>
					<td class="FieldLabel" style="width:16%">审核时间</td>
					<td class="FieldInput" colspan="3" style="width:48%"><label name="outTownAduitApproveDate"  field="outTownAduitApproveDate"    /></td>
				</tr>
		   		<tr>
					<td class="FieldLabel">意见</td>
					<td class="FieldInput" colspan="5"><label name="outTownAduitAdvice" field="outTownAduitAdvice" style="width:90%;"></textarea></td>
				</tr>
   			</table>
		</form>
   </next:Html>
</next:Panel>

	
</body>
<script type="text/javascript">
	var updateUrl;
	var url;
	var first = true;
	function init() {
		var ProvinceMigratDataSet = L5.DatasetMgr.lookup("ProvinceMigratDataSet");
		ProvinceMigratDataSet.setParameter("APPLY_ID",applyId);
		ProvinceMigratDataSet.load();
		L5.QuickTips.init(); 
		
	}
</script>

</html>
