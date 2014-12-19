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
<%@page import="com.inspur.cams.comm.dicm.IDicDao"%>
<%@page import="org.loushang.next.dao.DaoFactory"%>
<head>
<title>导出Excel</title>
<%
	SimpleDateFormat sdf=new SimpleDateFormat("yyyy年MM月dd日HH时mm分");
	SimpleDateFormat sdf2=new SimpleDateFormat("yyyy年MM月dd日");
	String date=sdf.format(new Date());
	String date2=sdf2.format(new Date());
	String name1="假肢和矫形器生产装配企业基本情况统计表";
	String name = name1+"_"+date;
	String username = GetBspInfo.getBspInfo(request).getUserName();
	out.clear();//清空缓存的内容
	out = pageContext.pushBody(); 
%>
</head>
<Excel:tablelist filename="<%=name %>">
	<Excel:table sheetname="<%=name1 %>">
		<Excel:tr>
			<Excel:td colspan="17" align="center" ><Excel:font size="15"  bold="true"><%=name1 %></Excel:font></Excel:td>
		</Excel:tr>
		<Excel:tr>

			<Excel:td colspan="8" align="left">统计单位：<%= BspUtil.getOrganName()%></Excel:td>
			<Excel:td colspan="9" align="right"></Excel:td>
	
		</Excel:tr>
		<Excel:tr height="30" bgcolor="grey" border="1">
		<Excel:td  align="center" width="100" rowspan="2" bordercolor="black"> 地区</Excel:td>
			<Excel:td  align="center" width="100" rowspan="2" bordercolor="black"> 企业总数</Excel:td>
			<Excel:td  align="center" width="100" colspan="6" bordercolor="black">经济性质</Excel:td>
			<Excel:td  align="center" width="100" rowspan="2" bordercolor="black"> 职工总数</Excel:td>
			<Excel:td  align="center" width="100" rowspan="2" bordercolor="black"> 非生产人数</Excel:td>
			<Excel:td  align="center" width="100" rowspan="2" bordercolor="black"> 生产人数</Excel:td>
			<Excel:td  align="center" width="100" rowspan="2" bordercolor="black"> 残疾人数</Excel:td>
			<Excel:td  align="center" width="100" rowspan="2" bordercolor="black"> 残疾人比例%</Excel:td>
			<Excel:td  align="center" width="100" rowspan="2" bordercolor="black"> 假肢制作师职业资格证书人数</Excel:td>
			<Excel:td  align="center" width="100" rowspan="2" bordercolor="black"> 假肢矫形器生产装配特有工种职业资格证书人数</Excel:td>
			<Excel:td  align="center" width="100" rowspan="2" bordercolor="black"> 假肢矫形器生产装配特有工种职业资格证书人数</Excel:td>
			<Excel:td  align="center" width="100" rowspan="2" bordercolor="black"> 注册资金（万元）</Excel:td>
		</Excel:tr>
		<%
			IDicDao dao = (IDicDao) DaoFactory.getDao("com.inspur.cams.comm.dicm.DicDao");
		%>
		<Excel:tr height="30" bgcolor="grey" border="1">
			<Excel:td  align="center" width="100"  bordercolor="black"> <%= dao.getValueByValue("WEAL_DIC_ECONOMICNATURE","NAME","01") %></Excel:td>
			<Excel:td  align="center" width="100"  bordercolor="black"> <%= dao.getValueByValue("WEAL_DIC_ECONOMICNATURE","NAME","02") %></Excel:td>
			<Excel:td  align="center" width="100"  bordercolor="black"><%= dao.getValueByValue("WEAL_DIC_ECONOMICNATURE","NAME","03") %></Excel:td>
			<Excel:td  align="center" width="100"  bordercolor="black"> <%= dao.getValueByValue("WEAL_DIC_ECONOMICNATURE","NAME","04") %></Excel:td>
			<Excel:td  align="center" width="100"  bordercolor="black"> <%= dao.getValueByValue("WEAL_DIC_ECONOMICNATURE","NAME","05") %></Excel:td>
			<Excel:td  align="center" width="100"  bordercolor="black">其他</Excel:td>
		</Excel:tr>
		<%
			DataSet ds = (DataSet)request.getAttribute("dataset");
				for(int i=0; i<ds.getCount(); i++) {
					Record rec = ds.getRecord(i);
		%>
		<Excel:tr border="1">
			<Excel:td align="center" ><%=rec.get("NAME")%></Excel:td>
			<Excel:td align="center" ><%=rec.get("FIT_NUM")==null?"0":rec.get("FIT_NUM")%></Excel:td>
			<Excel:td align="center" ><%=rec.get("ECONOMIC_ONE")==null?"0":rec.get("ECONOMIC_ONE")%></Excel:td>	
			<Excel:td align="center" ><%=rec.get("ECONOMIC_TWO")==null?"0":rec.get("ECONOMIC_TWO")%></Excel:td>	
			<Excel:td align="center" ><%=rec.get("ECONOMIC_THREE")==null?"0":rec.get("ECONOMIC_THREE")%></Excel:td>	
			<Excel:td align="center" ><%=rec.get("ECONOMIC_FOUR")==null?"0":rec.get("ECONOMIC_FOUR")%></Excel:td>	
			<Excel:td align="center" ><%=rec.get("ECONOMIC_FIVE")==null?"0":rec.get("ECONOMIC_FIVE")%></Excel:td>	
			<Excel:td align="center" ><%=rec.get("ECONOMIC_SIX")==null?"0":rec.get("ECONOMIC_SIX")%></Excel:td>	
			<Excel:td align="center" ><%=rec.get("WORKERS_ALL")==null?"0":rec.get("WORKERS_ALL")%></Excel:td>	
			<Excel:td align="center" ><%=rec.get("WORKERS_ALL")==null?"0":rec.get("PRODUCTOR_NUM")%></Excel:td>
			<Excel:td align="center" ><%=rec.get("WORKERS_ALL")==null?"0":rec.get("PRODUCTOR_NOT_NUM")%></Excel:td>
			<Excel:td align="center" ><%=rec.get("WORKERS_DEFORM")==null?"0":rec.get("WORKERS_DEFORM")%></Excel:td>	
			<Excel:td align="center" ><%=rec.get("SCALE_LIMB")==null?"0":rec.get("SCALE_LIMB")%></Excel:td>	
			<Excel:td align="center" ><%=rec.get("WORKERS_ALL")==null?"0":rec.get("CERT_ONE")%></Excel:td>
			<Excel:td align="center" ><%=rec.get("WORKERS_ALL")==null?"0":rec.get("CERT_TWO")%></Excel:td>
			<Excel:td align="center" ><%=rec.get("WORKERS_ALL")==null?"0":rec.get("CERT_THREE")%></Excel:td>
			<Excel:td align="center" ><%=rec.get("REG_FUND")==null?"0":rec.get("REG_FUND")%></Excel:td>	
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

