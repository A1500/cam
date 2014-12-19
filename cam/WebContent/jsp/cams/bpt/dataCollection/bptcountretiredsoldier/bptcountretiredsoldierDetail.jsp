<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<title>60周岁以上农村籍退役士兵信息</title>
<next:ScriptManager />
<script>
		    var familyId='<%=request.getParameter("familyId")%>';
			var peopleId='<%=request.getParameter("peopleId")%>';
			
		</script>
<script type="text/javascript" src="demobilizedUpdateManage.js"></script>
</head>
<body>

<next:Panel autoHeight="true"  bodyStyle="width:100%" width="100%" >
	<next:TabPanel>
		<next:Tabs>
			<next:Panel title="人员基本信息" width="100%" height="100%">
				<next:Html>
					<iframe id="peopleInfo"
						src="../comm/peopleDetail.jsp?peopleId=<%=request.getParameter("peopleId")%>"
						frameborder="no" border="0" marginwidth="0" marginheight="0"
						scrolling="no" allowtransparency="yes" width="100%" height="100%">
					</iframe>
				</next:Html>
			</next:Panel>
		<next:Panel title="类别信息" width="100%" height="100%">
				<next:Html>
					<iframe id="house"
						src="cbptcountretiredsoldierInfo.jsp?peopleId='<%=request.getParameter("peopleId")%>'"
						frameborder="no" border="0" marginwidth="0" marginheight="0"
						scrolling="no" allowtransparency="yes" width="100%" height="100%">
					</iframe>
				</next:Html>
			</next:Panel>
			<next:Panel title="家庭成员信息" width="100%" height="100%">
				<next:Html>
					<iframe id="member"
						src="../comm/memberListDetail.jsp?familyId='<%=request.getParameter("familyId")%>'"
						frameborder="no" border="0" marginwidth="0" marginheight="0"
						scrolling="no" allowtransparency="yes" width="100%" height="100%">
					</iframe>
				</next:Html>
			</next:Panel>
			<next:Panel title="住房信息" width="100%" height="100%">
				<next:Html>
					<iframe id="house"
						src="../comm/houseDetail.jsp?familyId=<%=request.getParameter("familyId")%>"
						frameborder="no" border="0" marginwidth="0" marginheight="0"
						scrolling="no" allowtransparency="yes" width="100%" height="100%">
					</iframe>
				</next:Html>
			</next:Panel>
			<next:Panel title="电子档案" width="100%" height="100%"
				id="uploadTabPanel">
				<next:Html>
				  <iframe id="upload" src="../comm/uploadfileDetail.jsp?peopleId='<%=request.getParameter("peopleId")%>'&serviceType='81'"
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
	   				</iframe>
				</next:Html>
		</next:Panel>
		</next:Tabs>
	</next:TabPanel>
</next:Panel>

</body>
</html>