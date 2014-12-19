<%@page contentType="charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="/tags/next-excel" prefix="Excel"%>
<%@page import="org.loushang.next.data.DataSet"%>
<%@page import="org.loushang.next.data.Record"%>
<%@page import="org.loushang.next.data.FieldSet"%>
<%@page import="org.loushang.next.commons.nenum.EnumService" %>
<%@page import="org.loushang.sca.ScaComponentFactory" %>
<%@page import="java.math.BigDecimal" %>
<%@page import="java.text.DecimalFormat" %>

<%@page import="java.text.SimpleDateFormat"%>
<%@ page import="org.loushang.bsp.security.context.GetBspInfo"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<%@page import="java.util.*"%>
<%
	SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
	String date=sdf.format(new Date());
	String title="火化数据查询_"+date;
	out.clear();//清空缓存的内容
	out = pageContext.pushBody(); 
%>
<!--导出Excel-->
<Excel:tablelist filename="<%=title%>">
	<Excel:table sheetname="火化数据分所属地区统计" border="1">
		<Excel:tr>
			<Excel:td colspan="12" align="center" border="0"><Excel:font size="15">火化数据查询导出</Excel:font></Excel:td>
		</Excel:tr>
		<Excel:tr border="0">
		<Excel:td  align="left" colspan="6" border="0">导出单位：<%=BspUtil.getOrganName()%></Excel:td>
		<Excel:td  align="right" colspan="6" border="0">导出时间：<%=date%></Excel:td>
		</Excel:tr>
		<Excel:tr  border="1" bgcolor="grey">
			<Excel:td width="90" align="center">户口所在地</Excel:td>
			<Excel:td width="150" align="center">殡仪馆名称</Excel:td>
			<Excel:td width="90" align="center">逝者姓名</Excel:td>
			<Excel:td width="90" align="center">性别</Excel:td>
			<Excel:td width="90" align="center">年龄</Excel:td>
			<Excel:td width="150" align="center">证件号码</Excel:td>
			<Excel:td width="90" align="center">享受惠民政策</Excel:td>
			<Excel:td width="90" align="center">死亡原因</Excel:td>
			<Excel:td width="90" align="center">入馆时间</Excel:td>
			<Excel:td width="90" align="center">去世时间</Excel:td>
			<Excel:td width="150" align="center">火化时间</Excel:td>
			<Excel:td width="200" align="center">骨灰去向</Excel:td>
		</Excel:tr>
		<%
				DataSet dataset = (DataSet) request.getAttribute("dataset");
					EnumService enumService = ScaComponentFactory.getService(EnumService.class, "Enum/EnumService");
					for (int i = 0; i < dataset.getCount(); i++){
						Record rec = dataset.getRecord(i);
						String sex = "";
						if("1".equals((String)rec.get("SEX"))){
							sex = "男";
						}else if("2".equals((String)rec.get("SEX"))){
							sex = "女";
						}
						String ashego = "";
						if (rec.get("ASHES_GO") != null) {
							ashego = enumService.getDescByValue("FIS.ASHES.GO", (String) rec.get("ASHES_GO"));
						}
		%>
		<Excel:tr  border="1">
			<Excel:td align="center"><%=rec.get("POPULACE_NAME")%></Excel:td>
			<Excel:td align="right"><%=rec.get("CREATE_ORGAN_NAME")%></Excel:td>
			<Excel:td align="right"><%=rec.get("NAME")%></Excel:td>
			<Excel:td align="right"><%=sex%></Excel:td>
			<Excel:td align="right"><%=rec.get("AGE")%></Excel:td>
			<Excel:td align="right"><%=rec.get("ID_CARD")%></Excel:td>
			<Excel:td align="right"><%=rec.get("PREFERENTIAL_TYPE")%></Excel:td>
			<Excel:td align="right"><%=rec.get("DEATH_CAUSE")%></Excel:td>
			<Excel:td align="right"><%=rec.get("RECEIVE_TIME")%></Excel:td>
			<Excel:td align="right"><%=rec.get("DEATH_DATE")%></Excel:td>
			<Excel:td align="right"><%=rec.get("START_TIME")%></Excel:td>
			<Excel:td align="right"><%=ashego%></Excel:td>
		</Excel:tr>
		<%
					}
		%>	
		<Excel:tr border="0">
		<Excel:td  align="left" colspan="6" border="0">制表人：<%=BspUtil.getEmpOrgan().getShortName()%></Excel:td>
		<Excel:td  align="right" colspan="6" border="0">制表时间：<%=date %></Excel:td>
		</Excel:tr>
	</Excel:table>
</Excel:tablelist>