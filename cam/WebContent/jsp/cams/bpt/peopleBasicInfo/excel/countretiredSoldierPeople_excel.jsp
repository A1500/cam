<%@ page contentType="charset=UTF-8"%>
<%@ taglib uri="/tags/next-excel" prefix="Excel"%>
<%@page import="org.loushang.next.data.DataSet"%>
<%@page import="org.loushang.next.data.Record"%>
<%@page import="java.text.SimpleDateFormat"%>
<%
	SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
	String date = sdf.format(new java.util.Date());
	
%>
<Excel:tablelist filename="60周岁以上农村籍退役军人基本信息" >
	<Excel:table>
		<Excel:tr>
			<Excel:td colspan="10" align="center"><Excel:font size="12">60周岁以上农村籍退役军人基本信息</Excel:font></Excel:td>
		</Excel:tr>
		<Excel:tr >
			<Excel:td colspan="10" align="center"><Excel:font size="13"><%=date%></Excel:font></Excel:td>
		</Excel:tr>
		<Excel:tr bgcolor="grey"  border="1">
			<Excel:td  align="center" width="200" rowspan="2"><Excel:font size="13">所属行政区划</Excel:font></Excel:td>
			<Excel:td  align="center" width="120" rowspan="2"><Excel:font size="13">姓名</Excel:font></Excel:td>
			<Excel:td  align="center" width="200" rowspan="2"><Excel:font size="13">身份证号</Excel:font></Excel:td>
			<Excel:td  align="center" width="120" rowspan="2"><Excel:font size="13">性别</Excel:font></Excel:td>
			<Excel:td  align="center" width="120" rowspan="2"><Excel:font size="13">民族</Excel:font></Excel:td>
			<Excel:td align="center" width="120" rowspan="2"><Excel:font size="13">户籍类别</Excel:font></Excel:td>
			<Excel:td align="center" width="120" rowspan="2"><Excel:font size="13">家庭人口</Excel:font></Excel:td>
			<Excel:td align="center" width="120" rowspan="2"><Excel:font size="13">是否享受低保</Excel:font></Excel:td>
			<Excel:td align="center" width="120" rowspan="2"><Excel:font size="13">是否享受五保</Excel:font></Excel:td>
			<Excel:td align="center" width="120" rowspan="2"><Excel:font size="13">服役年限</Excel:font></Excel:td>
			<Excel:td align="center" width="200" rowspan="2"><Excel:font size="13">备注</Excel:font></Excel:td>
		</Excel:tr>
		<Excel:tr ></Excel:tr>
		<%
		DataSet dataset=(DataSet)request.getAttribute("dataset");
			for(int i=0;i<dataset.getCount();i++){
				Record record=dataset.getRecord(i);
				
		%>
		<Excel:tr border="1">
            <Excel:td  align="center" width="200"><%=record.get("DOMICILE_NAME")==null?"":record.get("DOMICILE_NAME")%></Excel:td>
            <Excel:td  align="center" width="120"><%=record.get("NAME")==null?"":record.get("NAME")%></Excel:td>
            <Excel:td  align="center" width="200"><%=record.get("ID_CARD")==null?"":record.get("ID_CARD")%></Excel:td>
            <Excel:td  align="center" width="120"><%=record.get("SEX")==null?"":record.get("SEX")%></Excel:td>
            <Excel:td  align="center" width="120"><%=record.get("NATION")==null?"":record.get("NATION")%></Excel:td>
            <Excel:td  align="center" width="120"><%=record.get("DOMICILE_TYPE")==null?"":record.get("DOMICILE_TYPE")%></Excel:td>
            <Excel:td  align="center" width="120"><%=record.get("FAMILY_NUM")==null?"":record.get("FAMILY_NUM")%></Excel:td>
            <Excel:td  align="center" width="120"><%=record.get("IS_GUARANT")==null?"":record.get("IS_GUARANT")%></Excel:td>
            <Excel:td  align="center" width="120"><%=record.get("IS_FIVE_GUARANT")==null?"":record.get("IS_FIVE_GUARANT")%></Excel:td>
			<Excel:td  align="center" width="120"><%=record.get("SOLDIER_YEARS")==null?"":record.get("SOLDIER_YEARS")%></Excel:td>       
            <Excel:td  align="center" width="200"><%=record.get("NOTE")==null?"":record.get("NOTE")%></Excel:td>

		</Excel:tr>
		<%
			}
		%>
	</Excel:table>
</Excel:tablelist>