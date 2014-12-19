<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="org.loushang.workflow.util.bsp.BspUtil"%>
<%@ page import="org.loushang.workflow.util.bsp.WfStru"%>

<html>
<head>
<title>修改页面定义</title>
<next:ScriptManager></next:ScriptManager>
</head>
<%
WfStru wfStru=BspUtil.getInstance().getEmployeeStruView();
String originalOrganId=wfStru.getOrganId();
String procDefId = request.getParameter("procDefId");
String id = request.getParameter("id");
String oldProxyOrganId=request.getParameter("oldProxyOrganId");
String userId=BspUtil.getInstance().getLoginUserId();
if(userId==null){
	userId="";
}
%>
<body>
<model:datasets>
	<model:dataset pageSize="10" id="proxyProcDefDs" method="queryByProcDefId"
		cmd="org.loushang.workflow.tripproxy.cmd.TripProxyProcDefQueryCmd" autoLoad="false" global="true">
		<model:record>
			<model:field name="ID" type="string" />
			<model:field name="PROC_DEF_NAME" type="string" />
			<model:field name="PROC_DEF_ID" type="string" />
			<model:field name="ORIGINAL_ORGAN_NAME" type="string" />
			<model:field name="ORIGINAL_ORGAN_ID" type="string"/>
			<model:field name="PROXY_ORGAN_ID" type="string" />
			<model:field name="PROXY_ORGAN_NAME" type="string" />
		</model:record>
	</model:dataset>
</model:datasets>
<next:Panel width="100%" >
	<next:Html>
		<form action="" name="form1" method="post" onsubmit="return false" class="L5Form" dataset="proxyProcDefDs">
			<table width="100%" cellpadding="0" cellspacing="0" border="0">
					<tr>
						<td class="FieldLabel" width="20%"><label>流程名称:</label></td> 
						<td class="FieldInput" >
							<input id="procDefName" type="text"  name="name"  field="PROC_DEF_NAME" title="流程名称" readonly="readonly" size="80"/>
							<input id="procDefId" type="text"  name="name"  field="PROC_DEF_ID" style="display:none"/>
							<input id="originalOrganId" type="text"  name="name"  field="ORIGINAL_ORGAN_ID"  style="display:none" />
							<input id="originalOrganName" type="text"  name="name"  field="ORIGINAL_ORGAN_NAME" style="display:none"/>
							<input id="id" type="text"  name="name"  field="ID" style="display:none"/>
						</td>
					</tr>
					<tr>
						<td class="FieldLabel" width="20%"><label >代理人:</label></td> 
						<td class="FieldInput" ><input id="proxyOrganName" type="text"  name="name" field="PROXY_ORGAN_NAME"  title="代理人" size="80"/>
						<img src="<%=SkinUtils.getImage(request,"l5/liulan.gif")%>"  style="cursor:pointer " onclick="selectProxyUser()" />
							<input id="newProxyOrganId" type="text"  name="name"   field="PROXY_ORGAN_ID" style="display:none"/>
						</td>
					</tr>
				</table>
		</form>
	</next:Html>
	<next:TopBar>
	<next:ToolBarItem/>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="save"  text="保存" handler="save"/>
		<next:ToolBarItem iconCls="undo"  text="返回" handler="forReturn"/>
	</next:TopBar>
</next:Panel>
</body>
<script type="text/javascript">
function init(){       
    var procDefId='<%=procDefId%>';
    var originalOrganId='<%=originalOrganId%>';
    proxyProcDefDs.setParameter("PROC_DEF_ID",procDefId);
    proxyProcDefDs.setParameter("ORIGINAL_ORGAN_ID",originalOrganId);
    proxyProcDefDs.load(true);
}

function save(){	
	var record = proxyProcDefDs.getCurrent();
	var proxyOrganName=document.getElementById("proxyOrganName").value;
	var newProxyOrganId=document.getElementById("newProxyOrganId").value;
	if(proxyOrganName==""){
		L5.Msg.alert("消息提示","代理人不能为空!");
		return;
	}
	record.set("ID","<%=id%>");
	record.set("PROXY_ORGAN_ID",newProxyOrganId);
	record.set("PROXY_ORGAN_NAME",proxyOrganName);
	var command =new L5.Command("org.loushang.workflow.tripproxy.cmd.TripProxyProcDefCmd");
	command.setParameter("record",record);
	command.setParameter("oldProxyOrganId",'<%=oldProxyOrganId%>');
	command.afterExecute = function() {
		if (!command.error) {
			L5.Msg.alert("消息提示","修改成功");
			window.close();
			var url="jsp/workflow/tripproxy/processtripproxy.jsp";
			L5.forward(url,"委托列表");
		}else {
			L5.Msg.alert("错误:", command.error);
		}
}
	command.execute("update");
	}
function forReturn(){
	var url="jsp/workflow/tripproxy/processtripproxy.jsp";
	L5.forward(url,"委托；列表");
}

function selectProxyUser(){
	var dialogMsg = "scroll:yes;status:no;dialogWidth:420px;dialogHeight:450px"; //弹出框设置信息
	var L5_webPath = L5.webPath + "/jsp/public/help/help.jsp?helpCode=bsp_organhelp&rootId=rootId";
	var url = L5_webPath + "&organType=8&showOrganType=0&isExact=0&isCheckBox=1&isTree=1&userId="+"<%=userId%>";
	var win = showModalDialog(url,window,dialogMsg); //弹出框
	if(!win){
		return;
	}
	var returnValues=win.split(";");
	document.getElementById("newProxyOrganId").value=returnValues[0];
	document.getElementById("proxyOrganName").value=returnValues[1];
	
}
</script>
</html>