<%@ page contentType="charset=UTF-8"%>
<%@ taglib uri="/tags/next-excel" prefix="Excel"%>
<%@page import="org.loushang.next.data.DataSet"%>
<%@page import="org.loushang.next.data.Record"%>
<%@page import="java.text.SimpleDateFormat"%>
<%
	SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
	String date = sdf.format(new java.util.Date());
	
%>
<Excel:tablelist filename="三属人员基本信息" >
	<Excel:table>
		<Excel:tr>
			<Excel:td colspan="10" align="center"><Excel:font size="12">三属人员基本信息</Excel:font></Excel:td>
		</Excel:tr>
		<Excel:tr >
			<Excel:td colspan="10" align="center"><Excel:font size="13"><%=date%></Excel:font></Excel:td>
		</Excel:tr>
		<Excel:tr bgcolor="grey"  border="1">
			<Excel:td  align="center" width="200" rowspan="2"><Excel:font size="13">所属行政区划</Excel:font></Excel:td>
			<Excel:td  align="center" width="120" rowspan="2"><Excel:font size="13">姓名</Excel:font></Excel:td>
			<Excel:td  align="center" width="200" rowspan="2"><Excel:font size="13">身份证号</Excel:font></Excel:td>
			<Excel:td  align="center" width="120" rowspan="2"><Excel:font size="13">年龄（周岁）</Excel:font></Excel:td>
			<Excel:td  align="center" width="120" rowspan="2"><Excel:font size="13">性别</Excel:font></Excel:td>
			<Excel:td  align="center" width="120" rowspan="2"><Excel:font size="13">民族</Excel:font></Excel:td>
			<Excel:td align="center" width="200" rowspan="2"><Excel:font size="13">优抚人员状态</Excel:font></Excel:td>
			<Excel:td align="center" width="120" rowspan="2"><Excel:font size="13">优抚对象类别</Excel:font></Excel:td>
			<Excel:td align="center" width="120" rowspan="2"><Excel:font size="13">烈士姓名</Excel:font></Excel:td>
			<Excel:td align="center" width="120" rowspan="2"><Excel:font size="13">烈士批准时间</Excel:font></Excel:td>
			<Excel:td align="center" width="120" rowspan="2"><Excel:font size="13">定期抚恤证编号</Excel:font></Excel:td>
		</Excel:tr>
		<Excel:tr ></Excel:tr>
		<%
		DataSet dataset=(DataSet)request.getAttribute("dataset");
			for(int i=0;i<dataset.getCount();i++){
				Record record=dataset.getRecord(i);
				
		%>
		<Excel:tr border="1">
            <Excel:td  align="center" width="200"><%=record.get("DICNAME")==null?"":record.get("DICNAME")%></Excel:td>
            <Excel:td  align="center" width="120"><%=record.get("NAME")==null?"":record.get("NAME")%></Excel:td>
            <Excel:td  align="center" width="200"><%=record.get("ID_CARD")==null?"":record.get("ID_CARD")%></Excel:td>
            <Excel:td  align="center" width="120"><%=record.get("PEOPLE_AGE")==null?"":record.get("PEOPLE_AGE")%></Excel:td>
            <Excel:td  align="center" width="120"><%=record.get("SEX")==null?"":record.get("SEX")%></Excel:td>
            <Excel:td  align="center" width="120"><%=record.get("NATION")==null?"":record.get("NATION")%></Excel:td>
            <Excel:td  align="center" width="200"><%=record.get("DEPENDANT_STATE")==null?"":record.get("DEPENDANT_STATE")%></Excel:td>
            <Excel:td  align="center" width="120"><%=record.get("DEPENDANT_TYPE")==null?"":record.get("DEPENDANT_TYPE")%></Excel:td>
            <Excel:td  align="center" width="120"><%=record.get("LEZSW_NAME")==null?"":record.get("LEZSW_NAME")%></Excel:td>
            <Excel:td  align="center" width="120"><%=record.get("LEZSW_APPROVE_DATE")==null?"":record.get("LEZSW_APPROVE_DATE")%></Excel:td>
            <Excel:td  align="center" width="120"><%=record.get("DEPENDANT_NO")==null?"":record.get("DEPENDANT_NO")%></Excel:td>

		</Excel:tr>
		<%
			}
		%>
	</Excel:table>
</Excel:tablelist>