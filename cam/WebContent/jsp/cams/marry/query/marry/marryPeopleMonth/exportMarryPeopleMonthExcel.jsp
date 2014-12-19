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
	String name="结婚登记统计总表_"+date;
	String username=GetBspInfo.getBspInfo(request).getUserName();
%>
</head>
<Excel:tablelist filename="<%=name %>">
	<Excel:table sheetname="结婚登记统计总表">
		<Excel:tr>
			<Excel:td colspan="13" align="center" ><Excel:font size="15">结婚登记统计总表</Excel:font></Excel:td>
		</Excel:tr>
		<Excel:tr>
			<Excel:td colspan="6" align="left">统计单位：<%= BspUtil.getOrganName()%></Excel:td>
			<Excel:td colspan="7" align="right">统计时间:<%=request.getParameter("statisticsTime")%></Excel:td>
		</Excel:tr>
		<Excel:tr height="30" bgcolor="grey" border="1">
			<Excel:td  align="center" width="100" rowspan="2" bordercolor="black">地区</Excel:td>
			<Excel:td  align="center" width="100" colspan="12" bordercolor="black">按月份分类(对)</Excel:td>
		</Excel:tr>
		<Excel:tr height="20" bgcolor="grey" border="1">
			<Excel:td  align="center" bordercolor="black" >一月份</Excel:td>			
			<Excel:td  align="center" bordercolor="black" >二月份</Excel:td>
			<Excel:td  align="center" bordercolor="black" >三月份</Excel:td>	
			<Excel:td  align="center" bordercolor="black" >四月份</Excel:td>
			<Excel:td  align="center" bordercolor="black" >五月份</Excel:td>	
			<Excel:td  align="center" bordercolor="black" >六月份</Excel:td>
			<Excel:td  align="center" bordercolor="black" >七月份</Excel:td>	
			<Excel:td  align="center" bordercolor="black" >八月份</Excel:td>
			<Excel:td  align="center" bordercolor="black" >九月份</Excel:td>	
			<Excel:td  align="center" bordercolor="black" >十月份</Excel:td>
			<Excel:td  align="center" bordercolor="black" >十一月份</Excel:td>
			<Excel:td  align="center" bordercolor="black" >十二月份</Excel:td>			
		</Excel:tr>
		<%
			DataSet ds = (DataSet)request.getAttribute("dataset");
				for(int i=0; i<ds.getCount(); i++) {
					Record rec = ds.getRecord(i);
		%>
		<Excel:tr border="1">
			<Excel:td align="center"><%=rec.get("ITEMNAME")%></Excel:td>
			<Excel:td align="rihgt"><%=rec.get("JAN")%></Excel:td>
			<Excel:td align="rihgt"><%=rec.get("FEB")%></Excel:td>			
			<Excel:td align="rihgt"><%=rec.get("MAR")%></Excel:td>
			<Excel:td align="rihgt"><%=rec.get("APR")%></Excel:td>
			<Excel:td align="rihgt"><%=rec.get("MAY")%></Excel:td>
			<Excel:td align="rihgt"><%=rec.get("JUN")%></Excel:td>
			<Excel:td align="rihgt"><%=rec.get("JUL")%></Excel:td>
			<Excel:td align="rihgt"><%=rec.get("AUG")%></Excel:td>
			<Excel:td align="rihgt"><%=rec.get("SEP")%></Excel:td>
			<Excel:td align="rihgt"><%=rec.get("OCT")%></Excel:td>
			<Excel:td align="rihgt"><%=rec.get("NOV")%></Excel:td>
			<Excel:td align="rihgt"><%=rec.get("DEC")%></Excel:td>
		</Excel:tr>
		<%
			}
		%>
		<Excel:tr>
			<Excel:td colspan="6" align="left">制表人：<%= username%></Excel:td>
			<Excel:td colspan="7" align="right">制表时间：<%= date2%></Excel:td>
		</Excel:tr>
	</Excel:table>
</Excel:tablelist>

