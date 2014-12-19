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
	if(procName != null)
	procName = java.net.URLDecoder.decode(procName,"UTF-8");
%>
	<head>
		<title>流程活动实例列表</title>
		<next:ScriptManager/>
		<script type="text/javascript">
		var beforeInit={id:"<%=procDefUniqueId%>"}
		</script>
		<script type="text/javascript" src="queryprocessadmin.js"></script>
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
	<model:dataset id="ds" pageSize="10" cmd="org.loushang.workflow.manage.process.cmd.ProcessManageQueryCmd" global="true">
		<model:record fromBean="org.loushang.workflow.manage.process.data.ProcessManage"></model:record>
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
						<td class="FieldLabel"><button onclick="query()">查 询</button> </td>
					</tr>
				</table></form></div>
	</fieldset>
	</next:Html>
</next:Panel>
<next:GridPanel id="GridPanel" name="processdefGrid" width="100%" stripeRows="true" anchor="100%"
				height="100%" dataset="ds" title="流程实例管理" notSelectFirstRow="true">
<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="环节实例列表" iconCls="select" handler="toActivity()"/>
		<next:ToolBarItem text="挂起" iconCls="remove" handler="suspend()"/>
		<next:ToolBarItem text="恢复" iconCls="undo" handler="resume()"/>
		<next:ToolBarItem text="中断" iconCls="remove" handler="abort()"/>
		<next:ToolBarItem text="终止" iconCls="remove" handler="terminate()"/>
		<next:ToolBarItem text="删除" iconCls="delete" handler="dele"/>
		<next:ToolBarItem text="流转状态" iconCls="detail" handler="toState()"/>
		<next:ToolBarItem text="返回" iconCls="undo" handler="toProcessDef()"/>
	</next:TopBar>
	<next:Columns>
	    <next:RowNumberColumn width="30"/>
		<next:CheckBoxColumn></next:CheckBoxColumn>
		<next:Column id="subject" header="标题" field="subject" width="200" >
		</next:Column>
		<next:Column id="procDefName" header="流程名称" field="procDefName" width="200" >
		</next:Column>
		<next:Column id="reqOrganName" header="创建人" field="reqOrganName"  width="150" >
		</next:Column>
		<next:Column id="procCreateTime" header="创建时间" field="procCreateTime" width="150" >
		</next:Column>
		<next:Column id="toStateName" header="状态" renderer="toStateName" field="currentState" width="80" >
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
<script langugae="javascript" type="text/javascript">
function toProcessDef(){
	var text='管理监控';
		var url = "jsp/workflow/manage/queryprocessdefadmin.jsp?procName="+"<%=procName%>";
		url = encodeURI(encodeURI(url));
		L5.forward(url,text);
	}
</script>