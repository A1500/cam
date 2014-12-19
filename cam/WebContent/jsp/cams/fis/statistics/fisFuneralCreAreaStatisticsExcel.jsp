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
	String title="火化量分地区统计表_"+date;
	//out.clear();//清空缓存的内容
	//out = pageContext.pushBody(); 
%>
<!--导出Excel-->
<Excel:tablelist filename="<%=title%>">
	<Excel:table sheetname="火化量分地区统计表" border="1">
		<Excel:tr>
			<Excel:td colspan="18" align="center" border="0"><Excel:font size="15">火化量分地区统计表</Excel:font></Excel:td>
		</Excel:tr>
		<Excel:tr border="0">
		<Excel:td  align="left" colspan="9" border="0">填报单位：<%=BspUtil.getOrganName()%></Excel:td>
		<Excel:td  align="right" colspan="9" border="0">填报时间：<%=request.getParameter("statisticsTime")%></Excel:td>
		</Excel:tr>
		<Excel:tr border="1" bgcolor="grey">
			<Excel:td  align="center" rowspan="3">地区</Excel:td>
			<Excel:td  align="center" colspan="2" rowspan="2">总数</Excel:td>
			<Excel:td  align="center" rowspan="3">火化率(%)</Excel:td>
			<Excel:td  align="center" colspan="14">年龄段</Excel:td>
		</Excel:tr>
		<Excel:tr border="1" bgcolor="grey">
			<Excel:td  align="center" colspan="2">0-35岁</Excel:td>
			<Excel:td  align="center" colspan="2">36-49岁</Excel:td>
			<Excel:td  align="center" colspan="2">50-59岁</Excel:td>
			<Excel:td  align="center" colspan="2">60-69岁</Excel:td>
			<Excel:td  align="center" colspan="2">70-79岁</Excel:td>
			<Excel:td  align="center" colspan="2">80-89岁</Excel:td>
			<Excel:td  align="center" colspan="2">90岁以上</Excel:td>
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
			<Excel:td align="right"><%=rec.get("TOTALNUMW")%></Excel:td>
			<Excel:td align="right"><%=rec.get("CRE5")%></Excel:td>
			<Excel:td align="right"><%=rec.get("NUM36")%></Excel:td>
			<Excel:td align="right"><%=rec.get("NUM36W")%></Excel:td>
			<Excel:td align="right"><%=rec.get("NUM50")%></Excel:td>
			<Excel:td align="right"><%=rec.get("NUM50W")%></Excel:td>
			<Excel:td align="right"><%=rec.get("NUM60")%></Excel:td>
			<Excel:td align="right"><%=rec.get("NUM60W")%></Excel:td>
			<Excel:td align="right"><%=rec.get("NUM70")%></Excel:td>
			<Excel:td align="right"><%=rec.get("NUM70W")%></Excel:td>
			<Excel:td align="right"><%=rec.get("NUM80")%></Excel:td>
			<Excel:td align="right"><%=rec.get("NUM80W")%></Excel:td>
			<Excel:td align="right"><%=rec.get("NUM90")%></Excel:td>
			<Excel:td align="right"><%=rec.get("NUM90W")%></Excel:td>
			<Excel:td align="right"><%=rec.get("NUM100")%></Excel:td>
			<Excel:td align="right"><%=rec.get("NUM100W")%></Excel:td>
		</Excel:tr>
		<%
					}
		%>	
		<Excel:tr border="0">
		<Excel:td  align="left" colspan="9" border="0">制表人：<%=BspUtil.getEmpOrgan().getShortName()%></Excel:td>
		<Excel:td  align="right" colspan="9" border="0">制表时间：<%=date %></Excel:td>
		</Excel:tr>
	</Excel:table>
</Excel:tablelist>