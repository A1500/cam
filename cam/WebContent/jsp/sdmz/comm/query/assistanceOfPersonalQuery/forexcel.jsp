<%@ page contentType="charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/tags/next-excel" prefix="Excel"%>
<%@page import="org.loushang.next.data.DataSet"%>
<%@page import="org.loushang.next.data.Record"%>
<%! public  static final int PAGE_COUNT=15;%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.*"%>
<head>
<title>导出Excel</title>
<%
	SimpleDateFormat sdf=new SimpleDateFormat("yyyy年MM月dd日HH时mm分");
	String date=sdf.format(new Date());
	String name="救助方案明细_"+date;
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
<Excel:tablelist filename="<%=name %>">
	<Excel:table sheetname="救助方案明细">
		<Excel:tr>
			<Excel:td colspan="7" align="center" ><Excel:font size="<%=PAGE_COUNT %>">救助方案明细</Excel:font></Excel:td>
		</Excel:tr>
		<Excel:tr height="50" >
			<Excel:td  align="center" width="100">受助人/单位名称</Excel:td>
			<Excel:td  align="center" width="100">救助部门</Excel:td>
			<Excel:td  align="center" width="100">受助日期</Excel:td>
			<Excel:td  align="center" width="100">救助资金现金金额</Excel:td>
			<Excel:td  align="center" width="100">救助物品名称</Excel:td>
			<Excel:td  align="center" width="100">救助物品数量</Excel:td>
			<Excel:td  align="center" width="100">救助物品折价金额</Excel:td>
			<Excel:td  align="center" width="100">合计金额</Excel:td>
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
			<Excel:td><%=rec.get("assistedName")%></Excel:td>
			<Excel:td><%=rec.get("regOrgName")%></Excel:td>
			<Excel:td><%=rec.get("assitanceDate")%></Excel:td>
			<Excel:td><%=rec.get("captial")%></Excel:td>
			<Excel:td><%=rec.get("goodsName")%></Excel:td>
			<Excel:td><%=rec.get("goodsNum")%></Excel:td>
			<Excel:td><%=rec.get("goodsNums")%></Excel:td>
			<Excel:td><%=rec.get("totalFund")%></Excel:td>
		</Excel:tr>
		<%
			}
		%>
	</Excel:table>
</Excel:tablelist>

