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
	String name = "街道及以上单位填报任务统计表";
	String username = GetBspInfo.getBspInfo(request).getUserName();
	out.clear();//清空缓存的内容
	out = pageContext.pushBody(); 
%>
</head>
<Excel:tablelist filename="<%=name %>">
	<Excel:table sheetname="街道及以上单位填报任务统计表">
		<Excel:tr>
			<Excel:td colspan="15" align="center" ><Excel:font size="15"  bold="true"><%="街道及以上单位填报任务统计表"%></Excel:font></Excel:td>
		</Excel:tr>
		<Excel:tr>
			<Excel:td colspan="13" align="left">统计单位：<%= BspUtil.getOrganName()%></Excel:td>
			<Excel:td colspan="2" align="right">填报日期:<%= reportDate%></Excel:td>
		</Excel:tr>
		<Excel:tr height="30" bgcolor="grey" border="1">
			<Excel:td  align="center" width="100" rowspan="2" bordercolor="black">单位</Excel:td>
			<Excel:td  align="center" width="100" colspan="2" bordercolor="black">城市社区基础设施</Excel:td>			
			<Excel:td  align="center" width="100" colspan="2" bordercolor="black">城市社区民间组织</Excel:td>
			<Excel:td  align="center" width="100" colspan="2" bordercolor="black">农村社区领导协调组织</Excel:td>
			<Excel:td  align="center" width="100" colspan="2" bordercolor="black">农村社区建设规划</Excel:td>
			<Excel:td  align="center" width="100" colspan="2" bordercolor="black">农村社区经济基本情况</Excel:td>
			<Excel:td  align="center" width="100" colspan="2" bordercolor="black">农村社区服务设施</Excel:td>
			<Excel:td  align="center" width="100" colspan="2" bordercolor="black">农村社区服务情况</Excel:td>
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
		</Excel:tr>
		<%
			DataSet ds = (DataSet)request.getAttribute("dataset");
		
		%>
		<Excel:tr border="1">
			<Excel:td align="center">合计</Excel:td>
			<Excel:td align="right"><%=ds.sum("Y_NUM")==null?"0":ds.sum("Y_NUM")%></Excel:td>			
			<Excel:td align="right"><%=ds.sum("FACILITIES_NUM")==null?"0":ds.sum("FACILITIES_NUM")%></Excel:td>
			<Excel:td align="right"><%=ds.sum("Y_NUM")==null?"0":ds.sum("Y_NUM")%></Excel:td>
			<Excel:td align="right"><%=ds.sum("ORGAN_NUM")==null?"0":ds.sum("ORGAN_NUM")%></Excel:td>
			<Excel:td align="right"><%=ds.sum("Y_NUM")==null?"0":ds.sum("Y_NUM")%></Excel:td>
			<Excel:td align="right"><%=ds.sum("COORDINATE_NUM")==null?"0":ds.sum("COORDINATE_NUM")%></Excel:td>
			<Excel:td align="right"><%=ds.sum("Y_NUM")==null?"0":ds.sum("Y_NUM")%></Excel:td>			
			<Excel:td align="right"><%=ds.sum("PLAN_NUM")==null?"0":ds.sum("PLAN_NUM")%></Excel:td>
			<Excel:td align="right"><%=ds.sum("Y_NUM")==null?"0":ds.sum("Y_NUM")%></Excel:td>
			<Excel:td align="right"><%=ds.sum("FINANCE_NUM")==null?"0":ds.sum("FINANCE_NUM")%></Excel:td>
			<Excel:td align="right"><%=ds.sum("Y_NUM")==null?"0":ds.sum("Y_NUM")%></Excel:td>			
			<Excel:td align="right"><%=ds.sum("SERVICE_NUM")==null?"0":ds.sum("SERVICE_NUM")%></Excel:td>
			<Excel:td align="right"><%=ds.sum("Y_NUM")==null?"0":ds.sum("Y_NUM")%></Excel:td>
			<Excel:td align="right"><%=ds.sum("MODE_NUM")==null?"0":ds.sum("MODE_NUM")%></Excel:td>		
		</Excel:tr>
		
		<%
				for(int i=0; i<ds.getCount(); i++) {
					Record rec = ds.getRecord(i);
		%>
		<Excel:tr border="1">
			<Excel:td align="center"><%=rec.get("USER_NAME")%></Excel:td>
			<Excel:td align="right"><%=rec.get("Y_NUM")==null?"0":rec.get("Y_NUM")%></Excel:td>			
			<Excel:td align="right"><%=rec.get("FACILITIES_NUM")==null?"0":rec.get("FACILITIES_NUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("Y_NUM")==null?"0":rec.get("Y_NUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("ORGAN_NUM")==null?"0":rec.get("ORGAN_NUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("Y_NUM")==null?"0":rec.get("Y_NUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("COORDINATE_NUM")==null?"0":rec.get("COORDINATE_NUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("Y_NUM")==null?"0":rec.get("Y_NUM")%></Excel:td>			
			<Excel:td align="right"><%=rec.get("PLAN_NUM")==null?"0":rec.get("PLAN_NUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("Y_NUM")==null?"0":rec.get("Y_NUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("FINANCE_NUM")==null?"0":rec.get("FINANCE_NUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("Y_NUM")==null?"0":rec.get("Y_NUM")%></Excel:td>			
			<Excel:td align="right"><%=rec.get("SERVICE_NUM")==null?"0":rec.get("SERVICE_NUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("Y_NUM")==null?"0":rec.get("Y_NUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("MODE_NUM")==null?"0":rec.get("MODE_NUM")%></Excel:td>	
		</Excel:tr>
		<%
			}
		%>
		<Excel:tr>
			<Excel:td colspan="13" align="left">制表人：<%= username%></Excel:td>
			<Excel:td colspan="1" align="right">制表时间：<%= date2%></Excel:td>
		</Excel:tr>
	</Excel:table>
</Excel:tablelist>

