<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<title>导入流程</title>
<next:ScriptManager></next:ScriptManager>
<%
	String id = request.getParameter("id");
	if (id == null)
		id = "";
%>
</head>
<body>
<model:datasets>
	<model:dataset id="upLoadDataSet"
		cmd="org.loushang.workflow.modeling.exchange.cmd.ProcessDefImportCmd">
		<model:record
			fromBean="org.loushang.workflow.modeling.definition.data.ProcessDefinitionModeling"></model:record>
	</model:dataset>
</model:datasets>
<next:Panel>
	<next:TopBar>
		<next:ToolBarItem symbol="导入流程 "></next:ToolBarItem>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="save" text="导入" handler="importProcess" />
		<next:ToolBarItem iconCls="undo" text="返回" handler="backToPre" />
	</next:TopBar>
	<next:Html>
		<form id="upLoadFileForm" method="post" dataset="upLoadDataSet"
			onsubmit="return false"  class="L5form">
		<table width="100%" border="1">
			<tr>
				<td class="FieldLabel" width="20%">请选择要导入的流程文件:</td>
				<td class="FieldInput" width="80%"><input type="file" maxlength="100"
					id="procDefModelFile" name="procDefModelFile" style ="width:300"/></td>
			</tr>
		</table>
		</form>
	</next:Html>
</next:Panel>

</body>
<script>
function init(){
	var upLoadDataSet = L5.DatasetMgr.lookup("upLoadDataSet");
	upLoadDataSet.newRecord();
	L5.QuickTips.init(); 
}

function importProcess(){
	var upLoadDataSet=L5.DatasetMgr.lookup("upLoadDataSet");
	var record=upLoadDataSet.getCurrent();
	
	var command=new L5.Command("org.loushang.workflow.modeling.exchange.cmd.ProcessDefImportCmd"); 
	command.setForm(L5.getDom("upLoadFileForm"));
    command.setParameter("upLoadViewRecord",record); 
    command.afterExecute=function(){
        if (!command.error) {	
        	var state=command.getReturn("state");
        	command.setParameter("state",state);
            command.afterExecute=function(){
            	  if (!command.error) {			
            		L5.Msg.alert("提示","导入成功!",function(){
            			//转向查询页面
              			var url="jsp/workflow/modeling/query.jsp";
              			L5.forward(url,"业务Web服务查询");
                		});          	        
          		}else{
          			L5.Msg.alert("错误:",command.error);
          		}
            }
            if(state=="0"){
            	command.execute('importProcessDef');
            }else if(state=="1" || state=="2"){
            	var message="该流程已存在,是否要覆盖原流程";
            	if (state=="2"){
            		message="该流程已存在且已发布,是否要覆盖原流程";
            	}
            	L5.MessageBox.confirm('确定', message,function(state){
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

function backToPre()
{
	var text='流程定义';
	var url = "jsp/workflow/modeling/query.jsp";
	L5.forward(url,text);
}
</script>
</html>