<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<% 
String applyId=request.getParameter("applyId")==null?"":(String)request.getParameter("applyId");
%>
<html>
<head>
<title>三属人员信息修改</title>
<next:ScriptManager />
		<script>
			var peopleId='<%=request.getParameter("peopleId")%>';
			var familyId='<%=request.getParameter("familyId")%>';
			var photoId = '<%=request.getParameter("photoId")%>'
		</script>
<script type="text/javascript" src="dependantUpdateManage.js"></script>
</head>
<body>

<next:Panel autoHeight="true"   bodyStyle="width:100%" width="100%" >
	<next:TabPanel id="tabPanel">
		<next:Tabs>

		<next:Panel title="基本信息" width="100%" height="100%"
				id="peopleInfoTabPanel">
				<next:Html>
				  <iframe id="peopleInfo" src="../../comm/peopleUpdate.jsp?peopleId=<%=request.getParameter("peopleId")%>";
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
	   				</iframe>
				</next:Html>
		</next:Panel>

		<next:Panel title="类别信息" width="100%" height="100%"
				id="disabilityTypeTabPanel">
				<next:Html>
				  <iframe id="disabilityType" src="dependantTypeUpdate.jsp?peopleId=<%=request.getParameter("peopleId")%>"
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="yes" allowtransparency="yes" width="100%" height="100%">
	   				</iframe>
				</next:Html>
		</next:Panel>
		<next:Panel title="家庭成员信息" width="100%" height="100%"
				id="memberTabPanel"> 
				<next:Html>
				  <iframe id="member" src="../../comm/memberList.jsp?familyId=<%=request.getParameter("familyId")%>"
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
	   				</iframe>
				</next:Html>
		</next:Panel>

		<next:Panel title="住房信息" width="100%" height="100%"
				id="houseTabPanel">
				<next:Html>
				  <iframe id="house" src="../../comm/houseUpdate.jsp?familyId=<%=request.getParameter("familyId")%>"
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
	   				</iframe>
				</next:Html>
		</next:Panel>
		<next:Panel title="电子档案" width="100%" height="100%"
				id="uploadTabPanel">
				<next:Html>
				  <iframe id="upload" src="../../comm/uploadfile.jsp?peopleId=<%=request.getParameter("peopleId")%>&serviceType=21&applyId=<%=applyId%>"
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
	   				</iframe>
				</next:Html>
		</next:Panel>
		<next:Panel title="山东省领取定期抚恤金审批表" width="100%" height="100%"
				id="dependantApprove">
				<next:Html>
				  <iframe id="appTable" src="print/dependant_apptable.jsp?peopleId=<%=request.getParameter("peopleId")%>&applyId=<%=request.getParameter("applyId")%>"
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
	   				</iframe>
				</next:Html>
		</next:Panel>
		<next:Panel title="县级审批" width="100%" height="100%"
				id="dependanttownApprove">
				<next:Html>
				  <iframe id="appTownTable" src="comm/dependantTownapprovedEdit.jsp?peopleId=<%=request.getParameter("peopleId")%>&applyId=<%=request.getParameter("applyId")%>&serviceType=21"
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
	   				</iframe>
				</next:Html>
		</next:Panel>
		</next:Tabs> 
	</next:TabPanel>
</next:Panel>

</body>
</html>
