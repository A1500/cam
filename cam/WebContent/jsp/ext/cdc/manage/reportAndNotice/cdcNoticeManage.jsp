<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<title></title>
<next:ScriptManager />
<script type="text/javascript" src=""></script>
<jsp:include page="../util/cdcOrgan.jsp" flush="true"/>
</head>
<body>

<next:Panel autoHeight="true"   bodyStyle="width:100%" width="100%" >
	<next:TabPanel animScroll="true" id="test" enableTabScroll="true" width="100%">
		<next:Tabs>
		
		<next:Panel title="通知通告" width="100%" height="100%"  
				id="peopleInfoTabPanel">
				<next:Html>
				  <iframe id="peopleInfo" src="cdcNoticeList.jsp"
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
	   				</iframe>
				</next:Html>
		</next:Panel>
		
		<next:Panel title="下发通知" width="100%" height="100%" hidden="true"
				id="disabilityTypeTabPanel">
				<next:Html>
				  <iframe id="disabilityType" src="cdcNoticeNList.jsp"
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
	   				</iframe>
				</next:Html>
		</next:Panel>
		</next:Tabs>
	</next:TabPanel>
</next:Panel>
<script>
	function init() {
		if(organLevel=="SQ"){
			var  a =L5.getCmp("disabilityTypeTabPanel");
			var  b=L5.getCmp("test");
			b.remove(a,true);
		}
		if(organLevel=="11"){
			var  a =L5.getCmp("peopleInfoTabPanel");
			var  b=L5.getCmp("test");
			b.remove(a,true);
		}
	}
</script>
</body>
</html>
