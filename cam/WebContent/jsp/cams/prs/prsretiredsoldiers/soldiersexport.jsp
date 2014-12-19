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
	String getHukouType(Object hukouType){
		if ("1".equals(hukouType)){
			return "农村";
		}else if ("2".equals(hukouType)){
			return "城镇";
		}
		return "";
	}
	String getRegion(Object region){
		if (!"".equals(region)){
			return dicDao.getValueByValue("DIC_MILITARY_REGION_CODE", "name",(String)region);
			
		} 
		return "";
	}
	String getType(Object type){
		if("0".equals(type)){
			return "退伍义务兵";
		}else if ("1".equals(type)){
			return "复员士官";
		}else if ("3".equals(type)){
			return "转业士官";
		}return "";
	}
	String getCountralLevel(Object countralLevel){
		if("10".equals(countralLevel)){
			return "研究生";
		}else if ("20".equals(countralLevel)){
			return "大学本科";
		}else if ("30".equals(countralLevel)){
			return "大学专科和专科学校";
		}
		else if ("40".equals(countralLevel)){
			return "中等专业学校或中等技术学校";
		}
		else if ("50".equals(countralLevel)){
			return "技工学校";
		}
		else if ("60".equals(countralLevel)){
			return "高中";
		}
		else if ("70".equals(countralLevel)){
			return "初中";
		}
		else if ("80".equals(countralLevel)){
			return "小学";
		}
		else if ("90".equals(countralLevel)){
			return "文盲或半文盲";
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
	<html>
	<head>
		<title>导出Excel</title>
		<next:ScriptManager/>
	</head>
	<excel:tablelist filename="士兵信息">
		<excel:table sheetname="士兵信息">
			<excel:tr>
			</excel:tr>
			<excel:tr bgcolor="grey">
				<excel:td border="3" width="64" align="center">姓名</excel:td>
				<excel:td border="3" width="32" align="center">性别</excel:td>
				<excel:td border="3" width="64" align="center">民族</excel:td>
				<excel:td border="3" width="90" align="center">身份证号</excel:td>
				<excel:td border="3" width="90" align="center">退伍证号</excel:td>
				<excel:td border="3" width="96" align="center">户口性质</excel:td>
				<excel:td border="3" width="96" align="center">文化程度</excel:td>
				<excel:td border="3" width="96" align="center">士兵类型</excel:td>
				<excel:td border="3" width="96" align="center">军区大单位</excel:td>
				<excel:td border="3" width="96" align="center">入伍时间</excel:td>
				<excel:td border="3" width="96" align="center">退役时间</excel:td>
				<excel:td border="3" width="120" align="center">入伍地</excel:td>
				<excel:td border="3" width="120" align="center">报到时间</excel:td>
				<excel:td border="3" width="120" align="center">培训专业</excel:td>
				<excel:td border="3" width="112" align="center">安置地</excel:td>
				<excel:td border="3" width="64" align="center">是否退档</excel:td>
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
				<excel:td><%=record.get("IDCARD_NO")%></excel:td>
				<excel:td><%=record.get("CERTIFICATENO")%></excel:td>
				<excel:td><%=getHukouType(record.get("HUKOU_TYPE"))%></excel:td>
				<excel:td><%=getCountralLevel(record.get("COUTRAL_LEVEL"))%></excel:td>
				<excel:td><%=getType(record.get("SOLDIERTYPE"))%></excel:td>
				<excel:td><%=getRegion(record.get("REGION"))%></excel:td>
				<excel:td><%=record.get("ENTIME")%></excel:td>
	 			<excel:td><%=record.get("RETIREDTIME")%></excel:td>
	 			<excel:td><%=record.get("ENPLACE")%></excel:td>
	 			<excel:td><%=record.get("ARRIVE_TIME")%></excel:td>
	 			<excel:td><%=record.get("TRAINING_MAJOR")%></excel:td>
	 			<excel:td><%=record.get("domicileName")%></excel:td>
	 			<excel:td><%=getFlag(record.get("FLAG"))%></excel:td>
	 			<excel:td><%=record.get("TEL")%></excel:td>
	 			<excel:td><%=record.get("ADDRESS")%></excel:td>
			</excel:tr>
			<%
				}
			%>
		</excel:table>
	</excel:tablelist>
</html>