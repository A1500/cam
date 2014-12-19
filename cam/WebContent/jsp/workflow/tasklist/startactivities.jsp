<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Map"%>
<HTML>
<HEAD>
<TITLE></TITLE>
<style>a{TEXT-DECORATION:none}</style>
<next:ScriptManager></next:ScriptManager>
</HEAD>
<BODY style="margin:10px;">
<form  name="frmList"  action="">
<div align="center">
<br>
<table width="50%"  borderColor="#3784c9" cellpadding="5" border="1" cellspacing="0" >  
<tr><button onclick="forReturn()">返回</button></tr>
<tr><td bgcolor="#CCDBEE" align="left">请选择起始环节:</td></tr>
<%
	String procDefUniqueId=request.getParameter("procDefUniqueId");
	List startActList=(List)request.getAttribute("startActList");
	if(startActList!=null){
		for(int i=0;i<startActList.size();i++){
		Map map=(Map)startActList.get(i);
		String actDefUniqueId=(String)map.get("actDefUniqueId");
		String actDefName=(String)map.get("actDefName");
		String procDefId=(String)map.get("procDefId");
%>
		<tr><td align="center"><a href="javascript:forNewTask('<%=actDefUniqueId %>','<%=procDefUniqueId %>')"><%=actDefName %></a></td></tr>
	<%}}
%>

</table>
</div>
</form>
</BODY>
<script language="javascript">
function forNewTask(actDefUniqueId,procDefUniqueId){   
	var url="command/dispatcher/org.loushang.workflow.tasklist.forward.TaskListDispatcherCmd/newTaskForward";
	var query="?procDefUniqueId="+procDefUniqueId+"&startActDefUniqueId="+actDefUniqueId;
	L5.forward(url+query,"办理");
}
function forReturn(){
    var url='jsp/workflow/tasklist/querynew.jsp';
    L5.forward(url,"新建任务");	
}
</script>
</HTML>
