<%@page contentType="charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="/tags/next-excel" prefix="Excel"%>
<%@page import="org.loushang.next.data.DataSet"%>
<%@page import="org.loushang.next.data.Record"%>
<%@page import="java.util.Iterator"%>

<!--导出Excel-->
<Excel:tablelist filename="导出明细">
	<Excel:table sheetname="导出明细">
		<Excel:tr>
			<Excel:td colspan="7" align="center" ><Excel:font size="15">城乡居民家庭经济状况列表</Excel:font></Excel:td>
		</Excel:tr>

		<Excel:tr height="50" >
			<Excel:td  align="center" width="100">户主姓名</Excel:td>
			<Excel:td  align="center" width="100">身份证件号码</Excel:td>
			<Excel:td  align="center" width="100">家庭人口</Excel:td>
			<Excel:td  align="center" width="100">户籍行政区划</Excel:td>
			<Excel:td  align="center" width="100">属地行政区划</Excel:td>
			<Excel:td  align="center" width="100">家庭地址</Excel:td>
			<Excel:td  align="center" width="100">邮政编码</Excel:td>
			<Excel:td  align="center" width="100">家庭性质</Excel:td>
			<Excel:td  align="center" width="100">诚信等级</Excel:td>
			<Excel:td  align="center" width="100">申报救助类型</Excel:td>
			<Excel:td  align="right" width="100">申报家庭年总收入(元)</Excel:td>
			<Excel:td  align="right" width="100">核对家庭年总收入(元)</Excel:td>
			<Excel:td  align="right" width="100">家庭年人均收入(元)</Excel:td>
			<Excel:td  align="right" width="100">核对家庭年人均收入(元)</Excel:td>
			<Excel:td  align="right" width="100">家庭月总收入(元)</Excel:td>
			<Excel:td  align="right" width="100">核对家庭月总收入(元)</Excel:td>
			<Excel:td  align="right" width="100">家庭月人均收入(元)</Excel:td>
			<Excel:td  align="right" width="100">核对家庭月人均收入(元)</Excel:td>
		</Excel:tr>
		<%
			DataSet dataset = (DataSet)request.getAttribute("dataset");
			for(int i=0; i<dataset.getCount(); i++) {
				Record rec = dataset.getRecord(i);
		%>
		<Excel:tr>
			<Excel:td><%=rec.get("FAMILY_NAME")%></Excel:td>
			<Excel:td><%=rec.get("FAMILY_CARD_NO")%></Excel:td>
			<Excel:td><%=rec.get("PEOPLE_NUM")%></Excel:td>
			<Excel:td><%=rec.get("REG_ADDRESS")%></Excel:td>
			<Excel:td><%=rec.get("FAMILY_ADDRESS")%></Excel:td>
			<Excel:td><%=rec.get("ADDRESS")%></Excel:td>
			<Excel:td><%=rec.get("FAMILY_POSTCODE")%></Excel:td>
			<Excel:td><%=rec.get("DOMICILE_TYPE_NAME")%></Excel:td>
			<Excel:td><%=rec.get("CREDIT_RATING_NAME")%></Excel:td>
			<Excel:td><%=rec.get("ASSISTANCE_TYPE_NAME")%></Excel:td>
			<Excel:td><%=rec.get("YEAR_INCOME")%></Excel:td>
			<Excel:td><%=rec.get("SUM_YEAR_INCOME")%></Excel:td>
			<Excel:td><%=rec.get("YEAR_AVERAGE_INCOME")%></Excel:td>
			<Excel:td><%=rec.get("SUM_YEAR_AVERAGE_INCOME")%></Excel:td>
			<Excel:td><%=rec.get("MONTH_INCOME")%></Excel:td>
			<Excel:td><%=rec.get("SUM_MONTH_INCOME")%></Excel:td>
			<Excel:td><%=rec.get("MONTH_AVERAGE_INCOME")%></Excel:td>
			<Excel:td><%=rec.get("SUM_MONTH_AVERAGE_INCOME")%></Excel:td>
			
		</Excel:tr>
		<%
			}
		%>
	</Excel:table>
</Excel:tablelist>

