<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%
    String emigrateUrl = "";//迁移信息url
	String serviceType = request.getParameter("serviceType");
	String peopleId = request.getParameter("peopleId");
	String applyId = request.getParameter("applyId");
    if("22".equals(serviceType)) {
		emigrateUrl = "../../flow/dependant/dependantmigrate/ingoingprovince/intoProviPrint.jsp?peopleId="+peopleId +"&applyId="+applyId;
	} else if("23".equals(serviceType)) {
		emigrateUrl = "../../flow/dependant/dependantmigrate/provincemigration/provinceMigrationDetail.jsp?peopleId="+peopleId +"&applyId="+applyId;
	} else if("25".equals(serviceType)) {
		emigrateUrl = "../../flow/dependant/dependantmigrate/emigration/emigrationDetail.jsp?peopleId="+peopleId +"&applyId="+applyId;
	}
    
%>
<html>
<head>
<title>三属文书管理</title>
<next:ScriptManager />
<script language="javascript">
			var peopleId='<%=request.getParameter("peopleId")%>';
			var applyId='<%=request.getParameter("applyId")%>';
			var serviceType = '<%=request.getParameter("serviceType")%>';
			var tableUrl = ""; //审批表url
			
			
			function init() {
				var allPanel = L5.getCmp("allPanel");
				var approvetable = L5.getCmp("approvetablePanel");//审批表
				var emigrate = L5.getCmp("emigrate");//迁移信息
				
				
				if(serviceType == "21") { //申请
					allPanel.remove(emigrate);
					approvetable.on("activate",function () {
						func("tablePanel");
					});//审批表
				} else { 
					allPanel.remove(approvetable);
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
			
				
		</script>
</head>
<body>
<next:TabPanel id="allPanel">
	<next:Tabs>
		<next:Panel title="山东省领取定期抚恤金审批表" width="100%" height="100%"
			id="approvetablePanel" name="approvetablePaneltablePanel"
			autoScroll="false">
			<next:Html>
				<iframe id="tablePanel"
					src="../../flow/dependant/print/dependant_apptable.jsp?peopleId=<%=request.getParameter("peopleId")%>&applyId=<%=request.getParameter("applyId")%>"
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