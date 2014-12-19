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
	String title="骨灰去向统计_"+date;
	//out.clear();//清空缓存的内容
	//out = pageContext.pushBody(); 
%>
<!--导出Excel-->
<Excel:tablelist filename="<%=title%>">
	<Excel:table sheetname="骨灰去向统计" border="1">
		<Excel:tr>
			<Excel:td colspan="11" align="center" border="0"><Excel:font size="15">骨灰去向统计</Excel:font></Excel:td>
		</Excel:tr>
		<Excel:tr border="0">
		<Excel:td  align="left" colspan="6" border="0">填报单位：<%=BspUtil.getOrganName()%></Excel:td>
		<Excel:td  align="right" colspan="5" border="0">填报时间：<%=request.getParameter("statisticsTime")%></Excel:td>
		</Excel:tr>
		<Excel:tr border="1" bgcolor="grey">
			<Excel:td  align="center" rowspan="2">单位</Excel:td>
			<Excel:td  align="center" rowspan="2">总数</Excel:td>
			<Excel:td  align="center" colspan="9">骨灰去向</Excel:td>
			
		</Excel:tr>
		<Excel:tr border="1" bgcolor="grey">
			<Excel:td  align="center">户口所在地公益性公墓安葬（放）</Excel:td>
			<Excel:td  align="center">非户口所在地公益性公墓安葬（放）</Excel:td>
			<Excel:td  align="center">户口所在地经营性公墓安葬（放）</Excel:td>
			<Excel:td  align="center">非户口所在地经营性公墓安葬（放）</Excel:td>
			<Excel:td  align="center">自有坟地安葬（放）</Excel:td>
			<Excel:td  align="center">殡仪馆骨灰寄存</Excel:td>
			<Excel:td  align="center">骨灰撒散</Excel:td>
			<Excel:td  align="center">不要骨灰</Excel:td>
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
			
			<Excel:td align="right"><%=rec.get("TOTALNUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("ASHES01")%></Excel:td>
			
			<Excel:td align="right"><%=rec.get("ASHES02")%></Excel:td>
			<Excel:td align="right"><%=rec.get("ASHES03")%></Excel:td>
			
			<Excel:td align="right"><%=rec.get("ASHES04")%></Excel:td>
			<Excel:td align="right"><%=rec.get("ASHES05")%></Excel:td>
			
			<Excel:td align="right"><%=rec.get("ASHES06")%></Excel:td>
			<Excel:td align="right"><%=rec.get("ASHES07")%></Excel:td>
		    <Excel:td align="right"><%=rec.get("ASHES08")%></Excel:td>
			<Excel:td align="right"><%=rec.get("ASHES09")%></Excel:td>
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