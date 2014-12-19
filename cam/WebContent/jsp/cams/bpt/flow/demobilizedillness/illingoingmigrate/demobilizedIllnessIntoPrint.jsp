<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="com.inspur.cams.comm.util.IdHelp"%>

<html>
<head>
<title>带病回乡退伍军人信息</title>
<next:ScriptManager />
<script>
	var peopleId='<%=request.getParameter("peopleId")%>';
	var applyId='<%=request.getParameter("applyId")%>';
	function init() {
		var url="../../../../comm/print/jspcommonprint.jsp?";
		var width = 1024;
		var height = 768;
	    window.showModalDialog(url,window,"scroll:yes;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:1");
	}
</script>
</head>
<body>
						<input type="hidden" id="applyId" name="printQuery" queryData="queryData" value="<%=request.getParameter("applyId")%>"/>
						<input type="hidden" id="docpath" value="jsp/cams/bpt/flow/comm/print/e_intomigration_table.doc"/>
						<input type="hidden" id="peopleId" name="printQuery" queryData="queryData" value="<%=request.getParameter("peopleId")%>"/>
						<input type="hidden" id="scaconfPath" value="intoMigration/intoMigrationPrintDao"/>
						<input type="hidden" id="serviceType" name="printQuery" queryData="queryData" value="46"/>
</body>
</html>
