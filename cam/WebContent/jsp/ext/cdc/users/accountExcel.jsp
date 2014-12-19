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
	String userName= request.getParameter("userName");
	out.clear();//清空缓存的内容
	out = pageContext.pushBody(); 
%>
</head>
<Excel:tablelist filename="<%=userName %>">
	<Excel:table sheetname="基层政权账号">
		<Excel:tr>
			<Excel:td colspan="2" align="center" ><Excel:font size="15"  bold="true"><%=userName+"账号"%></Excel:font></Excel:td>
		</Excel:tr>
		<Excel:tr>
			<Excel:td colspan="2" align="left">统计单位：<%= userName%></Excel:td>
		</Excel:tr>
		<Excel:tr height="30" bgcolor="grey" border="1">
			<Excel:td  align="center" width="200"  bordercolor="black">社区账号</Excel:td>
			<Excel:td  align="center" width="200"  bordercolor="black">社区名称</Excel:td>			
		</Excel:tr>
		
		<%
			DataSet ds = (DataSet)request.getAttribute("dataset");
				for(int i=0; i<ds.getCount(); i++) {
					Record rec = ds.getRecord(i);
		%>
		<Excel:tr border="1">
			<Excel:td align="right"><%=rec.get("userId")%></Excel:td>			
			<Excel:td align="right"><%=rec.get("userName")%></Excel:td>
		</Excel:tr>
		<%
			}
		%>
		<Excel:tr>
			<Excel:td colspan="1" align="left">制表人：<%= userName%></Excel:td>
			<Excel:td colspan="1" align="right">制表时间：<%= date2%></Excel:td>
		</Excel:tr>
	</Excel:table>
</Excel:tablelist>

