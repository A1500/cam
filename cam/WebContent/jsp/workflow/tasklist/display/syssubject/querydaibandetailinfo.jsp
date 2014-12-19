<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="java.util.*"%>
<%@page
	import="org.loushang.workflow.tasklist.taskinfo.util.TaskListJspUtil"%>
<%@page
	import="org.loushang.workflow.processdefinition.tasklist.syssubjectdef.data.SysSubjectDef"%>
<%@page
	import="org.loushang.workflow.processdefinition.tasklist.syssubjectdef.data.SysSubjectQueryDef"%>
<%@page
	import="org.loushang.workflow.processdefinition.tasklist.syssubjectdef.data.SysSubjectQueryCommonHelpDef"%>
<%@page
	import="org.loushang.workflow.processdefinition.tasklist.syssubjectdef.data.SysSubjectQuerySelectDef"%>

<html>
<head>
<style>
a {
	TEXT-DECORATION: none
}
</style>
<title>待办任务详细信息查询</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="../../tasklistcommon.js"></script>
<%
	//任务标题
	List sysDaiBanSubjectDefList = TaskListJspUtil.getSysDaiBanTaskSubjectDefList();
	//查询条件
	List sysSubjectQueryDefList = TaskListJspUtil.getSysDaiBanTaskSubjectQueryDefList();
	//通用帮助
	List sysSubjectQueryCommonHelpDefList = TaskListJspUtil.getSysSubjectQueryCommonHelpDefList();
	//下拉框
	List sysSubjectQuerySelectDefList = TaskListJspUtil.getSysSubjectQuerySelectDefList();
%>
</head>
<body>

<model:datasets>
	<model:dataset pageSize="10" id="daiBanDataset"
		cmd="org.loushang.workflow.tasklist.taskinfo.cmd.DaiBanTaskQueryCmd"
		autoLoad="true" global="true"
		method="querySysDaiBanTaskTableDetailInfo">
		<model:record>
			<model:field name="taskState" type="string" />
			<model:field name="assignmentId" type="string" />
			<model:field name="procDefName" type="string" />
			<model:field name="actDefName" type="string" />
			<model:field name="preActDefNames" type="string" />
			<model:field name="preOrganNames" type="string" />
			<model:field name="createTime" type="string" />
			<model:field name="procCreateTime" type="string" />
			<model:field name="actLimitTime" type="string" />
			<model:field name="actWarnTime" type="string" />
			<model:field name="procLimitTime" type="string" />
			<model:field name="procWarnTime" type="string" />
			<model:field name="primaryKey" type="string" />
			<%
				for (int i = 0; i < sysDaiBanSubjectDefList.size(); i++) {
								SysSubjectDef sysSubjectDef = (SysSubjectDef) sysDaiBanSubjectDefList
										.get(i);
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
										for (int i = 0; i < sysSubjectQueryDefList.size(); i++) {
											SysSubjectQueryDef sysSubjectQueryDef = (SysSubjectQueryDef) sysSubjectQueryDefList.get(i);
											String sysSubjectKey = sysSubjectQueryDef.getSubjectKey();
											String sysSubjectAlias = sysSubjectQueryDef.getSubjectAlias();
											String sysSubField = sysSubjectQueryDef.getSubjectFieldType();
											if ("0".equals(sysSubField)||sysSubField == null) {
									%>
									<td class="FieldLabel" width="15%"><%=sysSubjectAlias%>：</td>
									<td class="FieldInput"><input type="text"
										id="<%=sysSubjectKey%>" class="TextEditor"
										title="<%=sysSubjectAlias%>" size="40" /></td>
										<%
										}else if("1".equals(sysSubField)){	
									%>
									<td class="FieldLabel"><%=sysSubjectAlias%>：</td>
									<td class="FieldInput">
									<select name="<%=sysSubjectKey%>">
									<option value="">请选择...</option>
									<%
										String optionValue;
										String optionText;
										for(int k=0; k<sysSubjectQuerySelectDefList.size(); k++){
											SysSubjectQuerySelectDef sysSubjectQuerySelectDef = (SysSubjectQuerySelectDef)sysSubjectQuerySelectDefList.get(k);
											String sujectQueryDefUniqueId = sysSubjectQuerySelectDef.getSubjectQueryDefUniqueId();
											if(sujectQueryDefUniqueId.equals(sysSubjectQueryDef.getId())){
												optionValue = sysSubjectQuerySelectDef.getOptionValue();
												optionText = sysSubjectQuerySelectDef.getOptionText();
											
									%>
										<option value="<%=optionValue%>"><%=optionText%></option>
									<%
											}
										}
									%>
									</select>
									</td>
									<%
										} else if ("3".equals(sysSubField)) {
											 String startDate=sysSubjectKey+"start";
											 String endDate=sysSubjectKey+"end";
									%>
									<td class="FieldLabel" width="15%"><%=sysSubjectAlias%>：</td>
									<td class="FieldInput"><input type="text" id="<%=startDate%>"
										class="TextEditor" title="开始日期" size="40"
										format="Y-m-d" 
										onclick="LoushangDate(this)" /> 至 <input type="text" id="<%=endDate%>"
										class="TextEditor" title="结束日期" size="40"
										format="Y-m-d" 
										onclick="LoushangDate(this)" /></td>
									<%
										} else if ("4".equals(sysSubField)) {
											String startDate=sysSubjectKey+"start";
											String endDate=sysSubjectKey+"end";
									%>
									<td class="FieldLabel" width="15%"><%=sysSubjectAlias%>：</td>
									<td class="FieldInput"><input type="text"
										id="<%=startDate%>" class="TextEditor"
										title="开始时间" size="40" format="Y-m-d"
										onclick="LoushangDatetime(this)" /> 至 <input type="text" id="<%=endDate%>"
										class="TextEditor" title="结束时间" size="40"
										format="Y-m-d" 
										onclick="LoushangDatetime(this)" /></td>
									<%
										}else if("2".equals(sysSubField)){
											String dialogUrl;
											String dialogWidth;
											String dialogHeight;
											int keyReturnIndex;
											int aliasReturnIndex;
											String conditionUseWay;
											for(int j=0;j<sysSubjectQueryCommonHelpDefList.size();j++){
												SysSubjectQueryCommonHelpDef sysSubjectQueryCommonHelpDef=(SysSubjectQueryCommonHelpDef)sysSubjectQueryCommonHelpDefList.get(j);
												String subjectQueryDefUniqueId = sysSubjectQueryCommonHelpDef.getSubjectQueryDefUniqueId();
												String conditionUseWayHidden = subjectQueryDefUniqueId + "returnvalue";//返回值id
												String conditionUseWayShow = subjectQueryDefUniqueId + "returnshow";//返回显示值id
												if(subjectQueryDefUniqueId.equals(sysSubjectQueryDef.getId())){
													dialogUrl = sysSubjectQueryCommonHelpDef.getDialogUrl();
													dialogWidth = sysSubjectQueryCommonHelpDef.getDialogWidth();
													dialogHeight = sysSubjectQueryCommonHelpDef.getDialogHeight();
													keyReturnIndex = sysSubjectQueryCommonHelpDef.getKeyReturnIndex();
													aliasReturnIndex = sysSubjectQueryCommonHelpDef.getAliasReturnIndex();
													conditionUseWay = sysSubjectQueryCommonHelpDef.getConditionUseWay();	
									%>
									<input type="hidden" id="<%=conditionUseWayHidden%>" class="TextEditor" value="" size="40" />
									<td class="FieldLabel" width="15%"><%=sysSubjectAlias%>：</td>
									<td class="FieldInput"><input type="text" id="<%=conditionUseWayShow%>" class="TextEditor" title="<%=sysSubjectAlias%>" value="" size="40" />
									<image src="<%=SkinUtils.getImage(request,"l5/liulan.gif")%>" onclick="forCommonHelp('<%=conditionUseWayHidden%>','<%=conditionUseWayShow%>','<%=keyReturnIndex%>','<%=aliasReturnIndex%>','<%=dialogUrl%>','<%=dialogWidth%>','<%=dialogHeight%>')"/>
									</td>
									<%}
										}
										}
										if(i%2==1){
											if(i!=sysSubjectQueryDefList.size()-1){
				                    	%>
				                     	</tr>
				                     	<tr>
				                    	<%
				                        	}
										}
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
					<next:GridPanel id="daiBanTaskGridPanel" name="daiBanTaskGridPanel"
						anchor="100%" height="100%" dataset="daiBanDataset"    
						title="待办任务详细信息列表" notSelectFirstRow="true">
						<next:Columns>
							<next:RowNumberColumn width="30" />
							<next:RadioBoxColumn></next:RadioBoxColumn>
							<next:Column header="状态" field="taskState" width="40"
								renderer="setTaskState" align="center">
								<next:TextField allowBlank="false" />
							</next:Column>
							<next:Column id="assignmentId" header="内码" field="assignmentId"
								width="50" hidden="true">
								<next:TextField allowBlank="false" />
							</next:Column>
							<%
							boolean flag = false;
							for (int j = 0; j < sysDaiBanSubjectDefList
									.size(); j++) {
								SysSubjectDef procTypeSubjectDef = (SysSubjectDef) sysDaiBanSubjectDefList
										.get(j);
								if ("actDefName"
										.equals(procTypeSubjectDef
												.getSubjectKey())
										|| "preActDefNames"
												.equals(procTypeSubjectDef
														.getSubjectKey())
										|| "procDefName"
												.equals(procTypeSubjectDef
														.getSubjectKey())
										|| "preOrganNames"
												.equals(procTypeSubjectDef
														.getSubjectKey())
										|| "createTime"
												.equals(procTypeSubjectDef
														.getSubjectKey())
										|| "procCreateTime"
												.equals(procTypeSubjectDef
														.getSubjectKey())
										|| "actLimitTime"
												.equals(procTypeSubjectDef
														.getSubjectKey())
										|| "actWarnTime"
												.equals(procTypeSubjectDef
														.getSubjectKey())
										|| "actRemainTime"
												.equals(procTypeSubjectDef
														.getSubjectKey())
										|| "actSetRemainTimeMin"
												.equals(procTypeSubjectDef
														.getSubjectKey())
										|| "procLimitTime"
												.equals(procTypeSubjectDef
														.getSubjectKey())
										|| "procWarnTime"
												.equals(procTypeSubjectDef
														.getSubjectKey())) {
                                        flag=true;
								}
							}
							if(flag==true){
								boolean sortAble = false;
								for (int i = 0; i < sysDaiBanSubjectDefList
										.size(); i++) {
									SysSubjectDef procTypeSubjectDef = (SysSubjectDef) sysDaiBanSubjectDefList
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
							
}else{
	boolean sortAble = false;
	for (int i = 0; i < sysDaiBanSubjectDefList
			.size(); i++) {
		SysSubjectDef procTypeSubjectDef = (SysSubjectDef) sysDaiBanSubjectDefList
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
<next:Column header="当前环节" field="actDefName" width="150" sortable="true">
<next:TextField allowBlank="false" />
</next:Column>
<next:Column header="任务到达时间" field="createTime" width="150" sortable="true">
<next:TextField allowBlank="false" />
</next:Column>
<next:Column id="id" header="发送环节" field="preActDefNames"
width="100" sortable="true">
<next:TextField allowBlank="false" />
</next:Column>
<next:Column header="发送人" field="preOrganNames" width="150" sortable="true">
<next:TextField allowBlank="false" />
</next:Column>
<next:Column header="环节限时时间" field="actLimitTime" width="150" sortable="true">
<next:TextField allowBlank="false" />
</next:Column>
<next:Column header="环节预警时间" field="actWarnTime" width="150" sortable="true">
<next:TextField allowBlank="false" />
</next:Column>
<next:Column header="流程限时时间" field="procLimitTime" width="150" sortable="true">
<next:TextField allowBlank="false" />
</next:Column>
<next:Column header="流程预警时间" field="procWarnTime" width="150" sortable="true">
<next:TextField allowBlank="false" />
</next:Column>
<%}
%>
							<next:Column header="业务主键" field="primaryKey" width="150" hidden="true">
								<next:TextField allowBlank="false"/>
							</next:Column>
						</next:Columns>
						<next:TopBar>	
							<next:ToolBarItem symbol="->"></next:ToolBarItem>
							<next:ToolBarItem iconCls="select" text="办理" handler="handle" />
							<next:ToolBarItem iconCls="detail" text="查看流转状态"
								handler="showState" />
						</next:TopBar>
						<next:BottomBar>
							<next:PagingToolBar displayMsg="从第{0}条到{1}条，一共{2}条"
								displayInfo="true" dataset="daiBanDataset" />
						</next:BottomBar>
					</next:GridPanel>
				</next:AnchorLayout>
			</next:Panel>
		</next:Center>
	</next:BorderLayout>
</next:ViewPort>
</body>
<script language="javascript" type="text/javascript">

//设置任务状态
function setTaskState(value)
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

	return '<img src="'+imagePath+image+'"/>';	
}
//待办任务查询
function query()
{
	var queryCondition;
	<%
		for (int i = 0; i < sysSubjectQueryDefList.size(); i++) {
					SysSubjectQueryDef sysSubjectQueryDef = (SysSubjectQueryDef) sysSubjectQueryDefList
							.get(i);
					String subjectCategory = sysSubjectQueryDef.getSubjectCategory();
					String subjectKey = sysSubjectQueryDef.getSubjectKey();
					String sysSubField = sysSubjectQueryDef.getSubjectFieldType();
					String startDate = subjectKey+"start";
					String endDate = subjectKey+"end";
		 if ("0".equals(sysSubField)||"1".equals(sysSubField)||sysSubField == null) {
	%>
	 	queryCondition=document.getElementById("<%=subjectKey%>").value;
	 <%
	 	}
		 else if ("3".equals(sysSubField)||"4".equals(sysSubField)) {
	 %>
	 var startDate=document.getElementById("<%=startDate%>").value;
	 var endDate=document.getElementById("<%=endDate%>").value;
	 queryCondition=startDate+"#"+endDate;
	 <%
	 	}else if("2".equals(sysSubField)){
	 		for(int j=0;j<sysSubjectQueryCommonHelpDefList.size();j++){
	 			SysSubjectQueryCommonHelpDef sysSubjectQueryCommonHelpDef =(SysSubjectQueryCommonHelpDef)sysSubjectQueryCommonHelpDefList.get(j);
	 			String subjectQueryDefUniqueId = sysSubjectQueryCommonHelpDef.getSubjectQueryDefUniqueId();
	 			if(subjectQueryDefUniqueId.equals(sysSubjectQueryDef.getId())){
					String conditionUseWayHidden = subjectQueryDefUniqueId + "returnvalue";//返回值id
					String conditionUseWayShow = subjectQueryDefUniqueId + "returnshow";//返回显示值id
		 			String conditionUseWay = sysSubjectQueryCommonHelpDef.getConditionUseWay();
					%>
					var conditionUseWayHidden = document.getElementById("<%=conditionUseWayHidden%>").value;
					var conditionUseWayShow = document.getElementById("<%=conditionUseWayShow%>").value;
					var conditionUseWay = '<%=conditionUseWay%>';
					if(conditionUseWay == "0"){
						if(conditionUseWayShow == null || conditionUseWayShow == ""){
							queryCondition = "";
						}
						else{
							queryCondition = conditionUseWayHidden;
						}
					}
					else{
						queryCondition = conditionUseWayShow;
					}
		<%
		 			}
	 			}
	 		}
		
		%>
	 if(<%=subjectCategory%>=="1"){
		 queryCondition = "procTable"+queryCondition;
	 }
	 if(queryCondition!=null&&queryCondition!="")
	 {	
		 daiBanDataset.setParameter("<%=subjectKey%>",queryCondition); 
	 }
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
   showprocessstate(daiBanTaskGridPanel,"daiban","jsp/workflow/tasklist/display/syssubject/querydaibandetailinfo.jsp");
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

function forCommonHelp(conditionUseWayHidden,conditionUseWayShow,keyReturnIndex,aliasReturnIndex,dialogUrl,dialogWidth,dialogHeight){
	<%
	String path = request.getContextPath();
	%>
	var scheme=dialogUrl.substring(0,7);
    if(scheme.toLowerCase()!="http://"){
        var allUrl= '<%=path%>' + "/" + dialogUrl;
    }
	var dialogMsg = "dialogWidth:"+dialogWidth+"px;dialogHeight:"+dialogHeight+"px";
	
	var win = showModalDialog(allUrl,window,dialogMsg);
	var conditionUseWayReturnValue = win[keyReturnIndex];
	var conditonUseWayShowValue = win[aliasReturnIndex];
	document.getElementById(conditionUseWayHidden).value = conditionUseWayReturnValue;
	document.getElementById(conditionUseWayShow).value = conditonUseWayShowValue;
}
</script>
</html>