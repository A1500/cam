<%@ page contentType="charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/tags/next-excel" prefix="Excel"%>
<%@page import="org.loushang.next.data.DataSet"%>
<%@page import="org.loushang.next.data.Record"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="com.inspur.comm.util.BspUtil"%>
<%@page import="org.loushang.next.commons.nenum.EnumService" %>
<%@page import="org.loushang.sca.ScaComponentFactory" %>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.*"%>
<head>
<title>导出Excel</title>
<%!
	
	SimpleDateFormat sdf=new SimpleDateFormat("yyyy年MM月dd日HH时mm分");
	SimpleDateFormat sdf2=new SimpleDateFormat("yyyy年MM月dd日");
	String date=sdf.format(new Date());
	String date2=sdf2.format(new Date());
	String name="殡仪馆收费价格公示表_"+date;
%>
<%
	out.clear();//清空缓存的内容
	out = pageContext.pushBody(); 
%>
</head>
<Excel:tablelist filename="<%=name %>">
	<Excel:table sheetname="殡仪馆收费价格公示表">
		<Excel:tr>
			<Excel:td colspan="12" align="center" ><Excel:font size="15">殡仪馆收费价格公示表</Excel:font></Excel:td>
		</Excel:tr>
		<Excel:tr>
			<Excel:td colspan="6" align="left">统计单位：<%= BspUtil.getOrganName()%></Excel:td>
		</Excel:tr>
			<Excel:tr height="30" bgcolor="grey" border="1">
			<Excel:td  align="center" width="120" bordercolor="black">服务类型</Excel:td>
			<Excel:td  align="center" width="120" bordercolor="black">收费类型</Excel:td>
			<Excel:td  align="center" width="120" bordercolor="black">项目名称</Excel:td>
		   	<Excel:td  align="center" width="120" bordercolor="black">收费标准</Excel:td>
		   	<Excel:td  align="center" width="120" bordercolor="black">收费性质</Excel:td>
			<Excel:td  align="center" width="120" bordercolor="black">定价形式</Excel:td>
			<Excel:td  align="center" width="120" bordercolor="black">收费依据</Excel:td>
			<Excel:td  align="center" width="120" bordercolor="black">执行时间</Excel:td>
			<Excel:td  align="center" width="120" bordercolor="black">减免对象</Excel:td>
			<Excel:td  align="center" width="120" bordercolor="black">政府减免标准</Excel:td>
			<Excel:td  align="center" width="120" bordercolor="black">减免依据</Excel:td>
			<Excel:td  align="center" width="120" bordercolor="black">减免执行时间</Excel:td>
		</Excel:tr>
		<%
			String workType="";
			String feeType="";
			String invoiceCodeType="";
			String priceStandard="";
			DataSet ds = (DataSet)request.getAttribute("dataset");
			EnumService enumService = ScaComponentFactory.getService(EnumService.class, "Enum/EnumService");
			for(int i=0; i<ds.getCount(); i++) {
				Record rec = ds.getRecord(i);
				if(rec.get("workType")!=null){
					workType =  enumService.getDescByValue("FIS.WORK_TYPE", (String)rec.get("workType"));
				}
				if(rec.get("feeType")!=null){
					feeType =  enumService.getDescByValue("FIS.FEE_TYPE", (String)rec.get("feeType"));
				}
				if(rec.get("invoiceCodeType")!=null){
					invoiceCodeType =  enumService.getDescByValue("FIS.INVOICE_TYPE", (String)rec.get("invoiceCodeType"));
				}
				if(rec.get("priceStandard")!=null){
					priceStandard =  enumService.getDescByValue("FIS.PRICE_STANDARD", (String)rec.get("priceStandard"));
				}
		%>
		<Excel:tr border="1">
			<Excel:td align="right"><%=workType%></Excel:td>
			<Excel:td align="right"><%=feeType%></Excel:td>
			<Excel:td align="right"><%=rec.get("serviceName")%></Excel:td>
		   	<Excel:td align="right"><%=rec.get("priceDesc")%></Excel:td>
		   	<Excel:td align="right"><%=invoiceCodeType%></Excel:td>
			<Excel:td align="right"><%=priceStandard%></Excel:td>
			<Excel:td align="right"><%=rec.get("priceFileNum")%></Excel:td>
			<Excel:td align="right"><%=rec.get("priceExeTime")%></Excel:td>
			<Excel:td align="right"><%=rec.get("remissionTarget")%></Excel:td>
			<Excel:td align="right"><%=rec.get("remissionDesc")%></Excel:td>
			<Excel:td align="right"><%=rec.get("remissionFileNum")%></Excel:td>
			<Excel:td align="right"><%=rec.get("remissionExeTime")%></Excel:td>
		</Excel:tr>
		<%
			}
		%>
		<Excel:tr>
			<Excel:td colspan="6" align="left">制表人：<%= BspUtil.getOrganName()%></Excel:td>
			<Excel:td colspan="6" align="right">制表时间：<%= date2%></Excel:td>
		</Excel:tr>
	</Excel:table>
</Excel:tablelist>

