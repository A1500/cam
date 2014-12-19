<%@ page contentType="charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/tags/next-excel" prefix="Excel"%>
<%@page import="org.loushang.next.data.DataSet"%>
<%@page import="org.loushang.next.data.Record"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<%@page import="org.loushang.next.commons.nenum.EnumService" %>
<%@page import="org.loushang.sca.ScaComponentFactory" %>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.*"%>
<head>
<title>导出Excel</title>
<%!
	
	SimpleDateFormat sdf=new SimpleDateFormat("yyyy年MM月dd日HH时mm分");
	SimpleDateFormat sdf2=new SimpleDateFormat("yyyy年MM月dd日");
	String date=sdf.format(new Date());
	String date2=sdf2.format(new Date());
	String name="应急生活救助_"+date;
	
%>

</head>
<Excel:tablelist filename="<%=name %>">
	<Excel:table sheetname="应急生活救助查询列表">
		<Excel:tr>
			<Excel:td colspan="11" align="center" ><Excel:font size="15">应急生活救助查询列表</Excel:font></Excel:td>
		</Excel:tr>
		<Excel:tr>
			<Excel:td colspan="11" align="left">统计单位：<%= BspUtil.getOrganName()%></Excel:td>
		</Excel:tr>
		<Excel:tr height="30" bgcolor="grey" border="1">
			<Excel:td  align="center" width="180" bordercolor="black">户主姓名</Excel:td>
			<Excel:td  align="center" width="100" bordercolor="black">身份证号码</Excel:td>
			<Excel:td  align="center" width="100" bordercolor="black">家庭类型</Excel:td>
			<Excel:td  align="center" width="100" bordercolor="black">行政村（社区）</Excel:td>
			<Excel:td  align="center" width="100" bordercolor="black">核准口粮救助(公斤)</Excel:td>
			<Excel:td  align="center" width="100" bordercolor="black">核准衣被救助(件)</Excel:td>
			<Excel:td  align="center" width="100" bordercolor="black">核准饮水救助(元)</Excel:td>
			<Excel:td  align="center" width="100" bordercolor="black">核准救助金额(元)</Excel:td>
			<Excel:td  align="center" width="100" bordercolor="black">开户银行</Excel:td>
			<Excel:td  align="center" width="100" bordercolor="black">开户银行账号</Excel:td>
			<Excel:td  align="center" width="100" bordercolor="black">填报日期</Excel:td>
			<Excel:td  align="center" width="100" bordercolor="black">提交状态</Excel:td>
			<Excel:td  align="center" width="100" bordercolor="black">备注</Excel:td>
		</Excel:tr>
		<%
			String familyRegister="";
			String familyType="";
			String workflowStatus="";
			DataSet ds = (DataSet)request.getAttribute("dataset");
			EnumService enumService = ScaComponentFactory.getService(EnumService.class, "Enum/EnumService");
			for(int i=0; i<ds.getCount(); i++) {
				Record rec = ds.getRecord(i);
				if(rec.get("familyType")!=null){
					familyType =  enumService.getDescByValue("DIS.FAMILY_TYPE", (String)rec.get("familyType"));
				}
				if(rec.get("workflowStatus")!=null){
					workflowStatus =  enumService.getDescByValue("DIS.RELIEFINFO_WORKFLOW_STATE", (String)rec.get("workflowStatus"));
				}
	
		%>
		<Excel:tr border="1">
			<Excel:td align="center"><%=rec.get("name")%></Excel:td>
			<Excel:td align="right"><%=rec.get("idCard")%></Excel:td>
			<Excel:td align="right"><%=rec.get("acceptAreaName")%></Excel:td>
			<Excel:td align="right"><%=familyType%></Excel:td>
			<Excel:td align="right"><%=rec.get("approvalFood")%></Excel:td>
			<Excel:td align="right"><%=rec.get("approvalClothes")%></Excel:td>
			<Excel:td align="right"><%=rec.get("approvalWater") %></Excel:td>
			<Excel:td align="right"><%=rec.get("approvalMoney")%></Excel:td>
			<Excel:td align="right"><%=rec.get("bank")%></Excel:td>
			<Excel:td align="right"><%=rec.get("accountCode")%></Excel:td>
			<Excel:td align="right"><%=rec.get("acceptDate")%></Excel:td>
			<Excel:td align="right"><%=workflowStatus%></Excel:td>
			<Excel:td align="right"><%=rec.get("note")%></Excel:td>
		</Excel:tr>
		<%
			}
		%>
		<Excel:tr>
			<Excel:td colspan="5" align="left">制表人：<%= BspUtil.getOrganName()%></Excel:td>
			<Excel:td colspan="6" align="right">制表时间：<%= date2%></Excel:td>
		</Excel:tr>
	</Excel:table>
</Excel:tablelist>

