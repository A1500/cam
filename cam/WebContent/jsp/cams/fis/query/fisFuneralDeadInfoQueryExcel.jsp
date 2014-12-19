<%@page contentType="charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="/tags/next-excel" prefix="Excel"%>
<%@page import="org.loushang.next.data.DataSet"%>
<%@page import="org.loushang.next.data.Record"%>
<%@page import="org.loushang.next.data.FieldSet"%>
<%@page import="org.loushang.next.commons.nenum.EnumService" %>
<%@page import="org.loushang.sca.ScaComponentFactory" %>
<%@page import="java.math.BigDecimal" %>
<%@page import="java.text.DecimalFormat" %>

<%@page import="java.text.SimpleDateFormat"%>
<%@ page import="org.loushang.bsp.security.context.GetBspInfo"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<%@page import="java.util.*"%>
<%
	SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
	String date=sdf.format(new Date());
	String title="火化数据分殡仪馆统计_"+date;
	out.clear();//清空缓存的内容
	out = pageContext.pushBody(); 
%>
<!--导出Excel-->
<Excel:tablelist filename="<%=title%>">
	<Excel:table sheetname="火化数据分殡仪馆统计" border="1">
		<Excel:tr>
			<Excel:td colspan="4" align="center" border="0"><Excel:font size="15">火化数据分殡仪馆统计</Excel:font></Excel:td>
		</Excel:tr>
		<Excel:tr border="0">
		<Excel:td  align="left" colspan="2" border="0">统计单位：<%=BspUtil.getOrganName()%></Excel:td>
		<Excel:td  align="right" colspan="2" border="0">统计时间：<%=request.getParameter("statisticsTime")%></Excel:td>
		</Excel:tr>
		<Excel:tr  border="1" bgcolor="grey">
			<Excel:td  width="50" align="center">序号</Excel:td>
				<Excel:td  width="120" align="center">殡仪馆编号</Excel:td>
				<Excel:td  width="200" align="center">殡仪馆名称</Excel:td>
				<Excel:td  width="100" align="center">火化数(具)</Excel:td>
		</Excel:tr>
		<%
				DataSet dataset = (DataSet) request.getAttribute("dataset");
					EnumService enumService = ScaComponentFactory.getService(EnumService.class, "Enum/EnumService");
					for (int i = 0; i < dataset.getCount(); i++){
						Record rec = dataset.getRecord(i);
						
		%>
		<Excel:tr  border="1">
			<Excel:td align="center"><%=rec.get("ROWNUM")%></Excel:td>
			<Excel:td align="center"><%=rec.get("UNIT_ID")%></Excel:td>
			<Excel:td align="right"><%=rec.get("UNIT_NAME")%></Excel:td>
			<Excel:td align="right"><%=rec.get("NUM")%></Excel:td>
		</Excel:tr>
		<%
					}
		%>	
		<Excel:tr border="0">
		<Excel:td  align="left" colspan="2" border="0">制表人：<%=BspUtil.getEmpOrgan().getShortName()%></Excel:td>
		<Excel:td  align="right" colspan="2" border="0">制表时间：<%=date %></Excel:td>
		</Excel:tr>
	</Excel:table>
</Excel:tablelist>