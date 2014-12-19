<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
<head>
<title>优抚对象基本信息修改</title>
<next:ScriptManager />
		<script>
			var idField='<%=request.getParameter("dataBean")%>';
			var method='<%=request.getParameter("method")%>';
			var username = '<%=request.getParameter("username")%>';
			var objectType = '<%=request.getParameter("objectType")%>';
			var organCode = '<%=BspUtil.getOrganCode()%>';
            var organName = '<%=BspUtil.getOrganName()%>';
		</script>
<script type="text/javascript" src="noPhotoBasicInfoUpdate.js"></script>
</head>
<body>
<model:datasets>
	<!-- 人员信息 -->
	<model:dataset id="BaseinfoPeopleDataSet" cmd="com.inspur.cams.bpt.manage.cmd.BptBaseinfoPeopleQueryCommand"
			method="queryPeopleInfo" global="true">
		<model:record fromBean="com.inspur.cams.comm.baseinfo.data.BaseinfoPeople">
		   <model:field name="domicileName" type="string"/>
		   <model:field name="apanageName" type="string"/>
		</model:record>
		<model:params>
			<model:param name="PEOPLE_ID" value='<%=request.getParameter("peopleId")%>'></model:param>
		</model:params>
	</model:dataset>
	<!-- 家庭信息 -->
	<model:dataset id="BaseinfoFamilyDataSet" cmd="com.inspur.cams.bpt.manage.cmd.BptBaseinfoPeopleQueryCommand"
		method="queryFamilyInfo" global="true">
		<model:record fromBean="com.inspur.cams.comm.baseinfo.data.BaseinfoFamily"></model:record>
		<model:params>
			<model:param name="FAMILY_ID" value='<%=request.getParameter("familyId")%>'></model:param>
		</model:params>
	</model:dataset>
</model:datasets>

<next:Panel autoHeight="true"   bodyStyle="width:100%" width="100%" autoScroll="false">

	<next:TabPanel id="tabPanel" name="tabPanel">
		<next:Tabs>
			<next:Panel title="人员基本信息" width="100%" height="100%"
				id="peopleInfoTabPanel">
				<next:Html>
	   			  <iframe id="peopleInfo" src="../comm/peopleUpdate.jsp?peopleId=<%=request.getParameter("peopleId")%>"
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
	   				</iframe>
				</next:Html>
			</next:Panel>
			<next:Panel title="类别信息" width="100%" height="100%" id="disabilityPanel">
				<next:Html>
					<iframe id="disability" src="../peopleBasicInfo/disabilityTypeUpdate.jsp?peopleId=<%=request.getParameter("peopleId")%>"
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
	   				</iframe>
				</next:Html>
			</next:Panel>
			<next:Panel title="类别信息" width="100%" height="100%" id="dependantPanel">
				<next:Html>
					<iframe id="disability" src="../dataCollection/dependant/dependantTypeUpdate.jsp?peopleId='<%=request.getParameter("peopleId")%>'"
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
	   				</iframe>
				</next:Html>
			</next:Panel>
			<next:Panel title="类别信息" width="100%" height="100%" id="demobilizedPanel">
				<next:Html>
					<iframe id="disability" src="../dataCollection/demobilized/demobilizedEdit.jsp?peopleId='<%=request.getParameter("peopleId")%>'"
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
	   				</iframe>
				</next:Html>
			</next:Panel>
			<next:Panel title="类别信息" width="100%" height="100%" id="demobilizedIllnessPanel">
				<next:Html>
					<iframe id="disability" src="../dataCollection/demobilizedIllness/demobilizedIllnessEdit.jsp?peopleId='<%=request.getParameter("peopleId")%>'"
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
	   				</iframe>
				</next:Html>
			</next:Panel>
			<next:Panel title="类别信息" width="100%" height="100%" id="warPanel">
				<next:Html>
					<iframe id="disability" src="../dataCollection/war/bptwarUpdate.jsp?peopleId=<%=request.getParameter("peopleId")%>"
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
	   				</iframe>
				</next:Html>
			</next:Panel>
			<next:Panel title="类别信息" width="100%" height="100%" id="testedPanel">
				<next:Html>
					<iframe id="disability" src="../dataCollection/tested/bpttestedUpdate.jsp?peopleId='<%=request.getParameter("peopleId")%>'"
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
	   				</iframe>
				</next:Html>
			</next:Panel>
			<next:Panel title="类别信息" width="100%" height="100%" id="countretiredsoldierPanel">
				<next:Html>
					<iframe id="disability" src="../dataCollection/bptcountretiredsoldier/cbptcountretiredsoldierEdit.jsp?peopleId='<%=request.getParameter("peopleId")%>'"
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
	   				</iframe>
				</next:Html>
			</next:Panel>
			<next:Panel title="类别信息" width="100%" height="100%" id="martyrOffspringPanel">
				<next:Html>
					<iframe id="disability" src="../dataCollection/martyroffspring/cmartyrOffspringUpdate.jsp?peopleId=<%=request.getParameter("peopleId")%>"
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
	   				</iframe>
				</next:Html>
			</next:Panel>
			<next:Panel title="家庭成员信息" width="100%" height="100%"
				id="memberTabPanel">
				<next:Html>
				  <iframe id="member" src="../comm/memberList.jsp?familyId=<%=request.getParameter("familyId")%>"
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
	   				</iframe>
				</next:Html>
			</next:Panel>
			<next:Panel title="住房信息" width="100%" height="100%"
				id="houseTabPanel">
				<next:Html>
				  <iframe id="house" src="../peopleBasicInfo/houseUpdate.jsp?familyId=<%=request.getParameter("familyId")%>"
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
	   				</iframe>
				</next:Html>
			</next:Panel>
			
			<next:Panel title="状态变更" autoHeight="true" autoWidth="true" autoScroll="false"
				id="stateChangeTabPanel">
				<next:Html>
					<iframe id="instance" src="../peopleBasicInfo/stateChangeInsert.jsp?peopleId=<%=request.getParameter("peopleId")%>&username=<%=request.getParameter("username")%>
					&idCard=<%=request.getParameter("idCard")%>&objectState=<%=request.getParameter("objectState")%>&objectType=<%=request.getParameter("objectType")%>"
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="480">
	   				</iframe>
				</next:Html>
			</next:Panel>
			 <next:Panel title="电子档案" autoHeight="true" autoWidth="true"
				id="electronicTabPanel">
				 <next:Html>
					<iframe id="electronic" src="../peopleBasicInfo/electronicListUpdate.jsp?peopleId=<%=request.getParameter("peopleId")%>&username=<%=request.getParameter("username")%>&objectType=<%=request.getParameter("objectType") %>"
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="480">
	   				</iframe>
				</next:Html>
			</next:Panel>
			<next:Panel title="信访管理" autoHeight="true" autoWidth="true" autoScroll="false"
				id="petitionTabPanel">
				<next:Html>
					<iframe id="instance" src="../peopleBasicInfo/petitionInsert.jsp?peopleId=<%=request.getParameter("peopleId")%>&username=<%=request.getParameter("username")%>
					&idCard=<%=request.getParameter("idCard")%>&objectType=<%=request.getParameter("objectType")%>"
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="480">
	   				</iframe>
				</next:Html>
			</next:Panel>
			<next:Panel title="定期认证" autoHeight="true" autoWidth="true" autoScroll="false"
				id="regularIdentificationTabPanel">
				<next:Html>
					<iframe id="instance" src="../peopleBasicInfo/regularIdentificationInsert.jsp?peopleId=<%=request.getParameter("peopleId")%>&username=<%=request.getParameter("username")%>
					&idCard=<%=request.getParameter("idCard")%>&objectType=<%=request.getParameter("objectType")%>"
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="480">
	   				</iframe>
				</next:Html>
			</next:Panel>
		</next:Tabs>
	</next:TabPanel>
</next:Panel>

</body>
</html>
