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
	String title="殡仪馆设备情况统计表_"+date;
	//out.clear();//清空缓存的内容
	//out = pageContext.pushBody(); 
%>
<!--导出Excel-->
<Excel:tablelist filename="<%=title%>">
	<Excel:table sheetname="殡仪馆设备情况统计表" border="1">
		<Excel:tr>
			<Excel:td colspan="14" align="center" border="0"><Excel:font size="15">殡仪馆设备情况统计表</Excel:font></Excel:td>
		</Excel:tr>
		<Excel:tr border="0">
		<Excel:td  align="left" colspan="6" border="0">填报单位：<%=BspUtil.getOrganName()%></Excel:td>
		</Excel:tr>
		<Excel:tr border="1" bgcolor="grey">
			<Excel:td  align="center" rowspan="2">单位</Excel:td>
			<Excel:td  align="center" colspan="4" >火化机</Excel:td>
			<Excel:td  align="center" colspan="3">运尸车</Excel:td>
			<Excel:td  align="center" colspan="3">冷藏</Excel:td>
			<Excel:td  align="center" colspan="3">寄存)</Excel:td>
			
		</Excel:tr>
		<Excel:tr border="1" bgcolor="grey">
			<Excel:td  align="center">合计</Excel:td>
			<Excel:td  align="center">拣灰（高档）</Excel:td>
			<Excel:td  align="center">平板（中档）</Excel:td>
			<Excel:td  align="center">架条（低档）</Excel:td>
			<Excel:td  align="center">合计</Excel:td>
			<Excel:td  align="center">高档</Excel:td>
			<Excel:td  align="center">普通</Excel:td>
			<Excel:td  align="center">柜数</Excel:td>
			<Excel:td  align="center">格位（个）</Excel:td>
			<Excel:td  align="center">已占用（个）</Excel:td>
			<Excel:td  align="center">架数</Excel:td>
			<Excel:td  align="center">格位（个）</Excel:td>
			<Excel:td  align="center">已占用（个）</Excel:td>
		</Excel:tr>
		<%
				DataSet dataset = (DataSet) request.getAttribute("dataset");
					EnumService enumService = ScaComponentFactory.getService(EnumService.class, "Enum/EnumService");
					for (int i = 0; i < dataset.getCount(); i++){
						Record rec = dataset.getRecord(i);
						
		%>
		<Excel:tr  border="1">
			<Excel:td align="center"><%=rec.get("NAME")%></Excel:td>
			<Excel:td align="right"><%=rec.get("CRE_TOTAL_NUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("CRE_1")%></Excel:td>
			<Excel:td align="right"><%=rec.get("CRE_2")%></Excel:td>
			<Excel:td align="right"><%=rec.get("CRE_3")%></Excel:td>
			<Excel:td align="right"><%=rec.get("CAR_TOTAL_NUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("CAR_1")%></Excel:td>
			<Excel:td align="right"><%=rec.get("CAR_2")%></Excel:td>
			<Excel:td align="right"><%=rec.get("STO_NUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("STO_TOTAL_NUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("STO_USE_NUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("EMP_NUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("EMP_TOTAL_NUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("EMP_USE_NUM")%></Excel:td>
		</Excel:tr>
		<%
					}
		%>	
		<Excel:tr border="0">
		<Excel:td  align="left" colspan="7" border="0">制表人：<%=BspUtil.getEmpOrgan().getShortName()%></Excel:td>
		<Excel:td  align="right" colspan="7" border="0">制表时间：<%=date %></Excel:td>
		</Excel:tr>
	</Excel:table>
</Excel:tablelist>