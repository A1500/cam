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
	String title="死亡原因分殡仪馆统计_"+date;
	//out.clear();//清空缓存的内容
	//out = pageContext.pushBody(); 
%>
<!--导出Excel-->
<Excel:tablelist filename="<%=title%>">
	<Excel:table sheetname="死亡原因分殡仪馆统计" border="1">
		<Excel:tr>
			<Excel:td colspan="24" align="center" border="0"><Excel:font size="15">死亡原因分殡仪馆统计</Excel:font></Excel:td>
		</Excel:tr>
		<Excel:tr border="0">
		<Excel:td  align="left" colspan="12" border="0">填报单位：<%=BspUtil.getOrganName()%></Excel:td>
		<Excel:td  align="right" colspan="12" border="0">填报时间：<%=request.getParameter("statisticsTime")%></Excel:td>
		</Excel:tr>
		<Excel:tr border="1" bgcolor="grey">
			<Excel:td  align="center" rowspan="3">地区</Excel:td>
			<Excel:td  align="center" colspan="3" rowspan="2">总数</Excel:td>
			<Excel:td  align="center" colspan="20">死亡原因</Excel:td>
			
		</Excel:tr>
		<Excel:tr border="1" bgcolor="grey">
			<Excel:td  align="center" colspan="2">死亡原因</Excel:td>
			<Excel:td  align="center" colspan="2">病故</Excel:td>
			<Excel:td  align="center" colspan="2">事故</Excel:td>
			<Excel:td  align="center" colspan="2">车祸</Excel:td>
			<Excel:td  align="center" colspan="2">他杀</Excel:td>
			<Excel:td  align="center" colspan="2">自杀</Excel:td>
			<Excel:td  align="center" colspan="2">溺水</Excel:td>
			<Excel:td  align="center" colspan="2">中毒</Excel:td>
			<Excel:td  align="center" colspan="2">自然灾害</Excel:td>
			<Excel:td  align="center" colspan="2">其他</Excel:td>
			
		</Excel:tr>
		<Excel:tr border="1" bgcolor="grey">
			<Excel:td  align="center"></Excel:td>
			<Excel:td  align="center">男</Excel:td>
			<Excel:td  align="center">女</Excel:td>
			<Excel:td  align="center"></Excel:td>
			<Excel:td  align="center">女</Excel:td>
			<Excel:td  align="center"></Excel:td>
			<Excel:td  align="center">女</Excel:td>
			<Excel:td  align="center"></Excel:td>
			<Excel:td  align="center">女</Excel:td>
			<Excel:td  align="center"></Excel:td>
			<Excel:td  align="center">女</Excel:td>
			<Excel:td  align="center"></Excel:td>
			<Excel:td  align="center">女</Excel:td>
			<Excel:td  align="center"></Excel:td>
			<Excel:td  align="center">女</Excel:td>
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
			<Excel:td align="right"><%=rec.get("TOTALNUMM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("TOTALNUMW")%></Excel:td>
			<Excel:td align="right"><%=rec.get("NUM01")%></Excel:td>
			<Excel:td align="right"><%=rec.get("NUM01W")%></Excel:td>
			<Excel:td align="right"><%=rec.get("NUM02")%></Excel:td>
			<Excel:td align="right"><%=rec.get("NUM02W")%></Excel:td>
			<Excel:td align="right"><%=rec.get("NUM03")%></Excel:td>
			<Excel:td align="right"><%=rec.get("NUM03W")%></Excel:td>
			<Excel:td align="right"><%=rec.get("NUM04")%></Excel:td>
			<Excel:td align="right"><%=rec.get("NUM04W")%></Excel:td>
			<Excel:td align="right"><%=rec.get("NUM05")%></Excel:td>
			<Excel:td align="right"><%=rec.get("NUM05W")%></Excel:td>
			<Excel:td align="right"><%=rec.get("NUM06")%></Excel:td>
			<Excel:td align="right"><%=rec.get("NUM06W")%></Excel:td>
			<Excel:td align="right"><%=rec.get("NUM07")%></Excel:td>
			<Excel:td align="right"><%=rec.get("NUM07W")%></Excel:td>
			<Excel:td align="right"><%=rec.get("NUM08")%></Excel:td>
			<Excel:td align="right"><%=rec.get("NUM08W")%></Excel:td>
			<Excel:td align="right"><%=rec.get("NUM09")%></Excel:td>
			<Excel:td align="right"><%=rec.get("NUM09W")%></Excel:td>
			<Excel:td align="right"><%=rec.get("NUM10")%></Excel:td>
			<Excel:td align="right"><%=rec.get("NUM10W")%></Excel:td>
			
		</Excel:tr>
		<%
					}
		%>	
		<Excel:tr border="0">
		<Excel:td  align="left" colspan="12" border="0">制表人：<%=BspUtil.getEmpOrgan().getShortName()%></Excel:td>
		<Excel:td  align="right" colspan="12" border="0">制表时间：<%=date %></Excel:td>
		</Excel:tr>
	</Excel:table>
</Excel:tablelist>