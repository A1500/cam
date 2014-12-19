<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model" %>
<html>
<head>
<title>流程定义增加</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="procdef.js"></script>
<script>
var needLoadFromParent='<%=request.getParameter("needLoadFromParent")%>';
var displaySourceTypes='<%=request.getParameter("displaySourceTypes")%>';
var fs_procDefId;
var fs_procDefName;
var fs_xmlContent;
var fs_xpdlContent;

function init()
{
	L5.QuickTips.init();
	var procDefDataset=L5.DatasetMgr.lookup("procDefDataset");
	procDefDataset.newRecord();	
	var record = procDefDataset.getCurrent();
	if(needLoadFromParent=="true")
	{
		
		fs_xpdlContent = window.dialogArguments.getIframeWindow("procEditor").getXpdlContent();
		fs_xmlContent = window.dialogArguments.getIframeWindow("procEditor").getXmlContent();
		fs_procDefId = window.dialogArguments.getIframeWindow("procEditor").getProcDefId();
		fs_procDefName = window.dialogArguments.getIframeWindow("procEditor").getProcDefName();
		var baseProcDefDataset=window.dialogArguments.L5.DatasetMgr.lookup("procDefDataset");
		var baseRecord = baseProcDefDataset.getCurrent();
		record.set("id", baseRecord.get("id"));
		record.set("procDefId", baseRecord.get("procDefId"));
		record.set("procDefName", baseRecord.get("procDefName"));
		record.set("xpdlContent", baseRecord.get("xpdlContent"));
		record.set("xmlContent", baseRecord.get("xmlContent"));
		record.set("sourceType", baseRecord.get("sourceType"));
		record.set("processType", baseRecord.get("processType"));
	}
}

function backToNormalMode()
{
	getIframeWindow("procEditor").saveProcess();
	window.dialogArguments.fs_procDefId = getIframeWindow("procEditor").getProcDefId();
	window.dialogArguments.fs_procDefName = getIframeWindow("procEditor").getProcDefName();
	window.dialogArguments.fs_xpdlContent = getIframeWindow("procEditor").getXpdlContent();
	window.dialogArguments.fs_xmlContent = getIframeWindow("procEditor").getXmlContent();
	var baseProcDefDataset=window.dialogArguments.L5.DatasetMgr.lookup("procDefDataset");
	var baseRecord = baseProcDefDataset.getCurrent();
	var procDefDataset=L5.DatasetMgr.lookup("procDefDataset");
	var record = procDefDataset.getCurrent();
	baseRecord.set("id", record.get("id"));
	baseRecord.set("procDefId", record.get("procDefId"));
	baseRecord.set("procDefName", record.get("procDefName"));
	baseRecord.set("xpdlContent", record.get("xpdlContent"));
	baseRecord.set("xmlContent", record.get("xmlContent"));
	baseRecord.set("sourceType", record.get("sourceType"));
	baseRecord.set("processType", record.get("processType"));
	window.returnValue="backToNormalMode";
	window.close();
}
function backToQueryPage(){
	window.returnValue="backToQueryPage";
	window.close();
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
	String displayModel = request.getParameter("displayModel");
	// 插件路径
	String pluginPath = request.getParameter("pluginPath");
	String flexUrl=rootUrl+pluginPath;
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
%>
<model:datasets>
	<model:dataset pageSize="20" id="procDefDataset" cmd="org.loushang.workflow.modeling.definition.cmd.ProcessDefinitionModelingQueryCmd">
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
			<next:ToolBarItem iconCls="undo"  text="退出全屏" handler="backToNormalMode"/>
			<next:ToolBarItem iconCls="undo"  text="返回" handler="backToQueryPage"/>
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
	<input type="hidden" name="displayModel"  id="displayModel" value="<%=displayModel%>"/>
</form>
<iframe name="procEditor" id="procEditor" frameborder="1" marginheight="0" marginwidth="0" scrolling="no"  width="100%" height="100%" src="<%=flexUrl%>"></iframe>

</next:Html>
</next:Panel>
</body>
</html>

