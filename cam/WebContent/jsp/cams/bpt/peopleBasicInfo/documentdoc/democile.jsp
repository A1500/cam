<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%
	String tableUrl = "";
	String decisionUrl = "";
	String openUrl="";
	String checkUrl="";
	String examUrl="";
    String emigrateUrl = "";//迁移信息url
	String serviceType = request.getParameter("serviceType");
	String peopleId = request.getParameter("peopleId");
	String applyId = request.getParameter("applyId");
    if("41".equals(serviceType)) {
    	tableUrl = "../../flow/demobilized/applydemobilized/print/demobilizedApp_table.jsp?peopleId="+peopleId +"&applyId="+applyId;
    	decisionUrl = "../../flow/demobilized/applydemobilized/demoDecisionLetterDetail.jsp?peopleId="+peopleId +"&applyId="+applyId;
    	openUrl="../../flow/demobilizedillness/applydemobilizedillness/openDemoIllDetail.jsp?peopleId="+peopleId +"&applyId="+applyId;
    } else if("42".equals(serviceType)) {
		emigrateUrl = "../../flow/demobilized/demoingoingprovince/demobilizedPrint.jsp?peopleId="+peopleId +"&applyId="+applyId;
	} else if("43".equals(serviceType)) {
		emigrateUrl = "../../flow/demobilized/demoprovincemigrate/demoProvince_Detail.jsp?peopleId="+peopleId +"&applyId="+applyId;
	} else if("45".equals(serviceType)) {
		tableUrl = "../../flow/demobilizedillness/table/demobilized_apptable.jsp?peopleId="+peopleId +"&applyId="+applyId;
		decisionUrl = "../../flow/demobilizedillness/applydemobilizedillness/demoIllnessDecisionLetterDetail.jsp?peopleId="+peopleId +"&applyId="+applyId;
		openUrl="../../flow/demobilizedillness/applydemobilizedillness/openDemoIllDetail.jsp?peopleId="+peopleId +"&applyId="+applyId;
		checkUrl="../../flow/demobilizedillness/applydemobilizedillness/bptphysicalexamination/bptDemobilizedillCheck_deatil.jsp?peopleId="+peopleId +"&applyId="+applyId;
		examUrl="../../flow/demobilizedillness/applydemobilizedillness/bptphysicalexamination/bptphysicalexamination_deatil.jsp?peopleId="+peopleId +"&applyId="+applyId;
	} else if("46".equals(serviceType)) {
		emigrateUrl = "../../flow/demobilizedillness/illingoingmigrate/demobilizedIllnessIntoPrint.jsp?peopleId="+peopleId +"&applyId="+applyId;
	} else if("47".equals(serviceType)) {
		emigrateUrl = "../../flow/demobilizedillness/illprovincemigrate/illprovinceMigrationDetail.jsp?peopleId="+peopleId +"&applyId="+applyId;
	} else if("4A".equals(serviceType)) {
		emigrateUrl = "../../flow/demobilized/demobilizedmigrate/demomigration_Detail.jsp?peopleId="+peopleId +"&applyId="+applyId;
	} else if("4B".equals(serviceType)) {
		emigrateUrl = "../../flow/demobilizedillness/illmigrate/illMigrationDetail.jsp?peopleId="+peopleId +"&applyId="+applyId;
	}
    
%>
<html>
<head>
<title>在乡复员、带病回乡文书管理</title>
<next:ScriptManager />
<script language="javascript">
			var peopleId='<%=request.getParameter("peopleId")%>';
			var applyId='<%=request.getParameter("applyId")%>';
			var serviceType = '<%=request.getParameter("serviceType")%>';
			var tableUrl = ""; //审批表url
			var docs="";
			
			function init() {
				docs = getDoc("Democile");
				var allPanel = L5.getCmp("allPanel");
				var approvetable = L5.getCmp("approvetablePanel");//审批表
				var emigrate = L5.getCmp("emigrate");//迁移信息
				var openTabPanel = L5.getCmp("openTabPanel");//公示信息
				var decisionLetterTabPanel = L5.getCmp("decisionLetterTabPanel");//决定书信息
				var checkTabPanel = L5.getCmp("checkTabPanel");//送检书信息
				var examTabPanel = L5.getCmp("examTabPanel");//体检书
				
				if(serviceType == "41" || serviceType == "45" ) { //申请
					allPanel.remove(emigrate);
					approvetable.on("activate",function () {
						func("tablePanel");
					});//审批表
					if(isTrue("decision")){
						decisionLetterTabPanel.on("activate",function() {
							func("decisionLetterTab");
						});//决定书
					}else{
						allPanel.remove(decisionLetterTabPanel);
					}
					if(isTrue("open")){
						openTabPanel.on("activate",function() {
							func("openTab");
						});//公示书
					}else{
						allPanel.remove(openTabPanel);
					}
					
					if(isTrue("examination")){
						examTabPanel.on("activate",function() {
							func("examLetterTab");
						});//体检表
					}else{
						allPanel.remove(examTabPanel);
					}
					if(isTrue("check")){
						checkTabPanel.on("activate",function() {
							func("checkTabPanel");
						});//送检表
					}else{
						allPanel.remove(checkTabPanel);
					}
					
				} else { 
					allPanel.remove(approvetable);
					allPanel.remove(decisionLetterTabPanel);
					emigrate.on("activate",function() {
						func("emigrate");
					});//迁移信息
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
		<next:Panel title="公示书" width="100%" height="100%"
			id="openTabPanel" name="openTabPanel"
			autoScroll="false">
			<next:Html>
				<iframe id="openTab"
					src="<%=openUrl%>"
					frameborder="no" border="0" marginwidth="0" marginheight="0"
					scrolling="no" allowtransparency="yes" width="100%" height="100%">
				</iframe>
			</next:Html>
		</next:Panel>
		<next:Panel title="不予评定决定书" width="100%" height="100%"
			id="decisionLetterTabPanel" name="decisionLetterTabPanel"
			autoScroll="false">
			<next:Html>
				<iframe id="decisionLetterTab"
					src="<%=decisionUrl%>"
					frameborder="no" border="0" marginwidth="0" marginheight="0"
					scrolling="no" allowtransparency="yes" width="100%" height="100%">
				</iframe>
			</next:Html>
		</next:Panel>
		<next:Panel title="体检表" width="100%" height="100%"
			id="examTabPanel" name="examTabPanel"
			autoScroll="false">
			<next:Html>
				<iframe id="examLetterTab"
					src="<%=examUrl%>"
					frameborder="no" border="0" marginwidth="0" marginheight="0"
					scrolling="no" allowtransparency="yes" width="100%" height="100%">
				</iframe>
			</next:Html>
		</next:Panel>
		<next:Panel title="病情送检表" width="100%" height="100%"
			id="checkTabPanel" name="checkTabPanel"
			autoScroll="false">
			<next:Html>
				<iframe id="checkTab"
					src="<%=checkUrl%>"
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
	</next:Tabs>
</next:TabPanel>
</body>
</html>