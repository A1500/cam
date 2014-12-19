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
	String statisticsTime=request.getParameter("statisticsTime");
	String name=statisticsTime+"敬老院基本情况统计表（一）";
	String username = GetBspInfo.getBspInfo(request).getUserName();
	out.clear();//清空缓存的内容
	out = pageContext.pushBody(); 
%>
</head>
<Excel:tablelist filename="<%=name %>">
	<Excel:table sheetname="敬老院基本情况统计表（一）">
		<Excel:tr>
			<Excel:td colspan="17" align="center" ><Excel:font size="15"  bold="true"><%=name %></Excel:font></Excel:td>
		</Excel:tr>
		<Excel:tr>
			<Excel:td colspan="8" align="left">统计单位：<%= BspUtil.getOrganName()%></Excel:td>
			<Excel:td colspan="9" align="right">统计时间:<%=statisticsTime%></Excel:td>
		</Excel:tr>
		<Excel:tr height="30" bgcolor="grey" border="1">
			<Excel:td  align="center" width="100" rowspan="2" bordercolor="black">单位</Excel:td>
			<Excel:td  align="center" width="100" rowspan="2" bordercolor="black">总数</Excel:td>			
			
			<Excel:td  align="center" width="100" colspan="4" bordercolor="black">等级</Excel:td>
			<Excel:td  align="center" width="100" rowspan="2" bordercolor="black">占地面积（亩）</Excel:td>
			<Excel:td  align="center" width="100" rowspan="2" bordercolor="black">建筑面积（㎡）</Excel:td>
			<Excel:td  align="center" width="100" rowspan="2" bordercolor="black">室外娱乐场所面积（㎡）</Excel:td>
			<Excel:td  align="center" width="100" rowspan="2" bordercolor="black">内娱乐场所面积（㎡）</Excel:td>
			<Excel:td  align="center" width="100" colspan="4" bordercolor="black">取暖方式</Excel:td>
			<Excel:td  align="center" width="100" colspan="2" bordercolor="black">床位（个）</Excel:td>
			<Excel:td  align="center" width="100" rowspan="2" bordercolor="black">集中供养率</Excel:td>
		</Excel:tr>
		<Excel:tr height="20" bgcolor="grey" border="1">
			<Excel:td  align="center" bordercolor="black" width="100">一级</Excel:td>
			<Excel:td  align="center" bordercolor="black" width="100">二级</Excel:td>
			<Excel:td  align="center" bordercolor="black" width="100">三级</Excel:td>
			<Excel:td  align="center" bordercolor="black" width="100">其他</Excel:td>
			<Excel:td  align="center" bordercolor="black" width="100">集中供暖</Excel:td>
			<Excel:td  align="center" bordercolor="black" width="100">燃煤取暖</Excel:td>
			<Excel:td  align="center" bordercolor="black" width="100">燃气取暖</Excel:td>
			<Excel:td  align="center" bordercolor="black" width="100">空调取暖</Excel:td>
			<Excel:td  align="center" bordercolor="black" width="100">合计</Excel:td>
			<Excel:td  align="center" bordercolor="black" width="100">占用</Excel:td>	
		</Excel:tr>
		<%
			DataSet ds = (DataSet)request.getAttribute("dataset");
		
		%>
		<Excel:tr border="1">
			<Excel:td align="center">合计</Excel:td>
			<Excel:td align="right"><%=ds.sum("NUM_SUM")==null?"0":ds.sum("NUM_SUM")%></Excel:td>			
			<Excel:td align="right"><%=ds.sum("LEVEL_ONE")==null?"0":ds.sum("LEVEL_ONE")%></Excel:td>
			<Excel:td align="right"><%=ds.sum("LEVEL_TWO")==null?"0":ds.sum("LEVEL_TWO")%></Excel:td>
			<Excel:td align="right"><%=ds.sum("LEVEL_THREE")==null?"0":ds.sum("LEVEL_THREE")%></Excel:td>
			<Excel:td align="right"><%=ds.sum("LEVEL_FOUR")==null?"0":ds.sum("LEVEL_FOUR")%></Excel:td>
			<Excel:td align="right"><%=ds.sum("TOTAL_AREA_SUM")==null?"0":ds.sum("TOTAL_AREA_SUM")%></Excel:td>
			<Excel:td align="right"><%=ds.sum("BUILD_AREA_SUM")==null?"0":ds.sum("BUILD_AREA_SUM")%></Excel:td>			
			<Excel:td align="right"><%=ds.sum("OUTDOOR_AREA_SUM")==null?"0":ds.sum("OUTDOOR_AREA_SUM")%></Excel:td>
			<Excel:td align="right"><%=ds.sum("INDOOR_AREA_SUM")==null?"0":ds.sum("INDOOR_AREA_SUM")%></Excel:td>
			<Excel:td align="right"><%=ds.sum("HEATING_JZ")==null?"0":ds.sum("HEATING_JZ")%></Excel:td>	
			<Excel:td align="right"><%=ds.sum("HEATING_RM")==null?"0":ds.sum("HEATING_RM")%></Excel:td>	
			<Excel:td align="right"><%=ds.sum("HEATING_RQ")==null?"0":ds.sum("HEATING_RQ")%></Excel:td>	
			<Excel:td align="right"><%=ds.sum("HEATING_KT")==null?"0":ds.sum("HEATING_KT")%></Excel:td>	
			<Excel:td align="right"><%=ds.sum("BED_SUM")==null?"0":ds.sum("BED_SUM")%></Excel:td>	
			<Excel:td align="right"><%=ds.sum("BED_SUM_INUSE")==null?"0":ds.sum("BED_SUM_INUSE")%></Excel:td>	
			<Excel:td align="right"><%=ds.sum("BED_SUM_INUSE")==null?"0":ds.sum("BED_SUM_INUSE")%></Excel:td>	
		</Excel:tr>
		
		<%
				for(int i=0; i<ds.getCount(); i++) {
					Record rec = ds.getRecord(i);
		%>
		<Excel:tr border="1">
			<Excel:td align="center"><%=rec.get("NAME")%></Excel:td>
			<Excel:td align="right"><%=rec.get("NUM_SUM")==null?"0":rec.get("NUM_SUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("LEVEL_ONE")==null?"0":rec.get("LEVEL_ONE")%></Excel:td>			
			<Excel:td align="right"><%=rec.get("LEVEL_TWO")==null?"0":rec.get("LEVEL_TWO")%></Excel:td>
			<Excel:td align="right"><%=rec.get("LEVEL_THREE")==null?"0":rec.get("LEVEL_THREE")%></Excel:td>
			<Excel:td align="right"><%=rec.get("LEVEL_FOUR")==null?"0":rec.get("LEVEL_FOUR")%></Excel:td>
			<Excel:td align="right"><%=rec.get("TOTAL_AREA_SUM")==null?"0":rec.get("TOTAL_AREA_SUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("BUILD_AREA_SUM")==null?"0":rec.get("BUILD_AREA_SUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("OUTDOOR_AREA_SUM")==null?"0":rec.get("OUTDOOR_AREA_SUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("INDOOR_AREA_SUM")==null?"0":rec.get("INDOOR_AREA_SUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("HEATING_JZ")==null?"0":rec.get("HEATING_JZ")%></Excel:td>
			<Excel:td align="right"><%=rec.get("HEATING_RM")==null?"0":rec.get("HEATING_RM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("HEATING_RQ")==null?"0":rec.get("HEATING_RQ")%></Excel:td>
			<Excel:td align="right"><%=rec.get("HEATING_KT")==null?"0":rec.get("HEATING_KT")%></Excel:td>
			<Excel:td align="right"><%=rec.get("BED_SUM")==null?"0":rec.get("BED_SUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("BED_SUM_INUSE")==null?"0":rec.get("BED_SUM_INUSE")%></Excel:td>
			<Excel:td align="right"><%=rec.get("BED_SUM_INUSE")==null?"0":rec.get("BED_SUM_INUSE")%></Excel:td>
		</Excel:tr>
		<%
			}
		%>
		<Excel:tr>
			<Excel:td colspan="8" align="left">制表人：<%= username%></Excel:td>
			<Excel:td colspan="9" align="right">制表时间：<%= date2%></Excel:td>
		</Excel:tr>
	</Excel:table>
</Excel:tablelist>

