<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="org.loushang.next.skin.SkinUtils" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.portal.util.PortalJspUtil" %>
<html>
<%
String webPath=PortalJspUtil.webPath(request);
%>
<head>
<title>增加页面模板</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="<%=webPath %>/jsp/portal/js/Portal.js"></script>
</head>
<body>
<model:datasets>
	<model:dataset id="portalTemplateDataset" cmd="org.loushang.portal.template.cmd.PortalTemplateQueryCmd" method="queryPortalTemplate" autoLoad="false" global="true">
		<model:record >
			<model:field name="templateName"/>
			<model:field name="pageName"/>
			<model:field name="templateId"/>
			<model:field name="pageId"/>
			<model:field name="type"/>
			<model:field name="permitIds"/>
			<model:field name="permitNames"/>
		</model:record>
	</model:dataset>
	<model:dataset id="typeDataset" enumName="LOUSHANG_PORTAL.TEMPLATE_TYPE"  autoLoad="true" global="true"></model:dataset>
</model:datasets>
<next:Panel  width="100%">
<next:Html>
		<form action="" name="form1" method="post" onsubmit="return false" class="L5Form" dataset="portalTemplateDataset">
			<input type="hidden" id="pageId" name ="pageId" field="pageId"  />	
			<input type="hidden" id="selectedType" />	
				<table width="100%"  cellpadding="0" cellspacing="0" border="0">
					<tr>
						<td class="FieldLabel" nowrap="nowrap"><label>模板名称:</label></td> 
						<td class="FieldInput">
							<input type="text" id="templateName"  name="templateName"  field="templateName"  title="模板名称" maxlength="25"/><font color="red">*</font>
						</td>
						</tr>
						<tr>
						<td class="FieldLabel" nowrap="nowrap"><label >页面名称:</label></td> 
						<td class="FieldInput">
							<input type="text" id="pageName"  name="pageName"  field="pageName"  title="页面名称" maxlength="25" disabled="disabled" />
							<img src="<%=SkinUtils.getImage(request,"l5/liulan.gif")%>"  style="cursor:pointer " onclick="getPortalPage()" /><font color="red">*</font>
						</td>
						</tr>
						<tr> 
							<td class="FieldLabel" nowrap="nowrap"><label >使用对象:</label></td> 
							<td class="FieldInput">
								<select id="type" name="type" field="type" noPlease="true">
									<option dataset="typeDataset"></option>
								</select><font color="red">*</font>
							</td>
						</tr>
						<tr>
							<td class="FieldLabel" nowrap="nowrap"><label >使用范围:</label></td> 
							<td class="FieldInput">
								<input type="hidden" id="permitIds"  name="permitIds"  field="permitIds" title="使用范围"/>
								<textarea rows="3" cols="80" id="permitNames"  field="permitNames" name="permitNames" disabled="disabled" ></textarea>
								<img src="<%=SkinUtils.getImage(request,"l5/liulan.gif")%>"  style="cursor:pointer " onclick="getPermitId()" /><font color="red">*</font>
							</td>
					</tr>
			</table>
		</form>
		</next:Html>
	<next:TopBar>
	<next:ToolBarItem/>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="save"  text="保存" handler="saveTemplate"/>
		<next:ToolBarItem iconCls="save"  text="保存并设计模板" handler="saveAndDesignTemplate"/>
		<next:ToolBarItem iconCls="undo" text="返回" handler="forReturn"/>
	</next:TopBar>

</next:Panel>
</body>
<script type="text/javascript">
function init(){
	portalTemplateDataset.newRecord();
	L5.QuickTips.init(); 
}

//获得使用范围
function getPermitId(){ 
	var type = L5.getDom("type").value;
	var permitIds=L5.getDom("permitIds").value;
	var permitNames=L5.getDom("permitNames").value;

	var revalue = null;
	var url = null;
	switch(type)
	{
		case "0":
			url = L5.webPath+"/jsp/portal/help/userhelper.jsp";
			break;
		case "1":
			url = L5.webPath+"/jsp/portal/help/rolehelper.jsp";
			break;
		case "2":
			url = L5.webPath+"/jsp/portal/help/organtypehelper.jsp";
			break;
		case "3":
			url = L5.webPath+"/jsp/portal/help/organhelper.jsp";
			break;
		default:
			L5.MessageBox.alert("消息提示","请选择使用对象!");
		    return false;
	}
	//传递参数
	var obj = new Object(); 
	obj.permitIds=permitIds;
	obj.permitNames=permitNames;
    
   revalue=LoushangPortalUtil.showModalDialog(url,obj,400,350);   

	if(revalue){
		var list =revalue.split(";");
		L5.getDom("permitIds").value=list[0];
		L5.getDom("permitNames").value=list[1];
  		var rcd = portalTemplateDataset.getCurrent();
  		rcd.set('permitIds',list[0]);
  		rcd.set('permitNames',list[1]);
  		
  		L5.getDom("selectedType").value = type;
	}
}

//选择页面
function getPortalPage(){
	var pageId = L5.getDom("pageId").value;
	var url=L5.webPath+"/jsp/portal/help/pagehelper.jsp?pageId="+pageId;
	var win = LoushangPortalUtil.showModalDialog(url,420,450);
	if (!win) {  
     return;
    }
	var pageId = win[0];
	var pageName = win[1];
	L5.getDom("pageId").value = pageId;
	L5.getDom("pageName").value = pageName;
	var portalTemplateDataset = L5.DatasetMgr.lookup("portalTemplateDataset");
	var rcd = portalTemplateDataset.getCurrent();
	rcd.set('pageId',pageId);
	rcd.set('pageName',pageName);
}

//保存模板并返回
function saveTemplate(){
	if(!check())return;
	var templateRecord = portalTemplateDataset.getCurrent();
	var pageId = L5.getDom("pageId").value;
	
	var command = new L5.Command("org.loushang.portal.template.cmd.PortalTemplateCmd");
	command.setParameter("templateRecord", templateRecord);
	command.setParameter("pageId", pageId);
	command.execute("insertPortalTemplate");
	if (!command.error) {
		L5.MessageBox.alert("消息提示", "保存成功!", function(){
			var url="jsp/portal/template/pagetemplate.jsp";
			L5.forward(url,"页面模板");
		});
	}else{
		L5.MessageBox.alert(command.error);
	}
}

//保存并进入设计模板
function saveAndDesignTemplate(){
	if(!check())return;
	var templateRecord = portalTemplateDataset.getCurrent();
	var pageId = L5.getDom("pageId").value;
	
	var command = new L5.Command("org.loushang.portal.template.cmd.PortalTemplateCmd");
	command.setParameter("templateRecord", templateRecord);
	command.setParameter("pageId", pageId);
	command.execute("insertPortalTemplate");
	if (!command.error) {
		L5.MessageBox.alert("消息提示", "保存成功!", function(){
			var templateId = command.getReturn("templateId");
			var url="jsp/portal/template/pagetemplatedesign.jsp?templateId="+templateId+"&pageId="+pageId;
			L5.forward(url,"设计模板");
		});
	}else{
		L5.MessageBox.alert(command.error);
	}
}

//校验
function check(){
	var templateName = L5.getDom("templateName").value;
	if(!templateName||templateName.replace(/(^\s*)|(\s*$)/g, "")=="")
	{
		L5.MessageBox.alert("消息提示","[模板名称]不能为空!");
		return false;
	}
	
	var pageName = L5.getDom("pageName").value;
	if(!pageName||pageName.replace(/(^\s*)|(\s*$)/g, "")=="")
	{
		L5.MessageBox.alert("消息提示","[页面名称]不能为空!");
		return false;
	}
	var type = L5.getDom("type").value;
	if(!type||type.replace(/(^\s*)|(\s*$)/g, "")=="")
	{
		L5.MessageBox.alert("消息提示","请选择使用对象!");
		return false;
	}
	//使用范围
	var permitId = L5.getDom("permitIds").value;
	if(!permitId||permitId.replace(/(^\s*)|(\s*$)/g, "")=="")
	{
		L5.MessageBox.alert("消息提示","[使用范围]不能为空!");
		return false;
	}
	var selectedType = L5.getDom("selectedType").value;
	if(selectedType != type){
		L5.MessageBox.alert("消息提示","[使用范围]与[使用对象]不一致!");
		return false;
	}
	return true;
}
function forReturn(){
	var url="jsp/portal/template/pagetemplate.jsp";
	L5.forward(url,"页面模板");
}
</script>
</html>