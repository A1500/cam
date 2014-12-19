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
	String title="殡仪馆服务情况统计_"+date;
	//out.clear();//清空缓存的内容
	//out = pageContext.pushBody(); 
%>
<!--导出Excel-->
<Excel:tablelist filename="<%=title%>">
	<Excel:table sheetname="殡仪馆服务情况统计" border="1">
		<Excel:tr>
			<Excel:td colspan="9" align="center" border="0"><Excel:font size="15">殡仪馆服务情况统计</Excel:font></Excel:td>
		</Excel:tr>
		<Excel:tr border="0">
		<Excel:td  align="left" colspan="4" border="0">填报单位：<%=BspUtil.getOrganName()%></Excel:td>
		<Excel:td  align="right" colspan="5" border="0">填报时间：<%=request.getParameter("statisticsTime")%></Excel:td>
		</Excel:tr>
		<Excel:tr border="1" bgcolor="grey">
			<Excel:td  align="center" rowspan="2">单位</Excel:td>
			<Excel:td  align="center" colspan="8">服务项目</Excel:td>
			
		</Excel:tr>
		<Excel:tr border="1" bgcolor="grey">
			<Excel:td  align="center">火化</Excel:td>
			<Excel:td  align="center">运尸</Excel:td>
			<Excel:td  align="center">冷藏</Excel:td>
			<Excel:td  align="center">告别</Excel:td>
			<Excel:td  align="center">整容</Excel:td>
			<Excel:td  align="center">寄存</Excel:td>
			<Excel:td  align="center">售骨灰盒</Excel:td>
			<Excel:td  align="center">国际运尸</Excel:td>
			
		</Excel:tr>
		<%
				DataSet dataset = (DataSet) request.getAttribute("dataset");
					EnumService enumService = ScaComponentFactory.getService(EnumService.class, "Enum/EnumService");
					for (int i = 0; i < dataset.getCount(); i++){
						Record rec = dataset.getRecord(i);
						
		%>
		<Excel:tr  border="1">
			<Excel:td align="center"><%=rec.get("NAME")%></Excel:td>
			
			<Excel:td align="right"><%=rec.get("CRE")%></Excel:td>
			<Excel:td align="right"><%=rec.get("CAR")%></Excel:td>
			
			<Excel:td align="right"><%=rec.get("STO")%></Excel:td>
			<Excel:td align="right"><%=rec.get("FARE")%></Excel:td>
			
			<Excel:td align="right"><%=rec.get("COS")%></Excel:td>
			<Excel:td align="right"><%=rec.get("EMP")%></Excel:td>
			
			<Excel:td align="right"><%=rec.get("CAS")%></Excel:td>
			<Excel:td align="right"><%=rec.get("NAT")%></Excel:td>
		
		</Excel:tr>
		<%
					}
		%>	
		<Excel:tr border="0">
		<Excel:td  align="left" colspan="4" border="0">制表人：<%=BspUtil.getEmpOrgan().getShortName()%></Excel:td>
		<Excel:td  align="right" colspan="5" border="0">制表时间：<%=date %></Excel:td>
		</Excel:tr>
	</Excel:table>
</Excel:tablelist>