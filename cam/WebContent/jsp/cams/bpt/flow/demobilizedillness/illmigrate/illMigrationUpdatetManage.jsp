<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="com.inspur.cams.bpt.base.dao.IBptPeopleDemobilizedIllnessDao"%>
<%@ page import="org.loushang.next.data.ParameterSet"%>
<%@ page import="org.loushang.next.dao.DaoFactory"%>
<html>
<head>
<title>带病回乡人员抚恤跨省迁出信息查看</title>
<next:ScriptManager />
		<script>
		<%
	ParameterSet pset = new ParameterSet();
	pset.setParameter("peopleId",request.getParameter("peopleId"));
	IBptPeopleDemobilizedIllnessDao dao = (IBptPeopleDemobilizedIllnessDao) DaoFactory.getDao("com.inspur.cams.bpt.base.dao.jdbc.BptPeopleDemobilizedIllnessDao");

	String idCard = dao.queryIdCardByPeopleId(pset);

%>
			var peopleId='<%=request.getParameter("peopleId")%>';
			var applyId='<%=request.getParameter("applyId")%>';
			var familyId='<%=request.getParameter("familyId")%>';
			var idCard = '<%=idCard%>';
		</script>
</head>
<body>

<next:Panel width="100%">
	<next:TabPanel>
		<next:Tabs>

		<next:Panel title="基本信息" width="100%" height="100%" id="peopleInfoTabPanel">
				<next:Html>
				   <iframe id="peopleInfo" src="../../../comm/peopleDetail.jsp?peopleId=<%=request.getParameter("peopleId")%>"
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
	   				</iframe>
				</next:Html>
		</next:Panel>

		<next:Panel title="类别信息" width="100%" height="100%">
				<next:Html>
					<iframe id="peopleInfo"
						src="../applydemobilizedillness/demobilizedIllnessInfo.jsp?peopleId=<%=request.getParameter("peopleId")%>"
						frameborder="no" border="0" marginwidth="0" marginheight="0"
						scrolling="no" allowtransparency="yes" width="100%" height="100%">
					</iframe>
				</next:Html>
			</next:Panel>
		<next:Panel title="家庭成员信息" width="100%" height="100%"
				id="memberTabPanel">
				<next:Html>
				  <iframe id="member" src="../../../comm/memberListDetail.jsp?familyId=<%=request.getParameter("familyId")%>"
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
	   				</iframe>
				</next:Html>
		</next:Panel>
		
		<next:Panel title="住房信息" width="100%" height="100%"
				id="houseTabPanel">
				<next:Html>
				  <iframe id="house" src="../../../comm/houseDetail.jsp?familyId=<%=request.getParameter("familyId")%>"
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
	   				</iframe>
				</next:Html>
		</next:Panel>
		<next:Panel title="电子档案" width="100%" height="100%"
				id="uploadTabPanel">
				<next:Html>
				  <iframe id="upload" src="../../../comm/uploadfile.jsp?peopleId=<%=request.getParameter("peopleId")%>&serviceType=4B&applyId=<%=request.getParameter("applyId")%>"
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
	   				</iframe>
				</next:Html>
		</next:Panel>
		<next:Panel title="迁出信息" width="100%" height="100%"
				id="emigrationTabPanel">
				<next:Html>
				  <iframe id="upload" src="illMigrationUpdatet.jsp?applyId=<%=request.getParameter("applyId")%>&idCard=<%=idCard%>&peopleId=<%=request.getParameter("peopleId")%>"
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
	   				</iframe>
				</next:Html>
		</next:Panel>
		<next:Panel title="县级审核" width="100%" height="100%">
				<next:Html>
					<iframe id="house"
						src="../../comm/emigrationProviTown_edit.jsp?applyId=<%=request.getParameter("applyId")%>"
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
