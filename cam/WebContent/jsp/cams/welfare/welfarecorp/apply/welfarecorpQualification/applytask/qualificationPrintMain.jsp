<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<title></title>
<next:ScriptManager />
<script>
		    var taskCode='<%=request.getParameter("taskCode")%>';
			var applyState='<%=request.getParameter("applyState")%>';
			var companyName='<%=request.getParameter("companyName")%>';
		</script>
</head>
<body>

<next:Panel autoHeight="true"  bodyStyle="width:100%" width="100%"  >
	<next:TabPanel  id="panel">
		<next:Tabs>
			<next:Panel title="资格认定申报表" width="100%" height="100%" id="applytablepanel">
				<next:Html>
					<iframe id="applytable"
						src="welfarecorpPrintDetail.jsp?taskCode=<%=request.getParameter("taskCode")%>"
						frameborder="no" border="0" marginwidth="0" marginheight="0"
						scrolling="yes" allowtransparency="yes" width="100%" height="100%">
					</iframe>
				</next:Html>
			</next:Panel>
			
			<next:Panel title="证书打印" width="100%" height="100%" id="certificatepanel">
				<next:Html>
					<iframe id="certificate" 
						src="welfarecorpCertPrint.jsp?taskCode=<%=request.getParameter("taskCode")%>"
						frameborder="no" border="0" marginwidth="0" marginheight="0"
						scrolling="yes" allowtransparency="yes" width="100%" height="100%">
					</iframe>
				</next:Html>
			</next:Panel>
			<next:Panel title="回执单" width="100%" height="100%" id="backtablepanel">
				<next:Html>
					<iframe id="backtable"
						src="welfarecorpBackPrint.jsp?taskCode=<%=request.getParameter("taskCode")%>&companyName=<%=request.getParameter("companyName")%>"
						frameborder="no" border="0" marginwidth="0" marginheight="0"
						scrolling="yes" allowtransparency="yes" width="100%" height="100%">
					</iframe>
				</next:Html>
			</next:Panel>
		</next:Tabs>
	</next:TabPanel>
</next:Panel>
<script>
function init(){
	var panel = L5.getCmp("panel");
	if(applyState=="4"){
		var backtablepanel = L5.getCmp("backtablepanel");
		panel.remove(backtablepanel);
	}else if(applyState=="5"){
		var applytablepanel = L5.getCmp("applytablepanel");
		var certificatepanel = L5.getCmp("certificatepanel");
		panel.remove(applytablepanel);
		panel.remove(certificatepanel);
	}
}

</script>
</body>
</html>
