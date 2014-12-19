<%@ page contentType="charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/tags/next-excel" prefix="Excel"%>
<%@page import="org.loushang.next.data.DataSet"%>
<%@page import="org.loushang.next.data.Record"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<%@ page import="org.loushang.bsp.security.context.GetBspInfo"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="org.loushang.next.commons.nenum.EnumService" %>
<%@page import="org.loushang.sca.ScaComponentFactory" %>
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
	String userName= request.getParameter("userName");
	out.clear();//清空缓存的内容
	out = pageContext.pushBody(); 
%>
</head>
<Excel:tablelist filename="<%=userName %>">
	<Excel:table sheetname="基层民政人员信息">
		<Excel:tr>
			<Excel:td colspan="10" align="center" ><Excel:font size="15"  bold="true"><%=userName+"基层民政人员信息"%></Excel:font></Excel:td>
		</Excel:tr>
		<Excel:tr height="30" bgcolor="grey" border="1">
			<Excel:td  align="center" width="200"  bordercolor="black">姓名</Excel:td>
			<Excel:td  align="center" width="200"  bordercolor="black">性别</Excel:td>
			<Excel:td  align="center" width="200"  bordercolor="black">身份证号</Excel:td>
			<Excel:td  align="center" width="200"  bordercolor="black">民族</Excel:td>
			<Excel:td  align="center" width="200"  bordercolor="black">出生年月</Excel:td>
			<Excel:td  align="center" width="200"  bordercolor="black">参加工作时间</Excel:td>
			<Excel:td  align="center" width="200"  bordercolor="black">政治面貌</Excel:td>
			<Excel:td  align="center" width="200"  bordercolor="black">学历</Excel:td>
			<Excel:td  align="center" width="200"  bordercolor="black">毕业学校</Excel:td>
			<Excel:td  align="center" width="300"  bordercolor="black">家庭住址</Excel:td>			
		</Excel:tr>
		
		<%
			String peopleSex="";
			DataSet ds = (DataSet)request.getAttribute("dataset");
			IDicDao dao = (IDicDao) DaoFactory.getDao("com.inspur.cams.comm.dicm.DicDao");
			EnumService enumService = ScaComponentFactory.getService(EnumService.class, "Enum/EnumService");
			for(int i=0; i<ds.getCount(); i++) {
				Record rec = ds.getRecord(i);
				if(rec.get("peopleSex")!=null){
					peopleSex =  enumService.getDescByValue("COMM.SEX", (String)rec.get("peopleSex"));
				}
				if(rec.get("peopleNation")!=null){
					rec.set("peopleNation",dao.getValueByValue("DIC_NATION","NAME",(String)rec.get("peopleNation")));
				}
				if(rec.get("peoplePolitics")!=null){
					rec.set("peoplePolitics",dao.getValueByValue("DIC_POLITICAL","NAME",(String)rec.get("peoplePolitics")));
				}
				if(rec.get("peopleEdu")!=null){
					rec.set("peopleEdu",dao.getValueByValue("dic_education","NAME",(String)rec.get("peopleEdu")));
				}
		%>
		<Excel:tr border="1">
			<Excel:td align="right"><%=rec.get("peopleName")%></Excel:td>			
			<Excel:td align="right"><%=peopleSex %></Excel:td>
			<Excel:td align="right"><%=rec.get("peopleCard")%></Excel:td>			
			<Excel:td align="right"><%=rec.get("peopleNation")%></Excel:td>
			<Excel:td align="right"><%=rec.get("peopleBirthday")%></Excel:td>
			<Excel:td align="right"><%=rec.get("jobStartTime")%></Excel:td>			
			<Excel:td align="right"><%=rec.get("peoplePolitics")%></Excel:td>
			<Excel:td align="right"><%=rec.get("peopleEdu")%></Excel:td>			
			<Excel:td align="right"><%=rec.get("peopleSchool")%></Excel:td>
			<Excel:td align="right"><%=rec.get("peopleAdress")%></Excel:td>			
		</Excel:tr>
		<%
			}
		%>
		<Excel:tr>
			<Excel:td colspan="5" align="left">制表人：<%= userName%></Excel:td>
			<Excel:td colspan="5" align="right">制表时间：<%= date2%></Excel:td>
		</Excel:tr>
	</Excel:table>
</Excel:tablelist>

