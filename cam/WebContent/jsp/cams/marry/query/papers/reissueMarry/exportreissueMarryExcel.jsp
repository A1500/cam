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
	String name="补发结婚证情况统计表_"+date;
	String username=GetBspInfo.getBspInfo(request).getUserName();
%>
</head>
<Excel:tablelist filename="<%=name %>">
	<Excel:table sheetname="补发结婚证情况统计表">
		<Excel:tr>
			<Excel:td colspan="9" align="center" ><Excel:font size="15">补发结婚证情况统计表</Excel:font></Excel:td>
		</Excel:tr>
		<Excel:tr>
			<Excel:td colspan="4" align="left">统计单位：<%= BspUtil.getOrganName()%></Excel:td>
			<Excel:td colspan="5" align="right">统计时间:<%=request.getParameter("statisticsTime")%></Excel:td>
		</Excel:tr>
		<Excel:tr height="30" bgcolor="grey" border="1">
			<Excel:td  align="center" width="100" rowspan="2" bordercolor="black">地区行政区划名称</Excel:td>
			<Excel:td  align="center" width="120" colspan="2" bordercolor="black">补发结婚证总数</Excel:td>			
			<Excel:td  align="center" width="120" colspan="3" bordercolor="black">本地补发</Excel:td>
			<Excel:td  align="center" width="120" colspan="3" bordercolor="black">异地补发</Excel:td>
		</Excel:tr>
		<Excel:tr height="20" bgcolor="grey" border="1">
			<Excel:td  align="center" bordercolor="black" >总数</Excel:td>
			<Excel:td  align="center" bordercolor="black" width="100">其中委托补发</Excel:td>	
			<Excel:td  align="center" bordercolor="black" >数量</Excel:td>	
			<Excel:td  align="center" bordercolor="black" >占总数％</Excel:td>	
			<Excel:td  align="center" bordercolor="black" width="100">其中委托补发</Excel:td>	
			<Excel:td  align="center" bordercolor="black" >数量</Excel:td>	
			<Excel:td  align="center" bordercolor="black" >占总数％</Excel:td>	
			<Excel:td  align="center" bordercolor="black" width="100">其中委托补发</Excel:td>			
		</Excel:tr>
		<%
			DataSet ds = (DataSet)request.getAttribute("dataset");
				for(int i=0; i<ds.getCount(); i++) {
					Record rec = ds.getRecord(i);
		%>
		<Excel:tr border="1">
			<Excel:td align="center"><%=rec.get("ITEM_NAME")%></Excel:td>
			<Excel:td align="right"><%=rec.get("TOTAL_NUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("TOTAL_ENTRUST_NUM")%></Excel:td>			
			<Excel:td align="right"><%=rec.get("LOCAL_NUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("LOCAL_NUM_RATE")%></Excel:td>
			<Excel:td align="right"><%=rec.get("LOCAL_ENTRUST_NUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("ALLOPATRY_NUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("ALLOPATRY_NUM_RATE")%></Excel:td>			
			<Excel:td align="right"><%=rec.get("ALLOPATRY_ENTRUST_NUM")%></Excel:td>
		</Excel:tr>
		<%
			}
		%>
		<Excel:tr>
			<Excel:td colspan="4" align="left">制表人：<%= username%></Excel:td>
			<Excel:td colspan="5" align="right">制表时间：<%= date2%></Excel:td>
		</Excel:tr>
	</Excel:table>
</Excel:tablelist>

