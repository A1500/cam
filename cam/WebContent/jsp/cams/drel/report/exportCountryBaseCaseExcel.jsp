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
	String assistanceType= request.getParameter("assistanceType");
	String startTime= request.getParameter("startTime");
	String name1="";
	if("01".equals(assistanceType)){
		name1 ="城市低保基本情况统计";
	} else if("02".equals(assistanceType)){
		name1 ="农村低保基本情况统计";
	}
	String name = startTime+name1+"_"+date;
	String username = GetBspInfo.getBspInfo(request).getUserName();
	out.clear();//清空缓存的内容
	out = pageContext.pushBody(); 
%>
</head>
<script type="text/javascript">
function init(){
	
	alert(1);
}
</script>
<Excel:tablelist filename="<%=name %>">
	<Excel:table sheetname="<%=name1 %>">
		<Excel:tr>
			<Excel:td colspan="8" align="center" ><Excel:font size="15"  bold="true"><%=startTime+name1 %></Excel:font></Excel:td>
		</Excel:tr>
		<Excel:tr>

			<Excel:td colspan="4" align="left">统计单位：<%= BspUtil.getOrganName()%></Excel:td>
			<Excel:td colspan="4" align="right">统计时间:<%= startTime%></Excel:td>
	
		</Excel:tr>
		<Excel:tr height="30" bgcolor="grey" border="1">
			<Excel:td  align="center" width="100" rowspan="2" bordercolor="black">单位</Excel:td>
			<Excel:td  align="center" width="100" colspan="2" bordercolor="black">户数（户）</Excel:td>
			<Excel:td  align="center" width="100" colspan="2" bordercolor="black">人数（人）</Excel:td>
			<Excel:td  align="center" width="100" colspan="3" bordercolor="black">保障金（元）</Excel:td>
		</Excel:tr>
		<Excel:tr height="20" bgcolor="grey" border="1">
			<Excel:td  align="center" bordercolor="black" width="100"></Excel:td>
			<Excel:td  align="center" bordercolor="black" width="100">其中分类施保</Excel:td>			
			<Excel:td  align="center" bordercolor="black" width="100" ></Excel:td>
			<Excel:td  align="center" bordercolor="black" width="100">其中分类施保</Excel:td>			
			<Excel:td  align="center" bordercolor="black" width="100" >合计</Excel:td>
			<Excel:td  align="center" bordercolor="black" width="100">户月保障金</Excel:td>			
			<Excel:td  align="center" bordercolor="black" width="100">分类施保金</Excel:td>		
		</Excel:tr>
		
		<%
			DataSet ds = (DataSet)request.getAttribute("dataset");
		
		%>
		<Excel:tr border="1">
			<Excel:td align="center">合计</Excel:td>
			<Excel:td align="right"><%=ds.sum("FAMILY_SUM")==null?"0":ds.sum("FAMILY_SUM")%></Excel:td>			
			<Excel:td align="right"><%=ds.sum("CLASS_FAMILY_SUM")==null?"0":ds.sum("CLASS_FAMILY_SUM")%></Excel:td>
			<Excel:td align="right"><%=ds.sum("ASSISTANCE_PEOPLE_SUM")==null?"0":ds.sum("ASSISTANCE_PEOPLE_SUM")%></Excel:td>
			<Excel:td align="right"><%=ds.sum("CLASS_PEOPLE_SUM")==null?"0":ds.sum("CLASS_PEOPLE_SUM")%></Excel:td>
			<Excel:td align="right"><%=ds.sum("MONEY_SUM")==null?"0":ds.sum("MONEY_SUM")%></Excel:td>
			<Excel:td align="right"><%=ds.sum("ASSISTANCE_MONEY_SUM")==null?"0":ds.sum("ASSISTANCE_MONEY_SUM")%></Excel:td>
			<Excel:td align="right"><%=ds.sum("CLASS_MONEY_SUM")==null?"0":ds.sum("CLASS_MONEY_SUM")%></Excel:td>			
		</Excel:tr>
		
		<%
				for(int i=0; i<ds.getCount(); i++) {
					Record rec = ds.getRecord(i);
		%>
		<Excel:tr border="1">
			<Excel:td align="center"><%=rec.get("NAME")%></Excel:td>
			<Excel:td align="right"><%=rec.get("FAMILY_SUM")==null?"0":rec.get("FAMILY_SUM")%></Excel:td>			
			<Excel:td align="right"><%=rec.get("CLASS_FAMILY_SUM")==null?"0":rec.get("CLASS_FAMILY_SUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("ASSISTANCE_PEOPLE_SUM")==null?"0":rec.get("ASSISTANCE_PEOPLE_SUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("CLASS_PEOPLE_SUM")==null?"0":rec.get("CLASS_PEOPLE_SUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("MONEY_SUM")==null?"0":rec.get("MONEY_SUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("ASSISTANCE_MONEY_SUM")==null?"0":rec.get("ASSISTANCE_MONEY_SUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("CLASS_MONEY_SUM")==null?"0":rec.get("CLASS_MONEY_SUM")%></Excel:td>			
		</Excel:tr>
		<%
			}
		%>
		<Excel:tr>
			<Excel:td colspan="4" align="left">制表人：<%= username%></Excel:td>
			<Excel:td colspan="4" align="right">制表时间：<%= date2%></Excel:td>
		</Excel:tr>
	</Excel:table>
</Excel:tablelist>

