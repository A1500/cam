<%@ page contentType="charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ taglib uri="/tags/next-excel" prefix="Excel"%>
<%@page import="org.loushang.next.data.*"%>
<html>
	<head>
		<title>导出Excel</title>
		<next:ScriptManager/>
	</head>
<Excel:tablelist filename="车辆核对信息">
	<Excel:table sheetname="车辆核对信息">
		<Excel:tr>
			<Excel:td colspan="10" align="center"><Excel:font size="12">统计报表</Excel:font>></Excel:td>
		</Excel:tr>
		<Excel:tr bgcolor="grey">
			
			<Excel:td  align="center" width="100">人员姓名</Excel:td>
			<Excel:td  align="center" width="150">身份证号码</Excel:td>
			<Excel:td  align="center" width="100">车牌号码</Excel:td>
			<Excel:td  align="center" width="80">车辆类型</Excel:td>
			<Excel:td  align="center" width="80">登记价值(万元)</Excel:td>
			<Excel:td  align="center" width="80">登记时间</Excel:td>
			<Excel:td  align="center" width="80">车辆用途</Excel:td>
			<Excel:td  align="center" width="80">所在地区</Excel:td>
			<Excel:td  align="center" width="80">核对日期</Excel:td>
			<Excel:td  align="center" width="80">核对人</Excel:td>
		</Excel:tr>
		<%
			DataSet dataset=(DataSet)request.getAttribute("dataset");
			for(int i=0;i<dataset.getCount();i++){
				Record record=dataset.getRecord(i);
				String carType="";
				try{
					carType=(String)record.get("CAR_TYPE");
					if(carType.equals("01")){
						carType="大型";
					}else if(carType.equals("02")){
						carType="中型";
					}else if(carType.equals("03")){
						carType="小型";
					}else if(carType.equals("04")){
						carType="微型";
					}
				}catch(Exception e){}	
				
				String carUse="";
				try{
					carUse=(String)record.get("CAR_USE");
					if(carUse.equals("0")){
						carUse="营运";
					}else if(carUse.equals("1")){
						carUse="非营运";
					}
				}catch(Exception e){}	
				
				String familyAddress="";
				try{
					familyAddress=(String)record.get("FAMILY_ADDRESS");
					if(familyAddress.equals("370100000000")){
						familyAddress="济南市";
					}else if(familyAddress.equals("370101000000")){
						familyAddress="济南本级";
					}else if(familyAddress.equals("370102000000")){
						familyAddress="历下区";
					}else if(familyAddress.equals("370103000000")){
						familyAddress="市中区";
					}else if(familyAddress.equals("370104000000")){
						familyAddress="槐荫区";
					}else if(familyAddress.equals("370105000000")){
						familyAddress="天桥区";
					}else if(familyAddress.equals("370112000000")){
						familyAddress="历城区";
					}else if(familyAddress.equals("370113000000")){
						familyAddress="长清区";
					}else if(familyAddress.equals("370181000000")){
						familyAddress="章丘区";
					}else if(familyAddress.equals("370124000000")){
						familyAddress="平阴县";
					}else if(familyAddress.equals("370125000000")){
						familyAddress="济阳县";
					}else if(familyAddress.equals("370190000000")){
						familyAddress="济南市开发区";
					}else if(familyAddress.equals("370126000000")){
						familyAddress="商河县";
					}
				}catch(Exception e){}	
				
		%>
		<Excel:tr>
			
			<Excel:td><%=record.get("NAME")%></Excel:td>
			<Excel:td><%=record.get("ID_CARD")%></Excel:td>
			<Excel:td><%=record.get("CAR_NO")%></Excel:td>
			<Excel:td><%=carType%></Excel:td>
			<Excel:td><%=record.get("REG_VALUE")%></Excel:td>
 			<Excel:td><%=record.get("REG_DATE")%></Excel:td>
 			<Excel:td><%=carUse%></Excel:td>
 			<Excel:td><%=familyAddress%></Excel:td>
 			<Excel:td><%=record.get("CHECK_TIME")%></Excel:td>
 			<Excel:td><%=record.get("CHECK_PEOPLE")%></Excel:td>
		</Excel:tr>
		<%
			}
		%>
	</Excel:table>
</Excel:tablelist>

</html>