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
<!--导出Excel-->
<Excel:tablelist filename="<%=fileName %>">
	<Excel:table sheetname="<%= title%>" border="1">
		<Excel:tr>
			<Excel:td colspan="9" align="center" border="0"><Excel:font size="15"><%= request.getParameter("title")%></Excel:font></Excel:td>
		</Excel:tr>
		<Excel:tr border="0">
		<Excel:td  align="left" colspan="3" border="0">统计单位：<%=BspUtil.getOrganName()%></Excel:td>
		<Excel:td  align="right" colspan="6" border="0">统计时间：<%= statisticsTime%></Excel:td>
		</Excel:tr>
		<Excel:tr border="1" bgcolor="grey">
			<Excel:td  align="center" rowspan="3">地区</Excel:td>
			<Excel:td  align="center" rowspan="3">总计</Excel:td>
			<Excel:td  align="center"  rowspan="3">未安置</Excel:td>
			<Excel:td  align="center" colspan="6">安置</Excel:td>
		</Excel:tr>
		<Excel:tr border="1" bgcolor="grey">
			<Excel:td  align="center" rowspan="2">合计</Excel:td>
			<Excel:td  align="center" rowspan="2">自主就业</Excel:td>
			<Excel:td  align="center" colspan="4">政府指导</Excel:td>
		</Excel:tr>
		<Excel:tr border="1" bgcolor="grey">
			<Excel:td  align="center">复工复学</Excel:td>
			<Excel:td  align="center">政府安置</Excel:td>
			<Excel:td  align="center">自谋职业</Excel:td>
			<Excel:td  align="center">自找单位</Excel:td>
			
		</Excel:tr>
		<%
				DataSet soldiersdataset=(DataSet)request.getAttribute("dataset");
				for(int i=0;i<soldiersdataset.getCount();i++){
					Record record=soldiersdataset.getRecord(i);
				%>	
		<Excel:tr  border="1">
			<Excel:td align="center"><%=record.get("ORGAN_NAME")%></Excel:td>
			<Excel:td align="right"><%=record.get("TOTALCOUNT")%></Excel:td>
			<Excel:td align="right"><%=record.get("UNPLACED")%></Excel:td>
			<Excel:td align="right"><%=record.get("TOTAL_PLACED")%></Excel:td>
			<Excel:td align="right"><%=record.get("SELF_EMPLOYMENT")%></Excel:td>
			<Excel:td align="right"><%=record.get("FUXUEFUGONG")%></Excel:td>
			<Excel:td align="right"><%=record.get("PLACEMENT_GOV")%></Excel:td>
			<Excel:td align="right"><%=record.get("EMPLOYED")%></Excel:td>
			<Excel:td align="right"><%=record.get("SELF_EMPLOYED")%></Excel:td>
		</Excel:tr>
		<%
					}
		%>	
		<Excel:tr border="0">
		<Excel:td  align="left" colspan="4" border="0">制表人：<%=username %></Excel:td>
		<Excel:td  align="right" colspan="5" border="0">制表时间：<%=date %></Excel:td>
		</Excel:tr>
	</Excel:table>
</Excel:tablelist>