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
<Excel:tablelist filename="伤残人员信息" >
	<Excel:table>
		<Excel:tr>
			<Excel:td colspan="9" align="center"><Excel:font size="12">伤残人员信息</Excel:font></Excel:td>
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
			<Excel:td  align="center" width="120" rowspan="2"><Excel:font size="13">伤残类别</Excel:font></Excel:td>
			<Excel:td align="center" width="120" rowspan="2"><Excel:font size="13">伤残等级</Excel:font></Excel:td>
			<Excel:td align="center" width="120" rowspan="2"><Excel:font size="13">伤残性质</Excel:font></Excel:td>
			<Excel:td align="center" width="120" rowspan="2"><Excel:font size="13">伤残属别</Excel:font></Excel:td>
			<Excel:td align="center" width="200" rowspan="2"><Excel:font size="13">伤残时期</Excel:font></Excel:td>
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
            <Excel:td  align="center" width="120"><%=record.get("DISABILITYNO")==null?"":record.get("DISABILITYNO")%></Excel:td>
             <Excel:td align="center" width="120"><%=EnumUtil.findTextFromEnum(String.valueOf(record.get("DISABILITYTYPE")),"DISABILITY.TYPE.CODE")%></Excel:td>
              <Excel:td align="center" width="120"><%=EnumUtil.findTextFromEnum(String.valueOf(record.get("DISABILITYLEVEL")),"LEVEL.CODE")%></Excel:td>
              <Excel:td align="center" width="120"><%=EnumUtil.findTextFromEnum(String.valueOf(record.get("DISABILITYCASE")),"CASE.CODE")%></Excel:td>
              <Excel:td align="center" width="120"><%=EnumUtil.findTextFromEnum(String.valueOf(record.get("DISABILITYGENUS")),"GENUS.CODE")%></Excel:td>
              <Excel:td align="center" width="120"><%=EnumUtil.findTextFromEnum(String.valueOf(record.get("DISABILITYDATE")),"WAR.CODE")%></Excel:td>
            <Excel:td  align="center" width="120"><%=record.get("MOUN")==null?"":record.get("MOUN")%></Excel:td>
            <Excel:td  align="center" width="200"><%=record.get("NOTE")==null?"":record.get("NOTE")%></Excel:td>

		</Excel:tr>
		<%
			}
		%>
	</Excel:table>
</Excel:tablelist>