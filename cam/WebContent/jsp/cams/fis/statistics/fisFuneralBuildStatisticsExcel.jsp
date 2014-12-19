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
	String title="殡仪馆建设情况统计表_"+date;
	//out.clear();//清空缓存的内容
	//out = pageContext.pushBody(); 
%>
<!--导出Excel-->
<Excel:tablelist filename="<%=title%>">
	<Excel:table sheetname="殡仪馆建设情况统计表" border="1">
		<Excel:tr>
			<Excel:td colspan="18" align="center" border="0"><Excel:font size="15">殡仪馆建设情况统计表</Excel:font></Excel:td>
		</Excel:tr>
		<Excel:tr border="0">
		<Excel:td  align="left" colspan="6" border="0">填报单位：<%=BspUtil.getOrganName()%></Excel:td>
		</Excel:tr>
		<Excel:tr border="1" bgcolor="grey">
			        <Excel:td align="center">单位</Excel:td>
					<Excel:td align="center">合计（㎡）</Excel:td>
					<Excel:td align="center">业务办理区（㎡）</Excel:td>
					<Excel:td align="center">告别区（㎡）</Excel:td>
					<Excel:td align="center">守灵区（㎡）</Excel:td>
					<Excel:td align="center">冷藏区（㎡）</Excel:td>
					<Excel:td align="center">防腐区（㎡）</Excel:td>
					<Excel:td align="center">整容区（㎡）</Excel:td>
					<Excel:td align="center">火化区（㎡）</Excel:td>
					<Excel:td align="center">骨灰寄存区（㎡）</Excel:td>
					<Excel:td align="center">丧属休息区（㎡）</Excel:td>
					<Excel:td align="center">停车场（㎡）</Excel:td>
					<Excel:td align="center">办公区（㎡）</Excel:td>
					<Excel:td align="center">职工休息区（㎡）</Excel:td>
					<Excel:td align="center">职工值班室（㎡）</Excel:td>
					<Excel:td align="center">职工食堂（㎡）</Excel:td>
					<Excel:td align="center">绿化面积（㎡）</Excel:td>
					<Excel:td align="center">其他（㎡）</Excel:td>
		</Excel:tr>
		<%
				DataSet dataset = (DataSet) request.getAttribute("dataset");
					EnumService enumService = ScaComponentFactory.getService(EnumService.class, "Enum/EnumService");
					for (int i = 0; i < dataset.getCount(); i++){
						Record rec = dataset.getRecord(i);
						
		%>
		<Excel:tr  border="1">
			<Excel:td align="center"><%=rec.get("NAME")%></Excel:td>
			<Excel:td align="right"><%=rec.get("TOTALNUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("NUM01")%></Excel:td>
			<Excel:td align="right"><%=rec.get("NUM02")%></Excel:td>
			<Excel:td align="right"><%=rec.get("NUM03")%></Excel:td>
			<Excel:td align="right"><%=rec.get("NUM04")%></Excel:td>
			<Excel:td align="right"><%=rec.get("NUM05")%></Excel:td>
			<Excel:td align="right"><%=rec.get("NUM06")%></Excel:td>
			<Excel:td align="right"><%=rec.get("NUM07")%></Excel:td>
			<Excel:td align="right"><%=rec.get("NUM08L")%></Excel:td>
			<Excel:td align="right"><%=rec.get("NUM09")%></Excel:td>
			<Excel:td align="right"><%=rec.get("NUM10")%></Excel:td>
			<Excel:td align="right"><%=rec.get("NUM11")%></Excel:td>
			<Excel:td align="right"><%=rec.get("NUM12")%></Excel:td>
			<Excel:td align="right"><%=rec.get("NUM13")%></Excel:td>
			<Excel:td align="right"><%=rec.get("NUM14")%></Excel:td>
			<Excel:td align="right"><%=rec.get("NUM15")%></Excel:td>
			<Excel:td align="right"><%=rec.get("NUM16")%></Excel:td>
		</Excel:tr>
		<%
					}
		%>	
		<Excel:tr border="0">
		<Excel:td  align="left" colspan="9" border="0">制表人：<%=BspUtil.getEmpOrgan().getShortName()%></Excel:td>
		<Excel:td  align="right" colspan="9" border="0">制表时间：<%=date %></Excel:td>
		</Excel:tr>
	</Excel:table>
</Excel:tablelist>