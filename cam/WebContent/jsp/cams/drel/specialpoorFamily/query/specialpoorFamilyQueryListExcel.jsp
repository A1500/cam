<%@page contentType="charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="/tags/next-excel" prefix="Excel"%>
<%@page import="org.loushang.next.data.DataSet"%>
<%@page import="org.loushang.next.data.Record"%>
<%@page import="org.loushang.next.data.FieldSet"%>
<%@page import="org.loushang.next.commons.nenum.EnumService"%>
<%@page import="org.loushang.sca.ScaComponentFactory"%>
<%@page import="java.math.BigDecimal"%>
<%@page import="java.text.DecimalFormat"%>

<%@page import="java.text.SimpleDateFormat"%>
<%@ page import="org.loushang.bsp.security.context.GetBspInfo"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<%@page import="java.util.*"%>
<%!
	DataSet eduDs = new DataSet();
	String getEdu(String code) {
		if(code!=null && !"".equals(code)) {
			for(int i=0;i<eduDs.getCount();i++) {
				if(code.equals(eduDs.getRecord(i).get("value"))) {
					return 	(String)eduDs.getRecord(i).get("text");
				}
			}
		}
		return "";
	}
%>
<%
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	String date = sdf.format(new Date());
	String title = "特殊困难户统计_" + date;
	out.clear();//清空缓存的内容
	out = pageContext.pushBody();
%>
<!--导出Excel-->
<%@page import="org.loushang.next.dao.DaoFactory"%>
<%@page import="com.inspur.cams.comm.dicm.IDicDao"%>
<%@page import="org.loushang.next.data.ParameterSet"%>
<Excel:tablelist filename="<%=title%>">
	<Excel:table sheetname="特殊困难户统计" border="1">
		<Excel:tr>
			<Excel:td colspan="8" align="center" border="0">
				<Excel:font size="15">特殊困难户统计</Excel:font>
			</Excel:td>
		</Excel:tr>
		<Excel:tr border="0">
			<Excel:td align="left" colspan="8" border="0">统计单位：<%=BspUtil.getOrganName()%></Excel:td>
		</Excel:tr>
		<Excel:tr border="1" bgcolor="grey">
			<Excel:td width="90" align="center">户主姓名</Excel:td>
			<Excel:td width="200" align="center">身份证号码</Excel:td>
			<Excel:td width="80" align="center">家庭人口数</Excel:td>
			<Excel:td width="120" align="center">联系电话</Excel:td>
			<Excel:td width="250" align="center">致贫原因</Excel:td>
			<Excel:td width="90" align="center">是否低保标志</Excel:td>
			<Excel:td width="90" align="center">救助类型</Excel:td>
			<Excel:td width="250" align="center">家庭住址</Excel:td>
		</Excel:tr>
		<%
			DataSet dataset = (DataSet) request.getAttribute("dataset");
			EnumService enumService = ScaComponentFactory.getService(EnumService.class, "Enum/EnumService");
			IDicDao dao = (IDicDao) DaoFactory.getDao("com.inspur.cams.comm.dicm.DicDao");
			ParameterSet pset = new ParameterSet();
			pset.setParameter("dic","DIC_ASSITANCE_TYPE");
			pset.setParameter("includeCode","01,02,03");
			eduDs = dao.getDicMapList(pset);
			eduDs.getMetaData().setIdProperty("value");
					String assistanceFlag="";
					for (int i = 0; i < dataset.getCount(); i++) {
						Record rec = dataset.getRecord(i);
						assistanceFlag="";
						if(rec.get("assistanceFlag")!=null){
							assistanceFlag = enumService.getDescByValue("COMM.YESORNO", (String)rec.get("assistanceFlag"));
						}
		%>
		<Excel:tr border="1">
			<Excel:td><%=rec.get("familyName")%></Excel:td>
			<Excel:td><%=rec.get("familyCardNo")%></Excel:td>
			<Excel:td><%=rec.get("peopleNum")%></Excel:td>
			<Excel:td><%=rec.get("familyPhone")%></Excel:td>
			<Excel:td><%=rec.get("specialpoorCauseName")%></Excel:td>
			<Excel:td><%=assistanceFlag%></Excel:td>
			<Excel:td><%=getEdu((String)rec.get("assistanceType"))%></Excel:td>
			<Excel:td><%=rec.get("address")%></Excel:td>
		</Excel:tr>
		<%
			}
		%>
		<Excel:tr border="0">
			<Excel:td align="left" colspan="4" border="0">制表人：<%=BspUtil.getEmpOrgan()
													.getOrganName()%></Excel:td>
			<Excel:td align="right" colspan="4" border="0">制表时间：<%=date%></Excel:td>
		</Excel:tr>
	</Excel:table>
</Excel:tablelist>