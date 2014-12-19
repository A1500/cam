<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="/tags/next-excel" prefix="Excel"%>
<%@page import="org.loushang.next.data.DataSet"%>
<%@page import="org.loushang.next.data.Record"%>
<%@page import="java.text.SimpleDateFormat"%>
<Excel:tablelist filename='<%=request.getParameter("title")+"报表"%>'>
	<Excel:table>
	<%--标题栏 --%>
		<Excel:tr>
			<Excel:td colspan="3" align="center"><%=request.getParameter("title")+"报表"%></Excel:td>
		</Excel:tr>
		<%
			SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
			String title=request.getParameter("title");
			String field=request.getParameter("field");
		%>
	<%--时间栏 --%>
		<Excel:tr>
			<Excel:td colspan='3' align="left">日期：<%=sdf.format(new java.util.Date())%></Excel:td>
		</Excel:tr>
	<%--列标题 --%>
		<Excel:tr bgcolor="grey">
			<Excel:td  align="center" width="300">登记证号</Excel:td>
			<Excel:td  align="center" width="400">社会组织名称</Excel:td>
			<Excel:td  align="center" width="300"><%=title%></Excel:td>
		</Excel:tr>
	<%--数据区 --%>
		<%
			DataSet dataset=(DataSet)request.getAttribute("dataset");
			for(int i=0;i<dataset.getCount();i++){
				Record record=dataset.getRecord(i);
		%>
		<Excel:tr>
			<Excel:td  align="center"><%=record.get("SORG_CODE")%></Excel:td>
			<Excel:td  align="center"><%=record.get("CN_NAME")%></Excel:td>
			<Excel:td  align="center"><%=record.get(field)%></Excel:td>
		</Excel:tr>
		<%
			}
		%>
	</Excel:table>
</Excel:tablelist>