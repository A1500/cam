<%@ page contentType="charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/tags/next-excel" prefix="Excel"%>
<%@page import="org.loushang.next.data.DataSet"%>
<%@page import="org.loushang.next.data.Record"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.commons.nenum.EnumService" %>
<%@page import="org.loushang.sca.ScaComponentFactory" %>
<head>
<title>导出Excel</title>
<%
	String funeral_name=request.getParameter("funeral_name");
	String name="殡仪馆收费价格公示表";
%>
<%
	out.clear();//清空缓存的内容
	out = pageContext.pushBody(); 
%>
</head>
<Excel:tablelist filename="<%=name %>">
	<Excel:table sheetname="殡仪馆收费价格公示表">
		<Excel:tr>
			<Excel:td colspan="12" align="center" ><Excel:font size="15"><%=funeral_name%>收费价格公示表</Excel:font></Excel:td>
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
				if(rec.get("WORK_TYPE")!=null){
					workType =  enumService.getDescByValue("FIS.WORK_TYPE", (String)rec.get("WORK_TYPE"));
				}
				if(rec.get("FEE_TYPE")!=null){
					feeType =  enumService.getDescByValue("FIS.FEE_TYPE", (String)rec.get("FEE_TYPE"));
				}
				if(rec.get("INVOICE_CODE_TYPE")!=null){
					invoiceCodeType =  enumService.getDescByValue("FIS.INVOICE_TYPE", (String)rec.get("INVOICE_CODE_TYPE"));
				}
				if(rec.get("PRICE_STANDARD")!=null){
					priceStandard =  enumService.getDescByValue("FIS.PRICE_STANDARD", (String)rec.get("PRICE_STANDARD"));
				}
		%>
		<Excel:tr border="1">
			<Excel:td align="right"><%=workType%></Excel:td>
			<Excel:td align="right"><%=feeType%></Excel:td>
			<Excel:td align="right"><%=rec.get("SERVICE_NAME")%></Excel:td>
		   	<Excel:td align="right"><%=rec.get("PRICE_DESC")%></Excel:td>
		   	<Excel:td align="right"><%=invoiceCodeType%></Excel:td>
			<Excel:td align="right"><%=priceStandard%></Excel:td>
			<Excel:td align="right"><%=rec.get("PRICE_FILE_NUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("PRICE_EXE_TIME")%></Excel:td>
			<Excel:td align="right"><%=rec.get("REMISSION_TARGET")%></Excel:td>
			<Excel:td align="right"><%=rec.get("REMISSION_DESC")%></Excel:td>
			<Excel:td align="right"><%=rec.get("REMISSION_FILE_NUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("REMISSION_EXE_TIME")%></Excel:td>
		</Excel:tr>
		<%
			}
		%>
	</Excel:table>
</Excel:tablelist>

