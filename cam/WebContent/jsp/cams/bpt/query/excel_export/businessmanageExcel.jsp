<%@ page contentType="charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/tags/next-excel" prefix="Excel"%>
<%@page import="org.loushang.next.data.DataSet"%>
<%@page import="org.loushang.next.data.Record"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.inspur.cams.comm.util.EnumUtil"%>
<%@page import="java.util.*"%>
<head>
<title>优抚业务办理统计导出</title>
<%
	SimpleDateFormat sdf=new SimpleDateFormat("yyyy年MM月dd日HH时mm分");
	String date=sdf.format(new Date());
	String name="优抚业务办理统计列表_"+date;
%>
</head>
<Excel:tablelist filename="<%=name%>">
	<Excel:table sheetname="优抚业务办理统计列表">
		<Excel:tr height="50" >
			<Excel:td  align="center" width="150">所属行政区划</Excel:td>
			<Excel:td  align="center" width="80">姓名</Excel:td>
			<Excel:td  align="center" width="50">性别</Excel:td>
			<Excel:td  align="center" width="100">民族</Excel:td>
			<Excel:td  align="center" width="150">身份证件号码</Excel:td>
			<Excel:td  align="center" width="90">出生日期</Excel:td>
			<Excel:td  align="center" width="60">户籍类别</Excel:td>
			<Excel:td  align="center" width="260">优抚业务类别</Excel:td>
		</Excel:tr>
		<%
			DataSet ds = (DataSet)request.getAttribute("dataset");
			for(int i=0; i<ds.getCount(); i++) {
				Record rec = ds.getRecord(i);
		%>
		<Excel:tr>
			<Excel:td ><%=rec.get("FULL_NAME")%></Excel:td>
			<Excel:td><%=rec.get("NAME")%></Excel:td>
			<Excel:td><%=EnumUtil.findTextFromEnum((String)rec.get("SEX"),"COMM.SEX")%></Excel:td>
			<Excel:td><%=EnumUtil.findTextFromEnum("DIC_NATION","CODE","NAME",(String)rec.get("NATION"))%></Excel:td>
			<Excel:td><%=rec.get("ID_CARD")%></Excel:td>
			<Excel:td><%=rec.get("BIRTHDAY")%></Excel:td>
			<Excel:td><%=EnumUtil.findTextFromEnum(String.valueOf(rec.get("DOMICILE_TYPE")),"DOMICILE.TYPE")%></Excel:td>
			<Excel:td><%=EnumUtil.findTextFromEnum(String.valueOf(rec.get("SERVICE_TYPE")),"APPLY.TYPE")%></Excel:td>
		</Excel:tr>
		<%
			}
		%>
	</Excel:table>
</Excel:tablelist>
