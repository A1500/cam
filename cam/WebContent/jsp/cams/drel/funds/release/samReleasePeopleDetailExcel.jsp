<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="/tags/next-excel" prefix="Excel"%>
<%@page import="org.loushang.next.data.DataSet"%>
<%@page import="org.loushang.next.data.Record"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<%@page import="com.inspur.cams.drel.sam.dao.jdbc.SamSpecialAssistanceItemDao"%>
<%@page import="org.loushang.next.commons.nenum.EnumService" %>
<%@page import="org.loushang.sca.ScaComponentFactory" %>
<%@page import="java.util.*"%>
<%@page import="com.inspur.cams.comm.dicm.IDicDao"%>
<%@page import="org.loushang.next.dao.DaoFactory"%>
<%
	SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
	out.clear();//清空缓存的内容
	out = pageContext.pushBody(); 
	String title="家庭成员信息";
	String assistanceType = request.getParameter("assistanceType");
%>
<%@page import="org.loushang.next.data.ParameterSet"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<Excel:tablelist filename="<%=title%>">
	<Excel:table border="1">
	<%--标题栏 --%>
		<Excel:tr>
			<Excel:td colspan="9" align="center"><Excel:font size="16">家庭成员信息</Excel:font></Excel:td>
		</Excel:tr>
	<%--时间栏 --%>
		<Excel:tr>
			<Excel:td  align="left" colspan="4" border="0">制表单位：<%=BspUtil.getCorpOrgan().getOrganName()%></Excel:td>
			<Excel:td colspan="5" align="right">日期：<%=sdf.format(new java.util.Date())%></Excel:td>
		</Excel:tr>
	<%--列标题 --%>
		<Excel:tr bgcolor="grey">
			<Excel:td  align="center" width="100" >地区</Excel:td>
			<Excel:td  align="center" width="100">姓名</Excel:td>
			<Excel:td  align="center" width="150">身份证号</Excel:td>
			<Excel:td  align="center" width="100">性别</Excel:td>
			<Excel:td  align="center" width="100">户主姓名</Excel:td>
			<%
				if(!"03".equals(assistanceType)) {
			%>
			<Excel:td  align="center" width="100">是否保障对象</Excel:td>
			<%
				} 
			%>
			<Excel:td  align="center" width="100">与户主关系</Excel:td>
			<%
				if("01".equals(assistanceType)) {
			%>
				<Excel:td  align="center" width="100">月收入（元）</Excel:td>
			<%
				} else if("02".equals(assistanceType)){
			%>
				<Excel:td  align="center" width="100">年收入（元）</Excel:td>
			<%} %>
			
			<Excel:td  align="center" width="100">健康状况</Excel:td>
			<Excel:td  align="center" width="100">婚姻状况</Excel:td>
			<Excel:td  align="center" width="180">教育状况</Excel:td>
		</Excel:tr>

	<%--数据区 --%>
		<%
			String sex="";
			String healthCode = "";
			DataSet dataset=(DataSet)request.getAttribute("dataset");
			EnumService enumService = ScaComponentFactory.getService(EnumService.class, "Enum/EnumService");
			IDicDao dao = (IDicDao) DaoFactory.getDao("com.inspur.cams.comm.dicm.DicDao");
			for(int i=0;i<dataset.getCount();i++){
				Record record=dataset.getRecord(i);
				if(record.get("SEX")!=null){
					sex =  enumService.getDescByValue("COMM.SEX", (String)record.get("SEX"));
				}
				if(record.get("MARRIAGE_CODE") != null ){
					record.set("MARRIAGE_CODE",dao.getValueByValue("DIC_MARRIAGE","NAME",(String)record.get("MARRIAGE_CODE")));
				}
				if(record.get("HEALTH_CODE")!=null){
					healthCode =  enumService.getDescByValue("SAM_HEALTH_CODE", (String)record.get("HEALTH_CODE"));
				}
				if(record.get("IS_ASSISTANCE")!=null){
					record.set("IS_ASSISTANCE", enumService.getDescByValue("comm_yesorno", (String)record.get("IS_ASSISTANCE")));
				}
				
				if(record.get("EDU_CODE") != null ){
					record.set("EDU_CODE",dao.getValueByValue("DIC_EDUCATION","NAME",(String)record.get("EDU_CODE")));
				}
				if(record.get("RELATIONSHIP_TYPE") != null ){
					record.set("RELATIONSHIP_TYPE",dao.getValueByValue("DIC_RELATIONSHIP_TYPE","NAME",(String)record.get("RELATIONSHIP_TYPE")));
				}
				
		%>
		<Excel:tr>
			<Excel:td  align="center"  width="100"><%=record.get("DOMICILE_NAME")%></Excel:td>
			<Excel:td  align="center"  width="100"><%=record.get("NAME")%></Excel:td>
			<Excel:td align="center"  width="150"><%=record.get("ID_CARD")%></Excel:td>
			<Excel:td align="center"  width="100"><%=sex%></Excel:td>
			<Excel:td  align="center" width="100"><%=record.get("FAMILY_NAME")%></Excel:td>
			<%
				if(!"03".equals(assistanceType)) {
			%>
			<Excel:td  align="center" width="100"><%=record.get("IS_ASSISTANCE")%></Excel:td>
			<%
				} 
			%>
			<Excel:td  align="center" width="100"><%=record.get("RELATIONSHIP_TYPE")%></Excel:td>
			<%
				if("01".equals(assistanceType)) {
			%>
				<Excel:td  align="right" width="100"><%=record.get("INCOME_MONTH")%></Excel:td>
			<%
				} else if("02".equals(assistanceType)){
			%>
				<Excel:td  align="right" width="100"><%=record.get("INCOME_YEAR")%></Excel:td>
			<%} %>
			<Excel:td align="center"  width="100"><%=healthCode%></Excel:td>
			<Excel:td  align="center" width="100"><%=record.get("MARRIAGE_CODE")%></Excel:td>
			<Excel:td  align="center" width="180"><%=record.get("EDU_CODE")%></Excel:td>
		</Excel:tr>
		<%
			}
		%>
	</Excel:table>
</Excel:tablelist>