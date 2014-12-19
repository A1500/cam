<%@ page contentType="charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/tags/next-excel" prefix="Excel"%>
<%@page import="org.loushang.next.data.DataSet"%>
<%@page import="org.loushang.next.data.Record"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="com.inspur.cams.marry.base.dao.IMarrydicDao" %>
<%@page import="com.inspur.cams.marry.region.dao.IMarryregionDao" %>
<%@page import="org.loushang.next.dao.DaoFactory" %>
<%@page import="org.loushang.next.data.ParameterSet" %>
<%@page import="java.math.BigDecimal" %>


<Excel:tablelist filename="查询婚姻登记机关结果列表">
	<Excel:table sheetname="查询婚姻登记机关结果列表">
		<Excel:tr>
			<Excel:td colspan="7" align="center" ><Excel:font size="15">查询婚姻登记机关结果列表</Excel:font></Excel:td>
		</Excel:tr>
		<Excel:tr height="50" >
			<Excel:td  align="center" width="100">统一编号</Excel:td>			
			<Excel:td  align="center" width="150">所属行政区</Excel:td>
			<Excel:td  align="center" width="300">机构名称</Excel:td>
			<Excel:td  align="center" width="100">机构类型</Excel:td>
			<Excel:td  align="center" width="130">机构性质</Excel:td>
			<Excel:td  align="center" width="120">创建日期</Excel:td>
			<Excel:td  align="center" width="80">机构状态</Excel:td>
		</Excel:tr>
		<%
			DataSet ds = (DataSet)request.getAttribute("dataset");
			IMarrydicDao mdDao = (IMarrydicDao) DaoFactory.getDao("com.inspur.cams.marry.base.dao.jdbc.MarrydicDao");
			IMarryregionDao mrDao = (IMarryregionDao) DaoFactory.getDao("com.inspur.cams.marry.region.dao.jdbc.MarryregionDao");
			
			//获取机构类型字典
			ParameterSet ps = new ParameterSet();
			ps.setParameter("PID@=", "1100");
			DataSet jglxDs = mdDao.getCacheDic(ps);
			
			//获取机构性质字典
			ParameterSet ps2 = new ParameterSet();
			ps2.setParameter("PID@=", "840");
			DataSet jgxzDs = mdDao.getCacheDic(ps2);
			
			//获取行政区划字典(全部)
			DataSet xzqhDs = mrDao.getCacheRegion(new ParameterSet());
			
			for(int i=0; i<ds.getCount(); i++) {
				Record rec = ds.getRecord(i);
				
				//遍历行政区划字典
				String regionCode= "";
				try { 
					regionCode= (String)rec.get("regionCode");
					for(int j=0; j < xzqhDs.getCount(); j++) {
						if(regionCode.equals(xzqhDs.getRecord(j).get("code"))) {
							regionCode =(String)(xzqhDs.getRecord(j).get("name"));
							break;
						} 
					}
				}catch(Exception e) {
					System.out.println("E:dept-regionCode:" + e.getMessage());
				}
				
				//遍历机构类型字典
				String adminType = "";
				try {
					adminType = (String)rec.get("adminType");
					for(int j=0; j < jglxDs.getCount(); j++) {
						if(adminType.equals(jglxDs.getRecord(j).get("dicValue"))) {
							adminType =(String)(jglxDs.getRecord(j).get("dicName"));
							break;
						} 
					}
				}catch(Exception e) {
					System.out.println("E:dept-adminType:" + e.getMessage());
				}
				
				//遍历机构性质字典
				String type = "";
				try {
					type = (String)rec.get("type");
					for(int j=0; j < jgxzDs.getCount(); j++) {
						if(type.equals(jgxzDs.getRecord(j).get("dicValue"))) {
							type =(String)(jgxzDs.getRecord(j).get("dicName"));
							break;
						} 
					}
				}catch(Exception e) {
					System.out.println("E:dept-type:" + e.getMessage());
				}
				
				//遍历机构状态
				String validFlag = "";
				try {
					BigDecimal validFlagInt = (BigDecimal)rec.get("validFlag");
					validFlag = (validFlagInt.intValue() == 1) ? "有效" : ((validFlagInt.intValue() == 9) ? "停用" : "新增");
				}catch(Exception e) {
					System.out.println("E:dept-validFlag:" + e.getMessage());
				}
		%>
		<Excel:tr>
			<Excel:td><%=rec.get("deptCode")%></Excel:td>	
			<Excel:td><%=regionCode%></Excel:td>			
			<Excel:td><%=rec.get("name")%></Excel:td>
			<Excel:td><%=adminType%></Excel:td>
			<Excel:td><%=type%></Excel:td>
			<Excel:td><%=rec.get("creatDate")%></Excel:td>
			<Excel:td><%=validFlag%></Excel:td>
		</Excel:tr>
		<%
			}
		%>
	</Excel:table>
</Excel:tablelist>

