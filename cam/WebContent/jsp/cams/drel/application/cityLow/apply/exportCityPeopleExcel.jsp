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
	
	String beginDate= request.getParameter("beginDate");
	String endDate= request.getParameter("endDate");
	String name1="城市低收入家庭统计表";
	
	String name = beginDate+"至"+endDate+name1+"_"+date;
	String username = GetBspInfo.getBspInfo(request).getUserName();
	out.clear();//清空缓存的内容
	out = pageContext.pushBody(); 
%>
</head>
<Excel:tablelist filename="<%=name %>">
	<Excel:table sheetname="<%=name1 %>">
		<Excel:tr>
			<Excel:td colspan="4" align="center" ><Excel:font size="15"  bold="true"><%=beginDate+"至"+endDate+name1 %></Excel:font></Excel:td>
		</Excel:tr>
		<Excel:tr>
			
			<Excel:td colspan="2" align="left">统计单位：<%= BspUtil.getOrganName()%></Excel:td>
			<Excel:td colspan="2" align="right">统计时间:<%= beginDate+"至"+endDate%></Excel:td>
			
		</Excel:tr>
		<Excel:tr height="30" bgcolor="grey" border="1">
			<Excel:td  align="center" width="150"  bordercolor="black">行政区划</Excel:td>
			<Excel:td  align="center" width="150"  bordercolor="black">户数</Excel:td>
			<Excel:td  align="center" width="150"  bordercolor="black">平均家庭收入</Excel:td>
			<Excel:td  align="center" width="150"  bordercolor="black">平均家庭资产</Excel:td>
		</Excel:tr>
		
		<%
			DataSet ds = (DataSet)request.getAttribute("dataset");
		
		%>
				
		<%
				for(int i=0; i<ds.getCount(); i++) {
					Record rec = ds.getRecord(i);
		%>
		<Excel:tr border="1">
			<Excel:td align="center"><%=rec.get("NAME")%></Excel:td>
			<Excel:td align="right"><%=rec.get("NUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("TOTALINC")%></Excel:td>
			<Excel:td align="right"><%=rec.get("TOTALPRO")%></Excel:td>			
			
		</Excel:tr>
		<%
			}
		%>
		<Excel:tr>
			
			<Excel:td colspan="2" align="left">制表人：<%= username%></Excel:td>
			<Excel:td colspan="2" align="right">制表时间：<%= date2%></Excel:td>
			
		</Excel:tr>
	</Excel:table>
</Excel:tablelist>

