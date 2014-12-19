<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<html>
<%String procDefUniqueId = request.getParameter("procDefUniqueId");
	if(procDefUniqueId == null){
		procDefUniqueId = (String)request.getSession().getAttribute("procDefUniqueId");
	}else{
		request.getSession().setAttribute("procDefUniqueId",procDefUniqueId);
	}
	String procName = request.getParameter("procName");
	if(procName == null){
		procName = "";
	}else{
    	procName = java.net.URLDecoder.decode(procName,"UTF-8");
	}
%>
	<head>
		<title>流程归档实例列表</title>
		<next:ScriptManager/>
		<script type="text/javascript">
		var beforeInit={id:"<%=procDefUniqueId%>"}
		</script>
		<script type="text/javascript" src="queryprocessend.js"></script>
		<script language="javascript"  type="text/javascript" >
		 	 //查询条件面板打开合并函数
			 function collapse(element){
				var fieldsetParent=L5.get(element).findParent("fieldset");
				if(element.expand==null||element.expand==true){
					fieldsetParent.getElementsByTagName("div")[0].style.display="none";
					element.src = '<%=SkinUtils.getImage(request,"groupbox_expand.gif")%>';
					element.expand=false;
				}else{
					fieldsetParent.getElementsByTagName("div")[0].style.display="";
					element.src = "<%=SkinUtils.getImage(request,"groupbox_collapse.gif")%>";
					element.expand =true;
				}
			}
		</script>
	</head>
<body>
<model:datasets>
	<model:dataset id="ds" pageSize="10" cmd="org.loushang.workflow.manage.processend.cmd.ProcessEndManageQueryCmd" global="true">
		<model:record fromBean="org.loushang.workflow.manage.processend.data.ProcessEndManage"></model:record>
	</model:dataset>
</model:datasets>
<next:ViewPort>
	<next:Defaults>{collapsible:true,split:true,animFloat:true,autoHide:true,useSplitTips:true,bodyStyle:'padding:6px;'}</next:Defaults>
	<next:Panel>
<next:Panel  name="form" width="100%" border="0" bodyStyle="padding-bottom:10px;padding-top:12px;" autoHeight="true" >
	<next:Html>
	<fieldset style="overflow: visible;" class="GroupBox">
		<legend class="GroupBoxTitle">查询条件<img class="GroupBoxExpandButton" src="<%=SkinUtils.getImage(request,"groupbox_collapse.gif")%>" onclick="collapse(this);"/></legend>
		<div class="GroupBoxDiv" style="width: 100%;height: 100%;">
			<form onsubmit="return false;"  class="L5form">
				<table  border="1" width="100%" >
					<tr >
						<td class="FieldLabel">标题:</td>
						<td class="FieldInput"><input type="text"  id="subjectName" class="TextEditor" title="标题" /></td>
						<td class="FieldButton"><button onclick="query()">查 询</button> </td>
					</tr>
				</table></form></div>
	</fieldset>
	</next:Html>
</next:Panel>
<next:GridPanel id="GridPanel" name="processdefGrid" width="100%" stripeRows="true" height="100%"
dataset="ds" title="流程实例归档管理" notSelectFirstRow="true">
<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="环节实例归档列表" iconCls="select" handler="toActivity()"/>
		<next:ToolBarItem text="删除" iconCls="delete" handler="delProcess()"/>
		<next:ToolBarItem text="流转状态" iconCls="detail" handler="toState()"/>
		<next:ToolBarItem text="返回" iconCls="undo" handler="toProcessDef()"/>
	</next:TopBar>
	<next:Columns>
	    <next:RowNumberColumn width="30"/>
		<next:CheckBoxColumn  ></next:CheckBoxColumn>
		<next:Column id="subject" header="标题" field="subject" width="200" >
		</next:Column>
		<next:Column id="procDefName" header="流程名称" field="procDefName" width="200" >
		</next:Column>
		<next:Column id="procCreateTime" header="开始时间" field="procCreateTime"  width="150" >
		</next:Column>
		<next:Column id="procEndTime" header="结束时间" field="procEndTime" width="150" >
		</next:Column>

	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="ds"/>
	</next:BottomBar>
</next:GridPanel>
</next:Panel>
</next:ViewPort>
</body>
</html>
<script language="javascript" type="text/javascript">
function toProcessDef(){
	var text='管理监控页面';
	var url = "jsp/workflow/manage/queryprocessdefadmin.jsp?procName="+"<%=procName%>";
	url = encodeURI(encodeURI(url));
	L5.forward(url,text);
}
</script>