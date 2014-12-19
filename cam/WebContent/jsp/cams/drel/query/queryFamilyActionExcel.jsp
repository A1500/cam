<%@page contentType="charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="/tags/next-excel" prefix="Excel"%>
<%@page import="org.loushang.next.data.DataSet"%>
<%@page import="org.loushang.next.data.Record"%>
<%@page import="org.loushang.next.commons.nenum.EnumService" %>
<%@page import="org.loushang.sca.ScaComponentFactory" %>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<%@page import="java.util.*"%>
<%
	String title = "";
	String name = "";
	int colsCount=10;
	String assistanceType = request.getParameter("assistanceType");
	SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
	String date=sdf.format(new Date());
	if(assistanceType.equals("01")){
		title = "城市低保家庭查询报表_"+date;
		name = "城市低保家庭查询";
	}else if(assistanceType.equals("02")){
		title = "农村低保家庭查询报表_"+date;
		name = "农村低保家庭查询";
	}else if(assistanceType.equals("03")){
		title = "农村五保家庭查询报表_"+date;
		name = "农村五保家庭查询";
		colsCount=9;
	}
	out.clear();//清空缓存的内容
	out = pageContext.pushBody(); 
%>

<!--导出Excel-->
<Excel:tablelist filename="<%=title%>">
	<Excel:table sheetname="<%=name%>" border="1">
		<Excel:tr>
			<Excel:td colspan="<%=colsCount %>" align="center" ><Excel:font size="16"><%=name%></Excel:font></Excel:td>
		</Excel:tr>
		<Excel:tr  bgcolor="grey">
			<Excel:td  align="center" width="165"><Excel:font size="12">地区</Excel:font></Excel:td>
			<Excel:td  align="center" width="100"><Excel:font size="12">户主姓名</Excel:font></Excel:td>
			<Excel:td  align="center" width="145"><Excel:font size="12">身份证号</Excel:font></Excel:td>
			<Excel:td  align="center" width="130"><Excel:font size="12">低保证号</Excel:font></Excel:td>			
			<%
			if(assistanceType.equals("01")||assistanceType.equals("02")){
			%>
			<Excel:td  align="center" width="100"><Excel:font size="12">主要致贫原因</Excel:font></Excel:td>	
			<%
			}
			%>			
			<Excel:td  align="center" width="100"><Excel:font size="12">家庭人口数</Excel:font></Excel:td>
			<Excel:td  align="center" width="100"><Excel:font size="12">保障人口数</Excel:font></Excel:td>
			<%
			if(assistanceType.equals("01")||assistanceType.equals("02")){
			%>
			<Excel:td  align="center" width="120"><Excel:font size="12">保障金额（元）</Excel:font></Excel:td>
			<%
			}else if(assistanceType.equals("03")){
			%>
			<Excel:td  align="center" width="120"><Excel:font size="12">供养方式</Excel:font></Excel:td>
			<%
			}
			%>
			<Excel:td  align="center" width="100"><Excel:font size="12">起始保障年月</Excel:font></Excel:td>
			<Excel:td  align="center" width="300"><Excel:font size="12">家庭住址</Excel:font></Excel:td>
		</Excel:tr>
		<%
			String povertyCause = "";
			String supportWay = "";
			DataSet dataset = (DataSet) request.getAttribute("dataset");
			EnumService enumService = ScaComponentFactory.getService(EnumService.class, "Enum/EnumService");
			for (int i = 0; i < dataset.getCount(); i++) {
				Record rec = dataset.getRecord(i);
				if(rec.get("POVERTY_CAUSE")!=null){
					povertyCause =  enumService.getDescByValue("SAM_CITY_PROVERTY_CAUSE", (String)rec.get("POVERTY_CAUSE"));
				}
				if(rec.get("SUPPORT_WAY")!=null){
					supportWay =  enumService.getDescByValue("SAM.SUPPORT_WAY", (String)rec.get("SUPPORT_WAY"));
				}
		%>
		<Excel:tr border="1">
			<Excel:td align="center"><%=rec.get("DOMICILE_NAME")%></Excel:td>
			<Excel:td align="center"><%=rec.get("FAMILY_NAME")%></Excel:td>
			<Excel:td align="center"><%=rec.get("FAMILY_CARD_NO")%></Excel:td>
			<Excel:td align="center"><%=rec.get("CARD_NO")%></Excel:td>
			<%
			if(assistanceType.equals("01")||assistanceType.equals("02")){
			%>
			<Excel:td align="center"><%=povertyCause%></Excel:td>
			<%
			}
			%>
			<Excel:td align="right" ><%=rec.get("PEOPLE_NUM")%></Excel:td>
			<Excel:td align="right" ><%=rec.get("ASSISTANCE_PEOPLE_NUM")%></Excel:td>
			<%
			if(assistanceType.equals("01")||assistanceType.equals("02")){
			%>
			<Excel:td align="right" ><%=rec.get("ASSISTANCE_MONEY")%></Excel:td>
			<%
			}else if(assistanceType.equals("03")){
			%>
			<Excel:td align="center"><%=supportWay%></Excel:td>
			<%
			}
			%>
			<Excel:td align="center"><%=rec.get("BEGIN_DATE")%></Excel:td>
			<Excel:td align="center"><%=rec.get("ADDRESS")%></Excel:td>
		</Excel:tr>
		<%
			}
		%>
		<Excel:tr border="0">
		<Excel:td  align="left" colspan="5" border="0">制表人：<%=BspUtil.getEmpOrgan().getOrganName()%></Excel:td>
		<Excel:td  align="right" colspan="<%=colsCount-5 %>" border="0">制表时间：<%=date %></Excel:td>
		</Excel:tr>
	</Excel:table>
</Excel:tablelist>