<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<title>受理通知书</title>
<next:ScriptManager />
		<script>
			var peopleId="<%=request.getParameter("peopleId")%>";
		</script>
<script type="text/javascript" src="acceptNotice_apptable.js"></script>
</head>
<body>
<input type="hidden" id="docpath" value="jsp/cams/bpt/flow/disability/assessdisability/table/acceptNotice_apptable.doc"/>
<input type="hidden" id="peopleId" name="printQuery" queryData="queryData" value="<%=request.getParameter("peopleId")%>"/>
<input type="hidden" id="method" name="queryData" queryData="queryData" value="queryAcceptNotice"/>
<input type="hidden" id="scaconfPath" value="assDisdislityApp/assDisdislityAppPrintDao"/>
</body>  
</html> 
