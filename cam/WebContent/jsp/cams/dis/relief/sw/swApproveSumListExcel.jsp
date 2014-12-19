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
	String name="遇难人员家属抚慰汇总_"+date;
	
%>

</head>
<Excel:tablelist filename="<%=name %>">
	<Excel:table sheetname="遇难人员家属抚慰汇总列表">
		<Excel:tr>
			<Excel:td colspan="4" align="center" ><Excel:font size="15">遇难人员家属抚慰汇总列表</Excel:font></Excel:td>
		</Excel:tr>
		<Excel:tr>
			<Excel:td colspan="4" align="left">统计单位：<%= BspUtil.getOrganName()%></Excel:td>
		</Excel:tr>
		<Excel:tr height="30" bgcolor="grey" border="1">
			<Excel:td  align="center" width="180" bordercolor="black">单位</Excel:td>
			<Excel:td  align="center" width="100" bordercolor="black">流程状态(省市能否查看)</Excel:td>
			<Excel:td  align="center" width="100" bordercolor="black">核准救助资金(元)</Excel:td>
			<Excel:td  align="center" width="100" bordercolor="black">人均核准救助资金(元)</Excel:td>
		</Excel:tr>
		<%
			String fill_state="";
			DataSet ds = (DataSet)request.getAttribute("dataset");
			EnumService enumService = ScaComponentFactory.getService(EnumService.class, "Enum/EnumService");
			for(int i=0; i<ds.getCount(); i++) {
				Record rec = ds.getRecord(i);
				if(rec.get("FILL_STATE")!=null){
					fill_state =  enumService.getDescByValue("DIS.BATCHDETAIL_FILL_STATE", (String)rec.get("FILL_STATE"));
				}
		%>
		<Excel:tr border="1">
			<Excel:td align="center"><%=rec.get("REQUIRED_ORGAN_NAME")%></Excel:td>
			<Excel:td align="right"><%=fill_state%></Excel:td>
			<Excel:td align="right"><%=rec.get("APPROVAL_MONEY")%></Excel:td>
			<Excel:td align="right"><%=rec.get("APPROVAL_MONEY_AVG")%></Excel:td>
		</Excel:tr>
		<%
			}
		%>
		<Excel:tr>
			<Excel:td colspan="2" align="left">制表人：<%= BspUtil.getOrganName()%></Excel:td>
			<Excel:td colspan="2" align="right">制表时间：<%= date%></Excel:td>
		</Excel:tr>
	</Excel:table>
</Excel:tablelist>

