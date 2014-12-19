<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model" %>
<html>
	<head>
		<title>业务流程设计工具</title>
		<next:ScriptManager></next:ScriptManager>
		<script>
		function init()
		{
			var procDefDataset=L5.DatasetMgr.lookup("procDefDataset");
			procDefDataset.newRecord();
			L5.getCmp("mainPanel").setHeight(screen.height-25);
		}

		function getIframeWindow(id){
			return document.getElementById(id).contentWindow || document.frames[id].window;
		}

		function needConvertHighLevelToExecuteLevel()
		{
			return false;
		}

		function insert()
		{
			var procDefDataset = L5.DatasetMgr.lookup("procDefDataset");
			var record = procDefDataset.getCurrent();
			if (record.get("id")!="") {
				if(executeUpdate())
					alert("流程定义修改成功！");
			}
			else
			{
				if(executeInsert())
					alert("流程定义保存成功！");
			}
		}
		function executeInsert()
		{
			var procDefDataset = L5.DatasetMgr.lookup("procDefDataset");
			var record = procDefDataset.getCurrent();
			var procDefName = getIframeWindow("procEditor").getBpmnDefinitionName();
			var modelingContent = getIframeWindow("procEditor").getBpmnXml();
			var extensionContent = getIframeWindow("procEditor").getExtensionXml();
			
			record.set("procDefId", "procDefId");
			record.set("procDefName", procDefName);
			record.set("modelingContent", modelingContent);
			record.set("extensionContent", extensionContent);
			record.set("isHighLevel", "1");
			record.set("sourceType", "bpmn");
			var valid = procDefDataset.isValidate();
			if (valid !== true) {
				alert("校验未通过，不能保存！" + valid);
				return false;
			}
			var command = new L5.Command(
					"org.loushang.workflow.modeling.definition.cmd.BPMNProcessDefinitionModelingCmd");
			command.setParameter("procDef",procDefDataset.getCurrent().toBean(
								"org.loushang.workflow.modeling.definition.data.BPMNProcessDefinitionModeling"));
			command.execute("insert");
			if (!command.error) {
				record.set("id",command.getReturn("procDefUniqueId"));
				record.set("isHistory", command.getReturn("isHistory"));
				return true;
			} else {
				alert(command.error);
				return false;
			}
		}

		function executeUpdate()
		{
			var procDefDataset = L5.DatasetMgr.lookup("procDefDataset");
			var record = procDefDataset.getCurrent();
			var procDefName = getIframeWindow("procEditor").getBpmnDefinitionName();
			var modelingContent = getIframeWindow("procEditor").getBpmnXml();
			var extensionContent = getIframeWindow("procEditor").getExtensionXml();

			record.set("procDefId", "procDefId");
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
			command.setParameter("procDef",procDefDataset.getCurrent().toBean(
							"org.loushang.workflow.modeling.definition.data.BPMNProcessDefinitionModeling"));
			command.execute("update");
			if (!command.error) {
				return true;
			} else {
				alert(command.error);
				return false;
			}	
		}

		function procEditorScrollEventHandler()
		{
			var frame=getIframeWindow("procEditor");
			frame.designerContainerScrollSizeChanged(document.body.scrollLeft,document.body.scrollTop);
		}

    	function saveProcessDefinition()
		{
			insert();
		}
		
		function forwardToQueryPage()
		{
			var url = 'jsp/workflow/modeling/bpmn/querybpmnprocessdef.jsp?isHighLevel=1';
			var text = 'BPMN流程定义查询';
			L5.forward(url, text);
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
	<body  onscroll="procEditorScrollEventHandler()">
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
			<model:dataset pageSize="20" id="procDefDataset" cmd="org.loushang.workflow.modeling.definition.cmd.BPMNProcessDefinitionModelingQueryCmd" >
				<model:record fromBean="org.loushang.workflow.modeling.definition.data.BPMNProcessDefinitionModeling">
					<model:field name="isRelease" defaultValue="0"/>
				</model:record>
			</model:dataset>
		</model:datasets>
		
		<next:Panel id="mainPanel" height="650">
		<next:Html>
		<form id="userForm" method="post" dataset="procDefDataset" onsubmit="return false"  class="L5form">						
			<input type="hidden" name="id" field="id"/>
			<input type="hidden" name="isRelease" field="isRelease" >
			<input type="hidden" name="procDefId" id="procDefId" field="procDefId" title="流程定义ID"/>			
			<input type="hidden" name="procDefName" field="procDefName" title="流程定义名称"/>	
			<input type="hidden" name="sourceType"  id="sourceType" value="bpmn">
			<input type="hidden" name="xpdlContent" field="bpmnContent" title="流程定义XPDL"/>				
			<input type="hidden" name="xmlContent" field="xmlContent" title="流程定义XML内容"/>		
			<input type="hidden" id="rootUrl" name="rootUrl" title="根路径"  value="<%=rootUrl%>"/>		
		</form>
		<iframe name="procEditor" id="procEditor" frameborder="0" marginheight="0" marginwidth="0" scrolling="no"  width="100%" height="100%" src="<%=flexUrl%>"></iframe>
		</next:Html>
		</next:Panel>
		<input type="hidden" name="id" id="definitionId" field="id" value=""/>
		<input type="hidden" id="isHighLevel" field="isHighLevel" value="1"/>
		<input type="hidden" id="isHorizontal" field="isHorizontal" value="false"/>
	</body>
</html>

