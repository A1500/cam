<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<title>年满60周岁农村籍退役士兵定补关系跨省迁出信息修改</title>
<next:ScriptManager />
		<script>
			var peopleId='<%=request.getParameter("peopleId")%>';
			var applyId='<%=request.getParameter("applyId")%>';
		</script>
</head>
<body>

<next:Panel width="100%">
	<next:TabPanel>
		<next:Tabs>

		<next:Panel title="基本信息" width="100%" height="100%" id="peopleInfoTabPanel">
				<next:Html>
				   <iframe id="peopleInfo" src="../../../../comm/peopleDetail.jsp?peopleId=<%=request.getParameter("peopleId")%>"
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
	   				</iframe>
				</next:Html>
		</next:Panel>

		<next:Panel title="类别信息" width="100%" height="100%" id="intoProviTabPanel">
				<next:Html>
				    <iframe id="intoProvi" src="../../../../dataCollection/bptcountretiredsoldier/bptcountretiredsoldierInfo.jsp?peopleId='<%=request.getParameter("peopleId")%>'&applyId=<%=request.getParameter("applyId")%>"
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
	   				</iframe>
				</next:Html>
		</next:Panel>
		<next:Panel title="家庭成员信息" width="100%" height="100%"
				id="memberTabPanel">
				<next:Html>
				  <iframe id="member" src="../../../../comm/memberListDetail.jsp?familyId=<%=request.getParameter("familyId")%>"
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
	   				</iframe>
				</next:Html>
		</next:Panel>
		
		<next:Panel title="住房信息" width="100%" height="100%"
				id="houseTabPanel">
				<next:Html>
				  <iframe id="house" src="../../../../comm/houseDetail.jsp?familyId=<%=request.getParameter("familyId")%>"
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
	   				</iframe>
				</next:Html>
		</next:Panel>
			<next:Panel title="电子档案" width="100%" height="100%" id="uploadTabPanel">
				<next:Html>
				  <iframe id="upload" src="../../../../comm/uploadfile.jsp?peopleId=<%=request.getParameter("peopleId")%>&serviceType=65&applyId=<%=request.getParameter("applyId")%>"
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
	   				</iframe>
				</next:Html>
		</next:Panel>
		<next:Panel title="迁移信息" width="100%" height="100%" id="emigrationTabPanel">
				<next:Html>
				  <iframe id="upload" src="sEmigrationUpdate.jsp?applyId=<%=request.getParameter("applyId")%>&peopleId=<%=request.getParameter("peopleId")%>"
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
	   				</iframe>
				</next:Html>
		</next:Panel>
		<next:Panel title="县级审核" width="100%" height="100%">
				<next:Html>
					<iframe id="house"
						src="../../../comm/emigrationProviTown_edit.jsp?applyId=<%=request.getParameter("applyId")%>"
						frameborder="no" border="0" marginwidth="0" marginheight="0"
						scrolling="no" allowtransparency="yes" width="100%" height="100%">
					</iframe>
				</next:Html>
</next:Panel>
		</next:Tabs>
	</next:TabPanel>
</next:Panel>

</body>
</html>
