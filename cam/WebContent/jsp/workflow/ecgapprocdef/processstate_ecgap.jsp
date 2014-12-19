<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<html>
<head>
<title>流程流转状态</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript">
var returnUrl="";
function setReturnUrl()
{
	var documentUrl=document.URL.toLowerCase().split("?")[1];
	var paramsArr=documentUrl.split("&");
	for(var i=0;i<paramsArr.length;i++)
	{
		var paramName=paramsArr[i].split("=")[0];
		if("returnurl"==paramName)
		{
			returnUrl=unescape(paramsArr[i].split("=")[1]);
			break;
		}
	}
}

function setBackButtonStatus()
{
	if(returnUrl=="")
	{
		L5.getCmp("ret").hide();
	}
}

function init()
{
	setReturnUrl();
	setBackButtonStatus();
}

function back(){
	if(returnUrl!="")
	{
    	var text = '流程定义查询';
   		L5.forward(returnUrl,text);
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
	String rootUrl = sb.toString();
   String flexUrl= rootUrl+"jsp/workflow/monitor/FlowView.html";
%>
<next:ViewPort>
	<next:AnchorLayout>
		<next:Panel anchor="100% 100%">
				<next:TopBar>
					<next:ToolBarItem symbol="->"></next:ToolBarItem>
					<next:ToolBarItem symbol="流转状态"></next:ToolBarItem>
					<next:ToolBarItem symbol="->"></next:ToolBarItem>
					<next:ToolBarItem iconCls="undo" id="ret" text="返回" handler="back"/>
				</next:TopBar>
			<next:Html>
				<form id="userForm" method="post" onsubmit="return false">						
					<input type="hidden" name="procDefUniqueId" id="procDefUniqueId" value="<%=request.getParameter("procDefUniqueId") %>" />
					<input type="hidden" name="processId" id="processId" value="<%=request.getParameter("processId") %>" />
					<input type="hidden" name="assignmentId" id="assignmentId" value="<%=request.getParameter("assignmentId") %>" />
					<input type="hidden" id="rootUrl" name="rootUrl" title="根路径"  value="<%=rootUrl%>"/>		
					<input type="hidden" name="isShowOrderCounterSign" id="isShowOrderCounterSign" value="true" >
					<input type="hidden" name="isShowParallelCounterSign" id="isShowParallelCounterSign" value="true" >
					<input type="hidden" name="isShowSplit" id="isShowSplit" value="true" >
					<input type="hidden" name="isShowJoin" id="isShowJoin" value="true" >
					<input type="hidden" name="isShowSubflow" id="isShowSubflow" value="true" >
					<input type="hidden" name="isShowActPropertyUrl" id="isShowActPropertyUrl" value="false" >
					<input type="hidden" name="actionType" id="actionType" value="" >
					<input type="hidden" name="isShowActInfoByMouseOver" id="isShowActInfoByMouseOver" value="false" >
					<input type="hidden" name="isShowStartEndNode" id="isShowStartEndNode" value="true" >
					<input type="hidden" name="isShowIconDetailPanel" id="isShowIconDetailPanel" value="true" >
					<input type="hidden" name="isShowSimpleFlowView" id="isShowSimpleFlowView" value="true" >
					<input type="hidden" name="isShowProcessInfo" id="isShowProcessInfo" value="false" >
					<input type="hidden" name="isShowBackBtn" id="isShowBackBtn" value="false" >
				<table width="100%" height="100%" cellpadding="0">
					<tr>
						<td>
							<iframe name="procEditor" frameborder="1" marginheight="0" marginwidth="0" scrolling="no"  width="100%" height="100%" src="<%=flexUrl%>"></iframe>
						</td>	
					</tr>			
				</table>
				</form>
		   </next:Html>
		</next:Panel>	
	</next:AnchorLayout>
</next:ViewPort>
</body>
</html>

