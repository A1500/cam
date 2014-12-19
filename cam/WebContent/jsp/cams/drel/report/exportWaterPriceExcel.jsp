<%@ page contentType="charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/tags/next-excel" prefix="Excel"%>
<%@page import="org.loushang.next.data.DataSet"%>
<%@page import="org.loushang.next.data.Record"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<%@ page import="org.loushang.bsp.security.context.GetBspInfo"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.*"%>
<%@page import="com.inspur.cams.drel.sam.dao.jdbc.SamSpecialAssistanceItemDao"%>
<%@page import="org.loushang.next.data.ParameterSet"%>
<head>
<title>导出Excel</title>
<%
	SimpleDateFormat sdf=new SimpleDateFormat("yyyy年MM月dd日HH时mm分");
	SimpleDateFormat sdf2=new SimpleDateFormat("yyyy年MM月dd日");
	String startTime= request.getParameter("startTime");
	String date=sdf.format(new Date());
	String date2=sdf2.format(new Date());
	String name = startTime+"专项补贴资金明细_"+date;
	String username = GetBspInfo.getBspInfo(request).getUserName();
	out.clear();//清空缓存的内容
	out = pageContext.pushBody(); 
	SamSpecialAssistanceItemDao dao= new SamSpecialAssistanceItemDao();
	ParameterSet pset=new ParameterSet();
	pset.setParameter("AREA_CODE",BspUtil.getOrganCode());
	pset.setParameter("IN_USE","1");
	pset.setParameter("sort","ITEM_CODE");
	pset.setParameter("dir","ASC");
	DataSet typeDS=dao.query(pset);
	int k=typeDS.getCount(); 
	k=3*k+4;
	int t=k%2;
%>
</head>
<Excel:tablelist filename="<%=name %>">
	<Excel:table sheetname="专项补贴资金明细">
		<Excel:tr>
			<Excel:td colspan="<%=k%>" align="center" ><Excel:font size="15"  bold="true"><%=startTime+"专项补贴资金明细" %></Excel:font></Excel:td>
		</Excel:tr>
		<Excel:tr>
			<Excel:td colspan="<%=(k-t)/2 %>" align="left">统计单位：<%=BspUtil.getOrganName()%></Excel:td>
			<Excel:td colspan="<%=(k+t)/2 %>" align="right">统计时间:<%= startTime%></Excel:td>
		</Excel:tr>
		<Excel:tr height="30" bgcolor="grey" border="1">
			<Excel:td  align="center" width="100" rowspan="2"  bordercolor="black">单位</Excel:td>
			<%
				for(int i=0;i<typeDS.getCount();i++){
					Record rec=typeDS.getRecord(i); 
			%> 
			<Excel:td  align="center" width="100" colspan="3"  bordercolor="black"><%=rec.get("itemName") %></Excel:td>
			<%} %>
			<Excel:td  align="center" width="100" rowspan="2"  bordercolor="black">总户数</Excel:td>
			<Excel:td  align="center" width="100" rowspan="2" colspan="2"  bordercolor="black">所需资金总额（元）</Excel:td>				
		</Excel:tr>
		<Excel:tr height="20" bgcolor="grey" border="1">
			<%for(int i=0;i<typeDS.getCount();i++){ 
			%>
			<Excel:td  align="center" bordercolor="black" width="100">低保户数合计</Excel:td>
			<Excel:td  align="center" bordercolor="black" width="100">人数</Excel:td>			
			<Excel:td  align="center" bordercolor="black" width="100">所需资金（元）</Excel:td>
			<%} %>
		</Excel:tr>
		
		<%
			DataSet ds = (DataSet)request.getAttribute("dataset");
				for(int i=0; i<ds.getCount(); i++) {
					Record rec = ds.getRecord(i);
		%>
		<Excel:tr border="1">
			<Excel:td align="center" ><%=rec.get("NAME")%></Excel:td>
			<%for(int j=0;j<typeDS.getCount();j++){
			Record rec1=typeDS.getRecord(j); 
			%> 
			<Excel:td align="right" ><%=rec1.get("RELEASE_FAMILY_SUM"+(j+1))==null?"0":rec.get("RELEASE_FAMILY_SUM"+(j+1))%></Excel:td>
			<Excel:td align="right" ><%=rec1.get("ASSISTANCE_MON_SUM"+(j+1))==null?"0":rec.get("ASSISTANCE_MON_SUM"+(j+1))%></Excel:td>	
			<Excel:td align="right" ><%=rec1.get("ASSISTANCE_MON_SUM"+(j+1))==null?"0":rec.get("ASSISTANCE_MON_SUM"+(j+1))%></Excel:td>
			<%} %>
			<Excel:td align="right" ><%=rec.get("RELEASE_FAMILY_SUM")==null?"0":rec.get("RELEASE_FAMILY_SUM")%></Excel:td>
			<Excel:td align="right" colspan="2" ><%=rec.get("ASSISTANCE_MON_SUM")==null?"0":rec.get("ASSISTANCE_MON_SUM")%></Excel:td>	
		</Excel:tr>
		<%
			}
		%>
		<Excel:tr>
			<Excel:td colspan="<%=(k-t)/2 %>" align="left">制表人：<%= username%></Excel:td>
			<Excel:td colspan="<%=(k+t)/2 %>" align="right">制表时间：<%= date2%></Excel:td>
		</Excel:tr>
	</Excel:table>
</Excel:tablelist>

