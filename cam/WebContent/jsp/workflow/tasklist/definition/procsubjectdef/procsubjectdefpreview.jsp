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
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
	<head><style>a{TEXT-DECORATION:none}</style>
		<title>流程定义层次任务标题预览</title>
		<next:ScriptManager></next:ScriptManager>
	</head>
	    <% 
	      String procDefUniqueId=request.getParameter("procDefUniqueId");
	      String tabId = request.getParameter("tabId");//用于确定首先加载哪个tab页
		  if("".equals(tabId) || null == tabId){
		  	tabId = "daiBanTask";
		  }
		  int dispalyProcTab = 0;//0:待办 1:已办 2:办结
		 
		  if(tabId.equals("daiBanTask")){
		  	dispalyProcTab = 0;
		  }
		  else if(tabId.equals("yiBanTask")){
		  	dispalyProcTab = 1;
		  }
		  else if(tabId.equals("endTask")){
		  	dispalyProcTab = 2;
		  }
	       //待办任务标题
	      List procSubjectDefDaiBanList=TaskListJspUtil.getProcDaiBanTaskSubjectDefListByProcDefUniqueId(procDefUniqueId);
	       //已办任务标题
	      List procSubjectDefYiBanList=TaskListJspUtil.getProcYiBanTaskSubjectDefListByProcDefUniqueId(procDefUniqueId);
	       //办结任务标题
	      List procSubjectDefEndList=TaskListJspUtil.getProcEndTaskSubjectDefListByProcDefUniqueId(procDefUniqueId);
		  //待办任务标题查询条件
	      List procSubjectQueryDefDaiBanList=TaskListJspUtil.getProcDaiBanTaskSubjectQueryDefListByProcDefUniqueId(procDefUniqueId);
	       //已办任务标题查询条件
	      List procSubjectQueryDefYiBanList=TaskListJspUtil.getProcSubjectYiBanTaskProcSubjectQueryDefListByProcDefUniqueId(procDefUniqueId);
	       //办结任务标题查询条件
	      List procSubjectQueryDefEndList=TaskListJspUtil.getProcSubjectEndTaskProcSubjectQueryDefListByProcDefUniqueId(procDefUniqueId);
	      //通用帮助查询条件
	      List procSubjectQueryDefCommonHelpList=TaskListJspUtil.getProcSubjectQueryDefCommonHelpListByProcDefUniqueId(procDefUniqueId);
	      //下拉框信息
	      List procSubjectQueryDefSelectList=TaskListJspUtil.getProcSubjectQueryDefSelectListByProcDefUniqueId(procDefUniqueId);
        %>
<body>

<model:datasets>
	<model:dataset pageSize="15" id="procSubjectPreviewDaiBanDataset" cmd="org.loushang.workflow.processdefinition.tasklist.procsubjectdef.cmd.ProcSubjectDefQueryCmd" autoLoad="false" method="previewProcSubjectDaiBanTask" global="true">
		<model:record>
			<model:field name="procDefUniqueId" type="string" />
			<model:field name="procDefName" type="string" />
			<model:field name="procCreateTime" type="string" />
			<% 
			  for(int i=0;i<procSubjectDefDaiBanList.size();i++)
			  {
				  ProcSubjectDef procSubjectDef=(ProcSubjectDef)procSubjectDefDaiBanList.get(i);
			 %>
				<model:field name="<%=procSubjectDef.getSubjectKey()%>" type="string" />  
			<%
			  }
			%>
		</model:record>
	</model:dataset>
	<model:dataset pageSize="15" id="procSubjectPreviewYiBanDataset" cmd="org.loushang.workflow.processdefinition.tasklist.procsubjectdef.cmd.ProcSubjectDefQueryCmd" autoLoad="false" method="previewProcSubjectYiBanTask" global="true">
		<model:record>
			<model:field name="procDefUniqueId" type="string" />
			<model:field name="procDefName" type="string" />
			<model:field name="procCreateTime" type="string" />
			<% 
			  for(int i=0;i<procSubjectDefYiBanList.size();i++)
			  {
				  ProcSubjectDef procSubjectDef=(ProcSubjectDef)procSubjectDefYiBanList.get(i);
			 %>
				<model:field name="<%=procSubjectDef.getSubjectKey()%>" type="string" />  
			<%
			  }
			%>
		</model:record>
	</model:dataset>
	
	<model:dataset pageSize="15" id="procSubjectPreviewEndDataset" cmd="org.loushang.workflow.processdefinition.tasklist.procsubjectdef.cmd.ProcSubjectDefQueryCmd" autoLoad="false" method="previewProcSubjectEndTask" global="true">
		<model:record>
			<model:field name="procDefUniqueId" type="string" />
			<model:field name="procDefName" type="string" />
			<model:field name="procCreateTime" type="string" />
			<% 
			  for(int i=0;i<procSubjectDefEndList.size();i++)
			  {
				  ProcSubjectDef procSubjectDef=(ProcSubjectDef)procSubjectDefEndList.get(i);
			 %>
				<model:field name="<%=procSubjectDef.getSubjectKey()%>" type="string" />  
			<%
			  }
			%>
		</model:record>
	</model:dataset>
	
</model:datasets>

<next:TabPanel id="previewTabs" name="tabpanel-div" height="590" activeTab="<%=dispalyProcTab %>">
	<next:Tabs>
		<next:Defaults>{collapsible:true,split:true,animFloat:true,autoHide:true,useSplitTips:true,bodyStyle:'padding:6px;'}</next:Defaults>
		
			<next:Panel title="待办任务标题定义预览" id="daiBanTab">
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
									String procSubjectKey=null;
									String procSubjectAlias=null;
			                          for(int i=0;i<procSubjectQueryDefDaiBanList.size();i++)
			                          {
			                          	if(num%2==0&&num!=0){//一行最多有两个输入框
			                          		%>
			                          		</tr>
			                          		<tr>
			                          		<%
			                          	}
			                        	ProcSubjectQueryDef procSubjectQueryDef=(ProcSubjectQueryDef)procSubjectQueryDefDaiBanList.get(i);
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
						                     		<option value="selectNull">请选择</option>
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
			                         		procSubjectKeyCommonHelp = procSubjectKey+"DaiBan" + countHelp;
			                         		procSubjectKeyCommonHelpHidden = "conditionUseWayHidden"+"DaiBan" + countHelp;
			                         		countHelp++;
			                         		num++;
			                         		String procSubjectQueryDefId = procSubjectQueryDef.getId();//查询条件id
			                         		String subjectQueryDefUniqueId ;//查询字段定义唯一id
			                         		String dialogUrl;
			                         		String dialogWidth;
			                         		String dialogHeight;
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
									<td class="FieldButton" width="15%"><button  disabled="disabled">查询</button> </td>
								</tr>
							</table>
						</form>		
					</div>
				</fieldset>
				</next:Html>
				</next:Panel>
			<next:GridPanel id="procSubjectPreviewDaiBanGridPanel" name="procSubjectPreviewDaiBanGridPanel" anchor="100%" height="100%" dataset="procSubjectPreviewDaiBanDataset"     title="流程定义层次待办任务标题定义预览" notSelectFirstRow="true">
				<next:Columns>
	   				<next:RowNumberColumn width="30"/>
	    			<next:RadioBoxColumn></next:RadioBoxColumn>
					<next:Column id="procDefUniqueId" header="内码" field="procDefUniqueId" width="50" hidden="true" >
					  <next:TextField allowBlank="false"/>
					</next:Column>
					<% 
			        for(int i=0;i<procSubjectDefDaiBanList.size();i++)
			        {
				     ProcSubjectDef procSubjectDef=(ProcSubjectDef)procSubjectDefDaiBanList.get(i);
			        %>
				   	<next:Column header="<%=procSubjectDef.getSubjectAlias()%>" field="<%=procSubjectDef.getSubjectKey()%>" width="<%=procSubjectDef.getSubjectWidth()%>">
						<next:TextField allowBlank="false"/>
					</next:Column>
			        <%
			         }
			        %>
					<next:Column header="流程名称" field="procDefName" width="150">
						<next:TextField allowBlank="false"/>
					</next:Column>
					<next:Column header="流程创建时间" field="procCreateTime" width="150" >
						<next:TextField allowBlank="false"/>
					</next:Column>	
				</next:Columns>
				<next:TopBar>	
					<next:ToolBarItem symbol="->"></next:ToolBarItem>		
					<next:ToolBarItem iconCls="undo"  text="返回" handler="backToProcSubjectDefList"/>
				</next:TopBar>
				<next:BottomBar>
					<next:PagingToolBar displayMsg="从第{0}条到{1}条，一共{2}条" displayInfo="true" dataset="procSubjectPreviewDaiBanDataset"/>
				</next:BottomBar>
			</next:GridPanel>
			
			</next:AnchorLayout>
			</next:Panel>
		
		
		<next:Panel title="已办任务标题定义预览" id="yiBanTab">
			
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
									String procSubjectKey=null;
									String procSubjectAlias=null;
			                          for(int i=0;i<procSubjectQueryDefYiBanList.size();i++)
			                          {
			                          	if(num%2==0&&num!=0){//一行最多有两个输入框
			                          		%>
			                          		</tr>
			                          		<tr>
			                          		<%
			                          	}
			                        	ProcSubjectQueryDef procSubjectQueryDef=(ProcSubjectQueryDef)procSubjectQueryDefYiBanList.get(i);
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
						                     		<option value="selectNull">请选择</option>
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
			                         		procSubjectKeyCommonHelp = procSubjectKey+"YiBan" + countHelp;
			                         		procSubjectKeyCommonHelpHidden = "conditionUseWayHidden"+"YiBan" + countHelp;
			                         		countHelp++;
			                         		num++;
			                         		String procSubjectQueryDefId = procSubjectQueryDef.getId();//查询条件id
			                         		String subjectQueryDefUniqueId ;//查询字段定义唯一id
			                         		String dialogUrl;
			                         		String dialogWidth;
			                         		String dialogHeight;
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
									<td class="FieldButton" width="15%"><button  disabled="disabled">查询</button> </td>
								</tr>
							</table>
						</form>		
					</div>
				</fieldset>
				</next:Html>
			</next:Panel>
			<next:GridPanel id="procSubjectPreviewYiBanGridPanel" name="procSubjectPreviewYiBanGridPanel" anchor="100%" height="100%" dataset="procSubjectPreviewYiBanDataset"     title="流程定义层次已办任务标题定义预览" notSelectFirstRow="true">
				<next:Columns>
	   				<next:RowNumberColumn width="30"/>
	    			<next:RadioBoxColumn></next:RadioBoxColumn>
					<next:Column id="procDefUniqueId" header="内码" field="procDefUniqueId" width="50" hidden="true" >
					  <next:TextField allowBlank="false"/>
					</next:Column>
					<% 
			        for(int i=0;i<procSubjectDefYiBanList.size();i++)
			        {
				     ProcSubjectDef procSubjectDef=(ProcSubjectDef)procSubjectDefYiBanList.get(i);
			        %>
				   	<next:Column header="<%=procSubjectDef.getSubjectAlias()%>" field="<%=procSubjectDef.getSubjectKey()%>" width="<%=procSubjectDef.getSubjectWidth()%>">
						<next:TextField allowBlank="false"/>
					</next:Column>
			        <%
			         }
			        %>
					<next:Column header="流程名称" field="procDefName" width="150">
						<next:TextField allowBlank="false"/>
					</next:Column>
					<next:Column header="流程创建时间" field="procCreateTime" width="150" >
						<next:TextField allowBlank="false"/>
					</next:Column>	
				</next:Columns>
				<next:TopBar>	
					<next:ToolBarItem symbol="->"></next:ToolBarItem>		
					<next:ToolBarItem iconCls="undo"  text="返回" handler="backToProcSubjectDefList"/>
				</next:TopBar>
				<next:BottomBar>
					<next:PagingToolBar displayMsg="从第{0}条到{1}条，一共{2}条" displayInfo="true" dataset="procSubjectPreviewYiBanDataset"/>
				</next:BottomBar>
			</next:GridPanel>
			</next:AnchorLayout>
		</next:Panel>
		
		<next:Panel title="办结任务标题定义预览" id="endTab">
				
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
									String procSubjectKey=null;
									String procSubjectAlias=null;
			                          for(int i=0;i<procSubjectQueryDefEndList.size();i++)
			                          {
			                          	if(num%2==0&&num!=0){//一行最多有两个输入框
			                          		%>
			                          		</tr>
			                          		<tr>
			                          		<%
			                          	}
			                        	ProcSubjectQueryDef procSubjectQueryDef=(ProcSubjectQueryDef)procSubjectQueryDefEndList.get(i);
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
						                     		<option value="selectNull">请选择</option>
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
			                         		procSubjectKeyCommonHelp = procSubjectKey +"End"+ countHelp;
			                         		procSubjectKeyCommonHelpHidden = "conditionUseWayHidden"+"End" + countHelp;
			                         		countHelp++;
			                         		num++;
			                         		String procSubjectQueryDefId = procSubjectQueryDef.getId();//查询条件id
			                         		String subjectQueryDefUniqueId ;//查询字段定义唯一id
			                         		String dialogUrl;
			                         		String dialogWidth;
			                         		String dialogHeight;
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
									<td class="FieldButton" width="15%"><button  disabled="disabled">查询</button> </td>
								</tr>
							</table>
						</form>		
					</div>
				</fieldset>
				</next:Html>
			</next:Panel>
			<next:GridPanel id="procSubjectPreviewEndGridPanel" name="procSubjectPreviewEndGridPanel" anchor="100%" height="100%" dataset="procSubjectPreviewEndDataset"     title="流程定义层次办结任务标题定义预览" notSelectFirstRow="true">
				<next:Columns>
	   				<next:RowNumberColumn width="30"/>
	    			<next:RadioBoxColumn></next:RadioBoxColumn>
					<next:Column id="procDefUniqueId" header="内码" field="procDefUniqueId" width="50" hidden="true" >
					  <next:TextField allowBlank="false"/>
					</next:Column>
					<% 
			        for(int i=0;i<procSubjectDefEndList.size();i++)
			        {
				     ProcSubjectDef procSubjectDef=(ProcSubjectDef)procSubjectDefEndList.get(i);
			        %>
				   	<next:Column header="<%=procSubjectDef.getSubjectAlias()%>" field="<%=procSubjectDef.getSubjectKey()%>" width="<%=procSubjectDef.getSubjectWidth()%>">
						<next:TextField allowBlank="false"/>
					</next:Column>
			        <%
			         }
			        %>
					<next:Column header="流程名称" field="procDefName" width="150">
						<next:TextField allowBlank="false"/>
					</next:Column>
					<next:Column header="流程创建时间" field="procCreateTime" width="150" >
						<next:TextField allowBlank="false"/>
					</next:Column>	
				</next:Columns>
				<next:TopBar>
					<next:ToolBarItem symbol="->"></next:ToolBarItem>			
					<next:ToolBarItem iconCls="undo"  text="返回" handler="backToProcSubjectDefList"/>
				</next:TopBar>
				<next:BottomBar>
					<next:PagingToolBar displayMsg="从第{0}条到{1}条，一共{2}条" displayInfo="true" dataset="procSubjectPreviewEndDataset"/>
				</next:BottomBar>
			</next:GridPanel>
			</next:AnchorLayout>
		</next:Panel>		
		
	</next:Tabs>
</next:TabPanel>
</body>
<script language="javascript"  type="text/javascript" >
var isDaiBanInit = false;
var isYiBanInit = false;
var isEndInit = false;
function init()
{
	var tabId = '<%=tabId%>';
	if (tabId == "daiBanTask"){
		isDaiBanInit = true;
		procSubjectPreviewDaiBanDataset.setParameter("procDefUniqueId","<%=procDefUniqueId%>");
		procSubjectPreviewDaiBanDataset.load();
	}
	if (tabId == "yiBanTask"){
		isYiBanInit = true;
		procSubjectPreviewYiBanDataset.setParameter("procDefUniqueId","<%=procDefUniqueId%>");
		procSubjectPreviewYiBanDataset.load();
	}
	if (tabId == "endTask"){
		isEndInit = true;
		procSubjectPreviewEndDataset.setParameter("procDefUniqueId","<%=procDefUniqueId%>");
		procSubjectPreviewEndDataset.load();
	}
	var tabpanel = L5.getCmp("previewTabs");
	tabpanel.on("tabchange", loadTab);
}
function loadTab(tabpanels, tab)
{
	//只有在初始化后切换到数据权限页面才加载用户的数据权限
	if(isDaiBanInit == false){
		if(tab.id == "daiBanTab"){
			isDaiBanInit = true;
			procSubjectPreviewDaiBanDataset.setParameter("procDefUniqueId","<%=procDefUniqueId%>");
			procSubjectPreviewDaiBanDataset.load();
		}
	}
	//只有在初始化后切换到数据权限页面才加载用户的数据权限
	if(isYiBanInit == false){
		if(tab.id == "yiBanTab"){
			isYiBanInit = true;
			procSubjectPreviewYiBanDataset.setParameter("procDefUniqueId","<%=procDefUniqueId%>");
			procSubjectPreviewYiBanDataset.load();
		}
	}
	//只有在初始化后切换到数据权限页面才加载用户的数据权限
	if(isEndInit == false){
		if(tab.id == "endTab"){
			isEndInit = true;
			procSubjectPreviewEndDataset.setParameter("procDefUniqueId","<%=procDefUniqueId%>");
			procSubjectPreviewEndDataset.load();
		}
	}
}


function backToProcSubjectDefList()
{
	window.history.go(-1);
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