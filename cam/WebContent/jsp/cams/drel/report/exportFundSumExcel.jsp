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
	String startTime= request.getParameter("startTime");
	String name = startTime+"城市低保保障金及分类施保金统计表_"+date;
	String username = GetBspInfo.getBspInfo(request).getUserName();
	out.clear();//清空缓存的内容
	out = pageContext.pushBody(); 
%>
</head>
<Excel:tablelist filename="<%=name %>">
	<Excel:table sheetname="城市低保保障金及分类施保金统计表">
		<Excel:tr>
			<Excel:td colspan="12" align="center" ><Excel:font size="15"  bold="true"><%=startTime+"城市低保保障金及分类施保金统计表" %></Excel:font></Excel:td>
		</Excel:tr>
		<Excel:tr>
			<Excel:td colspan="6" align="left">统计单位：<%= BspUtil.getOrganName()%></Excel:td>
			<Excel:td colspan="6" align="right">统计时间:<%= startTime%></Excel:td>
		</Excel:tr>
		<Excel:tr height="30" bgcolor="grey" border="1">
			<Excel:td  align="center" width="100" rowspan="2" bordercolor="black">单位</Excel:td>
			<Excel:td  align="center" width="100" colspan="4" bordercolor="black">低保金额</Excel:td>			
			<Excel:td  align="center" width="100" colspan="4" bordercolor="black">分类施保</Excel:td>
			<Excel:td  align="center" width="100" colspan="2" bordercolor="black">低保金+分类施保</Excel:td>
			<Excel:td  align="center" width="100" rowspan="2" bordercolor="black">总计</Excel:td>
		</Excel:tr>
		<Excel:tr height="20" bgcolor="grey" border="1">
			<Excel:td  align="center" bordercolor="black" width="100">中央</Excel:td>
			<Excel:td  align="center" bordercolor="black" width="100">省级</Excel:td>			
			<Excel:td  align="center" bordercolor="black" width="100">市级</Excel:td>
			<Excel:td  align="center" bordercolor="black" width="100">区级</Excel:td>			
			<Excel:td  align="center" bordercolor="black" width="100">中央</Excel:td>
			<Excel:td  align="center" bordercolor="black" width="100">省级</Excel:td>			
			<Excel:td  align="center" bordercolor="black" width="100">市级</Excel:td>
			<Excel:td  align="center" bordercolor="black" width="100">区级</Excel:td>	
			<Excel:td  align="center" bordercolor="black" width="100">低保金</Excel:td>
			<Excel:td  align="center" bordercolor="black" width="100">分类施保</Excel:td>		
		</Excel:tr>
		<%
			DataSet ds = (DataSet)request.getAttribute("dataset");
		
		%>
		<Excel:tr border="1">
			<Excel:td align="center">合计</Excel:td>
			<Excel:td align="right"><%=ds.sum("CENTRAL_ASSISTANCE_MON")==null?"0":ds.sum("CENTRAL_ASSISTANCE_MON")%></Excel:td>			
			<Excel:td align="right"><%=ds.sum("PROVINCE_ASSISTANCE_MON")==null?"0":ds.sum("PROVINCE_ASSISTANCE_MON")%></Excel:td>
			<Excel:td align="right"><%=ds.sum("CITY_ASSISTANCE_MON")==null?"0":ds.sum("CITY_ASSISTANCE_MON")%></Excel:td>
			<Excel:td align="right"><%=ds.sum("COUNTY_FAMILY_SUM")==null?"0":ds.sum("COUNTY_FAMILY_SUM")%></Excel:td>
			<Excel:td align="right"><%=ds.sum("CENTRAL_CLASS_MON")==null?"0":ds.sum("CENTRAL_CLASS_MON")%></Excel:td>
			<Excel:td align="right"><%=ds.sum("PROVINCE_CLASS_MON")==null?"0":ds.sum("PROVINCE_CLASS_MON")%></Excel:td>
			<Excel:td align="right"><%=ds.sum("CITY_CLASS_MON")==null?"0":ds.sum("CITY_CLASS_MON")%></Excel:td>	
			<Excel:td align="right"><%=ds.sum("COUNTY_CLASS_MON")==null?"0":ds.sum("COUNTY_CLASS_MON")%></Excel:td>
			<Excel:td align="right"><%=ds.sum("ASSISTANCE_MON_SUM")==null?"0":ds.sum("ASSISTANCE_MON_SUM")%></Excel:td>
			<Excel:td align="right"><%=ds.sum("ASSISTANCE_CLASS_MON_SUM")==null?"0":ds.sum("ASSISTANCE_CLASS_MON_SUM")%></Excel:td>
			<Excel:td align="right"><%=ds.sum("RELEASE_MON_SUM")==null?"0":ds.sum("RELEASE_MON_SUM")%></Excel:td>		
		</Excel:tr>
		
		<%
				for(int i=0; i<ds.getCount(); i++) {
					Record rec = ds.getRecord(i);
		%>
		<Excel:tr border="1">
			<Excel:td align="center"><%=rec.get("NAME")%></Excel:td>
			<Excel:td align="right"><%=rec.get("CENTRAL_ASSISTANCE_MON")==null?"0":rec.get("CENTRAL_ASSISTANCE_MON")%></Excel:td>
			<Excel:td align="right"><%=rec.get("PROVINCE_ASSISTANCE_MON")==null?"0":rec.get("PROVINCE_ASSISTANCE_MON")%></Excel:td>			
			<Excel:td align="right"><%=rec.get("CITY_ASSISTANCE_MON")==null?"0":rec.get("CITY_ASSISTANCE_MON")%></Excel:td>
			<Excel:td align="right"><%=rec.get("COUNTY_FAMILY_SUM")==null?"0":rec.get("COUNTY_FAMILY_SUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("CENTRAL_CLASS_MON")==null?"0":rec.get("CENTRAL_CLASS_MON")%></Excel:td>
			<Excel:td align="right"><%=rec.get("PROVINCE_CLASS_MON")==null?"0":rec.get("PROVINCE_CLASS_MON")%></Excel:td>
			<Excel:td align="right"><%=rec.get("CITY_CLASS_MON")==null?"0":rec.get("CITY_CLASS_MON")%></Excel:td>
			<Excel:td align="right"><%=rec.get("COUNTY_CLASS_MON")==null?"0":rec.get("COUNTY_CLASS_MON")%></Excel:td>
			<Excel:td align="right"><%=rec.get("ASSISTANCE_MON_SUM")==null?"0":rec.get("ASSISTANCE_MON_SUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("ASSISTANCE_CLASS_MON_SUM")==null?"0":rec.get("ASSISTANCE_CLASS_MON_SUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("RELEASE_MON_SUM")==null?"0":rec.get("RELEASE_MON_SUM")%></Excel:td>
		</Excel:tr>
		<%
			}
		%>
		<Excel:tr>
			<Excel:td colspan="6" align="left">制表人：<%= username%></Excel:td>
			<Excel:td colspan="6" align="right">制表时间：<%= date2%></Excel:td>
		</Excel:tr>
	</Excel:table>
</Excel:tablelist>

