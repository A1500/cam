<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
<head>
<title>参战退役人员登记审核表</title>
<next:ScriptManager />
		<script>
			var peopleId="<%=request.getParameter("peopleId")%>";
		</script>
<script type="text/javascript" src="war_apptable.js"></script>
</head>
<body>
<input type="hidden" id="docpath" value="jsp/cams/bpt/flow/war/table/war_apptable.doc"/>
<input type="hidden" id="peopleId" name="printQuery" queryData="queryData" value="<%=request.getParameter("peopleId")%>"/>
<input type="hidden" id="applyId" name="printQuery" queryData="queryData" value="<%=request.getParameter("applyId")%>"/>
<input type="hidden" id="organCode" name="printQuery" queryData="queryData" value="<%=BspUtil.getOrganCode()%>"/>
<input type="hidden" id="organName" name="printQuery" queryData="queryData" value="<%=BspUtil.getOrganName()%>"/>
<input type="hidden" id="scaconfPath" value="warApp/warAppPrintDao"/>
</body>  
</html> 
