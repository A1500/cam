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

<%
	String cxsj_year = (String)request.getParameter("cxsj_year");
	String cx_servedMilitaryRegion = (String)request.getParameter("cx_servedMilitaryRegion");
	String fileName = "退役士兵安置地明细表";
	if(!cx_servedMilitaryRegion.equals("")){
		cx_servedMilitaryRegion = EnumUtil.findTextFromEnum("DIC_MILITARY_REGION_CODE","CODE","NAME",String.valueOf(cx_servedMilitaryRegion));
		fileName = cx_servedMilitaryRegion+fileName;
	}
	if(!cxsj_year.equals("")){
		fileName = cxsj_year+"年度"+fileName;
	}
%>
	
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
				<excel:td border="1" width="128" align="center">入伍户口所在地</excel:td>
				<excel:td border="1" width="128" align="center">配偶户口所在地</excel:td>
				<excel:td border="1" width="96" align="center">安置理由</excel:td>
				<excel:td border="1" width="96" align="center">军区大单位</excel:td>
				<excel:td border="1" width="96" align="center">安置方式</excel:td>
				<excel:td border="1" width="96" align="center">就业时间</excel:td>
				<excel:td border="1" width="96" align="center">就业单位</excel:td>
				<excel:td border="1" width="192" align="center">经济补助金（自谋职业金）</excel:td>
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
