<%@ page contentType="charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/tags/next-excel" prefix="Excel"%>
<%@page import="org.loushang.next.data.DataSet"%>
<%@page import="org.loushang.next.data.Record"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.inspur.cams.comm.util.EnumUtil"%>
<%@page import="java.util.*"%>
<head>
<title>辅导员导出</title>
<%
	SimpleDateFormat sdf=new SimpleDateFormat("yyyy年MM月dd日HH时mm分");
	String date=sdf.format(new Date());
	String name= "辅导员列表_"+date;
	
	sdf = new SimpleDateFormat("yyyy");
	int year = Integer.parseInt(sdf.format(new Date()));
%>
</head>
<Excel:tablelist filename="<%=name%>">
	<Excel:table sheetname="辅导员列表">
		<Excel:tr height="50" >
			<Excel:td  align="center" width="160">所属机关</Excel:td>
			<Excel:td  align="center" width="90">姓名</Excel:td>
			<Excel:td  align="center" width="90">性别</Excel:td>
			<Excel:td  align="center" width="120">出生日期</Excel:td>
			<Excel:td  align="center" width="90">学历</Excel:td>
			<Excel:td  align="center" width="90">专业</Excel:td>
			<Excel:td  align="center" width="90">职称</Excel:td>
			<Excel:td  align="center" width="90">专业资格证</Excel:td>
			<Excel:td  align="center" width="90">人员来源</Excel:td>
			<Excel:td  align="center" width="150">其他情况</Excel:td>
			<Excel:td  align="center" width="150">辅导安排</Excel:td>
			<Excel:td  align="center" width="100">工作开始时间</Excel:td>
			<Excel:td  align="center" width="100">工作结束时间</Excel:td>
		</Excel:tr>
		<%
			DataSet ds = (DataSet)request.getAttribute("dataset");
			String status = "";
			for(int i=0; i<ds.getCount(); i++) {
				Record rec = ds.getRecord(i);
		%>
		<Excel:tr>
			<Excel:td><%=rec.get("deptName")%></Excel:td>
			<Excel:td><%=rec.get("name")%></Excel:td>
			<Excel:td><%=EnumUtil.findTextFromEnum(String.valueOf(rec.get("xb")),"COMM.SEX")%></Excel:td>
			<Excel:td><%=rec.get("nl")%></Excel:td>
			<Excel:td><%=EnumUtil.findTextFromEnum(String.valueOf(rec.get("hyzk")),"EDUCATION.TYPE")%></Excel:td>
			<Excel:td><%=EnumUtil.findTextFromEnum(String.valueOf(rec.get("zy")),"MRM.ZY.TYPE")%></Excel:td>
			<Excel:td><%=rec.get("zc")%></Excel:td>
			<Excel:td><%=EnumUtil.findTextFromEnum(String.valueOf(rec.get("zyzgz")),"MRM.ZYZGZ.TYPE")%></Excel:td>
			<Excel:td><%=EnumUtil.findTextFromEnum(String.valueOf(rec.get("ryly")),"MRM.RYCODE.TYPE")%></Excel:td>
			<Excel:td><%=rec.get("qtqk")%></Excel:td>
			<Excel:td><%=rec.get("bz")%></Excel:td>
			<Excel:td><%=rec.get("workbegintime")%></Excel:td>
			<Excel:td><%=rec.get("workendtime")%></Excel:td>
		</Excel:tr>
		<%
			}
		%>
	</Excel:table>
</Excel:tablelist>
