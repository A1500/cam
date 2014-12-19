<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="/tags/next-excel" prefix="Excel"%>
<%@page import="org.loushang.next.data.DataSet"%>
<%@page import="org.loushang.next.data.Record"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.inspur.cams.comm.util.*"%>
<%@page import="com.inspur.cams.drel.sam.dao.jdbc.SamSpecialAssistanceItemDao"%>
<%
    String domicileCode=request.getParameter("domicileCode");
    SamSpecialAssistanceItemDao dao=new SamSpecialAssistanceItemDao();
	ParameterSet pSet=new ParameterSet();
	pSet.setParameter("AREA_CODE", domicileCode.substring(0, 6)+"000000");
	pSet.setParameter("IN_USE", "1");
	DataSet itemDs=dao.query(pSet);
	String  assistanceTypeCode=request.getParameter("assistanceType");
	String  assitanceTypeText="";
	if("01".equals(assistanceTypeCode)){
		assitanceTypeText="城市低保";
	}else if("02".equals(assistanceTypeCode)){
		assitanceTypeText="农村低保";	
	}else if("03".equals(assistanceTypeCode)){
		assitanceTypeText="五保";	
	}else{
		assitanceTypeText="其他";	
	}
	out.clear();//清空缓存的内容
	out = pageContext.pushBody(); 
	String title=request.getParameter("releaseDate")+assitanceTypeText+"发放签字表";
%>
<%@page import="org.loushang.next.data.ParameterSet"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<Excel:tablelist filename="<%=title%>">
	<Excel:table border="1">
	<%--标题栏 --%>
		<Excel:tr>
			<Excel:td colspan="13" align="center"><%=request.getParameter("releaseDate")+assitanceTypeText %>发放签字表</Excel:td>
		</Excel:tr>
		<%
			SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
		%>
	<%--时间栏 --%>
		<Excel:tr>
			<Excel:td  align="left" colspan="13" border="0">制表单位：<%=BspUtil.getCorpOrgan().getOrganName()%></Excel:td>
		</Excel:tr>
		<Excel:tr>
			<Excel:td colspan="13" align="left">日期：<%=sdf.format(new java.util.Date())%></Excel:td>
		</Excel:tr>
	<%--列标题 --%>
		<Excel:tr bgcolor="grey">
			<Excel:td  align="center" rowspan="2">地区</Excel:td>
			<Excel:td  align="center" rowspan="2">姓名</Excel:td>
			<Excel:td  align="center" rowspan="2">身份证号</Excel:td>
			<Excel:td  align="center" rowspan="2">低保证号</Excel:td>
			<Excel:td  align="center" rowspan="2">保障人数</Excel:td>
			<Excel:td  align="center" rowspan="2">保障金（元）</Excel:td>
			<Excel:td  align="center" rowspan="2">分类施保金（元）</Excel:td>
			<%
				if(itemDs.getCount() > 0 ){
				%>	
					<Excel:td  align="center" colspan="<%=itemDs.getCount()%>">其他专项补贴金</Excel:td>
				<%
				}
			%>	
			
			<Excel:td  align="center" rowspan="2">发放合计（元）</Excel:td>
			<Excel:td  align="center" rowspan="2">居住地址</Excel:td>
			<Excel:td  align="center" rowspan="2">账户名称</Excel:td>
			<Excel:td  align="center" rowspan="2">开户银行</Excel:td>
			<Excel:td  align="center" rowspan="2">银行账号</Excel:td>
			<Excel:td  align="center" rowspan="2">领取人</Excel:td>
		</Excel:tr>
		
		<Excel:tr bgcolor="grey">
			<%for(int m=0;m<itemDs.getCount();m++){
				Record itemRecord=itemDs.getRecord(m);
				%>	
			<Excel:td  align="center" ><%=itemRecord.get("itemName")%></Excel:td>
			<%}%>
		</Excel:tr>
	<%--数据区 --%>
		<%
			DataSet dataset=(DataSet)request.getAttribute("dataset");
			for(int i=0;i<dataset.getCount();i++){
				Record record=dataset.getRecord(i);
				String  bank = "";
				if(record.get("BANK") != ""){
					bank= DicUtil.getTextValueFromDic("DIC_BANK","CODE",(String)record.get("BANK"),"NAME");
				}
		%>
		<Excel:tr>
			<Excel:td  align="center"  width="100"><%=record.get("DOMICILE_NAME")%></Excel:td>
			<Excel:td  align="center"  width="70"><%=record.get("NAME")%></Excel:td>
			<Excel:td align="center"  width="150"><%=record.get("ID_CARD")%></Excel:td>
			<Excel:td align="center"  width="150"><%=record.get("CARD_NO")%></Excel:td>
			<Excel:td align="right"  width="80"><%=record.get("ASSISTANCE_PEOPLE_NUM")%></Excel:td>
			<Excel:td  align="right" width="100"><%=record.get("BASE_MON")%></Excel:td>
			<Excel:td  align="right" width="100"><%=record.get("CLASS_MON")%></Excel:td>
			<%
			if(itemDs.getCount() > 0 ){
				for(int m=0;m<itemDs.getCount();m++){
					Record itemRecord=itemDs.getRecord(m);
					%>	
				
		
			
		
			<Excel:td  align="right"  ><%=record.get("A"+StringUtils.substring(StringUtils.upperCase((String)itemRecord.get("itemId")),15,32))%></Excel:td>
			<%	}
				}else{
				%>
				<%
			}	%>
			<Excel:td align="right"  width="100"><%=record.get("RELEASE_MON_SUM")%></Excel:td>
			<Excel:td align="center" width="200"><%=record.get("ADDRESS")%></Excel:td>
			<Excel:td width="100"><%=record.get("ACCOUNT_NAME")%></Excel:td>
			<Excel:td width="200"><%=bank%></Excel:td>
			<Excel:td align="center"  width="150"><%=record.get("ACCOUNT_NUMBER")%></Excel:td>
			<Excel:td ></Excel:td>
			
		</Excel:tr>
		<%
			}
		%>
	</Excel:table>
</Excel:tablelist>