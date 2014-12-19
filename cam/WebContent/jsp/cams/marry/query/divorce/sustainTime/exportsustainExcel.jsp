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
	String name="婚姻维系时间统计表_"+date;
	String username=GetBspInfo.getBspInfo(request).getUserName();
%>
</head>
<Excel:tablelist filename="<%=name %>">
	<Excel:table sheetname="婚姻维系时间统计表">
		<Excel:tr>
			<Excel:td colspan="20" align="center" ><Excel:font size="15">婚姻维系时间统计表</Excel:font></Excel:td>
		</Excel:tr>
		<Excel:tr>
			<Excel:td colspan="10" align="left">统计单位：<%= BspUtil.getOrganName()%></Excel:td>
			<Excel:td colspan="10" align="right">统计时间:<%=request.getParameter("statisticsTime")%></Excel:td>
		</Excel:tr>
		<Excel:tr height="30" bgcolor="grey" border="1">
			<Excel:td  align="center" width="100" rowspan="2" bordercolor="black">地区行政区划名称</Excel:td>
			<Excel:td  align="center" width="100" rowspan="2" bordercolor="black">合计</Excel:td>			
			<Excel:td  align="center" width="50" colspan="2" bordercolor="black">1年和1年以内</Excel:td>
			<Excel:td  align="center" width="50" colspan="2" bordercolor="black">2-3年</Excel:td>
			<Excel:td  align="center" width="50" colspan="2" bordercolor="black">4-5年</Excel:td>
			<Excel:td  align="center" width="50" colspan="2" bordercolor="black">6-9年</Excel:td>
			<Excel:td  align="center" width="50" colspan="2" bordercolor="black">10-15年</Excel:td>
			<Excel:td  align="center" width="50" colspan="2" bordercolor="black">16-25年</Excel:td>
			<Excel:td  align="center" width="50" colspan="2" bordercolor="black">26-35年</Excel:td>
			<Excel:td  align="center" width="50" colspan="2" bordercolor="black">36-50年</Excel:td>
			<Excel:td  align="center" width="50" colspan="2" bordercolor="black">50年以上</Excel:td>
		</Excel:tr>
		<Excel:tr height="20" bgcolor="grey" border="1">
			<Excel:td  align="center" bordercolor="black" >人数</Excel:td>
			<Excel:td  align="center" bordercolor="black" >％</Excel:td>			
			<Excel:td  align="center" bordercolor="black" >人数</Excel:td>
			<Excel:td  align="center" bordercolor="black" >％</Excel:td>
			<Excel:td  align="center" bordercolor="black" >人数</Excel:td>
			<Excel:td  align="center" bordercolor="black" >％</Excel:td>
			<Excel:td  align="center" bordercolor="black" >人数</Excel:td>
			<Excel:td  align="center" bordercolor="black" >％</Excel:td>
			<Excel:td  align="center" bordercolor="black" >人数</Excel:td>
			<Excel:td  align="center" bordercolor="black" >％</Excel:td>
			<Excel:td  align="center" bordercolor="black" >人数</Excel:td>
			<Excel:td  align="center" bordercolor="black" >％</Excel:td>
			<Excel:td  align="center" bordercolor="black" >人数</Excel:td>
			<Excel:td  align="center" bordercolor="black" >％</Excel:td>
			<Excel:td  align="center" bordercolor="black" >人数</Excel:td>
			<Excel:td  align="center" bordercolor="black" >％</Excel:td>
			<Excel:td  align="center" bordercolor="black" >人数</Excel:td>
			<Excel:td  align="center" bordercolor="black" >％</Excel:td>
		</Excel:tr>
		<%
			DataSet ds = (DataSet)request.getAttribute("dataset");
				for(int i=0; i<ds.getCount(); i++) {
					Record rec = ds.getRecord(i);
		%>
		<Excel:tr border="1">
			<Excel:td align="center"><%=rec.get("ITEM_NAME")%></Excel:td>
			<Excel:td align="right"><%=rec.get("TOTAL_NUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("YEAR1_NUM")%></Excel:td>			
			<Excel:td align="right"><%=rec.get("YEAR1_RATE")%></Excel:td>
			<Excel:td align="right"><%=rec.get("YEAR2_3_NUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("YEAR2_3_RATE")%></Excel:td>
			<Excel:td align="right"><%=rec.get("YEAR4_5_NUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("YEAR4_5_RATE")%></Excel:td>
			<Excel:td align="right"><%=rec.get("YEAR6_9_NUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("YEAR6_9_RATE")%></Excel:td>
			<Excel:td align="right"><%=rec.get("YEAR10_15_NUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("YEAR10_15_RATE")%></Excel:td>
			<Excel:td align="right"><%=rec.get("YEAR16_25_NUM")%></Excel:td>			
			<Excel:td align="right"><%=rec.get("YEAR16_25_RATE")%></Excel:td>
			<Excel:td align="right"><%=rec.get("YEAR26_35_NUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("YEAR26_35_RATE")%></Excel:td>
			<Excel:td align="right"><%=rec.get("YEAR36_50_NUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("YEAR36_50_RATE")%></Excel:td>
			<Excel:td align="right"><%=rec.get("YEAR50_NUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("YEAR50_RATE")%></Excel:td>
		</Excel:tr>
		<%
			}
		%>
		<Excel:tr>
			<Excel:td colspan="10" align="left">制表人：<%= username%></Excel:td>
			<Excel:td colspan="10" align="right">制表时间：<%= date2%></Excel:td>
		</Excel:tr>
	</Excel:table>
</Excel:tablelist>

