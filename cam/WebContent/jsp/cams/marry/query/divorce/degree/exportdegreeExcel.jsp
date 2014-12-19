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
	String name="离婚登记当事人文化程度状况统计表_"+date;
	String username=GetBspInfo.getBspInfo(request).getUserName();
%>
</head>
<Excel:tablelist filename="<%=name %>">
	<Excel:table sheetname="离婚登记当事人文化程度状况统计表">
		<Excel:tr>
			<Excel:td colspan="16" align="center" ><Excel:font size="15">离婚登记当事人文化程度状况统计表</Excel:font></Excel:td>
		</Excel:tr>
		<Excel:tr>
			<Excel:td colspan="8" align="left">统计单位：<%= BspUtil.getOrganName()%></Excel:td>
			<Excel:td colspan="8" align="right">统计时间:<%=request.getParameter("statisticsTime")%></Excel:td>
		</Excel:tr>
		<Excel:tr height="30" bgcolor="grey" border="1">
			<Excel:td  align="center" width="100" rowspan="2" bordercolor="black">地区行政区划名称</Excel:td>
			<Excel:td  align="center" width="100" rowspan="2" bordercolor="black">合计(人)</Excel:td>			
			<Excel:td  align="center" width="100" colspan="2" bordercolor="black">其他</Excel:td>
			<Excel:td  align="center" width="100" colspan="2" bordercolor="black">小学教育</Excel:td>
			<Excel:td  align="center" width="100" colspan="2" bordercolor="black">初级中学教育</Excel:td>
			<Excel:td  align="center" width="100" colspan="2" bordercolor="black">普通高级中学教育</Excel:td>
			<Excel:td  align="center" width="100" colspan="2" bordercolor="black">中等职业教育</Excel:td>
			<Excel:td  align="center" width="100" colspan="2" bordercolor="black">大学本科/专科教育</Excel:td>
			<Excel:td  align="center" width="100" colspan="2" bordercolor="black">研究生教育</Excel:td>
		</Excel:tr>
		<Excel:tr height="20" bgcolor="grey" border="1">
			<Excel:td  align="center" bordercolor="black" >人数</Excel:td>
			<Excel:td  align="center" bordercolor="black" >％</Excel:td>			
			<Excel:td  align="center" bordercolor="black" >人数</Excel:td>
			<Excel:td  align="center" bordercolor="black" >％</Excel:td>	
			<Excel:td  align="center" bordercolor="black" >人数</Excel:td>
			<Excel:td  align="center" bordercolor="black" >％</Excel:td>	
			<Excel:td  align="center" bordercolor="black" >人数</Excel:td>
			<Excel:td  align="center" bordercolor="black" >％</Excel:td>	
			<Excel:td  align="center" bordercolor="black" >人数</Excel:td>
			<Excel:td  align="center" bordercolor="black" >％</Excel:td>	
			<Excel:td  align="center" bordercolor="black" >人数</Excel:td>
			<Excel:td  align="center" bordercolor="black" >％</Excel:td>	
			<Excel:td  align="center" bordercolor="black" >人数</Excel:td>
			<Excel:td  align="center" bordercolor="black" >％</Excel:td>	
		</Excel:tr>
		<%
			DataSet ds = (DataSet)request.getAttribute("dataset");
				for(int i=0; i<ds.getCount(); i++) {
					Record rec = ds.getRecord(i);
		%>
		<Excel:tr border="1">
			<Excel:td align="center"><%=rec.get("ITEM_NAME")%></Excel:td>
			<Excel:td align="right"><%=rec.get("TOTAL_NUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("OTHER_NUM")%></Excel:td>			
			<Excel:td align="right"><%=rec.get("OTHER_RATE")%></Excel:td>
			<Excel:td align="right"><%=rec.get("ELEMENTARY_NUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("ELEMENTARY_RATE")%></Excel:td>
			<Excel:td align="right"><%=rec.get("SECONDARY_NUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("SECONDARY_RATE")%></Excel:td>
			<Excel:td align="right"><%=rec.get("SENIOR_NUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("SENIOR_RATE")%></Excel:td>
			<Excel:td align="right"><%=rec.get("TECHNICAL_NUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("TECHNICAL_RATE")%></Excel:td>
			<Excel:td align="right"><%=rec.get("BACHELOR_NUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("BACHELOR_RATE")%></Excel:td>
			<Excel:td align="right"><%=rec.get("GRADUATE_NUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("GRADUATE_RATE")%></Excel:td>
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

