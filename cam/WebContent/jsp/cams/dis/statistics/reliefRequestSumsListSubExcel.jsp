<%@ page contentType="charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/tags/next-excel" prefix="Excel"%>
<%@page import="org.loushang.next.data.DataSet"%>
<%@page import="org.loushang.next.data.Record"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<%@page import="org.loushang.next.commons.nenum.EnumService" %>
<%@page import="org.loushang.sca.ScaComponentFactory" %>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.*"%>
<head>
<title>导出Excel</title>
<%!
	
	SimpleDateFormat sdf=new SimpleDateFormat("yyyy年MM月dd日HH时mm分");
	SimpleDateFormat sdf2=new SimpleDateFormat("yyyy年MM月dd日");
	String date=sdf.format(new Date());
	String date2=sdf2.format(new Date());
	String name="救灾需求统计_"+date;
%>
<%
	String reliefType = (String)request.getParameter("reliefType");
%>
</head>
<Excel:tablelist filename="<%=name %>">
	<Excel:table sheetname="查询列表">
		<Excel:tr>
			<%
				if ("DC".equals(reliefType)) {
			%>
			<Excel:td colspan="6" align="center" ><Excel:font size="20">救灾需求统计</Excel:font></Excel:td>
			<%
				}else if("SW".equals(reliefType)){
			%>
			<Excel:td colspan="3" align="center" ><Excel:font size="20">救灾需求统计</Excel:font></Excel:td>
			<%
				}else if("YJ".equals(reliefType)){
			%>
			<Excel:td colspan="6" align="center" ><Excel:font size="20">救灾需求统计</Excel:font></Excel:td>
			<%
				}else if("GD".equals(reliefType)){
			%>
			<Excel:td colspan="6" align="center" ><Excel:font size="20">救灾需求统计</Excel:font></Excel:td>
			<%
				}else if("CJ".equals(reliefType)){
			%>
			<Excel:td colspan="5" align="center" ><Excel:font size="20">救灾需求统计</Excel:font></Excel:td>
			<%
				}else{
			%>
			<Excel:td colspan="22" align="center" ><Excel:font size="20">救灾需求统计</Excel:font></Excel:td>
			<%
				}
			%>
		</Excel:tr>
		<Excel:tr>
			<Excel:td colspan="6" align="left">统计单位：<%= BspUtil.getOrganName()%></Excel:td>
		</Excel:tr>
		<Excel:tr height="30" bgcolor="grey" border="1">
			<Excel:td  align="center" valign="center" width="180" bordercolor="black" rowspan="2" >单位</Excel:td>
			<% 
				if("DC".equals(reliefType)){
			%>
			<Excel:td  align="center" width="100" bordercolor="black" colspan="5" >冬春救助</Excel:td>
			<%
				}else if("SW".equals(reliefType)){
			%>
			<Excel:td  align="center" width="100" bordercolor="black" colspan="2" >遇难人员家属抚慰</Excel:td>
			<%
				}else if("YJ".equals(reliefType)){
			%>
			<Excel:td  align="center" width="100" bordercolor="black" colspan="5">应急救助</Excel:td>
			<%
				}else if("GD".equals(reliefType)){
			%>
			<Excel:td  align="center" width="100" bordercolor="black" colspan="5">过渡救助</Excel:td>
			<%
				}else if("CJ".equals(reliefType)){
			%>
			<Excel:td  align="center" width="100" bordercolor="black" colspan="4">灾区民房恢复重建补助</Excel:td>
			<%
				}else{
			%>
			<Excel:td  align="center" width="100" bordercolor="black" colspan="5" >冬春救助</Excel:td>
			<Excel:td  align="center" width="100" bordercolor="black" colspan="2" >遇难人员家属抚慰</Excel:td>
			<Excel:td  align="center" width="100" bordercolor="black" colspan="5">应急救助</Excel:td>
			<Excel:td  align="center" width="100" bordercolor="black" colspan="5">过渡救助</Excel:td>
			<Excel:td  align="center" width="100" bordercolor="black" colspan="4">灾区民房恢复重建补助</Excel:td>
		    <%
				}
			%>	
		</Excel:tr>
		<Excel:tr height="30" bgcolor="grey" border="1">
			<% 
				if("DC".equals(reliefType)){
			%>
			<Excel:td  align="center" width="100" bordercolor="black">救助户数</Excel:td>
			<Excel:td  align="center" width="100" bordercolor="black">救助口粮(公斤)</Excel:td>
			<Excel:td  align="center" width="100" bordercolor="black">救助衣被(件)</Excel:td>
			<Excel:td  align="center" width="100" bordercolor="black">救助饮水(元)</Excel:td>
			<Excel:td  align="center" width="100" bordercolor="black">救助金额(元)</Excel:td>
			<%
				}else if("SW".equals(reliefType)){
			%>
			<Excel:td  align="center" width="100" bordercolor="black">救助户数</Excel:td>
			<Excel:td  align="center" width="100" bordercolor="black">救助金额(元)</Excel:td>
			<%
				}else if("YJ".equals(reliefType)){
			%>
			<Excel:td  align="center" width="100" bordercolor="black">救助户数</Excel:td>
			<Excel:td  align="center" width="100" bordercolor="black">救助口粮(公斤)</Excel:td>
			<Excel:td  align="center" width="100" bordercolor="black">救助衣被(件)</Excel:td>
			<Excel:td  align="center" width="100" bordercolor="black">救助饮水(元)</Excel:td>
			<Excel:td  align="center" width="100" bordercolor="black">救助金额(元)</Excel:td>
			<%
				}else if("GD".equals(reliefType)){
			%>
			<Excel:td  align="center" width="100" bordercolor="black">救助户数</Excel:td>
			<Excel:td  align="center" width="100" bordercolor="black">救助口粮(公斤)</Excel:td>
			<Excel:td  align="center" width="100" bordercolor="black">救助衣被(件)</Excel:td>
			<Excel:td  align="center" width="100" bordercolor="black">救助饮水(元)</Excel:td>
			<Excel:td  align="center" width="100" bordercolor="black">救助金额(元)</Excel:td>
			<%
				}else if("CJ".equals(reliefType)){
			%>
			<Excel:td  align="center" width="100" bordercolor="black">救助户数</Excel:td>
			<Excel:td  align="center" width="100" bordercolor="black">重建间数</Excel:td>
			<Excel:td  align="center" width="100" bordercolor="black">修缮间数</Excel:td>
			<Excel:td  align="center" width="100" bordercolor="black">救助金额(元)</Excel:td>
			<%
				}else{
			%>
			<Excel:td  align="center" width="100" bordercolor="black">救助户数</Excel:td>
			<Excel:td  align="center" width="100" bordercolor="black">救助口粮(公斤)</Excel:td>
			<Excel:td  align="center" width="100" bordercolor="black">救助衣被(件)</Excel:td>
			<Excel:td  align="center" width="100" bordercolor="black">救助饮水(元)</Excel:td>
			<Excel:td  align="center" width="100" bordercolor="black">救助金额(元)</Excel:td>
			<Excel:td  align="center" width="100" bordercolor="black">救助户数</Excel:td>
			<Excel:td  align="center" width="100" bordercolor="black">救助金额(元)</Excel:td>
			<Excel:td  align="center" width="100" bordercolor="black">救助户数</Excel:td>
			<Excel:td  align="center" width="100" bordercolor="black">救助口粮(公斤)</Excel:td>
			<Excel:td  align="center" width="100" bordercolor="black">救助衣被(件)</Excel:td>
			<Excel:td  align="center" width="100" bordercolor="black">救助饮水(元)</Excel:td>
			<Excel:td  align="center" width="100" bordercolor="black">救助金额(元)</Excel:td>
			<Excel:td  align="center" width="100" bordercolor="black">救助户数</Excel:td>
			<Excel:td  align="center" width="100" bordercolor="black">救助口粮(公斤)</Excel:td>
			<Excel:td  align="center" width="100" bordercolor="black">救助衣被(件)</Excel:td>
			<Excel:td  align="center" width="100" bordercolor="black">救助饮水(元)</Excel:td>
			<Excel:td  align="center" width="100" bordercolor="black">救助金额(元)</Excel:td>
			<Excel:td  align="center" width="100" bordercolor="black">救助户数</Excel:td>
			<Excel:td  align="center" width="100" bordercolor="black">重建间数</Excel:td>
			<Excel:td  align="center" width="100" bordercolor="black">修缮间数</Excel:td>
			<Excel:td  align="center" width="100" bordercolor="black">救助金额(元)</Excel:td>
			<%
				}
			%>
		</Excel:tr>
		<%
			String familyRegister="";
			String familyType="";
			String workflowStatus="";
			DataSet ds = (DataSet)request.getAttribute("dataset");
			EnumService enumService = ScaComponentFactory.getService(EnumService.class, "Enum/EnumService");
			for(int i=0; i<ds.getCount(); i++) {
				Record rec = ds.getRecord(i);
				if(rec.get("familyRegister")!=null){
					familyRegister =  enumService.getDescByValue("DIS.FAMILY_REGISTER", (String)rec.get("familyRegister"));
				}
				if(rec.get("familyType")!=null){
					familyType =  enumService.getDescByValue("DIS.FAMILY_TYPE", (String)rec.get("familyType"));
				}
				if(rec.get("workflowStatus")!=null){
					workflowStatus =  enumService.getDescByValue("DIS.RELIEFINFO_WORKFLOW_STATE", (String)rec.get("workflowStatus"));
				}
	
		%>
		<Excel:tr border="1">
			<Excel:td align="left"><%=rec.get("ORGAN_NAME")%></Excel:td>
			<% 
				if("DC".equals(reliefType)){
			%>
			<Excel:td align="center"><%=rec.get("DCNUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("DCFOOD")%></Excel:td>
			<Excel:td align="right"><%=rec.get("DCCLOTHES")%></Excel:td>
			<Excel:td align="right"><%=rec.get("DCWATER")%></Excel:td>
			<Excel:td align="right"><%=rec.get("DCMONEY")%></Excel:td>
			<%
				}else if("SW".equals(reliefType)){
			%>
			<Excel:td align="center"><%=rec.get("SWNUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("SWMONEY")%></Excel:td>
			<%
				}else if("YJ".equals(reliefType)){
			%>
			<Excel:td align="center"><%=rec.get("YJNUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("YJFOOD")%></Excel:td>
			<Excel:td align="right"><%=rec.get("YJCLOTHES")%></Excel:td>
			<Excel:td align="right"><%=rec.get("YJWATER")%></Excel:td>
			<Excel:td align="right"><%=rec.get("YJMONEY")%></Excel:td>
			<%
				}else if("GD".equals(reliefType)){
			%>
			<Excel:td align="center"><%=rec.get("GDNUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("GDFOOD")%></Excel:td>
			<Excel:td align="right"><%=rec.get("GDCLOTHES")%></Excel:td>
			<Excel:td align="right"><%=rec.get("GDWATER")%></Excel:td>
			<Excel:td align="right"><%=rec.get("GDMONEY")%></Excel:td>
			<%
				}else if("CJ".equals(reliefType)){
			%>
			<Excel:td align="center"><%=rec.get("CJNUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("CJRBHOUSE")%></Excel:td>
			<Excel:td align="right"><%=rec.get("CJRPHOUSE")%></Excel:td>
			<Excel:td align="right"><%=rec.get("CJMONEY")%></Excel:td>
			<%
				}else{
			%>
			<Excel:td align="center"><%=rec.get("DCNUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("DCFOOD")%></Excel:td>
			<Excel:td align="right"><%=rec.get("DCCLOTHES")%></Excel:td>
			<Excel:td align="right"><%=rec.get("DCWATER")%></Excel:td>
			<Excel:td align="right"><%=rec.get("DCMONEY")%></Excel:td>
			<Excel:td align="center"><%=rec.get("SWNUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("SWMONEY")%></Excel:td>
			<Excel:td align="center"><%=rec.get("YJNUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("YJFOOD")%></Excel:td>
			<Excel:td align="right"><%=rec.get("YJCLOTHES")%></Excel:td>
			<Excel:td align="right"><%=rec.get("YJWATER")%></Excel:td>
			<Excel:td align="right"><%=rec.get("YJMONEY")%></Excel:td>
			<Excel:td align="center"><%=rec.get("GDNUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("GDFOOD")%></Excel:td>
			<Excel:td align="right"><%=rec.get("GDCLOTHES")%></Excel:td>
			<Excel:td align="right"><%=rec.get("GDWATER")%></Excel:td>
			<Excel:td align="right"><%=rec.get("GDMONEY")%></Excel:td>
			<Excel:td align="center"><%=rec.get("CJNUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("CJRBHOUSE")%></Excel:td>
			<Excel:td align="right"><%=rec.get("CJRPHOUSE")%></Excel:td>
			<Excel:td align="right"><%=rec.get("CJMONEY")%></Excel:td>
			<%
				}
			%>
		</Excel:tr>
		<%
			}
		%>
		<Excel:tr>
			<%
				if ("DC".equals(reliefType)) {
			%>
			<Excel:td colspan="3" align="left">制表人：<%= BspUtil.getOrganName()%></Excel:td>
			<Excel:td colspan="3" align="right">制表时间：<%= date2%></Excel:td>
			<%
				}else if("SW".equals(reliefType)){
			%>
			<Excel:td colspan="1" align="left">制表人：<%= BspUtil.getOrganName()%></Excel:td>
			<Excel:td colspan="2" align="right">制表时间：<%= date2%></Excel:td>
			<%
				}else if("YJ".equals(reliefType)){
			%>
			<Excel:td colspan="3" align="left">制表人：<%= BspUtil.getOrganName()%></Excel:td>
			<Excel:td colspan="3" align="right">制表时间：<%= date2%></Excel:td>
			<%
				}else if("GD".equals(reliefType)){
			%>
			<Excel:td colspan="3" align="left">制表人：<%= BspUtil.getOrganName()%></Excel:td>
			<Excel:td colspan="3" align="right">制表时间：<%= date2%></Excel:td>
			<%
				}else if("CJ".equals(reliefType)){
			%>
			<Excel:td colspan="3" align="left">制表人：<%= BspUtil.getOrganName()%></Excel:td>
			<Excel:td colspan="2" align="right">制表时间：<%= date2%></Excel:td>
			<%
				}else{
			%>
			<Excel:td colspan="11" align="left">制表人：<%= BspUtil.getOrganName()%></Excel:td>
			<Excel:td colspan="11" align="right">制表时间：<%= date2%></Excel:td>
			<%
				}
			%>
		</Excel:tr>
	</Excel:table>
</Excel:tablelist>

