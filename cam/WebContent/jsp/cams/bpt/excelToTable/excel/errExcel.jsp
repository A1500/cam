<%@ page contentType="charset=UTF-8"%>
<%@ taglib uri="/tags/next-excel" prefix="Excel"%>
<%@page import="org.loushang.next.data.DataSet"%>
<%@page import="org.loushang.next.data.Record"%>
<%@page import="java.text.SimpleDateFormat"%>
<%
	SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
	String date = sdf.format(new java.util.Date());
	System.out.println("dddddd");
%>
<Excel:tablelist filename="导入错误信息" >
	<Excel:table>
		<Excel:tr>
			<Excel:td colspan="9" align="center"><Excel:font size="12">导入错误信息</Excel:font></Excel:td>
		</Excel:tr>
		<Excel:tr >
			<Excel:td colspan="9" align="center"><Excel:font size="13"><%=date%></Excel:font></Excel:td>
		</Excel:tr>
		<Excel:tr bgcolor="grey"  border="1">
			<Excel:td  align="center" width="200" rowspan="2"><Excel:font size="13">在Excel中行数</Excel:font></Excel:td>
			<Excel:td  align="center" width="120" rowspan="2"><Excel:font size="13">姓名</Excel:font></Excel:td>
			<Excel:td  align="center" width="200" rowspan="2"><Excel:font size="13">身份证号</Excel:font></Excel:td>
			<Excel:td  align="center" width="500" rowspan="2"><Excel:font size="13">错误信息</Excel:font></Excel:td>
		</Excel:tr>
		<Excel:tr ></Excel:tr>
		<%
		System.out.println("dddddd");
		DataSet dataset=(DataSet)request.getAttribute("dataset");
			for(int i=0;i<dataset.getCount();i++){
				Record record=dataset.getRecord(i);
				
		%>
		<Excel:tr border="1">
            <Excel:td  align="center" width="200"><%=record.get("ROW_NUM")==null?"":record.get("ROW_NUM")%></Excel:td>
            <Excel:td  align="center" width="120"><%=record.get("NAME")==null?"":record.get("NAME")%></Excel:td>
            <Excel:td  align="center" width="200"><%=record.get("ID_CARD")==null?"":record.get("ID_CARD")%></Excel:td>
            <Excel:td  align="center" width="500"><%=record.get("ERROR_MESSAGE")==null?"":record.get("ERROR_MESSAGE")%></Excel:td>

		</Excel:tr>
		<%
			}
		%>
	</Excel:table>
</Excel:tablelist>