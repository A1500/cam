<%@ page contentType="charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/tags/next-excel" prefix="Excel"%>
<%@page import="org.loushang.next.data.DataSet"%>
<%@page import="org.loushang.next.data.Record"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.inspur.cams.comm.util.EnumUtil"%>
<%@page import="java.util.*"%>
<head>
<title>登记机关导出</title>
<%
	SimpleDateFormat sdf=new SimpleDateFormat("yyyy年MM月dd日HH时mm分");
	String date=sdf.format(new Date());
	String name="登记机关列表_"+date;
%>
</head>
<Excel:tablelist filename="<%=name%>">
	<Excel:table sheetname="登记机关列表">
		<Excel:tr height="50" >
			<Excel:td  align="center" width="150">名称</Excel:td>
			<Excel:td  align="center" width="80">代码</Excel:td>
			<Excel:td  align="center" width="150">地址</Excel:td>
			<Excel:td  align="center" width="100">服务电话</Excel:td>
			<Excel:td  align="center" width="100">负责人</Excel:td>
			<Excel:td  align="center" width="100">手机</Excel:td>
			<Excel:td  align="center" width="100">邮件地址</Excel:td>
			<Excel:td  align="center" width="100">性质</Excel:td>
			<Excel:td  align="center" width="100">总面积（平方米）</Excel:td>
			<Excel:td  align="center" width="100">状态</Excel:td>
		</Excel:tr>
		<%
			DataSet ds = (DataSet)request.getAttribute("dataset");
			for(int i=0; i<ds.getCount(); i++) {
				Record rec = ds.getRecord(i);
		%>
		<Excel:tr>
			<Excel:td ><%=rec.get("NAME")%></Excel:td>
			<Excel:td><%=rec.get("DEPT_CODE")%></Excel:td>
			<Excel:td><%=rec.get("DEPT_ADDRESS")%></Excel:td>
			<Excel:td><%=rec.get("DEPT_TEL")%></Excel:td>
			<Excel:td><%=rec.get("MODIFY_ID")%></Excel:td>
			<Excel:td><%=rec.get("COMPLAIN_TEL")%></Excel:td>
			<Excel:td><%=rec.get("OFFICE_EMAIL")%></Excel:td>
			<Excel:td><%=EnumUtil.findTextFromEnum((String)rec.get("TYPES"),"MRM.FORMATION.NATURE")%></Excel:td>
			<Excel:td><%=rec.get("areaCount")%></Excel:td>
			<Excel:td><%=EnumUtil.findTextFromEnum(String.valueOf(rec.get("VALID_FLAG")),"MRM.VALIDFLAG")%></Excel:td>
		</Excel:tr>
		<%
			}
		%>
	</Excel:table>
</Excel:tablelist>
