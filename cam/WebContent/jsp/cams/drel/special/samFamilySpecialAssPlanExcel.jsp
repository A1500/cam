<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="/tags/next-excel" prefix="Excel"%>
<%@page import="org.loushang.next.data.DataSet"%>
<%@page import="org.loushang.next.data.Record"%>
<%@page import="java.text.SimpleDateFormat"%>
<%
	out.clear();//清空缓存的内容
	out = pageContext.pushBody(); 
%>
<Excel:tablelist filename="专项补贴">
	<Excel:table>
	<%--标题栏 --%>
		<Excel:tr>
			<Excel:td colspan="8" align="center">专项补贴列表</Excel:td>
		</Excel:tr>
		<%
			SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
		%>
	<%--时间栏 --%>
		<Excel:tr>
			<Excel:td colspan="8" align="left">日期：<%=sdf.format(new java.util.Date())%></Excel:td>
		</Excel:tr>
	<%--列标题 --%>
		<Excel:tr bgcolor="grey">
			<Excel:td  align="center">地区</Excel:td>
			<Excel:td  align="center">救助对象类别</Excel:td>
			<Excel:td  align="center">发放年月</Excel:td>
			<Excel:td  align="center">救助目标</Excel:td>
			<Excel:td  width="200" align="center">发放标准（元/救助对象）</Excel:td>
			<Excel:td  align="center">发放总户数</Excel:td>
			<Excel:td  align="center">发放总额（元）</Excel:td>
			<Excel:td  align="center">补贴项目</Excel:td>
			<Excel:td  align="center">状态</Excel:td>
		</Excel:tr>
	<%--数据区 --%>
		<%
			DataSet dataset=(DataSet)request.getAttribute("dataset");
			for(int i=0;i<dataset.getCount();i++){
				Record record=dataset.getRecord(i);
				String  assitanceType="";
				if("01".equals(record.get("assistanceType"))){
					assitanceType="城市低保";
				}else if("02".equals(record.get("assistanceType"))){
					assitanceType="农村低保";	
				}else if("03".equals(record.get("assistanceType"))){
					assitanceType="五保";	
				}else{
					assitanceType="其他";	
				}
				String  releaseTarget="";
				if("1".equals(record.get("releaseTarget"))){
					releaseTarget="家庭";
				}else if("2".equals(record.get("releaseTarget"))){
					releaseTarget="个人";	
				}
				String  releaseStatus="";
				if("00".equals(record.get("releaseStatus"))){
					releaseStatus="生成中";
				}
				if("01".equals(record.get("releaseStatus"))){
					releaseStatus="已生成";
				}else if("02".equals(record.get("releaseStatus"))){
					releaseStatus="已确认";	
				}
		%>
		<Excel:tr>
			<Excel:td><%=record.get("releaseAreaName")%></Excel:td>
			<Excel:td width="100"><%=assitanceType%></Excel:td>
			<Excel:td><%=record.get("releaseDate")%></Excel:td>
			<Excel:td width="180"><%=releaseTarget%></Excel:td>
			<Excel:td width="100"><%=record.get("releaseStandard")%></Excel:td>
			<Excel:td width="100"><%=record.get("releaseFamilySum")%></Excel:td>
			<Excel:td width="100"><%=record.get("releaseFundSum")%></Excel:td>
			<Excel:td width="100"><%=record.get("releaseItem")%></Excel:td>
			<Excel:td width="100"><%=releaseStatus%></Excel:td>
		</Excel:tr>
		<%
			}
		%>
	</Excel:table>
</Excel:tablelist>