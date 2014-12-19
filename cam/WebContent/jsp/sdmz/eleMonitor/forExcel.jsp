<%@ page contentType="charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ taglib uri="/tags/next-excel" prefix="excel"%>
<%@page import="org.loushang.next.data.*"%>
<%@page import="java.util.*"%>
<%@page import="java.text.SimpleDateFormat"%>
<html>

<script language="javascript">
alert("22123");
</script>
	<head>
		<title>导出Excel</title>
		<next:ScriptManager/>
	</head>
<%
	SimpleDateFormat sdf=new SimpleDateFormat("yyyy年MM月dd日HH时mm分");
	String date=sdf.format(new Date());
	String name="困难家庭成员_"+date;
	System.out.println("112");
%>	
<excel:tablelist filename="<%=name%>">
	<excel:table sheetname="困难家庭成员信息">
		<excel:tr>
			<excel:td colspan="5" align="center">统计报表</excel:td>
		</excel:tr>
		<excel:tr bgcolor="grey">
			
			<excel:td  align="center">姓名</excel:td>
			<excel:td  align="center">身份证号</excel:td>
			<excel:td  align="center">户主姓名</excel:td>
			<excel:td  align="center">家庭成员</excel:td>
			<excel:td  align="center">与户主关系</excel:td>
			<excel:td  align="center">性别</excel:td>
			<excel:td  align="center">出生日期</excel:td>
			<excel:td  align="center">户籍性质</excel:td>
			<excel:td  align="center">民族</excel:td>
			<excel:td  align="center">婚姻状况</excel:td>
			<excel:td  align="center">医疗状况</excel:td>
			<excel:td  align="center">职业状况</excel:td>
			<excel:td  align="center">救助类型</excel:td>
			<excel:td  align="center">政治面貌</excel:td>
			<excel:td  align="center">登记时间</excel:td>
			<excel:td  align="center">登记单位</excel:td>
		</excel:tr>
		<%
			DataSet dataset=(DataSet)request.getAttribute("dataset");
			for(int i=0;i<dataset.getCount();i++){
				Record record=dataset.getRecord(i);
		%>
		<excel:tr>
			
			<excel:td><%=record.get("NAME")%></excel:td>
			<excel:td><%=record.get("ID_CARD")%></excel:td>
			<excel:td><%=record.get("FAMILY_NAME")%></excel:td>
			<excel:td><%=record.get("JTCY")%></excel:td>
			<excel:td><%=record.get("RELATIONSHIP_TYPE")%></excel:td>
 			<excel:td><%=record.get("SEX")%></excel:td>
 			<excel:td><%=record.get("BIRTHDAY")%></excel:td>
 			<excel:td><%=record.get("DOMICILE_TYPE")%></excel:td>
			<excel:td><%=record.get("NATION")%></excel:td>
			<excel:td><%=record.get("MARRIAGE_CODE")%></excel:td>
			<excel:td><%=record.get("SAFEGUARD_TYPE")%></excel:td>
			<excel:td><%=record.get("EMPLOYMENT_CODE")%></excel:td>
 			<excel:td><%=record.get("ASSISTANCE_TYPE")%></excel:td>
 			<excel:td><%=record.get("POLITICAL_CODE")%></excel:td>
 			<excel:td><%=record.get("REG_TIME")%></excel:td>
 			<excel:td><%=record.get("REG_ORG_NAME")%></excel:td>
		</excel:tr>
		<%
			}
		%>
		<excel:tr>
			<excel:td colspan="5">说明：
		</excel:td>
		</excel:tr>
		<excel:tr>
			<excel:td colspan="20" > 救助类型： 01城市低保； 02：农村低保
			03： 集中供养五保户； 04：分散供养五保户； 05：抚恤定补优抚对象； 06：残疾人；
			07：单亲特困母亲； 08：困难学生； 09："三无"对象； 10：特困职工； 11：其他；
		</excel:td>
		</excel:tr>
		<excel:tr>
			<excel:td colspan="20" > 审核标识： 0：待审核； 1：审核通过； 2：审核未通过；
		</excel:td>
		</excel:tr>
	</excel:table>
</excel:tablelist>

</html>