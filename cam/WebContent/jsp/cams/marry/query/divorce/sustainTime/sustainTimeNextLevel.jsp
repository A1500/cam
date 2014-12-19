<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<%@ page import="org.loushang.bsp.security.context.GetBspInfo"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.*"%>
<%
	SimpleDateFormat sdf=new SimpleDateFormat("yyyy年MM月dd日");
	String date=sdf.format(new Date());
	String username = GetBspInfo.getBspInfo(request).getUserName();
%>
<script>
	var xzqu = '<%=request.getParameter("xzqu")%>';
	var cxsjq = '<%=request.getParameter("cxsjq")%>';
	var cxsjz = '<%=request.getParameter("cxsjz")%>';
	var organName = '<%=BspUtil.getOrganName()%>';
	var pageflag ='<%=request.getParameter("pageflag")%>';
</script>
<html>
<head>
<next:ScriptManager />
<script type="text/javascript"
	src='<%=SkinUtils.getJS(request,"cams.js") %>'></script>
<script type="text/javascript"
	src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript" src="../../../../../comm/highchart/js/jquery.min.js"></script>
<script type="text/javascript" src="../../../../../comm/highchart/js/highcharts.js"></script>
<script type="text/javascript" src="sustainTimeNextLevel.js"></script>
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
.btTitle {
	word-break: break-all;
	font-weight: bold;
	font-size: x-small;
}
.tdTitle {
	border-style: solid;
	border-color: #000000;
	border-width: 1.5px;
	height: 20px;
	word-break: break-all;
	font-weight: bold;
}

tr{   
	yexj00:expression(this.style.background=(rowIndex%2==1)? 'white ': '#EAF4FD ')
} 

td {
	border-style: solid;
	border-color: #000000;
	border-width: 1px;
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
		cmd="com.inspur.cams.marry.query.divorce.cmd.DivorceSusTimeQueryCmd" global="true" method="query"
		autoLoad="false">
		<model:record>
			<model:field name="ITEM_CODE"/>
			<model:field name="ITEM_NAME"/>
			<model:field name="TOTAL_NUM"/>
			<model:field name="YEAR1_NUM"/>
			<model:field name="YEAR1_RATE"/>
			<model:field name="YEAR2_3_NUM"/>
			<model:field name="YEAR2_3_RATE"/>
			<model:field name="YEAR4_5_NUM"/>
			<model:field name="YEAR4_5_RATE"/>
			<model:field name="YEAR6_9_NUM"/>
			<model:field name="YEAR6_9_RATE"/>
			<model:field name="YEAR10_15_NUM"/>
			<model:field name="YEAR10_15_RATE"/>
			<model:field name="YEAR16_25_NUM"/>
			<model:field name="YEAR16_25_RATE"/>
			<model:field name="YEAR26_35_NUM"/>
			<model:field name="YEAR26_35_RATE"/>
			<model:field name="YEAR36_50_NUM"/>
			<model:field name="YEAR36_50_RATE"/>
			<model:field name="YEAR50_NUM"/>
			<model:field name="YEAR50_RATE"/>
		</model:record>
	</model:dataset>
</model:datasets>
<next:ViewPort>
	<next:Panel width="100%" border="0" height="100%" autoScroll="true">
		<next:TabPanel>
			<next:Tabs>
				<next:Panel title="婚姻维系时间统计表" bodyStyle="background-color:#EAF4FD;padding-bottom:10px;padding-top:12px;" height="100%" autoScroll="true">
					<next:Html>
						<div align="center" id="reDiv" style="display: none">
						<div align="center" style="width: 90%;">
						<div align="center"><span id="reportTitle"
							style="font-size: large;">婚姻维系时间统计表</span></div>
						</div>
						<div align="right" class="L5form">
						<button onclick="forExcel()">导出Excel</button>&nbsp;&nbsp;
						<button onclick="back()">返回</button>&nbsp;&nbsp;
						</div>
						<br />
						<table style="border-style: hidden; width: 90%" cellpadding="0"
							cellspacing="0" border="0">
							 <tr>
								<td colspan="2" style="border-width: 0px">
								<div align="left"><span class="btTitle">统计单位：<%=BspUtil.getOrganName()%></span></div></td>
								<td colspan="2" style="border-width: 0px">
								<div align="right"><span class="btTitle">统计时间：<label id="statisticsTime"/></span></div></td>
							</tr>
							<tr>
								<td colspan="4" style="border-width: 0px">
								<table width="100%" dataset="ds" align="center" id = "sourceTable" >
									<tbody id="resultsBody">
									<tr>
										<td class="tdTitle" width="8%" align="center" rowspan="2">地区行政<br> 区划名称</td>
										<td class="tdTitle" width="4%" align="center" rowspan="2">合计</td>
										<td class="tdTitle" width="2%" align="center" colspan="2" >1年和<br>1年以内</td>
										<td class="tdTitle" width="2%" align="center" colspan="2" >2-3年</td>
										<td class="tdTitle" width="2%" align="center" colspan="2" >4-5年</td>
										<td class="tdTitle" width="2%" align="center" colspan="2" >6-9年</td>
										<td class="tdTitle" width="2%" align="center" colspan="2" >10-15年</td>
										<td class="tdTitle" width="2%" align="center" colspan="2" >16-25年</td>
										<td class="tdTitle" width="2%" align="center" colspan="2" >26-35年</td>
										<td class="tdTitle" width="2%" align="center" colspan="2" >36-50年</td>
										<td class="tdTitle" width="2%" align="center" colspan="2" >50年以上</td>
									</tr>
									<tr>
										<td class="tdTitle" width="2%" align="center" >对数</td>
										<td class="tdTitle" width="2%" align="center" >％</td>
										<td class="tdTitle" width="2%" align="center" >对数</td>
										<td class="tdTitle" width="2%" align="center" >％</td>
										<td class="tdTitle" width="2%" align="center" >对数</td>
										<td class="tdTitle" width="2%" align="center" >％</td>
										<td class="tdTitle" width="2%" align="center" >对数</td>
										<td class="tdTitle" width="2%" align="center" >％</td>
										<td class="tdTitle" width="2%" align="center" >对数</td>
										<td class="tdTitle" width="2%" align="center" >％</td>
										<td class="tdTitle" width="2%" align="center" >对数</td>
										<td class="tdTitle" width="2%" align="center" >％</td>
										<td class="tdTitle" width="2%" align="center" >对数</td>
										<td class="tdTitle" width="2%" align="center" >％</td>
										<td class="tdTitle" width="2%" align="center" >对数</td>
										<td class="tdTitle" width="2%" align="center" >％</td>
										<td class="tdTitle" width="2%" align="center" >对数</td>
										<td class="tdTitle" width="2%" align="center" >％</td>
									</tr>
									<tr repeat="true">
										<td align="center"><a href="#"><label 
											field="ITEM_NAME" onclick="queryNextLevel(this)" /></label><label style="display: none;"
											field="ITEM_CODE" /></label></a></td>
										<td align="right" style="padding-right: 2px;"><label style="width: 30px;height: 20px;" field="TOTAL_NUM"/></label></td>
										<td align="right" style="padding-right: 2px;"><label style="width: 30px;height: 20px;" field="YEAR1_NUM"/></label></td>
										<td align="right" style="padding-right: 2px;"><label style="width: 30px;height: 20px;" field="YEAR1_RATE"/></label></td>
										<td align="right" style="padding-right: 2px;"><label style="width: 30px;height: 20px;" field="YEAR2_3_NUM"/></label></td>
										<td align="right" style="padding-right: 2px;"><label style="width: 30px;height: 20px;" field="YEAR2_3_RATE"/></label></td>
										<td align="right" style="padding-right: 2px;"><label style="width: 30px;height: 20px;" field="YEAR4_5_NUM"/></label></td>
										<td align="right" style="padding-right: 2px;"><label style="width: 30px;height: 20px;" field="YEAR4_5_RATE"/></label></td>
										<td align="right" style="padding-right: 2px;"><label style="width: 30px;height: 20px;" field="YEAR6_9_NUM"/></label></td>
										<td align="right" style="padding-right: 2px;"><label style="width: 30px;height: 20px;" field="YEAR6_9_RATE"/></label></td>
										<td align="right" style="padding-right: 2px;"><label style="width: 30px;height: 20px;" field="YEAR10_15_NUM"/></label></td>
										<td align="right" style="padding-right: 2px;"><label style="width: 30px;height: 20px;" field="YEAR10_15_RATE"/></label></td>
										<td align="right" style="padding-right: 2px;"><label style="width: 30px;height: 20px;" field="YEAR16_25_NUM"/></label></td>
										<td align="right" style="padding-right: 2px;"><label style="width: 30px;height: 20px;" field="YEAR16_25_RATE"/></label></td>
										<td align="right" style="padding-right: 2px;"><label style="width: 30px;height: 20px;" field="YEAR26_35_NUM"/></label></td>
										<td align="right" style="padding-right: 2px;"><label style="width: 30px;height: 20px;" field="YEAR26_35_RATE"/></label></td>
										<td align="right" style="padding-right: 2px;"><label style="width: 30px;height: 20px;" field="YEAR36_50_NUM"/></label></td>
										<td align="right" style="padding-right: 2px;"><label style="width: 30px;height: 20px;" field="YEAR36_50_RATE"/></label></td>
										<td align="right" style="padding-right: 2px;"><label style="width: 30px;height: 20px;" field="YEAR50_NUM"/></label></td>
										<td align="right" style="padding-right: 2px;"><label style="width: 30px;height: 20px;" field="YEAR50_RATE"/></label></td>
									</tr>
									</tbody>
								</table>
								</td>
							</tr>
							<tr>
								<td colspan="2" style="border-width: 0px">
								<div align="left"><span class="btTitle">制表人：<%=username %></span></div></td>
								<td colspan="2" style="border-width: 0px">
								<div align="right"><span class="btTitle">制表时间：<%=date %></span></div></td>
							</tr>
						</table>
						</div>
					</next:Html>
			</next:Panel>
			<next:Panel id= "highcharts" title="婚姻维系时间统计表（图表）" height="100%" autoScroll="true" bodyStyle="background-color:#EAF4FD;padding-bottom:10px;padding-top:12px;">
				<next:Html>
					<table width="100%" border="0" cellspacing="0" cellpadding="0" id ="showTable">
				         <tr style="border:1px solid #3BE263;border-collapse:collapse">
				        	<td style="border:1px solid #3BE263;border-collapse:collapse"><div id="charLine"></div></td>
						</tr>
						 <tr style="border:1px solid #3BE263;border-collapse:collapse">
				        	<td style="border:1px solid #3BE263;border-collapse:collapse"><div id="charPie"></div></td>
						</tr>
				     </table>
				</next:Html>
			</next:Panel>
		</next:Tabs>
	</next:TabPanel>
	</next:Panel>
</next:ViewPort>
</body>
</html>
