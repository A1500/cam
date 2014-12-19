<%@ page contentType="charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/tags/next-excel" prefix="Excel"%>
<%@page import="org.loushang.next.data.DataSet"%>
<%@page import="org.loushang.next.data.Record"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<%@ page import="org.loushang.bsp.security.context.GetBspInfo"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.*"%>
<head>
<title>导出Excel</title>
<%
	SimpleDateFormat sdf=new SimpleDateFormat("yyyy年MM月dd日HH时mm分");
	SimpleDateFormat sdf2=new SimpleDateFormat("yyyy年MM月dd日");
	String date=sdf.format(new Date());
	String date2=sdf2.format(new Date());
	String name="结婚登记婚姻状况统计表（初婚、再婚、复婚）_"+date;
	String username=GetBspInfo.getBspInfo(request).getUserName();
%>
</head>
<Excel:tablelist filename="<%=name %>">
	<Excel:table sheetname="结婚登记婚姻状况统计表（初婚、再婚、复婚）">
		<Excel:tr>
			<Excel:td colspan="12" align="center" ><Excel:font size="15">结婚登记婚姻状况统计表（初婚、再婚、复婚）</Excel:font></Excel:td>
		</Excel:tr>
		<Excel:tr>
			<Excel:td colspan="6" align="left">统计单位：<%= BspUtil.getOrganName()%></Excel:td>
			<Excel:td colspan="6" align="right">统计时间:<%=request.getParameter("statisticsTime")%></Excel:td>
		</Excel:tr>
		<Excel:tr height="30" bgcolor="grey" border="1">
			<Excel:td  align="center" width="100" rowspan="2" bordercolor="black">地区行政区划名称</Excel:td>
			<Excel:td  align="center" width="100" rowspan="2" bordercolor="black">登记总对数</Excel:td>			
			<Excel:td  align="center" width="100" colspan="4" bordercolor="black">初婚人数</Excel:td>
			<Excel:td  align="center" width="100" colspan="4" bordercolor="black">再婚人数</Excel:td>
			<Excel:td  align="center" width="100" colspan="2" bordercolor="black">再婚中复婚人数</Excel:td>
		</Excel:tr>
		<Excel:tr height="20" bgcolor="grey" border="1">
			<Excel:td  align="center" bordercolor="black" >合计</Excel:td>
			<Excel:td  align="center" bordercolor="black" >占登记％</Excel:td>			
			<Excel:td  align="center" bordercolor="black" >男</Excel:td>
			<Excel:td  align="center" bordercolor="black" >女</Excel:td>
			<Excel:td  align="center" bordercolor="black" >合计</Excel:td>
			<Excel:td  align="center" bordercolor="black" >占登记％</Excel:td>
			<Excel:td  align="center" bordercolor="black" >男</Excel:td>
			<Excel:td  align="center" bordercolor="black" >女</Excel:td>
			<Excel:td  align="center" bordercolor="black" >数量</Excel:td>
			<Excel:td  align="center" bordercolor="black" >占再婚的%</Excel:td>
		</Excel:tr>
		<%
			DataSet ds = (DataSet)request.getAttribute("dataset");
				for(int i=0; i<ds.getCount(); i++) {
					Record rec = ds.getRecord(i);
		%>
		<Excel:tr border="1">
			<Excel:td align="center"><%=rec.get("ITEM_NAME")%></Excel:td>
			<Excel:td align="right"><%=rec.get("MARRY_NUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("NEW_MARRY_NUM")%></Excel:td>			
			<Excel:td align="right"><%=rec.get("NEW_MARRY_RATE")%></Excel:td>
			<Excel:td align="right"><%=rec.get("NEW_MARRY_MAN_NUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("NEW_MARRY_WOMAN_NUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("REMARRY_NUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("REMARRY_RATE")%></Excel:td>
			<Excel:td align="right"><%=rec.get("REMARRY_MAN_NUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("REMARRY_WOMAN_NUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("RENEW_NUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("RENEW_RATE")%></Excel:td>
		</Excel:tr>
		<%
			}
		%>
		<Excel:tr>
			<Excel:td colspan="6" align="left">制表人：<%= username%></Excel:td>
			<Excel:td colspan="6" align="right">制表时间：<%= date2%></Excel:td>
		</Excel:tr>
	</Excel:table>
</Excel:tablelist>

