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
<script type="text/javascript" src="reissueMarryNextLevel.js"></script>
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
		cmd="com.inspur.cams.marry.query.papers.cmd.ReissueMarryQueryCmd" global="true" method="query"
		autoLoad="false">
		<model:record>
			<model:field name="ITEM_CODE"/>
			<model:field name="ITEM_NAME"/>
			<model:field name="TOTAL_NUM"/>
			<model:field name="TOTAL_ENTRUST_NUM"/>
			<model:field name="LOCAL_NUM"/>
			<model:field name="LOCAL_NUM_RATE"/>
			<model:field name="LOCAL_ENTRUST_NUM"/>
			<model:field name="ALLOPATRY_NUM"/>
			<model:field name="ALLOPATRY_NUM_RATE"/>
			<model:field name="ALLOPATRY_ENTRUST_NUM"/>
		</model:record>
	</model:dataset>
</model:datasets>
<next:ViewPort>
	<next:Panel width="100%" border="0"
		bodyStyle="background-color:#EAF4FD;padding-bottom:10px;padding-top:12px;"
		height="100%" autoScroll="true">
		<next:Html>
			<div align="center" id="reDiv" style="display: none">
			<div align="center" style="width: 90%;">
			<div align="center"><span id="reportTitle"
				style="font-size: large;">补发结婚证情况统计表</span></div>
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
					<table width="100%" dataset="ds" align="center" >
						<tbody id="resultsBody">
						<tr>
							<td class="tdTitle" width="6%" align="center" rowspan="2">地区行政<br> 区划名称</td>
							<td class="tdTitle" width="6%" align="center" colspan="2">补发结婚证总数</td>
							<td class="tdTitle" width="8%" align="center" colspan="3" >本地补发</td>
							<td class="tdTitle" width="4%" align="center" colspan="3" >异地补发</td>
						</tr>
						<tr>
							<td class="tdTitle" width="2%" align="center" >总数</td>
							<td class="tdTitle" width="2%" align="center" >其中委托补发</td>
							<td class="tdTitle" width="2%" align="center" >数量</td>
							<td class="tdTitle" width="2%" align="center" >占总数％</td>
							<td class="tdTitle" width="2%" align="center" >其中委托补发</td>
							<td class="tdTitle" width="2%" align="center" >数量</td>
							<td class="tdTitle" width="2%" align="center" >占总数％</td>
							<td class="tdTitle" width="2%" align="center" >其中委托补发</td>
						</tr>
						<tr repeat="true">
							<td align="center"><a href="#"><label 
								field="ITEM_NAME" onclick="queryNextLevel(this)" /></label><label style="display: none;"
								field="ITEM_CODE" /></label></a></td>
							<td align="right" style="padding-right: 2px;"><label style="width: 50px;height: 20px;" field="TOTAL_NUM"/></label></td>
							<td align="right" style="padding-right: 2px;"><label style="width: 50px;height: 20px;" field="TOTAL_ENTRUST_NUM"/></label></td>
							<td align="right" style="padding-right: 2px;"><label style="width: 50px;height: 20px;" field="LOCAL_NUM"/></label></td>
							<td align="right" style="padding-right: 2px;"><label style="width: 50px;height: 20px;" field="LOCAL_NUM_RATE"/></label></td>
							<td align="right" style="padding-right: 2px;"><label style="width: 50px;height: 20px;" field="LOCAL_ENTRUST_NUM"/></label></td>
							<td align="right" style="padding-right: 2px;"><label style="width: 50px;height: 20px;" field="ALLOPATRY_NUM"/></label></td>
							<td align="right" style="padding-right: 2px;"><label style="width: 50px;height: 20px;" field="ALLOPATRY_NUM_RATE"/></label></td>
							<td align="right" style="padding-right: 2px;"><label style="width: 50px;height: 20px;" field="ALLOPATRY_ENTRUST_NUM"/></label></td>
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
