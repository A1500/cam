<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model" %>
<%@page import="org.loushang.workflow.util.WfProcessPluginTypeApi"%>
<%@page import="org.loushang.next.data.Record"%>

<%
	String displaySourceTypes=request.getParameter("displaySourceTypes");
%>
<html>
	<head>
		<title>流程定义增加</title>
		<next:ScriptManager></next:ScriptManager>
		<script type="text/javascript" src="procdef.js"></script>
		<script>
		var fs_procDefId;
		var fs_procDefName;
		var fs_xmlContent;
		var fs_xpdlContent;
		var needLoadFromParent=false;
		var displaySourceTypes='<%=displaySourceTypes%>';
		function init()
		{
			var procDefDataset=L5.DatasetMgr.lookup("procDefDataset");
			procDefDataset.newRecord();
			L5.QuickTips.init();
			var isfullscreen = document.getElementById('isFullScreen').value;
			if(isfullscreen=="true"){
				needLoadFromParent=false;
				fullscreen();
			}
		}
		
		function fullScreenFromInsertPage(){
			needLoadFromParent=true;
			getIframeWindow("procEditor").saveProcess();
			fullscreen();
		}
		
		function fullscreen()
		{
			var url=document.URL.replace("forinsert.jsp","fullscreeninsert.jsp")+"&needLoadFromParent="+needLoadFromParent
				+"&pluginPath="+document.getElementById('pluginPath').value+"&displaySourceTypes="+displaySourceTypes;
			var ret=showModalDialog(url,window,"scroll:yes;status:no;location:no;dialogWidth:"+screen.width+"px;dialogHeight:"+screen.height+"px")
			if(ret==null)return;
			if(ret=="backToQueryPage"){
				back();
			}
			if(ret=="backToNormalMode"){
				getIframeWindow("procEditor").location.reload();
				needLoadFromParent=true;
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
			
			String formId=request.getParameter("formId");
			if(formId==null)formId="";
			
			String processType=request.getParameter("processType");
			if(processType==null)processType="";
			// 插件类型
			String sourceType=request.getParameter("sourceType");
			Record Record = WfProcessPluginTypeApi.getByPluginType(sourceType);
			// 插件路径
			String pluginPath = (String) Record.get("pluginPath");
			if (pluginPath.startsWith("/")) {
				pluginPath = pluginPath.substring(1);
			}
			String isFullScreen=request.getParameter("isFullScreen");
			String displayModel=request.getParameter("displayModel");
			String flexUrl=rootUrl+pluginPath;
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
		%>
		<model:datasets>
			<model:dataset pageSize="20" id="procDefDataset" cmd="org.loushang.workflow.modeling.definition.cmd.ProcessDefinitionModelingQueryCmd" >
				<model:record fromBean="org.loushang.workflow.modeling.definition.data.ProcessDefinitionModeling">
					<model:field name="isRelease" defaultValue="0"/>
				</model:record>
			</model:dataset>
		</model:datasets>
		
		<next:Panel height="735">
			<next:TopBar>
					<next:ToolBarItem symbol="流程设置"></next:ToolBarItem>
					<next:ToolBarItem symbol="->"></next:ToolBarItem>
					<next:ToolBarItem iconCls="save"  text="保存" handler="insertPre"/>
					<next:ToolBarItem iconCls="select"  text="发布" handler="releaseProcDefPre"/>
					<next:ToolBarItem iconCls="undo"  text="返回" handler="back"/>
					<next:ToolBarItem iconCls="add"  text="全屏" handler="fullScreenFromInsertPage"/>
			</next:TopBar>
		<next:Html>
		<form id="userForm" method="post" dataset="procDefDataset" onsubmit="return false"  class="L5form">						
			<input type="hidden" name="id" field="id"/>
			<input type="hidden" name="isRelease" field="isRelease" >
			<input type="hidden" name="procDefId" id="procDefId" field="procDefId" title="流程定义ID"/>			
			<input type="hidden" name="procDefName" field="procDefName" title="流程定义名称"/>	
			<input type="hidden" name="designer" id="designer"  value="<%=sourceType%>">
			<input type="hidden" name="sourceType"  id="sourceType" value="<%=sourceType%>">
			<input type="hidden" name="pluginPath"  id="pluginPath" value="<%=pluginPath%>">
			<input type="hidden" name="xpdlContent" field="xpdlContent" title="流程定义XPDL"/>				
			<input type="hidden" name="xmlContent" field="xmlContent" title="流程定义XML内容"/>		
			<input type="hidden" id="rootUrl" name="rootUrl" title="根路径"  value="<%=rootUrl%>"/>	
			<input type="hidden" name="formId"  id="formId" value="<%=formId%>"/>
			<input type="hidden" name="processType"  id="processType" value="<%=processType%>"/>
			<input type="hidden" name="isFullScreen"  id="isFullScreen" value="<%=isFullScreen%>"/>
			<input type="hidden" name="displayModel"  id="displayModel" value="<%=displayModel%>"/>
		</form>
		<iframe name="procEditor" id="procEditor" frameborder="0" marginheight="0" marginwidth="0" scrolling="no"  width="100%" height="100%" src="<%=flexUrl%>"></iframe>
		</next:Html>
		</next:Panel>
	</body>
</html>

