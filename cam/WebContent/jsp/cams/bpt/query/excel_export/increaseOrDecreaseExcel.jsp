<%@ page contentType="charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/tags/next-excel" prefix="Excel"%>
<%@page import="org.loushang.next.data.DataSet"%>
<%@page import="org.loushang.next.data.Record"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.inspur.cams.comm.util.EnumUtil"%>
<%@page import="java.util.*"%>
<head>
<title>优抚减员或者增员导出</title>
<%
	SimpleDateFormat sdf=new SimpleDateFormat("yyyy年MM月dd日HH时mm分");
	String type = request.getParameter("type");
	String exportTitle = "";
	if("increase".equals(type)) {
		exportTitle = "优抚对象增员";
	} else if("decrease".equals(type)) {
		exportTitle = "优抚对象减员";
	}
	String date=sdf.format(new Date());
	String name= exportTitle + "_列表"+date;
%>
</head>
<Excel:tablelist filename="<%=name%>">
	<Excel:table sheetname="<%=exportTitle%>">
		<Excel:tr height="50" >
			<Excel:td  align="center" width="150">所属行政区划</Excel:td>
			<Excel:td  align="center" width="80">姓名</Excel:td>
			<Excel:td  align="center" width="150">身份证件号码</Excel:td>
			<Excel:td  align="center" width="50">性别</Excel:td>
			<Excel:td  align="center" width="100">民族</Excel:td>
			<Excel:td  align="center" width="100">优抚对象状态</Excel:td>
			<Excel:td  align="center" width="150">优抚对象类别</Excel:td>
		</Excel:tr>
		<%
			DataSet ds = (DataSet)request.getAttribute("dataset");
			for(int i=0; i<ds.getCount(); i++) {
				Record rec = ds.getRecord(i);
		%>
		<Excel:tr>
			<Excel:td ><%=rec.get("DICNAME")%></Excel:td>
			<Excel:td><%=rec.get("NAME")%></Excel:td>
			<Excel:td><%=rec.get("ID_CARD")%></Excel:td>
			<Excel:td><%=EnumUtil.findTextFromEnum((String)rec.get("SEX"),"COMM.SEX")%></Excel:td>
			<Excel:td><%=EnumUtil.findTextFromEnum("DIC_NATION","CODE","NAME",(String)rec.get("NATION"))%></Excel:td>
			<Excel:td><%=EnumUtil.findTextFromEnum(String.valueOf(rec.get("STATE_CODE")),"OBJECT.STATE")%></Excel:td>
			<Excel:td><%=EnumUtil.findTextFromEnum(String.valueOf(rec.get("SERVICE_TYPE")),"OBJECT.TYPE.PART")%></Excel:td>
		</Excel:tr>
		<%
			}
		%>
	</Excel:table>
</Excel:tablelist>
