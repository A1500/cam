<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model" %>
<%@page import="org.loushang.workflow.api.WfQuery"%>
<html>
	<head>
		<title>流程定义增加</title>
		<next:ScriptManager></next:ScriptManager>
		<script>
		function getIframeWindow(id){
			return document.getElementById(id).contentWindow || document.frames[id].window;
		}
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
			
			String rootUrl=sb.toString();
			
			String flexUrl=rootUrl+"jsp/workflow/monitor/bpmn/BusinessProcessViewer.html";
			String procDefId=request.getParameter("procDefId");
			String procDefUniqueId=request.getParameter("id");
			if(procDefId!=null&&!"".equals(procDefId.trim())&&(procDefUniqueId==null||"".equals(procDefUniqueId.trim())))
			{
				procDefUniqueId=WfQuery.getHighLevelProcDefUniqueIdByProcDefId(procDefId);
			}
		   String backUrl=request.getParameter("backUrl");
		   if(backUrl==null)backUrl="";
		%>
		
		<next:Panel height="735">
			<next:Html>
				<iframe name="procEditor" id="procEditor" frameborder="0" marginheight="0" marginwidth="0" scrolling="no"  width="100%" height="100%" src="<%=flexUrl%>"></iframe>
			</next:Html>
		</next:Panel>
		<input type="hidden" id="rootUrl" name="rootUrl" title="根路径"  value="<%=rootUrl%>"/>
		<input type="hidden" name="id" id="definitionId" field="id" value="<%=procDefUniqueId%>"/>
		<input type="hidden" name="assignmentId" id="assignmentId" field="id" value="<%=request.getParameter("assignmentId")%>"/>
		<input type="hidden" name="processId" id="processId" field="processId" value="<%=request.getParameter("processId")%>"/>
		<input type="hidden" id="isHighLevel" field="isHighLevel" value="1"/>
		<input type="hidden" id="isHorizontal" field="isHorizontal" value="false"/>
		<input type="hidden" name="backUrl" id="backUrl" value="<%=backUrl%>" >
	</body>
</html>

