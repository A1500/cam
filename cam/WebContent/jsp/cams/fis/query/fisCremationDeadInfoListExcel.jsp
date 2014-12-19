<%@page contentType="charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="/tags/next-excel" prefix="Excel"%>
<%@page import="org.loushang.next.data.DataSet"%>
<%@page import="org.loushang.next.data.Record"%>
<%@page import="org.loushang.next.data.FieldSet"%>
<%@page import="org.loushang.next.commons.nenum.EnumService" %>
<%@page import="org.loushang.sca.ScaComponentFactory" %>
<%@page import="java.math.BigDecimal" %>
<%@page import="java.text.DecimalFormat" %>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page import="org.loushang.bsp.security.context.GetBspInfo"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<%@page import="com.inspur.cams.comm.dicm.IDicDao" %>
<%@page import="org.loushang.next.dao.DaoFactory" %>

<%@page import="java.util.*"%>
<%!
IDicDao dicDao = (IDicDao) DaoFactory.getDao("com.inspur.cams.comm.dicm.DicDao");
	SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
	String date = sdf.format(new java.util.Date());
	String title = "逝者统计报表_"+date;
	String getKind(Object kind){
		if (!"".equals(kind)){
			return dicDao.getValueByValue("DIC_DISEASE", "name",(String)kind);
			
		} 
		return "";
	}
%>
<%
	out.clear();//清空缓存的内容
	out = pageContext.pushBody(); 
%>
<!--导出Excel-->
<Excel:tablelist filename="<%=title%>">
	<Excel:table sheetname="逝者统计报表" border="1">
		<Excel:tr>
			<Excel:td colspan="11" align="center" ><Excel:font size="16">逝者统计报表</Excel:font></Excel:td>
		</Excel:tr>
		<Excel:tr border="0">
		<Excel:td  align="left" colspan="6" border="0">统计单位：<%=BspUtil.getOrganName()%></Excel:td>
		<Excel:td  align="right" colspan="5" border="0"></Excel:td>
		</Excel:tr>
		<Excel:tr border="1" bgcolor="grey" >
			<Excel:td  align="center" width="30"><Excel:font size="13">序号</Excel:font></Excel:td>
			<Excel:td  align="center" width="80"><Excel:font size="13">姓名</Excel:font></Excel:td>
			<Excel:td  align="center" width="40"><Excel:font size="13">性别</Excel:font></Excel:td>
			<Excel:td  align="center" width="65"><Excel:font size="13">出生年月</Excel:font></Excel:td>
			<Excel:td  align="center" width="40"><Excel:font size="13">年龄</Excel:font></Excel:td>
			<Excel:td  align="center" width="130"><Excel:font size="13">证件号码</Excel:font></Excel:td>
			<Excel:td  align="center" width="300"><Excel:font size="13">户口所在地</Excel:font></Excel:td>
			<Excel:td  align="center" width="65"><Excel:font size="13">死亡原因</Excel:font></Excel:td>
			<Excel:td  align="center" width="65"><Excel:font size="13">入馆时间</Excel:font></Excel:td>
			<Excel:td  align="center" width="120"><Excel:font size="13">火化时间</Excel:font></Excel:td>
			<Excel:td  align="center" width="200"><Excel:font size="13">骨灰去向</Excel:font></Excel:td>
		</Excel:tr>
		<%
			String sex="";
			String cause="";
			String flag="";
			String ashesGo="";
			DataSet dataset = (DataSet) request.getAttribute("dataset");
			EnumService enumService = ScaComponentFactory.getService(EnumService.class, "Enum/EnumService");
				for (int i = 0; i < dataset.getCount(); i++) {
					Record rec = dataset.getRecord(i);
					if(rec.get("SEX")!=null){
						sex =  enumService.getDescByValue("COMM.SEX", (String)rec.get("SEX"));
					}
					if(rec.get("DEATH_CAUSE")!=null){
						cause =  enumService.getDescByValue("FIS.DEATH.CAUSE", (String)rec.get("DEATH_CAUSE"));
					}
					if(rec.get("CORPSE_STATUS")!=null){
						flag =  enumService.getDescByValue("FIS.CORPSE.STATUS", (String)rec.get("CORPSE_STATUS"));
					}
					if(rec.get("ASHES_GO")!=null){
						ashesGo =  enumService.getDescByValue("FIS.ASHES.GO", (String)rec.get("ASHES_GO"));
					}
		%>
		<Excel:tr>
			<Excel:td align="center"><%=i+1 %></Excel:td>
			<Excel:td align="center"><%=rec.get("NAME")%></Excel:td>
			<Excel:td align="center"><%=sex%></Excel:td>
			<Excel:td align="center"><%=rec.get("BIRTHDAY")%></Excel:td>
			<Excel:td align="center"><%=rec.get("AGE")%></Excel:td>
			<Excel:td align="center"><%=rec.get("ID_CARD")%></Excel:td>
			<Excel:td align="center"><%=rec.get("FULL_NAME")%></Excel:td>
			<Excel:td align="center"><%=cause%></Excel:td>
			<Excel:td align="center"><%=rec.get("RECEIVE_TIME")%></Excel:td>
			<Excel:td align="center"><%=rec.get("CREMATION_TIME")%></Excel:td>
			<Excel:td align="center"><%=ashesGo%></Excel:td>
		</Excel:tr>
		<%
			}
		%>
		<Excel:tr border="0">
		<Excel:td  align="left" colspan="6" border="0">制表人：<%=BspUtil.getEmpOrgan().getShortName()%></Excel:td>
		<Excel:td  align="right" colspan="5" border="0">制表时间：<%=date %></Excel:td>
		</Excel:tr>
	</Excel:table>
</Excel:tablelist>

