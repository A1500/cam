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
<script type="text/javascript" src="degree_query.js"></script>
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

tr{   
	yexj00:expression(this.style.background=(rowIndex%2==1)? 'white ': '#EAF4FD ')
} 

td {
	border-style: solid;
	border-color: #000000;
	border-width: 1px;
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

.tdIma {
	background-image: url(line.bpm);
	background-repeat: no-repeat;
}
</style>

</head>
<body>
<model:datasets>
	<model:dataset id="ds"
		cmd="com.inspur.cams.marry.query.divorce.cmd.MrmDegreeQueryCmd" global="true"
		method="query" autoLoad="false">
		<model:record>
			<model:field name="ITEM_CODE" />
			<model:field name="ITEM_NAME" />
			<model:field name="TOTAL_NUM" />
			<model:field name="OTHER_NUM" />
			<model:field name="OTHER_RATE" />
			<model:field name="ELEMENTARY_NUM" />
			<model:field name="ELEMENTARY_RATE" />
			<model:field name="SECONDARY_NUM" />
			<model:field name="SECONDARY_RATE" />
			<model:field name="SENIOR_NUM" />
			<model:field name="SENIOR_RATE" />
			<model:field name="TECHNICAL_NUM" />
			<model:field name="TECHNICAL_RATE" />
			<model:field name="BACHELOR_NUM" />
			<model:field name="BACHELOR_RATE" />
			<model:field name="GRADUATE_NUM" />
			<model:field name="GRADUATE_RATE" />
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
				style="font-size: large;">离婚登记当事人文化程度状况统计表</span></div>
			</div>
			<div align="right" class="L5form">
			<button onclick="forExcel()">导出Excel</button>&nbsp;&nbsp;
			<button onclick="back()">返回</button>
			</div>
			<br />
			<table style="border-style: hidden; width: 90%" cellpadding="0"
				cellspacing="0" border="0">
				 <tr>
					<td colspan="2" style="border-width: 0px">
					<div align="left"><span class="btTitle">统计单位：<%=BspUtil.getOrganName()%></span></div>
					<td colspan="2" style="border-width: 0px">
					<div align="right"><span class="btTitle">统计时间：<label id="statisticsTime"/></span></div>
				</tr>
				<tr>
					<td colspan="4" style="border-width: 0px">
					<table width="100%" dataset="ds" align="center">
						<tbody id="resultsBody">
							<tr>
								<td class="tdTitle" align="center" rowspan="2">地&nbsp;&nbsp;&nbsp;区</td>
								<td class="tdTitle" align="center" rowspan="2">合计(人)</td>
								<td class="tdTitle" align="center" colspan="2">其他</td>
								<td class="tdTitle" align="center" colspan="2">小学教育</td>
								<td class="tdTitle" align="center" colspan="2">初级中学<br />
								教育</td>
								<td class="tdTitle" align="center" colspan="2">普通高级<br />
								中学教育</td>
								<td class="tdTitle" align="center" colspan="2">中等职<br />
								业教育</td>
								<td class="tdTitle" align="center" colspan="2">大学本科<br />
								/专科教育</td>
								<td class="tdTitle" align="center" colspan="2">研究生教育</td>
							</tr>
							<tr>
								<td class="tdTitle" align="center">人数</td>
								<td class="tdTitle" align="center">%</td>
								<td class="tdTitle" align="center">人数</td>
								<td class="tdTitle" align="center">%</td>
								<td class="tdTitle" align="center">人数</td>
								<td class="tdTitle" align="center">%</td>
								<td class="tdTitle" align="center">人数</td>
								<td class="tdTitle" align="center">%</td>
								<td class="tdTitle" align="center">人数</td>
								<td class="tdTitle" align="center">%</td>
								<td class="tdTitle" align="center">人数</td>
								<td class="tdTitle" align="center">%</td>
								<td class="tdTitle" align="center">人数</td>
								<td class="tdTitle" align="center">%</td>
							</tr>
							<tr repeat="true">
								<td align="center"><a href="#"><label onclick="queryNextLevel(this)"
									field="ITEM_NAME" /></label> <label style="display: none"
									field="ITEM_CODE" /></label></a></td>
								<td align="right" style="padding-right: 2px;"><label style="width: 30px;height: 20px;" field="TOTAL_NUM"></label></td>
								<td align="right" style="padding-right: 2px;"><label style="width: 30px;height: 20px;" field="OTHER_NUM"></label></td>
								<td align="right" style="padding-right: 2px;"><label style="width: 30px;height: 20px;" field="OTHER_RATE"></label></td>
								<td align="right" style="padding-right: 2px;"><label style="width: 30px;height: 20px;" field="ELEMENTARY_NUM"></label></td>
								<td align="right" style="padding-right: 2px;"><label style="width: 30px;height: 20px;" field="ELEMENTARY_RATE"></label></td>
								<td align="right" style="padding-right: 2px;"><label style="width: 30px;height: 20px;" field="SECONDARY_NUM"></label></td>
								<td align="right" style="padding-right: 2px;"><label style="width: 30px;height: 20px;" field="SECONDARY_RATE"></label></td>
								<td align="right" style="padding-right: 2px;"><label style="width: 30px;height: 20px;" field="SENIOR_NUM"></label></td>
								<td align="right" style="padding-right: 2px;"><label style="width: 30px;height: 20px;" field="SENIOR_RATE"></label></td>
								<td align="right" style="padding-right: 2px;"><label style="width: 30px;height: 20px;" field="TECHNICAL_NUM"></label></td>
								<td align="right" style="padding-right: 2px;"><label style="width: 30px;height: 20px;" field="TECHNICAL_RATE"></label></td>
								<td align="right" style="padding-right: 2px;"><label style="width: 30px;height: 20px;" field="BACHELOR_NUM"></label></td>
								<td align="right" style="padding-right: 2px;"><label style="width: 30px;height: 20px;" field="BACHELOR_RATE"></label></td>
								<td align="right" style="padding-right: 2px;"><label style="width: 30px;height: 20px;" field="GRADUATE_NUM"></label></td>
								<td align="right" style="padding-right: 2px;"><label style="width: 30px;height: 20px;" field="GRADUATE_RATE"></label></td>
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
</next:ViewPort>
</body>
</html>