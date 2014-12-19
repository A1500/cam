<%@ page contentType="charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/tags/next-excel" prefix="Excel"%>
<%@page import="org.loushang.next.data.DataSet"%>
<%@page import="org.loushang.next.data.Record"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<%@ page import="org.loushang.bsp.security.context.GetBspInfo"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.*"%>
<head>
<title>导出Excel</title>
<%
	SimpleDateFormat sdf=new SimpleDateFormat("yyyy年MM月dd日HH时mm分");
	SimpleDateFormat sdf2=new SimpleDateFormat("yyyy年MM月dd日");
	String date=sdf.format(new Date());
	String date2=sdf2.format(new Date());
	String name="登记机关面积统计表_"+date;
	String username=GetBspInfo.getBspInfo(request).getUserName();
%>
</head>
<Excel:tablelist filename="<%=name %>">
	<Excel:table sheetname="登记机关面积统计表">
		<Excel:tr>
			<Excel:td colspan="11" align="center" ><Excel:font size="15">登记机关面积统计表</Excel:font></Excel:td>
		</Excel:tr>
		<Excel:tr>
			<Excel:td colspan="11" align="left">统计单位：<%= BspUtil.getOrganName()%></Excel:td>
		</Excel:tr>
		<Excel:tr height="30" bgcolor="grey" border="1">
			<Excel:td  align="center" width="140" rowspan="2" bordercolor="black">单位</Excel:td>
			<Excel:td  align="center" width="100" rowspan="2" bordercolor="black">总面积（㎡）</Excel:td>			
			<Excel:td  align="center" width="100" colspan="9" bordercolor="black">登记机关场所（㎡）</Excel:td>
		</Excel:tr>
		<Excel:tr height="20" bgcolor="grey" border="1">
			<Excel:td  align="center" bordercolor="black" >候登区</Excel:td>
			<Excel:td  align="center" bordercolor="black" >结婚登记区</Excel:td>
			<Excel:td  align="center" bordercolor="black" >离婚登记区</Excel:td>
			<Excel:td  align="center" bordercolor="black" >颁证区</Excel:td>
			<Excel:td  align="center" bordercolor="black" >咨询辅导区</Excel:td>
			<Excel:td  align="center" bordercolor="black" >档案室</Excel:td>
			<Excel:td  align="center" bordercolor="black" >主任室</Excel:td>
			<Excel:td  align="center" bordercolor="black" >填表区</Excel:td>
			<Excel:td  align="center" bordercolor="black" >其他</Excel:td>
				
		</Excel:tr>
		<%
			DataSet ds = (DataSet)request.getAttribute("dataset");
				for(int i=0; i<ds.getCount(); i++) {
					Record rec = ds.getRecord(i);
		%>
		<Excel:tr border="1">
			<Excel:td><%=rec.get("ORGAN_NAME")%></Excel:td>
			<Excel:td><%=rec.get("TOTALAREA")%></Excel:td>
			<Excel:td><%=rec.get("HDAREA")%></Excel:td>			
			<Excel:td><%=rec.get("JHAREA")%></Excel:td>
			<Excel:td><%=rec.get("LHAREA")%></Excel:td>
			<Excel:td><%=rec.get("BZAREA")%></Excel:td>
			<Excel:td><%=rec.get("ZXFDAREA")%></Excel:td>			
			<Excel:td><%=rec.get("DASAREA")%></Excel:td>
			<Excel:td><%=rec.get("ZRSAREA")%></Excel:td>
			<Excel:td><%=rec.get("TBQAREA")%></Excel:td>
			<Excel:td><%=rec.get("OTHERAREA")%></Excel:td>			
		</Excel:tr>
		<%
			}
		%>
		<Excel:tr>
			<Excel:td colspan="5" align="left">制表人：<%= username%></Excel:td>
			<Excel:td colspan="6" align="right">制表时间：<%= date2%></Excel:td>
		</Excel:tr>
	</Excel:table>
</Excel:tablelist>

