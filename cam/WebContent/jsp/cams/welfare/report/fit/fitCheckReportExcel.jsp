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
	String name1="假肢和矫形器生产装配企业年检情况统计表";
	String statisticsTime= request.getParameter("statisticsTime");
	String name = statisticsTime+name1+"_"+date;
	String username = GetBspInfo.getBspInfo(request).getUserName();
	out.clear();//清空缓存的内容
	out = pageContext.pushBody(); 
%>
</head>
<Excel:tablelist filename="<%=name %>">
	<Excel:table sheetname="<%=name1 %>">
		<Excel:tr>
			<Excel:td colspan="7" align="center" ><Excel:font size="15"  bold="true"><%=name1 %></Excel:font></Excel:td>
		</Excel:tr>
		<Excel:tr>

			<Excel:td colspan="3" align="left">统计单位：<%= BspUtil.getOrganName()%></Excel:td>
			<Excel:td colspan="4" align="right">统计时间:<%= statisticsTime%></Excel:td>
	
		</Excel:tr>
		<Excel:tr height="30" bgcolor="grey" border="1">
		<Excel:td  align="center" width="100" rowspan="2" bordercolor="black"> 地区</Excel:td>
			<Excel:td  align="center" width="100" rowspan="2" bordercolor="black"> 企业总数</Excel:td>
			<Excel:td  align="center" width="100" colspan="5" bordercolor="black">年检情况</Excel:td>
		</Excel:tr>
		<Excel:tr height="30" bgcolor="grey" border="1">
			<Excel:td  align="center" width="100"  bordercolor="black">已年检数</Excel:td>
			<Excel:td  align="center" width="100"  bordercolor="black">合格数</Excel:td>
			<Excel:td  align="center" width="100"  bordercolor="black">合格率（%）</Excel:td>
			<Excel:td  align="center" width="100"  bordercolor="black">换证数</Excel:td>
			<Excel:td  align="center" width="100"  bordercolor="black">资格注销数</Excel:td>
		</Excel:tr>
		<%
			DataSet ds = (DataSet)request.getAttribute("dataset");
				for(int i=0; i<ds.getCount(); i++) {
					Record rec = ds.getRecord(i);
		%>
		<Excel:tr border="1">
			<Excel:td align="center" ><%=rec.get("NAME")%></Excel:td>
			<Excel:td align="center" ><%=rec.get("FIT_NUM")==null?"0":rec.get("FIT_NUM")%></Excel:td>
			<Excel:td align="center" ><%=rec.get("CHECK_NUM")==null?"0":rec.get("CHECK_NUM")%></Excel:td>	
			<Excel:td align="center" ><%=rec.get("CHECK_PASS_NUM")==null?"0":rec.get("CHECK_PASS_NUM")%></Excel:td>	
			<Excel:td align="center" ><%=rec.get("PERCENT_PASS")==null?"0":rec.get("PERCENT_PASS")%></Excel:td>	
			<Excel:td align="center" ><%=rec.get("CERT_CHANGE_NUM")==null?"0":rec.get("CERT_CHANGE_NUM")%></Excel:td>	
			<Excel:td align="center" ><%=rec.get("CANCEL_NUM")==null?"0":rec.get("CANCEL_NUM")%></Excel:td>	
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

