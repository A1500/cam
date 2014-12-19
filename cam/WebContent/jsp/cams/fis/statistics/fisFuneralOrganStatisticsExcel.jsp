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
	String title="殡仪馆基本情况统计表_"+date;
	//out.clear();//清空缓存的内容
	//out = pageContext.pushBody(); 
%>
<!--导出Excel-->
<Excel:tablelist filename="<%=title%>">
	<Excel:table sheetname="殡仪馆基本情况统计表" border="1">
		<Excel:tr>
			<Excel:td colspan="13" align="center" border="0"><Excel:font size="15">殡仪馆基本情况统计表</Excel:font></Excel:td>
		</Excel:tr>
		<Excel:tr border="0">
		<Excel:td  align="left" colspan="6" border="0">填报单位：<%=BspUtil.getOrganName()%></Excel:td>
		</Excel:tr>
		<Excel:tr border="1" bgcolor="grey">
			<Excel:td  align="center" rowspan="2">单位</Excel:td>
			<Excel:td  align="center" colspan="7" >机构性质</Excel:td>
			<Excel:td  align="center" rowspan="2">编制人数</Excel:td>
			<Excel:td  align="center" rowspan="2">实有人数</Excel:td>
			<Excel:td  align="center" rowspan="2">占地面积(亩)</Excel:td>
			<Excel:td  align="center" rowspan="2">建筑面积(㎡)</Excel:td>
			<Excel:td  align="center" rowspan="2">固定资产(万元)</Excel:td>
		</Excel:tr>
		<Excel:tr border="1" bgcolor="grey">
			<Excel:td  align="center">合计</Excel:td>
			<Excel:td  align="center">全额拨款</Excel:td>
			<Excel:td  align="center">差额拨款</Excel:td>
			<Excel:td  align="center">自收自支</Excel:td>
			<Excel:td  align="center">企业</Excel:td>
			<Excel:td  align="center">民办非企业</Excel:td>
			<Excel:td  align="center">其他</Excel:td>
		</Excel:tr>
		<%
				DataSet dataset = (DataSet) request.getAttribute("dataset");
					EnumService enumService = ScaComponentFactory.getService(EnumService.class, "Enum/EnumService");
					for (int i = 0; i < dataset.getCount(); i++){
						Record rec = dataset.getRecord(i);
						
		%>
		<Excel:tr  border="1">
			<Excel:td align="center"><%=rec.get("NAME")%></Excel:td>
			<Excel:td align="right"><%=rec.get("PROPTOTAL")%></Excel:td>
			<Excel:td align="right"><%=rec.get("PROP01")%></Excel:td>
			<Excel:td align="right"><%=rec.get("PROP02")%></Excel:td>
			<Excel:td align="right"><%=rec.get("PROP03")%></Excel:td>
			<Excel:td align="right"><%=rec.get("PROP04")%></Excel:td>
			<Excel:td align="right"><%=rec.get("PROP06")%></Excel:td>
			<Excel:td align="right"><%=rec.get("PROP05")%></Excel:td>
			<Excel:td align="right"><%=rec.get("NUMOF")%></Excel:td>
			<Excel:td align="right"><%=rec.get("NUMREAL")%></Excel:td>
			<Excel:td align="right"><%=rec.get("TOTALAREA")%></Excel:td>
			<Excel:td align="right"><%=rec.get("BUILTAREA")%></Excel:td>
			<Excel:td align="right"><%=rec.get("FIXEDASSETS")%></Excel:td>
		</Excel:tr>
		<%
					}
		%>	
		<Excel:tr border="0">
		<Excel:td  align="left" colspan="6" border="0">制表人：<%=BspUtil.getEmpOrgan().getShortName()%></Excel:td>
		<Excel:td  align="right" colspan="7" border="0">制表时间：<%=date %></Excel:td>
		</Excel:tr>
	</Excel:table>
</Excel:tablelist>