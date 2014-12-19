<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model" %>
<%@ page import="java.net.URLDecoder" %>
<%
	String displaySourceTypes=request.getParameter("displaySourceTypes");
%>
<html>
	<head>
	<title>流程定义修改</title>
	<next:ScriptManager></next:ScriptManager>
	<script type="text/javascript" src="procdef.js">
	</script>
	<script>
	var fs_procDefId;
	var fs_procDefName;
	var fs_xmlContent;
	var fs_xpdlContent;
	var needLoadFromParent=false;
	var displaySourceTypes='<%=displaySourceTypes%>';
	
	function fullScreenFromModifyPage(){
		needLoadFromParent=true;
		getIframeWindow("procEditor").saveProcess();
		fullscreen();
	}
	
	function fullscreen()
	{
		var url=document.URL.replace("forupdate.jsp","fullscreenupdate.jsp")+"&needLoadFromParent="+needLoadFromParent+"&displaySourceTypes="+displaySourceTypes;
		var ret=showModalDialog(url,window,"scroll:yes;status:no;location:no;dialogWidth:"+screen.width+"px;dialogHeight:"+screen.height+"px")
		if(ret==null)return;
		if(ret=="backToNormalMode"){
			getIframeWindow("procEditor").location.reload();
			needLoadFromParent=true;
		}
		if(ret=="backToQueryPage"){
			back1();
		}
		
	}
	function init(){
	//使这个方法先加载，避免调用procdef.js里的init方法
	var isfullscreen = document.getElementById('isFullScreen').value;
	if(isfullscreen =="true"){
		needLoadFromParent=false;
		fullscreen();
	}
	}
	</script>
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
		String processType=request.getParameter("processType");
		if(processType==null)processType="";
		String isFullScreen=request.getParameter("isFullScreen");
		String displayModel=request.getParameter("displayModel");
		// 插件路径
		String pluginPath=request.getParameter("pluginPath");
	    String flexUrl= rootUrl+pluginPath;
		String sourceType=request.getParameter("sourceType");
		String designer=null;
	    if(sourceType.equals("wfd_bizform")){
	    	designer="wfd_bizform.swf";
	    }else if(sourceType.equals("wfd_soa_xpdl_wsdl")){
	    	designer="wfd_soa_xpdl_wsdl.swf";
	    }else if(sourceType.equals("wfd_oa")){
	    	designer="wfd_oa.swf";
	    }else{
	    	designer="wfd_bizform.swf";
	    }
	 	String isRelease=request.getParameter("isRelease");
	 	
	 	//ren为保留查询结果添加
	 	String procDefName=request.getParameter("procDefName");
	 	procDefName = URLDecoder.decode(procDefName, "UTF-8");
	 	String version=request.getParameter("version");
	%>
	<model:datasets>
		<model:dataset pageSize="20" id="procDefDataset" cmd="org.loushang.workflow.modeling.definition.cmd.ProcessDefinitionModelingGetCmd" autoLoad="true">
			<model:record fromBean="org.loushang.workflow.modeling.definition.data.ProcessDefinitionModeling"></model:record>
		</model:dataset>
	</model:datasets>
	<next:Panel height="735">
		<next:TopBar>
				<next:ToolBarItem symbol="流程设置"></next:ToolBarItem>
				<next:ToolBarItem symbol="->"></next:ToolBarItem>
				<next:ToolBarItem iconCls="save"  text="保存" handler="updatePre"/>
				<next:ToolBarItem iconCls="save"  text="另存为新流程" handler="saveAsPre"/>
				<next:ToolBarItem iconCls="save"  text="另存为新版本" handler="saveAsVersionPre"/>
				<next:ToolBarItem iconCls="select"  text="发布" handler="releaseProcDefPre"/>
				<next:ToolBarItem iconCls="undo"  text="返回" handler="back1"/>
				<next:ToolBarItem iconCls="add"  text="全屏" handler="fullScreenFromModifyPage"/>
		</next:TopBar>
	<next:Html>
	<form id="userForm" method="post" dataset="procDefDataset" onsubmit="return false" class="L5form">						
		<input type="hidden" name="id" field="id" id="id">
		<input type="hidden" id="isRelease" name="isRelease" title="是否发布"   value="<%=isRelease%>">
		<input type="hidden" name="procDefId" id="procDefId" field="procDefId" title="流程定义ID">			
		<input type="hidden" name="procDefName" field="procDefName" title="流程定义名称">				
		<input type="hidden" name="designer" id="designer"   value="<%=sourceType%>">
		<input type="hidden" name="sourceType"   value="<%=sourceType%>">
		<input type="hidden" name="pluginPath"  id="pluginPath" value="<%=pluginPath%>">
		<input type="hidden" name="xpdlContent" field="xpdlContent" title="流程定义XPDL">				
		<input type="hidden" name="xmlContent" field="xmlContent" title="流程定义XML内容">
		<input type="hidden" id="rootUrl" name="rootUrl" title="根路径"  value="<%=rootUrl%>">
		<input type="hidden" name="formId"  id="formId" value=""/>	
		<input type="hidden" name="processType"  id="processType" value="<%=processType%>"/>
		<input type="hidden" name="isFullScreen"  id="isFullScreen" value="<%=isFullScreen%>"/>
		<input type="hidden" name="displayModel"  id="displayModel" value="<%=displayModel%>"/>
	</form>
		<iframe name="procEditor" id="procEditor" frameborder="0" marginheight="0" marginwidth="0" scrolling="no"  width="100%" height="100%" src="<%=flexUrl%>"></iframe>
	</next:Html>
	</next:Panel>
	</body>
<script>
// 跳转到流程定义查询页面
function forwardToQuery1() {	
	var url = 'jsp/workflow/modeling/query.jsp?procDefName='+'<%=procDefName%>'+'&version='+'<%=version%>'+"&displaySourceTypes="+displaySourceTypes;
	url = encodeURI(encodeURI(url));
	var text = '流程定义查询';
	L5.forward(url, text);
}

function back1() {
	forwardToQuery1();
}
</script>
</html>
