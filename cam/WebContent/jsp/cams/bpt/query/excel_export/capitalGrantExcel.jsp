<%@ page contentType="charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/tags/next-excel" prefix="Excel"%>
<%@page import="org.loushang.next.data.DataSet"%>
<%@page import="org.loushang.next.data.Record"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.inspur.cams.comm.util.EnumUtil"%>
<%@page import="java.util.*"%>
<head>
<title>生活补助金人员情况导出</title>
<%
	SimpleDateFormat sdf=new SimpleDateFormat("yyyy年MM月dd日HH时mm分");
	String date=sdf.format(new Date());
	String type = request.getParameter("type");
	String sheetName = "";
	if("1".equals(type)) { 
		sheetName = "定期抚恤金人员列表";
	} else if("2".equals(type)) {
		sheetName = "临时救助人员列表";
	} else {
		sheetName = "生活补助金人员列表";
	}
	String name = sheetName + "_"+date;
%>
</head>
<Excel:tablelist filename="<%=name%>">
	<Excel:table sheetname="<%=sheetName %>">
		<Excel:tr height="50" >
			<Excel:td  align="center" width="150">所属行政区划</Excel:td>
			<Excel:td  align="center" width="80">姓名</Excel:td>
			<Excel:td  align="center" width="50">性别</Excel:td>
			<Excel:td  align="center" width="100">民族</Excel:td>
			<Excel:td  align="center" width="150">身份证件号码</Excel:td>
			<Excel:td  align="center" width="90">出生日期</Excel:td>
			<Excel:td  align="center" width="60">户籍类别</Excel:td>
			<Excel:td  align="center" width="140">户口地址</Excel:td>
			<Excel:td  align="center" width="90">工作单位</Excel:td>
			<Excel:td  align="center" width="90">证书编号</Excel:td>
			<Excel:td  align="center" width="120">优抚对象类别</Excel:td>
			<Excel:td  align="center" width="90">抚恤金额(元)</Excel:td>
		</Excel:tr>
		<%
			DataSet ds = (DataSet)request.getAttribute("dataset");
			for(int i=0; i<ds.getCount(); i++) {
				Record rec = ds.getRecord(i);
		%>
		<Excel:tr>
			<Excel:td ><%=rec.get("FULL_NAME")%></Excel:td>
			<Excel:td><%=rec.get("NAME")%></Excel:td>
			<Excel:td><%=EnumUtil.findTextFromEnum((String)rec.get("SEX"),"COMM.SEX")%></Excel:td>
			<Excel:td><%=EnumUtil.findTextFromEnum("DIC_NATION","CODE","NAME",(String)rec.get("NATION"))%></Excel:td>
			<Excel:td><%=rec.get("ID_CARD")%></Excel:td>
			<Excel:td><%=rec.get("BIRTHDAY")%></Excel:td>
			<Excel:td><%=EnumUtil.findTextFromEnum(String.valueOf(rec.get("DOMICILE_TYPE")),"DOMICILE.TYPE")%></Excel:td>
			<Excel:td><%=rec.get("ADDRESS")%></Excel:td>
			<Excel:td><%=rec.get("WORK_UNIT_NAME")%></Excel:td>
			<Excel:td><%=rec.get("BPT_NO")%></Excel:td>
			<Excel:td><%=EnumUtil.findTextFromEnum(String.valueOf(rec.get("OBJECT_TYPE")),"OBJECT.TYPE.PART")%></Excel:td>
			<Excel:td><%=rec.get("MON_SUM")%></Excel:td>
		</Excel:tr>
		<%
			}
		%>
	</Excel:table>
</Excel:tablelist>
