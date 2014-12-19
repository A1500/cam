<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<title></title>
<next:ScriptManager />
		<script>
			var peopleId='<%=request.getParameter("peopleId")%>';
			var familyId='<%=request.getParameter("familyId")%>';
		</script>
<script type="text/javascript" src=""></script>
<jsp:include page="../util/cdcOrgan.jsp" flush="true"/>
</head>
<body>

<next:Panel autoHeight="true"    bodyStyle="width:100%" width="100%" >
	<next:TabPanel animScroll="true" id="tab" enableTabScroll="true" width="100%">
		<next:Tabs>
		
		<next:Panel title="申报信息" width="100%" height="100%"
				id="applyreport">
				<next:Html>
				  <iframe id="applyreport1" src="cdcReportList.jsp"
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
	   				</iframe>
				</next:Html>
		</next:Panel>
		
		<next:Panel title="填写申报" width="100%" height="100%"
				id="addreport">
				<next:Html>
				  <iframe id="addreport1" src="cdcReportNList.jsp"
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
	   				</iframe>
				</next:Html>
		</next:Panel>
		</next:Tabs>
	</next:TabPanel>
</next:Panel>
<script>
	function init() {
		var  a =L5.getCmp("addreport");
		var  c =L5.getCmp("applyreport");
		var  b=L5.getCmp("tab");
		if(organLevel=="11"){
			b.remove(a);
		}
		if(organLevel=="SQ"){ 
			b.remove(c);
		}
		
	}
</script>
</body>
</html>
