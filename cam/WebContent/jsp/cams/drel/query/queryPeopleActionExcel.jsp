<%@page contentType="charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="/tags/next-excel" prefix="Excel"%>
<%@page import="org.loushang.next.data.DataSet"%>
<%@page import="org.loushang.next.data.Record"%>
<%@page import="org.loushang.next.commons.nenum.EnumService" %>
<%@page import="org.loushang.sca.ScaComponentFactory" %>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<%@page import="java.util.*"%>
<%
	String title = "";
	String name = "";
	int count=13;
	String income = "年收入（元）";
	String assistanceType = request.getParameter("assistanceType");
	SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
	String date=sdf.format(new Date());
	if(assistanceType.equals("01")){
		title = "城市低保人员查询报表_"+date;
		name = "城市低保人员查询";
		count=14;
		income = "月收入（元）";
	}else if(assistanceType.equals("02")){
		title = "农村低保人员查询报表_"+date;
		name = "农村低保人员查询";
	}else if(assistanceType.equals("03")){
		title = "农村五保人员查询报表_"+date;
		name = "农村五保人员查询";
	}
	out.clear();//清空缓存的内容
	out = pageContext.pushBody(); 
%>

<!--导出Excel-->
<%@page import="com.inspur.cams.comm.dicm.IDicDao"%>
<%@page import="org.loushang.next.dao.DaoFactory"%>
<Excel:tablelist filename="<%=title%>">
	<Excel:table sheetname="<%=name%>" border="1">
		<Excel:tr>
			<Excel:td colspan="<%=count %>" align="center" ><Excel:font size="16"><%=name%></Excel:font></Excel:td>
		</Excel:tr>
		<Excel:tr  bgcolor="grey">
			<Excel:td  align="center" width="165"><Excel:font size="12">地区</Excel:font></Excel:td>
			<Excel:td  align="center" width="80"><Excel:font size="12">姓名</Excel:font></Excel:td>
			<Excel:td  align="center" width="80"><Excel:font size="12">性别</Excel:font></Excel:td>
			<Excel:td  align="center" width="80"><Excel:font size="12">年龄</Excel:font></Excel:td>
			<Excel:td  align="center" width="80"><Excel:font size="12">民族</Excel:font></Excel:td>
			<Excel:td  align="center" width="145"><Excel:font size="12">身份证号</Excel:font></Excel:td>
			<Excel:td  align="center" width="163"><Excel:font size="12"><%=income%></Excel:font></Excel:td>		
			<%
			if(assistanceType.equals("01")){
			%>
			<Excel:td  align="center" width="100"><Excel:font size="12">是否“三无”</Excel:font></Excel:td>
			<%
			}
			%>			
			<Excel:td  align="center" width="175"><Excel:font size="12">文化程度</Excel:font></Excel:td>
			<Excel:td  align="center" width="80"><Excel:font size="12">健康状况</Excel:font></Excel:td>
			<Excel:td  align="center" width="108"><Excel:font size="12">婚姻状况</Excel:font></Excel:td>		
			<%
			if(assistanceType.equals("01")||assistanceType.equals("02")){
			%>
			<Excel:td  align="center" width="105"><Excel:font size="12">劳动能力</Excel:font></Excel:td>
			<%
			}else if(assistanceType.equals("03")){
			%>
			<Excel:td  align="center" width="105"><Excel:font size="12">生活自理能力</Excel:font></Excel:td>	
			<%
			}
			%>			
			<Excel:td  align="center" width="80"><Excel:font size="12">残疾类别</Excel:font></Excel:td>
			<Excel:td  align="center" width="80"><Excel:font size="12">残疾等级</Excel:font></Excel:td>
		</Excel:tr>
		<%
			String sex = "";
			String isThreeNo = "";
			String healthCode = "";
			String laborCapacity = "";
			String selfCareAbility = "";
			DataSet dataset = (DataSet) request.getAttribute("dataset");
			EnumService enumService = ScaComponentFactory.getService(EnumService.class, "Enum/EnumService");
			IDicDao dao = (IDicDao) DaoFactory.getDao("com.inspur.cams.comm.dicm.DicDao");
			for (int i = 0; i < dataset.getCount(); i++) {
				Record rec = dataset.getRecord(i);
				if(rec.get("SEX")!=null){
					sex =  enumService.getDescByValue("COMM.SEX", (String)rec.get("SEX"));
				}
				if(rec.get("NATION") != null ){
					rec.set("NATION",dao.getValueByValue("DIC_NATION","NAME",(String)rec.get("NATION")));
				}
				if(rec.get("DOMICILE_TYPE") != null ){
					rec.set("DOMICILE_TYPE",enumService.getDescByValue("SAM_DOMICILE_TYPE", (String)rec.get("DOMICILE_TYPE")));
				}
				if(rec.get("EDU_CODE") != null ){
					rec.set("EDU_CODE",dao.getValueByValue("DIC_EDUCATION","NAME",(String)rec.get("EDU_CODE")));
				}
				if(rec.get("MARRIAGE_CODE") != null ){
					rec.set("MARRIAGE_CODE",dao.getValueByValue("DIC_MARRIAGE","NAME",(String)rec.get("MARRIAGE_CODE")));
				}
				if(rec.get("DISABILITY_TYPE") != null ){
					rec.set("DISABILITY_TYPE",dao.getValueByValue("DIC_DISABILITY_TYPE","NAME",(String)rec.get("DISABILITY_TYPE")));
				}
				if(rec.get("DISABILITY_LEVEL") != null ){
					rec.set("DISABILITY_LEVEL",dao.getValueByValue("DIC_HANDICAP_LEVEL","NAME",(String)rec.get("DISABILITY_LEVEL")));
				}
				if(rec.get("IS_THREE_NO")!=null){
					isThreeNo =  enumService.getDescByValue("COMM.YESORNO",(String)rec.get("IS_THREE_NO"));
				}
				if(rec.get("HEALTH_CODE")!=null){
					healthCode =  enumService.getDescByValue("SAM_HEALTH_CODE", (String)rec.get("HEALTH_CODE"));
				}
				if(rec.get("LABOR_CAPACITY")!=null){
					laborCapacity =  enumService.getDescByValue("SAM_LABOR_CAPACITY", (String)rec.get("LABOR_CAPACITY"));
				}
				if(rec.get("SELF_CARE_ABILITY")!=null){
					selfCareAbility =  enumService.getDescByValue("SAM_SELF_CARE_ABILITY", (String)rec.get("SELF_CARE_ABILITY"));
				}
		%>
		<Excel:tr border="1">
			<Excel:td align="center"><%=rec.get("TOWN")%></Excel:td>
			<Excel:td align="center"><%=rec.get("NAME")%></Excel:td>
			<Excel:td align="center"><%=sex%></Excel:td>
			<Excel:td align="center"><%=rec.get("AGE")%></Excel:td>
			<Excel:td align="center"><%=rec.get("NATION")%></Excel:td>
			<Excel:td align="center"><%=rec.get("ID_CARD")%></Excel:td>
			<%
			if(assistanceType.equals("01")){
			%>
			<Excel:td align="right"><%=rec.get("INCOME_MONTH")%></Excel:td>		
			<%
			}else if(assistanceType.equals("02")||assistanceType.equals("03")){
			%>
			<Excel:td align="right"><%=rec.get("INCOME_YEAR")%></Excel:td>		
			<%
			}
			%>			
			<%
			if(assistanceType.equals("01")){
			%>
			<Excel:td align="center"><%=isThreeNo%></Excel:td>
			<%
			}
			%>			
			<Excel:td align="center"><%=rec.get("EDU_CODE")%></Excel:td>
			<Excel:td align="center"><%=healthCode%></Excel:td>
			<Excel:td align="center"><%=rec.get("MARRIAGE_CODE")%></Excel:td>	
			<%
			if(assistanceType.equals("01")||assistanceType.equals("02")){
			%>
			<Excel:td align="center"><%=laborCapacity%></Excel:td>
			<%
			}else if(assistanceType.equals("03")){
			%>
			<Excel:td align="center"><%=selfCareAbility%></Excel:td>
			<%
			}
			%>			
			<Excel:td align="center"><%=rec.get("DISABILITY_TYPE")%></Excel:td>
			<Excel:td align="center"><%=rec.get("DISABILITY_LEVEL")%></Excel:td>
		</Excel:tr>
		<%
			}
		%>
		<Excel:tr border="0">
		<Excel:td  align="left" colspan="7" border="0">制表人：<%=BspUtil.getEmpOrgan().getOrganName()%></Excel:td>
		<Excel:td  align="right" colspan="<%=count-7 %>" border="0">制表时间：<%=date %></Excel:td>
		</Excel:tr>
	</Excel:table>
</Excel:tablelist>