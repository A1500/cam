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
	String name1="假肢和矫形器生产装配企业建设情况统计表";
	String name = name1+"_"+date;
	String username = GetBspInfo.getBspInfo(request).getUserName();
	out.clear();//清空缓存的内容
	out = pageContext.pushBody(); 
%>
</head>
<Excel:tablelist filename="<%=name %>">
	<Excel:table sheetname="<%=name1 %>">
		<Excel:tr>
			<Excel:td colspan="11" align="center" ><Excel:font size="15"  bold="true"><%=name1 %></Excel:font></Excel:td>
		</Excel:tr>
		<Excel:tr>

			<Excel:td colspan="5" align="left">统计单位：<%= BspUtil.getOrganName()%></Excel:td>
			<Excel:td colspan="6" align="right"></Excel:td>
	
		</Excel:tr>
		<Excel:tr height="30" bgcolor="grey" border="1">
		<Excel:td  align="center" width="100" rowspan="2" bordercolor="black"> 地区</Excel:td>
			<Excel:td  align="center" width="100" rowspan="2" bordercolor="black"> 企业总数</Excel:td>
			<Excel:td  align="center" width="100" colspan="9" bordercolor="black">建设情况（万平方米）</Excel:td>
		</Excel:tr>
		<Excel:tr height="30" bgcolor="grey" border="1">
			<Excel:td  align="center" width="100"  bordercolor="black">总经营面积</Excel:td>
			<Excel:td  align="center" width="100"  bordercolor="black">制作间面积</Excel:td>
			<Excel:td  align="center" width="100"  bordercolor="black">康复室面积</Excel:td>
			<Excel:td  align="center" width="100"  bordercolor="black">接待室面积</Excel:td>
			<Excel:td  align="center" width="100"  bordercolor="black">训练厅面积</Excel:td>
			<Excel:td  align="center" width="100"  bordercolor="black">理疗室面积</Excel:td>
			<Excel:td  align="center" width="100"  bordercolor="black">办公面积</Excel:td>
			<Excel:td  align="center" width="100"  bordercolor="black">休闲区面积</Excel:td>
			<Excel:td  align="center" width="100"  bordercolor="black">其它</Excel:td>
		</Excel:tr>
		<%
			DataSet ds = (DataSet)request.getAttribute("dataset");
				for(int i=0; i<ds.getCount(); i++) {
					Record rec = ds.getRecord(i);
		%>
		<Excel:tr border="1">
			<Excel:td align="center" ><%=rec.get("NAME")%></Excel:td>
			<Excel:td align="center" ><%=rec.get("FIT_NUM")==null?"0":rec.get("FIT_NUM")%></Excel:td>
			<Excel:td align="center" ><%=rec.get("OPERATE_AREA")==null?"0":rec.get("OPERATE_AREA")%></Excel:td>	
			<Excel:td align="center" ><%=rec.get("PRODUCT_AREA")==null?"0":rec.get("PRODUCT_AREA")%></Excel:td>	
			<Excel:td align="center" ><%=rec.get("RECOVERY_AREA")==null?"0":rec.get("RECOVERY_AREA")%></Excel:td>	
			<Excel:td align="center" ><%=rec.get("RECEPTION_AREA")==null?"0":rec.get("RECEPTION_AREA")%></Excel:td>	
			<Excel:td align="center" ><%=rec.get("TRAIN_AREA")==null?"0":rec.get("TRAIN_AREA")%></Excel:td>	
			<Excel:td align="center" ><%=rec.get("TREATMENT_AREA")==null?"0":rec.get("TREATMENT_AREA")%></Excel:td>	
			<Excel:td align="center" ><%=rec.get("WORK_AREA")==null?"0":rec.get("WORK_AREA")%></Excel:td>	
			<Excel:td align="center" ><%=rec.get("LEISURE_AREA")==null?"0":rec.get("LEISURE_AREA")%></Excel:td>
			<Excel:td align="center" ><%=rec.get("OTHER_AREA")==null?"0":rec.get("OTHER_AREA")%></Excel:td>
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

