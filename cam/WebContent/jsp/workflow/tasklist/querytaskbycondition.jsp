<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="java.util.*"%>
<%@page import="org.loushang.workflow.tasklist.taskinfo.util.TaskListUtil"%>
<html>
	<head><style>a{TEXT-DECORATION:none}</style>
		<title>待办任务查询</title>
		<next:ScriptManager></next:ScriptManager>
		<%
			//指定过滤流程类型查询	
			String processId = request.getParameter("processId");
			if(processId==null)processId="";
			String searchType = request.getParameter("searchType");
			if(searchType==null)searchType="";
			// 查看该流程实例是否办结
			boolean isProcessEnd = false;
			if(!processId.equals("")){
				isProcessEnd = TaskListUtil.isProcessEnd(processId);
			}
			
			// 使用的dataSet类型(指定一个默认值)
			String dsType = "allTaskDataSet";
			if(searchType.equals("allTask")){
				if(isProcessEnd){
					dsType = "endTaskDataSet";
				}else{
					dsType = "allTaskDataSet";
				}
			}
			// 查询逾期任务
			if(searchType.equals("timeOutTask")){
				if(isProcessEnd){
					dsType = "timeOutEndTaskDataSet";
				}else{
					dsType = "timeOutTaskDataSet";
				}
			}
			// 查询待办任务
			if(searchType.equals("daiBanTask")){
				dsType = "daiBanTaskDataSet";
			}
		%>
	</head>
<body>

<model:datasets>
	<model:dataset pageSize="10" id="allTaskDataSet" cmd="org.loushang.workflow.tasklist.taskinfo.cmd.TaskQueryCommand" method="queryAllTask" autoLoad="false" global="true">
		<model:record>
			<model:field name="id" type="string" />
			<model:field name="state" type="string" />
			<model:field name="procDefName" type="string" />
			<model:field name="procCreateTime" type="string" />
			<model:field name="preActDefNames" type="string" />
			<model:field name="preOrganNames" type="string" />
			<model:field name="actDefName" type="string" />
			<model:field name="actLimitTime" type="string" />
			<model:field name="actWarnTime" type="string" />
			<model:field name="endTime" type="string" />
			<model:field name="activeActDefNames" type="string" />
			<model:field name="activeOrganNames" type="string" />
			<model:field name="isTimeOut" type="string" />
		</model:record>
	</model:dataset>
	
	<model:dataset pageSize="10"  id="endTaskDataSet" cmd="org.loushang.workflow.tasklist.taskinfo.cmd.TaskQueryCommand" method="queryEndTask" autoLoad="false" global="true">
		<model:record>
			<model:field name="id" type="string" />
			<model:field name="state" type="string" />
			<model:field name="procDefName" type="string" />
			<model:field name="procCreateTime" type="string" />
			<model:field name="procEndTime" type="string" />
			<model:field name="actDefName" type="string" />
			<model:field name="endTime" type="string" />
			<model:field name="isTimeOut" type="string" />
		</model:record>
	</model:dataset>
	
	<model:dataset pageSize="10"  id="daiBanTaskDataSet" cmd="org.loushang.workflow.tasklist.taskinfo.cmd.TaskQueryCommand" method="queryDaiBanTask" autoLoad="false" global="true">
		<model:record>
			<model:field name="id" type="string" />
			<model:field name="state" type="string" />
			<model:field name="procDefName" type="string" />
			<model:field name="procCreateTime" type="string" />
			<model:field name="preActDefNames" type="string" />
			<model:field name="preOrganNames" type="string" />
			<model:field name="actDefName" type="string" />
			<model:field name="actLimitTime" type="string" />
			<model:field name="actWarnTime" type="string" />
			<model:field name="isTimeOut" type="string" />
		</model:record>
	</model:dataset>

	<model:dataset id="timeOutTaskDataSet" cmd="org.loushang.workflow.tasklist.taskinfo.cmd.TaskQueryCommand" method="queryTimeOutTask" autoLoad="false" global="true">
		<model:record>
			<model:field name="id" type="string" />
			<model:field name="state" type="string" />
			<model:field name="procDefName" type="string" />
			<model:field name="procCreateTime" type="string" />
			<model:field name="preActDefNames" type="string" />
			<model:field name="preOrganNames" type="string" />
			<model:field name="actDefName" type="string" />
			<model:field name="actLimitTime" type="string" />
			<model:field name="actWarnTime" type="string" />
			<model:field name="endTime" type="string" />
			<model:field name="activeActDefNames" type="string" />
			<model:field name="activeOrganNames" type="string" />
			<model:field name="isTimeOut" type="string" />
		</model:record>
	</model:dataset>
	
	<model:dataset id="timeOutEndTaskDataSet" cmd="org.loushang.workflow.tasklist.taskinfo.cmd.TaskQueryCommand" method="queryTimeOutEndTask" autoLoad="false" global="true">
		<model:record>
			<model:field name="id" type="string" />
			<model:field name="state" type="string" />
			<model:field name="procDefName" type="string" />
			<model:field name="procCreateTime" type="string" />
			<model:field name="procEndTime" type="string" />
			<model:field name="actDefName" type="string" />
			<model:field name="endTime" type="string" />
			<model:field name="isTimeOut" type="string" />
		</model:record>
	</model:dataset>
</model:datasets>

<next:ViewPort>
	<next:Defaults>{collapsible:true,split:true,animFloat:true,autoHide:true,useSplitTips:true,bodyStyle:'padding:6px;'}</next:Defaults>
	<next:Panel id="daibanpanel">
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
								<td class="FieldLabel" width="15%" ><%if(isProcessEnd){%> 已办环节:<%}else{%> 当前环节:<%}%></td>
				                <td class="FieldInput">
				                	<input type="text"  id="searchCondition" class="TextEditor" title="标题"  size="40"/>
				                </td>
								<td class="FieldLabel" width="15%" >状态:</td>
								<td class="FieldInput">
									<select id="actState">
										<option value="">请选择······</option>
										<option value="daiBan">待办</option>
										<option value="yiBan">已办</option>
										<option value="end">办结</option>
									</select>
								</td>
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
		<%if(searchType.equals("daiBanTask")){%>
			<next:GridPanel id="daiBanTaskGridPanel" name="daiBanTaskGridPanel" anchor="100%" height="100%" dataset="<%=dsType%>"  title="待办任务列表" notSelectFirstRow="true">
				<next:Columns>
		  			<next:RowNumberColumn width="30"/>
		  			<next:RadioBoxColumn></next:RadioBoxColumn>
		  			<next:Column id="id" header="内码" field="id" width="50" hidden="true" >
						<next:TextField allowBlank="false"/>
					</next:Column>
					<next:Column id="state" header="状态" field="state" width="50" hidden="false" >
						<next:TextField allowBlank="false"/>
					</next:Column>
					<next:Column id="isTimeOut" header="逾期" field="isTimeOut" width="50" sortable="false">
						<next:TextField allowBlank="false"/>
					</next:Column>
					<next:Column id="actDefName" header="当前环节" field="actDefName" width="100" sortable="false">
						<next:TextField allowBlank="false"/>
					</next:Column>
					<next:Column id="preActDefNames" header="发送环节" field="preActDefNames" width="100" sortable="false">
						<next:TextField allowBlank="false"/>
					</next:Column>
					<next:Column id="preOrganNames" header="发送人" field="preOrganNames" width="100" sortable="false">
						<next:TextField allowBlank="false"/>
					</next:Column>
					<next:Column id="actLimitTime" header="环节限时" field="actLimitTime" width="150" sortable="false">
						<next:TextField allowBlank="false"/>
					</next:Column>
					<next:Column id="actWarnTime" header="环节预警" field="actWarnTime" width="150" sortable="false">
						<next:TextField allowBlank="false"/>
					</next:Column>
					<next:Column id="procDefName" header="流程名称" field="procDefName" width="200" sortable="false">
						<next:TextField allowBlank="false"/>
					</next:Column>
					<next:Column id="procCreateTime" header="流程发起时间" field="procCreateTime" width="150" sortable="false">
						<next:TextField allowBlank="false"/>
					</next:Column>
				</next:Columns>
				<next:TopBar>
					<next:ToolBarItem symbol="->"></next:ToolBarItem>
					<next:ToolBarItem iconCls="undo" text="返回" handler="forReturn" />
				</next:TopBar>
				<next:BottomBar>
					<next:PagingToolBar displayMsg="从第{0}条到{1}条，一共{2}条" displayInfo="true" dataset="<%=dsType%>"/>
				</next:BottomBar>
			</next:GridPanel>
		
		
			
		<%}else{
			if(isProcessEnd){
		%>
				<next:GridPanel id="endTaskGridPanel" name="endTaskGridPanel" anchor="100%" height="100%" dataset="<%=dsType%>"  title="办结任务列表" notSelectFirstRow="true">
					<next:Columns>
			  			<next:RowNumberColumn width="30"/>
			  			<next:RadioBoxColumn></next:RadioBoxColumn>
			  			<next:Column id="id" header="内码" field="id" width="50" hidden="true" >
							<next:TextField allowBlank="false"/>
						</next:Column>
			  			<next:Column id="state" header="状态" field="state" width="50" hidden="false" >
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="isTimeOut" header="逾期" field="isTimeOut" width="50" sortable="false">
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="actDefName" header="已办环节" field="actDefName" width="100" sortable="false">
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="endTime" header="办理时间" field="endTime" width="150" sortable="false">
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="procDefName" header="流程名称" field="procDefName" width="200" sortable="false">
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="procCreateTime" header="流程发起时间" field="procCreateTime" width="150" sortable="false">
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="procEndTime" header="流程结束时间" field="procEndTime" width="150" sortable="false">
							<next:TextField allowBlank="false"/>
						</next:Column>
					</next:Columns>
					<next:TopBar>
						<next:ToolBarItem symbol="->"></next:ToolBarItem>
						<next:ToolBarItem iconCls="undo" text="返回" handler="forReturn" />
					</next:TopBar>
					<% if(!searchType.equals("timeOutTask")){%>
						<next:BottomBar>
							<next:PagingToolBar displayMsg="从第{0}条到{1}条，一共{2}条" displayInfo="true" dataset="<%=dsType%>"/>
						</next:BottomBar>
					<%}%>
				</next:GridPanel>
		<%}else{%>
		<next:GridPanel id="allTaskGridPanel" name="allTaskGridPanel" anchor="100%" height="100%" dataset="<%=dsType%>"  title="任务列表" notSelectFirstRow="true">
			<next:Columns>
	  			<next:RowNumberColumn width="30"/>
	  			<next:RadioBoxColumn></next:RadioBoxColumn>
	  			<next:Column id="id" header="内码" field="id" width="50" hidden="true" >
					<next:TextField allowBlank="false"/>
				</next:Column>
				<next:Column id="state" header="状态" field="state" width="50" hidden="false" >
					<next:TextField allowBlank="false"/>
				</next:Column>
				<next:Column id="isTimeOut" header="逾期" field="isTimeOut" width="50" sortable="false">
					<next:TextField allowBlank="false"/>
				</next:Column>
				<next:Column id="actDefName" header="当前环节" field="actDefName" width="100" sortable="false">
					<next:TextField allowBlank="false"/>
				</next:Column>
				<next:Column id="preActDefNames" header="发送环节" field="preActDefNames" width="100" sortable="false">
					<next:TextField allowBlank="false"/>
				</next:Column>
				<next:Column id="preOrganNames" header="发送人" field="preOrganNames" width="100" sortable="false">
					<next:TextField allowBlank="false"/>
				</next:Column>
				<next:Column id="actLimitTime" header="环节限时" field="actLimitTime" width="150" sortable="false">
					<next:TextField allowBlank="false"/>
				</next:Column>
				<next:Column id="actWarnTime" header="环节预警" field="actWarnTime" width="150" sortable="false">
					<next:TextField allowBlank="false"/>
				</next:Column>
				<next:Column id="endTime" header="任务完成时间" field="endTime" width="150" sortable="false">
					<next:TextField allowBlank="false"/>
				</next:Column>
				<next:Column id="activeActDefNames" header="当前活动环节" field="activeActDefNames" width="100" sortable="false">
					<next:TextField allowBlank="false"/>
				</next:Column>
				<next:Column id="activeOrganNames" header="当前环节处理人" field="activeOrganNames" width="100" sortable="false">
					<next:TextField allowBlank="false"/>
				</next:Column>
				<next:Column id="procDefName" header="流程名称" field="procDefName" width="200" sortable="false">
					<next:TextField allowBlank="false"/>
				</next:Column>
				<next:Column id="procCreateTime" header="流程发起时间" field="procCreateTime" width="150" sortable="false">
					<next:TextField allowBlank="false"/>
				</next:Column>
			</next:Columns>
			<next:TopBar>
				<next:ToolBarItem symbol="->"></next:ToolBarItem>
				<next:ToolBarItem iconCls="undo" text="返回" handler="forReturn" />
			</next:TopBar>
			<% if(!searchType.equals("timeOutTask")){%>
				<next:BottomBar>
					<next:PagingToolBar displayMsg="从第{0}条到{1}条，一共{2}条" displayInfo="true" dataset="<%=dsType%>"/>
				</next:BottomBar>
			<%}%>
		</next:GridPanel>
		<% }%>
		<%}%>
	</next:Panel>
</next:ViewPort>
</body>
<script language="javascript"  type="text/javascript" >
var searchType ="<%=searchType%>";
var processId="<%=processId%>";
var isProcessEnd="<%=isProcessEnd%>";
var dsType="<%=dsType%>";



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
	if(processId == ""){
		L5.Msg.alert("提示：","流程实例参数不能为空!");
	}
	if(searchType == ""){
		L5.Msg.alert("提示：","检索类型参数不能为空!");
	}

	// 处理查询条件的状态
	var actStateObj = document.getElementById("actState");
	var actStateSelectedIndex = actStateObj.selectedIndex;
	var actState = actStateObj.options[actStateSelectedIndex].value;

	
	if(dsType == "allTaskDataSet"){
		actStateObj.options.remove(3);
	}else if(dsType == "endTaskDataSet"){
		actStateObj.disabled="true";
	}else if(dsType == "timeOutTaskDataSet"){
		actStateObj.options.remove(3);
	}else if(dsType == "timeOutEndTaskDataSet"){
		actStateObj.disabled="true";
	}else if(dsType == "daiBanTaskDataSet"){
		actStateObj.disabled="true";
	}
	
	
	// 查询全部任务
	if(searchType == "allTask"){
		if(isProcessEnd=="true"){
			endTaskDataSet.setParameter("processId",processId);
			endTaskDataSet.load();
		}else{
			allTaskDataSet.setParameter("processId",processId);
			allTaskDataSet.load();
		}
	}
	// 查询逾期任务
	if(searchType == "timeOutTask"){
		if(isProcessEnd=="true"){
			timeOutEndTaskDataSet.setParameter("processId",processId);
			timeOutEndTaskDataSet.load();
		}else{
			timeOutTaskDataSet.setParameter("processId",processId);
			timeOutTaskDataSet.load();
		}
	}
	// 查询待办任务
	if(searchType == "daiBanTask"){
		daiBanTaskDataSet.setParameter("processId",processId);
		daiBanTaskDataSet.load();
	}
}

//待办任务查询
function query(){
	var actDefName = document.getElementById("searchCondition").value;

	var actStateObj = document.getElementById("actState");
	var actStateSelectedIndex = actStateObj.selectedIndex;
	var actState = actStateObj.options[actStateSelectedIndex].value;

	if(dsType == "allTaskDataSet"){
		allTaskDataSet.setParameter("processId",processId);
		allTaskDataSet.setParameter("actDefName",actDefName);
		allTaskDataSet.setParameter("actState",actState);
		allTaskDataSet.load();
	}
	if(dsType == "endTaskDataSet"){
		endTaskDataSet.setParameter("processId",processId);
		endTaskDataSet.setParameter("actDefName",actDefName);
		endTaskDataSet.load();
	}
	if(dsType == "timeOutTaskDataSet"){
		timeOutTaskDataSet.setParameter("processId",processId);
		timeOutTaskDataSet.setParameter("actDefName",actDefName);
		timeOutTaskDataSet.setParameter("actState",actState);
		timeOutTaskDataSet.load();
	}
	if(dsType == "timeOutEndTaskDataSet"){
		timeOutEndTaskDataSet.setParameter("processId",processId);
		timeOutEndTaskDataSet.setParameter("actDefName",actDefName);
		timeOutEndTaskDataSet.load();
	}
	if(dsType == "daiBanTaskDataSet"){
		daiBanTaskDataSet.setParameter("processId",processId);
		daiBanTaskDataSet.setParameter("actDefName",actDefName);
		daiBanTaskDataSet.load();
	}
}

function forReturn(){
	var text='状态预览';
	var url = "jsp/query.jsp";
	L5.forward(url,text);
}

</script>
</html>