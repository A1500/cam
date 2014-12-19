<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="java.util.*"%>
<%@page import="org.loushang.workflow.tasklist.taskinfo.util.TaskListJspUtil"%>
<%@page import="org.loushang.workflow.processdefinition.tasklist.procsubjectdef.data.ProcSubjectDef"%>
<%@page import="org.loushang.workflow.processdefinition.tasklist.procsubjectdef.data.ProcSubjectQueryDef"%>
<%@page import="org.loushang.workflow.processdefinition.tasklist.procsubjectdef.data.ProcSubjectQueryCommonHelpDef"%>
<%@page import="org.loushang.workflow.processdefinition.tasklist.procsubjectdef.data.ProcSubjectQuerySelectDef"%>
<html>
<% 
	      String procDefUniqueId=request.getParameter("procDefUniqueId");
		  //任务标题
	      List procSubjectDefList=TaskListJspUtil.getProcSubjectDefListByProcDefUniqueId(procDefUniqueId);
		  //任务标题查询条件
	      List procSubjectQueryDefList=TaskListJspUtil.getProcSubjectQueryDefListByProcDefUniqueId(procDefUniqueId);
	       //通用帮助查询条件
	      List procSubjectQueryDefCommonHelpList=TaskListJspUtil.getProcSubjectQueryDefCommonHelpListByProcDefUniqueId(procDefUniqueId);
	      //下拉框信息
	      List procSubjectQueryDefSelectList=TaskListJspUtil.getProcSubjectQueryDefSelectListByProcDefUniqueId(procDefUniqueId);
%>
<body>
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
				                        procSubjectKey=procSubjectQueryDef.getSubjectKey();
				                        procSubjectAlias=procSubjectQueryDef.getSubjectAlias();
			                        	/*字段域类型，0代表文本框，1代表下拉框，2代表通用帮助，3代表日期，4代表日期时间，目前先处理0,3,4的显示，1,2以后完善*/
				                        String subjectFieldType=procSubjectQueryDef.getSubjectFieldType();
				                        if("0".equals(subjectFieldType)){//文本框
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
							
							
</body>		
