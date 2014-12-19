<%@ page contentType="charset=UTF-8"%>
<%@ taglib uri="/tags/next-excel" prefix="Excel"%>
<%@page import="org.loushang.next.data.DataSet"%>
<%@page import="org.loushang.next.data.Record"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.inspur.cams.comm.util.EnumUtil"%>
<%
	SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
	String date = sdf.format(new java.util.Date());
	
%>
<Excel:tablelist filename="参战参试人员信息" >
	<Excel:table>
		<Excel:tr>
			<Excel:td colspan="9" align="center"><Excel:font size="12">参战参试人员信息</Excel:font></Excel:td>
		</Excel:tr>
		<Excel:tr >
			<Excel:td colspan="9" align="center"><Excel:font size="13"><%=date%></Excel:font></Excel:td>
		</Excel:tr>
		<Excel:tr bgcolor="grey"  border="1">
			<Excel:td  align="center" width="120" rowspan="2"><Excel:font size="13">姓名</Excel:font></Excel:td>
			<Excel:td  align="center" width="120" rowspan="2"><Excel:font size="13">性别</Excel:font></Excel:td>
			<Excel:td  align="center" width="200" rowspan="2"><Excel:font size="13">身份证号</Excel:font></Excel:td>
			<Excel:td  align="center" width="120" rowspan="2"><Excel:font size="13">出生日期</Excel:font></Excel:td>
			<Excel:td  align="center" width="120" rowspan="2"><Excel:font size="13">户籍类别</Excel:font></Excel:td>
			<Excel:td  align="center" width="200" rowspan="2"><Excel:font size="13">户口地址</Excel:font></Excel:td>
			<Excel:td  align="center" width="120" rowspan="2"><Excel:font size="13">工作单位</Excel:font></Excel:td>
			<Excel:td  align="center" width="120" rowspan="2"><Excel:font size="13">证书编号</Excel:font></Excel:td>
			<Excel:td align="center" width="120" rowspan="2"><Excel:font size="13">参保类型</Excel:font></Excel:td>
			<Excel:td align="center" width="120" rowspan="2"><Excel:font size="13">医疗保险证号</Excel:font></Excel:td>
			<Excel:td align="center" width="120" rowspan="2"><Excel:font size="13">类别</Excel:font></Excel:td>
			<Excel:td align="center" width="120" rowspan="2"><Excel:font size="13">参战类别</Excel:font></Excel:td>
			<Excel:td align="center" width="120" rowspan="2"><Excel:font size="13">参试类别</Excel:font></Excel:td>
			<Excel:td  align="center" width="200" rowspan="2"><Excel:font size="13">抚恤金额</Excel:font></Excel:td>
			<Excel:td  align="center" width="200" rowspan="2"><Excel:font size="13">备注</Excel:font></Excel:td>
		</Excel:tr>
		<Excel:tr ></Excel:tr>
		<%
		DataSet dataset=(DataSet)request.getAttribute("dataset");
			for(int i=0;i<dataset.getCount();i++){
				Record record=dataset.getRecord(i);
				
		%>
		<Excel:tr border="1">
            <Excel:td  align="center" width="120"><%=record.get("NAME")==null?"":record.get("NAME")%></Excel:td>
            <Excel:td align="center" width="120"><%=EnumUtil.findTextFromEnum(String.valueOf(record.get("SEX")),"COMM.SEX")%></Excel:td>
            <Excel:td  align="center" width="200"><%=record.get("IDCARD")==null?"":record.get("IDCARD")%></Excel:td>
            <Excel:td  align="center" width="120"><%=record.get("BIRTHDAY")==null?"":record.get("BIRTHDAY")%></Excel:td>
            <Excel:td align="center" width="120"><%=EnumUtil.findTextFromEnum(String.valueOf(record.get("DOMICILETYPE")),"DOMICILE.TYPE")%></Excel:td>
            <Excel:td  align="center" width="120"><%=record.get("ADDRESS")==null?"":record.get("ADDRESS")%></Excel:td>
            <Excel:td  align="center" width="120"><%=record.get("WORKUNIT")==null?"":record.get("WORKUNIT")%></Excel:td>
            <Excel:td  align="center" width="120"><%=record.get("DEMOBILIZEDNO")==null?"":record.get("DEMOBILIZEDNO")%></Excel:td>
            <Excel:td align="center" width="120"><%=EnumUtil.findTextFromEnum(String.valueOf(record.get("SAFEGUARD")),"COMM.MEDICAL_STATUS")%></Excel:td>
            <Excel:td  align="center" width="120"><%=record.get("MEDICAL")==null?"":record.get("MEDICAL")%></Excel:td>
            <Excel:td align="center" width="120"><%=EnumUtil.findTextFromEnum(String.valueOf(record.get("WARTYPE")),"OBJECT.TYPE.PART")%></Excel:td>
              <Excel:td align="center" width="120"><%=EnumUtil.findTextFromEnum(String.valueOf(record.get("WARCODE")),"WARTYPE.CODE")%></Excel:td>
              <Excel:td align="center" width="120"><%=EnumUtil.findTextFromEnum(String.valueOf(record.get("TESTCODE")),"TESTED.TYPE")%></Excel:td>
            <Excel:td  align="center" width="120"><%=record.get("MOUN")==null?"":record.get("MOUN")%></Excel:td>
            <Excel:td  align="center" width="200"><%=record.get("NOTE")==null?"":record.get("NOTE")%></Excel:td>

		</Excel:tr>
		<%
			}
		%>
	</Excel:table>
</Excel:tablelist>