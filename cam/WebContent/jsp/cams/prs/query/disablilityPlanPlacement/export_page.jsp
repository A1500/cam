<%@ page contentType="charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ taglib uri="/tags/next-excel" prefix="Excel"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<%@page import="org.loushang.next.data.DataSet"%>
<%@page import="org.loushang.next.data.Record"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page import="org.loushang.bsp.security.context.GetBspInfo"%>
<%@page import="java.util.Date" %>
<%
	SimpleDateFormat sdf=new SimpleDateFormat("yyyy年MM月dd日");
	String date=sdf.format(new Date());	
	String username= GetBspInfo.getBspInfo(request).getUserName();
%>
<%
	String title = (String) request.getParameter("title");
	String statisticsTime = (String) request.getParameter("statisticsTime");
	String fileName = title+date;
%>
<Excel:tablelist filename="<%= fileName%>">
	<Excel:table sheetname="<%= title%>" border="1">
		<Excel:tr>
			<Excel:td align="center" colspan="9" border="0"><%= title%></Excel:td>
		</Excel:tr>
		<Excel:tr >
			<Excel:td  align="left" colspan="4" border="0">统计单位：<%=BspUtil.getOrganName()%></Excel:td>
			<Excel:td  align="right" colspan="5" border="0">统计时间：<%= statisticsTime%></Excel:td>
		</Excel:tr>
		<Excel:tr bgcolor="grey" border="1">
			<Excel:td  align="center" rowspan="2" colspan="3">单位</Excel:td>
			<Excel:td  align="center" colspan="6">计划内伤病残士兵接收安置情况统计表</Excel:td>
		</Excel:tr>
		<Excel:tr bgcolor="grey" border="1">
			<Excel:td  align="center" colspan="3">已接收</Excel:td>
			<Excel:td  align="center" colspan="3">未接收</Excel:td>
		</Excel:tr>
		<%
		DataSet dataset=(DataSet)request.getAttribute("dataset");
			for(int i=0;i<dataset.getCount();i++){
				Record record=dataset.getRecord(i);			
		%>
		<Excel:tr border="1">
		    <Excel:td  align="center" colspan="3"><%=record.get("ORGAN_NAME")==null?"":record.get("ORGAN_NAME")%></Excel:td>
            <Excel:td  align="center" colspan="3"><%=record.get("PLACEMENTED")==null?"":record.get("PLACEMENTED")%></Excel:td>
            <Excel:td  align="center" colspan="3"><%=record.get("UNPLACEMENTED")==null?"":record.get("UNPLACEMENTED")%></Excel:td>
		</Excel:tr>
		<%
			}
		%>
	
		<Excel:tr>
			<Excel:td colspan="5" border="0" align="left">制表人：<%=username %></Excel:td>
			<Excel:td colspan="4" border="0" align="right">制表时间：<%=date %></Excel:td>
		</Excel:tr>
	</Excel:table>
</Excel:tablelist>
