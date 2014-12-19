<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next" %>
<%@ taglib uri="/tags/next-model" prefix="model" %>
<html>
<head>
<%
    String groupId=new String(request.getParameter("groupId"));
%>
<title>本地操作组修改</title>
<next:ScriptManager ></next:ScriptManager >
</head>
<body>
<model:datasets>
	<model:dataset id="actiongroupdef"  cmd="org.loushang.workflow.ecgapform.actiongroupdef.cmd.ActionGroupDefQueryCmd" method="execute" global="true" >
		<model:record fromBean="org.loushang.workflow.ecgapform.actiongroupdef.data.ActionGroupDef">
		    <model:field name="groupId" mapping="groupId" type="string" />
			<model:field name="groupName" mapping="groupName" type="string" />
		</model:record>
	</model:dataset>	
	<model:dataset id="actiondeft"  cmd="org.loushang.workflow.ecgapform.actiongroupdef.cmd.ActionGroupDefQueryCmd" method="selectButton" global="true" >
		<model:record>
		    <model:field name="value" mapping="actionId" type="string"/>
			<model:field name="text" mapping="actionName" type="string" />
		</model:record>
	</model:dataset>	
	<model:dataset id="from_dataset" cmd="org.loushang.workflow.ecgapform.actiondef.cmd.ActionDefQueryCmd"  method="noSelectButton" global="true" pageSize="-1">
		<model:record>
			<model:field name="value" mapping="actionId" type="string"/>
			<model:field name="text" mapping="actionName" type="string" />			
		</model:record>
	</model:dataset>	
</model:datasets>

<next:Panel id="panel_id_2" name="panel_name_2" title="请选择操作" width="100%" autoHeight="true">
	<next:Html>		
		<form id="subForm" method="post" dataset="actiongroupdef"  class="L5form">
			<div align="right">
				<button type="button" onclick="forsave()" >保存</button>
				<button type="button" onclick="toquery()" >返回</button>
			</div>
			<input type="text" name="groupId" field="groupId" style="display:none"/>
			组名称：<input type="text" id="groupName" name="groupName" field="groupName" />
			
			<div id="childrenDiv"></div>
		</form>
	</next:Html>
</next:Panel>
</body>
<script type="text/javascript" defer="defer">
var selItem = null;
function init(){
	var dset = L5.DatasetMgr.lookup("actiongroupdef");	
	var groupId='<%=groupId%>';
	dset.setParameter("GROUP_ID@=",groupId);
	dset.load();
	var from_dataset = L5.DatasetMgr.lookup("from_dataset");
	from_dataset.setParameter("actionGroupDefId",groupId);	
	from_dataset.load();
	var actiondeft = L5.DatasetMgr.lookup("actiondeft");		
	actiondeft.setParameter("actionGroupDefId",groupId);
	actiondeft.load();
	selItem = new L5.ux.ItemSelector({				
		applyTo:"childrenDiv",
		id:"item",
		fromDataset:from_dataset,
		toDataset:actiondeft,
		name:'actionSet',		
		valueField:"value",
		displayField:"text",
		delimiter:'#',
		fromLegend:"操作按钮",
	    toLegend:"已选择操作按钮",
	    msWidth:200,
	    msHeight:200	    
	});	;	

}


function forsave(){
	var groupName=document.getElementById("groupName").value;
	if(groupName==""||groupName==undefined)
	{
		alert("操作组名称不能为空！");
		return;
		}
	var val = selItem.getValue();
	var result="";
	if(val==""||val==undefined)
	{
		alert("请选择表单操作！");
		return;
	}
	var vals=val.split("#");
	for(var i=0;i<vals.length;i++){
		var temp=vals[i]
		if(i!=0){
			temp="#"+temp;
		}
		result+=temp;
	}
	var dset = L5.DatasetMgr.lookup("actiongroupdef");	
	var rec = dset.getCurrent();
	rec.set('actionSet',result);
	var ecgapRecord=actiongroupdef.getCurrent();	
	var command=new L5.Command("org.loushang.workflow.ecgapform.actiongroupdef.cmd.ActionGroupDefCmd");
	command.setParameter("record",ecgapRecord);
	command.execute("update");
	if(!command.error){
		var url='jsp/workflow/ecgapform/actiongroupdef/query.jsp?groupId='+"<%=groupId%>";
		L5.forward(url,"本地操作组修改");
	}else{
		alert(command.error);
	}
}
function toquery(){
	L5.forward("jsp/workflow/ecgapform/actiongroupdef/query.jsp","");
}
</script>
</html>
