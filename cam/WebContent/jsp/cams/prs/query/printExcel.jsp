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
		<excel:table sheetname="转业士官审档花名册">
			<excel:tr>
			</excel:tr>
			<excel:tr bgcolor="grey">
				<excel:td border="3" width="64" align="center">序号</excel:td>
				<excel:td border="3" width="64" align="center">姓名</excel:td>
				
				<excel:td border="3" width="64" align="center">部队单位</excel:td>
				<excel:td border="3" width="96" align="center">入伍时间</excel:td>
				<excel:td border="3" width="32" align="center">入伍地</excel:td>
				<excel:td border="3" width="96" align="center">安置地</excel:td>
				<excel:td border="3" width="96" align="center">配偶户口所在地</excel:td>
				
				<excel:td border="3" width="120" align="center">安置理由</excel:td>
				<excel:td border="3" width="32" align="center">结婚时间</excel:td>
				<excel:td border="3" width="112" align="center">迁户时间</excel:td>
				<excel:td border="3" width="112" align="center">三等功</excel:td>
				<excel:td border="3" width="112" align="center">二等功</excel:td>
				<excel:td border="3" width="112" align="center">伤残等级</excel:td>
				<excel:td border="3" width="64" align="center">退档</excel:td>
				<excel:td border="3" width="96" align="center">审档情况</excel:td>
				</excel:tr>
				<%
				DataSet soldiersdataset=(DataSet)request.getAttribute("dataset");
				for(int i=0;i<soldiersdataset.getCount();i++){
					Record record=soldiersdataset.getRecord(i);
				%>				
			<excel:tr>
				<excel:td><%=record.get("")%></excel:td>
				<excel:td><%=record.get("NAME")%></excel:td>
				<excel:td><%=record.get("SERVEDARMY")%></excel:td>
				<excel:td><%=record.get("ENTIME")%></excel:td>
	 			<excel:td><%=record.get("ENPLACE")%></excel:td>
				<excel:td><%=getRegion(record.get("domicileName"))%></excel:td>
	 			<excel:td><%=record.get("SLOCATION")%></excel:td>
	 			<excel:td><%=getReason(record.get("PRENSON"))%></excel:td>
	 			<excel:td><%=record.get("a")%></excel:td>
	 			<excel:td><%=getFlag(record.get("b"))%></excel:td>
	 			<excel:td><%=record.get("c")%></excel:td>
	 			<excel:td><%=record.get("d")%></excel:td>
	 			<excel:td><%=record.get("e")%></excel:td>
	 			<excel:td><%=record.get("f")%></excel:td>
	 			<excel:td><%=record.get("g")%></excel:td>
			</excel:tr>
			<%
				}
			%>
		</excel:table>
	</excel:tablelist>
</html>