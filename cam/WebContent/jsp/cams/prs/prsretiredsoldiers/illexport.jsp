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
	String getSex(Object sex){
		if ("1".equals(sex)){
			return "男";
		}else if ("2".equals(sex)){
			return "女";
		}
		return "";
	}
	String getNation(Object nation){
		if (!"".equals(nation)){
			return dicDao.getValueByValue("DIC_NATION", "name",(String)nation);
			
		} 
		return "";
	}
	String getRegion(Object region){
		if (!"".equals(region)){
			return dicDao.getValueByValue("DIC_MILITARY_REGION_CODE", "name",(String)region);
			
		} 
		return "";
	}
	String getFlag(Object flag){
		if("1".equals(flag)){
			return "邮寄(机要号)";
		}else if("2".equals(flag)){
			return "专人传达";
		}else if("3".equals(flag)){
			return "集中接管";
		}return "";
	}
	%>	
	<html>
	<head>
		<title>导出Excel</title>
		<next:ScriptManager/>
	</head>
	<excel:tablelist filename="伤病残退役士兵信息">
		<excel:table sheetname="伤病残退役士兵信息">
			<excel:tr>
			</excel:tr>
			<excel:tr bgcolor="grey">
				<excel:td border="3" width="64" align="center">姓名</excel:td>
				<excel:td border="3" width="32" align="center">性别</excel:td>
				<excel:td border="3" width="64" align="center">民族</excel:td>
				<excel:td border="3" width="96" align="center">军区大单位</excel:td>
				<excel:td border="3" width="96" align="center">入伍时间</excel:td>
				<excel:td border="3" width="96" align="center">退役时间</excel:td>
				<excel:td border="3" width="112" align="center">入伍地</excel:td>
				<excel:td border="3" width="112" align="center">安置地</excel:td>
				<excel:td border="3" width="96" align="center">档案来源</excel:td>
				<excel:td border="3" width="96" align="center">联系电话</excel:td>
				<excel:td border="3" width="112" align="center">家庭住址</excel:td>
				</excel:tr>
				<%
				DataSet soldiersdataset=(DataSet)request.getAttribute("dataset");
				
				for(int i=0;i<soldiersdataset.getCount();i++){
					Record record=soldiersdataset.getRecord(i);
					
				%>				
			<excel:tr>
				<excel:td><%=record.get("NAME")%></excel:td>
				<excel:td><%=getSex(record.get("SEX"))%></excel:td>
				<excel:td><%=getNation(record.get("NATION"))%></excel:td>
				<excel:td><%=getRegion(record.get("REGION"))%></excel:td>
				<excel:td><%=record.get("ENTIME")%></excel:td>
	 			<excel:td><%=record.get("RETIREDTIME")%></excel:td>
	 			<excel:td><%=record.get("ENPLACE")%></excel:td>
	 			<excel:td><%=record.get("domicileName")%></excel:td>
	 			<excel:td><%=getFlag(record.get("SOURCE"))%></excel:td>
	 			<excel:td><%=record.get("TEL")%></excel:td>
	 			<excel:td><%=record.get("ADDRESS")%></excel:td>
			</excel:tr>
			<%
				}
			%>
		</excel:table>
	</excel:tablelist>
</html>