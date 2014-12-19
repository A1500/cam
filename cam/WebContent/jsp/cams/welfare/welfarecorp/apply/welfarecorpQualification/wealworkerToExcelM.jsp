<%@ page contentType="charset=UTF-8"%>
<%@ taglib uri="/tags/next-excel" prefix="Excel"%>
<%@ page import="org.loushang.next.data.DataSet"%>
<%@ page import="org.loushang.next.data.Record"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="com.inspur.cams.comm.util.EnumUtil"%>
<Excel:tablelist filename="职工信息列表">
	<Excel:table>
	<%--标题栏 --%>
		<Excel:tr>
			<Excel:td colspan="22" align="center">职工信息列表</Excel:td>
		</Excel:tr>
	<%--列标题 --%>
		<Excel:tr bgcolor="grey">
			<Excel:td  align="center" width="100">姓名</Excel:td>
			<Excel:td  align="center" width="300">身份证号</Excel:td>
			<Excel:td  align="center" width="100">性别</Excel:td>
			<Excel:td  align="center" width="100">联系电话</Excel:td>
			<Excel:td  align="center" width="100">残疾类别</Excel:td>
			<Excel:td  align="center" width="300">残疾等级</Excel:td>
			<Excel:td  align="center" width="100">文化程度</Excel:td>
			<Excel:td  align="center" width="100">入厂时间</Excel:td>
			<Excel:td  align="center" width="300">入厂形式</Excel:td>
			<Excel:td  align="center" width="100">职业资格等级</Excel:td>
			<Excel:td  align="center" width="100">实发工资</Excel:td>
			<Excel:td  align="center" width="100">社会保险</Excel:td>
			<Excel:td  align="center" width="300">养老保险</Excel:td>
			<Excel:td  align="center" width="100">医疗保险</Excel:td>
			<Excel:td  align="center" width="100">失业保险</Excel:td>
			<Excel:td  align="center" width="100">工伤保险</Excel:td>
			<Excel:td  align="center" width="300">生育保险</Excel:td>
			<Excel:td  align="center" width="100">住房公积金</Excel:td>
			<Excel:td  align="center" width="100">商业保险</Excel:td>
			<Excel:td  align="center" width="100">残疾人补贴</Excel:td>
			<Excel:td  align="center" width="100">发放方式</Excel:td>
			<Excel:td  align="center" width="100">是否生产人员</Excel:td>
		</Excel:tr>
	<%--数据区 --%>
		<%	
			DataSet ds = (DataSet)request.getAttribute("dataset");
			for(int i=0; i<ds.getCount(); i++) {
				Record record = ds.getRecord(i);
		%>
		<Excel:tr>
			<Excel:td  align="center"><%=record.get("NAME")%></Excel:td>
			<Excel:td  align="center"><%=record.get("ID_CARD")%></Excel:td>
			<Excel:td  align="center"><%=EnumUtil.findTextFromEnum((String)record.get("SEX"),"COMM.SEX")%></Excel:td>
			<Excel:td  align="center"><%=record.get("PHONE")%></Excel:td>
			<Excel:td  align="center"><%=EnumUtil.findTextFromEnum("DIC_DISABILITY_TYPE","CODE","NAME",(String)record.get("DISABILITY_TYPE"))%></Excel:td>
			<Excel:td  align="center"><%=EnumUtil.findTextFromEnum("DIC_HANDICAP_LEVEL","CODE","NAME",(String)record.get("DISABILITY_LEVEL"))%></Excel:td>
			<Excel:td  align="center"><%=EnumUtil.findTextFromEnum("DIC_EDUCATION","CODE","NAME",(String)record.get("EDUCATION"))%></Excel:td>
			<Excel:td  align="center"><%=record.get("ENTRY_DATE")%></Excel:td>
			<Excel:td  align="center"><%=EnumUtil.findTextFromEnum((String)record.get("ENTRY_TYPE"),"WEAL.ENTRY_TYPE")%></Excel:td>
			<Excel:td  align="center"><%=EnumUtil.findTextFromEnum((String)record.get("JOB_LEVEL"),"WEAL.JOB_LEVEL")%></Excel:td>
			<Excel:td  align="center"><%=record.get("REAL_WAGES")%></Excel:td>
			<Excel:td  align="center"><%=record.get("SOCIAL_INSURANCE")%></Excel:td>
			<Excel:td  align="center"><%=record.get("ENDOWMENT_INSURANCE")%></Excel:td>
			<Excel:td  align="center"><%=record.get("MEDICAL_INSURANCE")%></Excel:td>
			<Excel:td  align="center"><%=record.get("UNEMPLOYED_INSURANCE")%></Excel:td>
			<Excel:td  align="center"><%=record.get("INJURY_INSURANCE")%></Excel:td>
			<Excel:td  align="center"><%=record.get("MATERNITY_INSURANCE")%></Excel:td>
			<Excel:td  align="center"><%=record.get("HOUSING_FUND")%></Excel:td>
			<Excel:td  align="center"><%=record.get("BUS_INSURANCE")%></Excel:td>
			<Excel:td  align="center"><%=record.get("DIS_SUBSIDY")%></Excel:td>
			<Excel:td  align="center"><%=EnumUtil.findTextFromEnum((String)record.get("ALLOCATION_TYPE"),"WEAL.ALLOCATION_TYPE")%></Excel:td>
			<Excel:td  align="center"><%=EnumUtil.findTextFromEnum((String)record.get("IF_PRODUCTOR"),"COMM.YESORNO")%></Excel:td>
		</Excel:tr>
		<%
			}
		%>
	</Excel:table>
</Excel:tablelist>