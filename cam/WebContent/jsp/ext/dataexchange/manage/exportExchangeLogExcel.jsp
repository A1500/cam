<%@ page contentType="charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/tags/next-excel" prefix="Excel"%>
<%@page import="org.loushang.next.data.DataSet"%>
<%@page import="org.loushang.next.data.Record"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="com.inspur.cams.marry.base.dao.IMarrydicDao" %>
<%@page import="org.loushang.next.dao.DaoFactory" %>
<%@page import="org.loushang.next.data.ParameterSet" %>


<Excel:tablelist filename="数据交互信息日志查询">
	<Excel:table sheetname="数据交互信息日志查询">
		<Excel:tr>
			<Excel:td colspan="7" align="center" ><Excel:font size="15">数据交互信息日志查询</Excel:font></Excel:td>
		</Excel:tr>
		<Excel:tr height="50" >
			<Excel:td  align="center" width="180">查询单位</Excel:td>			
			<Excel:td  align="center" width="150">查询时间</Excel:td>
			<Excel:td  align="center" width="150">数据类型</Excel:td>
			<Excel:td  align="center" width="80">查询条件</Excel:td>
			<Excel:td  align="center" width="150">查询信息条数</Excel:td>
			<Excel:td  align="center" width="150">身份证件号码男</Excel:td>
			<Excel:td  align="center" width="150">身份证件号码女</Excel:td>
			<Excel:td  align="center" width="150">殡葬用身份证件号码</Excel:td>
		</Excel:tr>
		<%
			DataSet ds = (DataSet)request.getAttribute("dataset");
			
			for(int i=0; i<ds.getCount(); i++) {
				Record rec = ds.getRecord(i);
				if(rec.get("businessCategory").equals("901")){
					rec.set("businessCategory","婚姻");
				}
				if(rec.get("businessCategory").equals("902")){
					rec.set("businessCategory","殡葬");
				}
				
		%>
		<Excel:tr>
			<Excel:td><%=rec.get("unitName")%></Excel:td>	
			<Excel:td><%=rec.get("queryDate")%></Excel:td>			
			<Excel:td><%=rec.get("businessCategory")%></Excel:td>
			<Excel:td><%=rec.get("queryCondition")%></Excel:td>
			<Excel:td><%=rec.get("queryResultCount")%></Excel:td>
			<Excel:td><%=rec.get("certMan")%></Excel:td>
			<Excel:td><%=rec.get("certWoman")%></Excel:td>
			<Excel:td><%=rec.get("fisIdCard")%></Excel:td>
		</Excel:tr>
		<%
			}
		%>
	</Excel:table>
</Excel:tablelist>

