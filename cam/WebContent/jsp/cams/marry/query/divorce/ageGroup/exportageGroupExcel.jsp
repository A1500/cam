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
	String name="离婚登记分年龄统计表_"+date;
	String username=GetBspInfo.getBspInfo(request).getUserName();
%>
</head>
<Excel:tablelist filename="<%=name %>">
	<Excel:table sheetname="离婚登记分年龄统计表">
		<Excel:tr>
			<Excel:td colspan="25" align="center" ><Excel:font size="15">离婚登记分年龄统计表</Excel:font></Excel:td>
		</Excel:tr>
		<Excel:tr>
			<Excel:td colspan="13" align="left">统计单位：<%= BspUtil.getOrganName()%></Excel:td>
			<Excel:td colspan="12" align="right">统计时间:<%=request.getParameter("statisticsTime")%></Excel:td>
		</Excel:tr>
		<Excel:tr height="30" bgcolor="grey" border="1">
			<Excel:td  align="center" width="100" rowspan="2" bordercolor="black">地区行政区划名称</Excel:td>
			<Excel:td  align="center" width="100" rowspan="2" bordercolor="black">性别</Excel:td>			
			<Excel:td  align="center" width="100" rowspan="2" bordercolor="black">合计</Excel:td>
			<Excel:td  align="center" width="100" colspan="2" bordercolor="black">20周岁</Excel:td>
			<Excel:td  align="center" width="100" colspan="2" bordercolor="black">21周岁</Excel:td>
			<Excel:td  align="center" width="100" colspan="2" bordercolor="black">22周岁</Excel:td>
			<Excel:td  align="center" width="100" colspan="2" bordercolor="black">23周岁</Excel:td>
			<Excel:td  align="center" width="100" colspan="2" bordercolor="black">24周岁</Excel:td>
			<Excel:td  align="center" width="100" colspan="2" bordercolor="black">25-29周岁</Excel:td>
			<Excel:td  align="center" width="100" colspan="2" bordercolor="black">30-34周岁</Excel:td>
			<Excel:td  align="center" width="100" colspan="2" bordercolor="black">35-39周岁</Excel:td>
			<Excel:td  align="center" width="100" colspan="2" bordercolor="black">40-49周岁</Excel:td>
			<Excel:td  align="center" width="100" colspan="2" bordercolor="black">50-59周岁</Excel:td>
			<Excel:td  align="center" width="100" colspan="2" bordercolor="black">60周岁以上</Excel:td>
		</Excel:tr>
		<Excel:tr height="20" bgcolor="grey" border="1">
			<Excel:td  align="center" bordercolor="black" >人数</Excel:td>
			<Excel:td  align="center" bordercolor="black" >％</Excel:td>			
			<Excel:td  align="center" bordercolor="black" >人数</Excel:td>
			<Excel:td  align="center" bordercolor="black" >％</Excel:td>	
			<Excel:td  align="center" bordercolor="black" >人数</Excel:td>
			<Excel:td  align="center" bordercolor="black" >％</Excel:td>	
			<Excel:td  align="center" bordercolor="black" >人数</Excel:td>
			<Excel:td  align="center" bordercolor="black" >％</Excel:td>	
			<Excel:td  align="center" bordercolor="black" >人数</Excel:td>
			<Excel:td  align="center" bordercolor="black" >％</Excel:td>	
			<Excel:td  align="center" bordercolor="black" >人数</Excel:td>
			<Excel:td  align="center" bordercolor="black" >％</Excel:td>	
			<Excel:td  align="center" bordercolor="black" >人数</Excel:td>
			<Excel:td  align="center" bordercolor="black" >％</Excel:td>	
			<Excel:td  align="center" bordercolor="black" >人数</Excel:td>
			<Excel:td  align="center" bordercolor="black" >％</Excel:td>	
			<Excel:td  align="center" bordercolor="black" >人数</Excel:td>
			<Excel:td  align="center" bordercolor="black" >％</Excel:td>	
			<Excel:td  align="center" bordercolor="black" >人数</Excel:td>
			<Excel:td  align="center" bordercolor="black" >％</Excel:td>	
			<Excel:td  align="center" bordercolor="black" >人数</Excel:td>
			<Excel:td  align="center" bordercolor="black" >％</Excel:td>	
		</Excel:tr>
		<%
			DataSet ds = (DataSet)request.getAttribute("dataset");
				for(int i=0; i<ds.getCount(); i++) {
					Record rec = ds.getRecord(i);
		%>
		<Excel:tr border="1">
			<Excel:td align="center"><%=rec.get("ITEM_NAME")%></Excel:td>
			<Excel:td align="right"><%=rec.get("SEX_NAME")%></Excel:td>
			<Excel:td align="right"><%=rec.get("TOTAL_NUM")%></Excel:td>			
			<Excel:td align="right"><%=rec.get("AGE20_NUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("AGE20_RATE")%></Excel:td>
			<Excel:td align="right"><%=rec.get("AGE21_NUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("AGE21_RATE")%></Excel:td>
			<Excel:td align="right"><%=rec.get("AGE22_NUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("AGE22_RATE")%></Excel:td>
			<Excel:td align="right"><%=rec.get("AGE23_NUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("AGE23_RATE")%></Excel:td>
			<Excel:td align="right"><%=rec.get("AGE24_NUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("AGE24_RATE")%></Excel:td>
			<Excel:td align="right"><%=rec.get("AGE25_29_NUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("AGE25_29_RATE")%></Excel:td>
			<Excel:td align="right"><%=rec.get("AGE30_34_NUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("AGE30_34_RATE")%></Excel:td>
			<Excel:td align="right"><%=rec.get("AGE35_39_NUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("AGE35_39_RATE")%></Excel:td>
			<Excel:td align="right"><%=rec.get("AGE40_49_NUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("AGE40_49_RATE")%></Excel:td>
			<Excel:td align="right"><%=rec.get("AGE50_59_NUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("AGE50_59_RATE")%></Excel:td>
			<Excel:td align="right"><%=rec.get("AGE60_NUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("AGE60_RATE")%></Excel:td>
			
		</Excel:tr>
		<%
			}
		%>
		<Excel:tr>
			<Excel:td colspan="13" align="left">制表人：<%= username%></Excel:td>
			<Excel:td colspan="12" align="right">制表时间：<%= date2%></Excel:td>
		</Excel:tr>
	</Excel:table>
</Excel:tablelist>

