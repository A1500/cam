<%@ page contentType="charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ taglib uri="/tags/next-excel" prefix="Excel"%>
<%@page import="org.loushang.next.data.DataSet"%>
<%@page import="org.loushang.next.data.Record"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<html>
<head>
<title>导出Excel</title>
<next:ScriptManager />
</head>
<%!
	//SimpleDateFormat sdf=new SimpleDateFormat("yyyy年MM月dd日HH时mm分");
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	String date = sdf.format(new Date());
	String name = "公墓信息_" + date;
	
	String getProp(Object prop) {
		if ("1".equals(prop)) {
			return "公益性";
		} else if ("2".equals(prop)) {
			return "经营性";
		}
		return "";
	}

	String getResult(Object result) {
		if ("1".equals(result)) {
			return "合格";
		} else if ("2".equals(result)) {
			return "不合格";
		}
		return "未参检";
	}
%>
<Excel:tablelist filename="<%=name%>">
	<Excel:table sheetname="公墓信息列表">
		<Excel:tr>
			<Excel:td colspan="11" align="center">
				<Excel:font size="15">公墓信息列表</Excel:font>
			</Excel:td>
		</Excel:tr>
		<Excel:tr border="0">
			<Excel:td align="right" colspan="11" border="0">统计单位：<%=BspUtil.getOrganName()%></Excel:td>
		</Excel:tr>
		<Excel:tr bgcolor="grey" border="1">

			<Excel:td align="center" width="100">公墓编号</Excel:td>
			<Excel:td align="center" width="100">公墓名称</Excel:td>
			<Excel:td align="center" width="100">公墓性质</Excel:td>
			<Excel:td align="center" width="100">法人代表</Excel:td>
			<Excel:td align="center" width="100">主办/联办单位</Excel:td>
			<Excel:td align="center" width="100">正式营业时间</Excel:td>
			<Excel:td align="center" width="100">地址</Excel:td>
			<Excel:td align="center" width="100">主管单位</Excel:td>
			<Excel:td align="center" width="100">所属行政区</Excel:td>
			<Excel:td align="center" width="100">最近年检时间</Excel:td>
			<Excel:td align="center" width="100">最近年检结果</Excel:td>
		</Excel:tr>
		<%
			DataSet dataset = (DataSet) request.getAttribute("dataset");
					for (int i = 0; i < dataset.getCount(); i++) {
						Record record = dataset.getRecord(i);
		%>
		<Excel:tr border="1">
			<Excel:td><%=record.get("CEME_ID")%></Excel:td>
			<Excel:td><%=record.get("CEME_NAME")%></Excel:td>
			<Excel:td><%=getProp(record.get("PROP"))%></Excel:td>
			<Excel:td><%=record.get("LEGAL_PERSON")%></Excel:td>
			<Excel:td><%=record.get("ORGANIZER")%></Excel:td>
			<Excel:td><%=record.get("GESTION_TIME")%></Excel:td>
			<Excel:td><%=record.get("ADDRESS")%></Excel:td>
			<Excel:td><%=record.get("MANA_LEVEL")%></Excel:td>
			<Excel:td><%=record.get("AREA_LEVEL")%></Excel:td>
			<Excel:td><%=record.get("CHECK_YEAR")%></Excel:td>
			<Excel:td><%=getResult(record.get("CHECK_RESULT"))%></Excel:td>
		</Excel:tr>
		<%
			}
		%>
		<Excel:tr border="0">
			<Excel:td align="left" colspan="6" border="0">制表人：<%=BspUtil.getEmpOrgan().getShortName()%></Excel:td>
			<Excel:td align="right" colspan="5" border="0">制表时间：<%=date%></Excel:td>
		</Excel:tr>
	</Excel:table>
</Excel:tablelist>
</html>