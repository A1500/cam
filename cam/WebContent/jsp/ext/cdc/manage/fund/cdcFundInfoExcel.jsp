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
		<title>社区经费情况</title>
		<next:ScriptManager/>
	</head>
<Excel:tablelist filename="社区经费情况">
	<Excel:table sheetname="社区经费情况">
		<Excel:tr>
			<Excel:td colspan="18" align="center" width = "100" ><Excel:font size="15"  bold="true"><%=organName+"社区经费情况"%></Excel:font></Excel:td>
		</Excel:tr>
		<Excel:tr>
			<Excel:td colspan="9" align="left">统计单位：<%= organName%></Excel:td>
			<Excel:td colspan="9" align="right">统计时间：<%=date2%></Excel:td>
		</Excel:tr>
		<Excel:tr>
			<Excel:td  align="center" rowspan="3" width = "100" >单位名称</Excel:td>
			<Excel:td colspan="5" align="center" >社区年度办公经费（单位 万元）</Excel:td>
			<Excel:td colspan="9" align="center" >社区年度专项经费（单位 万元）</Excel:td>
		</Excel:tr>
		<Excel:tr>
			<Excel:td rowspan="2" align="center"  width = "100" >金额(万元)</Excel:td>
			<Excel:td colspan="4" align="center" >来源</Excel:td>
			<Excel:td rowspan="2" align="center"  width = "100" >金额(万元)</Excel:td>
			<Excel:td colspan="4" align="center" >来源</Excel:td>
			<Excel:td colspan="4" align="center" >用途</Excel:td>
		</Excel:tr>
		<Excel:tr bgcolor="grey">
			<Excel:td  align="center"  width = "100" >财政拨款金额(万元)</Excel:td>
			<Excel:td  align="center"  width = "100" >自筹金额(万元)</Excel:td>
			<Excel:td  align="center"  width = "100" >社会捐助金额(万元)</Excel:td>
			<Excel:td  align="center"  width = "100" >其他金额(万元)</Excel:td>
			
			<Excel:td  align="center"  width = "100" >财政拨款金额(万元)</Excel:td>
			<Excel:td  align="center"  width = "100" >自筹金额(万元)</Excel:td>
			<Excel:td  align="center"  width = "100" >社会捐助金额(万元)</Excel:td>
			<Excel:td  align="center"  width = "100" >其他金额(万元)</Excel:td>
			<Excel:td  align="center"  width = "100" >基础设施建设金额(万元)</Excel:td>
			<Excel:td  align="center"  width = "100" >各项活动金额(万元)</Excel:td>
			<Excel:td  align="center"  width = "100" >购买服务金额(万元)</Excel:td>
			<Excel:td  align="center"  width = "100" >其他金额(万元)</Excel:td>
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
		
		<Excel:td><%=record.get("offMon")%></Excel:td>
	
		<Excel:td><%=record.get("offFinanceMon")%></Excel:td>
	
		<Excel:td><%=record.get("offSelfMon")%></Excel:td>
	
		<Excel:td><%=record.get("offEnbowMon")%></Excel:td>
	
		<Excel:td><%=record.get("offOtherMon")%></Excel:td>
	
		<Excel:td><%=record.get("sepMon")%></Excel:td>
	
		<Excel:td><%=record.get("sepFinanceMon")%></Excel:td>
	
		<Excel:td><%=record.get("sepSelfMon")%></Excel:td>
	
		<Excel:td><%=record.get("sepEnbowMon")%></Excel:td>
	
		<Excel:td><%=record.get("sepOtherMon")%></Excel:td>
	
		<Excel:td><%=record.get("useBuildMon")%></Excel:td>
	
		<Excel:td><%=record.get("useActionMon")%></Excel:td>
	
		<Excel:td><%=record.get("useServiceMon")%></Excel:td>
	
		<Excel:td><%=record.get("useOtherMon")%></Excel:td>
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