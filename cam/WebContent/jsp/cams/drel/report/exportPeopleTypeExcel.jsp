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
	String startTime=request.getParameter("statisticsTime");
	String date=sdf.format(new Date());
	String date2=sdf2.format(new Date());
	String name=startTime+"城市低保保障情况统计表_"+date;
	String username=GetBspInfo.getBspInfo(request).getUserName();
%>
</head>
<Excel:tablelist filename="<%=name %>">
	<Excel:table sheetname="城市低保保障情况统计表">
		<Excel:tr>
			<Excel:td colspan="16" align="center" ><Excel:font size="15"  bold="true"><%=startTime+"城市低保保障情况统计表" %></Excel:font></Excel:td>
		</Excel:tr>
		<Excel:tr>
			<Excel:td colspan="8" align="left">统计单位：<%= BspUtil.getOrganName()%></Excel:td>
			<Excel:td colspan="8" align="right">统计时间:<%=startTime%></Excel:td>
		</Excel:tr>
		<Excel:tr height="30" bgcolor="grey" border="1">
			<Excel:td  align="center" width="100"  rowspan="2" bordercolor="black">单位</Excel:td>
			<Excel:td  align="center" width="100"  colspan="3" bordercolor="black">中属保障情况</Excel:td>			
			<Excel:td  align="center" width="100"  colspan="3" bordercolor="black">省属保障情况</Excel:td>
			<Excel:td  align="center" width="100"  colspan="3" bordercolor="black">市属保障情况</Excel:td>
			<Excel:td  align="center" width="100"  colspan="3" bordercolor="black">县属保障情况</Excel:td>			
			<Excel:td  align="center" width="100"  colspan="3" bordercolor="black">保障情况合计</Excel:td>
		</Excel:tr>
		<Excel:tr height="20" bgcolor="grey" border="1">
			<Excel:td  align="center" bordercolor="black" >户数</Excel:td>
			<Excel:td  align="center" bordercolor="black" >人数</Excel:td>			
			<Excel:td  align="center" bordercolor="black" >月保障额</Excel:td>
			<Excel:td  align="center" bordercolor="black" >户数</Excel:td>
			<Excel:td  align="center" bordercolor="black" >人数</Excel:td>			
			<Excel:td  align="center" bordercolor="black" >月保障额</Excel:td>
	        <Excel:td  align="center" bordercolor="black" >户数</Excel:td>
			<Excel:td  align="center" bordercolor="black" >人数</Excel:td>			
			<Excel:td  align="center" bordercolor="black" >月保障额</Excel:td>
	        <Excel:td  align="center" bordercolor="black" >户数</Excel:td>
			<Excel:td  align="center" bordercolor="black" >人数</Excel:td>			
			<Excel:td  align="center" bordercolor="black" >月保障额</Excel:td>
		    <Excel:td  align="center" bordercolor="black" >户数</Excel:td>
			<Excel:td  align="center" bordercolor="black" >人数</Excel:td>			
			<Excel:td  align="center" bordercolor="black" >月保障额</Excel:td>
		</Excel:tr>
		<%
			DataSet ds = (DataSet)request.getAttribute("dataset");
		
		%>
		<Excel:tr border="1">
			<Excel:td align="center">合计</Excel:td>
			<Excel:td align="right"><%=ds.sum("CENTRAL_FAMILY_SUM")==null?"0":ds.sum("CENTRAL_FAMILY_SUM")%></Excel:td>			
			<Excel:td align="right"><%=ds.sum("CENTRAL_PEOPLE_SUM")==null?"0":ds.sum("CENTRAL_PEOPLE_SUM")%></Excel:td>
			<Excel:td align="right"><%=ds.sum("CENTRAL_ASSISTANCE_MON")==null?"0":ds.sum("CENTRAL_ASSISTANCE_MON")%></Excel:td>
			<Excel:td align="right"><%=ds.sum("PROVINCE_FAMILY_SUM")==null?"0":ds.sum("PROVINCE_FAMILY_SUM")%></Excel:td>
			<Excel:td align="right"><%=ds.sum("PROVINCE_PEOPLE_SUM")==null?"0":ds.sum("PROVINCE_PEOPLE_SUM")%></Excel:td>
			<Excel:td align="right"><%=ds.sum("PROVINCE_ASSISTANCE_MON")==null?"0":ds.sum("PROVINCE_ASSISTANCE_MON")%></Excel:td>
			<Excel:td align="right"><%=ds.sum("CITY_FAMILY_SUM")==null?"0":ds.sum("CITY_FAMILY_SUM")%></Excel:td>	
			<Excel:td align="right"><%=ds.sum("CITY_PEOPLE_SUM")==null?"0":ds.sum("CITY_PEOPLE_SUM")%></Excel:td>			
			<Excel:td align="right"><%=ds.sum("CITY_ASSISTANCE_MON")==null?"0":ds.sum("CITY_ASSISTANCE_MON")%></Excel:td>
			<Excel:td align="right"><%=ds.sum("COUNTY_FAMILY_SUM")==null?"0":ds.sum("COUNTY_FAMILY_SUM")%></Excel:td>
			<Excel:td align="right"><%=ds.sum("COUNTY_PEOPLE_SUM")==null?"0":ds.sum("COUNTY_PEOPLE_SUM")%></Excel:td>
			<Excel:td align="right"><%=ds.sum("COUNTY_ASSISTANCE_MON")==null?"0":ds.sum("COUNTY_ASSISTANCE_MON")%></Excel:td>
			<Excel:td align="right"><%=ds.sum("RELEASE_FAMILY_SUM")==null?"0":ds.sum("RELEASE_FAMILY_SUM")%></Excel:td>
			<Excel:td align="right"><%=ds.sum("RELEASE_PEOPLE_SUM")==null?"0":ds.sum("RELEASE_PEOPLE_SUM")%></Excel:td>
			<Excel:td align="right"><%=ds.sum("ASSISTANCE_MON_SUM")==null?"0":ds.sum("ASSISTANCE_MON_SUM")%></Excel:td>		
		</Excel:tr>
		
		<%
				for(int i=0; i<ds.getCount(); i++) {
					Record rec = ds.getRecord(i);
		%>
		<Excel:tr border="1">
			<Excel:td align="center"><%=rec.get("RELEASE_AREA_NAME")%></Excel:td>
			<Excel:td align="right"><%=rec.get("CENTRAL_FAMILY_SUM")==null?"0":rec.get("CENTRAL_FAMILY_SUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("CENTRAL_PEOPLE_SUM")==null?"0":rec.get("CENTRAL_PEOPLE_SUM")%></Excel:td>			
			<Excel:td align="right"><%=rec.get("CENTRAL_ASSISTANCE_MON")==null?"0":rec.get("CENTRAL_ASSISTANCE_MON")%></Excel:td>
			<Excel:td align="right"><%=rec.get("PROVINCE_FAMILY_SUM")==null?"0":rec.get("PROVINCE_FAMILY_SUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("PROVINCE_PEOPLE_SUM")==null?"0":rec.get("PROVINCE_PEOPLE_SUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("PROVINCE_ASSISTANCE_MON")==null?"0":rec.get("PROVINCE_ASSISTANCE_MON")%></Excel:td>
			<Excel:td align="right"><%=rec.get("CITY_FAMILY_SUM")==null?"0":rec.get("CITY_FAMILY_SUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("CITY_PEOPLE_SUM")==null?"0":rec.get("CITY_PEOPLE_SUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("CITY_ASSISTANCE_MON")==null?"0":rec.get("CITY_ASSISTANCE_MON")%></Excel:td>
			<Excel:td align="right"><%=rec.get("COUNTY_FAMILY_SUM")==null?"0":rec.get("COUNTY_FAMILY_SUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("COUNTY_PEOPLE_SUM")==null?"0":rec.get("COUNTY_PEOPLE_SUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("COUNTY_ASSISTANCE_MON")==null?"0":rec.get("COUNTY_ASSISTANCE_MON")%></Excel:td>
			<Excel:td align="right"><%=rec.get("RELEASE_FAMILY_SUM")==null?"0":rec.get("RELEASE_FAMILY_SUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("RELEASE_PEOPLE_SUM")==null?"0":rec.get("RELEASE_PEOPLE_SUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("ASSISTANCE_MON_SUM")==null?"0":rec.get("ASSISTANCE_MON_SUM")%></Excel:td>
		</Excel:tr>
		<%
			}
		%>
		<Excel:tr>
			<Excel:td colspan="8" align="left">制表人：<%= username%></Excel:td>
			<Excel:td colspan="8" align="right">制表时间：<%= date2%></Excel:td>
		</Excel:tr>
	</Excel:table>
</Excel:tablelist>

