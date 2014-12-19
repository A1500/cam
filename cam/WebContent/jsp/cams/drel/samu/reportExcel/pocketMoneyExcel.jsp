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
	String username = GetBspInfo.getBspInfo(request).getUserName();
	String statisticsTime=request.getParameter("statisticsTime");
	String name=statisticsTime+"供养五保对象零花钱发放情况统计表";
	out.clear();//清空缓存的内容
	out = pageContext.pushBody(); 
%>
</head>
<Excel:tablelist filename="<%=name %>">
	<Excel:table >
		<Excel:tr>
			<Excel:td colspan="4" align="center" ><Excel:font size="15"  bold="true"><%=name %></Excel:font></Excel:td>
		</Excel:tr>
		<Excel:tr>
			<Excel:td colspan="2" align="left">统计单位：<%= BspUtil.getOrganName()%></Excel:td>
			<Excel:td colspan="2" align="right">统计年度:<%=statisticsTime%></Excel:td>
		</Excel:tr>
		<Excel:tr height="30" bgcolor="grey" border="1">
			<Excel:td  align="center" width="100" rowspan="2" bordercolor="black">单位</Excel:td>
			<Excel:td  align="center" width="100" rowspan="2" bordercolor="black">总人数</Excel:td>
			<Excel:td  align="center" width="100" colspan="3" bordercolor="black">总金额</Excel:td>
			<Excel:td  align="center" width="100" colspan="3" bordercolor="black">月平均金额</Excel:td>			
		</Excel:tr>
		<%
			DataSet ds = (DataSet)request.getAttribute("dataset");
		
		%>
		<Excel:tr border="1">
			<Excel:td align="center">合计</Excel:td>
			<Excel:td align="right"><%=ds.sum("TOTAL_NUM")==null?"0":ds.sum("TOTAL_NUM")%></Excel:td>			
			<Excel:td align="right"><%=ds.sum("APPLY_MONEYNUM")==null?"0":ds.sum("APPLY_MONEYNUM")%></Excel:td>
			<Excel:td align="right"><%=ds.sum("AVERAGE_MONEY")==null?"0":ds.sum("AVERAGE_MONEY")%></Excel:td>			
		</Excel:tr>
		
		<%
				for(int i=0; i<ds.getCount(); i++) {
					Record rec = ds.getRecord(i);
		%>
		<Excel:tr border="1">
			<Excel:td align="center"><%=rec.get("NAME")%></Excel:td>
			<Excel:td align="right"><%=rec.get("TOTAL_NUM")==null?"0":rec.get("TOTAL_NUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("APPLY_MONEYNUM")==null?"0":rec.get("APPLY_MONEYNUM")%></Excel:td>			
			<Excel:td align="right"><%=rec.get("AVERAGE_MONEY")==null?"0":rec.get("AVERAGE_MONEY")%></Excel:td>
			</Excel:tr>
		<%
			}
		%>
		<Excel:tr>
			<Excel:td colspan="2" align="left">制表人：<%= username%></Excel:td>
			<Excel:td colspan="2" align="right">制表时间：<%= date2%></Excel:td>
		</Excel:tr>
	</Excel:table>
</Excel:tablelist>

