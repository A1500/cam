
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils" %>
<%@ page import="com.inspur.cams.bpt.manage.cmd.BptBaseinfoPeopleCommand"%>
<%
BptBaseinfoPeopleCommand command = new BptBaseinfoPeopleCommand();
String photoId = command.findPhotoId(request.getParameter("peopleId"));
String photoTable = "COM_PHOTO";
if(photoId!=null && photoId.length()>0){
	photoTable = photoTable+"_"+photoId.substring(0,6);
}
%>
<html>
	<head>
		<title>矽肺病鉴定体检表打印</title>
		<next:ScriptManager/>
		<script>
		var applyId='<%=request.getParameter("applyId")%>';
		var peopleId='<%=request.getParameter("peopleId")%>';
		function init() {
			var url="../../../../../comm/print/jspcommonprint.jsp?";
			var width = 1024;
			var height = 768;
		    window.showModalDialog(url,window,"scroll:yes;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:1");
		}
		</script>
		<script type="text/javascript" src="../../../../comm/bptComm.js"></script>
	</head>
<body>
			<input type="hidden" id="docpath" value="jsp/cams/bpt/flow/disability/assessdisability/bptphysicalexamination/physicalexamination_print.doc"/>
			<input type="hidden" id="applyId" name="printQuery" queryData="queryData" value="<%=request.getParameter("applyId")%>"/>\
			<input type="hidden" id="method" name="method"  value="queryPhysical"/>
			<input type="hidden" id="type" name="printQuery" queryData="queryData" value="11"/>
			<input type="hidden" id="scaconfPath" value="intoMigration/intoMigrationPrintDao"/>
</body>
</html>
