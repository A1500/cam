<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<title>查看换证、补证信息</title>
<next:ScriptManager />
<script type="text/javascript">
	var applyId = '<%= (String)request.getParameter("applyId")%>';
</script>
</head>
<body>
						<!-- 打印相关 -->
		<input type="hidden" id="docpath" value="jsp/cams/bpt/flow/disability/exchacertidisa/print/exchacertidisa_table.doc"/>
		<input type="hidden" id="applyId" name="printQuery" queryData="queryData" value="<%=request.getParameter("applyId")%>"/>
		<input type="hidden" id="peopleId" name="printQuery" queryData="queryData" value="<%=request.getParameter("peopleId")%>"/>
		<input type="hidden" id="scaconfPath" value="assDisdislityApp/assDisdislityAppPrintDao"/>
		<input type="hidden" id="method" value="queryExchaCertiDis"/>
		<input type="hidden" id="serviceType" name="printQuery" queryData="queryData" value="13"/>
</body>
<script type="text/javascript">
	function init(){
	var url="../../../../../comm/print/jspcommonprint.jsp?";
	var text='鉴定介绍信打印';
	var width = 1024;
	var height = 768;
    window.showModalDialog(url,window,"scroll:yes;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:1");
}
</script>
</html>
