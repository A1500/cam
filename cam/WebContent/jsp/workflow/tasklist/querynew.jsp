<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="org.loushang.workflow.api.WfQuery"%>
<html>
	<head><style>a{TEXT-DECORATION:none}</style>
		<title>新建任务查询</title>
		<next:ScriptManager></next:ScriptManager>
		<script type="text/javascript" src="tasklistcommon.js"></script>
		<% 
		  String procTypeId=request.getParameter("procTypeId");
		  if(procTypeId==null)
			  procTypeId="";
		  //增加过滤流程类型Id
		  String exceptProcTypeIds=request.getParameter("exceptProcTypeIds");
		  if(exceptProcTypeIds==null)
			  exceptProcTypeIds="";
		%>
	</head>
<body>

<model:datasets>
	<model:dataset pageSize="10" id="newTaskDataset" cmd="org.loushang.workflow.tasklist.taskinfo.cmd.NewTaskQueryCmd"  autoLoad="false" global="true">
			<model:record>
				<model:field name="procDefUniqueId" type="string" />
				<model:field name="procDefName" type="string" />
				<model:field name="procCreateTime" type="string" />
			</model:record>
	</model:dataset>
</model:datasets>

<next:ViewPort>
	<next:BorderLayout>
		<next:Defaults>{collapsible:true,split:true,animFloat:true,autoHide:true,useSplitTips:true,bodyStyle:'padding:6px;'}</next:Defaults>
		<next:Center floatable="true" cmargins="0 0 0 0" margins="0 0 0 0" >
			<next:Panel>
			<next:Panel width="100%" border="0" bodyStyle="padding-bottom:10px;padding-top:0px;">
				<next:Html>			
				<fieldset style="overflow: visible;" class="GroupBox">
					<legend class="GroupBoxTitle">查询条件
						<img class="GroupBoxExpandButton" src="<%=SkinUtils.getImage(request,"groupbox_collapse.gif")%>" onclick="collapse(this);"/>									
					</legend>
					<div class="GroupBoxDiv" style="width: 100%;height: 100%;">	
						<form onsubmit="return false;" class="L5form">				
							<table  border="1" width="100%">
								<tr>
									<td class="FieldLabel"  width="15%">流程名称：</td>
									<td class="FieldInput"><input type="text"  id="processName" class="TextEditor" title="流程名称"  size="40"/></td>
									<td class="FieldButton"  width="15%"><button onclick="query()">查询</button> </td>
								</tr>
							</table>
						</form>		
					</div>
				</fieldset>
				</next:Html>
			</next:Panel>			
			<next:GridPanel id="newTaskGridPanel" name="newTaskGridPanel" width="100%" height="100%" dataset="newTaskDataset"     title="发起流程列表" notSelectFirstRow="true">
				<next:Columns>
	   				<next:RowNumberColumn width="30"/>
	    			<next:RadioBoxColumn></next:RadioBoxColumn>
					<next:Column id="procDefUniqueId" header="内码" field="procDefUniqueId" width="50" hidden="true" >
					<next:TextField allowBlank="false"/>
					</next:Column>
					<next:Column id="procDefName"  header="流程名称" field="procDefName" width="150" renderer="addLink">
						<next:TextField allowBlank="false"/>
					</next:Column>
					<next:Column id="procCreateTime" header="创建时间" field="procCreateTime"  width="200" >
						<next:TextField allowBlank="false"/>
					</next:Column>				
				</next:Columns>
				<next:TopBar>
					<next:ToolBarItem symbol="->"></next:ToolBarItem>			
					<next:ToolBarItem iconCls="select"  text="发起" handler="handle"/>
					<next:ToolBarItem iconCls="detail"  text="查看流转状态" handler="showState"/>
				</next:TopBar>
				<next:BottomBar>
					<next:PagingToolBar displayMsg="从第{0}条到{1}条，一共{2}条" displayInfo="true" dataset="newTaskDataset"/>
				</next:BottomBar>
			</next:GridPanel>
			</next:Panel>
		</next:Center>
	</next:BorderLayout>
</next:ViewPort>
</body>
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
function init()
{
  //要查询的流程类型或要过滤掉的流程类型
  var procTypeId="<%=procTypeId%>";
  var exceptProcTypeIds="<%=exceptProcTypeIds%>";
  if(procTypeId!="")
  {
	newTaskDataset.setParameter("procTypeId",procTypeId);
  }
  if(exceptProcTypeIds!=""){
	  newTaskDataset.setParameter("exceptProcTypeIds",exceptProcTypeIds);
  }
  newTaskDataset.load();
}
//新建任务查询
function query(){
  //流程类型
  var procTypeId="<%=procTypeId%>";
  var exceptProcTypeIds="<%=exceptProcTypeIds%>";
  if(procTypeId!="")
  {
	  newTaskDataset.setParameter("procTypeId",procTypeId);
  }
  if(exceptProcTypeIds!=""){
	  newTaskDataset.setParameter("exceptProcTypeIds",exceptProcTypeIds);
  }
  var processName=document.getElementById("processName").value;	
  if(processName.indexOf("'")!=-1){
	  L5.Msg.alert("提示", "不接受单引号输入!");
	  return;
}		 	
  if(processName!="") {
  newTaskDataset.setParameter("procDefName",processName);
  }

  newTaskDataset.load();
}

//通过链接处理新建任务
function addLink(value,second,record)
{
  var procDefUniqueId=record.get("procDefUniqueId");
  return "<a href=\"javascript:dealNewTask('"+procDefUniqueId+"')\">"+value+"</a>";
}

//通过按钮处理新建任务
function handle()
{
  var userGrid=L5.getCmp('newTaskGridPanel');
  var selected = userGrid.getSelectionModel().getSelections();
  if(selected.length!=1){
    L5.Msg.alert("提示","请选择一条记录进行处理!");
	return false;
  }
  var rec=selected[0];
  dealNewTask(rec.get("procDefUniqueId"));
}
//处理新建任务
function dealNewTask(procDefUniqueId)
{			
	var url="command/dispatcher/org.loushang.workflow.tasklist.forward.TaskListDispatcherCmd/newTaskForward";
	var query="?procDefUniqueId="+procDefUniqueId;
	L5.forward(url+query,"办理");
}
//查看流程状态图
function showState(){
  var newTaskGridPanel=L5.getCmp("newTaskGridPanel");
  showprocessstate(newTaskGridPanel,"new","jsp/workflow/tasklist/querynew.jsp");
}
</script>
</html>