<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<script type="text/javascript">
   var organCode = '<%=BspUtil.getOrganCode()%>';
   var organCodeSub = organCode.substr(0,6);
</script>
<html>
<head>
<title>鉴定介绍信打印</title>
<next:ScriptManager />
		<script>
			var peopleId='<%=request.getParameter("peopleId")%>';
			function init() {
				var url = "../../../comm/print/jspcommonprint.jsp?";
				var text = '鉴定介绍信打印';
				var width = 1024;
				var height = 768;
				window.showModalDialog(url, window, "scroll:yes;status:no;dialogWidth:"
								+ width + "px;dialogHeight:" + height + "px;resizable:1");
			}
		</script>
<script type="text/javascript" src="../../comm/bptComm.js"></script>
</head>
<body>

		<input type="hidden" id="docpath" value="jsp/cams/bpt/flow/disability/assessdisability/print/introductionLetter.doc"/>
		<input type="hidden" id="peopleId" name="printQuery" queryData="queryData" value="<%=request.getParameter("peopleId")%>"/>
		<input type="hidden" id="applyId" name="printQuery" queryData="queryData" value="<%=request.getParameter("applyId")%>"/>
		<input type="hidden" id="scaconfPath" value="assDisdislityApp/assDisdislityAppPrintDao"/>
		<input type="hidden" id="method" name="queryData" queryData="queryData" value="queryIntroductionLetter"/>
</body>
</html>
