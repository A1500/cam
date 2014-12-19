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
	String name="过渡性生活补助审核列表_"+date;
	
%>

</head>
<Excel:tablelist filename="<%=name %>">
	<Excel:table sheetname="过渡性生活补助审核列表">
		<Excel:tr>
			<Excel:td colspan="11" align="center" ><Excel:font size="15">过渡性生活补助审核列表</Excel:font></Excel:td>
		</Excel:tr>
		<Excel:tr>
			<Excel:td colspan="11" align="left">统计单位：<%= BspUtil.getOrganName()%></Excel:td>
		</Excel:tr>
		<Excel:tr height="30" bgcolor="grey" border="1">
			<Excel:td  align="center" width="100" bordercolor="black">单位</Excel:td>
			<Excel:td  align="center" width="100" bordercolor="black">流程状态(省市能否查看)</Excel:td>
			<Excel:td  align="center" width="100" bordercolor="black">救助家庭人口数量(人)</Excel:td>
			<Excel:td  align="center" width="100" bordercolor="black">总核准救助口粮（公斤）</Excel:td>
			<Excel:td  align="center" width="100" bordercolor="black">人均核准救助口粮（公斤）</Excel:td>
			<Excel:td  align="center" width="100" bordercolor="black">总核准救助衣被（件）</Excel:td>
			<Excel:td  align="center" width="100" bordercolor="black">人均核准救助衣被（件）</Excel:td>
			<Excel:td  align="center" width="100" bordercolor="black">总核准救助资金（元）</Excel:td>
			<Excel:td  align="center" width="100" bordercolor="black">人均核准救助资金（元）</Excel:td>
		</Excel:tr>
		<%
			String workflowStatus="";
			DataSet ds = (DataSet)request.getAttribute("dataset");
			EnumService enumService = ScaComponentFactory.getService(EnumService.class, "Enum/EnumService");
			for(int i=0; i<ds.getCount(); i++) {
				Record rec = ds.getRecord(i);
				if(rec.get("FILL_STATE")!=null){
					workflowStatus =  enumService.getDescByValue("DIS.RELIEFINFO_WORKFLOW_STATE", (String)rec.get("FILL_STATE"));
				}
		%>
		<Excel:tr border="1">
			<Excel:td align="right"><%=rec.get("REQUIRED_ORGAN_NAME")%></Excel:td>
			<Excel:td align="right"><%=workflowStatus%></Excel:td>
			<Excel:td align="right"><%=rec.get("FAMILY_NUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("APPROVAL_FOOD")%></Excel:td>
			<Excel:td align="right"><%=rec.get("APPROVAL_FOOD_AVG")%></Excel:td>
			<Excel:td align="right"><%=rec.get("APPROVAL_CLOTHES")%></Excel:td>
			<Excel:td align="right"><%=rec.get("APPROVAL_CLOTHES_AVG")%></Excel:td>
			<Excel:td align="right"><%=rec.get("APPROVAL_MONEY")%></Excel:td>
			<Excel:td align="right"><%=rec.get("APPROVAL_MONEY_AVG")%></Excel:td>
		</Excel:tr>
		<%
			}
		%>
		<Excel:tr>
			<Excel:td colspan="5" align="left">制表人：<%= BspUtil.getOrganName()%></Excel:td>
			<Excel:td colspan="6" align="right">制表时间：<%= date%></Excel:td>
		</Excel:tr>
	</Excel:table>
</Excel:tablelist>

