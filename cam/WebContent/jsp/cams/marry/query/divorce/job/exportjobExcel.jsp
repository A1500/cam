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
	String name="离婚登记当事人职业状况统计表_"+date;
	String username=GetBspInfo.getBspInfo(request).getUserName();
%>
</head>
<Excel:tablelist filename="<%=name %>">
	<Excel:table sheetname="离婚登记当事人职业状况统计表">
		<Excel:tr>
			<Excel:td colspan="18" align="center" ><Excel:font size="15">离婚登记当事人职业状况统计表</Excel:font></Excel:td>
		</Excel:tr>
		<Excel:tr>
			<Excel:td colspan="9" align="left">统计单位：<%= BspUtil.getOrganName()%></Excel:td>
			<Excel:td colspan="9" align="right">统计时间:<%=request.getParameter("statisticsTime")%></Excel:td>
		</Excel:tr>
		<Excel:tr height="30" bgcolor="grey" border="1">
			<Excel:td  align="center" width="100" rowspan="2" bordercolor="black">地区行政区划名称</Excel:td>
			<Excel:td  align="center" width="100" rowspan="2" bordercolor="black">合计(人)</Excel:td>			
			<Excel:td  align="center" width="100" colspan="2" bordercolor="black">不便分类的其他从业人员</Excel:td>
			<Excel:td  align="center" width="100" colspan="2" bordercolor="black">军人</Excel:td>
			<Excel:td  align="center" width="100" colspan="2" bordercolor="black">生产、运输设备操作人员及有关人员</Excel:td>
			<Excel:td  align="center" width="100" colspan="2" bordercolor="black">农、林、牧、渔、水利业生产人员</Excel:td>
			<Excel:td  align="center" width="100" colspan="2" bordercolor="black">商业、服务业人员</Excel:td>
			<Excel:td  align="center" width="100" colspan="2" bordercolor="black">办事人员和有关人员</Excel:td>
			<Excel:td  align="center" width="100" colspan="2" bordercolor="black">专业技术人员</Excel:td>
			<Excel:td  align="center" width="100" colspan="2" bordercolor="black">国家机关、党群组织、企业、事业单位负责人</Excel:td>
			<Excel:td  align="center" width="100" colspan="2" bordercolor="black">无业人员</Excel:td>
		</Excel:tr>
		<Excel:tr height="20" bgcolor="grey" border="1">
			<Excel:td  align="center" bordercolor="black" >人数</Excel:td>
			<Excel:td  align="center" bordercolor="black" >％</Excel:td>			
			<Excel:td  align="center" bordercolor="black" >人数</Excel:td>
			<Excel:td  align="center" bordercolor="black" >％</Excel:td>	
			<Excel:td  align="center" bordercolor="black" >人数</Excel:td>
			<Excel:td  align="center" bordercolor="black" >％</Excel:td>	
			<Excel:td  align="center" bordercolor="black" >人数</Excel:td>
			<Excel:td  align="center" bordercolor="black" >％</Excel:td>	
			<Excel:td  align="center" bordercolor="black" >人数</Excel:td>
			<Excel:td  align="center" bordercolor="black" >％</Excel:td>	
			<Excel:td  align="center" bordercolor="black" >人数</Excel:td>
			<Excel:td  align="center" bordercolor="black" >％</Excel:td>	
			<Excel:td  align="center" bordercolor="black" >人数</Excel:td>
			<Excel:td  align="center" bordercolor="black" >％</Excel:td>	
			<Excel:td  align="center" bordercolor="black" >人数</Excel:td>
			<Excel:td  align="center" bordercolor="black" >％</Excel:td>	
			<Excel:td  align="center" bordercolor="black" >人数</Excel:td>
			<Excel:td  align="center" bordercolor="black" >％</Excel:td>	
		</Excel:tr>
		<%
			DataSet ds = (DataSet)request.getAttribute("dataset");
				for(int i=0; i<ds.getCount(); i++) {
					Record rec = ds.getRecord(i);
		%>
		<Excel:tr border="1">
			<Excel:td align="center"><%=rec.get("ITEM_NAME")%></Excel:td>
			<Excel:td align="right"><%=rec.get("TOTAL_NUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("JOB0_NUM")%></Excel:td>			
			<Excel:td align="right"><%=rec.get("JOB0_RATE")%></Excel:td>
			<Excel:td align="right"><%=rec.get("JOB1_NUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("JOB1_RATE")%></Excel:td>
			<Excel:td align="right"><%=rec.get("JOB2_NUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("JOB2_RATE")%></Excel:td>
			<Excel:td align="right"><%=rec.get("JOB3_NUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("JOB3_RATE")%></Excel:td>
			<Excel:td align="right"><%=rec.get("JOB4_NUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("JOB4_RATE")%></Excel:td>
			<Excel:td align="right"><%=rec.get("JOB5_NUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("JOB5_RATE")%></Excel:td>
			<Excel:td align="right"><%=rec.get("JOB6_NUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("JOB6_RATE")%></Excel:td>
			<Excel:td align="right"><%=rec.get("JOB7_NUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("JOB7_RATE")%></Excel:td>
			<Excel:td align="right"><%=rec.get("JOB8_NUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("JOB8_RATE")%></Excel:td>
		</Excel:tr>
		<%
			}
		%>
		<Excel:tr>
			<Excel:td colspan="9" align="left">制表人：<%= username%></Excel:td>
			<Excel:td colspan="9" align="right">制表时间：<%= date2%></Excel:td>
		</Excel:tr>
	</Excel:table>
</Excel:tablelist>

