<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<script type="text/javascript">
	var peopleId = '<%=request.getParameter("peopleId")%>';
	var applyId = '<%=request.getParameter("applyId")%>';
</script>
<html>
<head>
<title>添加伤残人员抚恤关系跨省迁出</title>
<next:ScriptManager />
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
</head>
<body>
	<input type="hidden" id="applyId" name="printQuery" queryData="queryData" value="<%=request.getParameter("applyId")%>"/>
	<input type="hidden" id="docpath" value="jsp/cams/bpt/flow/disability/disabilitymigrate/emigration/print/disabilityProvinceEmigration_table.doc"/>
	<input type="hidden" id="peopleId" name="printQuery" queryData="queryData" value="<%=request.getParameter("peopleId")%>"/>
	<input type="hidden" id="scaconfPath" value="assDisdislityApp/assDisdislityAppPrintDao"/>
	<input type="hidden" id="method" value="queryProvinceMigration"/>
	<input type="hidden" id="serviceType" name="printQuery" queryData="queryData" value="19"/>
</body>
<script type="text/javascript">
function init(){
		var url="../../../../../comm/print/jspcommonprint.jsp?";
		var width = 1024;
		var height = 768;
	    window.showModalDialog(url,window,"scroll:yes;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:1");
	}
</script>
</html>
