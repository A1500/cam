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
	String name="结婚登记男女年龄差统计表_"+date;
	String username=GetBspInfo.getBspInfo(request).getUserName();
%>
</head>
<Excel:tablelist filename="<%=name %>">
	<Excel:table sheetname="结婚登记男女年龄差统计表">
		<Excel:tr>
			<Excel:td colspan="23" align="center" ><Excel:font size="15">结婚登记男女年龄差统计表</Excel:font></Excel:td>
		</Excel:tr>
		<Excel:tr>
			<Excel:td colspan="11" align="left">统计单位：<%= BspUtil.getOrganName()%></Excel:td>
			<Excel:td colspan="12" align="right">统计时间:<%=request.getParameter("statisticsTime")%></Excel:td>
		</Excel:tr>
		<Excel:tr height="30" bgcolor="grey" border="1">
			<Excel:td  align="center" width="100" rowspan="2" bordercolor="black">地区行政区划名称</Excel:td>
			<Excel:td  align="center" width="100" rowspan="2" bordercolor="black">性别</Excel:td>			
			<Excel:td  align="center" width="100" rowspan="2" bordercolor="black">合计</Excel:td>
			<Excel:td  align="center" width="100" colspan="2" bordercolor="black">0周岁</Excel:td>
			<Excel:td  align="center" width="100" colspan="2" bordercolor="black">1周岁</Excel:td>
			<Excel:td  align="center" width="100" colspan="2" bordercolor="black">2周岁</Excel:td>
			<Excel:td  align="center" width="100" colspan="2" bordercolor="black">3周岁</Excel:td>
			<Excel:td  align="center" width="100" colspan="2" bordercolor="black">4周岁</Excel:td>
			<Excel:td  align="center" width="100" colspan="2" bordercolor="black">5-9周岁</Excel:td>
			<Excel:td  align="center" width="100" colspan="2" bordercolor="black">10-14周岁</Excel:td>
			<Excel:td  align="center" width="100" colspan="2" bordercolor="black">15-19周岁</Excel:td>
			<Excel:td  align="center" width="100" colspan="2" bordercolor="black">20-29周岁</Excel:td>
			<Excel:td  align="center" width="100" colspan="2" bordercolor="black">30周岁以上</Excel:td>
		</Excel:tr>
		<Excel:tr height="20" bgcolor="grey" border="1">
			<Excel:td  align="center" bordercolor="black" >对数</Excel:td>
			<Excel:td  align="center" bordercolor="black" >％</Excel:td>			
			<Excel:td  align="center" bordercolor="black" >对数</Excel:td>
			<Excel:td  align="center" bordercolor="black" >％</Excel:td>	
			<Excel:td  align="center" bordercolor="black" >对数</Excel:td>
			<Excel:td  align="center" bordercolor="black" >％</Excel:td>	
			<Excel:td  align="center" bordercolor="black" >对数</Excel:td>
			<Excel:td  align="center" bordercolor="black" >％</Excel:td>	
			<Excel:td  align="center" bordercolor="black" >对数</Excel:td>
			<Excel:td  align="center" bordercolor="black" >％</Excel:td>	
			<Excel:td  align="center" bordercolor="black" >对数</Excel:td>
			<Excel:td  align="center" bordercolor="black" >％</Excel:td>	
			<Excel:td  align="center" bordercolor="black" >对数</Excel:td>
			<Excel:td  align="center" bordercolor="black" >％</Excel:td>	
			<Excel:td  align="center" bordercolor="black" >对数</Excel:td>
			<Excel:td  align="center" bordercolor="black" >％</Excel:td>	
			<Excel:td  align="center" bordercolor="black" >对数</Excel:td>
			<Excel:td  align="center" bordercolor="black" >％</Excel:td>	
			<Excel:td  align="center" bordercolor="black" >对数</Excel:td>
			<Excel:td  align="center" bordercolor="black" >％</Excel:td>	
		</Excel:tr>
		<%
			DataSet ds = (DataSet)request.getAttribute("dataset");
				for(int i=0; i<ds.getCount(); i++) {
					Record rec = ds.getRecord(i);
		%>
		<Excel:tr border="1">
			<Excel:td align="center"><%=rec.get("ITEM_NAME")%></Excel:td>
			<Excel:td align="center"><%=rec.get("SEX_NAME")%></Excel:td>
			<Excel:td align="right"><%=rec.get("TOTAL_NUM")%></Excel:td>			
			<Excel:td align="right"><%=rec.get("GAP0_NUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("GAP0_RATE")%></Excel:td>
			<Excel:td align="right"><%=rec.get("GAP1_NUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("GAP1_RATE")%></Excel:td>
			<Excel:td align="right"><%=rec.get("GAP2_NUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("GAP2_RATE")%></Excel:td>
			<Excel:td align="right"><%=rec.get("GAP3_NUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("GAP3_RATE")%></Excel:td>
			<Excel:td align="right"><%=rec.get("GAP4_NUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("GAP4_RATE")%></Excel:td>
			<Excel:td align="right"><%=rec.get("GAP5_9_NUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("GAP5_9_RATE")%></Excel:td>
			<Excel:td align="right"><%=rec.get("GAP10_14_NUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("GAP10_14_RATE")%></Excel:td>
			<Excel:td align="right"><%=rec.get("GAP15_19_NUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("GAP15_19_RATE")%></Excel:td>
			<Excel:td align="right"><%=rec.get("GAP20_29_NUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("GAP20_29_RATE")%></Excel:td>
			<Excel:td align="right"><%=rec.get("GAP30_NUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("GAP30_RATE")%></Excel:td>
			
		</Excel:tr>
		<%
			}
		%>
		<Excel:tr>
			<Excel:td colspan="11" align="left">制表人：<%= username%></Excel:td>
			<Excel:td colspan="12" align="right">制表时间：<%= date2%></Excel:td>
		</Excel:tr>
	</Excel:table>
</Excel:tablelist>

