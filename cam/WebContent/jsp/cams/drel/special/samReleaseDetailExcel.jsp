<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="/tags/next-excel" prefix="Excel"%>
<%@page import="org.loushang.next.data.DataSet"%>
<%@page import="org.loushang.next.data.Record"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<%	String  assistanceTypeCode=request.getParameter("assistanceType");
String  assitanceTypeText="";
if("01".equals(assistanceTypeCode)){
	assitanceTypeText="城市低保";
}else if("02".equals(assistanceTypeCode)){
	assitanceTypeText="农村低保";	
}else if("03".equals(assistanceTypeCode)){
	assitanceTypeText="五保";	
}else{
	assitanceTypeText="";	
}
	out.clear();//清空缓存的内容
	out = pageContext.pushBody(); 
	String title=request.getParameter("releaseDate")+assitanceTypeText+"专项补贴明细";
%>
<Excel:tablelist filename="<%=title%>">
	<Excel:table>
	<%--标题栏 --%>
		<Excel:tr>
			<Excel:td colspan="10" align="center"><%=request.getParameter("releaseDate")+assitanceTypeText %>专项补贴明细</Excel:td>
		</Excel:tr>
		<%
			SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
		%>
	<%--时间栏 --%>
		<Excel:tr>
			<Excel:td  align="left" colspan="10" border="0">制表单位：<%=BspUtil.getCorpOrgan().getOrganName()%></Excel:td>
		</Excel:tr>
		<Excel:tr>
			<Excel:td colspan="10" align="left">日期：<%=sdf.format(new java.util.Date())%></Excel:td>
		</Excel:tr>
	<%--列标题 --%>
		<Excel:tr bgcolor="grey">
			<Excel:td  align="center">地区</Excel:td>
			<Excel:td  align="center">姓名</Excel:td>
			<Excel:td  align="center">身份证号</Excel:td>
			<Excel:td  align="center">保障人数</Excel:td>
			<Excel:td  align="center">救助金（元）</Excel:td>
			<Excel:td  align="center">发放合计（元）</Excel:td>
			<Excel:td  align="center">专项救助对象</Excel:td>
			<Excel:td  align="center">账户名称</Excel:td>
			<Excel:td  align="center">开户银行</Excel:td>
			<Excel:td  align="center">账号</Excel:td>
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
				String  bank="";
				if("102".equals(record.get("bank"))){
					bank="中国工商银行";
				}else if("103".equals(record.get("bank"))){
					bank="中国农业银行";	
				}else if("104".equals(record.get("bank"))){
					bank="中国银行";	
				}else if("105".equals(record.get("bank"))){
					bank="中国建设银行";	
				}else if("301".equals(record.get("bank"))){
					bank="交通银行";	
				}else if("302".equals(record.get("bank"))){
					bank="中信银行";	
				}else if("304".equals(record.get("bank"))){
					bank="华夏银行";	
				}else if("308".equals(record.get("bank"))){
					bank="招商银行";	
				}else if("309".equals(record.get("bank"))){
					bank="中国邮政储蓄银行";	
				}
		%>
		<Excel:tr>
			<Excel:td width="200"><%=record.get("domicileName")%></Excel:td>
			<Excel:td width="100"><%=record.get("name")%></Excel:td>
			<Excel:td width="200"><%=record.get("idCard")%></Excel:td>
			<Excel:td width="100"><%=assitanceType%></Excel:td>
			<Excel:td width="100"><%=record.get("assistancePeopleNum")%></Excel:td>
			<Excel:td width="100"><%=record.get("releaseMonSum")%></Excel:td>
			<Excel:td width="100"><%=record.get("baseMon")%></Excel:td>
			<Excel:td width="100"><%=record.get("accountName")%></Excel:td>
			<Excel:td width="200"><%=bank%></Excel:td>
			<Excel:td width="200"><%=record.get("accountNumber")%></Excel:td>
		</Excel:tr>
		<%
			}
		%>
	</Excel:table>
</Excel:tablelist>