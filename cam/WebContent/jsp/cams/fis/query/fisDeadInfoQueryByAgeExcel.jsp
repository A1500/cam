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
	String title = "火化数据分年龄段统计_"+date;
	out.clear();//清空缓存的内容
	out = pageContext.pushBody(); 
%>


<!--导出Excel-->
<Excel:tablelist filename="<%=title%>">
	<Excel:table sheetname="火化数据分年龄段统计" border="1">
		<Excel:tr>
			<Excel:td colspan="7" align="center" ><Excel:font size="15">火化数据分年龄段统计</Excel:font></Excel:td>
		</Excel:tr>
		<Excel:tr border="0">
		<Excel:td  align="left" colspan="3" border="0">统计单位：<%=BspUtil.getOrganName()%></Excel:td>
		<Excel:td  align="right" colspan="4" border="0">统计时间：<%=request.getParameter("statisticsTime")%></Excel:td>
		</Excel:tr>
		<Excel:tr  bgcolor="grey">
			<Excel:td  align="center" width="100">区间</Excel:td>
			<Excel:td  align="center" width="100">0-49岁</Excel:td>
			<Excel:td  align="center" width="100">50-59岁</Excel:td>
			<Excel:td  align="center" width="100">60-69岁</Excel:td>
			<Excel:td  align="center" width="100">70-79岁</Excel:td>
			<Excel:td  align="center" width="100">80-89岁</Excel:td>
			<Excel:td  align="center" width="100">90岁以上</Excel:td>
		</Excel:tr>
		<%
			DataSet dataset = (DataSet) request.getAttribute("dataset");
			EnumService enumService = ScaComponentFactory.getService(EnumService.class, "Enum/EnumService");
			for (int i = 0; i < dataset.getCount(); i++) {
				Record rec = dataset.getRecord(i);
		%>
		<Excel:tr border="1">
			<Excel:td align="center">数量</Excel:td>
			<Excel:td align="right"><%=rec.get("ONE_NUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("TWO_NUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("THREE_NUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("FOUR_NUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("FIVE_NUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("SIX_NUM")%></Excel:td>
		</Excel:tr>
		<%
			}
		%>
		<Excel:tr border="0">
		<Excel:td  align="left" colspan="3" border="0">制表人：<%=BspUtil.getEmpOrgan().getShortName()%></Excel:td>
		<Excel:td  align="right" colspan="4" border="0">制表时间：<%=date %></Excel:td>
		</Excel:tr>
	</Excel:table>
</Excel:tablelist>

