<%@page contentType="charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="/tags/next-excel" prefix="Excel"%>
<%@page import="org.loushang.next.data.DataSet"%>
<%@page import="org.loushang.next.data.Record"%>
<%@page import="java.util.Iterator"%>

<!--导出Excel-->
<Excel:tablelist filename="导出明细">
	<Excel:table sheetname="导出明细">
		<Excel:tr>
			<Excel:td colspan="7" align="center" ><Excel:font size="15">导出明细</Excel:font></Excel:td>
		</Excel:tr>

		<Excel:tr height="50" >
			<Excel:td  align="center" width="100">户主姓名</Excel:td>
			<Excel:td  align="center" width="100">户主身份证件号码</Excel:td>
			<Excel:td  align="center" width="100">家庭居住地</Excel:td>
			<Excel:td  align="center" width="100">家庭地址</Excel:td>
		</Excel:tr>
		<%
			DataSet EconomicsDataset = (DataSet)request.getAttribute("dataset");
			for(int i=0; i<EconomicsDataset.getCount(); i++) {
				Record rec = EconomicsDataset.getRecord(i);
				
				for (Iterator iter = rec.keys(); iter.hasNext();) {
					  String str = (String)iter.next();
					  System.out.println(str);
			 	}
		%>
		<Excel:tr>
			<Excel:td><%=rec.get("PATRIARCH_NAME")%></Excel:td>
			<Excel:td><%=rec.get("ID_CARD")%></Excel:td>
			<Excel:td><%=rec.get("APANAGE_CODE")%></Excel:td>
			<Excel:td><%=rec.get("FAMILY_ADD")%></Excel:td>
		</Excel:tr>
		<%
			}
		%>
	</Excel:table>
</Excel:tablelist>

