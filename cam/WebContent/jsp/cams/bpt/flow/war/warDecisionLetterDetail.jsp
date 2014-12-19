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
	<!-- 不符合情形 -->
	<model:dataset id="noFitDataset" enumName="WAR.NOFIT.CODE" autoLoad="true" global="true"></model:dataset>
	<!-- 依据条款 -->
	<model:dataset id="foundationDataset" enumName="WAR.FOUNDATION.CODE" autoLoad="true" global="true"></model:dataset>
</model:datasets>
<next:Panel width="100%" height="100%" autoScroll="true" >
	<next:TopBar>
				<next:ToolBarItem symbol="->"></next:ToolBarItem>
				<next:ToolBarItem iconCls="print" text="打印" handler="print" />
		</next:TopBar>
	<next:Html>
		<form id="editForm"   dataset="decisionLetterDataset" onsubmit="return false" style="padding: 5px;" class="L5form">
		<table border="1"  width="98%">
	   		<tr>
				<td class="FieldLabel" >姓名：</td>
				<td class="FieldInput" ><label name="name" field="name"/></td>
				<td class="FieldLabel"  >业务类型：</td>
				<td class="FieldInput" >参战退役军人身份认定</td>
			</tr>
			<tr>	
				<td class="FieldLabel"  >不符合情形：</td>
				<td class="FieldInput" colspan="3"><label type="text" name="noFit" field="noFit" /></td>
			</tr>
	   		<tr>
				<td class="FieldLabel"  >依据：</td>
				<td class="FieldInput" width="32%" colspan="3">
				<label name="foundation" field="foundation"  />
				</td>
			</tr>
	   		<tr>
				<td class="FieldLabel"  >出具时间：</td>
				<td class="FieldInput" width="32%"><label name="decisionDate" field="decisionDate"/></td>
	   			<td class="FieldLabel" >出具单位：</td>
				<td class="FieldInput" width="32%"><label name="domicile" field="domicile"></label></td>
			</tr>
		</table>
		<!-- 打印相关 -->
		<input type="hidden" id="docpath" value="jsp/cams/bpt/flow/war/table/warDecisionLetter.doc"/>
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
		L5.QuickTips.init();
	}
	
function print() {
	var url="../../../comm/print/jspcommonprint.jsp?";
	var text='鉴定介绍信打印';
	var width = 1024;
	var height = 768;
    window.showModalDialog(url,window,"scroll:yes;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:1");
}
</script>
</html>
