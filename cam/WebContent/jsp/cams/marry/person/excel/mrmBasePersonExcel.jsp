<%@ page contentType="charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/tags/next-excel" prefix="Excel"%>
<%@page import="org.loushang.next.data.DataSet"%>
<%@page import="org.loushang.next.data.Record"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.inspur.cams.comm.util.EnumUtil"%>
<%@page import="java.util.*"%>
<head>
<title>登记员导出</title>
<%
	String type = request.getParameter("type");
	String nameType = "";
	if("01".equals(type)) {
		nameType = "登记";
	} else if("02".equals(type)) {
		nameType = "颁证";
	}
	SimpleDateFormat sdf=new SimpleDateFormat("yyyy年MM月dd日HH时mm分");
	String date=sdf.format(new Date());
	String name= nameType + "员列表_"+date;
	
	sdf = new SimpleDateFormat("yyyy");
	int year = Integer.parseInt(sdf.format(new Date()));
%>
</head>
<Excel:tablelist filename="<%=name%>">
	<Excel:table sheetname="登记员列表">
		<Excel:tr height="50" >
			<Excel:td  align="center" width="200">登记处</Excel:td>
			<Excel:td  align="center" width="90">姓名</Excel:td>
			<Excel:td  align="center" width="50">性别</Excel:td>
			<Excel:td  align="center" width="100">职务</Excel:td>
			<Excel:td  align="center" width="150">身份证号</Excel:td>
			<Excel:td  align="center" width="100">资格证编号</Excel:td>
			<Excel:td  align="center" width="60">岗位状态</Excel:td>
			<Excel:td  align="center" width="100">系统操作权限</Excel:td>
			<Excel:td  align="center" width="100">从事婚姻工作开始时间</Excel:td>
			<Excel:td  align="center" width="100">培训状态</Excel:td>
			<Excel:td  align="center" width="100">是否颁证员</Excel:td>
		</Excel:tr>
		<%
			DataSet ds = (DataSet)request.getAttribute("dataset");
			String status = "";
			for(int i=0; i<ds.getCount(); i++) {
				Record rec = ds.getRecord(i);
				if(rec.get("partyTime") != null){
					int partyYear = Integer.parseInt(((String)rec.get("partyTime")).split("-")[0]);
					if(year-partyYear<3){
						status = "正常";
					}else{
						status = "逾期";
					}
				}else{
					status = "未取得证书";
				}
				
		%>
		<Excel:tr>
			<Excel:td ><%=rec.get("deptName")%></Excel:td>
			<Excel:td><%=rec.get("name")%></Excel:td>
			<Excel:td><%=EnumUtil.findTextFromEnum(String.valueOf(rec.get("sex")),"COMM.SEX")%></Excel:td>
			<Excel:td><%=EnumUtil.findTextFromEnum(String.valueOf(rec.get("technical")),"MRM.ZW.TYPE")%></Excel:td>
			<Excel:td><%=rec.get("cardNo")%></Excel:td>
			<Excel:td><%=rec.get("certificateId")%></Excel:td>
			<Excel:td><%=EnumUtil.findTextFromEnum(String.valueOf(rec.get("workstate")),"MRM.WORK.TYPE")%></Excel:td>
			<Excel:td><%=EnumUtil.findTextFromEnum(String.valueOf(rec.get("computerType")),"MRM.COMPUTERTYPE")%></Excel:td>
			<Excel:td><%=rec.get("marryStartDate")%></Excel:td>
			<Excel:td><%=status%></Excel:td>
			<Excel:td><%=EnumUtil.findTextFromEnum(String.valueOf(rec.get("bzyCode")),"MRM.BZYCODE.TYPE")%></Excel:td>
		</Excel:tr>
		<%
			}
		%>
	</Excel:table>
</Excel:tablelist>
