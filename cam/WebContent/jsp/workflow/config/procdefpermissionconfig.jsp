<%@ page language="java" contentType="text/html;charset=utf-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<HTML>
<HEAD>
<TITLE>流程定义权限配置</TITLE>
<next:ScriptManager></next:ScriptManager>
</HEAD>
<BODY>
<model:datasets>
	<model:dataset enumName="PROC_DEF_PERMISSION_CONFIG" id="procDefPermissionConfig" autoLoad="true">
	</model:dataset>
</model:datasets>

<next:ViewPort>
		<next:Panel>
		<next:Html>
		<form id="userForm" method="post" onsubmit="return false" class="L5form">
		<table width="100%" border="1"> 
			<tr>
				<td class="FieldLabel" width="20%">流程定义权限控制：</td>
				<td class="FieldInput" width="30%">
					<select id="procDefPermissionConfig" style="width:200">
							<option dataset="procDefPermissionConfig"></option>
					</select>
				</td>
				<td class="FieldButton" rowspan="2" width="10%">
					<button onclick="doConfirm()">保存</button>
				</td>
				<td width="40%"></td>
			</tr>
		</table>
		</form>
	</next:Html>
	</next:Panel>
</next:ViewPort>
</body>
<script language="javascript">
function doConfirm(){
	var configInfo=document.getElementById("procDefPermissionConfig").value;
	var command = new L5.Command("org.loushang.workflow.config.property.cmd.PropertyConfigCmd");
	command.setParameter("propertyKey","PROC_DEF_PERMISSION_CONFIG");
	command.setParameter("propertyValue",configInfo);
	if(configInfo==null || configInfo==""){
		L5.Msg.alert("提示","请选择权限控制类型！");
		return;
	}
	var propertyDescription = "";
	if(configInfo=="0"){
		propertyDescription ="不进行权限控制";
	}else if(configInfo=="1"){
		propertyDescription ="本单位内的权限控制";
	}else if(configInfo=="2"){
		propertyDescription ="本单位及上级单位的权限控制";
	}else if(configInfo=="3"){
		propertyDescription ="本单位及下属单位的权限控制";
	}
	command.setParameter("propertyDescription",propertyDescription);
	command.execute("saveProcDefPermissionConfig");
	if(!command.error){
		  L5.Msg.alert("提示","保存成功!");
	}else{
		  L5.Msg.alert("错误",command.error);
	}
}
function init(){
	var command=new L5.Command("org.loushang.workflow.config.property.cmd.PropertyConfigCmd");
	command.execute("queryProcDefProperty");
	if(!command.error){
		document.getElementById("procDefPermissionConfig").value=command.getReturn("propertyValue");
	}else{
		L5.Msg.alert("错误",command.error);
	}
}
</script>
</html>