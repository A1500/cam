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
<script type="text/javascript" src="query_soldierYears.js"></script>
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
		cmd="com.inspur.cams.bpt.query.cmd.SoldierYearTongJiCmd" global="true"
		autoLoad="false">
		<model:record>
			<model:field name="ORGAN_CODE" type="string" />
			<model:field name="ORGAN_NAME" type="string" />

			<model:field name="Y1" type="string" />
			<model:field name="Y2" type="string" />
			<model:field name="Y3" type="string" />
			<model:field name="Y4" type="string" />
			<model:field name="Y5" type="string" />
			<model:field name="Y6" type="string" />
			<model:field name="Y7" type="string" />
			<model:field name="Y8" type="string" />
			<model:field name="Y9" type="string" />
			<model:field name="Y10" type="string" />
			<model:field name="Y11" type="string" />
			<model:field name="Y12" type="string" />
			<model:field name="Y13" type="string" />
			<model:field name="Y14" type="string" />
			<model:field name="Y15" type="string" />
			<model:field name="Y16" type="string" />
			<model:field name="Y17" type="string" />
			<model:field name="Y18" type="string" />
			<model:field name="Y19" type="string" />
			<model:field name="Y20" type="string" />
			<model:field name="Y21" type="string" />
			<model:field name="Y22" type="string" />
			<model:field name="Y23" type="string" />
			<model:field name="Y24" type="string" />
			<model:field name="Y25" type="string" />
			<model:field name="YU25" type="string" />
			<model:field name="TOTAL" type="string" />
			<model:field name="YT" type="string" />
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
				style="font-size: large;">山东省60岁老兵服役年限统计表</span></div>
			<div align="right" class="L5form">
			<button onclick="printBill()">打印</button>
			</div>
			<br />
			<div align="right"><span style="font-size: small;">编制单位：<%=BspUtil.getOrganName()%></span></div>
			</div>
					<table width="1350" dataset="ds" align="center" style="margin-left:40px;margin-right:40px;">
						<tr>
							<td class="tdTitle" width="60" align="center">单位</td>
							<td class="tdTitle" width="60" align="center">1年</td>
							<td class="tdTitle" width="61" align="center">2年</td>
							<td class="tdTitle" width="62" align="center">3年</td>
							<td class="tdTitle" width="63" align="center">4年</td>
							<td class="tdTitle" width="64" align="center">5年</td>
							<td class="tdTitle" width="65" align="center">6年</td>
							<td class="tdTitle" width="66" align="center">7年</td>
							<td class="tdTitle" width="67" align="center">8年</td>
							<td class="tdTitle" width="68" align="center">9年</td>
							<td class="tdTitle" width="69" align="center">10年</td>
							<td class="tdTitle" width="70" align="center">11年</td>
							<td class="tdTitle" width="71" align="center">12年</td>
							<td class="tdTitle" width="72" align="center">13年</td>
							<td class="tdTitle" width="73" align="center">14年</td>
							<td class="tdTitle" width="74" align="center">15年</td>
							<td class="tdTitle" width="75" align="center">16年</td>
							<td class="tdTitle" width="76" align="center">17年</td>
							<td class="tdTitle" width="77" align="center">18年</td>
							<td class="tdTitle" width="78" align="center">19年</td>
							<td class="tdTitle" width="79" align="center">20年</td>
							<td class="tdTitle" width="80" align="center">21年</td>
							<td class="tdTitle" width="81" align="center">22年</td>
							<td class="tdTitle" width="82" align="center">23年</td>
							<td class="tdTitle" width="83" align="center">24年</td>
							<td class="tdTitle" width="84" align="center">25年</td>
							<td class="tdTitle" width="84" align="center">>25年</td>
							<td class="tdTitle" width="84" align="center">合计人数</td>
							<td class="tdTitle" width="84" align="center">合计年限</td>
						</tr>
						<tr repeat="true">
							<td style="display: none" class="td">
								<label readonly="true" field="ORGAN_CODE" /></label>
							</td>
							<td align="left" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label readonly="true"
								onclick="test(this)" field="ORGAN_NAME" style="line-height:20px;"></label> <label
								style="display: none" readonly="true" field="ORGAN_CODE" ></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery(this.parentNode.parentNode,'1')" field="Y1" ></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery(this.parentNode.parentNode,'2')" field="Y2" ></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery(this.parentNode.parentNode,'3')" field="Y3" ></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery(this.parentNode.parentNode,'4')" field="Y4" ></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery(this.parentNode.parentNode,'5')" field="Y5" ></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery(this.parentNode.parentNode,'6')" field="Y6" ></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery(this.parentNode.parentNode,'7')" field="Y7" ></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery(this.parentNode.parentNode,'8')" field="Y8" ></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery(this.parentNode.parentNode,'9')" field="Y9" ></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery(this.parentNode.parentNode,'10')" field="Y10" ></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery(this.parentNode.parentNode,'11')" field="Y11" ></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery(this.parentNode.parentNode,'12')" field="Y12" ></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery(this.parentNode.parentNode,'13')" field="Y13" ></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery(this.parentNode.parentNode,'14')" field="Y14" ></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery(this.parentNode.parentNode,'15')" field="Y15" ></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery(this.parentNode.parentNode,'16')" field="Y16" ></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery(this.parentNode.parentNode,'17')" field="Y17" ></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery(this.parentNode.parentNode,'18')" field="Y18" ></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery(this.parentNode.parentNode,'19')" field="Y19" ></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery(this.parentNode.parentNode,'20')" field="Y20" ></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery(this.parentNode.parentNode,'21')" field="Y21" ></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery(this.parentNode.parentNode,'22')" field="Y22" ></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery(this.parentNode.parentNode,'23')" field="Y23" ></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery(this.parentNode.parentNode,'24')" field="Y24" ></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery(this.parentNode.parentNode,'25')" field="Y25" ></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label onclick="redirectQuery(this.parentNode.parentNode,'>25')" field="YU25" ></label></a></td>

							<td align="right" nowrap="nowrap" class="td"><a href="#" style="cursor:hand"><label  
								readonly="true" field="TOTAL" onclick="redirectQuery(this.parentNode.parentNode,'')"></label></a></td>
							<td align="right" nowrap="nowrap" class="td"><label  
								readonly="true" field="YT"></label></td>
						</tr>
					</table>
			</div>
		</next:Html>
	</next:Panel>
</next:ViewPort>
</body>
</html>