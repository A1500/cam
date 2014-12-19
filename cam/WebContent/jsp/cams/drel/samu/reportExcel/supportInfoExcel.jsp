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
	String statisticsTime=request.getParameter("statisticsTime");
	String name=statisticsTime+"供养五保对象情况统计表";
	String username = GetBspInfo.getBspInfo(request).getUserName();
	out.clear();//清空缓存的内容
	out = pageContext.pushBody(); 
%>
</head>
<Excel:tablelist filename="<%=name %>">
	<Excel:table sheetname="供养五保对象情况统计表">
		<Excel:tr>
			<Excel:td colspan="7" align="center" ><Excel:font size="15"  bold="true"><%=name %></Excel:font></Excel:td>
		</Excel:tr>
		<Excel:tr>
			<Excel:td colspan="3" align="left">统计单位：<%= BspUtil.getOrganName()%></Excel:td>
			<Excel:td colspan="4" align="right">统计时间:<%=statisticsTime%></Excel:td>
		</Excel:tr>
		<Excel:tr height="30" bgcolor="grey" border="1">
			<Excel:td  align="center" width="100" rowspan="2" bordercolor="black">单位</Excel:td>
			<Excel:td  align="center" width="100" rowspan="2" bordercolor="black">总人数</Excel:td>
			<Excel:td  align="center" width="100" colspan="3" bordercolor="black">年龄</Excel:td>			
			<Excel:td  align="center" width="100" colspan="2" bordercolor="black">性别</Excel:td>
		</Excel:tr>
		<Excel:tr height="20" bgcolor="grey" border="1">	
			<Excel:td  align="center" bordercolor="black" width="100">平均年龄</Excel:td>
			<Excel:td  align="center" bordercolor="black" width="100">最大年龄</Excel:td>
			<Excel:td  align="center" bordercolor="black" width="100">最小年龄</Excel:td>
			<Excel:td  align="center" bordercolor="black" width="100">男</Excel:td>
			<Excel:td  align="center" bordercolor="black" width="100">女</Excel:td>
		</Excel:tr>
		<%
			DataSet ds = (DataSet)request.getAttribute("dataset");
		
		%>
		<Excel:tr border="1">
			<Excel:td align="center">合计</Excel:td>
			<Excel:td align="right"><%=ds.sum("NUM_SUM")==null?"0":ds.sum("NUM_SUM")%></Excel:td>			
			<Excel:td align="right"><%=ds.sum("AVG_AGE")==null?"0":ds.sum("AVG_AGE")%></Excel:td>
			<Excel:td align="right"><%=ds.sum("MAX_AGE")==null?"0":ds.sum("MAX_AGE")%></Excel:td>
			<Excel:td align="right"><%=ds.sum("MIN_AGE")==null?"0":ds.sum("MIN_AGE")%></Excel:td>
			<Excel:td align="right"><%=ds.sum("SEX_MALE")==null?"0":ds.sum("SEX_MALE")%></Excel:td>
			<Excel:td align="right"><%=ds.sum("SEX_FEMALE")==null?"0":ds.sum("SEX_FEMALE")%></Excel:td>				
		</Excel:tr>
		
		<%
				for(int i=0; i<ds.getCount(); i++) {
					Record rec = ds.getRecord(i);
		%>
		<Excel:tr border="1">
			<Excel:td align="center"><%=rec.get("NAME")%></Excel:td>
			<Excel:td align="right"><%=rec.get("NUM_SUM")==null?"0":rec.get("NUM_SUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("AVG_AGE")==null?"0":rec.get("AVG_AGE")%></Excel:td>			
			<Excel:td align="right"><%=rec.get("MAX_AGE")==null?"0":rec.get("MAX_AGE")%></Excel:td>
			<Excel:td align="right"><%=rec.get("MIN_AGE")==null?"0":rec.get("MIN_AGE")%></Excel:td>
			<Excel:td align="right"><%=rec.get("SEX_MALE")==null?"0":rec.get("SEX_MALE")%></Excel:td>
			<Excel:td align="right"><%=rec.get("SEX_FEMALE")==null?"0":rec.get("SEX_FEMALE")%></Excel:td>
		</Excel:tr>
		<%
			}
		%>
		<Excel:tr>
			<Excel:td colspan="3" align="left">制表人：<%= username%></Excel:td>
			<Excel:td colspan="4" align="right">制表时间：<%= date2%></Excel:td>
		</Excel:tr>
	</Excel:table>
</Excel:tablelist>

