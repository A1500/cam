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
	var organName = '<%=BspUtil.getOrganName()%>';
	var currentUserName = '<%= GetBspInfo.getBspInfo().getUserName()%>';
</script>
<html>
<head>
<next:ScriptManager />
<script type="text/javascript" src="<%=SkinUtils.getJS(request, "ISPrint.js") %>"></script>
<script type="text/javascript"
	src='<%=SkinUtils.getJS(request,"cams.js") %>'></script>
<script type="text/javascript"
	src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript" src="query_martyr.js"></script>
<script type="text/javascript" src="../../comm/bptComm.js"></script>
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
		cmd="com.inspur.cams.bpt.query.cmd.MartyrTongJiCmd" global="true"
		autoLoad="false">
		<model:record>
			<model:field name="ORGAN_CODE" type="string" />
			<model:field name="ORGAN_NAME" type="string" />

			<model:field name="T1" type="string" />
			<model:field name="T2" type="string" />
			<model:field name="T3" type="string" />
			<model:field name="T4" type="string" />
			<model:field name="T5" type="string" />
			<model:field name="T6" type="string" />
			<model:field name="T7" type="string" />
		</model:record>
	</model:dataset>
</model:datasets>
<next:ViewPort>
	
	<next:Panel width="100%" border="0"
		bodyStyle="background-color:#EAF4FD;padding-bottom:10px;padding-top:12px;"
		height="100%" autoScroll="true">
		<next:Html>
			<div align="center" id="reDiv" style="display: none;">
			<div align="center" style="width: 80%;">
			<div align="center"><span id="reportTitle"
				style="font-size: large;">山东省老烈子女统计表</span></div>
			<div align="right" class="L5form">
			<button onclick="printBill()">打印</button>
			</div>
			<br />
			<div align="right"><span style="font-size: small;">编制单位：<%=BspUtil.getOrganName()%></span></div>
			</div>
					<table width="700" dataset="ds" align="center" style="margin-left:40px;margin-right:40px;">
						<tr>
							<td class="tdTitle" width="60" align="center" rowspan="2">单位</td>
							<td class="tdTitle" width="180" align="center" colspan="3">部分60周岁以上烈士子女</td>
							<td class="tdTitle" width="180" align="center" colspan="3">部分60周岁以上错杀被平反人员子女</td>
							<td class="tdTitle" width="76" align="center"  rowspan="2">合计</td>
						</tr>
						<tr>
							<td class="tdTitle" width="60" align="center">农村</td>
							<td class="tdTitle" width="60" align="center">城镇</td>
							<td class="tdTitle" width="60" align="center">小计</td>
							<td class="tdTitle" width="60" align="center">农村</td>
							<td class="tdTitle" width="60" align="center">城镇</td>
							<td class="tdTitle" width="60" align="center">小计</td>
						</tr>
						<tr repeat="true">
							<td style="display: none" class="td">
								<label readonly="true" field="ORGAN_CODE" /></label>
							</td>
							<td align="left" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label readonly="true"
								onclick="test(this)" field="ORGAN_NAME" style="line-height:20px;"></label> <label
								style="display: none" readonly="true" field="ORGAN_CODE" ></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery(this.parentNode.parentNode,'1','1')" field="T1" ></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery(this.parentNode.parentNode,'1','2')" field="T2" ></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery(this.parentNode.parentNode,'1','')" field="T3" ></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery(this.parentNode.parentNode,'2','1')" field="T4" ></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery(this.parentNode.parentNode,'2','2')" field="T5" ></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery(this.parentNode.parentNode,'2','')" field="T6" ></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery(this.parentNode.parentNode,'','')" field="T7" ></label></a></td>

						</tr>
					</table>
			</div>
		</next:Html>
	</next:Panel>
</next:ViewPort>
</body>
</html>