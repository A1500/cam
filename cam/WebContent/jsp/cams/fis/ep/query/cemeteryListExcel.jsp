<%@ page contentType="charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/tags/next-excel" prefix="Excel"%>
<%@page import="org.loushang.next.data.DataSet"%>
<%@page import="org.loushang.next.data.Record"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<%@page import="org.loushang.next.commons.nenum.EnumService" %>
<%@page import="org.loushang.sca.ScaComponentFactory" %>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.*"%>
<head>
<title>导出Excel</title>
<%!
	SimpleDateFormat sdf=new SimpleDateFormat("yyyy年MM月dd日HH时mm分");
	String date=sdf.format(new Date());
	String name="公墓信息_"+date;
%>
</head>
<Excel:tablelist filename="<%=name %>">
	<Excel:table sheetname="公墓信息列表">
		<Excel:tr>
			<Excel:td colspan="12" align="center" ><Excel:font size="15">公墓信息列表</Excel:font></Excel:td>
		</Excel:tr>
		<Excel:tr>
			<Excel:td colspan="12" align="left">统计单位：<%= BspUtil.getOrganName()%></Excel:td>
		</Excel:tr>
		<Excel:tr height="30" bgcolor="grey" border="1">
			<Excel:td  align="center" width="180" bordercolor="black">公墓编号</Excel:td>
			<Excel:td  align="center" width="100" bordercolor="black">公墓名称</Excel:td>
			<Excel:td  align="center" width="100" bordercolor="black">公墓性质</Excel:td>
			<Excel:td  align="center" width="100" bordercolor="black">法人代表</Excel:td>
			<Excel:td  align="center" width="100" bordercolor="black">主办单位</Excel:td>
			<Excel:td  align="center" width="100" bordercolor="black">批准建设时间</Excel:td>
			<Excel:td  align="center" width="100" bordercolor="black">正式营业时间</Excel:td>
			<Excel:td  align="center" width="100" bordercolor="black">编制人数</Excel:td>
			<Excel:td  align="center" width="100" bordercolor="black">管辖级别</Excel:td>
			<Excel:td  align="center" width="100" bordercolor="black">主管单位</Excel:td>
			<Excel:td  align="center" width="100" bordercolor="black">所属行政区</Excel:td>
			<Excel:td  align="center" width="100" bordercolor="black">地址</Excel:td>
		</Excel:tr>
		<%
			String prop = "";
			String domination = "";
			DataSet ds = (DataSet)request.getAttribute("dataset");
			EnumService enumService = ScaComponentFactory.getService(EnumService.class, "Enum/EnumService");

			for(int i=0; i<ds.getCount(); i++) {
				Record rec = ds.getRecord(i);
				if(rec.get("prop")!=null){
					prop =  enumService.getDescByValue("FIS.CEME.PROP", (String)rec.get("prop"));
				}
				if(rec.get("domination")!=null){
					domination =  enumService.getDescByValue("FIS.CEME.DOMINATION", (String)rec.get("domination"));
				}
		
		%>
		<Excel:tr border="1">
			<Excel:td align="center"><%=rec.get("organId")%></Excel:td>
			<Excel:td align="right"><%=rec.get("name")%></Excel:td>
			<Excel:td align="right"><%=prop %></Excel:td>
			
			<Excel:td align="right"><%=rec.get("legalPeople")%></Excel:td>
			<Excel:td align="right"><%=rec.get("organizer") %></Excel:td>
			
			<Excel:td align="right"><%=rec.get("approveTime")%></Excel:td>
			<Excel:td align="right"><%=rec.get("gestionTime")%></Excel:td>
			
			<Excel:td align="right"><%=rec.get("numberOf")%></Excel:td>
			<Excel:td align="right"><%=domination %></Excel:td>
			
			<Excel:td align="right"><%=rec.get("manaLevel")%></Excel:td>
			<Excel:td align="right"><%=rec.get("deptName")%></Excel:td>
			<Excel:td align="right"><%=rec.get("address")%></Excel:td>
		</Excel:tr>
		<%
			}
		%>
		<Excel:tr>
			<Excel:td colspan="6" align="left">制表人：<%= BspUtil.getOrganName()%></Excel:td>
			<Excel:td colspan="6" align="right">制表时间：<%= date%></Excel:td>
		</Excel:tr>
	</Excel:table>
</Excel:tablelist>

