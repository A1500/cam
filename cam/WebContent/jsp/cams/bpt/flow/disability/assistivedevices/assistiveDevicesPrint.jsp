<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
	<head>
		<title>优抚_申请_伤残辅助器械编辑查看</title>
		<next:ScriptManager/>
	</head>
<body>
<model:datasets>
	<model:dataset id="AssistiveDevicesDataset" cmd="com.inspur.cams.bpt.manage.cmd.BptApplyAssistiveDevicesQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.bpt.base.data.BptApplyAssistiveDevices"></model:record>
	</model:dataset>
	<model:dataset id="AssistiveDevicesPrDataset" cmd="com.inspur.cams.bpt.manage.cmd.BptApplyAssistiveDevicesPrQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.bpt.base.data.BptApplyAssistiveDevicesPr">
		</model:record>
	</model:dataset>
</model:datasets>
		
			<next:Panel width="100%" height="100%" autoScroll="false">
				<next:Html>
					<form id="editForm" dataset="AssistiveDevicesDataset" onsubmit="return false" style="padding: 5px;" class="L5form">
					<table border="1"  width="99%">
						<input type="hidden" id="docpath" value="jsp/cams/bpt/flow/disability/assistivedevices/print/assistiveDvicesPrint.doc"/>
						<input type="hidden" id="applyId" name="printQuery" queryData="queryData" value="<%=request.getParameter("applyId")%>"/>
						<input type="hidden" id="organId" name="printQuery" queryData="queryData" value="<%=BspUtil.getCorpOrgan().getOrganCode()%>"/>
						<input type="hidden" id="peopleId" name="printQuery" queryData="queryData" value="<%=request.getParameter("peopleId")%>"/>
						<input type="hidden" id="method" name="queryData" queryData="queryData" value="queryAssisDevices"/>
						<input type="hidden" id="scaconfPath" value="assDisdislityApp/assDisdislityAppPrintDao"/>
					</table>
					</form>
			   </next:Html>
			</next:Panel>

</body>
<script type="text/javascript">
	function init(){
		var url=L5.webPath+"/jsp/cams/comm/print/jspcommonprint.jsp";
		var width = 1024;
		var height = 768;
	    window.showModalDialog(url,window,"scroll:yes;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:1");
	}
</script>
</html>
