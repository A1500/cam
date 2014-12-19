<%@page contentType="charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="/tags/next-excel" prefix="Excel"%>
<%@page import="org.loushang.next.data.DataSet"%>
<%@page import="org.loushang.next.data.Record"%>
<%@page import="org.loushang.next.data.FieldSet"%>
<%@page import="org.loushang.next.commons.nenum.EnumService" %>
<%@page import="org.loushang.sca.ScaComponentFactory" %>
<%@page import="java.math.BigDecimal" %>
<%@page import="java.text.DecimalFormat" %>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page import="org.loushang.bsp.security.context.GetBspInfo"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<%@page import="java.util.*"%>
<%
	SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
	String date=sdf.format(new Date());
	String title="特殊困难帮扶单位信息统计表_"+date;
	//out.clear();//清空缓存的内容
	//out = pageContext.pushBody(); 
%>
<!--导出Excel-->
<Excel:tablelist filename="<%=title%>">
	<Excel:table sheetname="特殊困难帮扶单位信息统计表" border="1">
		<Excel:tr>
			<Excel:td colspan="11" align="center" border="0"><Excel:font size="15">特殊困难帮扶单位信息统计表</Excel:font></Excel:td>
		</Excel:tr>
		<Excel:tr border="0">
			<Excel:td  align="left" colspan="11" border="0">填报单位：<%=BspUtil.getOrganName()%></Excel:td>
		</Excel:tr>
		<Excel:tr border="1" bgcolor="grey">
			        <Excel:td align="center">帮扶单位代码</Excel:td>
					<Excel:td align="center">帮扶单位名称</Excel:td>
					<Excel:td align="center">单位类型代码</Excel:td>
					<Excel:td align="center">单位类型名称</Excel:td>
					<Excel:td align="center">帮扶区县代码</Excel:td>
					<Excel:td align="center">帮扶区县名称</Excel:td>
					<Excel:td align="center">帮扶镇级代码</Excel:td>
					<Excel:td align="center">帮扶镇级名称</Excel:td>
					<Excel:td align="center">帮扶村代码</Excel:td>
					<Excel:td align="center">帮扶村名称</Excel:td>
					<Excel:td align="center">顺序号</Excel:td>
		</Excel:tr>
		<%
				DataSet dataset = (DataSet) request.getAttribute("dataset");
					for (int i = 0; i < dataset.getCount(); i++){
						Record rec = dataset.getRecord(i);
						
		%>
		<Excel:tr  border="1">
			<Excel:td align="center"><%=rec.get("supportUnitCode")%></Excel:td>
			<Excel:td align="right"><%=rec.get("supportUnitName")%></Excel:td>
			<Excel:td align="right"><%=rec.get("supportUnitTypeCode")%></Excel:td>
			<Excel:td align="right"><%=rec.get("supportUnitTypeName")%></Excel:td>
			<Excel:td align="right"><%=rec.get("supportCountyCode")%></Excel:td>
			<Excel:td align="right"><%=rec.get("supportCountyName")%></Excel:td>
			<Excel:td align="right"><%=rec.get("supportTownCode")%></Excel:td>
			<Excel:td align="right"><%=rec.get("supportTownName")%></Excel:td>
			<Excel:td align="right"><%=rec.get("supportVillageCode")%></Excel:td>
			<Excel:td align="right"><%=rec.get("supportVillageName")%></Excel:td>
			<Excel:td align="right"><%=rec.get("supportUnitSn")%></Excel:td>
		</Excel:tr>
		<%
					}
		%>	
		<Excel:tr border="0">
		<Excel:td  align="left" colspan="6" border="0">制表人：<%=BspUtil.getEmpOrgan().getShortName()%></Excel:td>
		<Excel:td  align="right" colspan="5" border="0">制表时间：<%=date %></Excel:td>
		</Excel:tr>
	</Excel:table>
</Excel:tablelist>