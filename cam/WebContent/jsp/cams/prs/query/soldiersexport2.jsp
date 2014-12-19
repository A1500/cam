<%@ page contentType="charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ taglib uri="/tags/next-excel" prefix="excel"%>
<%@page import="org.loushang.next.data.DataSet"%>
<%@page import="org.loushang.next.data.Record"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.inspur.cams.comm.dicm.IDicDao" %>
<%@page import="org.loushang.next.dao.DaoFactory" %>
<%@page import="java.util.Date" %>
<%@page import="com.inspur.cams.comm.util.EnumUtil"%>
<%!IDicDao dicDao = (IDicDao) DaoFactory
			.getDao("com.inspur.cams.comm.dicm.DicDao");
SimpleDateFormat sdf = new SimpleDateFormat("yyyy年MM月dd日HH时mm分");
String date = sdf.format(new Date());
public String servicedTimeRenderer(Object value){
	int year =0;
	int month=0;
	if(value instanceof BigDecimal ){
		year = ((BigDecimal)value).intValue()/12;
		month =((BigDecimal)value).intValue()%12;
	}else{
		year= Integer.parseInt(value.toString())/12;
		month =Integer.parseInt(value.toString())%12;
	}
	if(year==0){
		return month+"个月";
	}else if(month==0){
		return year+"年";
	}else{
		return year+"年"+month+"个月";
	}
}
%>
<%
	String fileName = (String)request.getParameter("fileName");
	fileName+=date;
%>
	<%@page import="java.math.BigDecimal"%>
<%@page import="com.ibm.db2.jcc.b.y"%>
<head>
		<title>导出Excel</title>
		<next:ScriptManager/>
	</head>
	<excel:tablelist filename="<%=fileName %>">
		<excel:table sheetname="<%=fileName %>">
			<excel:tr bgcolor="grey">
				<excel:td border="1" width="96" align="center">编号</excel:td>
				<excel:td border="1" width="96" align="center">姓名</excel:td>
				<excel:td border="1" width="96" align="center">专业特长</excel:td>
				<excel:td border="1" width="96" align="center">部队单位</excel:td>
				<excel:td border="1" width="96" align="center">入伍时间</excel:td>
				<excel:td border="1" width="96" align="center">退役时间</excel:td>
				<excel:td border="1" width="96" align="center">服役年限</excel:td>
				<excel:td border="1" width="128" align="center">入伍户口所在地</excel:td>
				<excel:td border="1" width="128" align="center">配偶户口所在地</excel:td>
				<excel:td border="1" width="96" align="center">安置理由</excel:td>
				<excel:td border="1" width="128" align="center">军区大单位</excel:td>
				<excel:td border="1" width="96" align="center">安置方式</excel:td>
				<excel:td border="1" width="96" align="center">就业时间</excel:td>
				<excel:td border="1" width="128" align="center">就业单位</excel:td>
				<excel:td border="1" width="160" align="center">经济补助金（自谋职业金）</excel:td>
				<excel:td border="1" width="96" align="center">申请时间</excel:td>
				<excel:td border="1" width="96" align="center">发放时间</excel:td>				
				</excel:tr>
				<%
				DataSet soldiersdataset=(DataSet)request.getAttribute("dataset");
				for(int i=0;i<soldiersdataset.getCount();i++){
					Record record=soldiersdataset.getRecord(i);
				%>				
			<excel:tr >
				<excel:td><%=record.get("FILE_NUM")==null?"":record.get("FILE_NUM")%></excel:td>
				<excel:td><%=record.get("NAME")==null?"":record.get("NAME")%></excel:td>
	 			<excel:td><%=record.get("SPECIALTY")==null?"":record.get("SPECIALTY")%></excel:td>
	 			<excel:td><%=record.get("SERVED_ARMY")==null?"":record.get("SERVED_ARMY")%></excel:td>
	 			<excel:td><%=record.get("ENLIST_TIME")==null?"":record.get("ENLIST_TIME")%></excel:td>
	 			<excel:td><%=record.get("RETIRED_TIME")==null?"":record.get("RETIRED_TIME")%></excel:td>
	 			<excel:td><%=record.get("SERVICED_TIME")==null?"":servicedTimeRenderer(record.get("SERVICED_TIME"))%></excel:td>
	 			<excel:td><%=record.get("ENLIST_PLACE")==null?"":record.get("ENLIST_PLACE")%></excel:td>
	 			<excel:td><%=record.get("SPOUSE_LOCATION")==null?"":record.get("SPOUSE_LOCATION")%></excel:td>
	 			<excel:td><%=EnumUtil.findTextFromEnum(String.valueOf(record.get("PLACEMEN_RENSON")),"PLACEMENREASON.CODE")%></excel:td>
	 			<excel:td><%=EnumUtil.findTextFromEnum("DIC_MILITARY_REGION_CODE","CODE","NAME",String.valueOf(record.get("SERVED_MILITARY_REGION")))%></excel:td>
	 			<excel:td><%=EnumUtil.findTextFromEnum(String.valueOf(record.get("RESETTLEMENT_SITUATION")),"PLACEMENT.TYPE")%></excel:td>
	 			<excel:td><%=record.get("EMPLOYMENT_TIME")==null?"":record.get("EMPLOYMENT_TIME")%></excel:td>
	 			<excel:td><%=record.get("EMPLOYMENT_COMPANY")==null?"":record.get("EMPLOYMENT_COMPANY")%></excel:td>
	 			<excel:td><%=record.get("GRANT_GRANT")==null?"":record.get("GRANT_GRANT")%></excel:td>
	 			<excel:td><%=record.get("APPLICATION_DATE")==null?"":record.get("APPLICATION_DATE")%></excel:td>
		 		<excel:td><%=record.get("GRANT_DATE")==null?"":record.get("GRANT_DATE")%></excel:td>
			</excel:tr>
			<%
				}
			%>
		</excel:table>
	</excel:tablelist>