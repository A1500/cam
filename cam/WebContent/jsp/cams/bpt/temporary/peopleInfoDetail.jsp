<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<title>临时救助申请受理</title>
<next:ScriptManager />
</head>
<body>
<next:Panel width="100%" height="100%" autoScroll="false">
	<next:TabPanel>
		<next:Tabs>
			<next:Panel title="人员基本信息" width="100%" height="100%" autoScroll="false"
				id="peopleTabPanel">
				<next:Html>
				<iframe id="basepeopleTabPanel" src="../comm/peopleDetail.jsp?peopleId=<%=request.getParameter("peopleId")%>"
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
			<next:Panel title="家庭成员信息" width="100%" height="100%"
				id="memberTabPanel">
				<next:Html>
				  <iframe id="member" src="../comm/memberListDetail.jsp?familyId=<%=request.getParameter("familyId")%>"
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
	   				</iframe>
				</next:Html>
		</next:Panel>
		
		<next:Panel title="住房信息" width="100%" height="100%"
				id="houseTabPanel">
				<next:Html>
				  <iframe id="house" src="../comm/houseDetail.jsp?familyId=<%=request.getParameter("familyId")%>"
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
	   				</iframe>
				</next:Html>
		</next:Panel>
		<next:Panel title="电子档案" width="100%" height="100%"
				id="uploadTabPanel">
				<next:Html>
				  <iframe id="upload" src="../comm/uploadfileDetail.jsp?peopleId=<%=request.getParameter("peopleId")%>&serviceType=21"
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
	   				</iframe>
				</next:Html>
		</next:Panel>
			
			<next:Panel title="临时救助审批表" width="100%" height="100%" autoScroll="false"
				id="apTabPanel">
				<next:Html>
				
				<% String method = request.getParameter("method");
				if("DETAIL".equals(method)){%>
	   			   <iframe id="instance" src="bpttemporaryhelpDetail.jsp?method=DETAIL&applyId=<%=request.getParameter("applyId")%>&peopleId=<%=request.getParameter("peopleId")%>"
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
	   				</iframe>
	   			
	   			<%} else if("UPDATE".equals(method)){%>
	   			   <iframe id="instance" src="temporaryHelpEdit.jsp?method=UPDATE&applyId=<%=request.getParameter("applyId")%>&peopleId=<%=request.getParameter("peopleId")%>"
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
	   				</iframe>
	   			<%}%>
				</next:Html>
			</next:Panel>
			<next:Panel title="县级审核" width="100%" height="100%" autoScroll="false"
				id="approveTabPanel">
				<next:Html>
				
				<% String method = request.getParameter("method");
				if("DETAIL".equals(method)){%>
	   			   <iframe id="instance" src="temporaryHelpApplyDetail.jsp?method=DETAIL&applyId=<%=request.getParameter("applyId")%>&peopleId=<%=request.getParameter("peopleId")%>"
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
	   				</iframe>
	   			
	   			<%} else if("UPDATE".equals(method)){%>
	   			   <iframe id="instance" src="temporaryHelpApplyEdit.jsp?method=UPDATE&applyId=<%=request.getParameter("applyId")%>&peopleId=<%=request.getParameter("peopleId")%>"
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
