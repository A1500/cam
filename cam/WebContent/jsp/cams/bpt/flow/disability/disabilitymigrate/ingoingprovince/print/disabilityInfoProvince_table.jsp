<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<title>残疾人员抚恤关系迁入呈报表</title>
<next:ScriptManager />
		<script>
			var peopleId="<%=request.getParameter("peopleId")%>";
		</script>
</head>
<body>
<input type="hidden" id="applyId" name="printQuery" queryData="queryData" value="<%=request.getParameter("applyId")%>"/>
<input type="hidden" id="docpath" value="jsp/cams/bpt/flow/disability/disabilitymigrate/ingoingprovince/print/disabilityIntoProvince_table.doc"/>
<input type="hidden" id="peopleId" name="printQuery" queryData="queryData" value="<%=request.getParameter("peopleId")%>"/>
<input type="hidden" id="scaconfPath" value="assDisdislityApp/assDisdislityAppPrintDao"/>
<input type="hidden" id="method" value="queryDisIntoProvince"/>
<input type="hidden" id="serviceType" name="printQuery" queryData="queryData" value="15"/>
</body>  

<script type="text/javascript">
	function init() {
		var url="../../../../../../comm/print/jspcommonprint.jsp?";
		var width = 1024;
		var height = 768;
	    window.showModalDialog(url,window,"scroll:yes;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:1");
	}

</script>
</html> 
