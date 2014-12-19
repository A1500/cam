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
	String name="登记机关办公设备统计表_"+date;
	String username=GetBspInfo.getBspInfo(request).getUserName();
%>
</head>
<Excel:tablelist filename="<%=name %>">
	<Excel:table sheetname="登记机关办公设备统计表">
		<Excel:tr>
			<Excel:td colspan="12" align="center" ><Excel:font size="15">登记机关办公设备统计表</Excel:font></Excel:td>
		</Excel:tr>
		<Excel:tr>
			<Excel:td colspan="12" align="left">统计单位：<%= BspUtil.getOrganName()%></Excel:td>
		</Excel:tr>
		<Excel:tr height="20" bgcolor="grey" border="1">
			<Excel:td  align="center" width="140" bordercolor="black" >单位</Excel:td>
			<Excel:td  align="center"  width="100" bordercolor="black" >计算机（台）</Excel:td>
			<Excel:td  align="center"  width="100" bordercolor="black" >打印机（台）</Excel:td>
			<Excel:td  align="center"  width="100" bordercolor="black" >读卡器（个）</Excel:td>
			<Excel:td  align="center" bordercolor="black" >复印机</Excel:td>
			<Excel:td  align="center" bordercolor="black" >传真机</Excel:td>
			<Excel:td  align="center" bordercolor="black" >扫描仪</Excel:td>
			<Excel:td  align="center" bordercolor="black" >电视机</Excel:td>
			<Excel:td  align="center" bordercolor="black" >叫号机</Excel:td>
			<Excel:td  align="center"  width="100" bordercolor="black" >电子显示屏</Excel:td>
			<Excel:td  align="center" bordercolor="black" >监控设备</Excel:td>
			<Excel:td  align="center"  width="100" bordercolor="black" >服务评价系统</Excel:td>
		</Excel:tr>
		<%
			DataSet ds = (DataSet)request.getAttribute("dataset");
				for(int i=0; i<ds.getCount(); i++) {
					Record rec = ds.getRecord(i);
		%>
		<Excel:tr border="1">
			<Excel:td><%=rec.get("ORGAN_NAME")%></Excel:td>
			<Excel:td><%=rec.get("CUM_NUM")%></Excel:td>
			<Excel:td><%=rec.get("PRINTER_NUM")%></Excel:td>			
			<Excel:td><%=rec.get("CARD_READER_NUM")%></Excel:td>
			<Excel:td><%=rec.get("COPIER_NUM")%></Excel:td>
			<Excel:td><%=rec.get("SCANNER_NUM")%></Excel:td>
			<Excel:td><%=rec.get("FAX_NUM")%></Excel:td>			
			<Excel:td><%=rec.get("TV_NUM")%></Excel:td>
			<Excel:td><%=rec.get("CAL_NUM")%></Excel:td>
			<Excel:td><%=rec.get("SCREEN_NUM")%></Excel:td>
			<Excel:td><%=rec.get("MONITORING_NUM")%></Excel:td>			
			<Excel:td><%=rec.get("EVALUATION_NUM")%></Excel:td>
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

