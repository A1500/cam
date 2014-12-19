<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="java.net.URLDecoder" %>
<html>
	<head>
		<title>流程版本管理</title>
		<style>a{TEXT-DECORATION:none}</style>
		<next:ScriptManager/>
		<script type="text/javascript" src="queryprocessdefadmin.js"></script>
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
	<model:dataset id="ds" pageSize="10" cmd="org.loushang.workflow.manage.processdef.cmd.ProcessDefManageQueryCmd" global="true">
		<model:record fromBean="org.loushang.workflow.manage.processdef.data.ProcessDefManage"></model:record>
	</model:dataset>
</model:datasets>
<next:ViewPort>
<next:Panel  name="form" width="100%" border="0" bodyStyle="padding-bottom:10px;padding-top:12px;" autoHeight="true" >
	<next:Html>
	<fieldset style="overflow: visible;" class="GroupBox">
		<legend class="GroupBoxTitle">查询条件<img class="GroupBoxExpandButton" src="<%=SkinUtils.getImage(request,"groupbox_collapse.gif")%>" onclick="collapse(this);"/></legend>
			<div class="GroupBoxDiv" style="width: 100%;height: 100%;">
			<form  class="L5form"  onsubmit="return false;" >
				<table  border="1" width="100%" >
					<tr >
						<td class="FieldLabel">流程名称:</td>
						<td class="FieldInput"><input type="text"  id="name" class="TextEditor" title="流程名称" /></td>
						<td class="FieldButton"><button type="button" onclick="query()">查 询</button> </td>
					</tr>
				</table></form></div>
	</fieldset>
	</next:Html>
</next:Panel>

<next:GridPanel id="GridPanel" name="processdefGrid"  autoWidth="true" width="100%" stripeRows="true" height="100%" dataset="ds" title="流程版本管理" notSelectFirstRow="true">
<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="查看活动流程实例" iconCls="detail" handler="queryAct"/>
		<next:ToolBarItem text="查看办结流程实例" iconCls="detail" handler="queryEnd"/>
		<next:ToolBarItem text="删除" iconCls="delete" handler="dele"/>

	</next:TopBar>
	<next:Columns>
	    <next:RowNumberColumn width="30"/>
		<next:RadioBoxColumn></next:RadioBoxColumn>
		<next:Column id="procDefName" header="流程定义名称" field="procDefName" width="260" >
		</next:Column>
		<next:Column id="procCreateTime" header="创建时间" field="procCreateTime" width="200" >
		</next:Column>
		<next:Column id="proCount" header="活动流程个数" field="processCount"  renderer="addLink" width="150" >
		</next:Column>
		<next:Column id="endProCount" header="办结流程个数" field="processEndCount" renderer="addLink2" width="100" >
		</next:Column>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="ds"/>
	</next:BottomBar>
</next:GridPanel>
</next:ViewPort>
</body>
</html>
<script type="text/javascript">
function init() {
	<%
    String procName=request.getParameter("procName");
	if(procName!=null && procName !="null" && procName != "undefined")
		procName = URLDecoder.decode(procName,"UTF-8");
	%>
	var name ="<%=procName%>";
	if(name != null && name != "undefined" && name !="null")
		document.getElementById("name").value="<%=procName%>";
	
	ds.setParameter("name@like", getParam("name"));
	ds.load();
}
</script>
