<%@ page contentType="charset=UTF-8"%>
<%@ taglib uri="/tags/next-excel" prefix="Excel"%>
<%@page import="org.loushang.next.data.DataSet"%>
<%@page import="org.loushang.next.data.Record"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%
	String queryCondition = request.getParameter("queryCondition");
	SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
	String date = sdf.format(new java.util.Date());
	String title = "殡仪馆上报情况查询导出_"+date;
	out.clear();//清空缓存的内容
	out = pageContext.pushBody(); 
%>
<%@page import="com.inspur.cams.fis.util.FisIdHelp"%>
<%@page import="com.inspur.cams.fis.util.BspUtil"%>
<Excel:tablelist filename="<%=title%>" >
	<Excel:table sheetname="殡仪馆上报情况查询报表">
		<Excel:tr>
			<Excel:td colspan="3" align="center"><Excel:font size="16"><%=queryCondition %>殡仪馆上报情况报表</Excel:font></Excel:td>
		</Excel:tr>
		<Excel:tr bgcolor="grey"  border="1">
			<Excel:td align="center" width="250" ><Excel:font size="13">殡仪馆名称</Excel:font></Excel:td>
			<Excel:td align="center" width="150" ><Excel:font size="13">最后上报时间</Excel:font></Excel:td>
			<Excel:td align="center" width="150" ><Excel:font size="13">间隔天数</Excel:font></Excel:td>
		</Excel:tr>
		<%
			DataSet dataset=(DataSet)request.getAttribute("dataset");
			for(int i=0;i<dataset.getCount();i++){
				Record record=dataset.getRecord(i);	
		%>
		<Excel:tr border="1">
			<Excel:td align="center"><Excel:font size="11"><%=record.get("UNIT_NAME")%></Excel:font></Excel:td>
			<Excel:td align="center"><Excel:font size="11"><%=record.get("END_TIME")%></Excel:font></Excel:td>
			<Excel:td align="center"><Excel:font size="11"><%=record.get("DAY_DIFF")%></Excel:font></Excel:td>
		</Excel:tr>
		<%
			}
		%>
		<Excel:tr border="0">
			<Excel:td  align="left" colspan="2" border="0">制表人：<%=BspUtil.getEmpOrgan().getOrganName()%></Excel:td>
			<Excel:td  align="right" colspan="1" border="0">制表时间：<%=date%></Excel:td>
		</Excel:tr>
	</Excel:table>
</Excel:tablelist>