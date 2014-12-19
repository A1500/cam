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
	String name="结婚登记统计总表_"+date;
	String username=GetBspInfo.getBspInfo(request).getUserName();
%>
</head>
<Excel:tablelist filename="<%=name %>">
	<Excel:table sheetname="结婚登记统计总表">
		<Excel:tr>
			<Excel:td colspan="32" align="center" ><Excel:font size="15">结婚登记统计总表</Excel:font></Excel:td>
		</Excel:tr>
		<Excel:tr>
			<Excel:td colspan="6" align="left">统计单位：<%= BspUtil.getOrganName()%></Excel:td>
			<Excel:td colspan="26" align="right">统计时间:<%=request.getParameter("statisticsTime")%></Excel:td>
		</Excel:tr>
		<Excel:tr height="30" bgcolor="grey" border="1">
			<Excel:td  align="center" width="100" rowspan="2" bordercolor="black">地区</Excel:td>
			<Excel:td  align="center" width="100" colspan="31" bordercolor="black">按日期分类(对)</Excel:td>
		</Excel:tr>
		<Excel:tr height="20" bgcolor="grey" border="1">
			<Excel:td  align="center" bordercolor="black" >1</Excel:td>			
			<Excel:td  align="center" bordercolor="black" >2</Excel:td>
			<Excel:td  align="center" bordercolor="black" >3</Excel:td>	
			<Excel:td  align="center" bordercolor="black" >4</Excel:td>
			<Excel:td  align="center" bordercolor="black" >5</Excel:td>	
			<Excel:td  align="center" bordercolor="black" >6</Excel:td>
			<Excel:td  align="center" bordercolor="black" >7</Excel:td>	
			<Excel:td  align="center" bordercolor="black" >8</Excel:td>
			<Excel:td  align="center" bordercolor="black" >9</Excel:td>	
			<Excel:td  align="center" bordercolor="black" >10</Excel:td>
			<Excel:td  align="center" bordercolor="black" >11</Excel:td>
			<Excel:td  align="center" bordercolor="black" >12</Excel:td>			
			<Excel:td  align="center" bordercolor="black" >13</Excel:td>
			<Excel:td  align="center" bordercolor="black" >14</Excel:td>	
			<Excel:td  align="center" bordercolor="black" >15</Excel:td>
			<Excel:td  align="center" bordercolor="black" >16</Excel:td>	
			<Excel:td  align="center" bordercolor="black" >17</Excel:td>
			<Excel:td  align="center" bordercolor="black" >18</Excel:td>	
			<Excel:td  align="center" bordercolor="black" >19</Excel:td>
			<Excel:td  align="center" bordercolor="black" >20</Excel:td>	
			<Excel:td  align="center" bordercolor="black" >21</Excel:td>
			<Excel:td  align="center" bordercolor="black" >22</Excel:td>
			<Excel:td  align="center" bordercolor="black" >23</Excel:td>			
			<Excel:td  align="center" bordercolor="black" >24</Excel:td>
			<Excel:td  align="center" bordercolor="black" >25</Excel:td>	
			<Excel:td  align="center" bordercolor="black" >26</Excel:td>
			<Excel:td  align="center" bordercolor="black" >27</Excel:td>	
			<Excel:td  align="center" bordercolor="black" >28</Excel:td>
			<Excel:td  align="center" bordercolor="black" >29</Excel:td>	
			<Excel:td  align="center" bordercolor="black" >30</Excel:td>
			<Excel:td  align="center" bordercolor="black" >31</Excel:td>	
		</Excel:tr>
		<%
			DataSet ds = (DataSet)request.getAttribute("dataset");
				for(int i=0; i<ds.getCount(); i++) {
					Record rec = ds.getRecord(i);
		%>
		<Excel:tr border="1">
			<Excel:td align="center"><%=rec.get("ITEMNAME")%></Excel:td>
			<Excel:td align="rihgt"><%=rec.get("ONE")%></Excel:td>
			<Excel:td align="rihgt"><%=rec.get("TWO")%></Excel:td>			
			<Excel:td align="rihgt"><%=rec.get("THR")%></Excel:td>
			<Excel:td align="rihgt"><%=rec.get("FOUR")%></Excel:td>
			<Excel:td align="rihgt"><%=rec.get("FIVE")%></Excel:td>
			<Excel:td align="rihgt"><%=rec.get("SIX")%></Excel:td>
			<Excel:td align="rihgt"><%=rec.get("SEVEN")%></Excel:td>
			<Excel:td align="rihgt"><%=rec.get("EIGHT")%></Excel:td>
			<Excel:td align="rihgt"><%=rec.get("NINE")%></Excel:td>
			<Excel:td align="rihgt"><%=rec.get("TEN")%></Excel:td>
			<Excel:td align="rihgt"><%=rec.get("ELEVEN")%></Excel:td>
			<Excel:td align="rihgt"><%=rec.get("TWELVE")%></Excel:td>
			<Excel:td align="rihgt"><%=rec.get("THIRTEEN")%></Excel:td>
			<Excel:td align="rihgt"><%=rec.get("FOURTEEN")%></Excel:td>			
			<Excel:td align="rihgt"><%=rec.get("FIFTEEN")%></Excel:td>
			<Excel:td align="rihgt"><%=rec.get("SISTEEN")%></Excel:td>
			<Excel:td align="rihgt"><%=rec.get("SEVENTEEN")%></Excel:td>
			<Excel:td align="rihgt"><%=rec.get("EIGHTEEN")%></Excel:td>
			<Excel:td align="rihgt"><%=rec.get("NINETEEN")%></Excel:td>
			<Excel:td align="rihgt"><%=rec.get("TWENTY")%></Excel:td>
			<Excel:td align="rihgt"><%=rec.get("TWENTYONE")%></Excel:td>
			<Excel:td align="rihgt"><%=rec.get("TWENTYTWO")%></Excel:td>
			<Excel:td align="rihgt"><%=rec.get("TWENTYTHREE")%></Excel:td>
			<Excel:td align="rihgt"><%=rec.get("TWENTYFOUR")%></Excel:td>
			<Excel:td align="rihgt"><%=rec.get("TWENTYFIVE")%></Excel:td>
			<Excel:td align="rihgt"><%=rec.get("TWENTYSIX")%></Excel:td>			
			<Excel:td align="rihgt"><%=rec.get("TWENTYSEVEN")%></Excel:td>
			<Excel:td align="rihgt"><%=rec.get("TWENTYEIGHT")%></Excel:td>
			<Excel:td align="rihgt"><%=rec.get("TWENTYNINE")%></Excel:td>
			<Excel:td align="rihgt"><%=rec.get("THIRTY")%></Excel:td>
			<Excel:td align="rihgt"><%=rec.get("THIRTYONE")%></Excel:td>
		</Excel:tr>
		<%
			}
		%>
		<Excel:tr>
			<Excel:td colspan="6" align="left">制表人：<%= username%></Excel:td>
			<Excel:td colspan="26" align="right">制表时间：<%= date2%></Excel:td>
		</Excel:tr>
	</Excel:table>
</Excel:tablelist>

