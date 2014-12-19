<%@ page contentType="charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/tags/next-excel" prefix="Excel"%>
<%@page import="org.loushang.next.data.DataSet"%>
<%@page import="org.loushang.next.data.Record"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.commons.nenum.EnumService" %>
<%@page import="org.loushang.sca.ScaComponentFactory" %>
<%@page import="com.inspur.cams.comm.dicm.IDicDao" %>
<%@page import="org.loushang.next.dao.DaoFactory" %>
<%@ page import="com.inspur.cams.comm.extuser.util.ExtBspInfo"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.*"%>
<head>
<title>导出Excel</title>
<%
	SimpleDateFormat sdf=new SimpleDateFormat("yyyy年MM月dd日HH时mm分");
	String date=sdf.format(new Date());
	String name="救助方案明细_"+date;
%>
</head>
<%
	String organType = ExtBspInfo.getUserInfo(request).getOrganType();
%>

<Excel:tablelist filename="<%=name %>">
	<Excel:table sheetname="救助方案明细">
		<Excel:tr>
			<Excel:td colspan="7" align="center" ><Excel:font size="15">救助方案明细</Excel:font></Excel:td>
		</Excel:tr>
		<Excel:tr>
			<Excel:td colspan="7">救助方案ID:<%=request.getParameter("planId")%></Excel:td>
		</Excel:tr>
		<Excel:tr height="50" >
			<Excel:td  align="center" width="100">受助人/单位名称</Excel:td>
			<Excel:td  align="center" width="100">受助对象身份证号</Excel:td>	
			<%if(("100".equals(organType))){ %>
			<Excel:td  align="center" width="100">受助对象残疾证号</Excel:td>
			<%} %>		
			<Excel:td  align="center" width="100">救助方向</Excel:td>
			<Excel:td  align="center" width="100">受助类型</Excel:td>
			<Excel:td  align="center" width="100">受助日期</Excel:td>
			<Excel:td  align="center" width="100">救助资金现金金额</Excel:td>
			<Excel:td  align="center" width="100">救助物品名称</Excel:td>
			<Excel:td  align="center" width="100">救助物品数量</Excel:td>
			<Excel:td  align="center" width="100">救助物品折价金额</Excel:td>
			<Excel:td  align="center" width="100">合计金额</Excel:td>
		</Excel:tr>
		<%
			DataSet jzfamxDataset = (DataSet)request.getAttribute("dataset");
		IDicDao dicDao = (IDicDao) DaoFactory.getDao("com.inspur.cams.comm.dicm.DicDao");
			EnumService enumService = ScaComponentFactory.getService(EnumService.class, "Enum/EnumService");
			for(int i=0; i<jzfamxDataset.getCount(); i++) {
				Record rec = jzfamxDataset.getRecord(i);
				String jzfxmc = dicDao.getValueByKey("DIC_ASSITANCE_SIDE", "code", rec.get("assistedSide").toString());
				String szdxlx =  enumService.getDescByValue("SZDXLX.TYPE", rec.get("assistedType").toString());
		%>
		<Excel:tr>
			<Excel:td><%=rec.get("assistedName")%></Excel:td>
			<Excel:td><%=rec.get("idCard")%></Excel:td>		
			<%if(("100".equals(organType))){ %>
			<Excel:td><%=rec.get("handicapNum")%></Excel:td>
			<%} %>				
			<Excel:td><%=jzfxmc%></Excel:td>
			<Excel:td><%=szdxlx%></Excel:td>
			<Excel:td><%=rec.get("assitanceDate")%></Excel:td>
			<Excel:td><%=rec.get("captial")%></Excel:td>
			<Excel:td><%=rec.get("goodsName")%></Excel:td>
			<Excel:td><%=rec.get("goodsNum")%></Excel:td>
			<Excel:td><%=rec.get("goodsNums")%></Excel:td>
			<Excel:td><%=rec.get("totalFund")%></Excel:td>
		</Excel:tr>
		<%
			}
		%>
	</Excel:table>
</Excel:tablelist>

