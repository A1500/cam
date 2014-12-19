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
	String title="殡仪馆技术人员统计表（二）_"+date;
	//out.clear();//清空缓存的内容
	//out = pageContext.pushBody(); 
%>
<!--导出Excel-->
<Excel:tablelist filename="<%=title%>">
	<Excel:table sheetname="殡仪馆技术人员统计表（二）" border="1">
		<Excel:tr>
			<Excel:td colspan="29" align="center" border="0"><Excel:font size="15">殡仪馆技术人员统计表（二）</Excel:font></Excel:td>
		</Excel:tr>
		<Excel:tr border="0">
		<Excel:td  align="left" colspan="8" border="0">填报单位：<%=BspUtil.getOrganName()%></Excel:td>
		
		</Excel:tr>
		<Excel:tr border="1" bgcolor="grey">
			<Excel:td  align="center" rowspan="2">单位</Excel:td>
			<Excel:td  align="center" rowspan="2">总计</Excel:td>
			<Excel:td  align="center" colspan="3">合计</Excel:td>
			<Excel:td  align="center" colspan="4">遗体接运工</Excel:td>
			<Excel:td  align="center" colspan="4">服务员</Excel:td>
			<Excel:td  align="center" colspan="4">遗体整容师</Excel:td>
			<Excel:td  align="center" colspan="4">遗体防腐师</Excel:td>
			<Excel:td  align="center" colspan="4">遗体火化师</Excel:td>
			<Excel:td  align="center" colspan="4">墓地管理员</Excel:td>
		</Excel:tr>
		<Excel:tr border="1" bgcolor="grey">
			<Excel:td  align="center">高级</Excel:td>
			<Excel:td  align="center">中级</Excel:td>
			<Excel:td  align="center">初级</Excel:td>
			
			<Excel:td  align="center">小计</Excel:td>
			<Excel:td  align="center">高级</Excel:td>
			<Excel:td  align="center">中级</Excel:td>
			<Excel:td  align="center">初级</Excel:td>
			
			<Excel:td  align="center">小计</Excel:td>
			<Excel:td  align="center">高级</Excel:td>
			<Excel:td  align="center">中级</Excel:td>
			<Excel:td  align="center">初级</Excel:td>
			
			<Excel:td  align="center">小计</Excel:td>
			<Excel:td  align="center">高级</Excel:td>
			<Excel:td  align="center">中级</Excel:td>
			<Excel:td  align="center">初级</Excel:td>
			
			<Excel:td  align="center">小计</Excel:td>
			<Excel:td  align="center">高级</Excel:td>
			<Excel:td  align="center">中级</Excel:td>
			<Excel:td  align="center">初级</Excel:td>
			
			<Excel:td  align="center">小计</Excel:td>
			<Excel:td  align="center">高级</Excel:td>
			<Excel:td  align="center">中级</Excel:td>
			<Excel:td  align="center">初级</Excel:td>
			
			<Excel:td  align="center">小计</Excel:td>
			<Excel:td  align="center">高级</Excel:td>
			<Excel:td  align="center">中级</Excel:td>
			<Excel:td  align="center">初级</Excel:td>
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
			<Excel:td align="right"><%=rec.get("TOTALNUMG")%></Excel:td>
			<Excel:td align="right"><%=rec.get("TOTALNUMZ")%></Excel:td>
			<Excel:td align="right"><%=rec.get("TOTALNUMC")%></Excel:td>
			
			<Excel:td align="right"><%=rec.get("TYPE02")%></Excel:td>
			<Excel:td align="right"><%=rec.get("TYPE02G")%></Excel:td>
			<Excel:td align="right"><%=rec.get("TYPE02Z")%></Excel:td>
			<Excel:td align="right"><%=rec.get("TYPE02C")%></Excel:td>
			
			<Excel:td align="right"><%=rec.get("TYPE01")%></Excel:td>
			<Excel:td align="right"><%=rec.get("TYPE01G")%></Excel:td>
			<Excel:td align="right"><%=rec.get("TYPE01Z")%></Excel:td>
			<Excel:td align="right"><%=rec.get("TYPE01C")%></Excel:td>
			
			<Excel:td align="right"><%=rec.get("TYPE04")%></Excel:td>
			<Excel:td align="right"><%=rec.get("TYPE04G")%></Excel:td>
			<Excel:td align="right"><%=rec.get("TYPE04Z")%></Excel:td>
			<Excel:td align="right"><%=rec.get("TYPE04C")%></Excel:td>
			
			<Excel:td align="right"><%=rec.get("TYPE03")%></Excel:td>
			<Excel:td align="right"><%=rec.get("TYPE03")%></Excel:td>
			<Excel:td align="right"><%=rec.get("TYPE03")%></Excel:td>
			<Excel:td align="right"><%=rec.get("TYPE03")%></Excel:td>
			
            <Excel:td align="right"><%=rec.get("TYPE05")%></Excel:td>
			<Excel:td align="right"><%=rec.get("TYPE05G")%></Excel:td>
			<Excel:td align="right"><%=rec.get("TYPE05Z")%></Excel:td>
			<Excel:td align="right"><%=rec.get("TYPE05C")%></Excel:td>
			
			<Excel:td align="right"><%=rec.get("TYPE06")%></Excel:td>
			<Excel:td align="right"><%=rec.get("TYPE06G")%></Excel:td>
			<Excel:td align="right"><%=rec.get("TYPE06Z")%></Excel:td>
			<Excel:td align="right"><%=rec.get("TYPE06C")%></Excel:td>
		</Excel:tr>
		<%
					}
		%>	
		<Excel:tr border="0">
		<Excel:td  align="left" colspan="14" border="0">制表人：<%=BspUtil.getEmpOrgan().getShortName()%></Excel:td>
		<Excel:td  align="right" colspan="15" border="0">制表时间：<%=date %></Excel:td>
		</Excel:tr>
	</Excel:table>
</Excel:tablelist>