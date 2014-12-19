<%@ page language="java" contentType="text/html;charset=utf-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="org.loushang.workflow.util.bsp.BspUtil"%>
<%@ page import="org.loushang.workflow.util.bsp.WfStru"%>


<% 
WfStru wfStru=BspUtil.getInstance().getEmployeeStruView();
String organId=wfStru.getOrganId();
if(organId==null)
	organId="";
String organName=wfStru.getOrganName();
if(organName==null)
	organName="test";
String userId=BspUtil.getInstance().getLoginUserId();
if(userId==null){
	userId="";
}
%>
<html>
<head>
<title>设置委托</title>
<next:ScriptManager></next:ScriptManager>
</head>
<body>
<next:ViewPort>
	<next:Defaults>{collapsible:true,split:true,animFloat:true,autoHide:true,useSplitTips:true,bodyStyle:'padding:1px;'}</next:Defaults>
	<next:Panel>
		<next:Panel width="100%" border="0"
			bodyStyle="padding-bottom:5px;padding-top:0px;">
			<next:Html>	
				<table border="1" width="100%">
					<tr>
						<td class="FieldLabel" width="100">流程名称</td>
						<td class="FieldInput" ><input type="text" id="procDefName"
							class="TextEditor" title="流程名称" size="30" readonly="readonly"/>
							<input type="text" id="procId" 
							class="TextEditor" style="display:none" />
						<img src="<%=SkinUtils.getImage(request,"l5/liulan.gif")%>"  style="cursor:pointer " onclick="selectProcess()" />
							</td>
					</tr>
					<tr>
						<td class="FieldLabel" width="100">代理人：</td>
						<td class="FieldInput"><input type="text" id="proxyUserOrganName"
							class="TextEditor" title="代理人" size="30" readonly="readonly"/>
							<input type="text" id="proxyUserOrganId"
							class="TextEditor" style="display:none" />
						<img src="<%=SkinUtils.getImage(request,"l5/liulan.gif")%>"  style="cursor:pointer " onclick="selectProxyUser()" />
					</td>
					</tr>
				</table>
			</next:Html>
			<next:TopBar>
	<next:ToolBarItem/>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="save"  text="保存" handler="save"/>
		<next:ToolBarItem iconCls="remove"  text="关闭" handler="forReturn"/>
	</next:TopBar>
		</next:Panel>
	</next:Panel>
</next:ViewPort>
</body>
<script language="javascript" type="text/javascript">
//流程ID
var processIds=[];
var proxyOrganIds=[];
//保存
function save(){
	var proxyUserOrganName=document.getElementById("proxyUserOrganName").value;
	var proxyUserOrganId=document.getElementById("proxyUserOrganId").value;
	var proxyUserOrganIds=proxyUserOrganId.split(",");
	var procDefName=document.getElementById("procDefName").value;
	var procDefNames=procDefName.split(",");
	var processId=document.getElementById("procId").value;
	var processIds=processId.split(",");
	if(procDefName=="" ||proxyUserOrganName=="" ){
		L5.Msg.alert("消息提示","[流程名称]和[代理人]不能为空");
		return;
		}
	var originalOrganName="<%=organName%>";
	var originalOrganId="<%=organId%>";
	
	var command =new L5.Command("org.loushang.workflow.tripproxy.cmd.TripProxyProcDefCmd");
	command.setParameter("procDefNames",procDefNames);
	command.setParameter("processIds",processIds);
	command.setParameter("proxyOrganId",proxyUserOrganIds);
	command.setParameter("proxyOrganName",proxyUserOrganName);
	command.setParameter("originalOrganName",originalOrganName);
	command.setParameter("originalOrganId",originalOrganId);
	command.afterExecute = function() {
		if (!command.error) {
			L5.Msg.alert("消息提示","保存成功");
			window.close();
			
		}else {
			L5.Msg.alert("错误:", command.error);
		}
    }
	command.execute("insert");
}
	
//选择流程
function selectProcess(){
	var dialogMsg = "scroll:yes;status:no;dialogWidth:470px;dialogHeight:450px"; //弹出框设置信息
	var url=L5.webPath+"/jsp/workflow/tripproxy/dialog/processselect.jsp";
	var win = showModalDialog(url,window,dialogMsg); //弹出框
	if(!win){
		return;
	}
	document.getElementById("procId").value=win[0];
	document.getElementById("procDefName").value=win[1];
}
//选择代理人
function selectProxyUser(){
	var dialogMsg = "scroll:no;status:no;dialogWidth:470px;dialogHeight:450px"; //弹出框设置信息
	var L5_webPath = L5.webPath + "/jsp/public/help/help.jsp?helpCode=bsp_organhelp&rootId=rootId";
	var url = L5_webPath + "&organType=8&showOrganType=0&isExact=0&isCheckBox=1&isTree=1&userId="+"<%=userId%>";
	var win = showModalDialog(url,window,dialogMsg); //弹出框
	if(!win){
		return;
	}
	var returnValues=win.split(";");
	document.getElementById("proxyUserOrganId").value=returnValues[0];
	document.getElementById("proxyUserOrganName").value=returnValues[1];
}
function forReturn(){
	window.close();
}
</script>
</html>