<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model" %>
<html>
	<head>
		<title>业务流程设计工具</title>
		<next:ScriptManager></next:ScriptManager>
		<script>
		var needConvertToExecuteLevel='<%=request.getParameter("needConvertToExecuteLevel")%>';
		function needConvertHighLevelToExecuteLevel()
		{
			return needConvertToExecuteLevel=="true";
		}
		function getIframeWindow(id){
			return document.getElementById(id).contentWindow || document.frames[id].window;
		}
		
		function executeUpdatePre()
		{
			getIframeWindow("procEditor").executePre("executeUpdate");
		}

		function executeUpdate()
		{
			var procDefDataset = L5.DatasetMgr.lookup("procDefDataset");
			var record = procDefDataset.getCurrent();
			var procDefName = getIframeWindow("procEditor").getBpmnDefinitionName();
			var modelingContent = getIframeWindow("procEditor").getBpmnXml();
			var extensionContent = getIframeWindow("procEditor").getExtensionXml();
			var procDefId = getIframeWindow("procEditor").getProcDefId();
			
			record.set("procDefId", procDefId);
			record.set("procDefName", procDefName);
			record.set("modelingContent", modelingContent);
			record.set("extensionContent", extensionContent);
			var isValidate = procDefDataset.isValidate();
			if (isValidate != true) {
				alert("校验未通过，不能保存！" + isValidate);
				return false;
			}
			var command = new L5.Command(
					"org.loushang.workflow.modeling.definition.cmd.BPMNProcessDefinitionModelingCmd");

			if(needConvertHighLevelToExecuteLevel())
			{
				record.set("isHighLevel","0");
				command.setParameter("procDef",procDefDataset.getCurrent().toBean(
							"org.loushang.workflow.modeling.definition.data.BPMNProcessDefinitionModeling"));
				command.setParameter("isConvertHighLevelToExecuteLevel","true");
				command.setParameter("highLevelProcDefUniqueId",record.get("id"));
				command.execute("insert");
				if (!command.error) {
					alert("流程修改成功！");
					record.set("id",command.getReturn("procDefUniqueId"));
					needConvertToExecuteLevel=false;
					return true;
				} else {
					alert(command.error);
					return false;
				}	
			}
			else
			{
				command.setParameter("procDef",procDefDataset.getCurrent().toBean(
							"org.loushang.workflow.modeling.definition.data.BPMNProcessDefinitionModeling"));
				command.execute("update");
				if (!command.error) {
					alert("流程修改成功！");
					return true;
				} else {
					alert(command.error);
					return false;
				}	
			}

		}

		function procEditorScrollEventHandler()
		{
			var frame=getIframeWindow("procEditor");
			frame.designerContainerScrollSizeChanged(document.body.scrollLeft,document.body.scrollTop);
		}

    	function saveProcessDefinition()
		{
    		executeUpdatePre();
		}
		
		function forwardToQueryPage()
		{
			var url = 'jsp/workflow/modeling/bpmn/querybpmnprocessdef.jsp?isHighLevel='+<%=request.getParameter("isHighLevel")%>;
			var text = 'BPMN流程定义查询';
			L5.forward(url, text);
		}
		function init()
		{
			var procDefDataset=L5.DatasetMgr.lookup("procDefDataset");
			procDefDataset.setParameter("id",'<%=request.getParameter("id")%>');
			procDefDataset.load();
			L5.getCmp("mainPanel").setHeight(screen.height-25);
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
	<body onscroll="procEditorScrollEventHandler()">
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
			
			String flexUrl=rootUrl+"jsp/workflow/modeling/bpmn/BusinessProcessDesigner.html";
		%>
	<model:datasets>
		<model:dataset pageSize="20" id="procDefDataset" cmd="org.loushang.workflow.modeling.definition.cmd.BPMNProcessDefinitionModelingGetCmd">
			<model:record fromBean="org.loushang.workflow.modeling.definition.data.BPMNProcessDefinitionModeling"></model:record>
		</model:dataset>
	</model:datasets>
		
		<next:Panel id="mainPanel" height="650">
		<next:Html>
		<form id="userForm" method="post" dataset="procDefDataset" onsubmit="return false"  class="L5form">						
			<input type="hidden" name="id" field="id" value="<%=request.getParameter("id")%>"/>
			<input type="hidden" name="isRelease" field="isRelease" >
			<input type="hidden" name="procDefId" id="procDefId" field="procDefId" title="流程定义ID"/>			
			<input type="hidden" name="procDefName" field="procDefName" title="流程定义名称"/>	
			<input type="hidden" name="modelingContent" field="modelingContent" title="流程定义XPDL"/>				
			<input type="hidden" name="extensionContent" field="extensionContent" title="流程定义XML内容"/>		
			<input type="hidden" id="rootUrl" name="rootUrl" title="根路径"  value="<%=rootUrl%>"/>	
			<input type="hidden" id="sourceType" field="sourceType" />
		</form>
		<iframe name="procEditor" id="procEditor" frameborder="0" marginheight="0" marginwidth="0" scrolling="no"  width="100%" height="100%" src="<%=flexUrl%>"></iframe>
		</next:Html>
		</next:Panel>
		<input type="hidden" name="id" id="definitionId" field="id" value="<%=request.getParameter("id")%>"/>
		<input type="hidden" id="isHighLevel" field="isHighLevel" value="<%=request.getParameter("isHighLevel")%>"/>
		<input type="hidden" id="isHorizontal" field="isHorizontal" value="false"/>
	</body>
</html>

