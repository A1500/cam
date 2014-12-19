<%@ page contentType="charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/tags/next-excel" prefix="Excel"%>
<%@page import="org.loushang.next.data.DataSet"%>
<%@page import="org.loushang.next.data.Record"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<%@ page import="org.loushang.bsp.security.context.GetBspInfo"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.*"%>
<head>
<title>导出Excel</title>
<%
	SimpleDateFormat sdf=new SimpleDateFormat("yyyy年MM月dd日HH时mm分");
	SimpleDateFormat sdf2=new SimpleDateFormat("yyyy年MM月dd日");
	String date=sdf.format(new Date());
	String date2=sdf2.format(new Date());
	String name="最低生活保障统计总表_"+date;
	String username=GetBspInfo.getBspInfo(request).getUserName();
%>
</head>
<Excel:tablelist filename="<%=name %>">
	<Excel:table sheetname="最低生活保障统计总表">
		<Excel:tr>
			<Excel:td colspan="16" align="center" ><Excel:font size="15"  bold="true">最低生活保障统计总表</Excel:font></Excel:td>
		</Excel:tr>
		<Excel:tr>
			<Excel:td colspan="8" align="left">统计单位：<%= BspUtil.getOrganName()%></Excel:td>
			<Excel:td colspan="8" align="right">统计时间:<%=request.getParameter("statisticsTime")%></Excel:td>
		</Excel:tr>
		<Excel:tr height="30" bgcolor="grey" border="1">
			<Excel:td  align="center" width="100"  rowspan="2" bordercolor="black">单位</Excel:td>
			<Excel:td  align="center" width="100"  colspan="3" bordercolor="black">中属保障情况</Excel:td>			
			<Excel:td  align="center" width="100"  colspan="3" bordercolor="black">省属保障情况</Excel:td>
			<Excel:td  align="center" width="100"  colspan="3" bordercolor="black">市属保障情况</Excel:td>
			<Excel:td  align="center" width="100"  colspan="3" bordercolor="black">县属保障情况</Excel:td>			
			<Excel:td  align="center" width="100"  colspan="3" bordercolor="black">保障情况合计</Excel:td>
		</Excel:tr>
		<Excel:tr height="20" bgcolor="grey" border="1">
			<Excel:td  align="center" bordercolor="black" >户数</Excel:td>
			<Excel:td  align="center" bordercolor="black" >人数</Excel:td>			
			<Excel:td  align="center" bordercolor="black" >月保障额</Excel:td>
			<Excel:td  align="center" bordercolor="black" >户数</Excel:td>
			<Excel:td  align="center" bordercolor="black" >人数</Excel:td>			
			<Excel:td  align="center" bordercolor="black" >月保障额</Excel:td>
	        <Excel:td  align="center" bordercolor="black" >户数</Excel:td>
			<Excel:td  align="center" bordercolor="black" >人数</Excel:td>			
			<Excel:td  align="center" bordercolor="black" >月保障额</Excel:td>
	        <Excel:td  align="center" bordercolor="black" >户数</Excel:td>
			<Excel:td  align="center" bordercolor="black" >人数</Excel:td>			
			<Excel:td  align="center" bordercolor="black" >月保障额</Excel:td>
		    <Excel:td  align="center" bordercolor="black" >户数</Excel:td>
			<Excel:td  align="center" bordercolor="black" >人数</Excel:td>			
			<Excel:td  align="center" bordercolor="black" >月保障额</Excel:td>
		</Excel:tr>
		<%
			DataSet ds = (DataSet)request.getAttribute("dataset");
				for(int i=0; i<ds.getCount(); i++) {
					Record rec = ds.getRecord(i);
		%>
		<Excel:tr border="1">
			<Excel:td align="center"><%=rec.get("ITEM_NAME")%></Excel:td>
			<Excel:td align="rihgt"><%=rec.get("CENTER_FAMILY_NUM")%></Excel:td>
			<Excel:td align="rihgt"><%=rec.get("CENTER_PEOPLE_NUM")%></Excel:td>			
			<Excel:td align="rihgt"><%=rec.get("CENTER_MONEY_MONTH")%></Excel:td>
			<Excel:td align="rihgt"><%=rec.get("PROVINCE_FAMILY_NUM")%></Excel:td>
			<Excel:td align="rihgt"><%=rec.get("PROVINCE_PEOPLE_NUM")%></Excel:td>
			<Excel:td align="rihgt"><%=rec.get("PROVINCE_MONEY_MONTH")%></Excel:td>
			<Excel:td align="rihgt"><%=rec.get("CITY_FAMILY_NUM")%></Excel:td>
			<Excel:td align="rihgt"><%=rec.get("CITY_PEOPLE_NUM")%></Excel:td>
			<Excel:td align="rihgt"><%=rec.get("CITY_MONEY_MONTH")%></Excel:td>
			<Excel:td align="rihgt"><%=rec.get("TOWN_FAMILY_NUM")%></Excel:td>
			<Excel:td align="rihgt"><%=rec.get("TOWN_PEOPLE_NUM")%></Excel:td>
			<Excel:td align="rihgt"><%=rec.get("TOWN_MONEY_MONTH")%></Excel:td>
			<Excel:td align="rihgt"><%=rec.get("TOTAL_FAMILY_NUM")%></Excel:td>
			<Excel:td align="rihgt"><%=rec.get("TOTAL_PEOPLE_NUM")%></Excel:td>
			<Excel:td align="rihgt"><%=rec.get("TOTAL_MONEY_MONTH")%></Excel:td>
		</Excel:tr>
		<%
			}
		%>
		<Excel:tr>
			<Excel:td colspan="8" align="left">制表人：<%= username%></Excel:td>
			<Excel:td colspan="8" align="right">制表时间：<%= date2%></Excel:td>
		</Excel:tr>
	</Excel:table>
</Excel:tablelist>

