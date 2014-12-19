<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
<head>
<title>受理通知书添加</title>
<next:ScriptManager/>
		<script>
			var peopleId='<%=request.getParameter("peopleId")%>';
			var organId='<%=BspUtil.getCorpOrgan().getOrganCode()%>';
		</script>
</head>
<body>

	   		
			<input type="hidden" id="applyId" name="printQuery" queryData="queryData" value="<%=request.getParameter("applyId")%>"/>
			<input type="hidden" id="docpath" value="jsp/cams/bpt/flow/disability/assessdisability/table/acceptNotice_apptable.doc"/>
			<input type="hidden" id="organId" name="printQuery" queryData="queryData" value="<%=BspUtil.getCorpOrgan().getOrganCode()%>"/>
			<input type="hidden" id="peopleId" name="printQuery" queryData="queryData" value="<%=request.getParameter("peopleId")%>"/>
			<input type="hidden" id="method" name="queryData" queryData="queryData" value="queryAcceptNotice"/>
			<input type="hidden" id="scaconfPath" value="assDisdislityApp/assDisdislityAppPrintDao"/>
</body>
<script type="text/javascript">
	function init(){
		var url="../../../../comm/print/jspcommonprint.jsp?";
		var width = 1024;
		var height = 768;
	    window.showModalDialog(url,window,"scroll:yes;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:1");
	}
</script>
</html>
