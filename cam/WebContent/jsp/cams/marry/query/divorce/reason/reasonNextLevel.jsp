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
<script type="text/javascript" src="reasonNextLevel.js"></script>
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
		cmd="com.inspur.cams.marry.query.divorce.cmd.DivorceReasonQueryCmd" global="true" method="query"
		autoLoad="false">
		<model:record>
			<model:field name="ITEM_CODE"/>
			<model:field name="ITEM_NAME"/>
			<model:field name="TOTAL_NUM"/>
			<model:field name="INCOMPATIBLE_NUM"/>
			<model:field name="INCOMPATIBLE_RATE"/>
			<model:field name="FINANCIAL_NUM"/>
			<model:field name="FINANCIAL_RATE"/>
			<model:field name="THIRD_NUM"/>
			<model:field name="THIRD_RATE"/>
			<model:field name="BOTH_PLACES_NUM"/>
			<model:field name="BOTH_PLACES_RATE"/>
			<model:field name="EDUCATION_NUM"/>
			<model:field name="EDUCATION_RATE"/>
			<model:field name="DISSENSION_NUM"/>
			<model:field name="DISSENSION_RATE"/>
			<model:field name="SEXUAL_NUM"/>
			<model:field name="SEXUAL_RATE"/>
			<model:field name="ILLEGAL_NUM"/>
			<model:field name="ILLEGAL_RATE"/>
			<model:field name="BAD_HADIT_NUM"/>
			<model:field name="BAD_HADIT_RATE"/>
			<model:field name="NOT_FAMILIAR_NUM"/>
			<model:field name="NOT_FAMILIAR_RATE"/>
			<model:field name="OTHERS_NUM"/>
			<model:field name="OTHERS_RATE"/>
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
				style="font-size: large;">离婚原因统计表</span></div>
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
							<td class="tdTitle" width="8%" align="center" rowspan="2">地区行政<br> 区划名称</td>
							<td class="tdTitle" width="4%" align="center" rowspan="2">合计</td>
							<td class="tdTitle" width="2%" align="center" colspan="2" >感情<br>不和</td>
							<td class="tdTitle" width="2%" align="center" colspan="2" >经济<br>困难</td>
							<td class="tdTitle" width="2%" align="center" colspan="2" >第三者<br>插足</td>
							<td class="tdTitle" width="2%" align="center" colspan="2" >两地<br>生活</td>
							<td class="tdTitle" width="2%" align="center" colspan="2" >教育<br>子女</td>
							<td class="tdTitle" width="2%" align="center" colspan="2" >家庭<br>纠纷</td>
							<td class="tdTitle" width="2%" align="center" colspan="2" >夫妻<br>性生活<br>不和谐</td>
							<td class="tdTitle" width="2%" align="center" colspan="2" >一方有<br>违法犯<br>罪行为</td>
							<td class="tdTitle" width="2%" align="center" colspan="2" >一方有<br>不良生<br>活习惯</td>
							<td class="tdTitle" width="2%" align="center" colspan="2" >婚前<br>缺乏<br>了解</td>
							<td class="tdTitle" width="2%" align="center" colspan="2" >其他</td>
						</tr>
						<tr>
							<td class="tdTitle" width="2%" align="center" >人数</td>
							<td class="tdTitle" width="2%" align="center" >％</td>
							<td class="tdTitle" width="2%" align="center" >人数</td>
							<td class="tdTitle" width="2%" align="center" >％</td>
							<td class="tdTitle" width="2%" align="center" >人数</td>
							<td class="tdTitle" width="2%" align="center" >％</td>
							<td class="tdTitle" width="2%" align="center" >人数</td>
							<td class="tdTitle" width="2%" align="center" >％</td>
							<td class="tdTitle" width="2%" align="center" >人数</td>
							<td class="tdTitle" width="2%" align="center" >％</td>
							<td class="tdTitle" width="2%" align="center" >人数</td>
							<td class="tdTitle" width="2%" align="center" >％</td>
							<td class="tdTitle" width="2%" align="center" >人数</td>
							<td class="tdTitle" width="2%" align="center" >％</td>
							<td class="tdTitle" width="2%" align="center" >人数</td>
							<td class="tdTitle" width="2%" align="center" >％</td>
							<td class="tdTitle" width="2%" align="center" >人数</td>
							<td class="tdTitle" width="2%" align="center" >％</td>
							<td class="tdTitle" width="2%" align="center" >人数</td>
							<td class="tdTitle" width="2%" align="center" >％</td>
							<td class="tdTitle" width="2%" align="center" >人数</td>
							<td class="tdTitle" width="2%" align="center" >％</td>
						</tr>
						<tr repeat="true">
							<td align="center"><a href="#"><label 
								field="ITEM_NAME" onclick="queryNextLevel(this)" /></label><label style="display: none;"
								field="ITEM_CODE" /></label></a></td>
							<td align="right" style="padding-right: 2px;"><label style="width: 30px;height: 20px;" field="TOTAL_NUM"/></label></td>
							<td align="right" style="padding-right: 2px;"><label style="width: 30px;height: 20px;" field="INCOMPATIBLE_NUM"/></label></td>
							<td align="right" style="padding-right: 2px;"><label style="width: 30px;height: 20px;" field="INCOMPATIBLE_RATE"/></label></td>
							<td align="right" style="padding-right: 2px;"><label style="width: 30px;height: 20px;" field="FINANCIAL_NUM"/></label></td>
							<td align="right" style="padding-right: 2px;"><label style="width: 30px;height: 20px;" field="FINANCIAL_RATE"/></label></td>
							<td align="right" style="padding-right: 2px;"><label style="width: 30px;height: 20px;" field="THIRD_NUM"/></label></td>
							<td align="right" style="padding-right: 2px;"><label style="width: 30px;height: 20px;" field="THIRD_RATE"/></label></td>
							<td align="right" style="padding-right: 2px;"><label style="width: 30px;height: 20px;" field="BOTH_PLACES_NUM"/></label></td>
							<td align="right" style="padding-right: 2px;"><label style="width: 30px;height: 20px;" field="BOTH_PLACES_RATE"/></label></td>
							<td align="right" style="padding-right: 2px;"><label style="width: 30px;height: 20px;" field="EDUCATION_NUM"/></label></td>
							<td align="right" style="padding-right: 2px;"><label style="width: 30px;height: 20px;" field="EDUCATION_RATE"/></label></td>
							<td align="right" style="padding-right: 2px;"><label style="width: 30px;height: 20px;" field="DISSENSION_NUM"/></label></td>
							<td align="right" style="padding-right: 2px;"><label style="width: 30px;height: 20px;" field="DISSENSION_RATE"/></label></td>
							<td align="right" style="padding-right: 2px;"><label style="width: 30px;height: 20px;" field="SEXUAL_NUM"/></label></td>
							<td align="right" style="padding-right: 2px;"><label style="width: 30px;height: 20px;" field="SEXUAL_RATE"/></label></td>
							<td align="right" style="padding-right: 2px;"><label style="width: 30px;height: 20px;" field="ILLEGAL_NUM"/></label></td>
							<td align="right" style="padding-right: 2px;"><label style="width: 30px;height: 20px;" field="ILLEGAL_RATE"/></label></td>
							<td align="right" style="padding-right: 2px;"><label style="width: 30px;height: 20px;" field="BAD_HADIT_NUM"/></label></td>
							<td align="right" style="padding-right: 2px;"><label style="width: 30px;height: 20px;" field="BAD_HADIT_RATE"/></label></td>
							<td align="right" style="padding-right: 2px;"><label style="width: 30px;height: 20px;" field="NOT_FAMILIAR_NUM"/></label></td>
							<td align="right" style="padding-right: 2px;"><label style="width: 30px;height: 20px;" field="NOT_FAMILIAR_RATE"/></label></td>
							<td align="right" style="padding-right: 2px;"><label style="width: 30px;height: 20px;" field="OTHERS_NUM"/></label></td>
							<td align="right" style="padding-right: 2px;"><label style="width: 30px;height: 20px;" field="OTHERS_RATE"/></label></td>
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
