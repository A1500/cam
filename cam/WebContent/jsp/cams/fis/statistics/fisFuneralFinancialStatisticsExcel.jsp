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
    String queryCondition = request.getParameter("queryCondition");
	SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
	String date=sdf.format(new Date());
	String title="殡仪馆财政收支情况统计表_"+date;
	out.clear();//清空缓存的内容
	out = pageContext.pushBody(); 
%>
<!--导出Excel-->
<Excel:tablelist filename="<%=title%>">
	<Excel:table sheetname="殡仪馆工作人员统计表" border="1">
		<Excel:tr>
			<Excel:td colspan="14" align="center" border="0"><Excel:font size="15">殡仪馆财政收支情况统计表</Excel:font></Excel:td>
		</Excel:tr>
		<Excel:tr border="0">
		<Excel:td  align="left" colspan="7" border="0">填报单位：<%=BspUtil.getOrganName()%></Excel:td>
		<Excel:td  align="right" colspan="7" border="0">统计时间段：<%=queryCondition%></Excel:td>
		</Excel:tr>
		<Excel:tr border="1" bgcolor="grey">
			<Excel:td  align="center" rowspan="2">单位</Excel:td>
			<Excel:td  align="center" colspan="1" rowspan="2">结余</Excel:td>
			<Excel:td  align="center" colspan="5">收入（万元）</Excel:td>
			<Excel:td  align="center" colspan="7">支出（万元）</Excel:td>
		</Excel:tr>
		<Excel:tr border="1" bgcolor="grey">
			<Excel:td  align="center" >服务收入</Excel:td>
			<Excel:td  align="center" >财政拨款</Excel:td>
			<Excel:td  align="center" >福彩公益金</Excel:td>
			<Excel:td  align="center" >银行贷款</Excel:td>
			<Excel:td  align="center" >其他</Excel:td>
			<Excel:td  align="center" >服务成本</Excel:td>
			<Excel:td  align="center" >人员工资</Excel:td>
			<Excel:td  align="center" >财政提留</Excel:td>
			<Excel:td  align="center" >纳税</Excel:td>
			<Excel:td  align="center" >基建</Excel:td>
			<Excel:td  align="center" >设备采购</Excel:td>
			<Excel:td  align="center" >其他</Excel:td>
		</Excel:tr>
		<%
				DataSet dataset = (DataSet) request.getAttribute("dataset");
					EnumService enumService = ScaComponentFactory.getService(EnumService.class, "Enum/EnumService");
					for (int i = 0; i < dataset.getCount(); i++){
						Record rec = dataset.getRecord(i);
						
		%>
		<Excel:tr  border="1">
		    <Excel:td align="center"><%=rec.get("NAME")%></Excel:td>
			<Excel:td align="center"><%=rec.get("INCOMESUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("SERVICE_INCOMESUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("FUND_FINANCESUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("FUND_LOTTERYSUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("FUND_BANKSUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("OTHER_INCOMESUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("SERVICE_COSTSUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("EMPLOYEE_SALARYSUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("FISCAL_RESERVESUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("TAX_COSTSUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("INFRASTRUCTURE_COSTSUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("EQUIPMENT_COSTSUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("OTHER_COSTSUM")%></Excel:td>
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