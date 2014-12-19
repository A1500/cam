<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<title>优抚对象基本信息</title>
<next:ScriptManager />
		<script>
			var peopleId='<%=request.getParameter("peopleId")%>';
			var objectType='<%=request.getParameter("objectType")%>';
			var objectState='<%=request.getParameter("objectState")%>';
		</script>
		<script type="text/javascript" src="informationCueConfirm.js"></script>
</head>
<body>
<next:Panel width="100%" height="100%" autoScroll="false">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem text="确认" iconCls="edit" handler="save"/>
		<next:ToolBarItem text="返回" iconCls="undo" handler="back"/>
	</next:TopBar>
	<next:TabPanel>
		<next:Tabs>
			<next:Panel title="基本信息" width="100%" height="100%" autoScroll="false" id="peopleTabPanel">
				<next:Html>
				   <iframe id="peopleFrame" src=""
							frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
		   		   </iframe>
				</next:Html>
			</next:Panel>
			<next:Panel title="类别信息" width="100%" height="100%" autoScroll="false"
				id="objectTypeTabPanel">
				<next:Html>
						<%	String objectType = request.getParameter("objectType");
						if("11".equals(objectType) || "12".equals(objectType) || "13".equals(objectType) || "14".equals(objectType)|| "15".equals(objectType)|| "16".equals(objectType)){%>
						<iframe id="instanceDisability" src="../basicInfoView/disabilityTypeDetail.jsp?peopleId=<%=request.getParameter("peopleId")%>"
							frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
		   				</iframe>
		   			<% }else if("21".equals(objectType) || "22".equals(objectType) || "23".equals(objectType)){ %>
		   				<iframe id="instance" src="../basicInfoView/dependantTypeDetail.jsp?peopleId=<%=request.getParameter("peopleId")%>"
							frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
		   				</iframe>
		   			<% }else if("41".equals(objectType)){ %>
		   				<iframe id="instance" src="../basicInfoView/demobilizedDetail.jsp?peopleId=<%=request.getParameter("peopleId")%>"
							frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
		   				</iframe>
		   			<% }else if("42".equals(objectType)){ %>
		   				<iframe id="instance" src="../basicInfoView/demobilizedIllnessDetail.jsp?peopleId=<%=request.getParameter("peopleId")%>"
							frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
		   				</iframe>
		   			<%} else if("51".equals(objectType)){%>
		   			    <iframe id="instance" src="../basicInfoView/bptwarDetail.jsp?peopleId=<%=request.getParameter("peopleId")%>"
							frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
		   				</iframe>
		   			<%} else if("61".equals(objectType)){%>
		   			    <iframe id="instance" src="../basicInfoView/bpttestedDetail.jsp?peopleId=<%=request.getParameter("peopleId")%>"
							frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
		   				</iframe>
		   			<%}%>
				</next:Html>
			</next:Panel>
		</next:Tabs>
	</next:TabPanel>
</next:Panel>
</body>
</html>
