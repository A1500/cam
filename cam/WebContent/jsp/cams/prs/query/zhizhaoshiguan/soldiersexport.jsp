<%@ page contentType="charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ taglib uri="/tags/next-excel" prefix="excel"%>
<%@page import="org.loushang.next.data.DataSet"%>
<%@page import="org.loushang.next.data.Record"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.inspur.cams.comm.dicm.IDicDao" %>
<%@page import="org.loushang.next.dao.DaoFactory" %>
<%@page import="java.util.Date" %>
<%!
	IDicDao dicDao = (IDicDao) DaoFactory.getDao("com.inspur.cams.comm.dicm.DicDao");
	SimpleDateFormat sdf=new SimpleDateFormat("yyyy年MM月dd日HH时mm分");
	String date=sdf.format(new Date());
	String getRegion(Object region){
		if (!"".equals(region)){
			return dicDao.getValueByValue("DIC_MILITARY_REGION_CODE", "name",(String)region);
			
		} 
		return "";
	}
	String getReason(Object flag){
		if("1".equals(flag)){
			return "期满原籍";
		}else if("2".equals(flag)){
			return "期满易地";
		}else if("3".equals(flag)){
			return "提前原籍";
		}else if("4".equals(flag)){
			return "提前易地";
		}return "";
	}
	String getFlag(Object flag){
		if("1".equals(flag)){
			return "否";
		}else if("2".equals(flag)){
			return "是";
		}return "";
	}
	%>	
	<%
		String fileName = request.getParameter("fileName");
		fileName+=date;
	%>
	<html>
	<head>
		<title>导出Excel</title>
		<next:ScriptManager/>
	</head>
	<excel:tablelist filename="<%=fileName %>">
		<excel:table sheetname="直招士官信息">
			<excel:tr>
			</excel:tr>
			<excel:tr bgcolor="grey">
				<excel:td border="3" width="64" align="center">编号</excel:td>
				<excel:td border="3" width="64" align="center">姓名</excel:td>
				<excel:td border="3" width="32" align="center">专业特长</excel:td>
				<excel:td border="3" width="64" align="center">部队单位</excel:td>
				<excel:td border="3" width="96" align="center">入伍时间</excel:td>
				<excel:td border="3" width="96" align="center">入伍户口所在地</excel:td>
				<excel:td border="3" width="96" align="center">军区大单位</excel:td>
				<excel:td border="3" width="96" align="center">转业安置地</excel:td>
				<excel:td border="3" width="120" align="center">安置理由</excel:td>
				<excel:td border="3" width="112" align="center">移交材料</excel:td>
				<excel:td border="3" width="64" align="center">是否退档</excel:td>
				<excel:td border="3" width="96" align="center">备注</excel:td>
				</excel:tr>
				<%
				DataSet soldiersdataset=(DataSet)request.getAttribute("dataset");
				for(int i=0;i<soldiersdataset.getCount();i++){
					Record record=soldiersdataset.getRecord(i);
				%>				
			<excel:tr>
				<excel:td><%=record.get("FILENUM")%></excel:td>
				<excel:td><%=record.get("NAME")%></excel:td>
				<excel:td><%=record.get("SPEC")%></excel:td>
				<excel:td><%=record.get("SERVEDARMY")%></excel:td>
				<excel:td><%=record.get("ENTIME")%></excel:td>
	 			<excel:td><%=record.get("ENPLACE")%></excel:td>
				<excel:td><%=getRegion(record.get("REGION"))%></excel:td>
	 			<excel:td><%=record.get("domicileName")%></excel:td>
	 			<excel:td><%=getReason(record.get("PRENSON"))%></excel:td>
	 			<excel:td><%=record.get("TFILE")%></excel:td>
	 			<excel:td><%=getFlag(record.get("FLAG"))%></excel:td>
	 			<excel:td><%=record.get("CONTENT")%></excel:td>
			</excel:tr>
			<%
				}
			%>
		</excel:table>
	</excel:tablelist>
</html>