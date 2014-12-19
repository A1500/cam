<%@page contentType="charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="/tags/next-excel" prefix="Excel"%>
<%@page import="org.loushang.next.data.DataSet"%>
<%@page import="org.loushang.next.data.Record"%>
<%@page import="org.loushang.next.commons.nenum.EnumService" %>
<%@page import="org.loushang.sca.ScaComponentFactory" %>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<%@page import="java.util.*"%>
<%
	String assistanceType = request.getParameter("assistanceType");
	SimpleDateFormat sdf=new SimpleDateFormat("yyyy年MM月dd日HH时mm分");
	String date=sdf.format(new Date());
	String title = "光荣院发展情况统计表_"+date;
	String name = "光荣院发展情况统计表";
%>

<!--导出Excel-->
<Excel:tablelist filename="<%=title%>">
	<Excel:table sheetname="<%=name%>">
		<Excel:tr border="0">
			<Excel:td colspan="20" align="center" border="0"><Excel:font size="16"><%=name%></Excel:font></Excel:td>
		</Excel:tr>
		<Excel:tr border="0">
			<Excel:td colspan="2" align="left" border="0">统计单位：<%= BspUtil.getOrganName()%></Excel:td>
			<Excel:td colspan="18" align="right" border="0">统计时间:<%=request.getParameter("statisticsTime")%>年</Excel:td>
		</Excel:tr>
		<Excel:tr  bgcolor="grey" border="1">
			<Excel:td  align="center" width="170"><Excel:font>属地行政区划</Excel:font></Excel:td>
			<Excel:td  align="center" width="170"><Excel:font>光荣院名称</Excel:font></Excel:td>
			<Excel:td  align="center" width="70"><Excel:font>年度</Excel:font></Excel:td>
			<Excel:td  align="center" width="100"><Excel:font>建立日期</Excel:font></Excel:td>
			<Excel:td  align="center" width="95"><Excel:font>建设状况</Excel:font></Excel:td>
			<Excel:td  align="center" width="70"><Excel:font>建设方式</Excel:font></Excel:td>
			<Excel:td  align="center" width="90"><Excel:font>有无编委批文</Excel:font></Excel:td>
			<Excel:td  align="center" width="65"><Excel:font>编制人数</Excel:font></Excel:td>
			<Excel:td  align="center" width="65"><Excel:font>床位数</Excel:font></Excel:td>
			<Excel:td  align="center" width="110"><Excel:font>总计投入（万元）</Excel:font></Excel:td>
			<Excel:td  align="center" width="110"><Excel:font>县级投入（万元）</Excel:font></Excel:td>
			<Excel:td  align="center" width="110"><Excel:font>市级投入（万元）</Excel:font></Excel:td>
			<Excel:td  align="center" width="110"><Excel:font>省级投入（万元）</Excel:font></Excel:td>
			<Excel:td  align="center" width="110"><Excel:font>中央投入（万元）</Excel:font></Excel:td>
			<Excel:td  align="center" width="135"><Excel:font>市级以上投入（万元）</Excel:font></Excel:td>
			<Excel:td  align="center" width="120"><Excel:font>孤老优抚对象（人）</Excel:font></Excel:td>
			<Excel:td  align="center" width="120"><Excel:font>其他优抚对象（人）</Excel:font></Excel:td>
			<Excel:td  align="center" width="80"><Excel:font>轮养（人次）</Excel:font></Excel:td>
			<Excel:td  align="center" width="120"><Excel:font>敬老院光荣间（间）</Excel:font></Excel:td>
			<Excel:td  align="center" width="175"><Excel:font>在敬老院孤老优抚对象（人）</Excel:font></Excel:td>
		</Excel:tr>
		<%
			String buildState = "";
			String buildingapproach = "";
			String approval = "";
			DataSet dataset = (DataSet) request.getAttribute("dataset");
			EnumService enumService = ScaComponentFactory.getService(EnumService.class, "Enum/EnumService");
			for (int i = 0; i < dataset.getCount(); i++) {
				Record rec = dataset.getRecord(i);
				if(rec.get("buildState")!=null){
					buildState =  enumService.getDescByValue("BPT.BUILDSTATE", (String)rec.get("buildState"));
				}
				if(rec.get("buildingapproach")!=null){
					buildingapproach =  enumService.getDescByValue("BPT.BUILDINGAPPROACH.TYPE", (String)rec.get("buildingapproach"));
				}
				if(rec.get("approval")!=null){
					approval =  enumService.getDescByValue("COMM.YESORNO", (String)rec.get("approval"));
				}
		%>
		<Excel:tr border="1">
			<Excel:td align="center"><%=rec.get("name")%></Excel:td>
			<Excel:td align="center"><%=rec.get("unitFullname")%></Excel:td>
			<Excel:td align="center"><%=rec.get("years")%></Excel:td>
			<Excel:td align="center"><%=rec.get("creationDate")%></Excel:td>
			<Excel:td align="center"><%=buildState%></Excel:td>
			<Excel:td align="center"><%=buildingapproach%></Excel:td>
			<Excel:td align="center"><%=approval%></Excel:td>
			<Excel:td align="center"><%=rec.get("prepareNum")%></Excel:td>
			<Excel:td align="center"><%=rec.get("bedNum")%></Excel:td>
			<Excel:td align="right"><%=rec.get("totalFunds")%></Excel:td>
			<Excel:td align="right"><%=rec.get("countyfunds")%></Excel:td>
			<Excel:td align="right"><%=rec.get("cityfunds")%></Excel:td>
			<Excel:td align="right"><%=rec.get("provincefunds")%></Excel:td>
			<Excel:td align="right"><%=rec.get("centralFunds")%></Excel:td>
			<Excel:td align="center"><%=rec.get("aboveCityfunds")%></Excel:td>
			<Excel:td align="center"><%=rec.get("specialassistance")%></Excel:td>
			<Excel:td align="center" ><%=rec.get("otherNum")%></Excel:td>
			<Excel:td align="center"><%=rec.get("careRotation")%></Excel:td>
			<Excel:td align="center"><%=rec.get("gloryroom")%></Excel:td>
			<Excel:td align="center"><%=rec.get("carePeople")%></Excel:td>
		</Excel:tr>
		<%
			}
		%>
		<Excel:tr border="0">
		<Excel:td  align="left" colspan="2" border="0">制表人：<%=BspUtil.getEmpOrgan().getShortName()%></Excel:td>
		<Excel:td  align="right" colspan="18" border="0">制表时间：<%=date %></Excel:td>
		</Excel:tr>
	</Excel:table>
</Excel:tablelist>