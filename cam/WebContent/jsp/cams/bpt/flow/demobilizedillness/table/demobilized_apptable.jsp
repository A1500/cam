<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
<head>
<title>山东省带病回乡退伍军人审批表</title>
<next:ScriptManager />
		<script>
			var peopleId="<%=request.getParameter("peopleId")%>";
		</script>
<script type="text/javascript" src="demobilized_apptable.js"></script>
</head>
<body>
<input type="hidden" id="docpath" value="jsp/cams/bpt/flow/demobilizedillness/table/demobilized_apptable.doc"/>
<input type="hidden" id="peopleId" name="printQuery" queryData="queryData" value="<%=request.getParameter("peopleId")%>"/>
<input type="hidden" id="applyId" name="printQuery" queryData="queryData" value="<%=request.getParameter("applyId")%>"/>
<input type="hidden" id="scaconfPath" value="demobilizedIllApp/demobilizedIllAppPrintDao"/>
</body>  
</html> 
