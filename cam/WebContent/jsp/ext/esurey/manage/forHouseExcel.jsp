<%@ page contentType="charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ taglib uri="/tags/next-excel" prefix="Excel"%>
<%@page import="org.loushang.next.data.*"%>
<%@page import="org.loushang.next.commons.nenum.EnumService" %>
<%@page import="org.loushang.sca.ScaComponentFactory" %>
<%@page import="com.inspur.cams.comm.dicm.IDicDao" %>
<%@page import="org.loushang.next.dao.DaoFactory" %>
<html>
	<head>
		<title>房管核对信息</title>
		<next:ScriptManager/>
	</head>
<Excel:tablelist filename="房管核对信息">
	<Excel:table sheetname="房管核对信息">
		<Excel:tr>
			<Excel:td colspan="17" align="center"><Excel:font size="12">统计报表</Excel:font></Excel:td>
		</Excel:tr>
		<Excel:tr bgcolor="grey">
			
			<Excel:td  align="center" width="100">人员姓名</Excel:td>
			<Excel:td  align="center" width="150">身份证号码</Excel:td>
			<Excel:td  align="center" width="100">房产证号</Excel:td>
			<Excel:td  align="center" width="80">产权人姓名</Excel:td>
			<Excel:td  align="center" width="80">产权人身份证号</Excel:td>
			<Excel:td  align="center" width="80">房屋用途</Excel:td>
			<Excel:td  align="center" width="80">交易价值（元）</Excel:td>
			<Excel:td  align="center" width="80">登记或交易时间</Excel:td>
			<Excel:td  align="center" width="80">交易性质</Excel:td>
			<Excel:td  align="center" width="80">房屋坐落</Excel:td>
			<Excel:td  align="center" width="80">建筑面积（平方米）</Excel:td>
			<Excel:td  align="center" width="80">所在地区</Excel:td>
			<Excel:td  align="center" width="80">核对日期</Excel:td>
			<Excel:td  align="center" width="80">核对人</Excel:td>
			
		</Excel:tr>
		<%
		DataSet dataset = (DataSet)request.getAttribute("dataset");
		for(int i=0; i<dataset.getCount(); i++) {
			Record record = dataset.getRecord(i);
		%>
		<Excel:tr>
			
			<Excel:td><%=record.get("NAME")%></Excel:td>
			<Excel:td><%=record.get("ID_CARD")%></Excel:td>
			<Excel:td><%=record.get("HOUSE_CARD_NO")%></Excel:td>
 			<Excel:td><%=record.get("HOUSE_OWER")%></Excel:td>
 			<Excel:td><%=record.get("OWER_ID_CARD")%></Excel:td>
 			<Excel:td><%=record.get("HOUSE_USEAGE_NAME")%></Excel:td>
 			<Excel:td><%=record.get("REG_VALUE")%></Excel:td>
 			<Excel:td><%=record.get("REG_DATE")%></Excel:td>
 			<Excel:td><%=record.get("BUSINESS_TYPE_NAME")%></Excel:td>
 			<Excel:td><%=record.get("LOCATION")%></Excel:td>
 			<Excel:td><%=record.get("HOUSE_AREA")%></Excel:td>
 			<Excel:td><%=record.get("FAMILY_ADDRESS_NAME")%></Excel:td>
 			<Excel:td><%=record.get("CHECK_TIME")%></Excel:td>
 			<Excel:td><%=record.get("CHECK_PEOPLE")%></Excel:td>
		</Excel:tr>
		<%
			}
		%>
	</Excel:table>
</Excel:tablelist>

</html>