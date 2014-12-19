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
	String name="残疾军人伤残器械发放_"+date;
	String configuration = (String)request.getParameter("configuration");
	
%>
</head>
<Excel:tablelist filename="<%=name%>">
	<Excel:table sheetname="残疾军人伤残器械发放列表">
		<Excel:tr >
		<%if("0".equals(configuration)){%>
			<Excel:td  align="center" width="150" colspan="10"><Excel:font size="18">山东省残疾军人康复辅助器具配置明细表</Excel:font></Excel:td>
		<%}else if("1".equals(configuration)){ %>
			<Excel:td  align="center" width="150" colspan="10"><Excel:font size="18">山东省残疾军人康复辅助器具维修明细表</Excel:font></Excel:td>
		<%} %>
		</Excel:tr>
		<Excel:tr  >
			<Excel:td  align="center" width="150">地区</Excel:td>
			<Excel:td  align="center" width="80">姓名</Excel:td>
			<Excel:td  align="center" width="130">身份证件号</Excel:td>
			<Excel:td  align="center" width="150">家庭住址</Excel:td>
			<Excel:td  align="center" width="100">电话</Excel:td>
			<Excel:td  align="center" width="200">伤残情形</Excel:td>
			<Excel:td  align="center" width="200">配置器具名称</Excel:td>
			<%if("0".equals(configuration)){%>
				<Excel:td  align="center" width="100">配置类别</Excel:td>
				<Excel:td  align="center" width="100">配置时间</Excel:td>
			<%}else if("1".equals(configuration)){ %>
				<Excel:td  align="center" width="100">维修类别</Excel:td>
				<Excel:td  align="center" width="100">维修时间</Excel:td>
			<%} %>
		</Excel:tr>
		<%
			DataSet ds = (DataSet)request.getAttribute("dataset");
			for(int i=0; i<ds.getCount(); i++) {
				Record rec = ds.getRecord(i);
		%>
		<Excel:tr>
			<Excel:td ><%=rec.get("DOMICILE")%></Excel:td>
			<Excel:td><%=rec.get("NAME")%></Excel:td>
			<Excel:td><%=rec.get("ID_CARD")%></Excel:td>
			<Excel:td><%=rec.get("FULL_NAME")%></Excel:td>
			<Excel:td><%=rec.get("TEL_MOBILE")%></Excel:td>
			<Excel:td><%=rec.get("DISABILITY_BODY")%></Excel:td>
			<Excel:td><%=rec.get("APPARATUS_NAME")%></Excel:td>
			<Excel:td><%=rec.get("DEVICES_TYPE")%></Excel:td>
			<Excel:td><%=rec.get("APPROVE_DATE")%></Excel:td>
		</Excel:tr>
		<%
			}
		%>
		<Excel:tr >
			<Excel:td  align="left"  colspan="3">合计人数：<%=ds.getCount() %></Excel:td>
		</Excel:tr>
	</Excel:table>
</Excel:tablelist>
