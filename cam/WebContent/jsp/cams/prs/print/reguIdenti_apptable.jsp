<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<title>打印模板</title>
<next:ScriptManager />
	<script>
		var soldierId="<%=request.getParameter("soldierId")%>";
	</script>
<script type="text/javascript" src="reguIdenti_apptable.js"></script>
</head>
<body>
<%
	String  type = request.getParameter("type");//优抚类别ID
	String docpath = null;//模板地址
	if("01".equalsIgnoreCase(type)){
		 docpath = "jsp/cams/prs/print/settle_letter_apptable.doc"; //模板地址
	}else if("02".equalsIgnoreCase(type)){
		 docpath = "jsp/cams/prs/print/anzhi.doc"; //模板地址
	}else if("03".equalsIgnoreCase(type)){
		 docpath = "jsp/cams/prs/print/train.doc"; //模板地址
	}else{
	    docpath = "jsp/cams/prs/print/baseInfo.doc"; //模板地址
	}

%>
<input type="hidden" id="docpath" value="<%=docpath %>"/>
<input type="hidden" id="soldierId" name="printQuery" queryData="queryData"  value="<%=request.getParameter("soldierId")%>"/>
<input type="hidden" id="scaconfPath" value="soldierApp/soldierPrintDao"/>
<input type="hidden" id="type" name="printQuery" queryData="queryData"  value="<%=request.getParameter("type")%>"/>
</body>
</html>
