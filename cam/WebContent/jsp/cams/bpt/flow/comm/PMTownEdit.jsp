<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<title>人员信息</title>
<next:ScriptManager />

<script>    
            var peopleId='<%=request.getParameter("peopleId")%>';
			var familyId='<%=request.getParameter("familyId")%>';
			var applyId='<%=request.getParameter("applyId")%>';
			var serviceType='<%=request.getParameter("serviceType")%>';
		</script>
</head>
<body>
<next:Panel autoHeight="true"   bodyStyle="width:100%" width="100%" autoScroll="false">
	<next:TabPanel>
		<next:Tabs>

		<next:Panel title="基本信息" width="100%" height="100%"
				id="peopleInfoTabPanel">
				<next:Html>
				  <iframe id="peopleInfo" src="../../comm/peopleDetail.jsp?peopleId=<%=request.getParameter("peopleId")%>"
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
	   				</iframe>
				</next:Html>
		</next:Panel>

		<next:Panel title="类别信息" width="100%" height="100%"
				id="TypeTabPanel">
				<next:Html>
				  <iframe id="Type" src=""
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
	   				</iframe>
				</next:Html>
		</next:Panel>
	<next:Panel title="家庭成员信息" width="100%" height="100%"
				id="memberTabPanel">
				<next:Html>
				  <iframe id="member" src="../../comm/memberListDetail.jsp?familyId=<%=request.getParameter("familyId")%>"
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
	   				</iframe>
				</next:Html>
		</next:Panel>
		
		<next:Panel title="住房信息" width="100%" height="100%"
				id="houseTabPanel">
				<next:Html>
				  <iframe id="house" src="../../comm/houseDetail.jsp?familyId=<%=request.getParameter("familyId")%>"
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
	   				</iframe>
				</next:Html>
		</next:Panel>

		
		<next:Panel title="电子档案" width="100%" height="100%"
				id="uploadTabPanel">
				<next:Html>
				  <iframe id="upload" src="../../comm/uploadfile.jsp?peopleId=<%=request.getParameter("peopleId")%>&serviceType=<%=request.getParameter("serviceType")%>&applyId=<%=request.getParameter("applyId")%>"
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
	   				</iframe>
				</next:Html>
		</next:Panel>
		<next:Panel title="县级审批意见" width="100%" height="100%"
				id="uploadTabPanel1">
				<next:Html>
				  <iframe id="upload11" src="../comm/townProvinceMigratApprove.jsp?applyId=<%=request.getParameter("applyId")%>"
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
	   				</iframe>
				</next:Html>
		</next:Panel>
		</next:Tabs>
	</next:TabPanel>
</next:Panel>
</body>
<script type="text/javascript">
	var updateUrl;
	var url;
	function init() {
		
		setPanel();
		var typePanel = L5.getCmp("TypeTabPanel"); // 设置类别信息url
		typePanel.on("activate",funcFrameUrl);
		
	}
	
	
	function funcFrameUrl() { //类别信息url跳转
			document.getElementById("Type").src=url;
	}
	
	function setPanel() { //设置panel的隐藏
		
		if(serviceType=="16"){
			//隐藏除伤残以外的其他tab，待写
			url = "../../flow/disability/assessdisability/disabilityTypeDetail.jsp?peopleId=<%=request.getParameter("peopleId")%>";
		}
		if(serviceType=="23"){
			//隐藏除三属以外的其他tab，待写
			
			url = "../../flow/dependant/dependantTypeDetail.jsp?peopleId=<%=request.getParameter("peopleId")%>";
		}
		if(serviceType=="43"){
			//隐藏除在乡以外的其他tab
			url = "../../flow/demobilized/applydemobilized/demobilizedInfo.jsp?peopleId=<%=request.getParameter("peopleId")%>";
		}
		if(serviceType=="47"){
			//隐藏除带病回乡以外的其他tab，待写
			url = "../../flow/demobilizedillness/applydemobilizedillness/demobilizedIllnessInfo.jsp?peopleId=<%=request.getParameter("peopleId")%>";
		}
		if(serviceType=="53"){
			
			url = "../../flow/war/bptwarDetail.jsp?peopleId=<%=request.getParameter("peopleId")%>";
		}
		if(serviceType=="63"){
			//隐藏除参试以外的其他tab，待写
			
			url = "../../flow/tested/bpttestedDetail.jsp?peopleId=<%=request.getParameter("peopleId")%>";
		}
	}

</script>
</html>
