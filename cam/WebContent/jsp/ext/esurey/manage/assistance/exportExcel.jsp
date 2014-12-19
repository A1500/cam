<%@ page contentType="charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ taglib uri="/tags/next-excel" prefix="excel"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="org.loushang.next.data.*"%>
<%@page import="java.util.*"%>
<%@page import="java.text.SimpleDateFormat"%>
<head>
<title>导出Excel</title>
<next:ScriptManager/>
<%
	SimpleDateFormat sdf=new SimpleDateFormat("yyyy年MM月dd日HH时mm分");
	String date=sdf.format(new Date());
	String name=date+"核对结果统计";
%>
</head>
<excel:tablelist filename="<%=name%>">
	<excel:table sheetname="核对结果统计">
		<excel:tr>
			<excel:td colspan="11" align="center"><excel:font size="15">核对结果统计</excel:font></excel:td>
		</excel:tr>
		<excel:tr bgcolor="grey">
			<excel:td  align="center" width="100">姓名</excel:td>
			<excel:td  align="center" width="130">身份证号</excel:td>
			<excel:td  align="center" width="100">户籍县（市、区）地址</excel:td>
			<excel:td  align="center" width="100">居住县（市、区）地址</excel:td>
			<excel:td  align="center" width="100">申请日期</excel:td>
			<excel:td  align="center" width="100">核对项目</excel:td>
			<excel:td  align="center" width="100">核对结果</excel:td>
			<excel:td  align="center" width="120">核对单位</excel:td>
			<excel:td  align="center" width="100">核对日期</excel:td>
			<excel:td  align="center" width="100">发证机关</excel:td>
			<excel:td  align="center" width="100">发证日期</excel:td>
		</excel:tr>
		<%
	
			DataSet dataset=(DataSet)request.getAttribute("dataset");
			for(int i=0;i<dataset.getCount();i++){
				Record record=dataset.getRecord(i);
		%>
		<excel:tr>
			<excel:td align="center" width="100"><%=record.get("NAME")%></excel:td>
			<excel:td align="center" width="130"><%=record.get("ID_CARD")%></excel:td>
			<excel:td align="center" width="100"><%=record.get("DOMICILE_NAME")%></excel:td>
			<excel:td align="center" width="100"><%=record.get("APANAGE_NAME")%></excel:td>
			<excel:td align="center" width="100"><%=record.get("APPLY_DATE")%></excel:td>
			<excel:td align="center" width="100"><%=record.get("ASSISTANCE_TYPE")%></excel:td>
			<excel:td align="center" width="100"><%=record.get("RESULT")%></excel:td>
			<excel:td align="center" width="120"><%=record.get("SURVEY_ORGAN_NAME")%></excel:td>
 			<excel:td align="center" width="100"><%=record.get("SURVEY_DATE")%></excel:td>
 			<excel:td align="center" width="100"><%=record.get("SIGN_ORGAN")%></excel:td>
 			<excel:td align="center" width="100"><%=record.get("SIGN_DATE")%></excel:td>
		</excel:tr>
		<%
			}
		%>
		<excel:tr>
			<excel:td colspan="5">说明：
		</excel:td>
		</excel:tr>
		<excel:tr>
			<excel:td colspan="20" > 核对项目： 01：城市低保； 02：农村低保 03： 低收入家庭；04：无法确认； 
											11：非城市低保对象； 12：非农村低保对象； 13：非低收入家庭；
		</excel:td>
		</excel:tr>
		<excel:tr>
			<excel:td colspan="20" > 核对结果： 01：城市低保； 02：农村低保 03： 低收入家庭；04：无法确认； 
											11：非城市低保对象； 12：非农村低保对象； 13：非低收入家庭；
		</excel:td>
		</excel:tr>
	</excel:table>
</excel:tablelist>

