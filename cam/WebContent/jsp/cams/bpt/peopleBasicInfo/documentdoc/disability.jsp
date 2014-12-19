<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%
	String tableUrl = "";
    String emigrateUrl = "";//迁移信息url
	String serviceType = request.getParameter("serviceType");
	String peopleId = request.getParameter("peopleId");
	String applyId = request.getParameter("applyId");
	if("11".equals(serviceType)) {
		tableUrl = "../../flow/disability/assessdisability/print/ass_disability_apptable.jsp?peopleId="+peopleId +"&applyId="+applyId;
	} else if("12".equals(serviceType)) {
		tableUrl = "../../flow/disability/adjustdisability/print/adjustDisabilitytable.jsp?peopleId="+peopleId +"&applyId="+applyId;
	} else if("15".equals(serviceType)) {
		emigrateUrl = "../../flow/disability/disabilitymigrate/ingoingprovince/intoProviPrint.jsp?peopleId="+peopleId +"&applyId="+applyId;
	} else if("16".equals(serviceType)) {
		emigrateUrl = "../../flow/disability/disabilitymigrate/provincemigration/provinceMigration_Detail.jsp?peopleId="+peopleId +"&applyId="+applyId;
	} else if("19".equals(serviceType)) {
		emigrateUrl = "../../flow/disability/disabilitymigrate/emigration/emigration_Detail.jsp?peopleId="+peopleId +"&applyId="+applyId;
	}
%>
<html>
<head>
<title>伤残文书管理</title>
<next:ScriptManager />
<script language="javascript">
			var peopleId='<%=request.getParameter("peopleId")%>';
			var applyId='<%=request.getParameter("applyId")%>';
			var serviceType = '<%=request.getParameter("serviceType")%>';
			
			var tableUrl = ""; //审批表url
			var docs="";
			
			function init() {
				docs = getDoc("Disability");
				var allPanel = L5.getCmp("allPanel");
				var approvetable = L5.getCmp("approvetablePanel");//审批表
				var noticeTab = L5.getCmp("noticeTabPanel");//受理通知书
				var disabilityIdentiTal = L5.getCmp("disabilityIdentiTabPanel");//介绍信
				var openTable = L5.getCmp("openTabPanel");//公式书
				var decisionTab = L5.getCmp("decisionLetterTabPanel");//不予评定决定书
				var physicalv = L5.getCmp("physicalv");//体检表
				var physicala = L5.getCmp("physicala");//体检表
				var emigrate = L5.getCmp("emigrate");//迁移信息
				var exchaTab = L5.getCmp("exchaTable");//换证补证
				var intoTable = L5.getCmp("intoTable");//残疾人员抚恤关系迁入表
				
				
				if(serviceType == "11" || serviceType == "12") { //评残|| 调残
					if(serviceType == "11") {
						decisionTab.setTitle("不予评定决定书");
						if(isTrue("examination")){
							physicala.on("activate",function() {
								func("physicala");
							});//参试体检表
						}
						
					}else {
						allPanel.remove(physicala);
					}
					allPanel.remove(emigrate);
					allPanel.remove(exchaTab);
					allPanel.remove(intoTable);
					approvetable.on("activate",function () {
						func("tablePanel");
					});//审批表
					
					if(isTrue("notice")){
						noticeTab.on("activate",function() {
							func("noticTabPanel");
						});//受理通知书
					}else{
						allPanel.remove(noticeTab);
					}
					if(isTrue("identity")){
						disabilityIdentiTal.on("activate",function () {
							func("disabilityIdentiTabPanel");
						});//介绍信
					}else{
						allPanel.remove(disabilityIdentiTal);
					}
					if(isTrue("open")){
						openTable.on("activate",function () {
							func("openTabPanel");
						});//公式书
					}else{
						allPanel.remove(openTable);
					}
					if(isTrue("decision")){
						decisionTab.on("activate",function() {
							func("decisionTabPanel");
						});//不予评定决定书
					}else{
						allPanel.remove(decisionTab);
					}
					if(isTrue("examination")){
						physicalv.on("activate",function() {
							func("physicalv");
						});//体检表
					}else{
						allPanel.remove(physicalv);
					}
					
				} else { 
					allPanel.remove(approvetable);
					allPanel.remove(noticeTab);
					allPanel.remove(disabilityIdentiTal);
					allPanel.remove(openTable);
					allPanel.remove(decisionTab);
					allPanel.remove(physicalv);
					allPanel.remove(physicala);
					if(serviceType == "13") { //换证补证
						allPanel.remove(emigrate);
						allPanel.remove(intoTable);
						exchaTab.on("activate",function() {
							func("exchaTab");
						});//换证补证
					} else if (serviceType == "14") {//残疾人员抚恤关系迁入表
						allPanel.remove(emigrate);
						allPanel.remove(exchaTab);
						intoTable.on("activate",function() {
							func("tableFrame");
						});//残疾人员抚恤关系迁入表
					} else if(serviceType == "15" || serviceType == "16") {
						allPanel.remove(intoTable);
						allPanel.remove(exchaTab);
						emigrate.on("activate",function() {
							func("emigrate");
						});//迁移信息
					}
				}
			
			}
				
			function func(frameId){  
				var srcUrl = document.getElementById(frameId);
				if(srcUrl == null || srcUrl == "") {
					return;
				} else {
					srcUrl = srcUrl.src;
				}
				document.getElementById(frameId).src=srcUrl;
			}
			function isTrue(str){
				
				for(var i=0;i<docs.length-1;i++){
					if (str==docs[i]){
						return true;
					}
				}
			}
			function getDoc(service){
				var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.DocumentDocCommand");
				command.setParameter("people_id", peopleId);
				command.setParameter("apply_id", applyId);
				command.setParameter("service_type", serviceType);
				command.setParameter("service", service);
				command.execute("getDoc");
				
				if (!command.error) {
					var map = command.getReturn("map");
					var doc = map.split(";");
					return doc;
				}
			}
				
		</script>
</head>
<body>
<next:TabPanel id="allPanel">
	<next:Tabs>
		<next:Panel title="审批表" width="100%" height="100%"
			id="approvetablePanel" name="approvetablePaneltablePanel"
			autoScroll="false">
			<next:Html>
				<iframe id="tablePanel"
					src="<%=tableUrl %>"
					frameborder="no" border="0" marginwidth="0" marginheight="0"
					scrolling="no" allowtransparency="yes" width="100%" height="100%">
				</iframe>
			</next:Html>
		</next:Panel>
		<next:Panel title="受理通知书" width="100%" height="100%"
			id="noticeTabPanel">
			<next:Html>
				<iframe id="noticTabPanel"
					src="../../flow/disability/assessdisability/acceptNoticeDetail.jsp?peopleId=<%=request.getParameter("peopleId")%>&applyId=<%=request.getParameter("applyId")%>"
					frameborder="no" border="0" marginwidth="0" marginheight="0"
					scrolling="no" allowtransparency="yes" width="100%" height="100%">
				</iframe>
			</next:Html>
		</next:Panel>
		<next:Panel title="介绍信" width="100%" height="100%"
			id="disabilityIdentiTabPanel">
			<next:Html>
				<iframe id="disabilityIdentiTabPanel"
					src="../../flow/disability/assessdisability/introductionLetterDetail.jsp?peopleId=<%=request.getParameter("peopleId")%>&applyId=<%=request.getParameter("applyId")%>"
					frameborder="no" border="0" marginwidth="0" marginheight="0"
					scrolling="no" allowtransparency="yes" width="100%" height="100%">
				</iframe>
			</next:Html>
		</next:Panel>

		<next:Panel title="公示书" width="100%" height="100%" id="openTabPanel">
			<next:Html>
				<iframe id="openTabPanel"
					src="../../flow/disability/assessdisability/openDisabilitydetail.jsp?peopleId=<%=request.getParameter("peopleId")%>&applyId=<%=request.getParameter("applyId")%>"
					frameborder="no" border="0" marginwidth="0" marginheight="0"
					scrolling="no" allowtransparency="yes" width="100%" height="100%">
				</iframe>
			</next:Html>
		</next:Panel>
		<next:Panel title="不予调整决定书" width="100%" height="100%"
			id="decisionLetterTabPanel">
			<next:Html>
				<iframe id="decisionTabPanel"
					src="../../flow/disability/assessdisability/decisionLetterDetail.jsp?peopleId=<%=request.getParameter("peopleId")%>&applyId=<%=request.getParameter("applyId")%>"
					frameborder="no" border="0" marginwidth="0" marginheight="0"
					scrolling="no" allowtransparency="yes" width="100%" height="100%">
				</iframe>
			</next:Html>
		</next:Panel>
		<next:Panel title="体检表" width="100%" height="100%"
			id="physicalv">
			<next:Html>
				<iframe id="physicalv"
					src="../../flow/disability/assessdisability/bptphysicalexamination/bptphysicalexamination_deatil.jsp?peopleId=<%=request.getParameter("peopleId")%>&applyId=<%=request.getParameter("applyId")%>"
					frameborder="no" border="0" marginwidth="0" marginheight="0"
					scrolling="no" allowtransparency="yes" width="100%" height="100%">
				</iframe>
			</next:Html>
		</next:Panel>
		
		<next:Panel title="参试体检表" width="100%" height="100%"
			id="physicala">
			<next:Html>
				<iframe id="physicala"
					src="../../flow/disability/assessdisability/bptexamination/bptexamination_deatil.jsp?peopleId=<%=request.getParameter("peopleId")%>&applyId=<%=request.getParameter("applyId")%>"
					frameborder="no" border="0" marginwidth="0" marginheight="0"
					scrolling="no" allowtransparency="yes" width="100%" height="100%">
				</iframe>
			</next:Html>
		</next:Panel>
		<next:Panel title="迁移信息" width="100%" height="100%"
			id="emigrate">
			<next:Html>
				<iframe id="emigrate"
					src="<%=emigrateUrl%>"
					frameborder="no" border="0" marginwidth="0" marginheight="0"
					scrolling="no" allowtransparency="yes" width="100%" height="100%">
				</iframe>
			</next:Html>
		</next:Panel>
		<next:Panel id="exchaTable" width="100%" height="100%" autoScroll="false" title="换证,补证信息">
				<next:Html>
				    <iframe id="exchaTab" src="../../../../../jsp/cams/bpt/flow/disability/exchacertidisa/print/exchaCertiDisatable.jsp?peopleId=<%=request.getParameter("peopleId")%>&applyId=<%=request.getParameter("applyId")%>"
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
	   				</iframe>
				</next:Html>
			</next:Panel>
			<next:Panel title="残疾人员抚恤关系迁入表" width="100%" height="100%" id="intoTable">
				<next:Html>
				    <iframe id="tableFrame" src="../../../../../jsp/cams/bpt/flow/disability/veteransshift/print/disabilityInfoProvince_table.jsp?peopleId=<%=request.getParameter("peopleId")%>&applyId=<%=request.getParameter("applyId")%>"
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
	   				</iframe>
			</next:Html>
		</next:Panel>		
	</next:Tabs>
</next:TabPanel>
</body>
</html>