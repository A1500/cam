<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<title>60周岁以上农村籍退役士兵修改管理界面</title>
<next:ScriptManager/>
</head>
<body> 
<next:Panel autoHeight="true" bodyStyle="width:100%" width="100%">
	<next:TabPanel id="tabPanel">
		<next:Tabs>
		<next:Panel title="基本信息" width="100%" height="100%"
				id="peopleInfoTabPanel">
				<next:Html>
				  <iframe id="peopleInfo" src="../../comm/peopleDetail.jsp?peopleId=<%=request.getParameter("peopleId")%>";
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
	   				</iframe>
				</next:Html>
		</next:Panel>
		<next:Panel title="类别信息" width="100%" height="100%" id="countretiredsoldierTabPanel">
				<next:Html>
				  <iframe id="countretiredsoldierTabPanelFrame" src="../../dataCollection/bptcountretiredsoldier/bptcountretiredsoldierInfo.jsp?peopleId='<%=request.getParameter("peopleId")%>'"
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="yes" allowtransparency="yes" width="100%" height="100%">
	   				</iframe>
				</next:Html>
		</next:Panel>
		<next:Panel title="家庭成员信息" width="100%" height="100%" id="memberTabPanel">
				<next:Html>
				  <iframe id="member" src="../../comm/memberListDetail.jsp?familyId=<%=request.getParameter("familyId")%>"
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
	   				</iframe>
				</next:Html>
		</next:Panel>
		<next:Panel title="住房信息" width="100%" height="100%" id="houseTabPanel">
				<next:Html>
				  <iframe id="house" src="../../comm/houseDetail.jsp?familyId=<%=request.getParameter("familyId")%>" frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
	   				</iframe>
				</next:Html>
		</next:Panel>
		<next:Panel title="电子档案" width="100%" height="100%"
				id="uploadTabPanel">
				<next:Html>
				  <iframe id="upload" src="../../comm/uploadfileDetail.jsp?peopleId=<%=request.getParameter("peopleId")%>&serviceType=81&applyId=<%=request.getParameter("applyId")%>"
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
	   				</iframe>
				</next:Html>
		</next:Panel>
		<next:Panel title="公示书" width="100%" height="100%"
				id="publicityDoc">
				<next:Html>
				  <iframe id="countrySoldieropenFrame" src="openSoldierDetail.jsp?peopleId=<%=request.getParameter("peopleId")%>&applyId=<%=request.getParameter("applyId")%>"
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
	   				</iframe>
				</next:Html>
		</next:Panel>
		<next:Panel title="审批表" width="100%" height="100%"
				id="countretiredsoldierApprove">
				<next:Html>
				<iframe id="countretiredsoldierApproveFrame" src="soldierApproveDoc.jsp?peopleId=<%=request.getParameter("peopleId")%>&applyId=<%=request.getParameter("applyId")%>""
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
	   			</iframe>	
				</next:Html>
		</next:Panel>
		<next:Panel title="县级审批" width="100%" height="100%"
				id="countrySoldierTownApprove">
				<next:Html>
				  <iframe id="countrySoldierTownApproveFrame" src="townApprovedDetail.jsp?peopleId=<%=request.getParameter("peopleId")%>&applyId=<%=request.getParameter("applyId")%>&serviceType=81"
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
	   				</iframe>
				</next:Html>
		</next:Panel>
		</next:Tabs> 
	</next:TabPanel>
</next:Panel>
<script type="text/javascript">
function init(){
var disabilityIdentiTabPanel = L5.getCmp("countretiredsoldierApprove");
	disabilityIdentiTabPanel.on("activate",function () {
		var obj = document.getElementById("countretiredsoldierApproveFrame");
		obj.src=obj.src;
	});
	var publicityDoc = L5.getCmp("publicityDoc");
	publicityDoc.on("activate",function () {
		var obj = document.getElementById("countrySoldieropenFrame");
		obj.src=obj.src;
	});
}
</script>
</body>
</html>
