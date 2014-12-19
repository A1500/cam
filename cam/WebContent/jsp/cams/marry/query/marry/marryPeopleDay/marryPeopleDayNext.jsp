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
	String username= GetBspInfo.getBspInfo(request).getUserName();
%>
<script>
	var xzqu = '<%=request.getParameter("xzqu")%>';
	var cxsjq = '<%=request.getParameter("cxsjq")%>';
	var cxsjqm = '<%=request.getParameter("cxsjqm")%>';
	var organName = '<%=BspUtil.getOrganName()%>';
	var pageflag ='<%=request.getParameter("pageflag")%>';
</script>
<html>
<head>
<next:ScriptManager />
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js") %>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript" src="marryPeopleDayNext.js"></script>
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

.tdTitle {
	border-style: solid;
	border-color: #000000;
	border-width: 1.5px;
	height: 20px;
	word-break: break-all;
	font-weight: bold;
}
.btTitle {
	word-break: break-all;
	font-weight: bold;
	font-size: x-small;
}

.tdBottom {
	border-style: solid;
	border-color: #000000;
	border-width: 1.5px;
	height: 20px;
	word-break: break-all;
	font-weight: bold;
	border-top-style: none;
	border-left-style: none;
	border-right-style: none;
    border-bottom-style: none;
    FONT-SIZE: 10pt;
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
	<model:dataset id="dsNext" cmd="com.inspur.cams.marry.statisticDay.cmd.MarryPeopleDayQueryCommand" global="true"  autoLoad="false">
		<model:record fromBean="com.inspur.cams.marry.statisticDay.dao.MarryPeopleDay"></model:record>
	</model:dataset>
</model:datasets>
<next:ViewPort>
	<next:Panel width="100%" border="0"
		bodyStyle="background-color:#EAF4FD;padding-bottom:10px;padding-top:12px;"
		height="100%" autoScroll="true">
		<next:Html>
		    <div align="center"  >
			<div align="center" style="width: 90%;">
			<div align="center"><span id="reportTitle"
				style="font-size: large;">结婚登记统计总表</span></div>
			</div>
			<div align="right" class="L5form">
			<button onclick="forExcel()">导出Excel</button>&nbsp;&nbsp;
			<button onclick="back()">返回</button>&nbsp;&nbsp;
			</div>
	 
			<table style="border-style: hidden; width: 90%" cellpadding="0" cellspacing="0" border="0">
				 <tr>
					<td colspan="2" style="border-width: 0px">
					<div align="left"><span class= "btTitle">统计单位：<%=BspUtil.getOrganName()%></span></div>
					<td colspan="2" style="border-width: 0px">
					<div align="right"><span class= "btTitle">统计时间：<label id="statisticsTime" class= "btTitle"/></span></div>
				</tr>
				<tr>
					<td colspan="4" style="border-width: 0px">
					<table width="100%" dataset="dsNext" align="center">
					   <tbody id="resultsBody">
					   <tr>
							<td class="tdTitle" width="20%" align="center" rowspan="2">地区</td>
							<td class="tdTitle" width="80%" align="center" colspan="31"  >按日期分类(结婚对数)</td>
						</tr>
						<tr>
							<td class="tdTitle" width="2%" align="center" style="background-color: #DAE9F3">1</td>
							<td class="tdTitle" width="2%" align="center" style="background-color: #DAE9F3">2</td>
							<td class="tdTitle" width="2%" align="center" style="background-color: #DAE9F3">3</td>
							<td class="tdTitle" width="2%" align="center" style="background-color: #DAE9F3">4</td>
							<td class="tdTitle" width="2%" align="center" style="background-color: #DAE9F3">5</td>
							<td class="tdTitle" width="2%" align="center" style="background-color: #DAE9F3">6</td>
							<td class="tdTitle" width="2%" align="center" style="background-color: #DAE9F3">7</td>
							<td class="tdTitle" width="2%" align="center" style="background-color: #DAE9F3">8</td>
							<td class="tdTitle" width="2%" align="center" style="background-color: #DAE9F3">9</td>
							<td class="tdTitle" width="2%" align="center" style="background-color: #DAE9F3">10</td>
							<td class="tdTitle" width="2%" align="center" style="background-color: #DAE9F3">11</td>
							<td class="tdTitle" width="2%" align="center" style="background-color: #DAE9F3">12</td>
							<td class="tdTitle" width="2%" align="center" style="background-color: #DAE9F3">13</td>
							<td class="tdTitle" width="2%" align="center" style="background-color: #DAE9F3">14</td>
							<td class="tdTitle" width="2%" align="center" style="background-color: #DAE9F3">15</td>
							<td class="tdTitle" width="2%" align="center" style="background-color: #DAE9F3">16</td>
							<td class="tdTitle" width="2%" align="center" style="background-color: #DAE9F3">17</td>
							<td class="tdTitle" width="2%" align="center" style="background-color: #DAE9F3">18</td>
							<td class="tdTitle" width="2%" align="center" style="background-color: #DAE9F3">19</td>
							<td class="tdTitle" width="2%" align="center" style="background-color: #DAE9F3">20</td>
							<td class="tdTitle" width="2%" align="center" style="background-color: #DAE9F3">21</td>
							<td class="tdTitle" width="2%" align="center" style="background-color: #DAE9F3">22</td>
							<td class="tdTitle" width="2%" align="center" style="background-color: #DAE9F3">23</td>
							<td class="tdTitle" width="2%" align="center" style="background-color: #DAE9F3">24</td>
							<td class="tdTitle" width="2%" align="center" style="background-color: #DAE9F3">25</td>
							<td class="tdTitle" width="2%" align="center" style="background-color: #DAE9F3">26</td>
							<td class="tdTitle" width="2%" align="center" style="background-color: #DAE9F3">27</td>
							<td class="tdTitle" width="2%" align="center" style="background-color: #DAE9F3">28</td>
							<td class="tdTitle" width="2%" align="center" style="background-color: #DAE9F3">29</td>
							<td class="tdTitle" width="2%" align="center" style="background-color: #DAE9F3">30</td>
							<td class="tdTitle" width="2%" align="center" style="background-color: #DAE9F3">31</td>
						</tr>
						<tr repeat="true" >
							<td align="center"><label style="width: 100px;" field="ITEMNAME"  onclick="queryNextLevel(this)" /></label><label style="display: none;" field="ITEMCODE" /></label></td>
							<td align="right" style="padding-right: 2px"><label style="width: 30px;height: 20px;" field="ONE"/></label></td>
							<td align="right" style="padding-right: 2px"><label style="width: 30px;height: 20px;" field="TWO"/></label></td>
							<td align="right" style="padding-right: 2px"><label style="width: 30px;height: 20px;" field="THR"/></label></td>
					        <td align="right" style="padding-right: 2px"><label style="width: 30px;height: 20px;" field="FOUR"/></label></td>
						    <td align="right" style="padding-right: 2px"><label style="width: 30px;height: 20px;" field="FIVE"/></label></td>
						    <td align="right" style="padding-right: 2px"><label style="width: 30px;height: 20px;" field="SIX"/></label></td>
						    <td align="right" style="padding-right: 2px"><label style="width: 30px;height: 20px;" field="SEVEN"/></label></td>
						    <td align="right" style="padding-right: 2px"><label style="width: 30px;height: 20px;" field="EIGHT"/></label></td>
						    <td align="right" style="padding-right: 2px"><label style="width: 30px;height: 20px;" field="NINE"/></label></td>
						    <td align="right" style="padding-right: 2px"><label style="width: 30px;height: 20px;" field="TEN"/></label></td>
						    <td align="right" style="padding-right: 2px"><label style="width: 30px;height: 20px;" field="ELEVEN"/></label></td>
						    <td align="right" style="padding-right: 2px"><label style="width: 30px;height: 20px;" field="TWELVE"/></label></td>
						    <td align="right" style="padding-right: 2px"><label style="width: 30px;height: 20px;" field="THIRTEEN"/></label></td>
							<td align="right" style="padding-right: 2px"><label style="width: 30px;height: 20px;" field="FOURTEEN"/></label></td>
							<td align="right" style="padding-right: 2px"><label style="width: 30px;height: 20px;" field="FIFTEEN"/></label></td>
					        <td align="right" style="padding-right: 2px"><label style="width: 30px;height: 20px;" field="SISTEEN"/></label></td>
						    <td align="right" style="padding-right: 2px"><label style="width: 30px;height: 20px;" field="SEVENTEEN"/></label></td>
						    <td align="right" style="padding-right: 2px"><label style="width: 30px;height: 20px;" field="EIGHTEEN"/></label></td>
						    <td align="right" style="padding-right: 2px"><label style="width: 30px;height: 20px;" field="NINETEEN"/></label></td>
						    <td align="right" style="padding-right: 2px"><label style="width: 30px;height: 20px;" field="TWENTY"/></label></td>
						    <td align="right" style="padding-right: 2px"><label style="width: 30px;height: 20px;" field="TWENTYONE"/></label></td>
						    <td align="right" style="padding-right: 2px"><label style="width: 30px;height: 20px;" field="TWENTYTWO"/></label></td>
						    <td align="right" style="padding-right: 2px"><label style="width: 30px;height: 20px;" field="TWENTYTHREE"/></label></td>
						    <td align="right" style="padding-right: 2px"><label style="width: 30px;height: 20px;" field="TWENTYFOUR"/></label></td>
						    <td align="right" style="padding-right: 2px"><label style="width: 30px;height: 20px;" field="TWENTYFIVE"/></label></td>
						    <td align="right" style="padding-right: 2px"><label style="width: 30px;height: 20px;" field="TWENTYSIX"/></label></td>
						    <td align="right" style="padding-right: 2px"><label style="width: 30px;height: 20px;" field="TWENTYSEVEN"/></label></td>
						    <td align="right" style="padding-right: 2px"><label style="width: 30px;height: 20px;" field="TWENTYEIGHT"/></label></td>
						    <td align="right" style="padding-right: 2px"><label style="width: 30px;height: 20px;" field="TWENTYNINE"/></label></td>
						    <td align="right" style="padding-right: 2px"><label style="width: 30px;height: 20px;" field="THIRTY"/></label></td>
						    <td align="right" style="padding-right: 2px"><label style="width: 30px;height: 20px;" field="THIRTYONE"/></label></td>
						</tr>
						</tbody>
					</table>
					</td>
				</tr>
				<tr>
					<td colspan="2" style="border-width: 0px">
					<div align="left"><span class= "btTitle">制表人：<%=username %></span></div></td>
					<td colspan="4" style="border-width: 0px">
					<div align="right"><span class= "btTitle">制表时间：<%=date %></span></div>
				</tr>
			</table>
			</div>
		</next:Html>
	</next:Panel>
</next:ViewPort>
</body>
</html>
