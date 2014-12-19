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
	String name= "登记员考试管理列表_"+date;
	
	sdf = new SimpleDateFormat("yyyy");
	int year = Integer.parseInt(sdf.format(new Date()));
%>
</head>
<Excel:tablelist filename="<%=name%>">
	<Excel:table sheetname="登记员考试管理列表">
		<Excel:tr height="50" >
			<Excel:td  align="center" width="160">登记处</Excel:td>
			<Excel:td  align="center" width="90">姓名</Excel:td>
			<Excel:td  align="center" width="90">性别</Excel:td>
			<Excel:td  align="center" width="160">民族</Excel:td>
			<Excel:td  align="center" width="160">手机</Excel:td>
			<Excel:td  align="center" width="90">年度</Excel:td>
			<Excel:td  align="center" width="120">初考复考标识</Excel:td>
			<Excel:td  align="center" width="90">考试期次</Excel:td>
			<Excel:td  align="center" width="90">考试时间</Excel:td>
			<Excel:td  align="center" width="90">考试结果</Excel:td>
			<Excel:td  align="center" width="90">补考结果</Excel:td>
			<Excel:td  align="center" width="90">资格证编号</Excel:td>
			<Excel:td  align="center" width="150">是否补证</Excel:td>
			<Excel:td  align="center" width="150">发证时间</Excel:td>
			<Excel:td  align="center" width="100">资格证状态</Excel:td>
			<Excel:td  align="center" width="100">撤销原因</Excel:td>
		</Excel:tr>
		<%
			DataSet ds = (DataSet)request.getAttribute("dataset");
			String status = "";
			for(int i=0; i<ds.getCount(); i++) {
				Record rec = ds.getRecord(i);
		%>
		<Excel:tr>
			<Excel:td><%=rec.get("DEPT_NAME")%></Excel:td>
			<Excel:td><%=rec.get("NAME")%></Excel:td>
			<Excel:td><%=EnumUtil.findTextFromEnum(String.valueOf(rec.get("SEX")),"COMM.SEX")%></Excel:td>
			<Excel:td><%=rec.get("NATION")%></Excel:td>
			<Excel:td><%=rec.get("MOBILE")%></Excel:td>
			<Excel:td><%=rec.get("ND_YEAR")%></Excel:td>
			<Excel:td><%=EnumUtil.findTextFromEnum(String.valueOf(rec.get("CKFKBZ")),"MRM.CKFKBZ.TYPE")%></Excel:td>
			<Excel:td><%=rec.get("KSQS")%></Excel:td>
			<Excel:td><%=rec.get("KSSJ_TIME")%></Excel:td>
			<Excel:td><%=EnumUtil.findTextFromEnum(String.valueOf(rec.get("KSJG")),"MRM.KSJG.TYPE")%></Excel:td>
			<Excel:td><%=EnumUtil.findTextFromEnum(String.valueOf(rec.get("BKJG")),"MRM.BKJG.TYPE")%></Excel:td>
			<Excel:td><%=rec.get("CERTIFICATE_ID")%></Excel:td>
			<Excel:td><%=EnumUtil.findTextFromEnum(String.valueOf(rec.get("FILL_CARD_TIME")),"COMM.YESORNO")%></Excel:td>
			<Excel:td><%=rec.get("GIVE_OUT_TIME")%></Excel:td>
			<Excel:td><%=EnumUtil.findTextFromEnum(String.valueOf(rec.get("ZGZZT")),"MRM.ZGZZT.TYPE")%></Excel:td>
			<Excel:td><%=rec.get("CXYY")%></Excel:td>
		</Excel:tr>
		<%
			}
		%>
	</Excel:table>
</Excel:tablelist>
