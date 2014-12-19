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
	String title="殡仪馆火化量分地区统计_"+date;
	//out.clear();//清空缓存的内容
	//out = pageContext.pushBody(); 
%>
<!--导出Excel-->
<Excel:tablelist filename="<%=title%>">
	<Excel:table sheetname="殡仪馆火化量分地区统计" border="1">
		<Excel:tr>
			<Excel:td colspan="10" align="center" border="0"><Excel:font size="15">殡仪馆火化量分地区统计</Excel:font></Excel:td>
		</Excel:tr>
		<Excel:tr border="0">
		<Excel:td  align="left" colspan="5" border="0">填报单位：<%=BspUtil.getOrganName()%></Excel:td>
		<Excel:td  align="right" colspan="5" border="0">填报时间：<%=request.getParameter("statisticsTime")%></Excel:td>
		</Excel:tr>
		<Excel:tr border="1" bgcolor="grey">
			<Excel:td  align="center" rowspan="3">单位</Excel:td>
			<Excel:td  align="center" rowspan="3">总数</Excel:td>
			<Excel:td  align="center" colspan="2">本地区</Excel:td>
			<Excel:td  align="center" colspan="2">省内其他地区</Excel:td>
			<Excel:td  align="center" colspan="2">外省（市）</Excel:td>
			<Excel:td  align="center" colspan="2">境外</Excel:td>
		</Excel:tr>
		<Excel:tr border="1" bgcolor="grey">
			<Excel:td  align="center" colspan="2">火化数</Excel:td>
			<Excel:td  align="center" colspan="2">火化数</Excel:td>
			<Excel:td  align="center" colspan="2">火化数</Excel:td>
			<Excel:td  align="center" colspan="2">火化数</Excel:td>
			
		</Excel:tr>
		<Excel:tr border="1" bgcolor="grey">
			<Excel:td  align="center"></Excel:td>
			<Excel:td  align="center">女</Excel:td>
			<Excel:td  align="center"></Excel:td>
			<Excel:td  align="center">女</Excel:td>
			<Excel:td  align="center"></Excel:td>
			<Excel:td  align="center">女</Excel:td>
			<Excel:td  align="center"></Excel:td>
			<Excel:td  align="center">女</Excel:td>
			
		</Excel:tr>
		<%
				DataSet dataset = (DataSet) request.getAttribute("dataset");
					EnumService enumService = ScaComponentFactory.getService(EnumService.class, "Enum/EnumService");
					for (int i = 0; i < dataset.getCount(); i++){
						Record rec = dataset.getRecord(i);
						
		%>
		<Excel:tr  border="1">
			<Excel:td align="center"><%=rec.get("NAME")%></Excel:td>
			<Excel:td align="right"><%=rec.get("TOTALNUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("QN")%></Excel:td>
			<Excel:td align="right"><%=rec.get("QNW")%></Excel:td>
			<Excel:td align="right"><%=rec.get("SN")%></Excel:td>
			<Excel:td align="right"><%=rec.get("SNW")%></Excel:td>
			<Excel:td align="right"><%=rec.get("WS")%></Excel:td>
			<Excel:td align="right"><%=rec.get("WSW")%></Excel:td>
			<Excel:td align="right"><%=rec.get("JW")%></Excel:td>
			<Excel:td align="right"><%=rec.get("JWW")%></Excel:td>
			
		</Excel:tr>
		<%
					}
		%>	
		<Excel:tr border="0">
		<Excel:td  align="left" colspan="5" border="0">制表人：<%=BspUtil.getEmpOrgan().getShortName()%></Excel:td>
		<Excel:td  align="right" colspan="5" border="0">制表时间：<%=date %></Excel:td>
		</Excel:tr>
	</Excel:table>
</Excel:tablelist>