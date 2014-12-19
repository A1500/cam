<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%
	String tableUrl = "";
	String decisionUrl = "";
    String emigrateUrl = "";//迁移信息url
	String serviceType = request.getParameter("serviceType");
	String peopleId = request.getParameter("peopleId");
	String applyId = request.getParameter("applyId");
    if("81".equals(serviceType)) {
    	tableUrl = "../../flow/countretiredsoldier/soldierApproveDoc.jsp?peopleId="+peopleId +"&applyId="+applyId;
    	decisionUrl = "../../flow/countretiredsoldier/openSoldierDetail.jsp?peopleId="+peopleId +"&applyId="+applyId;
    } else if("82".equals(serviceType)) {
		emigrateUrl = "../../flow/countretiredsoldier/soldiermigrate/ingoingprovince/sintoProviPrint.jsp?peopleId="+peopleId +"&applyId="+applyId;
	} else if("83".equals(serviceType)) {
		emigrateUrl = "../../flow/countretiredsoldier/soldiermigrate/provincemigration/sprovinceMigrationDetail.jsp?peopleId="+peopleId +"&applyId="+applyId;
	} else if("B1".equals(serviceType)) {
		tableUrl = "../../flow/martyroffspring/martyrOffspringApproveDoc.jsp?peopleId="+peopleId +"&applyId="+applyId;
		decisionUrl = "../../flow/martyroffspring/openMartyDetail.jsp?peopleId="+peopleId +"&applyId="+applyId;
	} else if("B2".equals(serviceType)) {
		emigrateUrl = "../../flow/martyroffspring/martymigrate/ingoingprovince/mintoProviPrint.jsp?peopleId="+peopleId +"&applyId="+applyId;
	} else if("B3".equals(serviceType)) {
		emigrateUrl = "../../flow/martyroffspring/martymigrate/provincemigration/mprovinceMigrationDetail.jsp?peopleId="+peopleId +"&applyId="+applyId;
	} else if("84".equals(serviceType)) {
		emigrateUrl = "../../flow/countretiredsoldier/soldiermigrate/emigration/sEmigrationDetail.jsp?peopleId="+peopleId +"&applyId="+applyId;
	} else if("B4".equals(serviceType)) {
		emigrateUrl = "../../flow/martyroffspring/martymigrate/emigration/martyEmigrationDetail.jsp?peopleId="+peopleId +"&applyId="+applyId;
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
				docs = getDoc("SoldierAndMarty");
				var allPanel = L5.getCmp("allPanel");
				var approvetable = L5.getCmp("approvetablePanel");//审批表
				var emigrate = L5.getCmp("emigrate");//迁移信息
				var decisionLetterTabPanel = L5.getCmp("decisionLetterTabPanel");//公示书
				
				if(serviceType == "81" || serviceType == "B1" ) { //申请
					allPanel.remove(emigrate);
					 if(serviceType == "B1") {
						approvetable.setTitle("部分烈士（错杀被平反人员）子女登记审核表");
					}
					approvetable.on("activate",function () {
						func("tablePanel");
					});//审批表
					if(isTrue("open")){
						decisionLetterTabPanel.on("activate",function() {
							func("decisionLetterTab");
						});//公式书
					}else{
						allPanel.remove(decisionLetterTabPanel);
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
		<next:Panel title="年满60周岁农村籍退役士兵登记审核表" width="100%" height="100%"
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