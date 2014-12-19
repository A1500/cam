<%@ page contentType="charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ taglib uri="/tags/next-excel" prefix="Excel"%>
<%@ page import="org.loushang.bsp.security.context.GetBspInfo"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<%@page import="org.loushang.next.data.DataSet"%>
<%@page import="org.loushang.next.data.Record"%>
<%@page import="java.text.SimpleDateFormat"%>
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
			<Excel:td  align="left" colspan="5" border="0">统计单位：<%=BspUtil.getOrganName()%></Excel:td>
			<Excel:td  align="right" colspan="4" border="0">统计时间：<%=statisticsTime%></Excel:td>
		</Excel:tr>
		<Excel:tr bgcolor="grey" border="1">
			<Excel:td  align="center" rowspan="3">单位</Excel:td>
			<Excel:td  align="center" colspan="8">伤残退役士兵</Excel:td>
		</Excel:tr>
		<Excel:tr bgcolor="grey" border="1">
			<Excel:td  align="center" colspan="2">五级</Excel:td>
			<Excel:td  align="center" colspan="2">六级</Excel:td>
			<Excel:td  align="center" colspan="2">七级</Excel:td>
			<Excel:td  align="center" colspan="2">八级</Excel:td>
		</Excel:tr>
		<Excel:tr bgcolor="grey" border="1">
			<Excel:td align="center">因战</Excel:td>
			<Excel:td align="center">因公</Excel:td>
			<Excel:td align="center">因战</Excel:td>
			<Excel:td align="center">因公</Excel:td>
			<Excel:td align="center">因战</Excel:td>
			<Excel:td align="center">因公</Excel:td>
			<Excel:td align="center">因战</Excel:td>
			<Excel:td align="center">因公</Excel:td>		
		</Excel:tr>
		<%
		DataSet dataset=(DataSet)request.getAttribute("dataset");
			for(int i=0;i<dataset.getCount();i++){
				Record record=dataset.getRecord(i);			
		%>
		<Excel:tr border="1">
            <Excel:td  align="center" ><%=record.get("ORGAN_NAME")==null?"":record.get("ORGAN_NAME")%></Excel:td>
            <Excel:td  align="center" ><%=record.get("YZ_5")==null?"":record.get("YZ_5")%></Excel:td>
            <Excel:td  align="center" ><%=record.get("YG_5")==null?"":record.get("YG_5")%></Excel:td>
            <Excel:td  align="center" ><%=record.get("YZ_6")==null?"":record.get("YZ_6")%></Excel:td>
            <Excel:td  align="center" ><%=record.get("YG_6")==null?"":record.get("YG_6")%></Excel:td>
            <Excel:td  align="center" ><%=record.get("YZ_7")==null?"":record.get("YZ_7")%></Excel:td>
            <Excel:td  align="center" ><%=record.get("YG_7")==null?"":record.get("YG_7")%></Excel:td>
            <Excel:td  align="center" ><%=record.get("YZ_8")==null?"":record.get("YZ_8")%></Excel:td>       
            <Excel:td  align="center" ><%=record.get("YG_8")==null?"":record.get("YG_8")%></Excel:td>
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
