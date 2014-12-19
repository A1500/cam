<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="java.util.*"%>
<%@page import="org.loushang.workflow.tasklist.taskinfo.util.TaskListJspUtil"%>
<%@page import="org.loushang.workflow.processdefinition.tasklist.syssubjectdef.data.SysSubjectDef"%>
<%@page import="org.loushang.workflow.processdefinition.tasklist.syssubjectdef.data.SysSubjectQueryDef"%>
<%@page import="org.loushang.workflow.processdefinition.tasklist.syssubjectdef.data.SysSubjectQueryCommonHelpDef"%>
<%@page import="org.loushang.workflow.processdefinition.tasklist.syssubjectdef.data.SysSubjectQuerySelectDef"%>
<html>
<head>
<style>
a {
	TEXT-DECORATION: none
}
</style>
<title>已办办结合并任务查询</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="tasklistcommon.js"></script>
</head>
<body>
<% 
		  //任务标题
		  List sysYiBanAndEndSubjectDefList = TaskListJspUtil.getSysYiBanAndEndTaskSubjectDefList();
		  //查询条件
		  List sysSubjectQueryDefList = TaskListJspUtil.getSysYiBanAndEndTaskSubjectQueryDefList();
		  //通用帮助
		  List sysSubjectQueryCommonHelpDefList = TaskListJspUtil.getSysSubjectQueryCommonHelpDefList();
		  //下拉框
		  List sysSubjectQuerySelectDefList = TaskListJspUtil.getSysSubjectQuerySelectDefList();
		  String sysSubjectKeyHidden, sysSubjectKeyDataBegin, sysSubjectKeyDataEnd, sysSubjectKeyDataTimeBegin, sysSubjectKeyDataTimeEnd;
%>
<model:datasets>
	<model:dataset pageSize="10" id="yiBanAndEndTaskDataset"
		cmd="org.loushang.workflow.tasklist.taskinfo.cmd.YiBanAndEndTaskQueryCmd"
		autoLoad="false" global="true">
		<model:record>
			<model:field name="assignmentId" type="string" />
			<model:field name="subject" type="string" />
			<model:field name="procEndTime" type="string" />
			<model:field name="activeActDefNames" type="string" />
			<model:field name="activeOrganNames" type="string" />
			<model:field name="actDefName" type="string" />
			<model:field name="endTime" type="string" />
			<model:field name="procCreateTime" type="string" />
			<model:field name="procDefName" type="string" />
			<model:field name="createTime" type="string" />
			<model:field name="processId" type="string" />
			<model:field name="taskState" type="string" />
			<%
			for(int i=0;i<sysYiBanAndEndSubjectDefList.size();i++){
				SysSubjectDef sysSubjectDef = (SysSubjectDef)sysYiBanAndEndSubjectDefList.get(i);
			%>
				<model:field name="<%=sysSubjectDef.getSubjectKey()%>" type="string" />
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
				<next:Panel width="100%" border="0" bodyStyle="padding-bottom:10px;padding-top:0px;">
					<next:Html>
						<fieldset style="overflow: visible;" class="GroupBox">
						<legend class="GroupBoxTitle">查询条件 <img class="GroupBoxExpandButton"
							src="<%=SkinUtils.getImage(request, "groupbox_collapse.gif")%>"
							onclick="collapse(this);" />
						</legend>
						<div class="GroupBoxDiv" style="width: 100%; height: 100%;">
						<form onsubmit="return false;" class="L5form">
						<table border="1" width="100%">
							<tr>
								<%
									for (int i = 0; i < sysSubjectQueryDefList.size(); i++) {
										SysSubjectQueryDef sysSubjectQueryDef = (SysSubjectQueryDef)sysSubjectQueryDefList.get(i);
										//查询字段内码值
										String subjectQueryDefUniqueId = sysSubjectQueryDef.getId();
										String sysSubjectKey = sysSubjectQueryDef.getSubjectKey();
										String sysSubjectAlias = sysSubjectQueryDef.getSubjectAlias();
										String queryType = sysSubjectQueryDef.getSubjectFieldType();
										if (queryType == null) {
								%>
									<td class="FieldLabel" width="15%"><%=sysSubjectAlias%>：</td>
									<td class="FieldInput"><input type="text" id="<%=sysSubjectKey%>" class="TextEditor"
										title="<%=sysSubjectAlias%>" size="40" /></td>
									<%
										}
										else{
											int type = Integer.parseInt(queryType);
											switch(type){
												//下拉框
												case 1 :{
									%>
									<td class="FieldLabel" width="15%"><%=sysSubjectAlias%>：</td>
									<td class="FieldInput">
										<select type="text" name="<%=sysSubjectKey%>" field="subjectQueryDefUniqueId" title="查询条件">
										<option value="">请选择...</option>
										<%
											for (int p=0; p<sysSubjectQuerySelectDefList.size(); p++) {
												SysSubjectQuerySelectDef sysSubjectQuerySelectDef = 
														(SysSubjectQuerySelectDef)sysSubjectQuerySelectDefList.get(p);
												String subjectQueryDefUnique = sysSubjectQuerySelectDef.getSubjectQueryDefUniqueId();
												if (subjectQueryDefUnique.equals(subjectQueryDefUniqueId)){
													String optionValue = sysSubjectQuerySelectDef.getOptionValue();
													String optionText = sysSubjectQuerySelectDef.getOptionText();
										%>
										<option value="<%=optionValue%>"><%=optionText%></option>

										<%
												}
											}
										%>
										</select>
									</td>
										<%
											   }
												break;
												//通用帮助
												case 2 :{
													sysSubjectKeyHidden = sysSubjectKey + "hidden";
													for (int j=0; j < sysSubjectQueryCommonHelpDefList.size(); j++){
														SysSubjectQueryCommonHelpDef sysSubjectQueryCommonHelpDef = 
																(SysSubjectQueryCommonHelpDef)sysSubjectQueryCommonHelpDefList.get(j);
														String sysSubjectQueryCommonHelpDefId = sysSubjectQueryCommonHelpDef
																.getSubjectQueryDefUniqueId();
														if (sysSubjectQueryCommonHelpDefId.equals(subjectQueryDefUniqueId)) {
															String dialogUrl = sysSubjectQueryCommonHelpDef.getDialogUrl();
															String dialogHeight = sysSubjectQueryCommonHelpDef.getDialogHeight();
															String dialogWidth = sysSubjectQueryCommonHelpDef
																	.getDialogWidth();
															String conditionUseWay = sysSubjectQueryCommonHelpDef.getConditionUseWay();

															int keyReturnIndex = sysSubjectQueryCommonHelpDef.getKeyReturnIndex();
															int aliasReturnIndex = sysSubjectQueryCommonHelpDef.getAliasReturnIndex();
										%>
									<td class="FieldLabel" width="15%"><%=sysSubjectAlias%>：</td>
									<td class="FieldInput">
										<input type="text" id="<%=sysSubjectKey%>" title="<%=sysSubjectAlias%>" size="40">
										<input id="<%=sysSubjectKeyHidden%>" type="hidden" name="principalId" />
										<img src="<%=SkinUtils.getImage(request,"l5/liulan.gif")%>" style="cursor: hand"
											onclick="show('<%=sysSubjectKey%>','<%=sysSubjectKeyHidden%>','<%=dialogUrl%>','<%=dialogHeight%>','<%=dialogWidth%>','<%=keyReturnIndex%>','<%=aliasReturnIndex%>')" /></td>
									<%
														}
													}
												}
												break;
												//日期
												case 3 :{
													sysSubjectKeyDataBegin = sysSubjectKey + "dataBegin";
													sysSubjectKeyDataEnd = sysSubjectKey + "dataEnd";
									%>
									<td class="FieldLabel" width="10%"><%=sysSubjectAlias%>：</td>
									<td class="FieldInput" width="30%">
										<input type="text" id="<%=sysSubjectKeyDataBegin%>" class="TextEditor"
										title="开始日期" format="Y-m-d" name="createTime" field="createTime"
										onclick="LoushangDate(this)" /> 至 <input type="text"
										id="<%=sysSubjectKeyDataEnd%>" class="TextEditor"
										title="结束日期" format="Y-m-d" name="createTime" field="createTime"
										onclick="LoushangDate(this)" /></td>
									<%
										}
												break;
												//日期时间
												case 4 :{
													sysSubjectKeyDataTimeBegin = sysSubjectKey + "dataTimeBegin";
													sysSubjectKeyDataTimeEnd = sysSubjectKey + "dataTimeEnd";
									%>
									<td class="FieldLabel" width="10%"><%=sysSubjectAlias%>：</td>
									<td class="FieldInput" width="30%"><input type="text"
										id="<%=sysSubjectKeyDataTimeBegin%>" class="TextEditor"
										title="开始时间" size="40" format="Y-m-d H:i:s" name="createTime"
										field="createTime" onclick="LoushangDatetime(this)" /> 至 <input
										type="text" id="<%=sysSubjectKeyDataTimeEnd%>"
										class="TextEditor" title="结束时间" size="40" format="Y-m-d H:i:s"
										name="createTime" field="createTime"
										onclick="LoushangDatetime(this)" /></td>
									<%
										}
												break;
												default :{
									%>
									<td class="FieldLabel" width="15%"><%=sysSubjectAlias%>：</td>
									<td class="FieldInput" width="30%"><input type="text"
										id="<%=sysSubjectKey%>" class="TextEditor"
										title="<%=sysSubjectAlias%>" size="40" /></td>
									<%
												}
												break;
											}
										}
										if (i % 2 == 1) {
											if (i != sysSubjectQueryDefList.size() - 1) {
									%>
									</tr>
									<tr>
									<%
											}
										}
									}
									%>
									<% if(sysSubjectQueryDefList.size()%2==1){%>
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
				<next:GridPanel id="yiBanAndEndTaskGridPanel" name="yiBanAndEndTaskGridPanel"
					width="100%" height="100%" dataset="yiBanAndEndTaskDataset"
					title="已办流程列表" notSelectFirstRow="true">
					<next:Columns>
						<next:RowNumberColumn width="30" />
						<next:RadioBoxColumn></next:RadioBoxColumn>
						<next:Column id="assignmentId" header="内码" field="assignmentId"
							width="50" hidden="true">
							<next:TextField allowBlank="false" />
						</next:Column>
						<%
							//判断是否定制流程标题
							boolean hasProcSubject = false;
							for (int j = 0; j < sysYiBanAndEndSubjectDefList.size(); j++) {
								SysSubjectDef sysSubjectDef = (SysSubjectDef) sysYiBanAndEndSubjectDefList.get(j);
								if ("subject".equals(sysSubjectDef.getSubjectKey()) ||
									"procDefName".equals(sysSubjectDef.getSubjectKey()) ||
									"procCreateTime".equals(sysSubjectDef.getSubjectKey()) ||
									"procEndTime".equals(sysSubjectDef.getSubjectKey()) ||
								
									"actDefName".equals(sysSubjectDef.getSubjectKey()) ||
									"endTime".equals(sysSubjectDef.getSubjectKey()) ||
									"activeActDefNames".equals(sysSubjectDef.getSubjectKey()) ||
									"activeOrganNames".equals(sysSubjectDef.getSubjectKey())
									){
									hasProcSubject = true;
									break;
									}
							}
							if(hasProcSubject){
						%>
							<next:Column id="taskState" header="状态" field="taskState" width="50">
							<next:TextField allowBlank="false" />
							</next:Column>
							<next:Column id="subject" header="标题" field="subject" width="100">
								<next:TextField allowBlank="false" />
							</next:Column>
						<%
								for (int j = 0; j < sysYiBanAndEndSubjectDefList.size(); j++) {
									SysSubjectDef sysSubjectDef = (SysSubjectDef) sysYiBanAndEndSubjectDefList.get(j);
						%>
						<next:Column header="<%=sysSubjectDef.getSubjectAlias()%>"
								field="<%=sysSubjectDef.getSubjectKey()%>"
								width="<%=sysSubjectDef.getSubjectWidth()%>">
								<next:TextField allowBlank="false" />
						</next:Column>
						<%      }
							}else{
								for (int j = 0; j < sysYiBanAndEndSubjectDefList.size(); j++) {
									SysSubjectDef sysSubjectDef = (SysSubjectDef) sysYiBanAndEndSubjectDefList.get(j);
						%>
						<next:Column header="<%=sysSubjectDef.getSubjectAlias()%>"
								field="<%=sysSubjectDef.getSubjectKey()%>"
								width="<%=sysSubjectDef.getSubjectWidth()%>">
								<next:TextField allowBlank="false" />
						</next:Column>
						<%		}
						%>
						<next:Column id="taskState" header="状态" field="taskState" width="50">
							<next:TextField allowBlank="false" />
						</next:Column>
						<next:Column id="subject" header="标题" field="subject" width="100">
							<next:TextField allowBlank="false" />
						</next:Column>
						<next:Column id="procDefName" header="流程名称" field="procDefName" width="150" renderer="addLink">
							<next:TextField allowBlank="false" />
						</next:Column>
						<next:Column id="procCreateTime" header="流程发起时间" field="procCreateTime" width="150">
							<next:TextField allowBlank="false" />
						</next:Column>						
						<next:Column id="actDefName" header="已办环节" field="actDefName" width="150">
							<next:TextField allowBlank="false" />
						</next:Column>
						<next:Column id="endTime" header="办理时间" field="endTime" width="150">
							<next:TextField allowBlank="false" />
						</next:Column>
						<next:Column id="activeActDefNames" header="当前活动环节" field="activeActDefNames" width="150">
							<next:TextField allowBlank="false" />
						</next:Column>
						<next:Column id="activeOrganNames" header="当前活动环节处理人" field="activeOrganNames" width="150">
							<next:TextField allowBlank="false" />
						</next:Column>
						<next:Column id="procEndTime" header="流程结束时间" field="procEndTime" width="150">
							<next:TextField allowBlank="false" />
						</next:Column>
						<%}
						%>
					</next:Columns>
					<next:TopBar>
						<next:ToolBarItem symbol="->"></next:ToolBarItem>
						<next:ToolBarItem iconCls="select" text="查看" handler="handle" />
						<next:ToolBarItem iconCls="detail" text="查看流转状态" handler="showState" />
					</next:TopBar>
					<next:BottomBar>
						<next:PagingToolBar displayMsg="从第{0}条到{1}条，一共{2}条"
							displayInfo="true" dataset="yiBanAndEndTaskDataset" />
					</next:BottomBar>
				</next:GridPanel>
			</next:Panel>
		</next:Center>
	</next:BorderLayout>
</next:ViewPort>
</body>
<script language="javascript" type="text/javascript">
//查询条件面板打开合并函数
function collapse(element){
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

function init(){
	yiBanAndEndTaskDataset.load();
}


function query(){
	//获取用户输入查询条件值
	<%for (int i = 0; i < sysSubjectQueryDefList.size(); i++) {%>
		        var queryCondition="";
				<%SysSubjectQueryDef sysSubjectQueryDef = (SysSubjectQueryDef) sysSubjectQueryDefList.get(i);
				String subjectQueryDefUniqueId = sysSubjectQueryDef.getId();
				String subjectCatgory = sysSubjectQueryDef.getSubjectCategory();
				String subjectKey = sysSubjectQueryDef.getSubjectKey();
				String type = sysSubjectQueryDef.getSubjectFieldType();
				sysSubjectKeyDataBegin = subjectKey + "dataBegin";
				sysSubjectKeyDataEnd = subjectKey + "dataEnd";
				sysSubjectKeyDataTimeBegin = subjectKey + "dataTimeBegin";
				sysSubjectKeyDataTimeEnd = subjectKey + "dataTimeEnd";
				sysSubjectKeyHidden = subjectKey + "hidden";%>
				//通用帮助类型
				if(<%=type%>=="2"){
					queryCondition = document.getElementById("<%=subjectKey%>").value;
					if(queryCondition != null && queryCondition != ""){
						<%for (int j = 0; j < sysSubjectQueryCommonHelpDefList.size(); j++) {
							SysSubjectQueryCommonHelpDef sysSubjectQueryCommonHelpDef = 
								(SysSubjectQueryCommonHelpDef) sysSubjectQueryCommonHelpDefList.get(j);
							String sysSubjectQueryCommonHelpDefId = sysSubjectQueryCommonHelpDef
									.getSubjectQueryDefUniqueId();
							if (sysSubjectQueryCommonHelpDefId.equals(subjectQueryDefUniqueId)) {
								String condition = sysSubjectQueryCommonHelpDef.getConditionUseWay();
								if (!condition.equals("1")) {%>
									queryCondition=document.getElementById("<%=sysSubjectKeyHidden%>").value;
								<%}
							}
							break;
						}%>
					}
				}
				//日期
				else if(<%=type%>=="3"){	
					var sysSubjectKeyDataBegin=document.getElementById("<%=sysSubjectKeyDataBegin%>").value;
					var sysSubjectKeyDataEnd=document.getElementById("<%=sysSubjectKeyDataEnd%>").value;
					var dataBegin = sysSubjectKeyDataBegin.replace("-","").replace("-","");
					var dataEnd  = sysSubjectKeyDataEnd.replace("-","").replace("-","");
				    queryCondition=dataBegin+"#"+dataEnd;
				}
                //日期时间
				else if(<%=type%>=="4"){
					var sysSubjectKeyDataTimeBegin=document.getElementById("<%=sysSubjectKeyDataTimeBegin%>").value;
					var sysSubjectKeyDataTimeEnd=document.getElementById("<%=sysSubjectKeyDataTimeEnd%>").value;
					var dataTimeBegin = sysSubjectKeyDataTimeBegin.replace("-","").replace("-","");
					var dataTimeEnd = sysSubjectKeyDataTimeEnd.replace("-","").replace("-","");
				    queryCondition=dataTimeBegin+"#"+dataTimeEnd;
				}
                //文本框||下拉框
				else{
					var queryCondition=document.getElementById("<%=subjectKey%>").value;
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
			    	yiBanAndEndTaskDataset.setParameter("<%=subjectKey%>",queryCondition);
				 }
	<%}%>
	yiBanAndEndTaskDataset.load();
}
//通过链接处理已办任务
function addLink(value,second,record)
{
	var assignmentId=record.get("assignmentId");
	return "<a href=\"javascript:viewYiBanAndEndTask('"+assignmentId+"')\">"+value+"</a>";
}

//通过按钮查看已办办结合并任务
function handle()
{
	var userGrid=L5.getCmp('yiBanAndEndTaskGridPanel');
	var selected = userGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		alert("请选择一条记录进行查看!");
		return false;
	}
	var rec=selected[0];
	viewYiBanAndEndTask(rec.get("assignmentId"));
}

//查看已办办结合并任务
function viewYiBanAndEndTask(assignmentId)
{
	var userGridPanel=L5.getCmp('yiBanAndEndTaskGridPanel');
	 var selected=userGridPanel.getSelectionModel().getSelections();
	 var activeActDefNames = selected[0].get("activeActDefNames");
	if(activeActDefNames==null||activeActDefNames==''){
		var url="command/dispatcher/org.loushang.workflow.tasklist.forward.TaskListDispatcherCmd/endTaskForward";
	}else{
		var url="command/dispatcher/org.loushang.workflow.tasklist.forward.TaskListDispatcherCmd/yiBanTaskForward";
	}
	var query="?assignmentId="+assignmentId;
	L5.forward(url+query,"查看");
}

//查看流程状态图
function showState()
{
   var yiBanAndEndTaskGridPanel=L5.getCmp("yiBanAndEndTaskGridPanel");
   showprocessstate(yiBanAndEndTaskGridPanel,"yibanandend","jsp/workflow/tasklist/queryyibanandend.jsp");
}
</script>
</html>