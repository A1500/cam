<%@ page contentType="charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ taglib uri="/tags/next-excel" prefix="Excel"%>
<%@page import="org.loushang.next.data.DataSet"%>
<%@page import="org.loushang.next.data.Record"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<%@page import="java.util.Date" %>
<%@ page import="org.loushang.bsp.security.context.GetBspInfo"%>
<%!
	SimpleDateFormat sdf=new SimpleDateFormat("yyyy年MM月dd日");
	String date=sdf.format(new Date());
	String username = GetBspInfo.getBspInfo().getUserName();
%>
<%
	String title = (String) request.getParameter("title");
	String statisticsTime = (String) request.getParameter("statisticsTime");
	String fileName = title+date;
%>
<head>
	<title>导出Excel</title>
	<next:ScriptManager/>
</head>
<!--导出Excel-->
<Excel:tablelist filename="<%= fileName%>">
	<Excel:table sheetname="<%= title%>" border="1">
		<Excel:tr>
			<Excel:td colspan="6" align="center" border="0"><Excel:font size="15"><%= title%></Excel:font></Excel:td>
		</Excel:tr>
		<Excel:tr border="0">
		<Excel:td  align="left" colspan="2" border="0">统计单位：<%=BspUtil.getOrganName()%></Excel:td>
		<Excel:td  align="right" colspan="4" border="0">统计时间：<%=statisticsTime%></Excel:td>
		</Excel:tr>
		<Excel:tr border="1" bgcolor="grey">
			<Excel:td  align="center" width="100">地区</Excel:td>
			<Excel:td  align="center" width="100">总计</Excel:td>
			<Excel:td  align="center" width="100">退伍义务兵</Excel:td>
			<Excel:td  align="center" width="100">转业士官</Excel:td>
			<Excel:td  align="center" width="100">复员士官</Excel:td>
			<Excel:td  align="center" width="100">伤病残士兵</Excel:td>
		</Excel:tr>
		
		<%
				DataSet soldiersdataset=(DataSet)request.getAttribute("dataset");
				for(int i=0;i<soldiersdataset.getCount();i++){
					Record record=soldiersdataset.getRecord(i);
				%>	
		<Excel:tr  border="1">
			<Excel:td align="center"width="100"><%=record.get("ORGAN_NAME")%></Excel:td>
			<Excel:td align="right"width="100"><%=record.get("totalCount")%></Excel:td>
			<Excel:td align="right"width="100"><%=record.get("retiredSoldiers")%></Excel:td>
			<Excel:td align="right"width="100"><%=record.get("transferredOfficer")%></Excel:td>
			<Excel:td align="right"width="100"><%=record.get("demobilizedOfficer")%></Excel:td>
			<Excel:td align="right"width="100"><%=record.get("disabilitySoldiers")%></Excel:td>
			
		</Excel:tr>
		<%
					}
		%>	
		<Excel:tr border="0">
		<Excel:td  align="left" colspan="3" border="0">制表人：<%=username %></Excel:td>
		<Excel:td  align="right" colspan="3" border="0">制表时间：<%=date %></Excel:td>
		</Excel:tr>
	</Excel:table>
</Excel:tablelist>