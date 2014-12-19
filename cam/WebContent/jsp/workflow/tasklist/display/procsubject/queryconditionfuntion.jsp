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
		  String dataset = (String)request.getParameter("dataset");
		  
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
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<script language="javascript"  type="text/javascript" >
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
	
	var dataset = '<%=dataset%>';
	<% 
	  String subjectKey;//标题关联表的字段名
	  String subjectFieldType;//用于判断查询类型
	  for(int i=0;i<procSubjectQueryDefList.size();i++)
	  {
		  ProcSubjectQueryDef procSubjectQueryDef=(ProcSubjectQueryDef)procSubjectQueryDefList.get(i);
		  subjectKey=procSubjectQueryDef.getSubjectKey();
		  subjectFieldType=procSubjectQueryDef.getSubjectFieldType();
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
		 	
		 	countText++;
		 	
		 }
		 if(queryCondition!=null&&queryCondition!="")
		 {
		 	if(dataset == "daiBanDataset"){
			 	daiBanDataset.setParameter("<%=subjectKey%>",queryCondition); 
			 }
			 else if(dataset == "yiBanDataset"){
			 	yiBanDataset.setParameter("<%=subjectKey%>",queryCondition); 
			 }
			  else if(dataset == "endDataset"){
			 	endDataset.setParameter("<%=subjectKey%>",queryCondition); 
			 }
		 }
	<%
	  }
	%>
	if(dataset == "daiBanDataset"){
		daiBanDataset.setParameter("procDefUniqueId","<%=procDefUniqueId%>");
		daiBanDataset.load();
	}
	else if(dataset == "yiBanDataset"){
		yiBanDataset.setParameter("procDefUniqueId","<%=procDefUniqueId%>");
		yiBanDataset.load();
	}
	else if(dataset == "endDataset"){
		endDataset.setParameter("procDefUniqueId","<%=procDefUniqueId%>");
		endDataset.load();
	}
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
</script>
</html>