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
	String title="殡仪馆工作人员统计表_"+date;
	//out.clear();//清空缓存的内容
	//out = pageContext.pushBody(); 
%>
<!--导出Excel-->
<Excel:tablelist filename="<%=title%>">
	<Excel:table sheetname="殡仪馆工作人员统计表" border="1">
		<Excel:tr>
			<Excel:td colspan="19" align="center" border="0"><Excel:font size="15">殡仪馆工作人员统计表</Excel:font></Excel:td>
		</Excel:tr>
		<Excel:tr border="0">
		<Excel:td  align="left" colspan="8" border="0">填报单位：<%=BspUtil.getOrganName()%></Excel:td>
		
		</Excel:tr>
		<Excel:tr border="1" bgcolor="grey">
			<Excel:td  align="center" rowspan="3">单位</Excel:td>
			<Excel:td  align="center" colspan="2" rowspan="2">人员总数</Excel:td>
			<Excel:td  align="center" colspan="8">岗位性质</Excel:td>
			<Excel:td  align="center" colspan="8">工资</Excel:td>
		</Excel:tr>
		<Excel:tr border="1" bgcolor="grey">
			<Excel:td  align="center" colspan="2">正式职工</Excel:td>
			<Excel:td  align="center" colspan="2">合同工</Excel:td>
			<Excel:td  align="center" colspan="2">临时工</Excel:td>
			<Excel:td  align="center" colspan="2">其他</Excel:td>
			<Excel:td  align="center" colspan="2">1000元以下</Excel:td>
			<Excel:td  align="center" colspan="2">1000-2000元</Excel:td>
			<Excel:td  align="center" colspan="2">2000-3000元</Excel:td>
			<Excel:td  align="center" colspan="2">3000元以上</Excel:td>
		</Excel:tr>
		<Excel:tr border="1" bgcolor="grey">
			<Excel:td  align="center"></Excel:td>
			<Excel:td  align="center">女</Excel:td>
			<Excel:td  align="center"></Excel:td>
			<Excel:td  align="center">女</Excel:td>
			<Excel:td  align="center"></Excel:td>
			<Excel:td  align="center">女</Excel:td>
			<Excel:td  align="center"></Excel:td>
			<Excel:td  align="center">女</Excel:td>
			<Excel:td  align="center"></Excel:td>
			<Excel:td  align="center">女</Excel:td>
			<Excel:td  align="center"></Excel:td>
			<Excel:td  align="center">女</Excel:td>
			<Excel:td  align="center"></Excel:td>
			<Excel:td  align="center">女</Excel:td>
			<Excel:td  align="center"></Excel:td>
			<Excel:td  align="center">女</Excel:td>
			<Excel:td  align="center"></Excel:td>
			<Excel:td  align="center">女</Excel:td>
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
			<Excel:td align="right"><%=rec.get("TOTALNUMW")%></Excel:td>
			<Excel:td align="right"><%=rec.get("TYPE01")%></Excel:td>
			<Excel:td align="right"><%=rec.get("TYPE01W")%></Excel:td>
			<Excel:td align="right"><%=rec.get("TYPE02")%></Excel:td>
			<Excel:td align="right"><%=rec.get("TYPE02W")%></Excel:td>
			<Excel:td align="right"><%=rec.get("TYPE03")%></Excel:td>
			<Excel:td align="right"><%=rec.get("TYPE03W")%></Excel:td>
			<Excel:td align="right"><%=rec.get("TYPE04")%></Excel:td>
			<Excel:td align="right"><%=rec.get("TYPE04W")%></Excel:td>
			<Excel:td align="right"><%=rec.get("SALARY01")%></Excel:td>
			<Excel:td align="right"><%=rec.get("SALARY01W")%></Excel:td>
			<Excel:td align="right"><%=rec.get("SALARY02")%></Excel:td>
			<Excel:td align="right"><%=rec.get("SALARY02W")%></Excel:td>
			<Excel:td align="right"><%=rec.get("SALARY03")%></Excel:td>
			<Excel:td align="right"><%=rec.get("SALARY03W")%></Excel:td>
			<Excel:td align="right"><%=rec.get("SALARY04")%></Excel:td>
			<Excel:td align="right"><%=rec.get("SALARY04W")%></Excel:td>
		</Excel:tr>
		<%
					}
		%>	
		<Excel:tr border="0">
		<Excel:td  align="left" colspan="10" border="0">制表人：<%=BspUtil.getEmpOrgan().getShortName()%></Excel:td>
		<Excel:td  align="right" colspan="9" border="0">制表时间：<%=date %></Excel:td>
		</Excel:tr>
	</Excel:table>
</Excel:tablelist>