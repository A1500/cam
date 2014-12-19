<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<title>带病回乡退伍军人信息</title>
<next:ScriptManager />
		<script>
		    var peopleId='<%=request.getParameter("peopleId")%>';
			var familyId='<%=request.getParameter("familyId")%>';
			var idField='<%=request.getParameter("dataBean")%>';
			var method='<%=request.getParameter("method")%>';
		</script>
<script type="text/javascript" src="demobilizedIllnessUpdateManage.js"></script>
</head>
<body>

<next:Panel autoHeight="true"   bodyStyle="width:100%" width="100%" autoScroll="false">
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
		
		<next:Panel title="类别信息" width="100%" height="100%"
				id="demobilizedTypeTabPanel">
				<next:Html>
				  <iframe id="demobilizedIllnessType" src="demobilizedIllnessEdit.jsp?peopleId=<%=request.getParameter("peopleId")%>"
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
	   				</iframe>
				</next:Html>
		</next:Panel>
		
		<next:Panel title="住房信息" width="100%" height="100%"
				id="houseTabPanel">
				<next:Html>
				  <iframe id="house" src="../../../comm/houseUpdate.jsp?familyId=<%=request.getParameter("familyId")%>"
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
	   				</iframe>
				</next:Html>
		</next:Panel>

		<next:Panel title="家庭成员信息" width="100%" height="100%"
				id="memberTabPanel">
				<next:Html>
				  <iframe id="member" src="../../../comm/memberList.jsp?familyId=<%=request.getParameter("familyId")%>"
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
	   				</iframe>
				</next:Html>
		</next:Panel>
        			<next:Panel title="电子档案" width="100%" height="100%"
				id="uploadTabPanel">
				<next:Html>
				  <iframe id="upload" src="../../../comm/uploadfile.jsp?peopleId=<%=request.getParameter("peopleId")%>&serviceType=45&applyId=<%=request.getParameter("applyId")%>"
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
	   				</iframe>
				</next:Html>
		   </next:Panel>
		<%--  <next:Panel title="介绍信" width="100%" height="100%"
				id="introductionLetter">
				<next:Html>
				  <iframe id="introductionLetter" src="../../comm/introductionLetterUpdate.jsp?peopleId=<%=request.getParameter("peopleId")%>&applyId=<%=request.getParameter("applyId")%>"
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
	   				</iframe>
				</next:Html>
			</next:Panel> --%>
			 <next:Panel title="公示书" width="100%" height="100%"
				id="openLetter">
				<next:Html>
				  <iframe id="openLetter1" src="openDemoIllUpdate.jsp?peopleId=<%=request.getParameter("peopleId")%>&familyId=<%=request.getParameter("familyId")%>&applyId=<%=request.getParameter("applyId")%>&serviceType=45"
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
	   				</iframe>
				</next:Html>
		</next:Panel>
		   <next:Panel title="县级审核" width="100%" height="100%"
				id="demobilizedEdit">
				<next:Html>
				  <iframe id="demobilizedEdit" src="../../demobilized/applydemobilized/demobilizedflow_editUpdate.jsp?peopleId=<%=request.getParameter("peopleId")%>&familyId=<%=request.getParameter("familyId")%>&applyId=<%=request.getParameter("applyId")%>&serviceType=45"
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
	   				</iframe>
				</next:Html>
		</next:Panel>
		<next:Panel title="审批表" width="100%" height="100%"
				id="demobilizeApp">
				<next:Html>
				  <iframe id="demobilize" src="../table/demobilized_apptable.jsp?peopleId=<%=request.getParameter("peopleId")%>&applyId=<%=request.getParameter("applyId")%>"
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
	   				</iframe>
				</next:Html>
		</next:Panel>
		<next:Panel title="不予认定决定书" width="100%" height="100%"
				id="decisionLetterTabPanel">
				<next:Html>
				  <iframe id="decisionTabPanel" src="demoIllnessDecisionLetterUpdate.jsp?peopleId=<%=request.getParameter("peopleId")%>&applyId=<%=request.getParameter("applyId")%>"
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
	   				</iframe>
				</next:Html>
		</next:Panel>
		<next:Panel title="体检表" width="100%" height="100%"
				id="physical">
				<next:Html>
				  <iframe id="physical" src="bptphysicalexamination/bptphysicalexamination_edit.jsp?peopleId=<%=request.getParameter("peopleId")%>&applyId=<%=request.getParameter("applyId")%>"
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
	   				</iframe>
				</next:Html>
			</next:Panel>
			
		<next:Panel title="病情送检表" width="100%" height="100%"
				id="checkPanel">
				<next:Html>
				  <iframe id="check" src="bptphysicalexamination/bptDemobilizedillCheck_edit.jsp?peopleId=<%=request.getParameter("peopleId")%>&applyId=<%=request.getParameter("applyId")%>"
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
	   				</iframe>
				</next:Html>
			</next:Panel>
		</next:Tabs>
	</next:TabPanel>
</next:Panel>

</body>
</html>
