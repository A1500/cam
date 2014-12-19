<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ taglib uri="/tags/next-billprint" prefix="print"%>
<html>

<head>
<next:ScriptManager/>
<script type="text/javascript">
function init(){
	<%	
		String id=request.getParameter("id");
		String endDate=request.getParameter("endDate");
		String PrintDate=request.getParameter("PrintDate");
		String beginDate=request.getParameter("beginDate");
		String taskCode=request.getParameter("taskCode");
	%>
	var endDate='<%=endDate%>';
	var PrintDate='<%=PrintDate%>';
	var beginDate='<%=beginDate%>';
	var sorgId='<%=id%>';
	var taskCode='<%=taskCode%>';
	
	somGroupCertPrintDataset.setParameter("SORG_ID",sorgId);
	somGroupCertPrintDataset.setParameter("endDate",endDate);
	somGroupCertPrintDataset.setParameter("PrintDate",PrintDate);
	somGroupCertPrintDataset.setParameter("beginDate",beginDate);
	somGroupCertPrintDataset.setParameter("taskCode",taskCode);
	somGroupCertPrintDataset.load();
}

function returnList(){
	window.close();
}

</script>
<style>　
　　.toolbar{ 
		border:1px solid #6A9BFA; 
		background:#E8F7E8; 
		text-align: "right"
	}　　
	@media print{ 　　 
　　		.toolbar{ display:none; } 
　　 }
</style>
</head>

<body >
<model:datasets>
	<model:dataset id="somGroupCertPrintDataset"
		cmd="com.inspur.cams.sorg.manage.cmd.SomCertQueryCmd" global="true" method="createCert">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomCert">
			<model:field name="QYear" defaultValue="Qyyyy" />
			<model:field name="QMonth" defaultValue="Qm"/>
			<model:field name="QDay" defaultValue="Qd"/>
			<model:field name="ZYear" defaultValue="Zyyyy"/>
			<model:field name="ZMonth" defaultValue="Zm"/>
			<model:field name="ZDay" defaultValue="Zd"/>
			<model:field name="FYear" defaultValue="Fyyyy"/>
			<model:field name="FMonth" defaultValue="Fm"/>
			<model:field name="FDay" defaultValue="Fd"/>
			
			<model:field name="sorgCode" defaultValue="登记证号"/>
			<model:field name="sorgName" defaultValue="社会组织名称"/>
			<model:field name="business" defaultValue="业务范围"/>
			<model:field name="residence" defaultValue="住所"/>
			<model:field name="legalPeople" defaultValue="法定代表人"/>
			<model:field name="regMon" defaultValue="原始资金数额"/>
			<model:field name="borgName" defaultValue="业务主管单位"/>
			<model:field name="signOrgan" defaultValue="发证机关"/>
			<model:field name="actArea" defaultValue="活动地域"/>
		</model:record>
	</model:dataset>
</model:datasets>
<div class="toolbar">
	<button onclick="javascript:window.print()">打 印</button>
	<button onclick="javascript:L5.billprint.savePosition()">保存预览</button>	
	<button onclick="returnList();">关闭</button>
</div>

<print:template dataset="somGroupCertPrintDataset" image="2019.jpg" height="476" width="700">
	<print:field name="QYear" fontSize="15px" field="QYear"/>
	<print:field name="QMonth" fontSize="15px" field="QMonth"/>
	<print:field name="QDay" fontSize="15px" field="QDay"/>
	<print:field name="ZYear" fontSize="15px" field="ZYear"/>
	<print:field name="ZMonth" fontSize="15px" field="ZMonth"/>
	<print:field name="ZDay" fontSize="15px" field="ZDay"/>
	<print:field name="FYear" fontSize="15px" field="FYear"/>
	<print:field name="FMonth" fontSize="15px" field="FMonth"/>
	<print:field name="FDay" fontSize="15px" field="FDay"/>
	
	
	<print:field name="sorgCode" fontSize="15px"  field="sorgCode"/>
	<print:field name="sorgName" fontSize="15px" field="sorgName"/>
	<print:field name="business" fontSize="15px" field="business"/>
	<print:field name="residence" fontSize="15px" field="residence"/>
	<print:field name="legalPeople" fontSize="15px" field="legalPeople"/>
	<print:field name="regMon" fontSize="15px" field="regMon"/>
	<print:field name="borgName" fontSize="15px" field="borgName"/>
	<print:field name="signOrgan" fontSize="15px" field="signOrgan"/>
	<print:field name="actArea" fontSize="15px" field="actArea"/>
</print:template>
</body>
</html>