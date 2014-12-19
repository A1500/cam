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
	String title="殡仪馆工作人员统计表（二）_"+date;
	//out.clear();//清空缓存的内容
	//out = pageContext.pushBody(); 
%>
<!--导出Excel-->
<Excel:tablelist filename="<%=title%>">
	<Excel:table sheetname="殡仪馆工作人员统计表（二）" border="1">
		<Excel:tr>
			<Excel:td colspan="23" align="center" border="0"><Excel:font size="15">殡仪馆工作人员统计表（二）</Excel:font></Excel:td>
		</Excel:tr>
		<Excel:tr border="0">
		<Excel:td  align="left" colspan="8" border="0">填报单位：<%=BspUtil.getOrganName()%></Excel:td>
		
		</Excel:tr>
		<Excel:tr border="1" bgcolor="grey">
			<Excel:td  align="center" rowspan="3">单位</Excel:td>
			<Excel:td  align="center" colspan="2" rowspan="2">人员总数</Excel:td>
			<Excel:td  align="center" colspan="6">年龄</Excel:td>
			<Excel:td  align="center" colspan="6">学历</Excel:td>
			<Excel:td  align="center" colspan="8">政治面貌</Excel:td>
		</Excel:tr>
		<Excel:tr border="1" bgcolor="grey">
			<Excel:td  align="center" colspan="2">35岁以下</Excel:td>
			<Excel:td  align="center" colspan="2">36-49岁</Excel:td>
			<Excel:td  align="center" colspan="2">50岁以上</Excel:td>
			<Excel:td  align="center" colspan="2">大专以上</Excel:td>
			<Excel:td  align="center" colspan="2">高中</Excel:td>
			<Excel:td  align="center" colspan="2">初中以下</Excel:td>
			<Excel:td  align="center" colspan="2">党员</Excel:td>
			<Excel:td  align="center" colspan="2">团员</Excel:td>
			<Excel:td  align="center" colspan="2">民主党派</Excel:td>
			<Excel:td  align="center" colspan="2">群众</Excel:td>
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
			<Excel:td align="right"><%=rec.get("BIR01")%></Excel:td>
			<Excel:td align="right"><%=rec.get("BIR01W")%></Excel:td>
			<Excel:td align="right"><%=rec.get("BIR02")%></Excel:td>
			<Excel:td align="right"><%=rec.get("BIR02W")%></Excel:td>
			<Excel:td align="right"><%=rec.get("BIR03")%></Excel:td>
			<Excel:td align="right"><%=rec.get("BIR03W")%></Excel:td>
			<Excel:td align="right"><%=rec.get("EDU01")%></Excel:td>
			<Excel:td align="right"><%=rec.get("EDU01W")%></Excel:td>
			<Excel:td align="right"><%=rec.get("EDU02")%></Excel:td>
			<Excel:td align="right"><%=rec.get("EDU02W")%></Excel:td>
			<Excel:td align="right"><%=rec.get("EDU03")%></Excel:td>
			<Excel:td align="right"><%=rec.get("EDU03W")%></Excel:td>
			<Excel:td align="right"><%=rec.get("POL01")%></Excel:td>
			<Excel:td align="right"><%=rec.get("POL01W")%></Excel:td>
			<Excel:td align="right"><%=rec.get("POL02")%></Excel:td>
			<Excel:td align="right"><%=rec.get("POL02W")%></Excel:td>
			<Excel:td align="right"><%=rec.get("POL03")%></Excel:td>
			<Excel:td align="right"><%=rec.get("POL03W")%></Excel:td>
			<Excel:td align="right"><%=rec.get("POL04")%></Excel:td>
			<Excel:td align="right"><%=rec.get("POL04W")%></Excel:td>
		</Excel:tr>
		<%
					}
		%>	
		<Excel:tr border="0">
		<Excel:td  align="left" colspan="11" border="0">制表人：<%=BspUtil.getEmpOrgan().getShortName()%></Excel:td>
		<Excel:td  align="right" colspan="12" border="0">制表时间：<%=date %></Excel:td>
		</Excel:tr>
	</Excel:table>
</Excel:tablelist>