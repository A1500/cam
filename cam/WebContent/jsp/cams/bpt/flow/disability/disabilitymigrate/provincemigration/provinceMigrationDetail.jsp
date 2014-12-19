<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<script type="text/javascript">
	var peopleId = '<%=request.getParameter("peopleId")%>';
	var applyId = '<%=request.getParameter("applyId")%>';
</script>
<html>
<head>
<title> 伤残人员省内迁移信息查看</title>
<next:ScriptManager />
<script type="text/javascript" src="provinceMigrationUpdate.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
</head>
<body>
<model:datasets>
	<!-- 伤残人员省内迁移 -->
	<model:dataset id="ProvinceMigrationDataSet" cmd="com.inspur.cams.bpt.manage.cmd.BptProvinceMigrateQueryCommand" method="queryDisaUpdateRecord" global="true">
		<model:record fromBean="com.inspur.cams.bpt.base.data.BptProvinceMigrate">
			<model:field name="idCard" type="string"/>
			<model:field name="name" type="string"/>
			<model:field name="sex" type="string"/>
			<model:field name="disabilityCaseCode" type="string"/>
			<model:field name="disabilityLevelCode" type="string"/>
			<model:field name="disabilityNo" type="string"/>
			<model:field name="disabilityTypeCode" type="string"/>
			<model:field name="ingoingName" type="string"/>
			<model:field name="domicileName" type="string"  />
			<model:field name="apanageName" type="string"  />
		</model:record>
	</model:dataset>
	<!-- 性别 -->
	<model:dataset id="SexDataset" enumName="COMM.SEX" autoLoad="true" global="true"></model:dataset>
	<!-- 民族 -->
	<model:dataset id="NationDataset" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_NATION'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset> 
	<!-- 伤残性质 -->
	<model:dataset id="DisabilityCaseDataset" enumName="CASE.CODE" autoLoad="true" global="true"></model:dataset>
	<!-- 伤残等级 -->
	<model:dataset id="DisabilityLevelDataset" enumName="LEVEL.CODE" autoLoad="true" global="true"></model:dataset>
	<!-- 伤残类别代码 -->
	<model:dataset id="DisabilityTypeCodeEnum" enumName="DISABILITY.TYPE.CODE" autoLoad="true" global="true"></model:dataset>
</model:datasets>
<next:Panel autoHeight="true"   bodyStyle="width:100%" width="100%" >
	<next:TabPanel>
		<next:Tabs>
		
		<next:Panel title="基本信息" width="100%" height="100%"
				id="peopleInfoTabPanel">
				<next:Html>
				  <iframe id="peopleInfo" src="../../../../comm/peopleDetail.jsp?peopleId=<%=request.getParameter("peopleId")%>"
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
	   				</iframe>
				</next:Html>
		</next:Panel>
		
		<next:Panel title="类别信息" width="100%" height="100%"
				id="disabilityTypeTabPanel">
				<next:Html>
				  <iframe id="disabilityType" src="../../assessdisability/disabilityTypeDetail.jsp?peopleId=<%=request.getParameter("peopleId")%>"
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
		
		<next:Panel title="电子档案" width="100%" height="100%"
				id="uploadTabPanel">
				<next:Html>
				    <iframe id="upload" src="../../../../comm/uploadfileDetail.jsp?peopleId=<%=request.getParameter("peopleId")%>&serviceType=16&applyId=<%=request.getParameter("applyId")%>"
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
	   				</iframe>
				</next:Html>
		</next:Panel>

			<next:Panel width="100%" id="emigrationTabPanel" height="100%" autoScroll="false" title="迁移信息">
				<next:Html>
				    <iframe id="emigration" src="provinceMigration_Detail.jsp?peopleId=<%=request.getParameter("peopleId")%>&applyId=<%=request.getParameter("applyId")%>"
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
	   				</iframe>
				</next:Html>
					 
			</next:Panel>
			<next:Panel title="县级审核" width="100%" height="100%"
				id="eTabPanel">
				<next:Html>
				  <iframe id="upload" src="../../../comm/townProvinceMigratApproveDetail.jsp?applyId=<%=request.getParameter("applyId")%>"
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
	var ProvinceMigrationDataSet = L5.DatasetMgr.lookup("ProvinceMigrationDataSet");
	ProvinceMigrationDataSet.setParameter("PEOPLE_ID",peopleId);
 	ProvinceMigrationDataSet.setParameter("APPLY_ID",applyId);
 	ProvinceMigrationDataSet.load();
 	L5.getCmp("emigrationTabPanel").on("activate",func);
	L5.QuickTips.init();
}
function func(){  
		var src = document.getElementById("emigration").src;
		document.getElementById("emigration").src=src;
	}
function print() {
		var url="../../../../../comm/print/jspcommonprint.jsp?";
		var width = 1024;
		var height = 768;
	    window.showModalDialog(url,window,"scroll:yes;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:1");
	}
</script>
</html>
