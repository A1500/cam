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
	String name="婚姻颁证员统计分析_"+date;
	String username=GetBspInfo.getBspInfo(request).getUserName();
%>
</head>
<Excel:tablelist filename="<%=name %>">
	<Excel:table sheetname="婚姻颁证员统计分析">
		<Excel:tr>
			<Excel:td colspan="32" align="center" ><Excel:font size="15">婚姻颁证员统计分析</Excel:font></Excel:td>
		</Excel:tr>
		<Excel:tr>
			<Excel:td colspan="32" align="left">统计单位：<%= BspUtil.getOrganName()%></Excel:td>
		</Excel:tr>
		<Excel:tr height="30" bgcolor="grey" border="1">
			<Excel:td  align="center" width="100" rowspan="2" bordercolor="black">单位</Excel:td>
			<Excel:td  align="center" width="100" rowspan="2" bordercolor="black">总数(人)</Excel:td>			
			<Excel:td  align="center" width="100" colspan="3" bordercolor="black">性质</Excel:td>
			<Excel:td  align="center" width="100" colspan="2" bordercolor="black">性别</Excel:td>
			<Excel:td  align="center" width="100" colspan="2" bordercolor="black">民族</Excel:td>
			<Excel:td  align="center" width="100" colspan="2" bordercolor="black">年龄</Excel:td>
			<Excel:td  align="center" width="100" colspan="2" bordercolor="black">政治面貌</Excel:td>
			<Excel:td  align="center" width="100" colspan="2" bordercolor="black">学历</Excel:td>
			<Excel:td  align="center" width="100" colspan="4" bordercolor="black">从事工作时间</Excel:td>
			<Excel:td  align="center" width="100" colspan="5" bordercolor="black">首次考试</Excel:td>
			<Excel:td  align="center" width="100" colspan="7" bordercolor="black">复考情况</Excel:td>
			<Excel:td  align="center" width="100" rowspan="2" bordercolor="black">离岗人数</Excel:td>
		</Excel:tr>
		<Excel:tr height="20" bgcolor="grey" border="1">
			<Excel:td  align="center" bordercolor="black" >行政</Excel:td>
			<Excel:td  align="center" bordercolor="black" >参公管理</Excel:td>
			<Excel:td  align="center" bordercolor="black" >全额拨款</Excel:td>
			<Excel:td  align="center" bordercolor="black" >男</Excel:td>
			<Excel:td  align="center" bordercolor="black" >女</Excel:td>
			<Excel:td  align="center" bordercolor="black" >汉</Excel:td>
			<Excel:td  align="center" bordercolor="black" >少</Excel:td>
			<Excel:td  align="center" bordercolor="black" >平均</Excel:td>
			<Excel:td  align="center" bordercolor="black" >35岁以下</Excel:td>
			<Excel:td  align="center" bordercolor="black" >党</Excel:td>
			<Excel:td  align="center" bordercolor="black" >团</Excel:td>
			<Excel:td  align="center" bordercolor="black" >全日本科以上</Excel:td>
			<Excel:td  align="center" bordercolor="black" >大专</Excel:td>
			<Excel:td  align="center" bordercolor="black" >5年以下</Excel:td>
			<Excel:td  align="center" bordercolor="black" >6-10年</Excel:td>	
			<Excel:td  align="center" bordercolor="black" >11-20年</Excel:td>	
			<Excel:td  align="center" bordercolor="black" >21年以上</Excel:td>	
			<Excel:td  align="center" bordercolor="black" >总数</Excel:td>	
			<Excel:td  align="center" bordercolor="black" >合格人数</Excel:td>
			<Excel:td  align="center" bordercolor="black" >补考人数</Excel:td>	
			<Excel:td  align="center" bordercolor="black" >补考合格</Excel:td>	
			<Excel:td  align="center" bordercolor="black" >补考不合格</Excel:td>	
			<Excel:td  align="center" bordercolor="black" >应考人数</Excel:td>	
			<Excel:td  align="center" bordercolor="black" >实考人数</Excel:td>
			<Excel:td  align="center" bordercolor="black" >合格</Excel:td>	
			<Excel:td  align="center" bordercolor="black" >补考</Excel:td>	
			<Excel:td  align="center" bordercolor="black" >补考合格</Excel:td>	
			<Excel:td  align="center" bordercolor="black" >撤销资格证</Excel:td>	
			<Excel:td  align="center" bordercolor="black" >资格证自动失效</Excel:td>	
				
		</Excel:tr>
		<%
			DataSet ds = (DataSet)request.getAttribute("dataset");
				for(int i=0; i<ds.getCount(); i++) {
					Record rec = ds.getRecord(i);
		%>
		<Excel:tr border="1">
			<Excel:td><%=rec.get("ITEM_NAME")%></Excel:td>
			<Excel:td><%=rec.get("TOTAL_NUM")%></Excel:td>
			<Excel:td><%=rec.get("XZDW_NUM")%></Excel:td>			
			<Excel:td><%=rec.get("CGGLSYDW_NUM")%></Excel:td>
			<Excel:td><%=rec.get("QEBKSYDW_NUM")%></Excel:td>
			<Excel:td><%=rec.get("MAN_NUM")%></Excel:td>
			<Excel:td><%=rec.get("WOMAN_NUM")%></Excel:td>			
			<Excel:td><%=rec.get("HANZU_NUM")%></Excel:td>
			<Excel:td><%=rec.get("SHAO_NUM")%></Excel:td>
			<Excel:td><%=rec.get("AGE_AVG")%></Excel:td>
			<Excel:td><%=rec.get("AGE35_NUM")%></Excel:td>			
			<Excel:td><%=rec.get("PARTY_NUM")%></Excel:td>
			<Excel:td><%=rec.get("LEAGUE_NUM")%></Excel:td>
			<Excel:td><%=rec.get("UNDERGRADUATES_NUM")%></Excel:td>
			<Excel:td><%=rec.get("JUNIOR_NUM")%></Excel:td>			
			<Excel:td><%=rec.get("YEAR5_NUM")%></Excel:td>
			<Excel:td><%=rec.get("YEAR6_10_NUM")%></Excel:td>
			<Excel:td><%=rec.get("YEAR11_20_NUM")%></Excel:td>
			<Excel:td><%=rec.get("YEAR21_NUM")%></Excel:td>			
			<Excel:td><%=rec.get("FIRST_TOTAL_NUM")%></Excel:td>
			<Excel:td><%=rec.get("FIRST_HG_NUM")%></Excel:td>
			<Excel:td><%=rec.get("FIRST_BK_NUM")%></Excel:td>
			<Excel:td><%=rec.get("FIRST_BKHG_NUM")%></Excel:td>			
			<Excel:td><%=rec.get("FIRST_BKBHG_NUM")%></Excel:td>
			<Excel:td><%=rec.get("LAST_YK_NUM")%></Excel:td>
			<Excel:td><%=rec.get("LAST_SK_NUM")%></Excel:td>
			<Excel:td><%=rec.get("LAST_HG_NUM")%></Excel:td>			
			<Excel:td><%=rec.get("LAST_BK_NUM")%></Excel:td>
			<Excel:td><%=rec.get("LAST_BKHG_NUM")%></Excel:td>
			<Excel:td><%=rec.get("LAST_CXZGZ_NUM")%></Excel:td>
			<Excel:td><%=rec.get("LAST_ZGZZDSX_NUM")%></Excel:td>			
			<Excel:td><%=rec.get("DEPARTURE_NUM")%></Excel:td>
		</Excel:tr>
		<%
			}
		%>
		<Excel:tr>
			<Excel:td colspan="16" align="left">制表人：<%= username%></Excel:td>
			<Excel:td colspan="16" align="right">制表时间：<%= date2%></Excel:td>
		</Excel:tr>
	</Excel:table>
</Excel:tablelist>

