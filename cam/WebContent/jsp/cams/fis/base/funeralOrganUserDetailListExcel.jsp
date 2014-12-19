<%@page contentType="charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="/tags/next-excel" prefix="Excel"%>
<%@page import="org.loushang.next.data.DataSet"%>
<%@page import="org.loushang.next.data.Record"%>
<%@page import="org.loushang.next.commons.nenum.EnumService" %>
<%@page import="org.loushang.sca.ScaComponentFactory" %>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<%@page import="java.util.*"%>
<%
	SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
	String date=sdf.format(new Date());
	String title="殡仪馆查询_"+date;
	out.clear();//清空缓存的内容
	out = pageContext.pushBody(); 
%>
<!--导出Excel-->
<Excel:tablelist filename="<%=title%>">
	<Excel:table sheetname="殡仪馆查询" border="1">
		<Excel:tr>
			<Excel:td colspan="10" align="center" border="0"><Excel:font size="15">殡仪馆查询</Excel:font></Excel:td>
		</Excel:tr>
		<Excel:tr border="0">
		<Excel:td  align="right" colspan="10" border="0">统计单位：<%=BspUtil.getOrganName()%></Excel:td>
		</Excel:tr>
		<Excel:tr  border="1" bgcolor="grey">
				<Excel:td width="100" align="center">殡仪馆编号</Excel:td>
				<Excel:td width="100" align="center">殡仪馆名称</Excel:td>
				<Excel:td width="100" align="center">性质</Excel:td>
				<Excel:td width="100" align="center">法人代表</Excel:td>
				<Excel:td width="100" align="center">成立时间</Excel:td>
				<Excel:td width="100" align="center">级别</Excel:td>
				<Excel:td width="100" align="center">殡葬改革示范单位</Excel:td>
				<Excel:td width="100" align="center">等级</Excel:td>
				<Excel:td width="100" align="center">主管单位</Excel:td>
				<Excel:td width="100" align="center">所属行政区</Excel:td>
		</Excel:tr>
		<%
				DataSet dataset = (DataSet) request.getAttribute("dataset");
					EnumService enumService = ScaComponentFactory.getService(EnumService.class, "Enum/EnumService");
					for (int i = 0; i < dataset.getCount(); i++){
						Record rec = dataset.getRecord(i);
						String properties="";
						String Title="";
						String demonUnit="";
						String grade="";
						if(rec.get("properties")!=null){
							properties =  enumService.getDescByValue("FIS.FUNERALHOME.PROPERTIES2", (String)rec.get("properties"));
						}
						if(rec.get("title")!=null){
							Title =  enumService.getDescByValue("FIS.FUNERALHOME.TITLE", (String)rec.get("title"));						
						}
						if(rec.get("demonUnit")!=null){
							demonUnit =  enumService.getDescByValue("FIS.FUNERALHOME.DEMONUNIT", (String)rec.get("demonUnit"));						
						}
						if(rec.get("grade")!=null){
							grade =  enumService.getDescByValue("FIS.FUNERALHOME.GRADE", (String)rec.get("grade"));						
						}
						
		%>
		<Excel:tr  border="1">
				<Excel:td align="center"><%=rec.get("unitId")%></Excel:td>
				<Excel:td align="center"><%=rec.get("unitName")%></Excel:td>
				<Excel:td align="center"><%=properties%></Excel:td>
				<Excel:td align="center"><%=rec.get("legalPeople")%></Excel:td>
				<Excel:td align="center"><%=rec.get("gestionTime")%></Excel:td>
				<Excel:td align="center"><%=Title%></Excel:td>
	 			<Excel:td align="center"><%=demonUnit%></Excel:td>
	 			<Excel:td align="center"><%=grade%></Excel:td>
	 			<Excel:td align="center"><%=rec.get("parentOrganName")%></Excel:td>
	 			<Excel:td align="center"><%=rec.get("areaName")%></Excel:td>
		</Excel:tr>
		<%
					}
		%>	
		<Excel:tr border="0">
		<Excel:td  align="left" colspan="5" border="0">制表人：<%=BspUtil.getEmpOrgan().getShortName()%></Excel:td>
		<Excel:td  align="right" colspan="5" border="0">制表时间：<%=date %></Excel:td>
		</Excel:tr>
	</Excel:table>
</Excel:tablelist>