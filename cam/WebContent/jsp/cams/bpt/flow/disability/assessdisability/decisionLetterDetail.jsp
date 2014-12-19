<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
<head>
<title>决定书查看</title>
<next:ScriptManager />
		<script>
			var peopleId='<%=request.getParameter("peopleId")%>';
			var applyId='<%=request.getParameter("applyId")%>';
			var organId='<%=BspUtil.getCorpOrgan().getOrganCode()%>';
		</script>
</head>
<body>
<model:datasets>
	<!-- 决定书dataset -->
	<model:dataset id="decisionLetterDataset" cmd="com.inspur.cams.bpt.manage.cmd.BptDecisionLetterQueryCommand" method="queryDecisionLetter" global="true">
		<model:record fromBean="com.inspur.cams.bpt.base.data.BptDecisionLetter">
			<model:field name="domicile" type="string" />
			<model:field name="name" type="string" />
			<model:field name="yiju" type="string" />
		</model:record>
	</model:dataset>
	<!-- 业务类型 -->
	<model:dataset id="serviceTypeDataset" enumName="DISABILITY.SERVICE.TYPE" autoLoad="true" global="true"></model:dataset>
	<!-- 不符合情形 -->
	<model:dataset id="noFitDataset" enumName="DISABILITY.NOFIT.CODE" autoLoad="true" global="true"></model:dataset>
	<!-- 依据条款 -->
	<model:dataset id="foundationDataset" enumName="DISABILITY.FOUNDATION.CODE" autoLoad="true" global="true"></model:dataset>
</model:datasets>
<next:Panel width="100%" height="100%" autoScroll="true" >
	
	<next:Html>
		<form id="editForm"   dataset="decisionLetterDataset" onsubmit="return false" style="padding: 5px;" class="L5form">
		
		<!-- 打印相关 -->
		<input type="hidden" id="docpath" value=""/>
		<input type="hidden" id="peopleId" name="printQuery" queryData="queryData" value="<%=request.getParameter("peopleId")%>"/>
		<input type="hidden" id="applyId" name="printQuery" queryData="queryData" value="<%=request.getParameter("applyId")%>"/>
		<input type="hidden" id="organId" name="printQuery" queryData="queryData" value="<%=BspUtil.getCorpOrgan().getOrganCode()%>"/>
		<input type="hidden" id="scaconfPath" value="assDisdislityApp/assDisdislityAppPrintDao"/>
		<input type="hidden" id="method" value="queryDecisionLetter"/>
		</form>
   </next:Html>
</next:Panel>
</body>
<script type="text/javascript">
function init() {
		var decisionLetterDataset = L5.DatasetMgr.lookup("decisionLetterDataset");
		decisionLetterDataset.setParameter("PEOPLE_ID",peopleId);
		decisionLetterDataset.setParameter("APPLY_ID",applyId);
		decisionLetterDataset.setParameter("organId",organId);
		decisionLetterDataset.load();
		decisionLetterDataset.on("load",function print() {

	var decisionLetterDataset = L5.DatasetMgr.lookup("decisionLetterDataset");
	var decisionLetterRecord=decisionLetterDataset.getCurrent();
	
	if(decisionLetterRecord.get("serviceType")==0){
		document.getElementById("docpath").value="jsp/cams/bpt/flow/disability/assessdisability/print/appraiseDecisionLetter.doc"
	}else if(decisionLetterRecord.get("serviceType")==1){
		document.getElementById("docpath").value="jsp/cams/bpt/flow/disability/assessdisability/print/adjustDecisionLetter.doc"
	}
	
	var url="../../../../comm/print/jspcommonprint.jsp?";
	var text='鉴定介绍信打印';
	var width = 1024;
	var height = 768;
    window.showModalDialog(url,window,"scroll:yes;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:1");
});
}
</script>
</html>
