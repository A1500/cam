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
	SimpleDateFormat sdf2=new SimpleDateFormat("yyyy年MM月dd日");
	String date=sdf.format(new Date());
	String date2=sdf2.format(new Date());
	String name="资金投入统计_"+date;
	
%>

</head>
<Excel:tablelist filename="<%=name %>">
	<Excel:table sheetname="查询列表">
		<Excel:tr>
			<Excel:td colspan="4" align="center" ><Excel:font size="15">资金投入情况统计表</Excel:font></Excel:td>
		</Excel:tr>
		<Excel:tr>
			<Excel:td colspan="3" align="left">统计单位：<%= BspUtil.getOrganName()%></Excel:td>
		</Excel:tr>
		<Excel:tr height="30" bgcolor="grey" border="1">
			<Excel:td  align="center" width="180" bordercolor="black">地区</Excel:td>
			<Excel:td  align="center" width="100" bordercolor="black">本级投入</Excel:td>
			<Excel:td  align="center" width="150" bordercolor="black">其中：年度预算 （万元）</Excel:td>
			<Excel:td  align="center" width="150" bordercolor="black">其中：追加预算 （万元）</Excel:td>
		</Excel:tr>
		<%
			String familyRegister="";
			String familyType="";
			String workflowStatus="";
			DataSet ds = (DataSet)request.getAttribute("dataset");
			EnumService enumService = ScaComponentFactory.getService(EnumService.class, "Enum/EnumService");
			for(int i=0; i<ds.getCount(); i++) {
				Record rec = ds.getRecord(i);
				if(rec.get("familyRegister")!=null){
					familyRegister =  enumService.getDescByValue("DIS.FAMILY_REGISTER", (String)rec.get("familyRegister"));
				}
				if(rec.get("familyType")!=null){
					familyType =  enumService.getDescByValue("DIS.FAMILY_TYPE", (String)rec.get("familyType"));
				}
				if(rec.get("workflowStatus")!=null){
					workflowStatus =  enumService.getDescByValue("DIS.RELIEFINFO_WORKFLOW_STATE", (String)rec.get("workflowStatus"));
				}
	
		%>
		<Excel:tr border="1">
			<Excel:td align="center"><%=rec.get("NAME")%></Excel:td>
			<Excel:td align="right"><%=rec.get("AMOUNT")%></Excel:td>
			<Excel:td align="right"><%=rec.get("AMOUNT01")%></Excel:td>
			<Excel:td align="right"><%=rec.get("AMOUNT02")%></Excel:td>
		</Excel:tr>
		<%
			}
		%>
		<Excel:tr>
			<Excel:td colspan="2" align="left">制表人：<%= BspUtil.getOrganName()%></Excel:td>
			<Excel:td colspan="2" align="right">制表时间：<%= date2%></Excel:td>
		</Excel:tr>
	</Excel:table>
</Excel:tablelist>

