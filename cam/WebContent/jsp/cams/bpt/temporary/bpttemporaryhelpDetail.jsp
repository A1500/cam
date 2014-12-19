
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
	<head>
		<title>临时救助审批明细</title>
		<next:ScriptManager/>
		<script>
			var id='<%=request.getParameter("id")%>';
			var method='<%=request.getParameter("method")%>';
			function init() {
					var url="../../comm/print/jspcommonprint.jsp?";
					var text='优抚对象临时救助审批表';
					var width = 1024;
					var height = 768;
				    window.showModalDialog(url,window,"scroll:yes;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:1");
			}
		</script>
		<script type="text/javascript" src="../comm/bptComm.js"></script>
	</head>
<body>
					<input type="hidden" id="docpath" value="jsp/cams/bpt/temporary/table/temp_apptable.doc"/>
					<input type="hidden" id="peopleId" name="printQuery" queryData="queryData" value="<%=request.getParameter("peopleId")%>"/>
					<input type="hidden" id="scaconfPath" value="tempApp/tempAppPrintDao"/>
					</form>
</body>
</html>