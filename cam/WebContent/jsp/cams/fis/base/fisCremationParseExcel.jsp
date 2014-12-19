<%@page contentType="charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="org.loushang.next.data.DataSet"%>
<%@page import="org.loushang.next.data.Record"%>
<%@page import="org.loushang.next.commons.nenum.EnumService"%>
<%@page import="org.loushang.sca.ScaComponentFactory"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<%@page import="java.util.*"%>
<%@taglib uri="/tags/next-excel" prefix="Excel"%>
<%
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	String date = sdf.format(new Date());
	String title = "数据质量查询导出_" + date;
	out.clear();	//清空缓存的内容
	out = pageContext.pushBody();
%>
<!--导出Excel-->
<Excel:tablelist filename="<%=title%>">
	<Excel:table sheetname="数据质量查询" border="1">
		<Excel:tr>
			<Excel:td colspan="8" align="center" border="0">
				<Excel:font size="15">数据质量查询导出</Excel:font>
			</Excel:td>
		</Excel:tr>
		<Excel:tr border="0">
			<Excel:td align="right" colspan="8" border="0">统计单位：<%=BspUtil.getOrganName()%></Excel:td>
		</Excel:tr>
		<Excel:tr border="1" bgcolor="grey">
			<Excel:td width="100" align="center">殡仪馆编号</Excel:td>
			<Excel:td width="200" align="center">殡仪馆名称</Excel:td>
			<Excel:td width="100" align="center">当年火化数</Excel:td>
			<Excel:td width="100" align="center">上年火化数</Excel:td>
			<Excel:td width="100" align="center">证件类型为空数量</Excel:td>
			<Excel:td width="100" align="center">证件号为空数量</Excel:td>
			<Excel:td width="100" align="center">当年不规则数据</Excel:td>
			<Excel:td width="100" align="center">不规则数据总数</Excel:td>
		</Excel:tr>
		<%
			DataSet dataset = (DataSet) request.getAttribute("dataset");
				for (int i = 0; i < dataset.getCount(); i++) {
					Record rec = dataset.getRecord(i);
		%>
		<Excel:tr border="1">
			<Excel:td align="center"><%=rec.get("UNIT_ID")%></Excel:td>
			<Excel:td align="center"><%=rec.get("UNIT_NAME")%></Excel:td>
			<Excel:td align="center"><%=rec.get("CREMATION_NUM_YEAR")%></Excel:td>
			<Excel:td align="center"><%=rec.get("CREMATION_NUM_LAST_YEAR")%></Excel:td>
			<Excel:td align="center"><%=rec.get("NULL_IDTYPE_NUM")%></Excel:td>
			<Excel:td align="center"><%=rec.get("NULL_ID_NUM")%></Excel:td>
			<Excel:td align="center"><%=rec.get("ILLEGAL_DATA_YEAR")%></Excel:td>
			<Excel:td align="center"><%=rec.get("ILLEGAL_DATA_TOTAL")%></Excel:td>
		</Excel:tr>
		<%
			}
		%>
		<Excel:tr border="0">
			<Excel:td align="left" colspan="4" border="0">制表人：<%=BspUtil.getEmpOrgan().getShortName()%></Excel:td>
			<Excel:td align="right" colspan="4" border="0">制表时间：<%=date%></Excel:td>
		</Excel:tr>
	</Excel:table>
</Excel:tablelist>