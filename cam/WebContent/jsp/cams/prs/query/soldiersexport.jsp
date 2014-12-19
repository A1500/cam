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
<%@page import="com.inspur.cams.comm.util.EnumUtil"%>
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
	String getReason(Object reason){
		if("1".equals(reason)){
			return "期满原籍";
		}else if("2".equals(reason)){
			return "期满易地";
		}else if("3".equals(reason)){
			return "提前原籍";
		}else if("4".equals(reason)){
			return "提前易地";
		}
		return "";
	}
	String getFlag(Object flag){
		if("1".equals(flag)){
			return "否";
		}else if("2".equals(flag)){
			return "是";
		}
		return "";
	}
	String getType(Object type){
		if("1".equals(type)){
			return "职业教育";
		}else if("0".equals(type)){
			return "技能培训";
		}
		return "";
	}
	%>	
	<%
		String fileName = (String)request.getParameter("fileName");
		fileName+=date;
	%>
	<html>
	<head>
		<title>导出Excel</title>
		<next:ScriptManager/>
	</head>
	<excel:tablelist filename="<%=fileName %>">
		<excel:table sheetname="士兵信息">
			<excel:tr bgcolor="grey">
				<excel:td border="1" width="96" align="center">编号</excel:td>
				<excel:td border="1" width="96" align="center">姓名</excel:td>
				<excel:td border="1" width="96" align="center">专业特长</excel:td>
				<excel:td border="1" width="96" align="center">部队单位</excel:td>
				<excel:td border="1" width="96" align="center">入伍时间</excel:td>
				<excel:td border="1" width="128" align="center">入伍户口所在地</excel:td>
				<excel:td border="1" width="128" align="center">军区大单位</excel:td>
				<excel:td border="1" width="128" align="center">配偶户口所在地</excel:td>
				<excel:td border="1" width="96" align="center">安置理由</excel:td>
				<excel:td border="1" width="96" align="center">培训类型</excel:td>
				<excel:td border="1" width="96" align="center">培训机构</excel:td>
				<excel:td border="1" width="96" align="center">培训开始时间</excel:td>
				<excel:td border="1" width="96" align="center">培训结束时间</excel:td>
				<excel:td border="1" width="96" align="center">培训专业</excel:td>	
				<excel:td border="1" width="96" align="center">培训技能等级</excel:td>			
				</excel:tr>
				<%
				DataSet soldiersdataset=(DataSet)request.getAttribute("dataset");
				for(int i=0;i<soldiersdataset.getCount();i++){
					Record record=soldiersdataset.getRecord(i);
				%>				
			<excel:tr >
				<excel:td><%=record.get("FILE_NUM")==null?"":record.get("FILE_NUM")%></excel:td>
				<excel:td><%=record.get("NAME")==null?"":record.get("NAME")%></excel:td>
	 			<excel:td><%=record.get("SPECIALTY")==null?"":record.get("SPECIALTY")%></excel:td>
	 			<excel:td><%=record.get("SERVED_ARMY")==null?"":record.get("SERVED_ARMY")%></excel:td>
	 			<excel:td><%=record.get("ENLIST_TIME")==null?"":record.get("ENLIST_TIME")%></excel:td>
	 			<excel:td><%=record.get("ENLIST_PLACE")==null?"":record.get("ENLIST_PLACE")%></excel:td>
	 			<excel:td><%=EnumUtil.findTextFromEnum("DIC_MILITARY_REGION_CODE","CODE","NAME",String.valueOf(record.get("SERVED_MILITARY_REGION")))%></excel:td>
	 			<excel:td><%=record.get("SPOUSE_LOCATION")==null?"":record.get("SPOUSE_LOCATION")%></excel:td>
	 			<excel:td><%=EnumUtil.findTextFromEnum(String.valueOf(record.get("PLACEMEN_RENSON")),"PLACEMENREASON.CODE")%></excel:td>
	 			<excel:td><%=EnumUtil.findTextFromEnum(String.valueOf(record.get("TRAINING_TYPE")),"TRAINING.TYPE")%></excel:td>
	 			<excel:td><%=record.get("TRAINING_INSTITUTIONS")==null?"":record.get("TRAINING_INSTITUTIONS")%></excel:td>
	 			<excel:td><%=record.get("TRAINING_START_TIME")==null?"":record.get("TRAINING_START_TIME")%></excel:td>
	 			<excel:td><%=record.get("TRAINING_END_TIME")==null?"":record.get("TRAINING_END_TIME")%></excel:td>
	 			<excel:td><%=record.get("TRAINING_MAJOR")==null?"":record.get("TRAINING_MAJOR")%></excel:td>
		 		<excel:td><%=record.get("TRAINING_SKILL_LEVEL")==null?"":record.get("TRAINING_SKILL_LEVEL")%></excel:td>
			</excel:tr>
			<%
				}
			%>
		</excel:table>
	</excel:tablelist>
</html>