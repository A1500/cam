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
	String name="应急生活发放名册_"+date;
%>
<%
	String allocationType = (String)request.getParameter("allocationType");
%>
</head>
<Excel:tablelist filename="<%=name %>">
	<Excel:table sheetname="应急生活发放名册列表">
		<Excel:tr>
			<Excel:td colspan="7" align="center" ><Excel:font size="15">应急生活发放名册列表</Excel:font></Excel:td>
		</Excel:tr>
		<Excel:tr>
			<Excel:td colspan="7" align="left">统计单位：<%= BspUtil.getOrganName()%></Excel:td>
		</Excel:tr>
		<Excel:tr height="30" bgcolor="grey" border="1">
			<Excel:td  align="center" width="180" bordercolor="black">户主姓名</Excel:td>
			<Excel:td  align="center" width="100" bordercolor="black">身份证号</Excel:td>
			<Excel:td  align="center" width="100" bordercolor="black">行政村(社区)</Excel:td>
			<% 
				if("1".equals(allocationType)){
			%>
			<Excel:td  align="center" width="100" bordercolor="black">开户银行</Excel:td>
			<Excel:td  align="center" width="100" bordercolor="black">开户银行账号</Excel:td>
			<%
				}
			%>
			<Excel:td  align="center" width="100" bordercolor="black">核准救助金额(元)</Excel:td>
			<Excel:td  align="center" width="100" bordercolor="black">实际发放金额(元)</Excel:td>
		</Excel:tr>
		<%
			DataSet ds = (DataSet)request.getAttribute("dataset");
			for(int i=0; i<ds.getCount(); i++) {
				Record rec = ds.getRecord(i);
		
		%>
		<Excel:tr border="1">
			<Excel:td align="center"><%=rec.get("NAME")%></Excel:td>
			<Excel:td align="right"><%=rec.get("ID_CARD")%></Excel:td>
			<Excel:td align="right"><%=rec.get("ACCEPT_AREA_NAME")%></Excel:td>
			<% 
				if("1".equals(allocationType)){
			%>
			<Excel:td align="right"><%=rec.get("BANK")%></Excel:td>
			<Excel:td align="right"><%=rec.get("ACCOUNT_CODE") %></Excel:td>
			<%
				}
			%>
			<Excel:td align="right"><%=rec.get("APPROVAL_MONEY")%></Excel:td>
			<Excel:td align="right"><%=rec.get("AMOUNT")%></Excel:td>
		</Excel:tr>
		<%
			}
		%>
		<Excel:tr>
			<Excel:td colspan="4" align="left">制表人：<%= BspUtil.getOrganName()%></Excel:td>
			<Excel:td colspan="3" align="right">制表时间：<%= date%></Excel:td>
		</Excel:tr>
	</Excel:table>
</Excel:tablelist>

