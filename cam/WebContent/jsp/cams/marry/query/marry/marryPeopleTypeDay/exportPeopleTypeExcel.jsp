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
	String name="结婚登记统计总表(日报表)_"+date;
	String username=GetBspInfo.getBspInfo(request).getUserName();
%>
</head>
<Excel:tablelist filename="<%=name %>">
	<Excel:table sheetname="结婚登记统计总表(日报表)">
		<Excel:tr>
			<Excel:td colspan="13" align="center" ><Excel:font size="15">结婚登记统计总表(日报表)</Excel:font></Excel:td>
		</Excel:tr>
		<Excel:tr>
			<Excel:td colspan="6" align="left">统计单位：<%= BspUtil.getOrganName()%></Excel:td>
			<Excel:td colspan="7" align="right">统计时间:<%=request.getParameter("statisticsTime")%></Excel:td>
		</Excel:tr>
		<Excel:tr height="30" bgcolor="grey" border="1">
			<Excel:td  align="center" width="100" rowspan="3" bordercolor="black">地区</Excel:td>
			<Excel:td  align="center" width="100" rowspan="3" bordercolor="black">结婚登记对数</Excel:td>			
			<Excel:td  align="center" width="100" colspan="11" bordercolor="black">按居住地分类(对)</Excel:td>
		</Excel:tr>
		<Excel:tr height="20" bgcolor="grey" border="1">
			<Excel:td  align="center" bordercolor="black" rowspan="2">内地居民间</Excel:td>
			<Excel:td  align="center" bordercolor="black" >涉</Excel:td>			
			<Excel:td  align="center" bordercolor="black" ></Excel:td>
			<Excel:td  align="center" bordercolor="black" >涉</Excel:td>	
			<Excel:td  align="center" bordercolor="black" ></Excel:td>
			<Excel:td  align="center" bordercolor="black" >涉</Excel:td>	
			<Excel:td  align="center" bordercolor="black" ></Excel:td>
			<Excel:td  align="center" bordercolor="black" >涉</Excel:td>	
			<Excel:td  align="center" bordercolor="black" ></Excel:td>
			<Excel:td  align="center" bordercolor="black" >涉</Excel:td>	
			<Excel:td  align="center" bordercolor="black" ></Excel:td>
		</Excel:tr>
		<Excel:tr height="20" bgcolor="grey" border="1">
			<Excel:td  align="center" bordercolor="black" >外</Excel:td>
			<Excel:td  align="center" bordercolor="black" >内地女性</Excel:td>			
			<Excel:td  align="center" bordercolor="black" >港</Excel:td>
			<Excel:td  align="center" bordercolor="black" >内地女性</Excel:td>	
			<Excel:td  align="center" bordercolor="black" >澳</Excel:td>
			<Excel:td  align="center" bordercolor="black" >内地女性</Excel:td>	
			<Excel:td  align="center" bordercolor="black" >台</Excel:td>
			<Excel:td  align="center" bordercolor="black" >内地女性</Excel:td>	
			<Excel:td  align="center" bordercolor="black" >华侨</Excel:td>
			<Excel:td  align="center" bordercolor="black" >内地女性</Excel:td>	
		</Excel:tr>
		<%
			DataSet ds = (DataSet)request.getAttribute("dataset");
				for(int i=0; i<ds.getCount(); i++) {
					Record rec = ds.getRecord(i);
		%>
		<Excel:tr border="1">
			<Excel:td align="center"><%=rec.get("ITEM_NAME")%></Excel:td>
			<Excel:td align="rihgt"><%=rec.get("MARRY_NUM")%></Excel:td>
			<Excel:td align="rihgt"><%=rec.get("MAINLAND_NUM")%></Excel:td>			
			<Excel:td align="rihgt"><%=rec.get("FOREIGNER_NUM")%></Excel:td>
			<Excel:td align="rihgt"><%=rec.get("FOREIGNER_WOMAN_NUM")%></Excel:td>
			<Excel:td align="rihgt"><%=rec.get("HK_NUM")%></Excel:td>
			<Excel:td align="rihgt"><%=rec.get("HK_WOMAN_NUM")%></Excel:td>
			<Excel:td align="rihgt"><%=rec.get("MO_NUM")%></Excel:td>
			<Excel:td align="rihgt"><%=rec.get("MO_WOMAN_NUM")%></Excel:td>
			<Excel:td align="rihgt"><%=rec.get("TW_NUM")%></Excel:td>
			<Excel:td align="rihgt"><%=rec.get("TW_WOMAN_NUM")%></Excel:td>
			<Excel:td align="rihgt"><%=rec.get("HQ_NUM")%></Excel:td>
			<Excel:td align="rihgt"><%=rec.get("HQ_WOMAN_NUM")%></Excel:td>
		</Excel:tr>
		<%
			}
		%>
		<Excel:tr>
			<Excel:td colspan="6" align="left">制表人：<%= username%></Excel:td>
			<Excel:td colspan="7" align="right">制表时间：<%= date2%></Excel:td>
		</Excel:tr>
	</Excel:table>
</Excel:tablelist>

