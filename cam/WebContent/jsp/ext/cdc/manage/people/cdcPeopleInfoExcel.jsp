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
		<title>人口状况</title>
		<next:ScriptManager/>
	</head>
<Excel:tablelist filename="人口状况">
	<Excel:table sheetname="人口状况">
	<Excel:tr>
			<Excel:td colspan="56" align="center" width = "100" ><Excel:font size="15"  bold="true"><%=organName+"人口状况"%></Excel:font></Excel:td>
		</Excel:tr>
		<Excel:tr>
			<Excel:td colspan="28" align="left">统计单位：<%= organName%></Excel:td>
			<Excel:td colspan="28" align="right">统计时间：<%=date2%></Excel:td>
		</Excel:tr>
		<Excel:tr>
			<Excel:td colspan="24" align="center" >经选举产生的社区村民委员会成员</Excel:td>
			<Excel:td colspan="29" align="center" >其他社区工作者情况</Excel:td>
		</Excel:tr>
		<Excel:tr bgcolor="grey">
			<Excel:td  align="center" width = "100" >单位名称</Excel:td>
			<Excel:td  align="center" width = "100" >总人数</Excel:td>
			<Excel:td  align="center" width = "100">女性人数</Excel:td>
			<Excel:td  align="center" width = "100">30岁以下人数</Excel:td>
			<Excel:td  align="center" width = "100">31~40岁人数</Excel:td>
			<Excel:td  align="center" width = "100">41~50岁人数</Excel:td>
			<Excel:td  align="center" width = "100">50岁以上人数</Excel:td>
			<Excel:td  align="center" width = "100">少数民族人数</Excel:td>
			<Excel:td  align="center" width = "100">党员人数</Excel:td>
			<Excel:td  align="center" width = "100">共青团员人数</Excel:td>
			<Excel:td  align="center" width = "100">其他政治面貌人数</Excel:td>
			<Excel:td  align="center" width = "100">初中及以下人数</Excel:td>
			<Excel:td  align="center" width = "100">高中及中专人数</Excel:td>
			<Excel:td  align="center" width = "100">大学专科人数</Excel:td>
			<Excel:td  align="center" width = "100">大学本科人数</Excel:td>
			<Excel:td  align="center" width = "100">研究生及以上人数</Excel:td>
			<Excel:td  align="center" width = "100">养老保险人数</Excel:td>
			<Excel:td  align="center" width = "100">医疗保险人数</Excel:td>
			<Excel:td  align="center" width = "100">失业保险人数</Excel:td>
			<Excel:td  align="center" width = "100">工伤保险人数</Excel:td>
			<Excel:td  align="center" width = "100">生育保险人数</Excel:td>
			<Excel:td  align="center" width = "100">住房公积金人数</Excel:td>
			<Excel:td  align="center" width = "100">人均月报酬</Excel:td>
			<Excel:td  align="center" width = "100">总人数</Excel:td>
			<Excel:td  align="center" width = "100">女性人数</Excel:td>
			<Excel:td  align="center" width = "100">30岁以下人数</Excel:td>
			<Excel:td  align="center" width = "100">31~40岁人数</Excel:td>
			<Excel:td  align="center" width = "100">41~50岁人数</Excel:td>
			<Excel:td  align="center" width = "100">50岁以上人数</Excel:td>
			<Excel:td  align="center" width = "100">少数民族人数</Excel:td>
			<Excel:td  align="center" width = "100">交叉任职人数</Excel:td>
			<Excel:td  align="center" width = "100">党员人数</Excel:td>
			<Excel:td  align="center" width = "100">共青团员人数</Excel:td>
			<Excel:td  align="center" width = "100">其他政治面貌人数</Excel:td>
			<Excel:td  align="center" width = "100">初中及以下人数</Excel:td>
			<Excel:td  align="center" width = "100">高中及中专人数</Excel:td>
			<Excel:td  align="center" width = "100">大学专科人数</Excel:td>
			<Excel:td  align="center" width = "100">大学本科人数</Excel:td>
			<Excel:td  align="center" width = "100">研究生及以上人数</Excel:td>
			<Excel:td  align="center" width = "100">公务员人数</Excel:td>
			<Excel:td  align="center" width = "100">事业编人数</Excel:td>
			<Excel:td  align="center" width = "100">招聘人数</Excel:td>
			<Excel:td  align="center" width = "100">企业职工人数</Excel:td>
			<Excel:td  align="center" width = "100">社区居民人数</Excel:td>
			<Excel:td  align="center" width = "100">其他身份人数</Excel:td>
			<Excel:td  align="center" width = "100">养老保险人数</Excel:td>
			<Excel:td  align="center" width = "100">医疗保险人数</Excel:td>
			<Excel:td  align="center" width = "100">失业保险人数</Excel:td>
			<Excel:td  align="center" width = "100">工伤保险人数</Excel:td>
			<Excel:td  align="center" width = "100">生育保险人数</Excel:td>
			<Excel:td  align="center" width = "100">住房公积金人数</Excel:td>
			<Excel:td  align="center" width = "100">具备社会工作职业资格人数"</Excel:td>
			<Excel:td  align="center" width = "100">人均月报酬</Excel:td>
			<Excel:td  align="center" width = "100" >填报日期</Excel:td>
			<Excel:td  align="center" width = "100" >填报状态</Excel:td>
			<Excel:td  align="center" width = "100" >上报日期</Excel:td>
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
		<Excel:td><%=record.get("mbPeopleNum")%></Excel:td>
		<Excel:td><%=record.get("mbFemaleNum")%></Excel:td>
		<Excel:td><%=record.get("mbThirtyNum")%></Excel:td>
		<Excel:td><%=record.get("mbFourtyNum")%></Excel:td>
		<Excel:td><%= record.get("mbFiftyNum")%></Excel:td>
		<Excel:td><%= record.get("mbSixtyNum")%></Excel:td>
		<Excel:td><%=record.get("mbFolkNum")%></Excel:td>
		<Excel:td><%=record.get("mbCrossNum")%></Excel:td>
		<Excel:td><%=record.get("mbPartyNum")%></Excel:td>
		<Excel:td><%=record.get("mbLeagueNum")%></Excel:td>
		<Excel:td><%= record.get("mbOtherNum")%></Excel:td>
		<Excel:td><%=record.get("mbJuniorNum")%></Excel:td>
		<Excel:td><%=record.get("mbSeniorNum")%></Excel:td>
		<Excel:td><%=record.get("mbSpecialtyNum")%></Excel:td>
		<Excel:td><%=record.get("mbCollegeNum")%></Excel:td>
		<Excel:td><%= record.get("mbGraduateNum")%></Excel:td>
		<Excel:td><%=record.get("mbAgedInNum")%></Excel:td>
		<Excel:td><%=record.get("mbMedicalInNum")%></Excel:td>
		<Excel:td><%= record.get("mbUnemployInNum")%></Excel:td>
		<Excel:td><%= record.get("mbInjuryInNum")%></Excel:td>
		<Excel:td><%=record.get("mbBirthInNum")%></Excel:td>
		<Excel:td><%= record.get("mbHousingReNum")%></Excel:td>
		<Excel:td><%= record.get("mbSubsidyAvgMon")%></Excel:td>
		<Excel:td><%= record.get("wkPeopleNum")%></Excel:td>
		<Excel:td><%=record.get("wkFemaleNum")%></Excel:td>
		<Excel:td><%= record.get("wkThirtyNum")%></Excel:td>
		<Excel:td><%=record.get("wkFourtyNum")%></Excel:td>
		<Excel:td><%= record.get("wkFiftyNum")%></Excel:td>
		<Excel:td><%=record.get("wkSixtyNum")%></Excel:td>
		<Excel:td><%=record.get("wkFolkNum")%></Excel:td>
		<Excel:td><%=record.get("wkPartyNum")%></Excel:td>
		<Excel:td><%=record.get("wkLeagueNum")%></Excel:td>
		<Excel:td><%= record.get("wkOtherNum")%></Excel:td>
		<Excel:td><%=record.get("wkJuniorNum")%></Excel:td>
		<Excel:td><%=record.get("wkSeniorNum")%></Excel:td>
		<Excel:td><%=record.get("wkSpecialtyNum")%></Excel:td>
		<Excel:td><%=record.get("wkCollegeNum")%></Excel:td>
		<Excel:td><%=record.get("wkGraduateNum")%></Excel:td>
		<Excel:td><%=record.get("wkOfficialNum")%></Excel:td>
		<Excel:td><%=record.get("wkEnterpriseNum")%></Excel:td>
		<Excel:td><%= record.get("wkRequiredNum")%></Excel:td>
		<Excel:td><%= record.get("wkCorporationNum")%></Excel:td>
		<Excel:td><%= record.get("wkResideNum")%></Excel:td>
		<Excel:td><%= record.get("wkProOtherNum")%></Excel:td>
		<Excel:td><%=record.get("wkAgedInNum")%></Excel:td>
		<Excel:td><%= record.get("wkMedicalInNum")%></Excel:td>
		<Excel:td><%= record.get("wkUnemployInNum")%></Excel:td>
		<Excel:td><%= record.get("wkInjuryInNum")%></Excel:td>
		<Excel:td><%=record.get("wkBirthInNum")%></Excel:td>
		<Excel:td><%=record.get("wkHousingReNum")%></Excel:td>
		<Excel:td><%=record.get("wkWorkerNum")%></Excel:td>
		<Excel:td><%= record.get("wkSubsidyAvgMon")%></Excel:td>
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