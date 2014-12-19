<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<title>导入业务服务的WSDL文件</title>
<next:ScriptManager></next:ScriptManager>
<%
	String serviceDefId = request.getParameter("serviceDefId");
	if (serviceDefId == null)
		serviceDefId = "";
%>
</head>
<body>
<model:datasets>
	<model:dataset id="wsdlDataSet"
		cmd="org.loushang.workflow.webservice.serviceadmin.businessservice.cmd.BusinessServiceDefCmd">
		<model:record
			fromBean="org.loushang.workflow.webservice.serviceadmin.businessservice.data.WsdlFileView"></model:record>
	</model:dataset>
</model:datasets>
<next:Panel>
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="save" text="导入" handler="importWsdl" />
		<next:ToolBarItem iconCls="undo" text="返回" handler="backToPre" />
	</next:TopBar>
	<next:Html>
		<form id="wsdlFileForm" method="post" dataset="wsdlDataSet"
			onsubmit="return false"  class="L5form">
		<table width="100%" border="1">
			<tr>
				<td class="FieldLabel" width="20%">请输入要导入的WSDL网址:</td>
				<td class="FieldInput" width="80%"><input type="text"
					name="wsdlUri" field="wsdlUri" title="请输入要导入的WSDL网址" size="40" id = "wsdlUri"/><font
					color="red">(例如:http://10.162.1.1:9080/loushang5/services/myServiceName?wsdl)</font></td>
			</tr>
			<tr>
				<td class="FieldLabel" width="20%">请选择要导入的WSDL文件:</td>
				<td class="FieldInput" width="80%"><input type="file"
					id="wsdlFile" name="wsdlFile" style ="width:300"/></td>
			</tr>
		</table>
		</form>
	</next:Html>
</next:Panel>

</body>
<script>
function init(){
	var wsdlDataSet = L5.DatasetMgr.lookup("wsdlDataSet");
	wsdlDataSet.newRecord();
	L5.QuickTips.init(); 
}

function importWsdl(){
	var wsdlDataSet=L5.DatasetMgr.lookup("wsdlDataSet");
	var record=wsdlDataSet.getCurrent();
	var wsdlFile=document.getElementById("wsdlFile").value;
	var wsdlUri=document.getElementById("wsdlUri").value;
	if(wsdlUri=="" && wsdlFile==""){
		L5.Msg.alert("提示:","请输入要导入的WSDL网址或者选择要导入的WSDL文件!");
			return ;
	}
	var command=new L5.Command("org.loushang.workflow.webservice.serviceadmin.businessservice.cmd.BusinessServiceDefCmd"); 
	command.setForm(L5.getDom("wsdlFileForm"));
    command.setParameter("wsdlViewRecord",record);
    command.afterExecute=function(){
	    if (!command.error) {			
	        alert("导入成功!");
	        //转向查询页面
			var url="jsp/workflow/webservice/businessservicedef/query.jsp";
			L5.forward(url,"业务Web服务查询");
		}else{
			L5.Msg.alert("错误:",command.error);
		}
    }
    //导入还是覆盖导入
    var serviceDefId='<%=serviceDefId%>';
    //导入
    if(serviceDefId=="")
    {
    	command.execute('importwsdl');
    }
    //覆盖导入
    else
    {
    	command.setParameter("serviceDefId",serviceDefId);
    	command.execute('overrideimportwsdl');
    }
}

function backToPre()
{
	L5.forward("jsp/workflow/webservice/businessservicedef/query.jsp","");
}
</script>
</html>