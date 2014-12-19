<%@ page contentType="charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/tags/next-excel" prefix="Excel"%>
<%@page import="org.loushang.next.data.DataSet"%>
<%@page import="org.loushang.next.data.Record"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<%@page import="org.loushang.next.commons.nenum.EnumService" %>
<%@page import="org.loushang.sca.ScaComponentFactory" %>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.*"%>
<head>
<title>导出Excel</title>
<%!
	SimpleDateFormat sdf=new SimpleDateFormat("yyyy年MM月dd日HH时mm分");
	String date=sdf.format(new Date());
	String name="物资发放名册_"+date;
%>
<%
	String str = (String)request.getParameter("str");
	String[] text = str.split(",");
%>
</head>
<Excel:tablelist filename="<%=name %>">
	<Excel:table sheetname="物资发放名册列表">
		<Excel:tr>
			<Excel:td colspan="<%=text.length + 5 %>" align="center" ><Excel:font size="15">物资发放名册列表</Excel:font></Excel:td>
		</Excel:tr>
		<Excel:tr>
			<Excel:td colspan="<%=text.length + 5 %>" align="left">统计单位：<%= BspUtil.getOrganName()%></Excel:td>
		</Excel:tr>
		<Excel:tr height="30" bgcolor="grey" border="1">
			<Excel:td  align="center" width="180" bordercolor="black">户主姓名</Excel:td>
			<Excel:td  align="center" width="100" bordercolor="black">身份证号</Excel:td>
			<Excel:td  align="center" width="100" bordercolor="black">行政村(社区)</Excel:td>
			<Excel:td  align="center" width="100" bordercolor="black">核准口粮救助(公斤)</Excel:td>
			<Excel:td  align="center" width="100" bordercolor="black">核准衣被救助(件)</Excel:td>
			<%
				for(int i=0;i<text.length;i++){
					String s = text[i];
				
			%>
			<Excel:td  align="center" width="100" bordercolor="black"><%=s %></Excel:td>
			<%
				}
			%>
		</Excel:tr>
		<%
			DataSet ds = (DataSet)request.getAttribute("dataset");
			for(int j=0; j<ds.getCount(); j++) {
				Record rec = ds.getRecord(j);
		
		%>
		<Excel:tr border="1">
			<Excel:td align="center"><%=rec.get("NAME")%></Excel:td>
			<Excel:td align="right"><%=rec.get("ID_CARD")%></Excel:td>
			<Excel:td align="right"><%=rec.get("ACCEPT_AREA_NAME")%></Excel:td>
			<Excel:td align="right"><%=rec.get("APPROVAL_FOOD")%></Excel:td>
			<Excel:td align="right"><%=rec.get("APPROVAL_CLOTHES")%></Excel:td>
			<%
				for(int k=1;k<=text.length;k++){
					
			%>
			<Excel:td align="right"><%=rec.get("'"+k+"'")%></Excel:td>
			<%
				}
			%>
		</Excel:tr>
		<%
			}
		%>
		<Excel:tr>
			<Excel:td colspan="5" align="left">制表人：<%= BspUtil.getOrganName()%></Excel:td>
			<Excel:td colspan="<%=text.length %>" align="right">制表时间：<%= date%></Excel:td>
		</Excel:tr>
	</Excel:table>
</Excel:tablelist>

