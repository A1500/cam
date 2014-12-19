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
<Excel:tablelist filename="优待金发放人员信息" >
	<Excel:table>
		<Excel:tr>
			<Excel:td colspan="9" align="center"><Excel:font size="12">优待金发放人员信息</Excel:font></Excel:td>
		</Excel:tr>
		<Excel:tr >
			<Excel:td colspan="9" align="center"><Excel:font size="13"><%=date%></Excel:font></Excel:td>
		</Excel:tr>
		<Excel:tr bgcolor="grey"  border="1">
			<Excel:td  align="center" width="120" rowspan="2"><Excel:font size="13">所属行政区划</Excel:font></Excel:td>
			<Excel:td  align="center" width="120" rowspan="2"><Excel:font size="13">姓名</Excel:font></Excel:td>
			<Excel:td  align="center" width="120" rowspan="2"><Excel:font size="13">性别</Excel:font></Excel:td>
			<Excel:td  align="center" width="120" rowspan="2"><Excel:font size="13">民族</Excel:font></Excel:td>
			
			<Excel:td  align="center" width="200" rowspan="2"><Excel:font size="13">身份证号</Excel:font></Excel:td>
			<Excel:td  align="center" width="120" rowspan="2"><Excel:font size="13">出生日期</Excel:font></Excel:td>
			<Excel:td  align="center" width="120" rowspan="2"><Excel:font size="13">户籍类别</Excel:font></Excel:td>
			<Excel:td  align="center" width="200" rowspan="2"><Excel:font size="13">户口地址</Excel:font></Excel:td>
			<Excel:td  align="center" width="120" rowspan="2"><Excel:font size="13">工作单位</Excel:font></Excel:td>
			<Excel:td  align="center" width="120" rowspan="2"><Excel:font size="13">证书编号</Excel:font></Excel:td>
			
			<Excel:td align="center" width="120" rowspan="2"><Excel:font size="13">优抚对象类别</Excel:font></Excel:td>
			<Excel:td  align="center" width="200" rowspan="2"><Excel:font size="13">抚恤金额</Excel:font></Excel:td>
		</Excel:tr>
		<Excel:tr ></Excel:tr>
		<%
		DataSet dataset=(DataSet)request.getAttribute("dataset");
			for(int i=0;i<dataset.getCount();i++){
				Record record=dataset.getRecord(i);
		%>
		<Excel:tr border="1">
			<Excel:td  align="center" width="120"><%=record.get("FULL_NAME")==null?"":record.get("FULL_NAME")%></Excel:td>	
            <Excel:td  align="center" width="120"><%=record.get("NAME")==null?"":record.get("NAME")%></Excel:td>
            <Excel:td align="center" width="120"><%=EnumUtil.findTextFromEnum(String.valueOf(record.get("SEX")),"COMM.SEX")%></Excel:td>
            <Excel:td align="center" width="120"><%=EnumUtil.findTextFromEnum("DIC_NATION","CODE","NAME",String.valueOf(record.get("NATION")))%></Excel:td>
            
            
            <Excel:td  align="center" width="200"><%=record.get("ID_CARD")==null?"":record.get("ID_CARD")%></Excel:td>
            <Excel:td  align="center" width="120"><%=record.get("BIRTHDAY")==null?"":record.get("BIRTHDAY")%></Excel:td>
            <Excel:td align="center" width="120"><%=EnumUtil.findTextFromEnum(String.valueOf(record.get("DOMICILE_TYPE")),"DOMICILE.TYPE")%></Excel:td>
            <Excel:td  align="center" width="120"><%=record.get("ADDRESS")==null?"":record.get("ADDRESS")%></Excel:td>
            <Excel:td  align="center" width="120"><%=record.get("WORK_UNIT_NAME")==null?"":record.get("WORK_UNIT_NAME")%></Excel:td>
            <Excel:td  align="center" width="120"><%=record.get("BPT_NO")==null?"":record.get("BPT_NO")%></Excel:td>
            
            <Excel:td align="center" width="120"><%=EnumUtil.findTextFromEnum(String.valueOf(record.get("OBJECT_TYPE_CODE")),"OBJECT.TYPE.PART")%></Excel:td>
            <Excel:td  align="center" width="120"><%=record.get("MON_SUM")==null?"":record.get("MON_SUM")%></Excel:td>

		</Excel:tr>
		<%
			}
		%>
	</Excel:table>
</Excel:tablelist>