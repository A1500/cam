<%@ page contentType="charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ taglib uri="/tags/next-excel" prefix="excel"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="org.loushang.next.data.*"%>
<%@page import="java.util.*"%>
<%@page import="java.text.SimpleDateFormat"%>
<html>
<head>
<title>导出Excel</title>
<next:ScriptManager/>
<%
	SimpleDateFormat sdf=new SimpleDateFormat("yyyy年MM月dd日HH时mm分ss秒");
	String date=sdf.format(new Date());
%>
</head>
<excel:tablelist filename="<%=date%>">
	<excel:table sheetname="困难户信息">
		<excel:tr>
			<excel:td colspan="5" align="center">统计报表</excel:td>
		</excel:tr>
		<excel:tr bgcolor="grey">
			
			<excel:td  align="center">户主姓名</excel:td>
			<excel:td  align="center">家庭成员</excel:td>
			<excel:td  align="center">人口数量</excel:td>
			<excel:td  align="center">救助类型</excel:td>
			<excel:td  align="center">家庭地址</excel:td>
			<excel:td  align="center">综合得分</excel:td>
			<excel:td  align="center">审核标识</excel:td>
		</excel:tr>
		<%
			DataSet dataset=(DataSet)request.getAttribute("dataset");
			for(int i=0;i<dataset.getCount();i++){
				Record record=dataset.getRecord(i);
		%>
		<excel:tr>
			
			<excel:td><%=record.get("HZXM")%></excel:td>
			<excel:td><%=record.get("JTCY")%></excel:td>
			<excel:td><%=record.get("RK_SL")%></excel:td>
			<excel:td><%=record.get("JZLX")%></excel:td>
			<excel:td><%=record.get("JTDZ")%></excel:td>
			<excel:td><%=record.get("JZZS_ZH")%></excel:td>
 			<excel:td><%=record.get("CHECK_FLAG")%></excel:td>
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