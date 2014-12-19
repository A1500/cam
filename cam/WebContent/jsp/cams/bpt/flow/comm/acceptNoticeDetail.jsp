<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<title>受理通知书添加</title>
<next:ScriptManager />
		<script>
			var assignmentId = '<%= (String)request.getParameter("assignmentId")%>';
			var processId = '<%= (String)request.getParameter("processId")%>';
		</script>
</head>
<body>
<model:datasets>
	<!-- 受理通知书 -->
	<model:dataset id="DisabilityNoticeDataset" cmd="com.inspur.cams.bpt.manage.cmd.BptApplyDisabilityNoticeQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.bpt.base.data.BptApplyDisabilityNotice"></model:record>
	</model:dataset>
	<!-- 伤残业务类型 -->
	<model:dataset id="ServiceTypeDataSet" enumName="DISABILITY.SERVICE.TYPE"  autoLoad="true" global="true"></model:dataset>
</model:datasets>
					
<next:Panel width="100%" height="100%">
	<next:Html>
		<form id="editForm"   dataset="DisabilityNoticeDataset" onsubmit="return false" style="padding: 5px;" class="L5form">
		<table border="1"  width="99%" >
			
	   		<tr>
	   			<td  class="FieldLabel" style="width:15%">字：</td>
				<td class="FieldInput" style="width:15%"><label name="letter" field="letter"/></td>
				<td  class="FieldLabel" style="width:15%">号：</td>
				<td class="FieldInput" colspan="3"><label name="number" field="number"/></td>
			</tr>
			
			<tr>
				<td  class="FieldLabel" >姓名：</td>
				<td  class="FieldInput" ><label name="name" field="name"  /></td>

				<td  class="FieldLabel" >业务类型：</td>
				<td  class="FieldInput" ><label name="serviceType" field="serviceType" dataset="ServiceTypeDataSet"></label></td>
				
				<td  class="FieldLabel" >通知书日期：</td>
				<td class="FieldInput"><label name="noticeDate" field="noticeDate"/></td>
			</tr>
				
		</table>
		</form>
   </next:Html>
</next:Panel>
<script type="text/javascript">
function init(){
	var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.WfProcessBusinessCommand");
	if(processId=='null'){
		command.setParameter("assignmentId",assignmentId);
	}else{
		command.setParameter("PROCESS_ID",processId);
	}
	command.execute("queryBusinessType");
	var peopleId = command.getReturn("peopleId");

	var DisabilityNoticeDataset=L5.DatasetMgr.lookup("DisabilityNoticeDataset");
	DisabilityNoticeDataset.setParameter("PEOPLE_ID",peopleId);
	DisabilityNoticeDataset.load();
	L5.QuickTips.init(); 
}
</script>
</body>
</html>
