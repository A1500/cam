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
	String assistanceType= request.getParameter("assistanceType");
	String startTime= request.getParameter("startTime");
	String name1="城市低保人均补差统计表";
	if("02".equals(assistanceType)){
		name1 ="农村低保保障金统计表";
	} else if("03".equals(assistanceType)){
		name1 ="农村五保保障金统计表";
	}
	String name = startTime+name1+"_"+date;
	String username = GetBspInfo.getBspInfo(request).getUserName();
	out.clear();//清空缓存的内容
	out = pageContext.pushBody(); 
%>
</head>
<Excel:tablelist filename="<%=name %>">
	<Excel:table sheetname="<%=name1 %>">
		<Excel:tr>
			<%if("01".equals(assistanceType)){ %>
			<Excel:td colspan="8" align="center" ><Excel:font size="15"  bold="true"><%=startTime+name1 %></Excel:font></Excel:td>
			<%} else{ %>
			<Excel:td colspan="6" align="center" ><Excel:font size="15"  bold="true"><%=startTime+name1 %></Excel:font></Excel:td>
			<%} %>
		</Excel:tr>
		<Excel:tr>
			<%if("01".equals(assistanceType)){ %>
			<Excel:td colspan="4" align="left">统计单位：<%= BspUtil.getOrganName()%></Excel:td>
			<Excel:td colspan="4" align="right">统计时间:<%= startTime%></Excel:td>
			<%} else{ %>
			<Excel:td colspan="3" align="left">统计单位：<%= BspUtil.getOrganName()%></Excel:td>
			<Excel:td colspan="3" align="right">统计时间:<%= startTime%></Excel:td>
			<%} %>
		</Excel:tr>
		<Excel:tr height="30" bgcolor="grey" border="1">
			<Excel:td  align="center" width="100"  bordercolor="black">单位</Excel:td>
			<Excel:td  align="center" width="100"  bordercolor="black">户数</Excel:td>
			<Excel:td  align="center" width="100"  bordercolor="black">人数</Excel:td>
			<Excel:td  align="center" width="100"  bordercolor="black">保障金</Excel:td>
			<Excel:td  align="center" width="100"  bordercolor="black">分类施保金</Excel:td>
			<%if("01".equals(assistanceType)){ %>
			<Excel:td  align="center" width="100"  bordercolor="black">水价补贴</Excel:td>
			<%} %>
			<Excel:td  align="center" width="100"  bordercolor="black">总金额</Excel:td>
			<%if("01".equals(assistanceType)){ %>
			<Excel:td  align="center" width="100"  bordercolor="black">补差</Excel:td>
			<%} %>
		</Excel:tr>
		
		<%
			DataSet ds = (DataSet)request.getAttribute("dataset");
		
		%>
		<Excel:tr border="1">
			<Excel:td align="center">合计</Excel:td>
			<Excel:td align="right"><%=ds.sum("RELEASE_FAMILY_SUM")==null?"0":ds.sum("RELEASE_FAMILY_SUM")%></Excel:td>
			<Excel:td align="right"><%=ds.sum("RELEASE_PEOPLE_SUM")==null?"0":ds.sum("RELEASE_PEOPLE_SUM")%></Excel:td>			
			<Excel:td align="right"><%=ds.sum("ASSISTANCE_MON_SUM")==null?"0":ds.sum("ASSISTANCE_MON_SUM")%></Excel:td>
			<Excel:td align="right"><%=ds.sum("ASSISTANCE_CLASS_MON_SUM")==null?"0":ds.sum("ASSISTANCE_CLASS_MON_SUM")%></Excel:td>
			<%if("01".equals(assistanceType)){ %>
			<Excel:td align="right"><%=ds.sum("WATER_RELEASE_SUM")==null?"0":ds.sum("WATER_RELEASE_SUM")%></Excel:td>
			<%} %>
			<Excel:td align="right"><%=ds.sum("RELEASE_MON_SUM")==null?"0":ds.sum("RELEASE_MON_SUM")%></Excel:td>
			<%if("01".equals(assistanceType)){ %>
			<Excel:td align="right"><%=ds.sum("PEOPLE_AVERAGE")==null?"0":ds.sum("PEOPLE_AVERAGE")%></Excel:td>
			<%} %>			
		</Excel:tr>
		
		<%
				for(int i=0; i<ds.getCount(); i++) {
					Record rec = ds.getRecord(i);
		%>
		<Excel:tr border="1">
			<Excel:td align="center"><%=rec.get("NAME")%></Excel:td>
			<Excel:td align="right"><%=rec.get("RELEASE_FAMILY_SUM")==null?"0":rec.get("RELEASE_FAMILY_SUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("RELEASE_PEOPLE_SUM")==null?"0":rec.get("RELEASE_PEOPLE_SUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("ASSISTANCE_MON_SUM")==null?"0":rec.get("ASSISTANCE_MON_SUM")%></Excel:td>			
			<Excel:td align="right"><%=rec.get("ASSISTANCE_CLASS_MON_SUM")==null?"0":rec.get("ASSISTANCE_CLASS_MON_SUM")%></Excel:td>
			<%if("01".equals(assistanceType)){ %>
			<Excel:td align="right"><%=rec.get("WATER_RELEASE_SUM")==null?"0":rec.get("WATER_RELEASE_SUM")%></Excel:td>
			<%} %>
			<Excel:td align="right"><%=rec.get("RELEASE_MON_SUM")==null?"0":rec.get("RELEASE_MON_SUM")%></Excel:td>
			<%if("01".equals(assistanceType)){ %>
			<Excel:td align="right"><%=rec.get("PEOPLE_AVERAGE")==null?"0":rec.get("PEOPLE_AVERAGE")%></Excel:td>
			<%} %>
			
		</Excel:tr>
		<%
			}
		%>
		<Excel:tr>
			<%if("01".equals(assistanceType)){ %>
			<Excel:td colspan="4" align="left">制表人：<%= username%></Excel:td>
			<Excel:td colspan="4" align="right">制表时间：<%= date2%></Excel:td>
			<%} else{ %>
			<Excel:td colspan="3" align="left">制表人：<%= username%></Excel:td>
			<Excel:td colspan="3" align="right">制表时间：<%= date2%></Excel:td>
			<%} %>
		</Excel:tr>
	</Excel:table>
</Excel:tablelist>

