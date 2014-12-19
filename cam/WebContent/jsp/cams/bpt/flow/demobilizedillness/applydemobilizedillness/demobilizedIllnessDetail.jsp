<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<title>带病回乡退伍军人信息</title>
<next:ScriptManager />
<script>
		    var familyId='<%=request.getParameter("familyId")%>';
			var peopleId='<%=request.getParameter("peopleId")%>';
		</script>
<script type="text/javascript" src="demobilizedIllnessDetail.js"></script>
</head>
<body>
<next:Panel autoHeight="true"  bodyStyle="width:100%" width="100%" autoScroll="false">
	<next:TabPanel>
		<next:Tabs>
			<next:Panel title="基本信息" width="100%" height="100%">
				<next:Html>
					<iframe id="peopleInfo"
						src="../../../comm/peopleDetail.jsp?peopleId=<%=request.getParameter("peopleId")%>"
						frameborder="no" border="0" marginwidth="0" marginheight="0"
						scrolling="no" allowtransparency="yes" width="100%" height="100%">
					</iframe>
				</next:Html>
			</next:Panel>
			<next:Panel title="类别信息" width="100%" height="100%">
				<next:Html>
					<iframe id="peopleInfo"
						src="demobilizedIllnessInfo.jsp?peopleId=<%=request.getParameter("peopleId")%>"
						frameborder="no" border="0" marginwidth="0" marginheight="0"
						scrolling="no" allowtransparency="yes" width="100%" height="100%">
					</iframe>
				</next:Html>
			</next:Panel>
			<next:Panel title="住房信息" width="100%" height="100%">
				<next:Html>
					<iframe id="house"
						src="../../../comm/houseDetail.jsp?familyId=<%=request.getParameter("familyId")%>"
						frameborder="no" border="0" marginwidth="0" marginheight="0"
						scrolling="no" allowtransparency="yes" width="100%" height="100%">
					</iframe>
				</next:Html>
			</next:Panel>
			<next:Panel title="家庭成员信息" width="100%" height="100%">
				<next:Html>
					<iframe id="member"
						src="../../../comm/memberListDetail.jsp?familyId=<%=request.getParameter("familyId")%>"
						frameborder="no" border="0" marginwidth="0" marginheight="0"
						scrolling="no" allowtransparency="yes" width="100%" height="100%">
					</iframe>
				</next:Html>
			</next:Panel>
			<next:Panel title="电子档案" width="100%" height="100%"
				id="uploadTabPanel">
				<next:Html>
				  <iframe id="upload" src="../../../comm/uploadfileDetail.jsp?peopleId=<%=request.getParameter("peopleId")%>&serviceType=45&applyId=<%=request.getParameter("applyId")%>"
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
	   				</iframe>
				</next:Html>
		   </next:Panel>
		   <%-- 
		   <next:Panel title="介绍信" width="100%" height="100%"
				id="decisionLetterTabPanel">
				<next:Html>
				  <iframe id="introduceTabPanel" src="../../comm/bptintroductionLetterDetail.jsp?peopleId=<%=request.getParameter("peopleId")%>&applyId=<%=request.getParameter("applyId")%>"
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
	   				</iframe>
				</next:Html>
		</next:Panel>
		 --%>
		 <next:Panel title="公示书" width="100%" height="100%"
				id="openLetterPanel">
				<next:Html>
				  <iframe id="openLetter" src="openDemoIllDetail.jsp?peopleId=<%=request.getParameter("peopleId")%>&familyId=<%=request.getParameter("familyId")%>&applyId=<%=request.getParameter("applyId")%>&serviceType=45"
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
	   				</iframe>
				</next:Html>
		</next:Panel>
		   <next:Panel title="县级审核" width="100%" height="100%"
				id="demobilizedEdit">
				<next:Html>
				  <iframe id="demobilizedEdit" src="../../demobilized/applydemobilized/demobilizedflow_editDetail.jsp?peopleId=<%=request.getParameter("peopleId")%>&familyId=<%=request.getParameter("familyId")%>&applyId=<%=request.getParameter("applyId")%>&serviceType=45"
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
		<next:Panel title="不予认定身份决定书" width="100%" height="100%"
				id="decisionLetterTabPanel1">
				<next:Html>
				  <iframe id="decisionTabPanel" src="demoIllnessDecisionLetterDetail.jsp?peopleId=<%=request.getParameter("peopleId")%>&applyId=<%=request.getParameter("applyId")%>"
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
	   				</iframe>
				</next:Html>
		</next:Panel>
		<next:Panel title="体检表" width="100%" height="100%"
				id="physicalPanel">
				<next:Html>
				  <iframe id="physical" src="bptphysicalexamination/bptphysicalexamination_deatil.jsp?peopleId=<%=request.getParameter("peopleId")%>&applyId=<%=request.getParameter("applyId")%>"
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
	   				</iframe>
				</next:Html>
			</next:Panel>
		<next:Panel title="病情送检表" width="100%" height="100%"
				id="checkPanel">
				<next:Html>
				  <iframe id="check" src="bptphysicalexamination/bptDemobilizedillCheck_deatil.jsp?peopleId=<%=request.getParameter("peopleId")%>&applyId=<%=request.getParameter("applyId")%>"
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
	   				</iframe>
				</next:Html>
			</next:Panel>
		</next:Tabs>
	</next:TabPanel>
</next:Panel>

</body>
</html>
