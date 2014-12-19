<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="java.util.*"%>
<%@page import="org.loushang.workflow.tasklist.taskinfo.util.TaskListJspUtil"%>
<%@page import="org.loushang.workflow.processdefinition.tasklist.procsubjectdef.data.ProcSubjectDef"%>
<%@page import="org.loushang.workflow.processdefinition.tasklist.procsubjectdef.data.ProcSubjectQueryDef"%>
<%@page import="org.loushang.workflow.processdefinition.tasklist.procsubjectdef.data.ProcSubjectQueryCommonHelpDef"%>
<%@page import="org.loushang.workflow.processdefinition.tasklist.procsubjectdef.data.ProcSubjectQuerySelectDef"%>

<html>
	<head><style>a{TEXT-DECORATION:none}</style>
		<title>已办任务详细信息查询</title>
		<next:ScriptManager></next:ScriptManager>
		<script type="text/javascript" src="../../tasklistcommon.js"></script>
	    <% 
	  //taskListType="0"是直接进入详细界面，界面没有返回按钮；taskListType="1"由概要信息界面进入界面，界面显示返回按钮。
	    String taskListType = request.getParameter("taskListType");
		if(taskListType==null||"".equals(taskListType)){
			taskListType="1";
		}
	      String procDefUniqueId=request.getParameter("procDefUniqueId");
		  //任务标题
	      List procSubjectDefList=TaskListJspUtil.getProcYiBanTaskSubjectDefListByProcDefUniqueId(procDefUniqueId);
		  //任务标题查询条件
	      List procSubjectQueryDefList=TaskListJspUtil.getProcSubjectYiBanTaskProcSubjectQueryDefListByProcDefUniqueId(procDefUniqueId);
	       //通用帮助查询条件
	      List procSubjectQueryDefCommonHelpList=TaskListJspUtil.getProcSubjectQueryDefCommonHelpListByProcDefUniqueId(procDefUniqueId);
	      //下拉框信息
	      List procSubjectQueryDefSelectList=TaskListJspUtil.getProcSubjectQueryDefSelectListByProcDefUniqueId(procDefUniqueId);
         %>

	</head>
<body>

<model:datasets>
	<model:dataset pageSize="10" id="yiBanDataset" cmd="org.loushang.workflow.tasklist.taskinfo.cmd.YiBanTaskQueryCmd" autoLoad="false" method="queryProcYiBanTaskTableDetailInfo" global="true">
		<model:record>
			<model:field name="assignmentId" type="string" />
			
			<model:field name="primaryKey" type="string" />
			<% 
			if(null != procSubjectDefList && !procSubjectDefList.isEmpty() && procSubjectDefList.size() > 0){
			  for(int i=0;i<procSubjectDefList.size();i++)
			  {
				  ProcSubjectDef procSubjectDef=(ProcSubjectDef)procSubjectDefList.get(i);
			 %>
				<model:field name="<%=procSubjectDef.getSubjectKey()%>" type="string" />  
			<%
				
			  }
			 }else{
			%>
				<model:field name="activeActDefNames" type="string" />
				<model:field name="activeOrganNames" type="string" />
				<model:field name="actDefName" type="string" />
				<model:field name="endTime" type="string" />
				<model:field name="procCreateTime" type="string" />
				<model:field name="procDefName" type="string" />
			<% 
			}%>
			
		</model:record>
	</model:dataset>
</model:datasets>

<next:ViewPort>
	<next:BorderLayout>
		<next:Defaults>{collapsible:true,split:true,animFloat:true,autoHide:true,useSplitTips:true,bodyStyle:'padding:6px;'}</next:Defaults>
		<next:Center floatable="true" cmargins="0 0 0 0" margins="0 0 0 0" >
			<next:Panel>
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
									int num=0;//控制转行
									int countDate=1;//记录查询条件中，日期的个数，用于组装id，为了区分多个标题关联同一个数据库表的字段
	      							int countTime=1;//记录查询条件中，时间的个数，用于组装id，为了区分多个标题关联同一个数据库表的字段
	      							int countText=1;//记录查询条件中，文本框的个数，用于组装id，为了区分多个标题关联同一个数据库表的字段
	      							int countHelp=1;//记录查询条件中，通用帮助框的个数，用于组装id，为了区分多个标题关联同一个数据库表的字段
									String procSubjectKeyBegin=null;//日期\时间的id值，用于组装,开始时间
									String procSubjectKeyEnd=null;//日期\时间的id值，用于组装,结束时间
									String procSubjectKeyText=null;//文本框的id值，用于组装
									String procSubjectKeyCommonHelp=null;//通用帮助框的id值，用于组装，作为返回显示值
									String procSubjectKeyCommonHelpHidden=null;//通用帮助框隐藏域的id值，用于组装,作为返回值
									String conditionUseWayIdHidden=null;//通用帮助框中查询条件使用方式id，用于组装，隐藏域，查询时使用
									String procSubjectKey=null;
									String procSubjectAlias=null;
			                          for(int i=0;i<procSubjectQueryDefList.size();i++)
			                          {
			                          	if(num%2==0&&num!=0){//一行最多有两个输入框
			                          		%>
			                          		</tr>
			                          		<tr>
			                          		<%
			                          	}
			                        	ProcSubjectQueryDef procSubjectQueryDef=(ProcSubjectQueryDef)procSubjectQueryDefList.get(i);
				                        if(null == procSubjectQueryDef.getId()){
			                        		procSubjectQueryDef.setId("");
			                        	}
				                        procSubjectKey=procSubjectQueryDef.getSubjectKey();
				                        procSubjectAlias=procSubjectQueryDef.getSubjectAlias();
			                        	/*字段域类型，0代表文本框，1代表下拉框，2代表通用帮助，3代表日期，4代表日期时间，目前先处理0,3,4的显示，1,2以后完善*/
				                        String subjectFieldType=procSubjectQueryDef.getSubjectFieldType();
				                        if("0".equals(subjectFieldType) || null == subjectFieldType || "".equals(subjectFieldType)){//文本框
				                        	procSubjectKeyText = procSubjectKey + countText;
			                         		countText++;
			                         		
				                        	num++;
					                         %>
					                          <td class="FieldLabel" width="15%" ><%=procSubjectAlias%>：</td>
						                     <td class="FieldInput"><input type="text"  id="<%=procSubjectKeyText%>" class="TextEditor" title="<%=procSubjectAlias%>"  size="40"/></td>
					                         <%
			                         	}
			                         	else if("1".equals(subjectFieldType)){//下拉框
			                         		String procSubjectQueryDefId = procSubjectQueryDef.getId();//查询条件id
			                         		
			                         		num++;
			                         		 %>
					                          <td class="FieldLabel" width="15%" ><%=procSubjectAlias%>：</td>
						                     <td class="FieldInput">
						                     	<select name="<%=procSubjectKey %>" >
						                     		<option value="">请选择</option>
						                     <%
						                     		String subjectQueryDefUniqueId;
						                     		String optionValue;
						                     		String optionText;
						                     		for(int s=0;s<procSubjectQueryDefSelectList.size();s++){
						                     			ProcSubjectQuerySelectDef procSubjectQuerySelectDef = (ProcSubjectQuerySelectDef)procSubjectQueryDefSelectList.get(s);
						                     			subjectQueryDefUniqueId = procSubjectQuerySelectDef.getSubjectQueryDefUniqueId();
						                     			if(subjectQueryDefUniqueId.equals(procSubjectQueryDefId)){
						                     				optionValue = procSubjectQuerySelectDef.getOptionValue();
						                     				optionText = procSubjectQuerySelectDef.getOptionText();
						                      %>
						                     				<option value="<%=optionValue %>"><%=optionText %></option>
						                     <%
						                     			}
						                     		}
						                      %>		
						                     		
						                     	</select>
						                     </td>
					                         <%
			                         	}
			                         	else if("2".equals(subjectFieldType)){//通用帮助定义
			                         		procSubjectKeyCommonHelp = procSubjectKey + countHelp;
			                         		procSubjectKeyCommonHelpHidden = "conditionUseWayHidden" + countHelp;
			                         		conditionUseWayIdHidden = "conditionUseWay" + countHelp;
			                         		countHelp++;
			                         		num++;
			                         		String procSubjectQueryDefId = procSubjectQueryDef.getId();//查询条件id
			                         		String subjectQueryDefUniqueId ;//查询字段定义唯一id
			                         		String dialogUrl;
			                         		String dialogWidth;
			                         		String dialogHeight;
			                         		String conditionUseWay;
			                         		int keyReturnIndex,aliasReturnIndex;
			                         		for(int j=0;j<procSubjectQueryDefCommonHelpList.size();j++){
			                         			ProcSubjectQueryCommonHelpDef procSubjectQueryCommonHelpDef = (ProcSubjectQueryCommonHelpDef)procSubjectQueryDefCommonHelpList.get(j);
			                         			subjectQueryDefUniqueId = procSubjectQueryCommonHelpDef.getSubjectQueryDefUniqueId();
			                         			if(procSubjectQueryDefId.equals(subjectQueryDefUniqueId)){
			                         				dialogUrl = procSubjectQueryCommonHelpDef.getDialogUrl();
			                         				dialogWidth = procSubjectQueryCommonHelpDef.getDialogWidth();
			                         				dialogHeight = procSubjectQueryCommonHelpDef.getDialogHeight();
			                         				keyReturnIndex = procSubjectQueryCommonHelpDef.getKeyReturnIndex();
			                         				aliasReturnIndex = procSubjectQueryCommonHelpDef.getAliasReturnIndex();
				                         		%>
				                         		 <input type="hidden" id="<%=procSubjectKeyCommonHelpHidden %>" value=""/>
				                         		 <td class="FieldLabel" width="15%" ><%=procSubjectAlias%>：</td>
							                     <td class="FieldInput"><input type="text"  id="<%=procSubjectKeyCommonHelp%>" value="" class="TextEditor" title="<%=procSubjectAlias%>"  size="40"/>
							                     <img src="<%=SkinUtils.getImage(request,"l5/liulan.gif")%>" onclick="CommonHelpDef('<%=dialogUrl %>','<%=dialogWidth %>','<%=dialogHeight %>','<%=keyReturnIndex %>','<%=aliasReturnIndex %>','<%=procSubjectKeyCommonHelpHidden %>','<%=procSubjectKeyCommonHelp%>');"/>
							                     </td>
				                         		<%
				                         		}
				                         	}
			                         	}
			                         	else if("3".equals(subjectFieldType)){//日期
			                         		procSubjectKeyBegin = procSubjectKey + "DateBegin"+countDate;//组装id
			                         		procSubjectKeyEnd = procSubjectKey + "DateEnd"+countDate;//组装id
			                         		countDate++;
			                         		
			                         		num++;
			                         		
			                         			%>
					                         <td class="FieldLabel" width="15%"><%=procSubjectAlias%>：</td>
					                         <td class="FieldInput">
						                         <input type="text" id="<%=procSubjectKeyBegin %>" format="Ymd" class="TextEditor" title="<%=procSubjectAlias%>"  size="40" onclick="LoushangDatetime(this)"/>				                      
						                      	至
						                         <input type="text" id="<%=procSubjectKeyEnd %>" format="Ymd" class="TextEditor" title="<%=procSubjectAlias%>"  size="40" onclick="LoushangDatetime(this)"/>
					                          </td>
					                          <%
			                          	}
			                          	else if("4".equals(subjectFieldType)){//时间
			                          		procSubjectKeyBegin = procSubjectKey + "TimeBegin" + countTime;//组装id
			                         		procSubjectKeyEnd = procSubjectKey + "TimeEnd" + countTime;//组装id
			                         		countTime++;
			                         		
			                          		num++;
			                         			%>
					                          <td class="FieldLabel" width="15%"><%=procSubjectAlias%>：</td>
					                          <td class="FieldInput">
						                          <input type="text" id="<%=procSubjectKeyBegin %>" format="Ymd H:i:s" class="TextEditor" title="<%=procSubjectAlias%>"  size="40" onclick="LoushangDatetime(this)"/>
						                     	至
						                          <input type="text" id="<%=procSubjectKeyEnd %>" format="Ymd H:i:s" class="TextEditor" title="<%=procSubjectAlias%>"  size="40" onclick="LoushangDatetime(this)"/>
					                          </td>
					                         <%
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
			<next:GridPanel id="yiBanTaskGridPanel" name="yiBanTaskGridPanel" anchor="100%" height="100%" dataset="yiBanDataset"     title="已办任务详细信息列表" notSelectFirstRow="true">
				<next:Columns>
	   				<next:RowNumberColumn width="30"/>
	    			<next:RadioBoxColumn></next:RadioBoxColumn>
					<next:Column id="assignmentId" header="内码" field="assignmentId" width="50" hidden="true" >
					<next:TextField allowBlank="false"/>
					</next:Column>
					<% if(null != procSubjectDefList && !procSubjectDefList.isEmpty() && procSubjectDefList.size() > 0){
						boolean sortAble = false;
				        for(int i=0;i<procSubjectDefList.size();i++)
				        {
					     ProcSubjectDef procSubjectDef=(ProcSubjectDef)procSubjectDefList.get(i);					    
			        %>
				   	<next:Column header="<%=procSubjectDef.getSubjectAlias()%>" field="<%=procSubjectDef.getSubjectKey()%>" width="<%=procSubjectDef.getSubjectWidth()%>" sortable="true">
						<next:TextField allowBlank="false"/>
					</next:Column>
			        <%
			         }
			        }else{
			        %>
			        	
			        	<next:Column id="procDefName" header="流程名称" field="procDefName" width="150" sortable="true">
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="procCreateTime" header="流程发起时间" field="procCreateTime" width="150" sortable="true">
							<next:TextField allowBlank="false"/>
						</next:Column>						
						<next:Column id="actDefName" header="已办环节" field="actDefName" width="150" sortable="true">
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="endTime" header="任务完成时间" field="endTime" width="150" sortable="true">
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="activeActDefNames" header="当前活动环节" field="activeActDefNames" width="150" sortable="true">
							<next:TextField allowBlank="false"/>
						</next:Column>
						<next:Column id="activeOrganNames" header="当前活动环节处理人" field="activeOrganNames" width="150" sortable="true">
							<next:TextField allowBlank="false"/>
						</next:Column>						
			        <%
			        } %>
					
					<next:Column header="业务主键" field="primaryKey" width="150" hidden="true">
						<next:TextField allowBlank="false"/>
					</next:Column>	
				</next:Columns>
				<next:TopBar>	
					<next:ToolBarItem symbol="->"></next:ToolBarItem>		
					<next:ToolBarItem iconCls="select"  text="查看" handler="handle"/>
					<next:ToolBarItem iconCls="detail"  text="查看流转状态" handler="showState"/>
					<%if("1".equals(taskListType)){%>
							<next:ToolBarItem iconCls="undo" text="返回" handler="backToProfileInfo" />
							<%} %>
				</next:TopBar>
				<next:BottomBar>
					<next:PagingToolBar displayMsg="从第{0}条到{1}条，一共{2}条" displayInfo="true" dataset="yiBanDataset"/>
				</next:BottomBar>
			</next:GridPanel>
			</next:AnchorLayout>
			</next:Panel>
		</next:Center>
	</next:BorderLayout>
</next:ViewPort>
</body>
<%
	String path = request.getContextPath();
	String basePath;
	if (80 == request.getServerPort()) {
		basePath = request.getScheme() + "://"
			+ request.getServerName()
			+ path + "/";
	} else {
		basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	}
%>
<script language="javascript"  type="text/javascript" >
function init()
{
	yiBanDataset.setParameter("procDefUniqueId","<%=procDefUniqueId%>");
	yiBanDataset.load();
}

//办结任务详细查询
function query(dataset)
{
	var countDate = 1;//用于获取日期id
	var countTime = 1;//用于获取时间id
	var countText = 1;//用于获取文本框id
	var countHelp = 1;//用于获取通用帮助id
	
	var procSubjectKeyBegin;//开始日期\时间id
	var procSubjectKeyEnd;//结束日期\时间id
	var procSubjectKeyText;//文本框id
	var procSubjectKeyCommonHelp;//通用帮助id
	var procSubjectKeyCommonHelpHidden;//通用帮助隐藏域id
	var conditionUseWayIdHidden;//查询条件使用方式id
	
	var queryCondition;//查询条件
	var queryCondition1;//开始时间\日期
	var queryCondition2;//截止时间\日期
	var subjectFieldType；//用于判断查询类型
	var subjectKey;//标题关联表的字段名
	var conditionUseWay;//查询条件使用方式 0:使用返回值1:使用返回显示值
	
	var subjectCategory;//标题类型 0：业务信息 1：流程信息
	<% 
	  String subjectKey;//标题关联表的字段名
	  String subjectFieldType;//用于判断查询类型
	  for(int i=0;i<procSubjectQueryDefList.size();i++)
	  {
		  ProcSubjectQueryDef procSubjectQueryDef=(ProcSubjectQueryDef)procSubjectQueryDefList.get(i);
		   if(null == procSubjectQueryDef.getId()){
			procSubjectQueryDef.setId("");
		  }
		  subjectKey=procSubjectQueryDef.getSubjectKey();
		  subjectFieldType=procSubjectQueryDef.getSubjectFieldType();
		  if(null == subjectFieldType || "".equals(subjectFieldType)){
			subjectFieldType = "0";
		  }
	 %>
		 /**
		 *根据字段域类型获得查询条件。若为日期或时间，需要把表示为时间段的前后两个时间组装称，时间1#时间2的形式，在后台分割
		 */
		 subjectKey = "<%=subjectKey%>";
		 subjectFieldType = <%=subjectFieldType%>;
		 if("3"==subjectFieldType){//日期
			procSubjectKeyBegin = subjectKey + "DateBegin"+countDate;//获得id
			procSubjectKeyEnd = subjectKey + "DateEnd"+countDate;//获得id
			
		 	queryCondition1=document.getElementById(procSubjectKeyBegin).value;
		 	queryCondition2=document.getElementById(procSubjectKeyEnd).value;
		 	queryCondition=queryCondition1+"#"+queryCondition2;//组装日期
		 	
		 	countDate++;
		 }
		 else if("4"==subjectFieldType){//时间
		 	procSubjectKeyBegin = subjectKey + "TimeBegin" + countTime;//组装id
			procSubjectKeyEnd = subjectKey + "TimeEnd" + countTime;//组装id
			
		 	queryCondition1=document.getElementById(procSubjectKeyBegin).value;
		 	queryCondition2=document.getElementById(procSubjectKeyEnd).value;
		 	queryCondition=queryCondition1+"#"+queryCondition2;//组装时间
		 	
		 	countTime++;
		 }
		 else if("1"==subjectFieldType){//下拉框
		 	queryCondition=document.getElementById(subjectKey).value;
		 	
		 }
		 else if("2"==subjectFieldType){//通用帮助定义
		 <%
		 	String subjectQueryDefUniqueId;
		 	String conditionUseWay;
		 	String procSubjectQueryDefId = procSubjectQueryDef.getId();//查询条件id;
		 	for(int j=0;j<procSubjectQueryDefCommonHelpList.size();j++){
			     ProcSubjectQueryCommonHelpDef procSubjectQueryCommonHelpDef = (ProcSubjectQueryCommonHelpDef)procSubjectQueryDefCommonHelpList.get(j);
			     subjectQueryDefUniqueId = procSubjectQueryCommonHelpDef.getSubjectQueryDefUniqueId();
			     if(procSubjectQueryDefId.equals(subjectQueryDefUniqueId)){
			     	conditionUseWay = procSubjectQueryCommonHelpDef.getConditionUseWay();
		 %>
		 	var conditionUseWay = <%=conditionUseWay%>;
		 	procSubjectKeyCommonHelp = subjectKey + countHelp;
		 	var commonHelpDisplay = document.getElementById(procSubjectKeyCommonHelp).value;
		 	if(conditionUseWay == "0"){//0:使用返回值
		 		procSubjectKeyCommonHelpHidden = "conditionUseWayHidden" + countHelp;
		 		if(commonHelpDisplay == null || commonHelpDisplay == ""){//判断返回显示值是否被清空，是则查询条件为空
		 			queryCondition = "";
		 		}else{//否则使用返回值作为查询条件
		 			queryCondition = document.getElementById(procSubjectKeyCommonHelpHidden).value;
		 		}
		 	}else{//1:使用返回显示值
		 		queryCondition = commonHelpDisplay;
		 	}
		 	countHelp++;
		 <%
		 		}
		 	}
		 %>
		 }
		 else if("0"==subjectFieldType){//文本框或其他
		 	procSubjectKeyText = subjectKey + countText;//组装id
		 	queryCondition=document.getElementById(procSubjectKeyText).value;
		 	if(queryCondition.indexOf("'")!=-1){
		 		  L5.Msg.alert("提示", "不接受单引号输入!");
		 		  return;
		 	}
		 	countText++;
		 	
		 }
		 if(queryCondition!=null&&queryCondition!="")
		 {
			 subjectCategory = '<%=procSubjectQueryDef.getSubjectCategory()%>';
		 	if(subjectCategory == "0"){
		 		queryCondition = "bizTable"+queryCondition;
		 	}else{
		 		queryCondition = "procTable"+queryCondition;
		 	}
			 yiBanDataset.setParameter("<%=subjectKey%>",queryCondition); 
			 
		 }
	<%
	  }
	%>
		yiBanDataset.setParameter("procDefUniqueId","<%=procDefUniqueId%>");
		yiBanDataset.load();

}

//设置通用帮助框，弹出对话框设置
function CommonHelpDef(dialogUrl,dialogWidth,dialogHeight,keyReturnIndex,aliasReturnIndex,procSubjectKeyCommonHelpHidden,procSubjectKeyCommonHelp){
		var dialogMsg = "scroll:yes;status:no;dialogWidth:"; //弹出框设置信息
		dialogMsg += dialogWidth + ";dialogHeight:" + dialogHeight;
		var scheme = dialogUrl.substring(0,7);
		if(scheme.toLowerCase() != "http://"){//判断Url是否绝对地址
			dialogUrl = '<%=path%>' + "/" + dialogUrl;
		}
		var win = showModalDialog(dialogUrl,window,dialogMsg); //弹出框
		
		if (!win) {  
         return;
	    }
	    var commonHelpReturn = win[keyReturnIndex];//返回值
	    var commonHelpReturnDisplay = win[aliasReturnIndex];//返回显示值
	    document.getElementById(procSubjectKeyCommonHelpHidden).value = commonHelpReturn;
	    document.getElementById(procSubjectKeyCommonHelp).value = commonHelpReturnDisplay;
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
    var backUrl="jsp/workflow/tasklist/display/procsubject/queryyibandetailinfo.jsp";
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
	var url="jsp/workflow/tasklist/display/procsubject/queryyibanprofileinfo.jsp";
	L5.forward(url,"已办任务概要信息查询");
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
</script>

</html>