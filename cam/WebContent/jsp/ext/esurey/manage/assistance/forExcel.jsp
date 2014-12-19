<%@ page contentType="charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ taglib uri="/tags/next-excel" prefix="excel"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="org.loushang.next.data.*"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.*"%>
<head>
<title>导出Excel</title>
<%
	SimpleDateFormat sdf=new SimpleDateFormat("yyyy年MM月dd日HH时mm分");
	String date=sdf.format(new Date());
	String name="房管局核对信息_"+date;
%>
</head>
<html>
	<head>
		<title>导出Excel</title>
		<next:ScriptManager/>
	</head>
<excel:tablelist filename="<%=name %>">
	<excel:table sheetname="详细信息">
		<excel:tr bgcolor="grey">
			
			<excel:td  align="center">姓名</excel:td>
			<excel:td  align="center">身份证号码</excel:td>
			<excel:td  align="center">核对单位名称</excel:td>
			<excel:td  align="center">核对日期</excel:td>
			<excel:td  align="center">状态</excel:td>
			
		</excel:tr>
		<%
			DataSet dataset=(DataSet)request.getAttribute("dataset");
			for(int i=0;i<dataset.getCount();i++){
				Record record=dataset.getRecord(i);
		%>
		<excel:tr>
			
			<excel:td><%=record.get("name")%></excel:td>
			<excel:td><%=record.get("idCard")%></excel:td>
			<excel:td><%=record.get("checkOrg")%></excel:td>
			<excel:td><%=record.get("checkTime")%></excel:td>
			<excel:td><%=record.get("checkFlg")%></excel:td>
 			
		</excel:tr>
		<%
			}
		%>
	</excel:table>
</excel:tablelist>

</html>