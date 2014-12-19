<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<title>山东省领取定期抚恤金审批表</title>
<next:ScriptManager />
		<script>
			var peopleId="<%=request.getParameter("peopleId")%>";
		</script>
<script type="text/javascript" src="dependant_apptable.js"></script>
</head>
<body>
<input type="hidden" id="docpath"  value="jsp/cams/bpt/flow/dependant/print/dependant_apptable.doc"/>
<input type="hidden" id="peopleId" name="printQuery" queryData="queryData" value="<%=request.getParameter("peopleId")%>"/>
<input type="hidden" id="applyId" name="printQuery" queryData="queryData" value="<%=request.getParameter("applyId")%>"/>
<input type="hidden" id="scaconfPath"  value="dependantApp/dependantAppPrintDao"/>
</body>  
</html> 
