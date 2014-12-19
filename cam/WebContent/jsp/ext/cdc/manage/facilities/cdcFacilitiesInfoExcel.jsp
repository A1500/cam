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
		<title>社区综合服务设施</title>
		<next:ScriptManager/>
	</head>
<Excel:tablelist filename="社区综合服务设施">
	<Excel:table sheetname="社区综合服务设施">
	<Excel:tr>
			<Excel:td colspan="38" align="center" width = "100" ><Excel:font size="15"  bold="true"><%=organName+"社区综合服务设施"%></Excel:font></Excel:td>
		</Excel:tr>
		<Excel:tr>
			<Excel:td colspan="19" align="left">统计单位：<%= organName%></Excel:td>
			<Excel:td colspan="19" align="right">统计时间：<%=date2%></Excel:td>
		</Excel:tr>
		<Excel:tr>
			<Excel:td  align="center" rowspan="3" width = "100" >单位名称</Excel:td>
			<Excel:td colspan="3" align="center" >社区工作用房</Excel:td>
			<Excel:td colspan="18" align="center" >社区服务设施用房</Excel:td>
			<Excel:td colspan="5" align="center" >社区工作用房、社区服务设施用房投入资金</Excel:td>
			<Excel:td colspan="8" align="center" >社区室外活动场地</Excel:td>
		</Excel:tr>
		<Excel:tr>
			<Excel:td  align="center" width = "100" rowspan="2" >数量(个)</Excel:td>
			<Excel:td  align="center" width = "100" rowspan="2" >建筑面积(m2)</Excel:td>
			<Excel:td  align="center" width = "100" rowspan="2" >投入使用年份(年)</Excel:td>
			
			<Excel:td colspan="3" align="center" >社区服务大厅</Excel:td>
			<Excel:td colspan="3" align="center" >社区警务室</Excel:td>
			<Excel:td colspan="3" align="center" >社区卫生室</Excel:td>
			<Excel:td colspan="3" align="center" >社区图书室</Excel:td>
			<Excel:td colspan="3" align="center" >社区文娱活动室</Excel:td>
			<Excel:td colspan="3" align="center" >残疾人活动室</Excel:td>
			
			<Excel:td  align="center" width = "100" rowspan="2" >投入资金(万元)</Excel:td>
			
			<Excel:td colspan="4" align="center" >资金来源</Excel:td>
			
			<Excel:td  align="center" width = "100" rowspan="2">数量(个)</Excel:td>
			<Excel:td  align="center" width = "100" rowspan="2">面积(m2)</Excel:td>
			<Excel:td  align="center" width = "100" rowspan="2">投入使用年份(年)</Excel:td>
			<Excel:td  align="center" width = "100" rowspan="2">投入资金(万元)</Excel:td>
			
			<Excel:td colspan="4" align="center" >资金来源</Excel:td>
		</Excel:tr>
		<Excel:tr bgcolor="grey">
			
			<Excel:td  align="center" width = "100" >个数(个)</Excel:td>
			<Excel:td  align="center" width = "100" >面积(m2)</Excel:td>
			<Excel:td  align="center" width = "100" >投入使用年份(年)</Excel:td>
			
			<Excel:td  align="center" width = "100" >个数(个)</Excel:td>
			<Excel:td  align="center" width = "100" >面积(m2)</Excel:td>
			<Excel:td  align="center" width = "100" >投入使用年份(年)</Excel:td>
		
			<Excel:td  align="center" width = "100" >个数(个)</Excel:td>
			<Excel:td  align="center" width = "100" >面积(m2</Excel:td>
			<Excel:td  align="center" width = "100" >投入使用年份(年</Excel:td>
		
			<Excel:td  align="center" width = "100" >个数(个)</Excel:td>
			<Excel:td  align="center" width = "100" >面积(m2)</Excel:td>
			<Excel:td  align="center" width = "100" >投入使用年份(年)</Excel:td>
		
			<Excel:td  align="center" width = "100" >个数(个)</Excel:td>
			<Excel:td  align="center" width = "100" >面积(m2)</Excel:td>
			<Excel:td  align="center" width = "100" >投入使用年份(年)</Excel:td>
		
			<Excel:td  align="center" width = "100" >个数(个)</Excel:td>
			<Excel:td  align="center" width = "100" >面积(m2)</Excel:td>
			<Excel:td  align="center" width = "100" >投入使用年份(年)</Excel:td>
			
			
			<Excel:td  align="center" width = "100" >财政拨款(万元)</Excel:td>
			<Excel:td  align="center" width = "100" >自筹(万元)</Excel:td>
			<Excel:td  align="center" width = "100" >社会捐助(万元)</Excel:td>
			<Excel:td  align="center" width = "100" >其他(万元)</Excel:td>
			
			
			<Excel:td  align="center" width = "100" >财政拨款(万元)</Excel:td>
			<Excel:td  align="center" width = "100" >自筹(万元)</Excel:td>
			<Excel:td  align="center" width = "100" >社会捐助(万元)</Excel:td>
			<Excel:td  align="center" width = "100" >其他(万元)</Excel:td>
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
		<Excel:td><%=record.get("offNum")%></Excel:td>
		<Excel:td><%=record.get("offArea")%></Excel:td>
		<Excel:td><%=record.get("offYear")%></Excel:td>
	
		<Excel:td><%=record.get("serviceNum")%></Excel:td>
		<Excel:td><%=record.get("serviceArea")%></Excel:td>
		<Excel:td><%=record.get("serviceYear")%></Excel:td>
		
		<Excel:td><%=record.get("policeNum")%></Excel:td>
		<Excel:td><%=record.get("policeArea")%></Excel:td>
		<Excel:td><%=record.get("policeYear")%></Excel:td>
	
		<Excel:td><%=record.get("clinicNum")%></Excel:td>
		<Excel:td><%=record.get("clinicArea")%></Excel:td>
		<Excel:td><%=record.get("clinicYear")%></Excel:td>
	
		<Excel:td><%=record.get("libNum")%></Excel:td>
		<Excel:td><%=record.get("libArea")%></Excel:td>
		<Excel:td><%=record.get("libYear")%></Excel:td>
	
		<Excel:td><%=record.get("actionNum")%></Excel:td>
		<Excel:td><%=record.get("actionArea")%></Excel:td>
		<Excel:td><%=record.get("actionYear")%></Excel:td>
	
		<Excel:td><%=record.get("handNum")%></Excel:td>
		<Excel:td><%=record.get("handArea")%></Excel:td>
		<Excel:td><%=record.get("handYear")%></Excel:td>
		
		<Excel:td><%=record.get("offMon")%></Excel:td>
		<Excel:td><%=record.get("offFinaceMon")%></Excel:td>
		<Excel:td><%=record.get("offSelfMon")%></Excel:td>
		<Excel:td><%=record.get("offEmdowNum")%></Excel:td>
		<Excel:td><%=record.get("offOtherMon")%></Excel:td>
		
		<Excel:td><%=record.get("outNum")%></Excel:td>
		<Excel:td><%=record.get("outArea")%></Excel:td>
		<Excel:td><%=record.get("outYear")%></Excel:td>
		<Excel:td><%=record.get("outMon")%></Excel:td>
		<Excel:td><%=record.get("outFinanceMon")%></Excel:td>
		<Excel:td><%=record.get("outSelfMon")%></Excel:td>
		<Excel:td><%=record.get("outEnbowMon")%></Excel:td>
		<Excel:td><%=record.get("outOtherMon")%></Excel:td>
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