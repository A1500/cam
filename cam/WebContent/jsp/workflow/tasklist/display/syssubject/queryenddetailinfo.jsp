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
<%@page
	import="org.loushang.workflow.processdefinition.tasklist.syssubjectdef.data.SysSubjectQuerySelectDef"%>

<html>
	<head><style>a{TEXT-DECORATION:none}</style>
		<title>结束任务查询</title>
		<next:ScriptManager></next:ScriptManager>
		<script type="text/javascript" src="../../tasklistcommon.js"></script>
		<% 
		  //任务标题
		  List sysEndSubjectDefList = TaskListJspUtil.getSysEndTaskSubjectDefList();
		  //查询条件
		  List sysSubjectQueryDefList = TaskListJspUtil.getSysEndTaskSubjectQueryDefList();
		  //通用帮助
		  List sysSubjectQueryCommonHelpDefList = TaskListJspUtil.getSysSubjectQueryCommonHelpDefList();
		  //下拉框
		  List sysSubjectQuerySelectDefList = TaskListJspUtil.getSysSubjectQuerySelectDefList();

        %>
	</head>
<body>

<model:datasets>
	<model:dataset pageSize="10" id="endDataset" cmd="org.loushang.workflow.tasklist.taskinfo.cmd.EndTaskQueryCmd" autoLoad="true" global="true" method="querySysEndTaskTableDetailInfo">
		<model:record>
			<model:field name="assignmentId" type="string" />
			<model:field name="procDefName" type="string" />
			<model:field name="actDefName" type="string" />
			<model:field name="endTime" type="string" />
			<model:field name="procCreateTime" type="string" />
			<model:field name="procEndTime" type="string" />
			<model:field name="primaryKey" type="string" />
			<% 
			  for(int i=0;i<sysEndSubjectDefList.size();i++)
			  {
				  SysSubjectDef sysSubjectDef=(SysSubjectDef)sysEndSubjectDefList.get(i);
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
									<% 
			                          for(int i=0;i<sysSubjectQueryDefList.size();i++)
			                          {
				                        SysSubjectQueryDef sysSubjectQueryDef=(SysSubjectQueryDef)sysSubjectQueryDefList.get(i);
				                        String sysSubjectKey=sysSubjectQueryDef.getSubjectKey();
				                        String sysSubjectAlias=sysSubjectQueryDef.getSubjectAlias();
			                          	String sysSubField=sysSubjectQueryDef.getSubjectFieldType();
				                        if("0".equals(sysSubField)||sysSubField == null){
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
									<select id="<%=sysSubjectKey%>">
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
										<option value="<%=optionValue %>"><%=optionText%></option>
									<%
											}
										}
									%>
									</select>
									</td>
									<%
										}else if("3".equals(sysSubField)){
											String startDate=sysSubjectKey+"start";
											String endDate=sysSubjectKey+"end";
									%>
									<td class="FieldLabel" width="15%"><%=sysSubjectAlias%>：</td>
									<td class="FieldInput"><input type="text" id="<%=startDate%>"
										class="TextEditor" title="开始日期" size="40"
										format="Y-m-d" name="createTime" field="createTime"
										onclick="LoushangDate(this)" /> 至  <input type="text" id="<%=endDate%>"
										class="TextEditor" title="结束日期" size="40"
										format="Y-m-d" name="createTime" field="createTime"
										onclick="LoushangDate(this)" /></td>
									<%
										}else if("4".equals(sysSubField)){
											String startDate=sysSubjectKey+"start";
											String endDate=sysSubjectKey+"end";
									%>
									<td class="FieldLabel" width="15%"><%=sysSubjectAlias%>：</td>
									<td class="FieldInput"><input type="text"
										id="<%=startDate%>" class="TextEditor"
										title="开始时间" size="40" format="Y-m-d"
										name="createTime" field="createTime"
										onclick="LoushangDatetime(this)" /> 至 <input type="text" id="<%=endDate%>"
										class="TextEditor" title="结束时间" size="40"
										format="Y-m-d" name="createTime" field="createTime"
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
									<td class="FieldButton" width="15%"><button onclick="query()">查询</button> </td>
								</tr>
							</table>
						</form>		
					</div>
				</fieldset>
				</next:Html>
			</next:Panel>			
			<next:GridPanel id="endTaskGridPanel" name="endTaskGridPanel" width="100%" height="100%" dataset="endDataset"     title="办结任务详细信息列表" notSelectFirstRow="true">
				<next:Columns>
	   				<next:RowNumberColumn width="30"/>
	    			<next:RadioBoxColumn></next:RadioBoxColumn>
					<next:Column id="assignmentId" header="内码" field="assignmentId" width="50" hidden="true" >
					<next:TextField allowBlank="false"/>
					</next:Column>
					<% 
					boolean flag = false;
					for (int j = 0; j < sysEndSubjectDefList
							.size(); j++) {
						SysSubjectDef procTypeSubjectDef = (SysSubjectDef) sysEndSubjectDefList
								.get(j);
						if ("procDefName"
								.equals(procTypeSubjectDef
										.getSubjectKey())
								|| "actDefName"
										.equals(procTypeSubjectDef
												.getSubjectKey())
								|| "endTime"
										.equals(procTypeSubjectDef
												.getSubjectKey())
								|| "procCreateTime"
										.equals(procTypeSubjectDef
												.getSubjectKey())
								|| "procEndTime"
										.equals(procTypeSubjectDef
												.getSubjectKey())) {
							flag = true;
						}
					}
					if (flag == true) {
						boolean sortAble = false;
						for (int i = 0; i < sysEndSubjectDefList
								.size(); i++) {
							SysSubjectDef procTypeSubjectDef = (SysSubjectDef) sysEndSubjectDefList
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
						boolean sortAble = false;
						for (int i = 0; i < sysEndSubjectDefList
								.size(); i++) {
							SysSubjectDef procTypeSubjectDef = (SysSubjectDef) sysEndSubjectDefList
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
<next:Column id="id" header="办理时间" field="endTime" width="150" sortable="true">
<next:TextField allowBlank="false" />
</next:Column>
<next:Column header="流程结束时间" field="procEndTime" width="150" sortable="true">
<next:TextField allowBlank="false" />
</next:Column>
<%
}
%>
					<next:Column header="业务主键" field="primaryKey" width="150" hidden="true">
						<next:TextField allowBlank="false"/>
					</next:Column>					
				</next:Columns>
				<next:TopBar>	
					<next:ToolBarItem symbol="->"></next:ToolBarItem>		
					<next:ToolBarItem iconCls="select"  text="查看" handler="handle"/>
					<next:ToolBarItem iconCls="detail"  text="查看流转状态" handler="showState"/>
				</next:TopBar>
				<next:BottomBar>
					<next:PagingToolBar displayMsg="从第{0}条到{1}条，一共{2}条" displayInfo="true" dataset="endDataset"/>
				</next:BottomBar>
			</next:GridPanel>
			</next:Panel>
		</next:Center>
	</next:BorderLayout>
</next:ViewPort>
</body>
<script language="javascript"  type="text/javascript" >
//办结任务查询
function query()
{
	<%
		for (int i = 0; i < sysSubjectQueryDefList.size(); i++) {
			SysSubjectQueryDef sysSubjectQueryDef = (SysSubjectQueryDef) sysSubjectQueryDefList.get(i);
			String subjectCategory = sysSubjectQueryDef.getSubjectCategory();
			String subjectKey = sysSubjectQueryDef.getSubjectKey();
			String sysSubField = sysSubjectQueryDef.getSubjectFieldType();
			String startDate = subjectKey+"start";
			String endDate = subjectKey+"end";
	%>
		var queryCondition;
	<%
		 if ("0".equals(sysSubField)||"1".equals(sysSubField)||sysSubField == null) {
	%>
	 	queryCondition=document.getElementById("<%=subjectKey%>").value;
	<%
	 	} else if ("3".equals(sysSubField)||"4".equals(sysSubField)) {
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
		 endDataset.setParameter("<%=subjectKey%>",queryCondition); 
	 }
	<%
	}
	%>
	endDataset.load();
}

//通过链接处理办结任务
function addLink(value,second,record)
{
	var assignmentId=record.get("assignmentId");
	return "<a href=\"javascript:dealEndTask('"+assignmentId+"')\">"+value+"</a>";
}

//通过按钮处理办结任务
function handle()
{
	var userGrid=L5.getCmp('endTaskGridPanel');
	var selected = userGrid.getSelectionModel().getSelections();
	if(selected.length!=1){
		alert("请选择一条记录进行处理!");
		return false;
	}
	var rec=selected[0];
	dealEndTask(rec.get("assignmentId"));
}

//处理办结任务
function dealEndTask(assignmentId)
{			
	var url="command/dispatcher/org.loushang.workflow.tasklist.forward.TaskListDispatcherCmd/endTaskForward";
	var query="?assignmentId="+assignmentId;
	L5.forward(url+query,"办理");
}

//查看流程状态图
function showState()
{
   var endTaskGridPanel=L5.getCmp("endTaskGridPanel");
   showprocessstate(endTaskGridPanel,"end","jsp/workflow/tasklist/display/syssubject/queryenddetailinfo.jsp");
}
//查询条件面板打开合并函数
function collapse(element)
{
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