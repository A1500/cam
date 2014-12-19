<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%
	String tableUrl = "";
	String decisionUrl = "";
    String emigrateUrl = "";//迁移信息url
    String physical = ""; //体检url
	String serviceType = request.getParameter("serviceType");
	String peopleId = request.getParameter("peopleId");
	String applyId = request.getParameter("applyId");
    if("51".equals(serviceType)) {
    	tableUrl = "../../flow/war/table/war_apptable.jsp?peopleId="+peopleId +"&applyId="+applyId;
    	decisionUrl = "../../flow/war/openWarDetail.jsp?peopleId="+peopleId +"&applyId="+applyId;
    	physical = "../../flow/war/warDecisionLetterDetail.jsp?peopleId="+peopleId +"&applyId="+applyId;
    } else if("52".equals(serviceType)) {
		emigrateUrl = "../../flow/war/migrate/ingoingprovince/warIntoPrint.jsp?peopleId="+peopleId +"&applyId="+applyId;
	} else if("53".equals(serviceType)) {
		emigrateUrl = "../../flow/war/migrate/provincialmigration/provinceMigrationDetail.jsp?peopleId="+peopleId +"&applyId="+applyId;
	} else if("61".equals(serviceType)) {
		tableUrl = "../../flow/tested/table/test_apptable.jsp?peopleId="+peopleId +"&applyId="+applyId;
		decisionUrl = "../../flow/tested/openTestDetail.jsp?peopleId="+peopleId +"&applyId="+applyId;
		physical = "../../flow/tested/table/bptphysicalexamination/bptphysicalexamination_deatil.jsp?peopleId="+peopleId +"&applyId="+applyId;
	} else if("62".equals(serviceType)) {
		emigrateUrl = "../../flow/tested/testedmigrate/ingoingprovince/intoProviPrint.jsp?peopleId="+peopleId +"&applyId="+applyId;
	} else if("63".equals(serviceType)) {
		emigrateUrl = "../../flow/tested/testedmigrate/provincemigration/provinceMigrationDetail.jsp?peopleId="+peopleId +"&applyId="+applyId;
	} else if("55".equals(serviceType)) {
		emigrateUrl = "../../flow/war/migrate/emigration/emigrationDetail.jsp?peopleId="+peopleId +"&applyId="+applyId;
	} else if("65".equals(serviceType)) {
		emigrateUrl = "../../flow/tested/testedmigrate/emigration/emigrationDetail.jsp?peopleId="+peopleId +"&applyId="+applyId;
	}
    
%>
<html>
<head>
<title>参战、参试文书管理</title>
<next:ScriptManager />
<script language="javascript">
			var peopleId='<%=request.getParameter("peopleId")%>';
			var applyId='<%=request.getParameter("applyId")%>';
			var serviceType = '<%=request.getParameter("serviceType")%>';
			var tableUrl = ""; //审批表url
			var docs="";
			
			function init() {
				docs = getDoc("TestAndWar");
				var allPanel = L5.getCmp("allPanel");
				var approvetable = L5.getCmp("approvetablePanel");//审批表
				var emigrate = L5.getCmp("emigrate");//迁移信息
				var decisionLetterTabPanel = L5.getCmp("decisionLetterTabPanel");//决定书
				var physical = L5.getCmp("physical");
				
				if(serviceType == "51" || serviceType == "61" ) { //申请
					allPanel.remove(emigrate);
					if(serviceType == "51") {
						physical.setTitle("不予认定参战退役军人身份决定书");
					} else if(serviceType == "61") {
						physical.setTitle("人员体检表");
						approvetable.setTitle("参加核试验军队退役人员登记审核表");
					}
					approvetable.on("activate",function () {
						func("tablePanel");
					});//审批表
					if(isTrue("decision")){
						decisionLetterTabPanel.on("activate",function() {
							func("decisionLetterTab");
						});//公式书
					}else{
						allPanel.remove(decisionLetterTabPanel);
					}
					if(isTrue("decision")||isTrue("examination")){
						physical.on("activate",function() {
							func("physicalFrame");
						});//体检表或不予评定
					}else{
						allPanel.remove(physical);
					}
				} else { 
					allPanel.remove(approvetable);
					allPanel.remove(decisionLetterTabPanel);
					allPanel.remove(physical);
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
		<next:Panel title="参战退役人员登记审核表" width="100%" height="100%"
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
		<next:Panel title="公式书" width="100%" height="100%"
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
		<next:Panel title="人员体检表" width="100%" height="100%"
				id="physical">
				<next:Html>
				  <iframe id="physicalFrame" src="<%=physical%>"
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
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