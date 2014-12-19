<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<title>导入流程</title>
<next:ScriptManager></next:ScriptManager>
</head>
<body>
<model:datasets>
	<model:dataset id="upLoadDataSet"
		cmd="org.loushang.workflow.modeling.exchange.cmd.BPMNProcessDefImportCmd">
		<model:record
			fromBean="org.loushang.workflow.modeling.definition.data.BPMNProcessDefinitionModeling"></model:record>
	</model:dataset>
</model:datasets>
<next:Panel>
	<next:TopBar>
		<next:ToolBarItem symbol="导入流程 " />
		<next:ToolBarItem symbol="->" />
		<next:ToolBarItem iconCls="save" text="导入" handler="importBPMNProcess" />
		<next:ToolBarItem iconCls="undo" text="返回" handler="backToPre" />
	</next:TopBar>
	<next:Html>
		<form id="upLoadFileForm" method="post" dataset="upLoadDataSet"
			onsubmit="return false"  class="L5form">
			<table width="100%" border="1">
				<tr>
					<td class="FieldLabel" width="20%">请选择要导入的流程文件:</td>
					<td class="FieldInput" width="80%">
						<input type="file" maxlength="100" id="procDefModelFile" name="procDefModelFile" style="width:300"/>
					</td>
				</tr>
			</table>
		</form>
	</next:Html>
</next:Panel>
</body>
<script type="text/javascript">
// 初始化
function init(){
	var upLoadDataSet = L5.DatasetMgr.lookup("upLoadDataSet");
	upLoadDataSet.newRecord();
	L5.QuickTips.init(); 
}

// 导入流程
function importBPMNProcess() {
	var upLoadDataSet=L5.DatasetMgr.lookup("upLoadDataSet");
	var record=upLoadDataSet.getCurrent();
	
	var command=new L5.Command("org.loushang.workflow.modeling.exchange.cmd.BPMNProcessDefImportCmd"); 
	command.setForm(L5.getDom("upLoadFileForm"));
    command.setParameter("upLoadViewRecord",record); 
    command.setParameter("isHighLevel",'<%=request.getParameter("isHighLevel")%>'); 
    command.afterExecute=function(){
        if (!command.error) {	
        	var state=command.getReturn("state");
        	command.setParameter("state",state);
            command.afterExecute=function(){
            	  if (!command.error) {
            	  	L5.Msg.alert("提示","导入成功!",function(){
            			//转向查询页面
              			var url="jsp/workflow/modeling/bpmn/querybpmnprocessdef.jsp";
              			url = url + "?isHighLevel=" + '<%=request.getParameter("isHighLevel")%>';
						if("1"=="<%=request.getParameter("isHighLevel")%>") {
							text = 'BPMN业务流程定义';
						} else {
							text = 'BPMN可执行流程定义';
						}
              			L5.forward(url,text);
                	});          	        
          		}else{
          			L5.Msg.alert("错误:",command.error);
          		}
            }
            if(state=="0"){
            	command.execute('importProcessDef');
            }else if(state=="1"){
            	L5.MessageBox.confirm('确定', "该流程已存在,是否要覆盖原流程",function(state){
            		if(state=="yes"){   
            			command.execute('importProcessDef');
            		}else{
            			return false;
            		}
            	});	
            }
          
        	
		}else{
			L5.Msg.alert("错误:",command.error);
		}
    }
    command.execute('isExist');		
}

// 返回前界面
function backToPre() {
	var text;
	if("1"=="<%=request.getParameter("isHighLevel")%>") {
		text = 'BPMN业务流程定义';
	} else {
		text = 'BPMN可执行流程定义';
	}
	var url = "jsp/workflow/modeling/bpmn/querybpmnprocessdef.jsp" 
		+ "?isHighLevel=" + '<%=request.getParameter("isHighLevel")%>';
	L5.forward(url,text);
}
</script>
</html>