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
<%@page import="com.inspur.cams.comm.dicm.IDicDao"%>
<%@page import="org.loushang.next.dao.DaoFactory"%>
<head>
<title>导出Excel</title>
<%!
	
	SimpleDateFormat sdf=new SimpleDateFormat("yyyy年MM月dd日HH时mm分");
	SimpleDateFormat sdf2=new SimpleDateFormat("yyyy年MM月dd日");
	String date=sdf.format(new Date());
	String date2=sdf2.format(new Date());
	String name="代办理去世优抚对象信息_"+date;
	
%>

</head>
<Excel:tablelist filename="<%=name %>">
	<Excel:table sheetname="代办理去世优抚对象信息">
		<Excel:tr>
			<Excel:td colspan="10" align="center" ><Excel:font size="15">代办理去世优抚对象信息列表</Excel:font></Excel:td>
		</Excel:tr>
		<Excel:tr>
			<Excel:td colspan="5" align="left">统计单位：<%= BspUtil.getOrganName()%></Excel:td>
		</Excel:tr>
		<Excel:tr height="30" bgcolor="grey" border="1">
			<Excel:td  align="center" width="180" bordercolor="black">所属行政区划</Excel:td>
			<Excel:td  align="center" width="100" bordercolor="black">姓名</Excel:td>
			<Excel:td  align="center" width="100" bordercolor="black">身份证件号码</Excel:td>
			<Excel:td  align="center" width="100" bordercolor="black">性别</Excel:td>
			<Excel:td  align="center" width="100" bordercolor="black">民族</Excel:td>
			<Excel:td  align="center" width="100" bordercolor="black">优抚对象状态</Excel:td>
			<Excel:td  align="center" width="100" bordercolor="black">优抚对象类别</Excel:td>
			<Excel:td  align="center" width="100" bordercolor="black">去世日期</Excel:td>
			<Excel:td  align="center" width="100" bordercolor="black">火化时间</Excel:td>
			<Excel:td  align="center" width="100" bordercolor="black">殡仪馆</Excel:td>
		</Excel:tr>
		<%
			String sex="";
			String object_status="";
			String object_type="";
			DataSet ds = (DataSet)request.getAttribute("dataset");
			IDicDao dao = (IDicDao) DaoFactory.getDao("com.inspur.cams.comm.dicm.DicDao");
			EnumService enumService = ScaComponentFactory.getService(EnumService.class, "Enum/EnumService");
			for(int i=0; i<ds.getCount(); i++) {
				Record rec = ds.getRecord(i);
				if(rec.get("SEX")!=null){
					sex =  enumService.getDescByValue("COMM.SEX", (String)rec.get("SEX"));
				}
				if(rec.get("NATION")!=null){
					rec.set("NATION",dao.getValueByValue("DIC_NATION","NAME",(String)rec.get("NATION")));
				}
				if(rec.get("OBJECT_STATE")!=null){
					object_status =  enumService.getDescByValue("OBJECT.STATE", (String)rec.get("OBJECT_STATE"));
				}
				if(rec.get("OBJECT_TYPE")!=null){
					object_type =  enumService.getDescByValue("OBJECT.TYPE.PART", (String)rec.get("OBJECT_TYPE"));
				}
	
		%>
		<Excel:tr border="1">
			<Excel:td align="center"><%=rec.get("FULL_NAME")%></Excel:td>
			<Excel:td align="right"><%=rec.get("NAME")%></Excel:td>
			<Excel:td align="right"><%=rec.get("ID_CARD")%></Excel:td>
			<Excel:td align="right"><%=sex%></Excel:td>
			<Excel:td align="right"><%=rec.get("NATION")%></Excel:td>
			<Excel:td align="right"><%=object_status%></Excel:td>
			<Excel:td align="right"><%=object_type%></Excel:td>
			<Excel:td align="right"><%=rec.get("DEATH_DATE")%></Excel:td>
			<Excel:td align="right"><%=rec.get("CREMATION_TIME")%></Excel:td>
			<Excel:td align="right"><%=rec.get("FUNERAL_NAME")%></Excel:td>
		</Excel:tr>
		<%
			}
		%>
		<Excel:tr>
			<Excel:td colspan="5" align="left">制表人：<%= BspUtil.getOrganName()%></Excel:td>
			<Excel:td colspan="5" align="right">制表时间：<%= date2%></Excel:td>
		</Excel:tr>
	</Excel:table>
</Excel:tablelist>

