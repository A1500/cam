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
	String name="离婚原因统计表_"+date;
	String username=GetBspInfo.getBspInfo(request).getUserName();
%>
</head>
<Excel:tablelist filename="<%=name %>">
	<Excel:table sheetname="离婚原因统计表">
		<Excel:tr>
			<Excel:td colspan="24" align="center" ><Excel:font size="15">离婚原因统计表</Excel:font></Excel:td>
		</Excel:tr>
		<Excel:tr>
			<Excel:td colspan="12" align="left">统计单位：<%= BspUtil.getOrganName()%></Excel:td>
			<Excel:td colspan="12" align="right">统计时间:<%=request.getParameter("statisticsTime")%></Excel:td>
		</Excel:tr>
		<Excel:tr height="30" bgcolor="grey" border="1">
			<Excel:td  align="center" width="100" rowspan="2" bordercolor="black">地区行政区划名称</Excel:td>
			<Excel:td  align="center" width="100" rowspan="2" bordercolor="black">合计</Excel:td>			
			<Excel:td  align="center" width="50" colspan="2" bordercolor="black">感情不和</Excel:td>
			<Excel:td  align="center" width="50" colspan="2" bordercolor="black">经济困难</Excel:td>
			<Excel:td  align="center" width="50" colspan="2" bordercolor="black">第三者插足</Excel:td>
			<Excel:td  align="center" width="50" colspan="2" bordercolor="black">两地生活</Excel:td>
			<Excel:td  align="center" width="50" colspan="2" bordercolor="black">教育子女</Excel:td>
			<Excel:td  align="center" width="50" colspan="2" bordercolor="black">家庭纠纷</Excel:td>
			<Excel:td  align="center" width="50" colspan="2" bordercolor="black">夫妻性生活不和谐</Excel:td>
			<Excel:td  align="center" width="50" colspan="2" bordercolor="black">一方有违法犯罪行为</Excel:td>
			<Excel:td  align="center" width="50" colspan="2" bordercolor="black">一方有不良生活习惯</Excel:td>
			<Excel:td  align="center" width="50" colspan="2" bordercolor="black">婚前缺乏了解</Excel:td>
			<Excel:td  align="center" width="50" colspan="2" bordercolor="black">其他</Excel:td>
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
			<Excel:td align="right"><%=rec.get("INCOMPATIBLE_NUM")%></Excel:td>			
			<Excel:td align="right"><%=rec.get("INCOMPATIBLE_RATE")%></Excel:td>
			<Excel:td align="right"><%=rec.get("FINANCIAL_NUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("FINANCIAL_RATE")%></Excel:td>
			<Excel:td align="right"><%=rec.get("THIRD_NUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("THIRD_RATE")%></Excel:td>
			<Excel:td align="right"><%=rec.get("BOTH_PLACES_NUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("BOTH_PLACES_RATE")%></Excel:td>
			<Excel:td align="right"><%=rec.get("EDUCATION_NUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("EDUCATION_RATE")%></Excel:td>
			<Excel:td align="right"><%=rec.get("DISSENSION_NUM")%></Excel:td>			
			<Excel:td align="right"><%=rec.get("DISSENSION_RATE")%></Excel:td>
			<Excel:td align="right"><%=rec.get("SEXUAL_NUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("SEXUAL_RATE")%></Excel:td>
			<Excel:td align="right"><%=rec.get("ILLEGAL_NUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("ILLEGAL_RATE")%></Excel:td>
			<Excel:td align="right"><%=rec.get("BAD_HADIT_NUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("BAD_HADIT_RATE")%></Excel:td>
			<Excel:td align="right"><%=rec.get("NOT_FAMILIAR_NUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("NOT_FAMILIAR_RATE")%></Excel:td>
			<Excel:td align="right"><%=rec.get("OTHERS_NUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("OTHERS_RATE")%></Excel:td>
		</Excel:tr>
		<%
			}
		%>
		<Excel:tr>
			<Excel:td colspan="12" align="left">制表人：<%= username%></Excel:td>
			<Excel:td colspan="12" align="right">制表时间：<%= date2%></Excel:td>
		</Excel:tr>
	</Excel:table>
</Excel:tablelist>

