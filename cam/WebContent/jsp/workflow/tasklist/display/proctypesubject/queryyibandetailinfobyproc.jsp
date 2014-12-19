<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="java.util.*"%>
<%@page
	import="org.loushang.workflow.tasklist.taskinfo.util.TaskListJspUtil"%>
<%@page
	import="org.loushang.workflow.processdefinition.tasklist.proctypesubjectdef.data.ProcTypeSubjectDef"%>
<%@page
	import="org.loushang.workflow.processdefinition.tasklist.proctypesubjectdef.data.ProcTypeSubjectQueryDef"%>
<%@page
	import="org.loushang.workflow.processdefinition.tasklist.proctypesubjectdef.data.ProcTypeSubjectQueryCommonHelpDef"%>
<html>
<head>
<style>
a {
	TEXT-DECORATION: none
}
</style>
<title>已办任务详细信息查询</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="../../tasklistcommon.js"></script>
<%
	String path = request.getContextPath();
	String basePath;
	if (80 == request.getServerPort()) {
		basePath = request.getScheme() + "://"
			+ request.getServerName()
			+ path + "/";
	} else {
		basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	}
	//taskListType="0"是直接进入详细界面，界面没有返回按钮；taskListType="1"由概要信息界面进入界面，界面显示返回按钮。
	String taskListType = request.getParameter("taskListType");
	if (taskListType == null || "".equals(taskListType)) {
		taskListType = "1";
	}
%>
<%
	String procTypeId = request.getParameter("procTypeId");
	//任务标题
	List procTypeSubjectDefList = TaskListJspUtil
			.getProcTypeYiBanSubjectDefListByProcTypeId(procTypeId);
	//查询条件
	List procTypeSubjectQueryDefList = TaskListJspUtil
			.getProcTypeYiBanSubjectQueryDefListByProcTypeId(procTypeId);
	//该类型下的所有通用帮助定义信息
	List procTypeSubjectQueryCommonHelpDefList = TaskListJspUtil
			.getProcTypeSubjectQueryCommonHelpDefListByProcDefUniqueId(procTypeId);
	String procTypeSubjectKeyHidden, procTypeSubjectKeyDataBegin, procTypeSubjectKeyDataEnd, procTypeSubjectKeyDataTimeBegin, procTypeSubjectKeyDataTimeEnd;
%>
</head>
<body>

<model:datasets>
	<model:dataset pageSize="10" id="yiBanDataset"
		cmd="org.loushang.workflow.tasklist.taskinfo.cmd.YiBanTaskQueryCmd"
		autoLoad="false" method="queryProcTypeYiBanTaskTableDetailInfoByProc"
		global="true">
		<model:record>
			<model:field name="assignmentId" type="string" />
			<model:field name="procDefName" type="string" />
			<model:field name="actDefName" type="string" />
			<model:field name="activeActDefNames" type="string" />
			<model:field name="activeOrganNames" type="string" />
			<model:field name="endTime" type="string" />
			<model:field name="procCreateTime" type="string" />
			<model:field name="primaryKey" type="string" />
			<%
				for (int i = 0; i < procTypeSubjectDefList.size(); i++) {
								ProcTypeSubjectDef procTypeSubjectDef = (ProcTypeSubjectDef) procTypeSubjectDefList
										.get(i);
			%>
			<model:field name="<%=procTypeSubjectDef.getSubjectKey()%>"
				type="string" />
			<%
				}
			%>
		</model:record>
	</model:dataset>
</model:datasets>

<next:ViewPort>
	<next:BorderLayout>
		<next:Defaults>{collapsible:true,split:true,animFloat:true,autoHide:true,useSplitTips:true,bodyStyle:'padding:6px;'}</next:Defaults>
		<next:Center floatable="true" cmargins="0 0 0 0" margins="0 0 0 0">
			<next:Panel>
				<next:AnchorLayout>
					<next:Panel width="100%" border="0"
						bodyStyle="padding-bottom:10px;padding-top:0px;">
						<next:Html>
							<fieldset style="overflow: visible;" class="GroupBox">
							<legend class="GroupBoxTitle">查询条件 <img
								class="GroupBoxExpandButton"
								src="<%=SkinUtils.getImage(request,
												"groupbox_collapse.gif")%>"
								onclick="collapse(this);" /> </legend>
							<div class="GroupBoxDiv" style="width: 100%; height: 100%;">
							<form onsubmit="return false;" class="L5form">
							<table border="1" width="100%">
								<tr>
									<%
										for (int i = 0; i < procTypeSubjectQueryDefList
																			.size(); i++) {
																		ProcTypeSubjectQueryDef procTypeSubjectQueryDef = (ProcTypeSubjectQueryDef) procTypeSubjectQueryDefList
																				.get(i);
																		//查询字段内码值
																		String subjectQueryDefUniqueId = procTypeSubjectQueryDef
																				.getId();
																		String procTypeSubjectKey = procTypeSubjectQueryDef
																				.getSubjectKey();
																		String procTypeSubjectAlias = procTypeSubjectQueryDef
																				.getSubjectAlias();
																		String t = procTypeSubjectQueryDef
																				.getSubjectFieldType();
																		if (t == null) {
									%>
									<td class="FieldLabel" width="15%"><%=procTypeSubjectAlias%>：</td>
									<td class="FieldInput"><input type="text"
										id="<%=procTypeSubjectKey%>" class="TextEditor"
										title="<%=procTypeSubjectAlias%>" size="40" /></td>
									<%
										} else {
																			int type = Integer.parseInt(t);
																			switch (type) {
																				case 2 : {
																					procTypeSubjectKeyHidden = procTypeSubjectKey
																							+ "hidden";
																					for (int j = 0; j < procTypeSubjectQueryCommonHelpDefList
																							.size(); j++) {
																						ProcTypeSubjectQueryCommonHelpDef procTypeSubjectQueryCommonHelpDef = (ProcTypeSubjectQueryCommonHelpDef) procTypeSubjectQueryCommonHelpDefList
																								.get(j);
																						String procTypeSubjectQueryCommonHelpDefId = procTypeSubjectQueryCommonHelpDef
																								.getSubjectQueryDefUniqueId();
																						if (procTypeSubjectQueryCommonHelpDefId
																								.equals(subjectQueryDefUniqueId)) {
																							String dialogUrl = procTypeSubjectQueryCommonHelpDef
																									.getDialogUrl();
																							String dialogHeight = procTypeSubjectQueryCommonHelpDef
																									.getDialogHeight();
																							String dialogWidth = procTypeSubjectQueryCommonHelpDef
																									.getDialogWidth();
																							String conditionUseWay = procTypeSubjectQueryCommonHelpDef
																									.getSubjectQueryDefUniqueId();
									%>
									<td class="FieldLabel" width="15%"><%=procTypeSubjectAlias%>：</td>
									<td class="FieldInput"><input type="text"
										id="<%=procTypeSubjectKey%>" title="<%=procTypeSubjectAlias%>"
										size="40"> <input id="<%=procTypeSubjectKeyHidden%>"
										type="hidden" name="principalId" /> <img
										src="<%=SkinUtils
																		.getImage(
																				request,
																				"l5/liulan.gif")%>"
										style="cursor: hand"
										onclick="show('<%=procTypeSubjectKey%>','<%=procTypeSubjectKeyHidden%>','<%=dialogUrl%>','<%=dialogHeight%>','<%=dialogWidth%>')" /></td>
									<%
										}
																					}
																				}
																					break;
																				case 3 : {
																					procTypeSubjectKeyDataBegin = procTypeSubjectKey
																							+ "dataBegin";
																					procTypeSubjectKeyDataEnd = procTypeSubjectKey
																							+ "dataEnd";
									%>
									<td class="FieldLabel" width="10%"><%=procTypeSubjectAlias%>：</td>
									<td class="FieldInput" width="30%"><input type="text"
										id="<%=procTypeSubjectKeyDataBegin%>" class="TextEditor"
										title="开始日期" format="Y-m-d" name="createTime" field="createTime"
										onclick="LoushangDate(this)" /> 至 <input type="text"
										id="<%=procTypeSubjectKeyDataEnd%>" class="TextEditor"
										title="结束日期" format="Y-m-d" name="createTime" field="createTime"
										onclick="LoushangDate(this)" /></td>
									<%
										}
																					break;
																				case 4 : {
																					procTypeSubjectKeyDataTimeBegin = procTypeSubjectKey
																							+ "dataTimeBegin";
																					procTypeSubjectKeyDataTimeEnd = procTypeSubjectKey
																							+ "dataTimeEnd";
									%>
									<td class="FieldLabel" width="10%"><%=procTypeSubjectAlias%>：</td>
									<td class="FieldInput" width="30%"><input type="text"
										id="<%=procTypeSubjectKeyDataTimeBegin%>" class="TextEditor"
										title="开始时间" size="40" format="Y-m-d H:i:s" name="createTime"
										field="createTime" onclick="LoushangDatetime(this)" /> 至 <input
										type="text" id="<%=procTypeSubjectKeyDataTimeEnd%>"
										class="TextEditor" title="结束时间" size="40" format="Y-m-d H:i:s"
										name="createTime" field="createTime"
										onclick="LoushangDatetime(this)" /></td>
									<%
										}
																					break;
																				default : {
									%>
									<td class="FieldLabel" width="15%"><%=procTypeSubjectAlias%>：</td>
									<td class="FieldInput" width="30%"><input type="text"
										id="<%=procTypeSubjectKey%>" class="TextEditor"
										title="<%=procTypeSubjectAlias%>" size="40" /></td>
									<%
										}
																					break;
																			}
																		}
																		if (i % 2 == 1) {
																			if (i != procTypeSubjectQueryDefList
																					.size() - 1) {
									%>
								</tr>
								<tr>
									<%
										}
																		}
																	}
									%>
									 <% if( procTypeSubjectQueryDefList
											.size()%2==1){%>
											<td colspan="2"></td>
									<td class="FieldButton" width="15%">
									<button onclick="query()">查询</button>
									</td>
								    	
								    <%}else{%>
								    	<td class="FieldButton" width="15%">
									<button onclick="query()">查询</button>
									</td>
								    <%}
								    %>
								</tr>
							</table>
							</form>
							</div>
							</fieldset>
						</next:Html>
					</next:Panel>
					<next:GridPanel id="yiBanTaskGridPanel" name="yiBanTaskGridPanel"
						anchor="100%" height="100%" dataset="yiBanDataset"    
						title="已办任务详细信息列表" notSelectFirstRow="true">
						<next:Columns>
							<next:RowNumberColumn width="30" />
							<next:RadioBoxColumn></next:RadioBoxColumn>
							<next:Column id="assignmentId" header="内码" field="assignmentId"
								width="50" hidden="true">
								<next:TextField allowBlank="false" />
							</next:Column>
							<%
								boolean flag = false;
															for (int j = 0; j < procTypeSubjectDefList
																	.size(); j++) {
																ProcTypeSubjectDef procTypeSubjectDef = (ProcTypeSubjectDef) procTypeSubjectDefList
																		.get(j);
																if ("procDefName"
																		.equals(procTypeSubjectDef
																				.getSubjectKey())
																		|| "actDefName"
																				.equals(procTypeSubjectDef
																						.getSubjectKey())
																		|| "activeActDefNames"
																				.equals(procTypeSubjectDef
																						.getSubjectKey())
																		|| "activeOrganNames"
																				.equals(procTypeSubjectDef
																						.getSubjectKey())
																		|| "endTime"
																				.equals(procTypeSubjectDef
																						.getSubjectKey())
																		|| "procCreateTime"
																				.equals(procTypeSubjectDef
																						.getSubjectKey())) {
																	flag = true;
																}
															}
															if (flag == true) {
																boolean sortAble = false;
																for (int i = 0; i < procTypeSubjectDefList
																		.size(); i++) {
																	ProcTypeSubjectDef procTypeSubjectDef = (ProcTypeSubjectDef) procTypeSubjectDefList
																			.get(i);																	
							%>
							<next:Column header="<%=procTypeSubjectDef.getSubjectAlias()%>"
								field="<%=procTypeSubjectDef.getSubjectKey()%>"
								width="<%=procTypeSubjectDef.getSubjectWidth()%>"
								renderer="addLink" sortable="true">
								<next:TextField allowBlank="false" />
							</next:Column>
							<%
								}
															} else {
																for (int i = 0; i < procTypeSubjectDefList
																.size(); i++) {
															ProcTypeSubjectDef procTypeSubjectDef = (ProcTypeSubjectDef) procTypeSubjectDefList
																	.get(i);
							%>
							<next:Column header="<%=procTypeSubjectDef.getSubjectAlias()%>"
								field="<%=procTypeSubjectDef.getSubjectKey()%>"
								width="<%=procTypeSubjectDef.getSubjectWidth()%>"
								renderer="addLink" sortable="true">
								<next:TextField allowBlank="false" />
							</next:Column>
							<%
								}
							%>
							<next:Column header="流程名称" field="procDefName" width="150"
								renderer="addLink" sortable="true">
								<next:TextField allowBlank="false" />
							</next:Column>
							<next:Column header="流程发起时间" field="procCreateTime" width="150" sortable="true">
								<next:TextField allowBlank="false" />
							</next:Column>
							<next:Column header="已办环节" field="actDefName" width="150" sortable="true">
								<next:TextField allowBlank="false" />
							</next:Column>
							<next:Column header="任务完成时间" field="endTime" width="150" sortable="true">
								<next:TextField allowBlank="false" />
							</next:Column>
							<next:Column id="id" header="当前活动环节" field="activeActDefNames" width="100" sortable="true">
								<next:TextField allowBlank="false" />
							</next:Column>
							<next:Column header="当前活动环节处理人" field="activeOrganNames"
								width="150" sortable="true">
								<next:TextField allowBlank="false" />
							</next:Column>
							<%
								}
							%>
							<next:Column header="业务主键" field="primaryKey" width="150"
								hidden="true">
								<next:TextField allowBlank="false" />
							</next:Column>
						</next:Columns>
						<next:TopBar>
							<next:ToolBarItem symbol="->"></next:ToolBarItem>
							<next:ToolBarItem iconCls="select" text="查看" handler="handle" />
							<next:ToolBarItem iconCls="detail" text="查看流转状态" handler="showState" />
							<%if("1".equals(taskListType)){%>
							<next:ToolBarItem iconCls="undo" text="返回" handler="backToProfileInfo" />
							<%} %>
						</next:TopBar>
						<next:BottomBar>
							<next:PagingToolBar displayMsg="从第{0}条到{1}条，一共{2}条"
								displayInfo="true" dataset="yiBanDataset" />
						</next:BottomBar>
					</next:GridPanel>
				</next:AnchorLayout>
			</next:Panel>
		</next:Center>
	</next:BorderLayout>
</next:ViewPort>
</body>
<script language="javascript" type="text/javascript">
function init()
{
	yiBanDataset.setParameter("procTypeId","<%=procTypeId%>");
	yiBanDataset.load();
}

//显示通用帮助框
function show(procTypeSubjectKey,procTypeSubjectKeyHidden,dialogUrl,dialogHeight,dialogWidth){
	var scheme=dialogUrl.substring(0,7);
    if(scheme.toLowerCase()!="http://"){
        var allUrl= '<%=path%>' + "/" + dialogUrl;
    }
	var win = showModalDialog(allUrl,window,"dialogWidth:"+dialogWidth+"px;"+"dialogHeight:"+dialogHeight+"px");
	if(win==null){
		return ;
	}
	document.getElementById(procTypeSubjectKey).value=win[0];
	document.getElementById(procTypeSubjectKeyHidden).value=win[1];
}
//已办任务详细查询
function query()
{
	<%for (int i = 0; i < procTypeSubjectQueryDefList.size(); i++) {%>
		var queryCondition="";
		<%ProcTypeSubjectQueryDef procTypeSubjectQueryDef = (ProcTypeSubjectQueryDef) procTypeSubjectQueryDefList
				.get(i);
		String subjectQueryDefUniqueId = procTypeSubjectQueryDef
				.getId();
		String subjectCatgory = procTypeSubjectQueryDef
		.getSubjectCategory();
		String subjectKey = procTypeSubjectQueryDef.getSubjectKey();
		String type = procTypeSubjectQueryDef.getSubjectFieldType();
		procTypeSubjectKeyDataBegin = subjectKey + "dataBegin";
		procTypeSubjectKeyDataEnd = subjectKey + "dataEnd";
		procTypeSubjectKeyDataTimeBegin = subjectKey + "dataTimeBegin";
		procTypeSubjectKeyDataTimeEnd = subjectKey + "dataTimeEnd";
		procTypeSubjectKeyHidden = subjectKey + "hidden";%>
		//帮助框
		if(<%=type%>=="2"){
			queryCondition = document.getElementById("<%=subjectKey%>").value;
			if(queryCondition != null && queryCondition != ""){
				<%for (int j = 0; j < procTypeSubjectQueryCommonHelpDefList.size(); j++) {
					ProcTypeSubjectQueryCommonHelpDef procTypeSubjectQueryCommonHelpDef = (ProcTypeSubjectQueryCommonHelpDef) procTypeSubjectQueryCommonHelpDefList
							.get(j);
					String procTypeSubjectQueryCommonHelpDefId = procTypeSubjectQueryCommonHelpDef
							.getSubjectQueryDefUniqueId();
					if (procTypeSubjectQueryCommonHelpDefId.equals(subjectQueryDefUniqueId)) {
						String condition = procTypeSubjectQueryCommonHelpDef.getConditionUseWay();
						if (!condition.equals("1")) {%>
							queryCondition=document.getElementById("<%=procTypeSubjectKeyHidden%>").value;
						<%}
					}
					break;
				}%>
			}
		}
		//日期
		else if(<%=type%>=="3"){
			var procTypeSubjectKeyDataBegin=document.getElementById("<%=procTypeSubjectKeyDataBegin%>").value;
			var procTypeSubjectKeyDataEnd=document.getElementById("<%=procTypeSubjectKeyDataEnd%>").value;
			if(procTypeSubjectKeyDataBegin !="" || procTypeSubjectKeyDataEnd !=""){
				var dataBegin = procTypeSubjectKeyDataBegin.replace("-","").replace("-","");
				var dataEnd  = procTypeSubjectKeyDataEnd.replace("-","").replace("-","");
			    queryCondition=dataBegin+"#"+dataEnd;
			}
		}
		//日期时间
		else if(<%=type%>=="4"){
			var procTypeSubjectKeyDataTimeBegin=document.getElementById("<%=procTypeSubjectKeyDataTimeBegin%>").value;
			var procTypeSubjectKeyDataTimeEnd=document.getElementById("<%=procTypeSubjectKeyDataTimeEnd%>").value;
			if(procTypeSubjectKeyDataTimeBegin !="" || procTypeSubjectKeyDataTimeEnd !=""){
				var dataTimeBegin = procTypeSubjectKeyDataTimeBegin.replace("-","").replace("-","");
				var dataTimeEnd = procTypeSubjectKeyDataTimeEnd.replace("-","").replace("-","");
			    queryCondition=dataTimeBegin+"#"+dataTimeEnd;
			}
		}
		//文本框||下拉框
		else{
			queryCondition=document.getElementById("<%=subjectKey%>").value;
			if(queryCondition.indexOf("'")!=-1){
		 		  L5.Msg.alert("提示", "不接受单引号输入!");
		 		  return;
		 	}
		}
	    if(queryCondition!=null && queryCondition!=""){
	    	if(<%=subjectCatgory%>=="0"){
		    	queryCondition = "bizTable"+queryCondition
		    }else if(<%=subjectCatgory%>=="1"){
		    	queryCondition = "procTable"+queryCondition
		    }
	    	yiBanDataset.setParameter("<%=subjectKey%>",queryCondition);
	 	}
	<%}%>
	
	yiBanDataset.setParameter("procTypeId","<%=procTypeId%>");
	yiBanDataset.load();
}

//通过链接处理已办任务
function addLink(value,second,record)
{
	var assignmentId=record.get("assignmentId");
	return "<a href=\"javascript:dealYiBanTask('"+assignmentId+"')\">"+value+"</a>";
}

//通过按钮处理已办任务
function handle()
{
	var userGrid=L5.getCmp('yiBanTaskGridPanel');
	var selected = userGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		alert("请选择一条记录进行处理!");
		return false;
	}
	var rec=selected[0];
	dealYiBanTask(rec.get("assignmentId"));
}

//处理已办任务
function dealYiBanTask(assignmentId)
{
	var urls=document.URL;
	var basePath='<%=basePath%>';
	var backUrl=urls.substring(basePath.length);
	backUrl=backUrl.replace("?","[").replace(/&/g,";").replace(/=/g,":");
	backUrl=backUrl+"]";
	var url="command/dispatcher/org.loushang.workflow.tasklist.forward.TaskListDispatcherCmd/yiBanTaskForward";
	var query="?assignmentId="+assignmentId+'&backUrl='+backUrl;
	L5.forward(url+query,"办理");
}

//查看流程状态图
function showState()
{
   var yiBanTaskGridPanel=L5.getCmp("yiBanTaskGridPanel");
   var backUrl="jsp/workflow/tasklist/display/proctypesubject/queryyibandetailinfobyproc.jsp";
   var parms = document.URL.split("?");
   var parm="";
   if (parms!=null && parms!= undefined && parms.length>1) {
	   parm=parms[1];
	   parm = parm.replace("&",";");
	   parm = parm.replace("=",":");
	   parm="["+parm;
	   backUrl+=parm;
   }
   showprocessstate(yiBanTaskGridPanel,"yiban",backUrl);
}
//返回已办任务概要信息查询页面
function backToProfileInfo()
{
	var url="jsp/workflow/tasklist/display/proctypesubject/queryyibanprofileinfo.jsp";
	L5.forward(url,"已办任务概要信息查询");
}
//查询条件面板打开合并函数
function collapse(element)
{
	var fieldsetParent=L5.get(element).findParent("fieldset");
	if(element.expand==null||element.expand==true){	
	fieldsetParent.getElementsByTagName("div")[0].style.display="none";
	element.src = '<%=SkinUtils.getImage(request, "groupbox_expand.gif")%>';
	element.expand=false;
	}else{
		fieldsetParent.getElementsByTagName("div")[0].style.display="";
		element.src = "<%=SkinUtils.getImage(request, "groupbox_collapse.gif")%>";
		element.expand =true;
	}
}
</script>
</html>