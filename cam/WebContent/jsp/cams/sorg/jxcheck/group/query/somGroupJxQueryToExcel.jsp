<%@ page contentType="charset=UTF-8"%>
<%@ taglib uri="/tags/next-excel" prefix="Excel"%>
<%@page import="org.loushang.next.data.DataSet"%>
<%@page import="org.loushang.next.data.Record"%>
<%@page import="java.text.SimpleDateFormat"%>
<Excel:tablelist filename="查询报表">
	<Excel:table>
	<%--标题栏 --%>
		<Excel:tr>
			<Excel:td colspan="11" align="center">查询报表</Excel:td>
		</Excel:tr>
		<%
			SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
		%>
	<%--时间栏 --%>
		<Excel:tr>
			<Excel:td colspan="11" align="left">日期：<%=sdf.format(new java.util.Date())%></Excel:td>
		</Excel:tr>
	<%--列标题 --%>
		<Excel:tr bgcolor="grey">
			<Excel:td  align="center" width="100">登记证号</Excel:td>
			<Excel:td  align="center" width="150">社会组织名称</Excel:td>
			<Excel:td  align="center" width="100">年检年份</Excel:td>
			<Excel:td  align="center" width="100">年检结果</Excel:td>
		</Excel:tr>
	<%--数据区 --%>
		<%
			DataSet dataset=(DataSet)request.getAttribute("dataset");
			for(int i=0;i<dataset.getCount();i++){
				Record record=dataset.getRecord(i);
				//社会组织种类
				String checkResult=(String)record.get("checkResult");
				if(checkResult==null){
					checkResult="";
				}
				if(checkResult.equals("0")){
					checkResult="不合格";
				}else if(checkResult.equals("1")){
					checkResult="合格";
				}else if(checkResult.equals("2")){
					checkResult="基本合格";
				}
		%>
		<Excel:tr>
			<Excel:td  align="center"><%=record.get("sorgCode")%></Excel:td>
			<Excel:td  align="center"><%=record.get("cnName")%></Excel:td>
			<Excel:td  align="center"><%=record.get("checkYear")%></Excel:td>
			<Excel:td  align="center"><%=checkResult%></Excel:td>
		</Excel:tr>
		<%
			}
		%>
	</Excel:table>
</Excel:tablelist>