<%@ page contentType="charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/tags/next-excel" prefix="Excel"%>
<%@page import="org.loushang.next.data.DataSet"%>
<%@page import="org.loushang.next.data.Record"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="com.inspur.cams.marry.base.dao.IMarrydicDao" %>
<%@page import="com.inspur.cams.marry.dept.dao.IMarrydeptDao" %>
<%@page import="org.loushang.next.dao.DaoFactory" %>
<%@page import="org.loushang.next.data.ParameterSet" %>
<%@page import="java.math.BigDecimal" %>

<Excel:tablelist filename="查询婚姻登记人员结果列表">
	<Excel:table sheetname="查询婚姻登记人员结果列表">
		<Excel:tr>
			<Excel:td colspan="7" align="center" ><Excel:font size="15">查询婚姻登记人员结果列表</Excel:font></Excel:td>
		</Excel:tr>
		<Excel:tr height="50" >
			<Excel:td  align="center" width="100">登记员编号</Excel:td>			
			<Excel:td  align="center" width="80">姓名</Excel:td>
			<Excel:td  align="center" width="150">出生日期</Excel:td>
			<Excel:td  align="center" width="150">身份证号</Excel:td>
			<Excel:td  align="center" width="220">所属部门</Excel:td>
			<Excel:td  align="center" width="100">人员性质</Excel:td>
			<Excel:td  align="center" width="100">人员状态</Excel:td>
		</Excel:tr>
		<%
			DataSet ds = (DataSet)request.getAttribute("dataset");
			IMarrydicDao mdDao = (IMarrydicDao) DaoFactory.getDao("com.inspur.cams.marry.base.dao.jdbc.MarrydicDao");
			IMarrydeptDao mdeptDao = (IMarrydeptDao) DaoFactory.getDao("com.inspur.cams.marry.dept.dao.jdbc.MarrydeptDao");
			
			//获取人员性质字典
			ParameterSet ps = new ParameterSet();
			ps.setParameter("PID@=", "860");
			DataSet ryxzDs = mdDao.getCacheDic(ps);
			
			//获取登记机关字典
			ParameterSet ps2 = new ParameterSet();
			ps2.setParameter("DEPT_CODE@rlike@String", "37");
			DataSet djjgDs = mdeptDao.getCacheDept(ps2);
			
			for(int i=0; i<ds.getCount(); i++) {
				Record rec = ds.getRecord(i);
				
				//遍历人员性质字典
				String kind = "";
				try {	
					kind = (String)rec.get("kind");
					for(int j=0; j < ryxzDs.getCount(); j++) {
						if(kind.equals(ryxzDs.getRecord(j).get("dicValue"))) {
							kind =(String)(ryxzDs.getRecord(j).get("dicName"));
							break;
						} 
					}
				}catch(Exception e) {
					System.out.println("E:person-kind:" + e.getMessage());
				}
				
				//遍历部门编号字典
				String deptCode = "";
				try {	
					deptCode = (String)rec.get("deptCode");
					for(int j=0; j < djjgDs.getCount(); j++) {
						if(deptCode.equals(djjgDs.getRecord(j).get("deptCode"))) {
							deptCode =(String)(djjgDs.getRecord(j).get("name"));
							break;
						} 
					}
				}catch(Exception e) {
					System.out.println("E:person-deptCode:" + e.getMessage());
				}
				
				//遍历机构状态
				String validFlag = "";
				try {
					BigDecimal validFlagInt = (BigDecimal)rec.get("validFlag");
					validFlag = (validFlagInt.intValue() == 1) ? "有效" : ((validFlagInt.intValue() == 9) ? "停用" : "新增");
				}catch(Exception e) {
					System.out.println("E:person-validFlag:" + e.getMessage());
				}
		%>
		<Excel:tr>
			<Excel:td><%=rec.get("code")%></Excel:td>	
			<Excel:td><%=rec.get("name")%></Excel:td>			
			<Excel:td><%=rec.get("birthDate")%></Excel:td>
			<Excel:td><%=rec.get("cardNo")%></Excel:td>
			<Excel:td><%=deptCode%></Excel:td>
			<Excel:td><%=kind%></Excel:td>
			<Excel:td><%=validFlag%></Excel:td>
		</Excel:tr>
		<%
			}
		%>
	</Excel:table>
</Excel:tablelist>

