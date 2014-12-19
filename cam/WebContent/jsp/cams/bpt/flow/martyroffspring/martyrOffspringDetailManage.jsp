<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<title>部分烈士（错杀被平反人员）子女明细</title>
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
		<next:Panel title="类别信息" width="100%" height="100%" id="martyrOffspringTabPanel">
				<next:Html>
				  <iframe id="martyrOffspringTabPanelFrame" src="martyrOffspringDetail.jsp?peopleId=<%=request.getParameter("peopleId")%>"
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
				  <iframe id="upload" src="../../comm/uploadfileDetail.jsp?peopleId=<%=request.getParameter("peopleId")%>&serviceType=B1&applyId=<%=request.getParameter("applyId")%>"
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
	   				</iframe>
				</next:Html>
		</next:Panel>
		<next:Panel title="公示书" width="100%" height="100%"
				id="publicityDoc">
				<next:Html>
				  <iframe id="countrySoldierOpenFrame" src="openMartyDetail.jsp?peopleId=<%=request.getParameter("peopleId")%>&applyId=<%=request.getParameter("applyId")%>"
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
	   				</iframe>
				</next:Html>
		</next:Panel>
		<next:Panel title="审批表" width="100%" height="100%"
				id="martyrOffspringApprove">
				<next:Html>
				<iframe id="martyrOffspringApproveFrame" src="martyrOffspringApproveDoc.jsp?peopleId=<%=request.getParameter("peopleId")%>&applyId=<%=request.getParameter("applyId")%>""
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
	   			</iframe>	
				</next:Html>
		</next:Panel>
		
		<next:Panel title="县级审批" id="martyrOffspringTownApprove" width="100%" height="100%">
				<next:Html>
				    <iframe id="martyrOffspringTownApproveFrame" src="martyrOffspringTownDetail.jsp?peopleId=<%=request.getParameter("peopleId")%>&applyId=<%=request.getParameter("applyId")%>&serviceType=B1"
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
	   				</iframe>
				</next:Html>
		</next:Panel>
		</next:Tabs> 
	</next:TabPanel>
</next:Panel>
</body>
<script type="text/javascript">
	function init(){
		L5.QuickTips.init();
		L5.getCmp("martyrOffspringApprove").on("activate",func);
		L5.getCmp("publicityDoc").on("activate",funcOpen);
	}
	function func(){
		var src = document.getElementById("martyrOffspringApproveFrame").src;
		document.getElementById("martyrOffspringApproveFrame").src=src;
	}
	function funcOpen(){  
		var src = document.getElementById("countrySoldierOpenFrame").src;
		document.getElementById("countrySoldierOpenFrame").src=src;
	}
</script>
</html>