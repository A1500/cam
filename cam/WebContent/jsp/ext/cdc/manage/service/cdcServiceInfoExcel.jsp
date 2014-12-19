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
		<title>社区服务情况</title>
		<next:ScriptManager/>
	</head>
<Excel:tablelist filename="社区服务情况">
	<Excel:table sheetname="社区服务情况">
	<Excel:tr>
			<Excel:td colspan="32" align="center" width = "100" ><Excel:font size="15"  bold="true"><%=organName+"社区服务情况"%></Excel:font></Excel:td>
		</Excel:tr>
		<Excel:tr>
			<Excel:td colspan="16" align="left">统计单位：<%= organName%></Excel:td>
			<Excel:td colspan="16" align="right">统计时间：<%=date2%></Excel:td>
		</Excel:tr>
		<Excel:tr>
			<Excel:td  align="center" rowspan="3" width = "100" >单位名称</Excel:td>
			<Excel:td colspan="10" align="center" >公共服务</Excel:td>
			<Excel:td colspan="6" align="center" >便民利民服务</Excel:td>
			<Excel:td colspan="12" align="center" >志愿者服务</Excel:td>
		</Excel:tr>
		<Excel:tr>
		
			<Excel:td  align="center" rowspan="2"  width = "100" >开展服务社区数</Excel:td>
			<Excel:td  align="center" rowspan="2"  width = "100" >一站式服务大厅数</Excel:td>
			<Excel:td  align="center" rowspan="2" width = "100" >服务项目数</Excel:td>
			
			<Excel:td colspan="3" align="center" >服务方式</Excel:td>
			
			<Excel:td  align="center" rowspan="2"  width = "100" >主管单位总数</Excel:td>
			<Excel:td  align="center" rowspan="2"  width = "100" >服务人员数</Excel:td>
			
			<Excel:td colspan="2" align="center" >服务时间</Excel:td>
			
			<Excel:td  align="center" rowspan="2" width = "100" >项目数</Excel:td>
			<Excel:td  align="center" rowspan="2" width = "100" >主管单位数</Excel:td>
			<Excel:td  align="center" rowspan="2" width = "100" >服务人员</Excel:td>
			<Excel:td  align="center" rowspan="2" width = "100" >服务场所总面积</Excel:td>
			<Excel:td  align="center" rowspan="2" width = "100" >服务场所平均面积</Excel:td>
			<Excel:td  align="center" rowspan="2" width = "100" >24小时服务项目数</Excel:td>
			
			<Excel:td colspan="8" align="center" >志愿者组织活动</Excel:td>
			<Excel:td colspan="4" align="center" >志愿者组织人数</Excel:td>
			
		</Excel:tr>
		<Excel:tr bgcolor="grey">
			<Excel:td  align="center"  width = "100" >现场办理项目数</Excel:td>
			<Excel:td  align="center"  width = "100" >全程代理项目数</Excel:td>
			<Excel:td  align="center"  width = "100" >其他项目数</Excel:td>
			
			<Excel:td  align="center"  width = "100" >全天项目数</Excel:td>
			<Excel:td  align="center"  width = "100" >非全天项目数</Excel:td>
			
			<Excel:td  align="center"  width = "100" >总数</Excel:td>
			<Excel:td  align="center"  width = "100" >平均个数</Excel:td>
			<Excel:td  align="center"  width = "100" >当年成立数量</Excel:td>
			<Excel:td  align="center"  width = "100" >针对儿童个数</Excel:td>
			<Excel:td  align="center"  width = "100" >针对老年人个数</Excel:td>
			<Excel:td  align="center"  width = "100" >针对残疾人个数</Excel:td>
			<Excel:td  align="center"  width = "100" >针对困难群众个数</Excel:td>
			<Excel:td  align="center"  width = "100" >针对其他个数</Excel:td>
			<Excel:td  align="center"  width = "100" >总人数</Excel:td>
			<Excel:td  align="center"  width = "100" >平均人数</Excel:td>
			<Excel:td  align="center"  width = "100" >注册人数</Excel:td>
			<Excel:td  align="center"  width = "100" >平均注册人数</Excel:td>
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
		<Excel:td><%=record.get("onceNum")%></Excel:td>
		<Excel:td><%=record.get("publicNum")%></Excel:td>
		<Excel:td><%=record.get("publicLocaleNum")%></Excel:td>
		<Excel:td><%=record.get("publicSupplyNum")%></Excel:td>
		<Excel:td><%=record.get("publicOtherNum")%></Excel:td>
		<Excel:td><%=record.get("publicMorgNum")%></Excel:td>
		<Excel:td><%=record.get("publicPeopleNum")%></Excel:td>
		<Excel:td><%=record.get("publicDayNum")%></Excel:td>
		<Excel:td><%=record.get("publicNotdayNum")%></Excel:td>
		<Excel:td><%=record.get("facilitateNum")%></Excel:td>
		<Excel:td><%=record.get("facilitateMorgNum")%></Excel:td>
		<Excel:td><%=record.get("facilitatePeopleNum")%></Excel:td>
		<Excel:td><%=record.get("facilitateArea")%></Excel:td>
		<Excel:td><%=record.get("facilitateArea")%></Excel:td>
		<Excel:td><%=record.get("facilitateDayNum")%></Excel:td>
		<Excel:td><%=record.get("voluntNum")%></Excel:td>
		<Excel:td><%=record.get("voluntNum")%></Excel:td>
		<Excel:td><%=record.get("voluntYearNum")%></Excel:td>
		<Excel:td><%=record.get("voluntChildNum")%></Excel:td>
		<Excel:td><%=record.get("voluntOldNum")%></Excel:td>
		<Excel:td><%=record.get("voluntHandiNum")%></Excel:td>
		<Excel:td><%=record.get("voluntDiffNum")%></Excel:td>
		<Excel:td><%=record.get("voluntOtherNum")%></Excel:td>
		<Excel:td><%=record.get("volunteerNum")%></Excel:td>
		<Excel:td><%=record.get("volunteerNum")%></Excel:td>
		<Excel:td><%=record.get("regNum")%></Excel:td>
		<Excel:td><%=record.get("regNum")%></Excel:td>
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