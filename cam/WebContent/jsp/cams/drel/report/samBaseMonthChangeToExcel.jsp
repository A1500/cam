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
	String startTime= request.getParameter("startTime");
	String assistanceType=request.getParameter("assistanceType");
	String titel="";
	if("01".equals(assistanceType)){
		titel ="城市低保变更情况";
	}else if("02".equals(assistanceType)){
		titel ="农村低保变更情况";
	}else{
		titel ="农村五保变更情况";
	}
	String name1=titel+"统计表";
	String name = startTime+name1+"_"+date;
	String username = GetBspInfo.getBspInfo(request).getUserName();
	out.clear();//清空缓存的内容
	out = pageContext.pushBody(); 
%>
</head>
<Excel:tablelist filename="<%=name %>">
	<Excel:table sheetname="<%=name1 %>">
		<Excel:tr>
			<Excel:td colspan="13" align="center" ><Excel:font size="15"  bold="true"><%=startTime+name1 %></Excel:font></Excel:td>
		</Excel:tr>
		<Excel:tr>

			<Excel:td colspan="5" align="left">统计单位：<%= BspUtil.getOrganName()%></Excel:td>
			<Excel:td colspan="8" align="right">统计时间:<%= startTime%></Excel:td>
	
		</Excel:tr>
		<Excel:tr height="30" bgcolor="grey" border="1">
			<Excel:td  align="center" width="130" rowspan="2" bordercolor="black">单位</Excel:td>
			<Excel:td  align="center" width="100" colspan="12" bordercolor="black"><%=titel%></Excel:td>
		</Excel:tr>
		<Excel:tr height="20" bgcolor="grey" border="1">
			<Excel:td  align="center" width="100"   bordercolor="black">新增户数</Excel:td>
			<Excel:td  align="center" width="100"   bordercolor="black">新增保障人数</Excel:td>
			<Excel:td  align="center" width="100"   bordercolor="black">新增保障金的金额</Excel:td>
			<Excel:td  align="center" width="100"   bordercolor="black">停保户数</Excel:td>
			<Excel:td  align="center" width="100"   bordercolor="black">停保保障人数</Excel:td>
			<Excel:td  align="center" width="100"   bordercolor="black">停保保障金的金额</Excel:td>
			<Excel:td  align="center" width="100"   bordercolor="black">保障金增加的户数</Excel:td>
			<Excel:td  align="center" width="100"   bordercolor="black">保障金增加的保障人数</Excel:td>
			<Excel:td  align="center" width="100"   bordercolor="black">保障金增加的金额</Excel:td>
			<Excel:td  align="center" width="100"   bordercolor="black">保障金减少的户数</Excel:td>
			<Excel:td  align="center" width="100"   bordercolor="black">保障金减少的保障人数</Excel:td>
			<Excel:td  align="center" width="100"   bordercolor="black">保障金减少的金额</Excel:td>
		</Excel:tr>
		
		<%
			DataSet ds = (DataSet)request.getAttribute("dataset");
		
		%>
		<Excel:tr border="1">
			<Excel:td align="center">合计</Excel:td>

			<Excel:td align="right"><%=ds.sum("NEW_COUNT")==null?"0":ds.sum("NEW_COUNT")%></Excel:td>	
			<Excel:td align="right"><%=ds.sum("NEW_PEO")==null?"0":ds.sum("NEW_PEO")%></Excel:td>	
			<Excel:td align="right"><%=ds.sum("NEW_MON")==null?"0":ds.sum("NEW_MON")%></Excel:td>			
			<Excel:td align="right"><%=ds.sum("END_COUNT")==null?"0":ds.sum("END_COUNT")%></Excel:td>
			<Excel:td align="right"><%=ds.sum("END_PEO")==null?"0":ds.sum("END_PEO")%></Excel:td>	
			<Excel:td align="right"><%=ds.sum("END_MON")==null?"0":ds.sum("END_MON")%></Excel:td>
			<Excel:td align="right"><%=ds.sum("ADD_COUNT")==null?"0":ds.sum("ADD_COUNT")%></Excel:td>
			<Excel:td align="right"><%=ds.sum("ADD_PEO")==null?"0":ds.sum("ADD_PEO")%></Excel:td>	
			<Excel:td align="right"><%=ds.sum("ADD_MON")==null?"0":ds.sum("ADD_MON")%></Excel:td>
			
			<Excel:td align="right"><%=ds.sum("LOW_COUNT")==null?"0":ds.sum("LOW_COUNT")%></Excel:td>
			<Excel:td align="right"><%=ds.sum("LOW_PEO")==null?"0":ds.sum("LOW_PEO")%></Excel:td>	
			<Excel:td align="right"><%=ds.sum("LOW_MON")==null?"0":ds.sum("LOW_MON")%></Excel:td>
			
		</Excel:tr>
		
		<%
				for(int i=0; i<ds.getCount(); i++) {
					Record rec = ds.getRecord(i);
		%>
		<Excel:tr border="1">
			<Excel:td align="center"><%=rec.get("NAME")%></Excel:td>
			<Excel:td align="right"><%=rec.get("NEW_COUNT")==null?"0":rec.get("NEW_COUNT")%></Excel:td>
			<Excel:td align="right"><%=rec.get("NEW_PEO")==null?"0":rec.get("NEW_PEO")%></Excel:td>
			<Excel:td align="right"><%=rec.get("NEW_MON")==null?"0":rec.get("NEW_MON")%></Excel:td>			
			<Excel:td align="right"><%=rec.get("END_COUNT")==null?"0":rec.get("END_COUNT")%></Excel:td>
			<Excel:td align="right"><%=rec.get("END_PEO")==null?"0":rec.get("END_PEO")%></Excel:td>
			<Excel:td align="right"><%=rec.get("END_MON")==null?"0":rec.get("END_MON")%></Excel:td>
			<Excel:td align="right"><%=rec.get("ADD_COUNT")==null?"0":rec.get("ADD_COUNT")%></Excel:td>
			<Excel:td align="right"><%=rec.get("ADD_PEO")==null?"0":rec.get("ADD_PEO")%></Excel:td>
			<Excel:td align="right"><%=rec.get("ADD_MON")==null?"0":rec.get("ADD_MON")%></Excel:td>
			<Excel:td align="right"><%=rec.get("LOW_COUNT")==null?"0":rec.get("LOW_COUNT")%></Excel:td>
			<Excel:td align="right"><%=rec.get("LOW_PEO")==null?"0":rec.get("LOW_PEO")%></Excel:td>
			<Excel:td align="right"><%=rec.get("LOW_MON")==null?"0":rec.get("LOW_MON")%></Excel:td>
					
		</Excel:tr>
		<%
			}
		%>
		<Excel:tr>
			<Excel:td colspan="5" align="left">制表人：<%= username%></Excel:td>
			<Excel:td colspan="8" align="right">制表时间：<%= date2%></Excel:td>
		</Excel:tr>
	</Excel:table>
</Excel:tablelist>

