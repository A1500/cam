<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<html>
<head>
<next:ScriptManager ></next:ScriptManager>
</head>
<body>
<% 
	String formId=request.getParameter("formId");
	String actDefUniqueId=request.getParameter("actDefUniqueId");
	String procDefUniqueId=request.getParameter("procDefUniqueId");
	String actDefId=request.getParameter("actDefId");
%>
<script>
function init(){
	var queryStr="<%=request.getQueryString()%>";
	var primalPath=document.URL.split('?');
	if(primalPath.length>1){
		if(queryStr!=primalPath[1]){
			queryStr+="&";
			queryStr+=primalPath[1];
		}
	}
	var actDefUniqueId='<%=actDefUniqueId%>';
	var cmd=new L5.Command("org.loushang.workflow.ecgapform.formrender.cmd.FormRenderCmd");
	cmd.setParameter("formId",'<%=formId%>');
	cmd.setParameter("actDefUniqueId",'<%=actDefUniqueId%>');
	cmd.setParameter("procDefUniqueId",'<%=procDefUniqueId%>');
	cmd.setParameter("actDefId",'<%=actDefId%>');
	cmd.execute("forward");
	if(!cmd.error){
		var isMultiFormRef=cmd.getReturn("isMultiFormRef");
		if(isMultiFormRef=="true")
		{
			if(actDefUniqueId=="null"||actDefUniqueId==""||actDefUniqueId=="undefined"||actDefUniqueId==undefined)
			{
				actDefUniqueId=cmd.getReturn("actDefUniqueId");
				L5.forward("jsp/workflow/ecgapform/multiformrender.jsp?"+queryStr+"&actDefUniqueId="+actDefUniqueId,"多表单页面");
			}
			else
			{
				L5.forward("jsp/workflow/ecgapform/multiformrender.jsp?"+queryStr,"多表单页面");
			}
		}
		else
		{
			var path=cmd.getReturn("jspPath");
			L5.forward(path+"?"+queryStr,cmd.getReturn("caption"));
		}
	}else{
		alert(cmd.error);
	}
}
</script>
</body>
</html>