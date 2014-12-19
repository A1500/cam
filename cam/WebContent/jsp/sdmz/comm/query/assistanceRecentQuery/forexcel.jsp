<%@ page contentType="charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/tags/next-excel" prefix="Excel"%>
<%@page import="org.loushang.next.data.DataSet"%>
<%@page import="org.loushang.next.data.Record"%>
<%!public static final int PAGE_COUNT=15; %>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.*"%>
<head>
<title>导出Excel</title>
<%
	SimpleDateFormat sdf=new SimpleDateFormat("yyyy年MM月dd日HH时mm分");
	String date=sdf.format(new Date());
	String name="救助方案_"+date;
%>
</head>
<%
	//String size = request.getParameter("pageSize");
	//int pageSize = Integer.parseInt(size);
	String index = request.getParameter("pageIndex");
	
	
	int pageIndex = Integer.parseInt(index);
	//String cursor = request.getParameter("startCursor");
	//int startCursor = Integer.parseInt(cursor);
%>
<Excel:tablelist filename="<%=name%>">
	<Excel:table sheetname="救助方案">
		<Excel:tr>
			<Excel:td colspan="7" align="center" ><Excel:font size="<%=PAGE_COUNT %>">救助方案</Excel:font></Excel:td>
		</Excel:tr>
		<Excel:tr height="50" >
			<Excel:td  align="center" width="100">救助活动</Excel:td>
			<Excel:td  align="center" width="100">救助项目</Excel:td>
			<Excel:td  align="center" width="100">救助单位</Excel:td>
			<Excel:td  align="center" width="100">开始时间</Excel:td>
			<Excel:td  align="center" width="100">结束时间</Excel:td>
			<Excel:td  align="center" width="100">救助户数</Excel:td>
			<Excel:td  align="center" width="100">救助人数</Excel:td>
			<Excel:td  align="center" width="100">资金投入（元）</Excel:td>
			<Excel:td  align="center" width="100">实施状态标志</Excel:td>
		</Excel:tr>
		<%
			DataSet jzfamxDataset = (DataSet)request.getAttribute("dataset");
		int count=jzfamxDataset.getCount()-PAGE_COUNT*(pageIndex-1);
		 if(count>=PAGE_COUNT){
			 count=PAGE_COUNT;
		 }else {
			 count=jzfamxDataset.getCount()-PAGE_COUNT*(pageIndex-1);
		 }
			for(int i=(pageIndex-1)*PAGE_COUNT; i<(pageIndex-1)*PAGE_COUNT+count; i++) {
				Record rec = jzfamxDataset.getRecord(i);
		%>
		<Excel:tr>
			<Excel:td><%=rec.get("planName")%></Excel:td>
			<Excel:td><%=rec.get("planType")%></Excel:td>
			<Excel:td><%=rec.get("planOrgName")%></Excel:td>
			<Excel:td><%=rec.get("planBegin")%></Excel:td>
			<Excel:td><%=rec.get("planEnd")%></Excel:td>
			<Excel:td><%=rec.get("familyNum")%></Excel:td>
			<Excel:td><%=rec.get("peopleNum")%></Excel:td>
			<Excel:td><%=rec.get("fund")%></Excel:td>
			<Excel:td><%=rec.get("status")%></Excel:td>
		</Excel:tr>
		<%
			}
		%>
		<Excel:tr>
			<Excel:td colspan="5">说明：
		</Excel:td>
		</Excel:tr>
		<Excel:tr>
			<Excel:td colspan="20" > 救助项目： 01城市低保； 02：农村低保
			03： 集中供养五保户； 04：分散供养五保户； 05：抚恤定补优抚对象； 06：残疾人；
			07：单亲特困母亲； 08：困难学生； 09："三无"对象； 10：特困职工； 11：其他；
		</Excel:td>
		</Excel:tr>
		<Excel:tr>
			<Excel:td colspan="20" > 实施状态标志：0:未实施,1:已实施;
		</Excel:td>
		</Excel:tr>
	</Excel:table>
</Excel:tablelist>

