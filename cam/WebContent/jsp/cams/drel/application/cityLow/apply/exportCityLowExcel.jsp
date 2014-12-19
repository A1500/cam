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
	SimpleDateFormat formatDate = new SimpleDateFormat("yyyy-MM-dd");
	String beginDate= request.getParameter("beginDate");
	beginDate=sdf2.format(formatDate.parse(beginDate));
	String endDate= request.getParameter("endDate");
	endDate=sdf2.format(formatDate.parse(endDate));
	
	String username = GetBspInfo.getBspInfo(request).getUserName();
	
	String countCol =request.getParameter("countCol");//INCOME,AREA
	//System.out.println(countCol);
	String titel="";
	String titel1="";
	int[] limit = {};
	String danwei="元";
	if("INCOME".equals(countCol)){
		 titel ="城市低收入家庭人均可支配收入统计表";
		 titel1="年人均可支配收入段";
		 limit =new int[]{600,800,1000};
		 danwei="元";
	}
	if("AREA".equals(countCol)){
		titel="城市低收入家庭人均居住面积统计表";
		titel1="人均居住面积段";
		limit=new int[]{10,20,50};
		danwei="平方米";
	}
	String datearound=beginDate+"至"+endDate;
	if("".equals(beginDate)&&"".equals(endDate)){
		datearound="全部";
	}else if("".equals(beginDate)&&!"".equals(endDate)){
		datearound=endDate+"之前";
	}else if(!"".equals(beginDate)&&"".equals(endDate)){
		datearound=beginDate+"之后";
	}else if(!"".equals(beginDate)&&!"".equals(endDate)){
		
	}
	String name = datearound+titel+"_"+date;
	
	out.clear();//清空缓存的内容
	out = pageContext.pushBody(); 
%>
</head>
<Excel:tablelist filename="<%=name %>">
	<Excel:table sheetname="<%=titel %>">
		<Excel:tr>
			<Excel:td colspan="<%=(limit.length+1)*2+3 %>" align="center" ><Excel:font size="15"  bold="true"><%=datearound+titel %></Excel:font></Excel:td>
		</Excel:tr>
		<Excel:tr>
			
			<Excel:td colspan="2" align="left">统计单位：<%= BspUtil.getOrganName()%></Excel:td>
			<%
			for(int i=0;i<(limit.length*2);i++){
				%>
				<Excel:td></Excel:td>
				<%
			}
			%>
			<Excel:td colspan="3" align="right">统计时间:<%= datearound%></Excel:td>
			
		</Excel:tr>
		<Excel:tr height="30" bgcolor="grey" border="1">
			<Excel:td  align="center" width="150"  bordercolor="black" rowspan="3">行政区划</Excel:td>
			<Excel:td  align="center" width="100"  bordercolor="black" rowspan="3">户数</Excel:td>
			<Excel:td  align="center" width="100"  bordercolor="black" rowspan="3">人数</Excel:td>			
			<Excel:td  align="center" width="100"  bordercolor="black" colspan="<%=(limit.length+1)*2 %>"><%=titel1 %></Excel:td>
			
		</Excel:tr>
		<Excel:tr>
			<%
			for(int i=0;i<(limit.length);i++){ 
				if(i==0){	%>							
					<Excel:td  align="center" width="100"  bordercolor="black" colspan="2">低于<%=limit[i] %><%=danwei %>（含）</Excel:td>
					<%}if(i>0){%>
					<Excel:td  align="center" width="100"  bordercolor="black" colspan="2"><%=limit[i-1] %><%=danwei %>—<%=limit[i] %><%=danwei %>（含）</Excel:td>
					<%} if(i==(limit.length-1)){	%>
					<Excel:td  align="center" width="100"  bordercolor="black" colspan="2">高于<%=limit[i] %><%=danwei %></Excel:td>							
					<%}
					} %>	
			</Excel:tr>
			<Excel:tr>	
				<%	for(int i=0;i<(limit.length);i++){
					if(i==0){	%>
					<Excel:td  align="center" width="100"  bordercolor="black" >户数</Excel:td>
					<Excel:td  align="center" width="100"  bordercolor="black" >人数</Excel:td>
					<%}if(i>0){%>
					<Excel:td  align="center" width="100"  bordercolor="black">户数</Excel:td>
					<Excel:td  align="center" width="100"  bordercolor="black">人数</Excel:td>
					<%} if(i==(limit.length-1)){	%>
					<Excel:td  align="center" width="100"  bordercolor="black">户数</Excel:td>
					<Excel:td  align="center" width="100"  bordercolor="black" >人数</Excel:td>
				<%}
			} %>	
																				
			</Excel:tr>
		<%
			DataSet ds = (DataSet)request.getAttribute("dataset");
		
		%>
				
		<%
				for(int i=0; i<ds.getCount(); i++) {
					Record rec = ds.getRecord(i);
		%>			
		<Excel:tr border="1">
			<Excel:td align="center"><%=rec.get("NAME")%></Excel:td>
			<Excel:td align="right"><%=rec.get("TOTALF")%></Excel:td>
			<Excel:td align="right"><%=rec.get("TOTALH")%></Excel:td>
			<%	for(int j=0;j<(limit.length);j++){ %>
				<% if(j==0){	%>
					<Excel:td align="right" ><%=rec.get("F"+(j+1)+"")%></Excel:td>
					<Excel:td align="right" ><%=rec.get("H"+(j+1)+"")%></Excel:td>
					<%}if(j>0){%>
					<Excel:td align="right" ><%=rec.get("F"+(j+1)+"")%></Excel:td>
					<Excel:td align="right" ><%=rec.get("H"+(j+1)+"")%></Excel:td>
					<%} if(j==(limit.length-1)){	%>
					<Excel:td align="right" ><%=rec.get("F"+(j+2)+"")%></Excel:td>
					<Excel:td align="right" ><%=rec.get("H"+(j+2)+"")%></Excel:td>
					<%}
				} %>		
		</Excel:tr>
		<%
			}
		%>
		<Excel:tr>
			
			<Excel:td colspan="2" align="left">制表人：<%= username%></Excel:td>
		<%
			for(int i=0;i<(limit.length*2+1);i++){
				%>
				<Excel:td></Excel:td>
				<%
			}
			%>
			<Excel:td colspan="2" align="right">制表时间：<%= date2%></Excel:td>
			
		</Excel:tr>
	</Excel:table>
</Excel:tablelist>

