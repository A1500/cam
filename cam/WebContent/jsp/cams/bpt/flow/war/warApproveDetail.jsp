<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="org.loushang.workflow.api.WfQuery" %>
<%@page import="org.loushang.bsp.security.context.GetBspInfo"%>
<%@page import="java.util.List" %>
<%@page import="java.util.Map" %>
<%@page import="com.inspur.cams.bpt.manage.cmd.BptBaseinfoPeopleQueryCommand" %>
<%@page import="java.util.HashMap" %>
<html>
<head>
<title>参战人员申请审批表</title>
<next:ScriptManager />
<script type="text/javascript">
	var assignmentId = '<%= (String)request.getParameter("assignmentId")%>';
	var processId = '<%= (String)request.getParameter("processId")%>';
</script>
<script type="text/javascript" src="<%=SkinUtils.getJS(request, "bpm/bpm.js")%>"></script>
				<script>
					<%
						String primaryKey=request.getParameter("primaryKey");
					    if(primaryKey==null)
					    	primaryKey="";
					%>
					<%
						String assignmentId=(String)request.getParameter("assignmentId");
						String procDefUniqueId=(String)request.getParameter("procDefUniqueId");
						String actDefUniqueId=(String)request.getParameter("actDefUniqueId");
						//然调用接口
						List<Map> list = new WfQuery().getActButtons(actDefUniqueId);
						List<Map> list1=new WfQuery().getActFields(actDefUniqueId);
						//遍历list，如果该页面上某个域是需要隐藏的，则设置该域为不显示
						//如果域是只读的则显示为只读
						//如果是非空的，则在点击按钮时进行校验 ，若为空弹出提示框
						String fieldId,fieldName,isHidden,isReadOnly,isNotNull;
						//boolean isHidden,isReadOnly,isNotNull;
					%>
					
					<%
						Map<String, String> Idmap = new HashMap<String, String>();
							BptBaseinfoPeopleQueryCommand command= new BptBaseinfoPeopleQueryCommand();
									String  processId = request.getParameter("processId");
									Idmap = command.queryPeopleByProcessId(processId,assignmentId);
									String peopleId =Idmap.get("peopleId");
									String familyId =Idmap.get("familyId");
									String applyId = Idmap.get("applyId");
					%>
					
					var processId = '<%= (String)request.getParameter("processId")%>';
					var procDefUniqueId = '<%= (String)request.getParameter("procDefUniqueId")%>';
					var assignmentId="<%=assignmentId%>";
					var currentUserName = '<%= GetBspInfo.getBspInfo().getUserName()%>';
				</script>
</head>
<body>
<model:datasets>
	<model:dataset id="DependantApproveDataset" cmd="com.inspur.cams.bpt.manage.cmd.BptApplyDependantQueryCommand" method="queryApplyDependant"  global="true">
	</model:dataset>
	
</model:datasets>

<next:Panel width="100%" height="100%" autoScroll="false">
<next:Tabs>
<next:TabPanel>
<next:Panel width="100%" id="peopleTabPanel" title="基本信息" height="100%">
				<next:Html>
					<iframe id="instance" src="../../../jsp/cams/bpt/comm/peopleDetail.jsp?peopleId=<%=peopleId%>"
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="yes" allowtransparency="yes" width="100%" height="100%">
	   				</iframe>
				</next:Html>
</next:Panel>
<next:Panel width="100%" id="typeTabPanel" title="类别信息" height="100%">
				<next:Html>
					<iframe id="instance" src="../../../jsp/cams/bpt/flow/comm/warTypeDetail.jsp?familyId='<%=(String)request.getParameter("processId")%>'&assignmentId='<%= (String)request.getParameter("assignmentId")%>'"
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="yes" allowtransparency="yes" width="100%" height="100%">
	   				</iframe>
				</next:Html>
</next:Panel>
<next:Panel width="100%" id="menberTabPanel" title="家庭成员信息" height="100%">
				<next:Html>
					<iframe id="instance" src="../../../jsp/cams/bpt/comm/memberListDetail.jsp?familyId='<%=familyId%>'"
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="yes" allowtransparency="yes" width="100%" height="100%">
	   				</iframe>
				</next:Html>
</next:Panel>
<next:Panel width="100%" id="houseTabPanel" title="住房信息" height="100%">
				<next:Html>
					<iframe id="instance" src="../../../jsp/cams/bpt/comm/houseDetail.jsp?familyId='<%=familyId%>'"
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="yes" allowtransparency="yes" width="100%" height="100%">
	   				</iframe>
				</next:Html>
</next:Panel>
<next:Panel id="assessPanel" title="审批信息">
	<next:Html>
		<form id="approveForm" onsubmit="return false" style="padding: 5px;" class="L5form" dataset="DependantApproveDataset">
		<table border="0"  width="99%">
			<table border="0"  width="99%" >
			<div>
				<table width="99%">
			   		<tr>
						<td  class="FieldLabel" colspan="2">申请时间</td>
						<td class="FieldInput" style="width:30%"><label type="text" name="approve_date" field="APPROVE_DATE"/></td>
					
						<td  class="FieldLabel" style="width:20%">申请机构</td>
						<td class="FieldInput" style="width:30%"><label type="text" name="approve_organ_id" field="APPROVE_ORGAN_ID"/></td>
					</tr>
				</table>
			</div>
				<br>
				
			<div id="TownVerify">
				<table width="99%">
			   		<tr>
			   			<td  class="FieldLabel" rowspan="4" nowrap="nowrap">县级审核</td>
			   			<td  class="FieldLabel">负责人</td>
						<td class="FieldInput" style="width:30%"><label name="verify_incharge" field="TOWN_ADUIT_INCHARGE" /> </td>
						
						<td  class="FieldLabel" style="width:20%">时间</td>
						<td class="FieldInput" style="width:30%"><label type="text" name="verify_approve_date" field="TOWN_ADUIT_APPROVE_DATE" /> </td>
					</tr>
					
			   		<tr>	
						<td  class="FieldLabel" >意见</td>
						<td class="FieldInput" colspan="3"><label name="verify_advice" field="TOWN_ADUIT_ADVICE" style="width:80%" rows="2" /></td>
					</tr>
				</table>
			</div>
		</table>
		</form>
   </next:Html>
</next:Panel>	
</next:TabPanel>
</next:Tabs>
</next:Panel>
</body>

<script type="text/javascript">
	function init() {
		var DependantApproveDataset = L5.DatasetMgr.lookup("DependantApproveDataset");
		if(processId=="null"){
			DependantApproveDataset.setParameter("assignmentId",assignmentId);
		}else{
			DependantApproveDataset.setParameter("processId",processId);
		}
		DependantApproveDataset.load();  
		L5.QuickTips.init();
	}
		
</script>
</html>