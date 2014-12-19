<%@ page contentType="charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/tags/next-excel" prefix="Excel"%>
<%@page import="org.loushang.next.data.DataSet"%>
<%@page import="org.loushang.next.data.Record"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="com.inspur.cams.marry.base.dao.IMarrydicDao" %>
<%@page import="org.loushang.next.dao.DaoFactory" %>
<%@page import="org.loushang.next.data.ParameterSet" %>


<Excel:tablelist filename="查询婚姻记录结果列表">
	<Excel:table sheetname="查询婚姻记录结果列表">
		<Excel:tr>
			<Excel:td colspan="7" align="center" ><Excel:font size="15">查询婚姻记录结果列表</Excel:font></Excel:td>
		</Excel:tr>
		<Excel:tr height="50" >
			<Excel:td  align="center" width="180">登记字号</Excel:td>			
			<Excel:td  align="center" width="80">男方姓名</Excel:td>
			<Excel:td  align="center" width="150">男方身份证号</Excel:td>
			<Excel:td  align="center" width="80">女方姓名</Excel:td>
			<Excel:td  align="center" width="150">女方身份证号</Excel:td>
			<Excel:td  align="center" width="120">登记日期</Excel:td>
			<Excel:td  align="center" width="100">业务类型</Excel:td>
			<Excel:td  align="center" width="220">登记机关</Excel:td>
		</Excel:tr>
		<%
			DataSet ds = (DataSet)request.getAttribute("dataset");
			IMarrydicDao mdDao = (IMarrydicDao) DaoFactory.getDao("com.inspur.cams.marry.base.dao.jdbc.MarrydicDao");
			
			//获取业务类型字典
			ParameterSet ps = new ParameterSet();
			ps.setParameter("PID@=", "760");
			DataSet mdDs = mdDao.getCacheDic(ps);
			
			for(int i=0; i<ds.getCount(); i++) {
				Record rec = ds.getRecord(i);
				
				//遍历业务类型字典
				String ot= "";
				try {
					ot= (String)rec.get("opType");
					for(int j=0; j < mdDs.getCount(); j++) {
						if(ot.equals(mdDs.getRecord(j).get("dicValue"))) {
							ot =(String)(mdDs.getRecord(j).get("dicName"));
							break;
						} 
					}
				}catch(Exception e) {
					System.out.println("E:list-opType:" + e.getMessage());
				}
		%>
		<Excel:tr>
			<Excel:td><%=rec.get("certNo")%></Excel:td>	
			<Excel:td><%=rec.get("nameMan")%></Excel:td>			
			<Excel:td><%=rec.get("certNumMan")%></Excel:td>
			<Excel:td><%=rec.get("nameWoman")%></Excel:td>
			<Excel:td><%=rec.get("certNumWoman")%></Excel:td>
			<Excel:td><%=rec.get("opDate")%></Excel:td>
			<Excel:td><%=ot%></Excel:td>
			<Excel:td><%=rec.get("deptName")%></Excel:td>
		</Excel:tr>
		<%
			}
		%>
	</Excel:table>
</Excel:tablelist>

