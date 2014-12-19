<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<html>
<head>
<title>流程状态图</title>
<next:ScriptManager></next:ScriptManager>
<style type="text/css">
input {
	width:300px;
}
.button{
	width:75px;
}
</style>
</head>
<body>
<%
	StringBuffer sb = new StringBuffer();
	sb.append(request.getScheme());
	sb.append("://");
	sb.append(request.getServerName());
	sb.append(":");
	sb.append(request.getServerPort());
	sb.append(request.getContextPath());
	sb.append("/");
	String rootUrl = sb.toString();
   String flexUrl= rootUrl+"jsp/workflow/monitor/FlowView.html";
   String procDefUniqueId=(String)request.getAttribute("procDefUniqueId");
   if(procDefUniqueId==null)procDefUniqueId=request.getParameter("procDefUniqueId");
   String processId=(String)request.getAttribute("processId");
   if(processId==null)processId=request.getParameter("processId");
   String backUrl=request.getParameter("backUrl");
   if(backUrl==null)backUrl="";
   
%>
<next:Panel width="100%" height="100%">
	<next:Html>
		<form  name="frmList"  action="" class="L5form">					
					<input type="hidden" name="procDefUniqueId" id="procDefUniqueId" value="<%=procDefUniqueId%>" >
					<input type="hidden" name="processId" id="processId" value="<%=processId%>" >
					<input type="hidden" name="assignmentId" id="assignmentId" value="<%=request.getParameter("assignmentId") %>" >
					<input type="hidden" name="isShowOrderCounterSign" id="isShowOrderCounterSign" value="<%=request.getParameter("isShowOrderCounterSign") %>" >
					<input type="hidden" name="isShowParallelCounterSign" id="isShowParallelCounterSign" value="<%=request.getParameter("isShowParallelCounterSign") %>" >
					<input type="hidden" name="isShowSplit" id="isShowSplit" value="<%=request.getParameter("isShowSplit") %>" >
					<input type="hidden" name="isShowJoin" id="isShowJoin" value="<%=request.getParameter("isShowJoin") %>" >
					<input type="hidden" name="isShowSubflow" id="isShowSubflow" value="<%=request.getParameter("isShowSubflow") %>" >
					<input type="hidden" name="isShowActPropertyUrl" id="isShowActPropertyUrl" value="<%=request.getParameter("isShowActPropertyUrl") %>" >
					<input type="hidden" name="actionType" id="actionType" value="<%=request.getParameter("actionType") %>" >
					<input type="hidden" name="isShowActInfoByMouseOver" id="isShowActInfoByMouseOver" value="<%=request.getParameter("isShowActInfoByMouseOver") %>" >
					<input type="hidden" name="isShowStartEndNode" id="isShowStartEndNode" value="<%=request.getParameter("isShowStartEndNode") %>" >
					<input type="hidden" name="isShowIconDetailPanel" id="isShowIconDetailPanel" value="<%=request.getParameter("isShowIconDetailPanel") %>" >
					<input type="hidden" name="isShowSimpleFlowView" id="isShowSimpleFlowView" value="<%=request.getParameter("isShowSimpleFlowView") %>" >
					<input type="hidden" name="isShowProcessInfo" id="isShowProcessInfo" value="<%=request.getParameter("isShowProcessInfo") %>" >
					<input type="hidden" name="isShowBackBtn" id="isShowBackBtn" value="<%=request.getParameter("isShowBackBtn") %>" >
					<input type="hidden" name="pkDataField" id="pkDataField" value="<%=request.getParameter("primaryKey") %>" >
					<input type="hidden" name="rootUrl" id="rootUrl" title="根路径"  value="<%=rootUrl%>"/>	
					<input type="hidden" name="backUrl" id="backUrl" value="<%=backUrl%>" >
					<input type="hidden" name="isShowparentFlowViewButton" id="isShowparentFlowViewButton" value="<%=request.getParameter("isShowparentFlowViewButton") %>" >
		</form>
		<iframe name="procEditor" frameborder="1" marginheight="0" marginwidth="0" scrolling="auto" width="100%" height="100%" src="<%=flexUrl%>"></iframe>
	</next:Html>
</next:Panel>
</body>
<script>
function back(){
    var backUrl=document.getElementById('backUrl').value;
    if(backUrl!=null&&backUrl!="")
    {
    	backUrl = backUrl.replace("\[","?");
    	backUrl = backUrl.replace(":","=");
    	backUrl = backUrl.replace(";","&");
        L5.forward(backUrl,"");
    }
    else
    {
    	window.history.back();
    }      
}
</script>
</html>