<%@ page contentType="charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ taglib uri="/tags/next-excel" prefix="Excel"%>
<%@page import="org.loushang.next.data.*"%>
<%@page import="org.loushang.next.commons.nenum.EnumService" %>
<%@page import="org.loushang.sca.ScaComponentFactory" %>
<%@page import="com.inspur.cams.comm.dicm.IDicDao" %>
<%@page import="org.loushang.next.dao.DaoFactory" %>
<%@page import="com.inspur.cams.cdc.base.dao.ICdcReportWorkDao" %>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<html>
<%	
SimpleDateFormat sdf=new SimpleDateFormat("yyyy年MM月dd日HH时mm分");
SimpleDateFormat sdf2=new SimpleDateFormat("yyyy年MM月dd日");
String date=sdf.format(new Date());
String date2=sdf2.format(new Date());
out.clear();//清空缓存的内容
out = pageContext.pushBody(); 
	String organName = request.getParameter("organName");
%>
	<head>
		<title>社区资产状况</title>
		<next:ScriptManager/>
	</head>
<Excel:tablelist filename="社区资产状况">
	<Excel:table sheetname="社区资产状况">
		<Excel:tr>
			<Excel:td colspan="12" align="center" width = "100" ><Excel:font size="15"  bold="true"><%=organName+"社区资产状况"%></Excel:font></Excel:td>
		</Excel:tr>
		<Excel:tr>
			<Excel:td colspan="6" align="left">统计单位：<%= organName%></Excel:td>
			<Excel:td colspan="6" align="right">统计时间：<%=date2%></Excel:td>
		</Excel:tr>
		<Excel:tr bgcolor="grey">
			<Excel:td  align="center"  width = "100" >单位名称</Excel:td>
			<Excel:td  align="center"  width = "100" >社区数量</Excel:td>
			<Excel:td  align="center"  width = "100" >生产总值（万元）</Excel:td>
			<Excel:td  align="center"  width = "100" >农业产值（万元）</Excel:td>
			<Excel:td  align="center"  width = "100" >人均纯收入（元）</Excel:td>
			<Excel:td  align="center"  width = "100" >集体收入总额（万元）</Excel:td>
			<Excel:td  align="center"  width = "100" >债权总额（万元）</Excel:td>
			<Excel:td  align="center"  width = "100" >债务总额（万元）</Excel:td>
			<Excel:td  align="center"  width = "100" >固定资产（万元）</Excel:td>
			<Excel:td  align="center"  width = "100" >填报日期</Excel:td>
			<Excel:td  align="center"  width = "100" >填报状态</Excel:td>
			<Excel:td  align="center"  width = "100" >上报日期</Excel:td>
		</Excel:tr>
		<%
		
		String status="";
		String reportDate="";
		DataSet ds = (DataSet)request.getAttribute("dataset");
		IDicDao dao = (IDicDao) DaoFactory.getDao("com.inspur.cams.comm.dicm.DicDao");
		ICdcReportWorkDao reportdao = (ICdcReportWorkDao) DaoFactory.getDao("com.inspur.cams.cdc.base.dao.jdbc.CdcReportWorkDao");
		EnumService enumService = ScaComponentFactory.getService(EnumService.class, "Enum/EnumService");
		DataSet dataset = (DataSet)request.getAttribute("dataset");
		for(int i=0; i<dataset.getCount(); i++) {
			Record record = dataset.getRecord(i);
			if(record.get("status")!=null){
				status = enumService.getDescByValue("CDC.STATUS", (String)record.get("status"));
			}
			if(record.get("reportDate") != null ){
				ParameterSet pset = new ParameterSet();
				pset.setParameter("WORK_ID",record.get("reportDate"));
				reportDate =(String)reportdao.query(pset).getRecord(0).get("reportDate");
			}
		%>
		<Excel:tr>
		<Excel:td><%=record.get("organName")%></Excel:td>
		<Excel:td><%=record.get("communityNum")%></Excel:td>
		<Excel:td><%=record.get("gdpMon")%></Excel:td>
		<Excel:td><%=record.get("agricultureMon")%></Excel:td>
		<Excel:td><%=record.get("personMon")%></Excel:td>
		<Excel:td><%=record.get("incomeMon")%></Excel:td>
		<Excel:td><%=record.get("claimMon")%></Excel:td>
		<Excel:td><%=record.get("debtMon")%></Excel:td>
		<Excel:td><%=record.get("fixedMon")%></Excel:td>
		<Excel:td><%=reportDate%></Excel:td>
		<Excel:td><%=status%></Excel:td>
		<Excel:td><%=record.get("submitDate")%></Excel:td>
		</Excel:tr>
		<%
			}
		%>
	</Excel:table>
</Excel:tablelist>

</html>