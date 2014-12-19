<%@ page contentType="charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ taglib uri="/tags/next-excel" prefix="Excel"%>
<%@page import="org.loushang.next.data.*"%>
<%@page import="org.loushang.next.commons.nenum.EnumService" %>
<%@page import="org.loushang.sca.ScaComponentFactory" %>
<%@page import="com.inspur.cams.comm.dicm.IDicDao" %>
<%@page import="org.loushang.next.dao.DaoFactory" %>
<html>
<%
	String disDateStart = request.getParameter("disDateStart");
	String disDateEnd = request.getParameter("disDateEnd");
	String empDateStart = request.getParameter("empDateStart");
	String empDateEnd = request.getParameter("empDateEnd");
	String expDateStart = request.getParameter("expDateStart");
	String expDateEnd = request.getParameter("expDateEnd");
	String checkDate = request.getParameter("checkDate");
	String domicileCode = request.getParameter("domicileCode");
	out.clear();//清空缓存的内容
	out = pageContext.pushBody(); 

%>
	<head>
		<title>人员信息</title>
		<next:ScriptManager/>
	</head>
<Excel:tablelist filename="人员信息">
	<Excel:table sheetname="人员信息">
		<Excel:tr bgcolor="grey">
			<Excel:td  align="center" width="230">申请唯一号</Excel:td>
			<Excel:td  align="center" width="230">受理编号</Excel:td>
			<Excel:td  align="center" width="100">主申请人姓名</Excel:td>
			<Excel:td  align="center" width="200">主申请人证件类型</Excel:td>
			<Excel:td  align="center" width="200">主申请人证件号码</Excel:td>
			<Excel:td  align="center" width="100">姓名</Excel:td>
			<Excel:td  align="center" width="100">性别</Excel:td>
			<Excel:td  align="center" width="100">出生日期</Excel:td>
			<Excel:td  align="center" width="200">证件类型</Excel:td>
			<Excel:td  align="center" width="200">证件号码</Excel:td>
			<Excel:td  align="center" width="100">与主申请人关系</Excel:td>
			<Excel:td  align="center" width="100">曾用名</Excel:td>
			<Excel:td  align="center" width="100">行政区划</Excel:td>
		</Excel:tr>
		<%
		
		String sex="";
		String relationShip = "";
		String id_card_type = "";
		DataSet ds = (DataSet)request.getAttribute("dataset");
		IDicDao dao = (IDicDao) DaoFactory.getDao("com.inspur.cams.comm.dicm.DicDao");
		EnumService enumService = ScaComponentFactory.getService(EnumService.class, "Enum/EnumService");
		DataSet dataset = (DataSet)request.getAttribute("dataset");
		for(int i=0; i<dataset.getCount(); i++) {
			Record record = dataset.getRecord(i);
			if(record.get("SEX")!=null){
				sex = record.get("SEX")+":"+enumService.getDescByValue("COMM.SEX", (String)record.get("SEX"));
			}
			if(record.get("RELATIONSHIP_TYPE") != null ){
				relationShip = (String)record.get("RELATIONSHIP_TYPE");
				record.set("RELATIONSHIP_TYPE",dao.getValueByValue("DIC_RELATIONSHIP_TYPE","NAME",(String)record.get("RELATIONSHIP_TYPE")));
				relationShip = relationShip+":"+(String)record.get("RELATIONSHIP_TYPE");
			}
		%>
		<Excel:tr>
			<Excel:td><%=record.get("APPLY_ID")%></Excel:td>
			<Excel:td><%=""%></Excel:td>
			<Excel:td><%=record.get("FAMILY_NAME")%></Excel:td>
			<Excel:td><%=record.get("ID_CARD_TYPE")%></Excel:td>
			<Excel:td><%=record.get("FAMILY_CARD_NO")%></Excel:td>
 			<Excel:td><%=record.get("NAME")%></Excel:td>
 			<Excel:td><%=sex%></Excel:td>
 			<Excel:td><%=record.get("BIRTHDAY")%></Excel:td>
 			<Excel:td><%=record.get("ID_CARD_TYPE")%></Excel:td>
 			<Excel:td><%=record.get("ID_CARD")%></Excel:td>
 			<Excel:td><%=relationShip%></Excel:td>
 			<Excel:td><%=""%></Excel:td>
 			<Excel:td><%=domicileCode%></Excel:td>
		</Excel:tr>
		<%
			}
		%>
	</Excel:table>
</Excel:tablelist>

</html>