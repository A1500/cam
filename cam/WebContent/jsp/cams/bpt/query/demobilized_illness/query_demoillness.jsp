<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<%@ page import="org.loushang.bsp.security.context.GetBspInfo"%>
<script>
	var xzqu = '<%=request.getParameter("xzqu")%>';
	var cxsjq = '<%=request.getParameter("cxsjq")%>';
	var cxsjz = '<%=request.getParameter("cxsjz")%>';
	var organCode = '<%=BspUtil.getOrganCode()%>';
	var organName = '<%=BspUtil.getOrganName()%>';
	var currentUserName = '<%= GetBspInfo.getBspInfo().getUserName()%>';
</script>
<html>
<head>
<next:ScriptManager />
<script type="text/javascript" src="<%=SkinUtils.getJS(request, "ISPrint.js") %>"></script>
<script type="text/javascript" src="../../comm/bptComm.js"></script>
<script type="text/javascript"
	src='<%=SkinUtils.getJS(request,"cams.js") %>'></script>
<script type="text/javascript"
	src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript" src="query_demoillness.js"></script>
<script type="text/javascript" src="../querycomm.js"></script>
<script type="text/javascript">
	queryPage = true;
	if(cxsjq != null && cxsjq != "") {
		timeType = "1";
		startTime = cxsjq;
	}
	endTime = cxsjz;
</script>
<style>
body {
	background-color: #EAF4FD;
}

table {
	border-collapse: collapse;
}

input {
	background-color: #EAF4FD;
	border-style: none;
	text-align: right;
}

td {
	border-style: solid;
	border-color: #000000;
	border-width: 1px;
}

.tdTitle {
	border-style: solid;
	border-color: #000000;
	border-width: 1.5px;
	height: 20px;
	word-break: break-all;
	font-weight: bold;
}

.tdIma {
	background-image: url(line.bpm);
	background-repeat: no-repeat;
}
</style>

</head>
<body>
<model:datasets>
	<model:dataset id="ds"
		cmd="com.inspur.cams.bpt.query.cmd.Demobilized_IllnessCmd" global="true"
		autoLoad="false">
		<model:record>
			<model:field name="ORGAN_CODE" type="string" />
			<model:field name="ORGAN_NAME" type="string" />

			<model:field name="NONNUCLEUS" type="string" />
			<model:field name="NUCLEUS" type="string" />
			<model:field name="count_total" type="string" />
		</model:record>
	</model:dataset>
</model:datasets>
<next:ViewPort>
	<next:Panel  width="100%" border="0"
		bodyStyle="background-color:#EAF4FD;padding-bottom:10px;padding-top:12px;"
		height="100%" autoScroll="true">
		<next:Html>
			<div align="center" id="reDiv" style="display: none;">
			<div align="center" style="width: 80%;">
			<div align="center"><span id="reportTitle"
				style="font-size: large;">带病回乡退伍军人统计表</span></div>
				<div align="right" class="L5form" ><button onclick="printBill()">打印</button></div>
			<br />
			<div align="right"><span style="font-size: small;">编制单位：<%=BspUtil.getOrganName()%></span></div>
			</div>
			<table width="80%" dataset="ds" align="center">
				<tr>
					<td class="tdTitle" width="10%" align="center" rowspan="2">单位</td>
					<td class="tdTitle" width="6%" align="center" rowspan="2" >合计</td>
					<td class="tdTitle" width="12%" align="center" colspan="2">涉核情况</td>
				</tr>
				<tr>
					<td class="tdTitle" width="6%" align="center">无涉核</td>
					<td width="6%" class="tdTitle" align="center">涉核</td>
				</tr>
				<tr repeat="true">
					<td style="display: none" class="td">
								<label readonly="true" field="ORGAN_CODE" /></label>
					</td>
					<td align="left" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label readonly="true"
						onclick="test(this)" field="ORGAN_NAME" style="line-height:20px;"></label> <label
						style="display: none" readonly="true" field="ORGAN_CODE" ></label></a></td>
						
					<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery(this.parentNode.parentNode,'42')" readonly="true"
						field="count_total" ></label></td>
					<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery(this.parentNode.parentNode,'42','isInnuclear=0')" readonly="true"
						field="NONNUCLEUS" ></label></a></td>
						
					<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery(this.parentNode.parentNode,'42','isInnuclear=1')" readonly="true"
						field="NUCLEUS" ></label></a></td>
				</tr>
			</table>
			</div>
		</next:Html>
	</next:Panel>
</next:ViewPort>
</body>
</html>