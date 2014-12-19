<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<title>在乡人员抚恤关系跨省迁入修改</title>
<next:ScriptManager />
		<script>
			var peopleId='<%=request.getParameter("peopleId")%>';
			var familyId='<%=request.getParameter("familyId")%>';
		</script>
<script type="text/javascript" src="demobilizedUpdateManage.js"></script>
</head>
<body>
<next:Panel autoHeight="true"   bodyStyle="width:100%" width="100%" >
	<next:TabPanel>
		<next:Tabs>
		   <next:Panel title="基本信息" width="100%" height="100%"
				id="peopleInfoTabPanel">
				<next:Html>
				  <iframe id="peopleInfo" src="../../../comm/peopleUpdate.jsp?peopleId=<%=request.getParameter("peopleId")%>"
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
	   				</iframe>
				</next:Html>
		  </next:Panel>
		  <next:Panel title="类别信息" width="100%" height="100%" id="demobilizedTypeTabPanel">
				<next:Html>
				  <iframe id="demobilizedType" src="demobilizedEdit.jsp?peopleId=<%=request.getParameter("peopleId")%>"
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
	   				</iframe>
				</next:Html>
		 </next:Panel>
		 <next:Panel title="家庭成员信息" width="100%" height="100%" id="memberTabPanel">
				<next:Html>
				  <iframe id="member" src="../../../comm/memberList.jsp?familyId=<%=request.getParameter("familyId")%>"
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
	   				</iframe>
				</next:Html>
		</next:Panel>
		 <next:Panel title="住房信息" width="100%" height="100%" id="houseTabPanel">
				<next:Html>
				  <iframe id="house" src="../../../comm/houseUpdate.jsp?familyId=<%=request.getParameter("familyId")%>"
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
	   				</iframe>
				</next:Html>
		</next:Panel>
		 <next:Panel title="电子档案" width="100%" height="100%" id="uploadTabPanel">
				<next:Html>
				  <iframe id="upload" src="../../../comm/uploadfile.jsp?peopleId=<%=request.getParameter("peopleId")%>&serviceType=42&applyId=<%=request.getParameter("applyId")%>"
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
	   				</iframe>
				</next:Html>
		</next:Panel>
		 <next:Panel id="demobiInPrintPanel" title="迁入信息" width="100%" height="100%" >
				<next:Html>
				  <iframe id="demobiInPrintFrm" src="demobilizedPrint.jsp?peopleId=<%=request.getParameter("peopleId")%>&serviceType=42&applyId=<%=request.getParameter("applyId")%>"
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
	   				</iframe>
				</next:Html>
		</next:Panel>
		<next:Panel title="县级审核" width="100%" height="100%" id="town">
				<next:Html>
				    <iframe id="tableFrame" src="../../comm/intoProviTown_edit.jsp?applyId=<%=request.getParameter("applyId")%>"
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
	   				</iframe>
				</next:Html>
		</next:Panel>
		</next:Tabs>
	</next:TabPanel>
</next:Panel>
</body>
</html>
