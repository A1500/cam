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
	String title="享受惠民政策分殡仪馆统计_"+date;
	//out.clear();//清空缓存的内容
	//out = pageContext.pushBody(); 
%>
<!--导出Excel-->
<Excel:tablelist filename="<%=title%>">
	<Excel:table sheetname="享受惠民政策分殡仪馆统计" border="1">
		<Excel:tr>
			<Excel:td colspan="17" align="center" border="0"><Excel:font size="15">享受惠民政策分殡仪馆统计</Excel:font></Excel:td>
		</Excel:tr>
		<Excel:tr border="0">
		<Excel:td  align="left" colspan="8" border="0">填报单位：<%=BspUtil.getOrganName()%></Excel:td>
		<Excel:td  align="right" colspan="9" border="0">填报时间：<%=request.getParameter("statisticsTime")%></Excel:td>
		</Excel:tr>
		<Excel:tr border="1" bgcolor="grey">
			<Excel:td  align="center" rowspan="3">地区</Excel:td>
			<Excel:td  align="center" rowspan="3">总数量</Excel:td>
			<Excel:td  align="center" rowspan="3">总金额</Excel:td>
			<Excel:td  align="center" colspan="14">享受惠民政策</Excel:td>
			
		</Excel:tr>
		<Excel:tr border="1" bgcolor="grey">
			<Excel:td  align="center" colspan="2">全民普惠</Excel:td>
			<Excel:td  align="center" colspan="2">城乡低保对象</Excel:td>
			<Excel:td  align="center" colspan="2">农村五保对象</Excel:td>
			<Excel:td  align="center" colspan="2">城市“三无”人员</Excel:td>
			<Excel:td  align="center" colspan="2">优抚对象</Excel:td>
			<Excel:td  align="center" colspan="2">因灾死亡人员</Excel:td>
			<Excel:td  align="center" colspan="2">无名尸</Excel:td>
			
		</Excel:tr>
		<Excel:tr border="1" bgcolor="grey">
			<Excel:td  align="center">数量</Excel:td>
			<Excel:td  align="center">金额</Excel:td>
			<Excel:td  align="center">数量</Excel:td>
			<Excel:td  align="center">金额</Excel:td>
			<Excel:td  align="center">数量</Excel:td>
			<Excel:td  align="center">金额</Excel:td>
			<Excel:td  align="center">数量</Excel:td>
			<Excel:td  align="center">金额</Excel:td>
			<Excel:td  align="center">数量</Excel:td>
			<Excel:td  align="center">金额</Excel:td>
			<Excel:td  align="center">数量</Excel:td>
			<Excel:td  align="center">金额</Excel:td>
			<Excel:td  align="center">数量</Excel:td>
			<Excel:td  align="center">金额</Excel:td>
			
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
			<Excel:td align="right"><%=rec.get("TOTALMONEY")%></Excel:td>
			
			<Excel:td align="right"><%=rec.get("PRE00")%></Excel:td>
			<Excel:td align="right"><%=rec.get("PRE00M")%></Excel:td>
			
			<Excel:td align="right"><%=rec.get("PREC1")%></Excel:td>
			<Excel:td align="right"><%=rec.get("PREC1M")%></Excel:td>
			
			<Excel:td align="right"><%=rec.get("PREC2")%></Excel:td>
			<Excel:td align="right"><%=rec.get("PREC2M")%></Excel:td>
			
			<Excel:td align="right"><%=rec.get("PREC3")%></Excel:td>
			<Excel:td align="right"><%=rec.get("PREC3M")%></Excel:td>
			
			<Excel:td align="right"><%=rec.get("PREC4")%></Excel:td>
			<Excel:td align="right"><%=rec.get("PREC4M")%></Excel:td>
			
			<Excel:td align="right"><%=rec.get("PRED2")%></Excel:td>
			<Excel:td align="right"><%=rec.get("PRED2M")%></Excel:td>
			
			<Excel:td align="right"><%=rec.get("PRED3")%></Excel:td>
			<Excel:td align="right"><%=rec.get("PRED3M")%></Excel:td>
		
		</Excel:tr>
		<%
					}
		%>	
		<Excel:tr border="0">
		<Excel:td  align="left" colspan="8" border="0">制表人：<%=BspUtil.getEmpOrgan().getShortName()%></Excel:td>
		<Excel:td  align="right" colspan="9" border="0">制表时间：<%=date %></Excel:td>
		</Excel:tr>
	</Excel:table>
</Excel:tablelist>