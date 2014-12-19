<%@ page contentType="charset=UTF-8"%>
<%@ taglib uri="/tags/next-excel" prefix="Excel"%>
<%@page import="org.loushang.next.data.DataSet"%>
<%@page import="org.loushang.next.data.Record"%>
<%@page import="com.inspur.cams.comm.util.EnumUtil"%>
<%@page import="java.text.SimpleDateFormat"%>
<Excel:tablelist filename="查询报表">
	<Excel:table>
	<%--标题栏 --%>
		<Excel:tr>
			<Excel:td colspan="11" align="center">查询报表</Excel:td>
		</Excel:tr>
		<%
			SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
		%>
	<%--时间栏 --%>
		<Excel:tr>
			<Excel:td colspan="11" align="left">日期：<%=sdf.format(new java.util.Date())%></Excel:td>
		</Excel:tr>
	<%--列标题 --%>
		<Excel:tr bgcolor="grey">
			<Excel:td  align="center" width="100">社会组织种类</Excel:td>
			<Excel:td  align="center" width="150">社会组织名称</Excel:td>
			<Excel:td  align="center" width="100">登记证号</Excel:td>
			<Excel:td  align="center" width="100">社会组织状态</Excel:td>
			<Excel:td  align="center" width="100">所属行(事)业</Excel:td>
			<Excel:td  align="center" width="100">业务主管单位</Excel:td>
			<Excel:td  align="center" width="200">住所</Excel:td>
			<Excel:td  align="center" width="100">活动范围</Excel:td>
			<Excel:td  align="center" width="100">法定代表人姓名</Excel:td>
			<Excel:td  align="center" width="150">登记管理机关名称</Excel:td>
			<Excel:td  align="center" width="100">社会组织电话</Excel:td>
		</Excel:tr>
	<%--数据区 --%>
		<%
			DataSet dataset=(DataSet)request.getAttribute("dataset");
			for(int i=0;i<dataset.getCount();i++){
				Record record=dataset.getRecord(i);
				//社会组织种类
				String sorgType=(String)record.get("sorgType");
				if(sorgType==null){
					sorgType="";
				}
				if(sorgType.equals("S")){
					sorgType="社会团体";
				}else if(sorgType.equals("J")){
					sorgType="基金会";
				}else if(sorgType.equals("M")){
					sorgType="民非";
				}
				//社会组织状态
				String sorgStatus=(String)record.get("sorgStatus");
				if(sorgStatus==null){
					sorgStatus="";
				}else{
					sorgStatus=EnumUtil.findTextFromEnum("DIC_SORG_STATUS","CODE","NAME",sorgStatus);
				}


				String busScope=(String)record.get("busScope");
				if(busScope==null){
					busScope="";
				}else{
					busScope=EnumUtil.findTextFromEnum("DIC_BUS_SCOPE","CODE","NAME",busScope);
				}

				String borgName=(String)record.get("borgName");
				borgName=EnumUtil.findTextFromEnum("SOM_BUSINESS_ORGAN","BORG_CODE","BORG_NAME",borgName);
		%>
		<Excel:tr>
			<Excel:td  align="center"><%=sorgType%></Excel:td>
			<Excel:td  align="center"><%=record.get("cnName")%></Excel:td>
			<Excel:td  align="center"><%=record.get("sorgCode")%></Excel:td>
			<Excel:td  align="center"><%=sorgStatus%></Excel:td>
			<Excel:td  align="center"><%=busScope%></Excel:td>
			<Excel:td  align="center"><%=borgName%></Excel:td>
			<Excel:td  align="center"><%=record.get("residence")%></Excel:td>
			<Excel:td  align="center"><%=record.get("actArea")%></Excel:td>
			<Excel:td  align="center"><%=record.get("legalPeople")%></Excel:td>
			<Excel:td  align="center"><%=record.get("morgName")%></Excel:td>
			<Excel:td  align="center"><%=record.get("sorgPhone")%></Excel:td>
		</Excel:tr>
		<%
			}
		%>
	</Excel:table>
</Excel:tablelist>