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
	String statisticsTime=request.getParameter("statisticsTime");
	String name=statisticsTime+"敬老院基本情况统计表（二）";
	String username = GetBspInfo.getBspInfo(request).getUserName();
	out.clear();//清空缓存的内容
	out = pageContext.pushBody(); 
%>
</head>
<Excel:tablelist filename="<%=name %>">
	<Excel:table sheetname="敬老院基本情况统计表（二）">
		<Excel:tr>
			<Excel:td colspan="8" align="center" ><Excel:font size="15"  bold="true"><%=name %></Excel:font></Excel:td>
		</Excel:tr>
		<Excel:tr>
			<Excel:td colspan="4" align="left">统计单位：<%= BspUtil.getOrganName()%></Excel:td>
			<Excel:td colspan="4" align="right">统计时间:<%=statisticsTime%></Excel:td>
		</Excel:tr>
		<Excel:tr height="30" bgcolor="grey" border="1">
			<Excel:td  align="center" width="100"  bordercolor="black">单位</Excel:td>
			<Excel:td  align="center" width="100"  bordercolor="black">总数</Excel:td>			
			<Excel:td  align="center" width="100"  bordercolor="black">固定资产（万元）</Excel:td>
			<Excel:td  align="center" width="100"  bordercolor="black">管理工作经费（万元）</Excel:td>
			<Excel:td  align="center" width="100"  bordercolor="black">年副业收入（万元）</Excel:td>
			<Excel:td  align="center" width="100"  bordercolor="black">年均供养标准（元）</Excel:td>
			<Excel:td  align="center" width="100"  bordercolor="black">蔬菜种植面积（亩）</Excel:td>
			<Excel:td  align="center" width="100"  bordercolor="black">蔬菜产量（吨）</Excel:td>
		</Excel:tr>
		<%
			DataSet ds = (DataSet)request.getAttribute("dataset");
		
		%>
		<Excel:tr border="1">
			<Excel:td align="center">合计</Excel:td>
			<Excel:td align="right"><%=ds.sum("NUM_SUM")==null?"0":ds.sum("NUM_SUM")%></Excel:td>			
			<Excel:td align="right"><%=ds.sum("FIXED_ASSETS_SUM")==null?"0":ds.sum("FIXED_ASSETS_SUM")%></Excel:td>
			<Excel:td align="right"><%=ds.sum("MANAGEMENT_FUNDS_SUM")==null?"0":ds.sum("MANAGEMENT_FUNDS_SUM")%></Excel:td>
			<Excel:td align="right"><%=ds.sum("YEAR_SIDELINE_SUM")==null?"0":ds.sum("YEAR_SIDELINE_SUM")%></Excel:td>
			<Excel:td align="right"><%=ds.sum("SUPPORT_STANDARD_SUM")==null?"0":ds.sum("SUPPORT_STANDARD_SUM")%></Excel:td>
			<Excel:td align="right"><%=ds.sum("VEGETABLES_AREA_SUM")==null?"0":ds.sum("VEGETABLES_AREA_SUM")%></Excel:td>
			<Excel:td align="right"><%=ds.sum("VEGETABLES_YIELD_SUM")==null?"0":ds.sum("VEGETABLES_YIELD_SUM")%></Excel:td>				
		</Excel:tr>
		
		<%
				for(int i=0; i<ds.getCount(); i++) {
					Record rec = ds.getRecord(i);
		%>
		<Excel:tr border="1">
			<Excel:td align="center"><%=rec.get("NAME")%></Excel:td>
			<Excel:td align="right"><%=rec.get("NUM_SUM")==null?"0":rec.get("NUM_SUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("FIXED_ASSETS_SUM")==null?"0":rec.get("FIXED_ASSETS_SUM")%></Excel:td>			
			<Excel:td align="right"><%=rec.get("MANAGEMENT_FUNDS_SUM")==null?"0":rec.get("MANAGEMENT_FUNDS_SUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("YEAR_SIDELINE_SUM")==null?"0":rec.get("YEAR_SIDELINE_SUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("SUPPORT_STANDARD_SUM")==null?"0":rec.get("SUPPORT_STANDARD_SUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("VEGETABLES_AREA_SUM")==null?"0":rec.get("VEGETABLES_AREA_SUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("VEGETABLES_YIELD_SUM")==null?"0":rec.get("VEGETABLES_YIELD_SUM")%></Excel:td>
		</Excel:tr>
		<%
			}
		%>
		<Excel:tr>
			<Excel:td colspan="4" align="left">制表人：<%= username%></Excel:td>
			<Excel:td colspan="4" align="right">制表时间：<%= date2%></Excel:td>
		</Excel:tr>
	</Excel:table>
</Excel:tablelist>

