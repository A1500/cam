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
	String username = GetBspInfo.getBspInfo(request).getUserName();
	out.clear();//清空缓存的内容
	out = pageContext.pushBody(); 
%>
</head>
<Excel:tablelist filename="省直单位特殊困难户统计">
	<Excel:table sheetname="省直单位特殊困难户统计">
		<Excel:tr>
			<Excel:td colspan="4" align="center" ><Excel:font size="15"  bold="true">省直单位特殊困难户统计</Excel:font></Excel:td>
		</Excel:tr>
		<Excel:tr>

			<Excel:td colspan="4" align="left">统计单位：<%= BspUtil.getOrganName()%></Excel:td>
		</Excel:tr>
		<Excel:tr height="30" bgcolor="grey" border="1">
			<Excel:td  align="center" width="100" bordercolor="black">序号</Excel:td>
			<Excel:td  align="center" width="300"  bordercolor="black">省直单位名称</Excel:td>
			<Excel:td  align="center" width="100"   bordercolor="black">户数（户）</Excel:td>
			<Excel:td  align="center" width="100"  bordercolor="black">人数（人）</Excel:td>
		</Excel:tr>
		<%
			DataSet ds = (DataSet)request.getAttribute("dataset");
		
		%>
		<Excel:tr border="1">
			<Excel:td align="center">合计</Excel:td>

			<Excel:td align="right"><%=ds.getCount()%></Excel:td>			
			<Excel:td align="right"><%=ds.sum("FAMILY_SUM")==null?"0":ds.sum("FAMILY_SUM")%></Excel:td>
			<Excel:td align="right"><%=ds.sum("PEOPLE_NUM")==null?"0":ds.sum("PEOPLE_NUM")%></Excel:td>
		</Excel:tr>
		
		<%
				for(int i=0; i<ds.getCount(); i++) {
					Record rec = ds.getRecord(i);
		%>
		<Excel:tr border="1">
			<Excel:td align="center"><%=i+1%></Excel:td>
			<Excel:td align="right"><%=rec.get("SUPPORT_UNIT_NAME")==null?"0":rec.get("SUPPORT_UNIT_NAME")%></Excel:td>			
			<Excel:td align="right"><%=rec.get("FAMILY_SUM")==null?"0":rec.get("FAMILY_SUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("PEOPLE_NUM")==null?"0":rec.get("PEOPLE_NUM")%></Excel:td>
		</Excel:tr>
		<%
			}
		%>
		<Excel:tr>
			<Excel:td colspan="2" align="left">制表人：<%= username%></Excel:td>
			<Excel:td colspan="2" align="right">制表时间：<%= date2%></Excel:td>
		</Excel:tr>
	</Excel:table>
</Excel:tablelist>

