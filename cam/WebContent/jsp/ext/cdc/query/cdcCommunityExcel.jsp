<%@ page contentType="charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/tags/next-excel" prefix="Excel"%>
<%@page import="org.loushang.next.data.DataSet"%>
<%@page import="org.loushang.next.data.Record"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<%@ page import="org.loushang.bsp.security.context.GetBspInfo"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.*"%>
<head>
<title>导出Excel</title>
<%
	SimpleDateFormat sdf=new SimpleDateFormat("yyyy年MM月dd日HH时mm分");
	SimpleDateFormat sdf2=new SimpleDateFormat("yyyy年MM月dd日");
	String date=sdf.format(new Date());
	String date2=sdf2.format(new Date());
	String reportDate= request.getParameter("reportDate");
	String name = "社区级填报任务统计表";
	String username = GetBspInfo.getBspInfo(request).getUserName();
	out.clear();//清空缓存的内容
	out = pageContext.pushBody(); 
%>
</head>
<Excel:tablelist filename="<%=name %>">
	<Excel:table sheetname="社区级填报任务统计表">
		<Excel:tr>
			<Excel:td colspan="61" align="center" ><Excel:font size="15"  bold="true"><%="社区级填报任务统计表"%></Excel:font></Excel:td>
		</Excel:tr>
		<Excel:tr>
			<Excel:td colspan="59" align="left">统计单位：<%= BspUtil.getOrganName()%></Excel:td>
			<Excel:td colspan="2" align="right">填报日期:<%= reportDate%></Excel:td>
		</Excel:tr>
		<Excel:tr height="30" bgcolor="grey" border="1">
			<Excel:td  align="center" width="100" rowspan="3" bordercolor="black">单位</Excel:td>
			<Excel:td  align="center" width="100" colspan="4" bordercolor="black">人口状况</Excel:td>			
			<Excel:td  align="center" width="100" colspan="4" bordercolor="black">人员信息</Excel:td>
			<Excel:td  align="center" width="100" colspan="4" bordercolor="black">社区服务</Excel:td>
			<Excel:td  align="center" width="100" colspan="4" bordercolor="black">社区经费</Excel:td>
			<Excel:td  align="center" width="100" colspan="4" bordercolor="black">社区资产</Excel:td>
			<Excel:td  align="center" width="100" colspan="4" bordercolor="black">社区共建</Excel:td>
			<Excel:td  align="center" width="100" colspan="4" bordercolor="black">民主选举</Excel:td>
			<Excel:td  align="center" width="100" colspan="4" bordercolor="black">民主监督</Excel:td>			
			<Excel:td  align="center" width="100" colspan="4" bordercolor="black">民主管理</Excel:td>
			<Excel:td  align="center" width="100" colspan="4" bordercolor="black">民主决策</Excel:td>
			<Excel:td  align="center" width="100" colspan="4" bordercolor="black">社区规划</Excel:td>
			<Excel:td  align="center" width="100" colspan="4" bordercolor="black">社区自然状况</Excel:td>
			<Excel:td  align="center" width="100" colspan="4" bordercolor="black">民间组织</Excel:td>
			<Excel:td  align="center" width="100" colspan="4" bordercolor="black">城市社区物业情况</Excel:td>
			<Excel:td  align="center" width="100" colspan="4" bordercolor="black">基础设施</Excel:td>
		</Excel:tr>
		<Excel:tr height="20" bgcolor="grey" border="1">
			<Excel:td  align="center" bordercolor="black" colspan="2" width="100">城市</Excel:td>
			<Excel:td  align="center" bordercolor="black" colspan="2" width="100">农村</Excel:td>			
			<Excel:td  align="center" bordercolor="black" colspan="2" width="100">城市</Excel:td>
			<Excel:td  align="center" bordercolor="black" colspan="2" width="100">农村</Excel:td>			
			<Excel:td  align="center" bordercolor="black" colspan="2" width="100">城市</Excel:td>
			<Excel:td  align="center" bordercolor="black" colspan="2" width="100">农村</Excel:td>			
			<Excel:td  align="center" bordercolor="black" colspan="2" width="100">城市</Excel:td>
			<Excel:td  align="center" bordercolor="black" colspan="2" width="100">农村</Excel:td>
			<Excel:td  align="center" bordercolor="black" colspan="2" width="100">城市</Excel:td>
			<Excel:td  align="center" bordercolor="black" colspan="2" width="100">农村</Excel:td>			
			<Excel:td  align="center" bordercolor="black" colspan="2" width="100">城市</Excel:td>
			<Excel:td  align="center" bordercolor="black" colspan="2" width="100">农村</Excel:td>			
			<Excel:td  align="center" bordercolor="black" colspan="2" width="100">城市</Excel:td>
			<Excel:td  align="center" bordercolor="black" colspan="2" width="100">农村</Excel:td>
			<Excel:td  align="center" bordercolor="black" colspan="2" width="100">城市</Excel:td>
			<Excel:td  align="center" bordercolor="black" colspan="2" width="100">农村</Excel:td>			
			<Excel:td  align="center" bordercolor="black" colspan="2" width="100">城市</Excel:td>
			<Excel:td  align="center" bordercolor="black" colspan="2" width="100">农村</Excel:td>			
			<Excel:td  align="center" bordercolor="black" colspan="2" width="100">城市</Excel:td>
			<Excel:td  align="center" bordercolor="black" colspan="2" width="100">农村</Excel:td>			
			<Excel:td  align="center" bordercolor="black" colspan="2" width="100">城市</Excel:td>
			<Excel:td  align="center" bordercolor="black" colspan="2" width="100">农村</Excel:td>
			<Excel:td  align="center" bordercolor="black" colspan="2" width="100">城市</Excel:td>
			<Excel:td  align="center" bordercolor="black" colspan="2" width="100">农村</Excel:td>			
			<Excel:td  align="center" bordercolor="black" colspan="2" width="100">城市</Excel:td>
			<Excel:td  align="center" bordercolor="black" colspan="2" width="100">农村</Excel:td>			
			<Excel:td  align="center" bordercolor="black" colspan="2" width="100">城市</Excel:td>
			<Excel:td  align="center" bordercolor="black" colspan="2" width="100">农村</Excel:td>
			<Excel:td  align="center" bordercolor="black" colspan="2" width="100">城市</Excel:td>
			<Excel:td  align="center" bordercolor="black" colspan="2" width="100">农村</Excel:td>			
		</Excel:tr>
		<Excel:tr height="20" bgcolor="grey" border="1">
			<Excel:td  align="center" bordercolor="black" width="100">应填报</Excel:td>
			<Excel:td  align="center" bordercolor="black" width="100">已填报</Excel:td>			
			<Excel:td  align="center" bordercolor="black" width="100">应填报</Excel:td>
			<Excel:td  align="center" bordercolor="black" width="100">已填报</Excel:td>			
			<Excel:td  align="center" bordercolor="black" width="100">应填报</Excel:td>
			<Excel:td  align="center" bordercolor="black" width="100">已填报</Excel:td>			
			<Excel:td  align="center" bordercolor="black" width="100">应填报</Excel:td>
			<Excel:td  align="center" bordercolor="black" width="100">已填报</Excel:td>
			<Excel:td  align="center" bordercolor="black" width="100">应填报</Excel:td>
			<Excel:td  align="center" bordercolor="black" width="100">已填报</Excel:td>			
			<Excel:td  align="center" bordercolor="black" width="100">应填报</Excel:td>
			<Excel:td  align="center" bordercolor="black" width="100">已填报</Excel:td>			
			<Excel:td  align="center" bordercolor="black" width="100">应填报</Excel:td>
			<Excel:td  align="center" bordercolor="black" width="100">已填报</Excel:td>
			<Excel:td  align="center" bordercolor="black" width="100">应填报</Excel:td>
			<Excel:td  align="center" bordercolor="black" width="100">已填报</Excel:td>			
			<Excel:td  align="center" bordercolor="black" width="100">应填报</Excel:td>
			<Excel:td  align="center" bordercolor="black" width="100">已填报</Excel:td>			
			<Excel:td  align="center" bordercolor="black" width="100">应填报</Excel:td>
			<Excel:td  align="center" bordercolor="black" width="100">已填报</Excel:td>			
			<Excel:td  align="center" bordercolor="black" width="100">应填报</Excel:td>
			<Excel:td  align="center" bordercolor="black" width="100">已填报</Excel:td>
			<Excel:td  align="center" bordercolor="black" width="100">应填报</Excel:td>
			<Excel:td  align="center" bordercolor="black" width="100">已填报</Excel:td>			
			<Excel:td  align="center" bordercolor="black" width="100">应填报</Excel:td>
			<Excel:td  align="center" bordercolor="black" width="100">已填报</Excel:td>			
			<Excel:td  align="center" bordercolor="black" width="100">应填报</Excel:td>
			<Excel:td  align="center" bordercolor="black" width="100">已填报</Excel:td>
			<Excel:td  align="center" bordercolor="black" width="100">应填报</Excel:td>
			<Excel:td  align="center" bordercolor="black" width="100">已填报</Excel:td>
			<Excel:td  align="center" bordercolor="black" width="100">应填报</Excel:td>
			<Excel:td  align="center" bordercolor="black" width="100">已填报</Excel:td>			
			<Excel:td  align="center" bordercolor="black" width="100">应填报</Excel:td>
			<Excel:td  align="center" bordercolor="black" width="100">已填报</Excel:td>			
			<Excel:td  align="center" bordercolor="black" width="100">应填报</Excel:td>
			<Excel:td  align="center" bordercolor="black" width="100">已填报</Excel:td>			
			<Excel:td  align="center" bordercolor="black" width="100">应填报</Excel:td>
			<Excel:td  align="center" bordercolor="black" width="100">已填报</Excel:td>
			<Excel:td  align="center" bordercolor="black" width="100">应填报</Excel:td>
			<Excel:td  align="center" bordercolor="black" width="100">已填报</Excel:td>			
			<Excel:td  align="center" bordercolor="black" width="100">应填报</Excel:td>
			<Excel:td  align="center" bordercolor="black" width="100">已填报</Excel:td>			
			<Excel:td  align="center" bordercolor="black" width="100">应填报</Excel:td>
			<Excel:td  align="center" bordercolor="black" width="100">已填报</Excel:td>
			<Excel:td  align="center" bordercolor="black" width="100">应填报</Excel:td>
			<Excel:td  align="center" bordercolor="black" width="100">已填报</Excel:td>			
			<Excel:td  align="center" bordercolor="black" width="100">应填报</Excel:td>
			<Excel:td  align="center" bordercolor="black" width="100">已填报</Excel:td>			
			<Excel:td  align="center" bordercolor="black" width="100">应填报</Excel:td>
			<Excel:td  align="center" bordercolor="black" width="100">已填报</Excel:td>			
			<Excel:td  align="center" bordercolor="black" width="100">应填报</Excel:td>
			<Excel:td  align="center" bordercolor="black" width="100">已填报</Excel:td>
			<Excel:td  align="center" bordercolor="black" width="100">应填报</Excel:td>
			<Excel:td  align="center" bordercolor="black" width="100">已填报</Excel:td>			
			<Excel:td  align="center" bordercolor="black" width="100">应填报</Excel:td>
			<Excel:td  align="center" bordercolor="black" width="100">已填报</Excel:td>			
			<Excel:td  align="center" bordercolor="black" width="100">应填报</Excel:td>
			<Excel:td  align="center" bordercolor="black" width="100">已填报</Excel:td>
			<Excel:td  align="center" bordercolor="black" width="100">应填报</Excel:td>
			<Excel:td  align="center" bordercolor="black" width="100">已填报</Excel:td>			
		</Excel:tr>
		<%
			DataSet ds = (DataSet)request.getAttribute("dataset");
		
		%>
		<Excel:tr border="1">
			<Excel:td align="center">合计</Excel:td>
			<Excel:td align="right"><%=ds.sum("C_NUM")==null?"0":ds.sum("C_NUM")%></Excel:td>			
			<Excel:td align="right"><%=ds.sum("Y_POPULATE_NUM")==null?"0":ds.sum("Y_POPULATE_NUM")%></Excel:td>
			<Excel:td align="right"><%=ds.sum("N_NUM")==null?"0":ds.sum("N_NUM")%></Excel:td>
			<Excel:td align="right"><%=ds.sum("Y_POP_NUM")==null?"0":ds.sum("Y_POP_NUM")%></Excel:td>
			<Excel:td align="right"><%=ds.sum("C_NUM")==null?"0":ds.sum("C_NUM")%></Excel:td>
			<Excel:td align="right"><%=ds.sum("Y_PEOPLE_NUM")==null?"0":ds.sum("Y_PEOPLE_NUM")%></Excel:td>
			<Excel:td align="right"><%=ds.sum("N_NUM")==null?"0":ds.sum("N_NUM")%></Excel:td>			
			<Excel:td align="right"><%=ds.sum("Y_PEO_NUM")==null?"0":ds.sum("Y_POP_NUM")%></Excel:td>
			<Excel:td align="right"><%=ds.sum("C_NUM")==null?"0":ds.sum("C_NUM")%></Excel:td>
			<Excel:td align="right"><%=ds.sum("Y_SERVICE_NUM")==null?"0":ds.sum("Y_SERVICE_NUM")%></Excel:td>
			<Excel:td align="right"><%=ds.sum("N_NUM")==null?"0":ds.sum("N_NUM")%></Excel:td>			
			<Excel:td align="right"><%=ds.sum("Y_SER_NUM")==null?"0":ds.sum("Y_SER_NUM")%></Excel:td>
			<Excel:td align="right"><%=ds.sum("C_NUM")==null?"0":ds.sum("C_NUM")%></Excel:td>
			<Excel:td align="right"><%=ds.sum("Y_FUND_NUM")==null?"0":ds.sum("Y_FUND_NUM")%></Excel:td>
			<Excel:td align="right"><%=ds.sum("N_NUM")==null?"0":ds.sum("N_NUM")%></Excel:td>
			<Excel:td align="right"><%=ds.sum("Y_FUN_NUM")==null?"0":ds.sum("Y_FUN_NUM")%></Excel:td>
			<Excel:td align="right"><%=ds.sum("C_NUM")==null?"0":ds.sum("C_NUM")%></Excel:td>			
			<Excel:td align="right"><%=ds.sum("Y_ECONOMY_NUM")==null?"0":ds.sum("Y_ECONOMY_NUM")%></Excel:td>
			<Excel:td align="right"><%=ds.sum("N_NUM")==null?"0":ds.sum("N_NUM")%></Excel:td>
			<Excel:td align="right"><%=ds.sum("Y_ECO_NUM")==null?"0":ds.sum("Y_ECO_NUM")%></Excel:td>
			<Excel:td align="right"><%=ds.sum("C_NUM")==null?"0":ds.sum("C_NUM")%></Excel:td>			
			<Excel:td align="right"><%=ds.sum("Y_ORGAN_NUM")==null?"0":ds.sum("Y_ORGAN_NUM")%></Excel:td>
			<Excel:td align="right"><%=ds.sum("N_NUM")==null?"0":ds.sum("N_NUM")%></Excel:td>
			<Excel:td align="right"><%=ds.sum("Y_ORG_NUM")==null?"0":ds.sum("Y_ORG_NUM")%></Excel:td>
			<Excel:td align="right"><%=ds.sum("C_NUM")==null?"0":ds.sum("C_NUM")%></Excel:td>
			<Excel:td align="right"><%=ds.sum("Y_ELECTION_NUM")==null?"0":ds.sum("Y_ELECTION_NUM")%></Excel:td>
			<Excel:td align="right"><%=ds.sum("N_NUM")==null?"0":ds.sum("N_NUM")%></Excel:td>			
			<Excel:td align="right"><%=ds.sum("Y_ELE_NUM")==null?"0":ds.sum("Y_ELE_NUM")%></Excel:td>
			<Excel:td align="right"><%=ds.sum("C_NUM")==null?"0":ds.sum("C_NUM")%></Excel:td>
			<Excel:td align="right"><%=ds.sum("Y_DECISION_NUM")==null?"0":ds.sum("Y_DECISION_NUM")%></Excel:td>
			<Excel:td align="right"><%=ds.sum("N_NUM")==null?"0":ds.sum("N_NUM")%></Excel:td>
			<Excel:td align="right"><%=ds.sum("Y_DEC_NUM")==null?"0":ds.sum("Y_DEC_NUM")%></Excel:td>
			<Excel:td align="right"><%=ds.sum("C_NUM")==null?"0":ds.sum("C_NUM")%></Excel:td>			
			<Excel:td align="right"><%=ds.sum("Y_MANAGE_NUM")==null?"0":ds.sum("Y_MANAGE_NUM")%></Excel:td>
			<Excel:td align="right"><%=ds.sum("N_NUM")==null?"0":ds.sum("N_NUM")%></Excel:td>
			<Excel:td align="right"><%=ds.sum("Y_MAN_NUM")==null?"0":ds.sum("Y_MAN_NUM")%></Excel:td>
			<Excel:td align="right"><%=ds.sum("C_NUM")==null?"0":ds.sum("C_NUM")%></Excel:td>			
			<Excel:td align="right"><%=ds.sum("Y_SUPERVISE_NUM")==null?"0":ds.sum("Y_SUPERVISE_NUM")%></Excel:td>
			<Excel:td align="right"><%=ds.sum("N_NUM")==null?"0":ds.sum("N_NUM")%></Excel:td>
			<Excel:td align="right"><%=ds.sum("Y_SUP_NUM")==null?"0":ds.sum("Y_SUP_NUM")%></Excel:td>
			<Excel:td align="right"><%=ds.sum("C_NUM")==null?"0":ds.sum("C_NUM")%></Excel:td>			
			<Excel:td align="right"><%=ds.sum("Y_CONSTRUCT_NUM")==null?"0":ds.sum("Y_CONSTRUCT_NUM")%></Excel:td>
			<Excel:td align="right"><%=ds.sum("N_NUM")==null?"0":ds.sum("N_NUM")%></Excel:td>
			<Excel:td align="right"><%=ds.sum("Y_CON_NUM")==null?"0":ds.sum("Y_CON_NUM")%></Excel:td>
			<Excel:td align="right"><%=ds.sum("C_NUM")==null?"0":ds.sum("C_NUM")%></Excel:td>
			<Excel:td align="right"><%=ds.sum("Y_NATURE_NUM")==null?"0":ds.sum("Y_NATURE_NUM")%></Excel:td>
			<Excel:td align="right"><%=ds.sum("N_NUM")==null?"0":ds.sum("N_NUM")%></Excel:td>			
			<Excel:td align="right"><%=ds.sum("Y_NAT_NUM")==null?"0":ds.sum("Y_NAT_NUM")%></Excel:td>
			<Excel:td align="right"><%=ds.sum("C_NUM")==null?"0":ds.sum("C_NUM")%></Excel:td>
			<Excel:td align="right"><%=ds.sum("Y_ORGAN2_NUM")==null?"0":ds.sum("Y_ORGAN2_NUM")%></Excel:td>
			<Excel:td align="right"><%=ds.sum("N_NUM")==null?"0":ds.sum("N_NUM")%></Excel:td>			
			<Excel:td align="right"><%=ds.sum("Y_ORG2_NUM")==null?"0":ds.sum("Y_ORG2_NUM")%></Excel:td>
			<Excel:td align="right"><%=ds.sum("C_NUM")==null?"0":ds.sum("C_NUM")%></Excel:td>
			<Excel:td align="right"><%=ds.sum("Y_TENEMENT_NUM")==null?"0":ds.sum("Y_TENEMENT_NUM")%></Excel:td>
			<Excel:td align="right"><%=ds.sum("N_NUM")==null?"0":ds.sum("N_NUM")%></Excel:td>
			<Excel:td align="right"><%=ds.sum("Y_TEN_NUM")==null?"0":ds.sum("Y_TEN_NUM")%></Excel:td>	
			<Excel:td align="right"><%=ds.sum("C_NUM")==null?"0":ds.sum("C_NUM")%></Excel:td>
			<Excel:td align="right"><%=ds.sum("Y_FACILITIES_NUM")==null?"0":ds.sum("Y_FACILITIES_NUM")%></Excel:td>
			<Excel:td align="right"><%=ds.sum("N_NUM")==null?"0":ds.sum("N_NUM")%></Excel:td>
			<Excel:td align="right"><%=ds.sum("Y_FAC_NUM")==null?"0":ds.sum("Y_FAC_NUM")%></Excel:td>							
		</Excel:tr>
		
		<%
				for(int i=0; i<ds.getCount(); i++) {
					Record rec = ds.getRecord(i);
		%>
		<Excel:tr border="1">
			<Excel:td align="center"><%=rec.get("USER_NAME")%></Excel:td>
			<Excel:td align="right"><%=rec.get("C_NUM")==null?"0":rec.get("C_NUM")%></Excel:td>			
			<Excel:td align="right"><%=rec.get("Y_POPULATE_NUM")==null?"0":rec.get("Y_POPULATE_NUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("N_NUM")==null?"0":rec.get("N_NUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("Y_POP_NUM")==null?"0":rec.get("Y_POP_NUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("C_NUM")==null?"0":rec.get("C_NUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("Y_PEOPLE_NUM")==null?"0":rec.get("Y_PEOPLE_NUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("N_NUM")==null?"0":rec.get("N_NUM")%></Excel:td>			
			<Excel:td align="right"><%=rec.get("Y_PEO_NUM")==null?"0":rec.get("Y_POP_NUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("C_NUM")==null?"0":rec.get("C_NUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("Y_SERVICE_NUM")==null?"0":rec.get("Y_SERVICE_NUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("N_NUM")==null?"0":rec.get("N_NUM")%></Excel:td>			
			<Excel:td align="right"><%=rec.get("Y_SER_NUM")==null?"0":rec.get("Y_SER_NUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("C_NUM")==null?"0":rec.get("C_NUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("Y_FUND_NUM")==null?"0":rec.get("Y_FUND_NUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("N_NUM")==null?"0":rec.get("N_NUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("Y_FUN_NUM")==null?"0":rec.get("Y_FUN_NUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("C_NUM")==null?"0":rec.get("C_NUM")%></Excel:td>			
			<Excel:td align="right"><%=rec.get("Y_ECONOMY_NUM")==null?"0":rec.get("Y_ECONOMY_NUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("N_NUM")==null?"0":rec.get("N_NUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("Y_ECO_NUM")==null?"0":rec.get("Y_ECO_NUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("C_NUM")==null?"0":rec.get("C_NUM")%></Excel:td>			
			<Excel:td align="right"><%=rec.get("Y_ORGAN_NUM")==null?"0":rec.get("Y_ORGAN_NUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("N_NUM")==null?"0":rec.get("N_NUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("Y_ORG_NUM")==null?"0":rec.get("Y_ORG_NUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("C_NUM")==null?"0":rec.get("C_NUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("Y_ELECTION_NUM")==null?"0":rec.get("Y_ELECTION_NUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("N_NUM")==null?"0":rec.get("N_NUM")%></Excel:td>			
			<Excel:td align="right"><%=rec.get("Y_ELE_NUM")==null?"0":rec.get("Y_ELE_NUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("C_NUM")==null?"0":rec.get("C_NUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("Y_DECISION_NUM")==null?"0":rec.get("Y_DECISION_NUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("N_NUM")==null?"0":rec.get("N_NUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("Y_DEC_NUM")==null?"0":rec.get("Y_DEC_NUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("C_NUM")==null?"0":rec.get("C_NUM")%></Excel:td>			
			<Excel:td align="right"><%=rec.get("Y_MANAGE_NUM")==null?"0":rec.get("Y_MANAGE_NUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("N_NUM")==null?"0":rec.get("N_NUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("Y_MAN_NUM")==null?"0":rec.get("Y_MAN_NUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("C_NUM")==null?"0":rec.get("C_NUM")%></Excel:td>			
			<Excel:td align="right"><%=rec.get("Y_SUPERVISE_NUM")==null?"0":rec.get("Y_SUPERVISE_NUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("N_NUM")==null?"0":rec.get("N_NUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("Y_SUP_NUM")==null?"0":rec.get("Y_SUP_NUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("C_NUM")==null?"0":rec.get("C_NUM")%></Excel:td>			
			<Excel:td align="right"><%=rec.get("Y_CONSTRUCT_NUM")==null?"0":rec.get("Y_CONSTRUCT_NUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("N_NUM")==null?"0":rec.get("N_NUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("Y_CON_NUM")==null?"0":rec.get("Y_CON_NUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("C_NUM")==null?"0":rec.get("C_NUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("Y_NATURE_NUM")==null?"0":rec.get("Y_NATURE_NUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("N_NUM")==null?"0":rec.get("N_NUM")%></Excel:td>			
			<Excel:td align="right"><%=rec.get("Y_NAT_NUM")==null?"0":rec.get("Y_NAT_NUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("C_NUM")==null?"0":rec.get("C_NUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("Y_ORGAN2_NUM")==null?"0":rec.get("Y_ORGAN2_NUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("N_NUM")==null?"0":rec.get("N_NUM")%></Excel:td>			
			<Excel:td align="right"><%=rec.get("Y_ORG2_NUM")==null?"0":rec.get("Y_ORG2_NUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("C_NUM")==null?"0":rec.get("C_NUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("Y_TENEMENT_NUM")==null?"0":rec.get("Y_TENEMENT_NUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("N_NUM")==null?"0":rec.get("N_NUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("Y_TEN_NUM")==null?"0":rec.get("Y_TEN_NUM")%></Excel:td>	
			<Excel:td align="right"><%=rec.get("C_NUM")==null?"0":rec.get("C_NUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("Y_FACILITIES_NUM")==null?"0":rec.get("Y_FACILITIES_NUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("N_NUM")==null?"0":rec.get("N_NUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("Y_FAC_NUM")==null?"0":rec.get("Y_FAC_NUM")%></Excel:td>	
		</Excel:tr>
		<%
			}
		%>
		<Excel:tr>
			<Excel:td colspan="59" align="left">制表人：<%= username%></Excel:td>
			<Excel:td colspan="2" align="right">制表时间：<%= date2%></Excel:td>
		</Excel:tr>
	</Excel:table>
</Excel:tablelist>

