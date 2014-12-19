<%@ page contentType="charset=UTF-8"%>
<%@ taglib uri="/tags/next-excel" prefix="Excel"%>
<%@page import="org.loushang.next.data.DataSet"%>
<%@page import="org.loushang.next.data.Record"%>
<%@page import="java.text.SimpleDateFormat"%>
<%
	SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
	String date = sdf.format(new java.util.Date());
	
%>
<Excel:tablelist filename="伤残人员基本信息" >
	<Excel:table>
		<Excel:tr>
			<Excel:td colspan="12" align="center"><Excel:font size="12">伤残人员基本信息</Excel:font></Excel:td>
		</Excel:tr>
		<Excel:tr >
			<Excel:td colspan="12" align="center"><Excel:font size="13"><%=date%></Excel:font></Excel:td>
		</Excel:tr>
		<Excel:tr bgcolor="grey"  border="1">
			<Excel:td  align="center" width="200" rowspan="2"><Excel:font size="13">所属行政区划</Excel:font></Excel:td>
			<Excel:td  align="center" width="100" rowspan="2"><Excel:font size="13">姓名</Excel:font></Excel:td>
			<Excel:td  align="center" width="200" rowspan="2"><Excel:font size="13">身份证号</Excel:font></Excel:td>
			<Excel:td  align="center" width="120" rowspan="2"><Excel:font size="13">年龄（周岁）</Excel:font></Excel:td>
			<Excel:td  align="center" width="100" rowspan="2"><Excel:font size="13">性别</Excel:font></Excel:td>
			<Excel:td  align="center" width="100" rowspan="2"><Excel:font size="13">民族</Excel:font></Excel:td>
			<Excel:td align="center" width="120" rowspan="2"><Excel:font size="13">优抚人员状态</Excel:font></Excel:td>
			<Excel:td align="center" width="200" rowspan="2"><Excel:font size="13">优抚对象类别</Excel:font></Excel:td>
			<Excel:td align="center" width="120" rowspan="2"><Excel:font size="13">伤残等级</Excel:font></Excel:td>
			<Excel:td align="center" width="120" rowspan="2"><Excel:font size="13">伤残性质</Excel:font></Excel:td>
			<Excel:td align="center" width="120" rowspan="2"><Excel:font size="13">伤残属别</Excel:font></Excel:td>
			<Excel:td align="center" width="120" rowspan="2"><Excel:font size="13">伤残时期</Excel:font></Excel:td>
			<Excel:td align="center" width="120" rowspan="2"><Excel:font size="13">证书编号</Excel:font></Excel:td>
		</Excel:tr>
		<Excel:tr ></Excel:tr>
		<%
		DataSet dataset=(DataSet)request.getAttribute("dataset");
			for(int i=0;i<dataset.getCount();i++){
				Record record=dataset.getRecord(i);
				
		%>
		<Excel:tr border="1">
            <Excel:td  align="center" width="200"><%=record.get("DICNAME")==null?"":record.get("DICNAME")%></Excel:td>
            <Excel:td  align="center" width="100"><%=record.get("NAME")==null?"":record.get("NAME")%></Excel:td>
            <Excel:td  align="center" width="200"><%=record.get("ID_CARD")==null?"":record.get("ID_CARD")%></Excel:td>
            <Excel:td  align="center" width="120"><%=record.get("PEOPLE_AGE")==null?"":record.get("PEOPLE_AGE")%></Excel:td>
            <Excel:td  align="center" width="100"><%=record.get("PSEX")==null?"":record.get("PSEX")%></Excel:td>
            <Excel:td  align="center" width="100"><%=record.get("NATION")==null?"":record.get("NATION")%></Excel:td>
            <Excel:td  align="center" width="120"><%=record.get("DISABILITY_STATE_CODE")==null?"":record.get("DISABILITY_STATE_CODE")%></Excel:td>
            <Excel:td  align="center" width="200"><%=record.get("DISABILITY_TYPE_CODE")==null?"":record.get("DISABILITY_TYPE_CODE")%></Excel:td>
            <Excel:td  align="center" width="120"><%=record.get("DISABILITY_LEVEL_CODE")==null?"":record.get("DISABILITY_LEVEL_CODE")%></Excel:td>
            <Excel:td  align="center" width="120"><%=record.get("DISABILITY_CASE_CODE")==null?"":record.get("DISABILITY_CASE_CODE")%></Excel:td>
            <Excel:td  align="center" width="120"><%=record.get("DISABILITY_GENUS_CODE")==null?"":record.get("DISABILITY_GENUS_CODE")%></Excel:td>
            <Excel:td  align="center" width="120"><%=record.get("DISABILITY_WAR_CODE")==null?"":record.get("DISABILITY_WAR_CODE")%></Excel:td>
            <Excel:td  align="center" width="120"><%=record.get("DISABILITY_NO")==null?"":record.get("DISABILITY_NO")%></Excel:td>
		</Excel:tr>
		<%
			}
		%>
	</Excel:table>
</Excel:tablelist>