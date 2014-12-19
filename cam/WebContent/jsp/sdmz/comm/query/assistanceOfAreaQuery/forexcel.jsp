<%@ page contentType="charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/tags/next-excel" prefix="Excel"%>
<%@page import="org.loushang.next.data.DataSet"%>
<%@page import="org.loushang.next.data.Record"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.*"%>
<head>
<title>导出Excel</title>
<next:ScriptManager/>
<%
	SimpleDateFormat sdf=new SimpleDateFormat("yyyy年MM月dd日HH时mm分");
	String date=sdf.format(new Date());
	String name="全区救助_"+date;
%>
</head>
<Excel:tablelist filename="<%=name%>">
	<Excel:table sheetname="全区救助">
		<Excel:tr>
			<Excel:td colspan="7" align="center" ><Excel:font size="15">全区救助</Excel:font></Excel:td>
		</Excel:tr>
		<Excel:tr height="50" >
			<Excel:td  align="center" width="100">救助部门</Excel:td>
			<Excel:td  align="center" width="100">救助次数</Excel:td>
			<Excel:td  align="center" width="100">救助户数</Excel:td>
			<Excel:td  align="center" width="100">救助人数</Excel:td>
			<Excel:td  align="center" width="100">资金投入（元）</Excel:td>
		</Excel:tr>
		<%
	
			DataSet jzfamxDataset = (DataSet)request.getAttribute("dataset");
		
			for(int i=0; i<jzfamxDataset.getCount(); i++) {
				Record rec = jzfamxDataset.getRecord(i);
		%>
		<Excel:tr>
			<Excel:td><%=rec.get("PLAN_ORGAN_NAME")%></Excel:td>
			<Excel:td><%=rec.get("NUM")%></Excel:td>
			<Excel:td><%=rec.get("FAMILY_NUM")%></Excel:td>
			<Excel:td><%=rec.get("PEOPLE_NUM")%></Excel:td>
			<Excel:td><%=rec.get("FUND")%></Excel:td>
		</Excel:tr>
		<%
			}
		%>
	</Excel:table>
</Excel:tablelist>

