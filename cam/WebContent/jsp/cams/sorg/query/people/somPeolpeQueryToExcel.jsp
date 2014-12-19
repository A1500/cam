<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="/tags/next-excel" prefix="Excel"%>
<%@page import="org.loushang.next.data.DataSet"%>
<%@page import="org.loushang.next.data.Record"%>
<%@page import="java.text.SimpleDateFormat"%>
<Excel:tablelist filename="社会组织人员查询报表">
	<Excel:table>
	<%--标题栏 --%>
		<Excel:tr>
			<Excel:td colspan="8" align="center">社会组织人员查询报表</Excel:td>
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
			<Excel:td  align="center" width="100">姓名</Excel:td>
			<Excel:td  align="center" width="150">身份证号</Excel:td>
			<Excel:td  align="center" width="100">性别</Excel:td>
			<Excel:td  align="center" width="100">出生日期</Excel:td>
			<Excel:td  align="center" width="150">政治面貌</Excel:td>
			<Excel:td  align="center" width="100">电话</Excel:td>
			<Excel:td  align="center" width="100">是否离退休</Excel:td>
			<Excel:td  align="center" width="200">家庭住址</Excel:td>
		</Excel:tr>
	<%--数据区 --%>
		<%
			DataSet dataset=(DataSet)request.getAttribute("dataset");
			for(int i=0;i<dataset.getCount();i++){
				Record record=dataset.getRecord(i);
				//性别
				String sex="";
				sex=(String)record.get("SEX");
				if(sex==null){
					sex="";
				}
				if(sex.equals("0")){
					sex="男";
				}else if(sex.equals("1")){
					sex="女";
				}
				//是否离退休
				String ifRetire="";
				ifRetire=(String)record.get("IF_RETIRE");
				if(ifRetire==null){
					ifRetire="";
				}
				if(ifRetire.equals("0")){
					ifRetire="否";
				}else if(ifRetire.equals("1")){
					ifRetire="是";
				}
				//政治面貌
				String politics="";
				politics=(String)record.get("POLITICS");
				if(politics==null){
					politics="";
				}
				if(politics.equals("01")){
					politics="中国共产党党员";
				}else if(politics.equals("02")){
					politics="中国共产党预备党员";
				}else if(politics.equals("03")){
					politics="中国共产主义青年团团员";
				}else if(politics.equals("04")){
					politics="中国国民党革命委员会会员";
				}else if(politics.equals("05")){
					politics="中国民主同盟盟员";
				}else if(politics.equals("06")){
					politics="中国民主建国会会员";
				}else if(politics.equals("07")){
					politics="中国民主促进会会员";
				}else if(politics.equals("08")){
					politics="中国农工民主党党员";
				}else if(politics.equals("09")){
					politics="中国致公党党员";
				}else if(politics.equals("10")){
					politics="九三学社社员";
				}else if(politics.equals("11")){
					politics="台湾民主自治同盟盟员";
				}else if(politics.equals("12")){
					politics="无党派民主人士";
				}else if(politics.equals("13")){
					politics="群众";
				}
				
				
		%>
		<Excel:tr>
			<Excel:td  align="center"><%=record.get("NAME")%></Excel:td>
			<Excel:td  align="center"><%=record.get("ID_CARD")%></Excel:td>
			<Excel:td  align="center"><%=sex%></Excel:td>
			<Excel:td  align="center"><%=record.get("BIRTHDAY")%></Excel:td>
			<Excel:td  align="center"><%=politics%></Excel:td>
			<Excel:td  align="center"><%=record.get("PHONE")%></Excel:td>
			<Excel:td  align="center"><%=ifRetire%></Excel:td>
			<Excel:td  align="center"><%=record.get("ADDS")%></Excel:td>
		</Excel:tr>
		<%
			}
		%>
	</Excel:table>
</Excel:tablelist>