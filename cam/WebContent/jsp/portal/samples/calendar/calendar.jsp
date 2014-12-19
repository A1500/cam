<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="org.loushang.portal.util.PortalJspUtil" %>
<%
	String webPath=PortalJspUtil.webPath(request);
%>
<html>
<head>
 <script type="text/javascript" src="<%=webPath %>/jsp/portal/samples/calendar/calendar.js"></script>
  <link rel="stylesheet" type="text/css" href="<%=webPath %>/jsp/portal/samples/calendar/calendar.css" />
</head>
<body>
	<div id="date">
		<p>公历
		<select onchange="changeCld()" id="sy">
		<%
		 int year=1900;
		 for(int i=0;i<150;i++)
		 {
		%>
		<option><%= year+i%></option>
		<%
		 }
		%>
		</select>
			年 
		<select onchange="changeCld()" id="sm">
		<%
		 int month=1;
		 for(int i=0;i<12;i++)
		 {
		%>
		<option><%= month+i%></option>
		<%
		 }
		%></select>
			月
		<span id="gz">&nbsp;</span></p>
	</div>
	<div id="calendar" align="center">
		<div id="detail"><div id="datedetail"></div><div id="festival"></div></div>
	<table id="calendarhead" width="100%" >
		<tr align="center"> 
			<td>日</td>
			<td>一</td>
			<td>二</td>
			<td>三</td>
			<td>四</td>
			<td>五</td>
			<td>六</td>
		</tr>
	</table>
	<table align="center" width="100%">
<tr class="tr1"  align="center">
<td class="aorange" onmouseout="mOut()" onmouseover="mOvr(0)" id="sd0" style="width:45px;font-size: 12px;border-bottom: 1px solid #efefef;border-left: 1px solid #efefef;"></td>
<td class="one" onmouseout="mOut()" onmouseover="mOvr(1)" id="sd1" style="width:45px;font-size: 12px;border-bottom: 1px solid #efefef;border-left: 1px solid #efefef;"></td>
<td class="one" onmouseout="mOut()" onmouseover="mOvr(2)" id="sd2" style="width:45px;font-size: 12px;border-bottom: 1px solid #efefef;border-left: 1px solid #efefef;"></td>
<td class="one" onmouseout="mOut()" onmouseover="mOvr(3)" id="sd3" style="width:45px;font-size: 12px;border-bottom: 1px solid #efefef;border-left: 1px solid #efefef;"></td>
<td class="one" onmouseout="mOut()" onmouseover="mOvr(4)" id="sd4" style="width:45px;font-size: 12px;border-bottom: 1px solid #efefef;border-left: 1px solid #efefef;"></td>
<td class="one" onmouseout="mOut()" onmouseover="mOvr(5)" id="sd5" style="width:45px;font-size: 12px;border-bottom: 1px solid #efefef;border-left: 1px solid #efefef;"></td>
<td class="agreen" onmouseout="mOut()" onmouseover="mOvr(6)" id="sd6" style="width:45px;font-size: 12px;border-bottom: 1px solid #efefef;border-left: 1px solid #efefef;"></td>
</tr>
<tr class="tr2"  align="center">
<td onmouseout="mOut()" onmouseover="mOvr(0)" id="ld0" style="font-size: 12px;border-bottom: 1px solid #efefef;border-left: 1px solid #efefef;"></td>
<td onmouseout="mOut()" onmouseover="mOvr(1)" id="ld1" style="font-size: 12px;border-bottom: 1px solid #efefef;border-left: 1px solid #efefef;"></td>
<td onmouseout="mOut()" onmouseover="mOvr(2)" id="ld2" style="font-size: 12px;border-bottom: 1px solid #efefef;border-left: 1px solid #efefef;"></td>
<td onmouseout="mOut()" onmouseover="mOvr(3)" id="ld3" style="font-size: 12px;border-bottom: 1px solid #efefef;border-left: 1px solid #efefef;"></td>
<td onmouseout="mOut()" onmouseover="mOvr(4)" id="ld4" style="font-size: 12px;border-bottom: 1px solid #efefef;border-left: 1px solid #efefef;"></td>
<td onmouseout="mOut()" onmouseover="mOvr(5)" id="ld5" style="font-size: 12px;border-bottom: 1px solid #efefef;border-left: 1px solid #efefef;"></td>
<td onmouseout="mOut()" onmouseover="mOvr(6)" id="ld6" style="font-size: 12px;border-bottom: 1px solid #efefef;border-left: 1px solid #efefef;"></td>
</tr>
<tr class="tr1"  align="center">
<td class="aorange" onmouseout="mOut()" onmouseover="mOvr(7)" id="sd7" style="font-size: 12px;border-bottom: 1px solid #efefef;border-left: 1px solid #efefef;"></td>
<td class="one" onmouseout="mOut()" onmouseover="mOvr(8)" id="sd8" style="font-size: 12px;border-bottom: 1px solid #efefef;border-left: 1px solid #efefef;"></td>
<td class="one" onmouseout="mOut()" onmouseover="mOvr(9)" id="sd9" style="font-size: 12px;border-bottom: 1px solid #efefef;border-left: 1px solid #efefef;"></td>
<td class="one" onmouseout="mOut()" onmouseover="mOvr(10)" id="sd10" style="font-size: 12px;border-bottom: 1px solid #efefef;border-left: 1px solid #efefef;"></td>
<td class="one" onmouseout="mOut()" onmouseover="mOvr(11)" id="sd11" style="font-size: 12px;border-bottom: 1px solid #efefef;border-left: 1px solid #efefef;"></td>
<td class="one" onmouseout="mOut()" onmouseover="mOvr(12)" id="sd12" style="font-size: 12px;border-bottom: 1px solid #efefef;border-left: 1px solid #efefef;"></td>
<td class="aorange" onmouseout="mOut()" onmouseover="mOvr(13)" id="sd13" style="font-size: 12px;border-bottom: 1px solid #efefef;border-left: 1px solid #efefef;"></td>
</tr>
<tr class="tr2"  align="center">
<td onmouseout="mOut()" onmouseover="mOvr(7)" id="ld7" style="font-size: 12px;border-bottom: 1px solid #efefef;border-left: 1px solid #efefef;"></td>
<td onmouseout="mOut()" onmouseover="mOvr(8)" id="ld8" style="font-size: 12px;border-bottom: 1px solid #efefef;border-left: 1px solid #efefef;"></td>
<td onmouseout="mOut()" onmouseover="mOvr(9)" id="ld9" style="font-size: 12px;border-bottom: 1px solid #efefef;border-left: 1px solid #efefef;"></td>
<td onmouseout="mOut()" onmouseover="mOvr(10)" id="ld10" style="font-size: 12px;border-bottom: 1px solid #efefef;border-left: 1px solid #efefef;"></td>
<td onmouseout="mOut()" onmouseover="mOvr(11)" id="ld11" style="font-size: 12px;border-bottom: 1px solid #efefef;border-left: 1px solid #efefef;"></td>
<td onmouseout="mOut()" onmouseover="mOvr(12)" id="ld12" style="font-size: 12px;border-bottom: 1px solid #efefef;border-left: 1px solid #efefef;"></td>
<td onmouseout="mOut()" onmouseover="mOvr(13)" id="ld13" style="font-size: 12px;border-bottom: 1px solid #efefef;border-left: 1px solid #efefef;"></td>
</tr>
<tr class="tr1"  align="center">
<td class="aorange" onmouseout="mOut()" onmouseover="mOvr(14)" id="sd14" style="font-size: 12px;border-bottom: 1px solid #efefef;border-left: 1px solid #efefef;"></td>
<td class="one" onmouseout="mOut()" onmouseover="mOvr(15)" id="sd15" style="font-size: 12px;border-bottom: 1px solid #efefef;border-left: 1px solid #efefef;"></td>
<td class="one" onmouseout="mOut()" onmouseover="mOvr(16)" id="sd16" style="font-size: 12px;border-bottom: 1px solid #efefef;border-left: 1px solid #efefef;"></td>
<td class="one" onmouseout="mOut()" onmouseover="mOvr(17)" id="sd17"style="font-size: 12px;border-bottom: 1px solid #efefef;border-left: 1px solid #efefef;"></td>
<td class="one" onmouseout="mOut()" onmouseover="mOvr(18)" id="sd18"style="font-size: 12px;border-bottom: 1px solid #efefef;border-left: 1px solid #efefef;"></td>
<td class="one" onmouseout="mOut()" onmouseover="mOvr(19)" id="sd19"style="font-size: 12px;border-bottom: 1px solid #efefef;border-left: 1px solid #efefef;"></td>
<td class="agreen" onmouseout="mOut()" onmouseover="mOvr(20)" id="sd20"style="font-size: 12px;border-bottom: 1px solid #efefef;border-left: 1px solid #efefef;"></td>
</tr>
<tr class="tr2"  align="center">
<td onmouseout="mOut()" onmouseover="mOvr(14)" id="ld14"style="font-size: 12px;border-bottom: 1px solid #efefef;border-left: 1px solid #efefef;"></td>
<td onmouseout="mOut()" onmouseover="mOvr(15)" id="ld15"style="font-size: 12px;border-bottom: 1px solid #efefef;border-left: 1px solid #efefef;"></td>
<td onmouseout="mOut()" onmouseover="mOvr(16)" id="ld16"style="font-size: 12px;border-bottom: 1px solid #efefef;border-left: 1px solid #efefef;"></td>
<td onmouseout="mOut()" onmouseover="mOvr(17)" id="ld17"style="font-size: 12px;border-bottom: 1px solid #efefef;border-left: 1px solid #efefef;"></td>
<td onmouseout="mOut()" onmouseover="mOvr(18)" id="ld18"style="font-size: 12px;border-bottom: 1px solid #efefef;border-left: 1px solid #efefef;"></td>
<td onmouseout="mOut()" onmouseover="mOvr(19)" id="ld19"style="font-size: 12px;border-bottom: 1px solid #efefef;border-left: 1px solid #efefef;"></td>
<td onmouseout="mOut()" onmouseover="mOvr(20)" id="ld20"style="font-size: 12px;border-bottom: 1px solid #efefef;border-left: 1px solid #efefef;"></td>
</tr>
<tr class="tr1"  align="center">
<td class="aorange" onmouseout="mOut()" onmouseover="mOvr(21)" id="sd21"style="font-size: 12px;border-bottom: 1px solid #efefef;border-left: 1px solid #efefef;"></td>
<td class="one" onmouseout="mOut()" onmouseover="mOvr(22)" id="sd22"style="font-size: 12px;border-bottom: 1px solid #efefef;border-left: 1px solid #efefef;"></td>
<td class="one" onmouseout="mOut()" onmouseover="mOvr(23)" id="sd23"style="font-size: 12px;border-bottom: 1px solid #efefef;border-left: 1px solid #efefef;"></td>
<td class="one" onmouseout="mOut()" onmouseover="mOvr(24)" id="sd24"style="font-size: 12px;border-bottom: 1px solid #efefef;border-left: 1px solid #efefef;"></td>
<td class="one" onmouseout="mOut()" onmouseover="mOvr(25)" id="sd25"style="font-size: 12px;border-bottom: 1px solid #efefef;border-left: 1px solid #efefef;"></td>
<td class="one" onmouseout="mOut()" onmouseover="mOvr(26)" id="sd26"style="font-size: 12px;border-bottom: 1px solid #efefef;border-left: 1px solid #efefef;"></td>
<td class="aorange" onmouseout="mOut()" onmouseover="mOvr(27)" id="sd27"style="font-size: 12px;border-bottom: 1px solid #efefef;border-left: 1px solid #efefef;"></td>
</tr>
<tr class="tr2"  align="center">
<td onmouseout="mOut()" onmouseover="mOvr(21)" id="ld21"style="font-size: 12px;border-bottom: 1px solid #efefef;border-left: 1px solid #efefef;"></td>
<td onmouseout="mOut()" onmouseover="mOvr(22)" id="ld22"style="font-size: 12px;border-bottom: 1px solid #efefef;border-left: 1px solid #efefef;"></td>
<td onmouseout="mOut()" onmouseover="mOvr(23)" id="ld23"style="font-size: 12px;border-bottom: 1px solid #efefef;border-left: 1px solid #efefef;"></td>
<td onmouseout="mOut()" onmouseover="mOvr(24)" id="ld24"style="font-size: 12px;border-bottom: 1px solid #efefef;border-left: 1px solid #efefef;"></td>
<td onmouseout="mOut()" onmouseover="mOvr(25)" id="ld25"style="font-size: 12px;border-bottom: 1px solid #efefef;border-left: 1px solid #efefef;"></td>
<td onmouseout="mOut()" onmouseover="mOvr(26)" id="ld26"style="font-size: 12px;border-bottom: 1px solid #efefef;border-left: 1px solid #efefef;"></td>
<td onmouseout="mOut()" onmouseover="mOvr(27)" id="ld27"style="font-size: 12px;border-bottom: 1px solid #efefef;border-left: 1px solid #efefef;"></td>
</tr>
<tr class="tr1"  align="center">
<td class="aorange" onmouseout="mOut()" onmouseover="mOvr(28)" id="sd28"style="font-size: 12px;border-bottom: 1px solid #efefef;border-left: 1px solid #efefef;"></td>
<td class="one" onmouseout="mOut()" onmouseover="mOvr(29)" id="sd29"style="font-size: 12px;border-bottom: 1px solid #efefef;border-left: 1px solid #efefef;"></td>
<td class="one" onmouseout="mOut()" onmouseover="mOvr(30)" id="sd30"style="font-size: 12px;border-bottom: 1px solid #efefef;border-left: 1px solid #efefef;"></td>
<td class="one" onmouseout="mOut()" onmouseover="mOvr(31)" id="sd31"style="font-size: 12px;border-bottom: 1px solid #efefef;border-left: 1px solid #efefef;"></td>
<td class="one" onmouseout="mOut()" onmouseover="mOvr(32)" id="sd32"style="font-size: 12px;border-bottom: 1px solid #efefef;border-left: 1px solid #efefef;"></td>
<td class="one" onmouseout="mOut()" onmouseover="mOvr(33)" id="sd33"style="font-size: 12px;border-bottom: 1px solid #efefef;border-left: 1px solid #efefef;"></td>
<td class="agreen" onmouseout="mOut()" onmouseover="mOvr(34)" id="sd34"style="font-size: 12px;border-bottom: 1px solid #efefef;border-left: 1px solid #efefef;"></td>
</tr>
<tr class="tr2"  align="center">
<td onmouseout="mOut()" onmouseover="mOvr(28)" id="ld28"style="font-size: 12px;border-bottom: 1px solid #efefef;border-left: 1px solid #efefef;"></td>
<td onmouseout="mOut()" onmouseover="mOvr(29)" id="ld29"style="font-size: 12px;border-bottom: 1px solid #efefef;border-left: 1px solid #efefef;"></td>
<td onmouseout="mOut()" onmouseover="mOvr(30)" id="ld30"style="font-size: 12px;border-bottom: 1px solid #efefef;border-left: 1px solid #efefef;"></td>
<td onmouseout="mOut()" onmouseover="mOvr(31)" id="ld31"style="font-size: 12px;border-bottom: 1px solid #efefef;border-left: 1px solid #efefef;"></td>
<td onmouseout="mOut()" onmouseover="mOvr(32)" id="ld32"style="font-size: 12px;border-bottom: 1px solid #efefef;border-left: 1px solid #efefef;"></td>
<td onmouseout="mOut()" onmouseover="mOvr(33)" id="ld33"style="font-size: 12px;border-bottom: 1px solid #efefef;border-left: 1px solid #efefef;"></td>
<td onmouseout="mOut()" onmouseover="mOvr(34)" id="ld34"style="font-size: 12px;border-bottom: 1px solid #efefef;border-left: 1px solid #efefef;"></td>
</tr>
<tr class="tr1"  align="center">
<td class="aorange" onmouseout="mOut()" onmouseover="mOvr(35)" id="sd35"style="font-size: 12px;border-bottom: 1px solid #efefef;border-left: 1px solid #efefef;"></td>
<td class="one" onmouseout="mOut()" onmouseover="mOvr(36)" id="sd36"style="font-size: 12px;border-bottom: 1px solid #efefef;border-left: 1px solid #efefef;"></td>
<td class="one" onmouseout="mOut()" onmouseover="mOvr(37)" id="sd37"style="font-size: 12px;border-bottom: 1px solid #efefef;border-left: 1px solid #efefef;"></td>
<td class="one" onmouseout="mOut()" onmouseover="mOvr(38)" id="sd38"style="font-size: 12px;border-bottom: 1px solid #efefef;border-left: 1px solid #efefef;"></td>
<td class="one" onmouseout="mOut()" onmouseover="mOvr(39)" id="sd39"style="font-size: 12px;border-bottom: 1px solid #efefef;border-left: 1px solid #efefef;"></td>
<td class="one" onmouseout="mOut()" onmouseover="mOvr(40)" id="sd40"style="font-size: 12px;border-bottom: 1px solid #efefef;border-left: 1px solid #efefef;"></td>
<td class="aorange" onmouseout="mOut()" onmouseover="mOvr(41)" id="sd41"style="font-size: 12px;border-bottom: 1px solid #efefef;border-left: 1px solid #efefef;"></td>
</tr>
<tr class="tr2"  align="center">
<td onmouseout="mOut()" onmouseover="mOvr(35)" id="ld35"style="font-size: 12px;border-bottom: 1px solid #efefef;border-left: 1px solid #efefef;"></td>
<td onmouseout="mOut()" onmouseover="mOvr(36)" id="ld36"style="font-size: 12px;border-bottom: 1px solid #efefef;border-left: 1px solid #efefef;"></td>
<td onmouseout="mOut()" onmouseover="mOvr(37)" id="ld37"style="font-size: 12px;border-bottom: 1px solid #efefef;border-left: 1px solid #efefef;"></td>
<td onmouseout="mOut()" onmouseover="mOvr(38)" id="ld38"style="font-size: 12px;border-bottom: 1px solid #efefef;border-left: 1px solid #efefef;"></td>
<td onmouseout="mOut()" onmouseover="mOvr(39)" id="ld39"style="font-size: 12px;border-bottom: 1px solid #efefef;border-left: 1px solid #efefef;"></td>
<td onmouseout="mOut()" onmouseover="mOvr(40)" id="ld40"style="font-size: 12px;border-bottom: 1px solid #efefef;border-left: 1px solid #efefef;"></td>
<td onmouseout="mOut()" onmouseover="mOvr(41)" id="ld41"style="font-size: 12px;border-bottom: 1px solid #efefef;border-left: 1px solid #efefef;"></td>
</tr>
</table>
	</div>
	<script type="text/javascript">
		initial();
	</script>
</body>
</html>