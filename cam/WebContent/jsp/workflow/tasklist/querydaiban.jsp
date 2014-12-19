<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="java.util.*"%>
<%@page import="org.loushang.workflow.tasklist.taskinfo.util.TaskListJspUtil"%>
<%@page import="org.loushang.workflow.processdefinition.tasklist.defaultsubjectdef.data.DefaultSubjectDef" %>
<%@page import="org.loushang.workflow.processdefinition.tasklist.defaultsubjectdef.data.DefaultSubjectQueryDef" %>
<html>
	<head><style>a{TEXT-DECORATION:none}</style>
		<title>待办任务查询</title>
		<next:ScriptManager></next:ScriptManager>
		<script type="text/javascript" src="tasklistcommon.js"></script>
		<%
			//指定流程类型查询
			String procTypeId = request.getParameter("procTypeId");
			if(procTypeId==null){
				procTypeId ="";
			}
			//指定过滤流程类型查询	
			String exceptProcTypeIds = request.getParameter("exceptProcTypeIds");
			if(exceptProcTypeIds==null){
				exceptProcTypeIds="";
			}
			//任务标题
			List defaultDaiBanSubjectDefList = TaskListJspUtil.getDefaultDaiBanSubjectDefList();
			//查询条件
			List defaultDaiBanSubjectQueryDefList = TaskListJspUtil.getDefaultDaiBanSubjectQueryDefList();
		%>
	</head>
<body>

<model:datasets>
	<model:dataset pageSize="10" id="daiBanDataset" cmd="org.loushang.workflow.tasklist.taskinfo.cmd.DaiBanTaskQueryCmd" autoLoad="false" global="true">
		<model:record>
	    	<model:field name="taskState" type="string" />
			<model:field name="assignmentId" type="string" />
			<%
		if(null != defaultDaiBanSubjectDefList && !defaultDaiBanSubjectDefList.isEmpty() && defaultDaiBanSubjectDefList.size() > 0){
			for(int i = 0; i<defaultDaiBanSubjectDefList.size(); i++){
				DefaultSubjectDef defaultSubjectDef = (DefaultSubjectDef)defaultDaiBanSubjectDefList.get(i);
			%>
			<model:field name="<%=defaultSubjectDef.getSubjectKey() %>" type="string"/>
			<%
			}
			 }else{
			%>
				<model:field name="subject" type="string" />
				<model:field name="activityId" type="string" />
				<model:field name="actDefUniqueId" type="string" />
				<model:field name="actDefName" type="string" />
				<model:field name="actLimitTime" type="string" />
				<model:field name="actWarnTime" type="string" />
				<model:field name="procDefName" type="string" />
				<model:field name="procCreateTime" type="string" />
				<model:field name="preActDefNames" type="string" />
				<model:field name="preOrganNames" type="string" />
			<% 
			}%>
		</model:record>
	</model:dataset>
</model:datasets>

<next:ViewPort>
	<next:BorderLayout>
		<next:Defaults>{collapsible:true,split:true,animFloat:true,autoHide:true,useSplitTips:true,bodyStyle:'padding:6px;'}</next:Defaults>
		<next:Center floatable="true" cmargins="0 0 0 0" margins="0 0 0 0" >
			<next:Panel id="daibanpanel">
			<next:AnchorLayout>
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
									<%
									if(null != defaultDaiBanSubjectDefList && !defaultDaiBanSubjectDefList.isEmpty() && defaultDaiBanSubjectDefList.size() > 0){
										if(null != defaultDaiBanSubjectQueryDefList && !defaultDaiBanSubjectQueryDefList.isEmpty() && defaultDaiBanSubjectQueryDefList.size() > 0){
										for (int i = 0; i < defaultDaiBanSubjectQueryDefList.size(); i++) {
											
													DefaultSubjectQueryDef defaultSubjectQueryDef = (DefaultSubjectQueryDef) defaultDaiBanSubjectQueryDefList
																							.get(i);
													String defaultSubjectKey = defaultSubjectQueryDef
																							.getSubjectKey();
													String defaultSubjectAlias = defaultSubjectQueryDef
																							.getSubjectAlias();
													String defaultSubField = defaultSubjectQueryDef
																							.getSubjectFieldType();
													if ("0".equals(defaultSubField)|| defaultSubField == null) {
									%>
									<td class="FieldLabel" width="15%"><%=defaultSubjectAlias%>：</td>
									<td class="FieldInput"><input type="text" id="<%=defaultSubjectKey%>" class="TextEditor" title="<%=defaultSubjectAlias%>" size="40" /></td>
									<%
										} else if ("4".equals(defaultSubField)) {
											String startDate=defaultSubjectKey+"start";
											String endDate=defaultSubjectKey+"end";
									%>
									<td class="FieldLabel" width="15%"><%=defaultSubjectAlias%>：</td>
									<td class="FieldInput"><input type="text"
										id="<%=startDate%>" class="TextEditor"
										title="开始时间" size="40" format="Y-m-d H:i:s"
										onclick="LoushangDatetime(this)" /> 至 <input type="text" id="<%=endDate%>"
										class="TextEditor" title="结束时间" size="40"
										format="Y-m-d H:i:s" 
										onclick="LoushangDatetime(this)" /></td>
									<%
										} if (i % 2 == 1) {
												if (i != defaultDaiBanSubjectQueryDefList.size() - 1) {
									%>
				                     	</tr>
				                     	<tr>
				                    <%
				                    		}
										  }
				                        }										
				                     }else{
				                    		%> 
											 <td class="FieldLabel" width="15%" >标题：</td>
							                 <td class="FieldInput"><input type="text"  id="subject" class="TextEditor" title="标题"  size="40"/></td>
											<%
				                       }
									}else{
			                          	%> 
										 <td class="FieldLabel" width="15%" >标题：</td>
						                 <td class="FieldInput"><input type="text"  id="subject" class="TextEditor" title="标题"  size="40"/></td>
										<%
			                          }									
				                    %>
									<td class="FieldButton" width="15%">
									<button onclick="query()">查询</button>
									</td>
								</tr>
							</table>
						</form>		
					</div>
				</fieldset>
				</next:Html>
			</next:Panel>			
			<next:GridPanel id="daiBanTaskGridPanel" name="daiBanTaskGridPanel" anchor="100%" height="100%" dataset="daiBanDataset"     title="待办流程列表" notSelectFirstRow="true">
				<next:Columns>
	   				<next:RowNumberColumn width="30"/>
	    			<next:RadioBoxColumn></next:RadioBoxColumn>
	    			<next:Column header="状态" field="taskState" width="40" renderer="setTaskState" align="center">
						<next:TextField allowBlank="false"/>
					</next:Column>
					<next:Column id="assignmentId" header="内码" field="assignmentId" width="50" hidden="true" >
					<next:TextField allowBlank="false"/>
					</next:Column>					
							<%
							if(null != defaultDaiBanSubjectDefList && !defaultDaiBanSubjectDefList.isEmpty() && defaultDaiBanSubjectDefList.size() > 0){
								boolean sortAble = false;
								for (int i = 0; i < defaultDaiBanSubjectDefList.size(); i++) {
										DefaultSubjectDef defaultSubjectDef = (DefaultSubjectDef) defaultDaiBanSubjectDefList
																					.get(i);										
							%>
							<next:Column header="<%=defaultSubjectDef.getSubjectAlias()%>"
								field="<%=defaultSubjectDef.getSubjectKey()%>"
								width="<%=defaultSubjectDef.getSubjectWidth()%>"
								sortable="true">
								<next:TextField allowBlank="false" />
							</next:Column>
							<%
								}
							}else{
			        %>
			        	<next:Column id="subject" header="标题" field="subject" width="150" sortable="true">
							<next:TextField allowBlank="false"/>
						</next:Column>
			        	<next:Column id="procDefName" header="流程名称" field="procDefName" width="150" sortable="true">
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="procCreateTime" header="流程发起时间" field="procCreateTime" width="150" sortable="true">
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="actDefName" header="当前环节" field="actDefName" width="150" sortable="true">
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="preActDefNames" header="发送环节" field="preActDefNames" width="150" sortable="true">
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="preOrganNames" header="发送人" field="preOrganNames" width="150" sortable="true">
							<next:TextField allowBlank="false"/>
						</next:Column>					
						<next:Column id="actLimitTime" header="环节限时时间" field="actLimitTime" width="150" sortable="true">
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="actWarnTime" header="环节预警时间" field="actWarnTime" width="150" sortable="true">
							<next:TextField allowBlank="false"/>
						</next:Column>
			        <%
			        } %>
				</next:Columns>
				<next:TopBar>
					<next:ToolBarItem symbol="->"></next:ToolBarItem>			
					<next:ToolBarItem iconCls="select"  text="办理" handler="handle"/>
					<next:ToolBarItem iconCls="detail"  text="查看流转状态" handler="showState"/>
				</next:TopBar>
				<next:BottomBar>
					<next:PagingToolBar displayMsg="从第{0}条到{1}条，一共{2}条" displayInfo="true" dataset="daiBanDataset"/>
				</next:BottomBar>
			</next:GridPanel>
			</next:AnchorLayout>
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

function init(){
	//要查询的流程类型或要过滤掉的流程类型
	var procTypeId ="<%=procTypeId%>";
	var exceptProcTypeIds="<%=exceptProcTypeIds%>";
	if(procTypeId !=""){
		daiBanDataset.setParameter("procTypeId",procTypeId);
	}
	if(exceptProcTypeIds!=""){
		daiBanDataset.setParameter("exceptProcTypeIds",exceptProcTypeIds);
	}
	daiBanDataset.load();	
}

//待办任务查询
function query()
{
	//要查询的流程类型或要过滤掉的流程类型
	var procTypeId ="<%=procTypeId%>";
	var exceptProcTypeIds="<%=exceptProcTypeIds%>";
	if(procTypeId !=""){
		daiBanDataset.setParameter("procTypeId",procTypeId);
	}else{
		daiBanDataset.setParameter("exceptProcTypeIds",exceptProcTypeIds);
		}
	var queryCondition;
	<%
	if(null != defaultDaiBanSubjectQueryDefList && !defaultDaiBanSubjectQueryDefList.isEmpty() && defaultDaiBanSubjectQueryDefList.size() > 0){
		for (int i = 0; i < defaultDaiBanSubjectQueryDefList.size(); i++) {
					DefaultSubjectQueryDef defaultSubjectQueryDef = (DefaultSubjectQueryDef) defaultDaiBanSubjectQueryDefList
							.get(i);
					String subjectCategory = defaultSubjectQueryDef.getSubjectCategory();
					String subjectKey = defaultSubjectQueryDef.getSubjectKey();					
					String sysSubField = defaultSubjectQueryDef.getSubjectFieldType();
					String startDate = subjectKey+"start";
					String endDate = subjectKey+"end";
		 if ("0".equals(sysSubField) || "1".equals(sysSubField)) {
	%>
	 	queryCondition = document.getElementById("<%=subjectKey%>").value;
	 	if(queryCondition.indexOf("'")!=-1){
	 		  L5.Msg.alert("提示", "不接受单引号输入!");
	 		  return;
	 	}
	<%
	 	}
		 else if ("4".equals(sysSubField)) {
	%>
		 var startDate = document.getElementById("<%=startDate%>").value;
		 var endDate = document.getElementById("<%=endDate%>").value;	 
		 var dataTimeBegin = "";
		 var dataTimeEnd = "";
		 if(startDate == null || startDate == "" || startDate == undefined){
			 dataTimeBegin = "";
			 }else{
				 dataTimeBegin = startDate.replace("-","").replace("-","");
				 }
		 if(endDate == null || endDate == "" || endDate == undefined){
			 dataTimeEnd = "";
			 }else{
				 dataTimeEnd = endDate.replace("-","").replace("-","");
				 }
	     queryCondition = dataTimeBegin + "#" + dataTimeEnd;
	<%
	 	}
	%>
	 if(queryCondition != null&&queryCondition != "")
	 {			
		 daiBanDataset.setParameter("<%=subjectKey%>",queryCondition); 		 
	 }
	<%
	}
}else{
	%>	
	var subject = document.getElementById("subject").value;
	if(subject.indexOf("'")!=-1){
		  L5.Msg.alert("提示", "不接受单引号输入!");
		  return;
	}
	daiBanDataset.setParameter("subject",subject); 
	<%	
}
	%>
	daiBanDataset.load();
}

//通过链接处理待办任务
function addLink(value,second,record)
{
	var assignmentId=record.get("assignmentId");
	return "<a href=\"javascript:dealDaiBanTask('"+assignmentId+"')\">"+value+"</a>";
}

//通过按钮处理待办任务
function handle()
{
	var userGrid=L5.getCmp('daiBanTaskGridPanel');
	var selected = userGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		alert("请选择一条记录进行处理!");
		return false;
	}
	var rec=selected[0];
	dealDaiBanTask(rec.get("assignmentId"));
}

//处理待办任务
function dealDaiBanTask(assignmentId)
{			
	var url="command/dispatcher/org.loushang.workflow.tasklist.forward.TaskListDispatcherCmd/daiBanTaskForward";
	var query="?assignmentId="+assignmentId;
	L5.forward(url+query,"办理");
}

//查看流程状态图
function showState()
{
   var daiBanTaskGridPanel=L5.getCmp("daiBanTaskGridPanel");
   showprocessstate(daiBanTaskGridPanel,"daiban","jsp/workflow/tasklist/querydaiban.jsp");
}
//设置任务状态
function setTaskState(value,a,rec)
{
	var imagePath=L5.webPath+"/jsp/workflow/tasklist/images/";
	var image="";
	//正常状态
	if(value=="0")
	{
		image="normal.png";
	}
	//预警状态
	else if(value=="1")
	{
		image="warn.png";
	}
	//超时状态
	else if(value=="2")
	{
		image="limit.png";
	}

	return '<img src="'+imagePath+image+'" />';
}
</script>
</html>