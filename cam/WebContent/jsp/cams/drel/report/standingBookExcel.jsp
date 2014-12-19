<%@ page contentType="charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/tags/next-excel" prefix="Excel"%>
<%@page import="org.loushang.next.data.DataSet"%>
<%@page import="org.loushang.next.data.Record"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<%@ page import="org.loushang.bsp.security.context.GetBspInfo"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="org.loushang.next.commons.nenum.EnumService" %>
<%@page import="org.loushang.sca.ScaComponentFactory" %>
<%@page import="java.util.*"%>
<%@page import="com.inspur.cams.comm.dicm.IDicDao"%>
<%@page import="org.loushang.next.dao.DaoFactory"%>
<head>
<title>导出Excel</title>
<%
	SimpleDateFormat sdf=new SimpleDateFormat("yyyy年MM月dd日HH时mm分");
	SimpleDateFormat sdf2=new SimpleDateFormat("yyyy年MM月dd日");
	String date=sdf.format(new Date());
	String date2=sdf2.format(new Date());
	String domicileName= request.getParameter("domicileName");
	//String name = startTime+"城市低保分类施保资金明细表_"+date;
	String username = GetBspInfo.getBspInfo(request).getUserName();
	out.clear();//清空缓存的内容
	out = pageContext.pushBody(); 
%>
</head>
<Excel:tablelist filename='<%=domicileName+"台账统计明细"%>'>
	<Excel:table sheetname="台账统计">
		<Excel:tr>
			<Excel:td colspan="49" align="center" ><Excel:font size="15"><%=domicileName+"台账统计明细" %></Excel:font></Excel:td>
		</Excel:tr>
		<Excel:tr>
			<Excel:td colspan="49" align="left">统计单位：<%= BspUtil.getOrganName()%></Excel:td>
		</Excel:tr>
		<Excel:tr  bgcolor="grey" border="1">
			<Excel:td  align="center" width="100" rowspan="2">登记时间</Excel:td>
			<Excel:td  align="center" width="100" rowspan="2">证件号码</Excel:td>
			<Excel:td  align="center" width="100" rowspan="2">户主姓名</Excel:td>
			<Excel:td  align="center" width="150" rowspan="2">身份证号码</Excel:td>
			<Excel:td  align="center" width="100" rowspan="2">性别</Excel:td>
			<Excel:td  align="center" width="100" rowspan="2">民族</Excel:td>
			<Excel:td  align="center" width="300" rowspan="2">家庭住址</Excel:td>
			<Excel:td  align="center" width="100" rowspan="2">邮编</Excel:td>
			<Excel:td  align="center" width="100" rowspan="2">家庭电话</Excel:td>
			<Excel:td  align="center" width="100" rowspan="2">享受保障类别</Excel:td>
			<Excel:td  align="center" width="100" rowspan="2">享受保障人数</Excel:td>
			<Excel:td  align="center" width="100" rowspan="2">女性人数</Excel:td>
			<Excel:td  align="center" width="100" rowspan="2">残疾人数</Excel:td>
			<Excel:td  align="center" width="100" rowspan="2">三无人员</Excel:td>
			<Excel:td  align="center" width="100" rowspan="2">老年人</Excel:td>
			<Excel:td  align="center" width="100" colspan="4" >成年人</Excel:td>
			<Excel:td  align="center" width="100" colspan="2" >未成年人</Excel:td>
			<Excel:td  align="center" width="100" rowspan="2">户月保障金</Excel:td>
			<Excel:td  align="center" width="100" rowspan="2">月收入</Excel:td>
			<Excel:td  align="center" width="100" rowspan="2">最低生活标准</Excel:td>
			<Excel:td  align="center" width="100" rowspan="2">金额二</Excel:td>
			<Excel:td  align="center" width="100" rowspan="2">金额三</Excel:td>
			<Excel:td  align="center" width="150" rowspan="2">开户行</Excel:td>
			<Excel:td  align="center" width="150" rowspan="2">开户行账号</Excel:td>
			<Excel:td  align="center" width="100" rowspan="2">变动种类</Excel:td>
			<Excel:td  align="center" width="100" rowspan="2">变动时间</Excel:td>
			<Excel:td  align="center" width="100" rowspan="2">户主是否享受</Excel:td>
			<Excel:td  align="center" width="100" rowspan="2">成员一姓名</Excel:td>
			<Excel:td  align="center" width="150" rowspan="2">成员一身份证号</Excel:td>
			<Excel:td  align="center" width="100" rowspan="2">成员二姓名</Excel:td>
			<Excel:td  align="center" width="150" rowspan="2">成员二身份证号</Excel:td>
			<Excel:td  align="center" width="100" rowspan="2">成员三姓名</Excel:td>
			<Excel:td  align="center" width="150" rowspan="2">成员三身份证号</Excel:td>
			<Excel:td  align="center" width="100" rowspan="2">成员四姓名</Excel:td>
			<Excel:td  align="center" width="150" rowspan="2">成员四身份证号</Excel:td>
			<Excel:td  align="center" width="100" rowspan="2">成员五姓名</Excel:td>
			<Excel:td  align="center" width="150" rowspan="2">成员五身份证号</Excel:td>
			<Excel:td  align="center" width="100" rowspan="2">成员六姓名</Excel:td>
			<Excel:td  align="center" width="150" rowspan="2">成员六身份证号</Excel:td>
			<Excel:td  align="center" width="100" rowspan="2">成员七姓名</Excel:td>
			<Excel:td  align="center" width="150" rowspan="2">成员七身份证号</Excel:td>
			<Excel:td  align="center" width="100" rowspan="2">成员八姓名</Excel:td>
			<Excel:td  align="center" width="150" rowspan="2">成员八身份证号</Excel:td>
			<Excel:td  align="center" width="100" rowspan="2">成员九姓名</Excel:td>
			<Excel:td  align="center" width="150" rowspan="2">成员九身份证号</Excel:td>
		</Excel:tr>
		<Excel:tr   bgcolor="grey" border="1">
			<Excel:td  align="center" width="100">在职人员</Excel:td>
			<Excel:td  align="center" width="100">灵活就业</Excel:td>
			<Excel:td  align="center" width="100">登记失业</Excel:td>
			<Excel:td  align="center" width="100">未登记失业</Excel:td>
			<Excel:td  align="center" width="100">在校生</Excel:td>
			<Excel:td  align="center" width="100">其他</Excel:td>			
		</Excel:tr>
		<%
			String sex = "";
			EnumService enumService = ScaComponentFactory.getService(EnumService.class, "Enum/EnumService");
			IDicDao dao = (IDicDao) DaoFactory.getDao("com.inspur.cams.comm.dicm.DicDao");
			DataSet ds = (DataSet)request.getAttribute("dataset");
				for(int i=0; i<ds.getCount(); i++) {
					Record rec = ds.getRecord(i);
					if(rec.get("SEX")!=null){
						sex =  enumService.getDescByValue("COMM.SEX", (String)rec.get("SEX"));
					}
					if(rec.get("NATION") != null ){
						rec.set("NATION",dao.getValueByValue("DIC_NATION","NAME",(String)rec.get("NATION")));
					}
					if(rec.get("ASSISTANCE_TYPE") != null ){
						rec.set("ASSISTANCE_TYPE",dao.getValueByValue("DIC_ASSITANCE_TYPE","NAME",(String)rec.get("ASSISTANCE_TYPE")));
					}
					if(rec.get("BANK") != null ){
						rec.set("BANK",dao.getValueByValue("DIC_BANK","NAME",(String)rec.get("BANK")));
					}
		%>
		<Excel:tr border="1">
			<Excel:td align="right"><%=rec.get("BEGIN_DATE")%></Excel:td>
			<Excel:td align="right"><%=rec.get("CARD_NO")%></Excel:td>
			<Excel:td align="right"><%=rec.get("FAMILY_NAME")%></Excel:td>
			<Excel:td align="right"><%=rec.get("FAMILY_CARD_NO")%></Excel:td>
			<Excel:td align="right"><%=sex%></Excel:td>
			<Excel:td align="right"><%=rec.get("NATION")%></Excel:td>
			<Excel:td align="right"><%=rec.get("ADDRESS")%></Excel:td>
			<Excel:td align="right"><%=rec.get("FAMILY_POSTCODE")%></Excel:td>
			<Excel:td align="right"><%=rec.get("FAMILY_PHONE")%></Excel:td>
			<Excel:td align="right"><%=rec.get("ASSISTANCE_TYPE")%></Excel:td>
			<Excel:td align="right"><%=rec.get("ASSISTANCE_PEOPLE_NUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("WOMEN_NO")%></Excel:td>
			<Excel:td align="right"><%=rec.get("DISABILITY_NO")%></Excel:td>
			<Excel:td align="right"><%=rec.get("ISTHREENO")%></Excel:td>
			<Excel:td align="right"><%=rec.get("OLD_NO")%></Excel:td>
			<Excel:td align="right"><%=rec.get("INCUMBENCY_NO")%></Excel:td>
			<Excel:td align="right"><%=rec.get("FLEXIBLE_NO")%></Excel:td>
			<Excel:td align="right"><%=rec.get("UNEMPLOYED_NO")%></Excel:td>
			<Excel:td align="right"><%=rec.get("NOT_UNEMPLOYED_NO")%></Excel:td>
			<Excel:td align="right"><%=rec.get("STUDENT_NO")%></Excel:td>
			<Excel:td align="right"><%=rec.get("OTHER_NO")%></Excel:td>
			<Excel:td align="right"><%=rec.get("ASSISTANCE_MONEY")%></Excel:td>
			<Excel:td align="right"><%=rec.get("MONTH_INCOME")%></Excel:td>
			<Excel:td align="right"><%=rec.get("LOW_STANDARDS")%></Excel:td>
			<Excel:td align="right"><%=rec.get("OTHERMONEY")%></Excel:td>
			<Excel:td align="right"><%=rec.get("ASSISTANCE_CLASS_MONEY")%></Excel:td>
			<Excel:td align="right"><%=rec.get("BANK")%></Excel:td>
			<Excel:td align="right"><%=rec.get("ACCOUNT_NUMBER")%></Excel:td>
			<Excel:td align="right"><%=rec.get("CHANGE_TYPE")%></Excel:td>
			<Excel:td align="right"><%=rec.get("CHANGE_DATE")%></Excel:td>
			<Excel:td align="right"><%=rec.get("IS_ENJOY")=="0"?"否":"是"%></Excel:td>
			<Excel:td align="right"><%=rec.get("P1_NAME")%></Excel:td>
			<Excel:td align="right"><%=rec.get("P1_ID_CARD")%></Excel:td>
			<Excel:td align="right"><%=rec.get("P2_NAME")%></Excel:td>
			<Excel:td align="right"><%=rec.get("P2_ID_CARD")%></Excel:td>
			<Excel:td align="right"><%=rec.get("P3_NAME")%></Excel:td>
			<Excel:td align="right"><%=rec.get("P3_ID_CARD")%></Excel:td>
			<Excel:td align="right"><%=rec.get("P4_NAME")%></Excel:td>
			<Excel:td align="right"><%=rec.get("P4_ID_CARD")%></Excel:td>
			<Excel:td align="right"><%=rec.get("P5_NAME")%></Excel:td>
			<Excel:td align="right"><%=rec.get("P5_ID_CARD")%></Excel:td>
			<Excel:td align="right"><%=rec.get("P6_NAME")%></Excel:td>
			<Excel:td align="right"><%=rec.get("P6_ID_CARD")%></Excel:td>
			<Excel:td align="right"><%=rec.get("P7_NAME")%></Excel:td>
			<Excel:td align="right"><%=rec.get("P7_ID_CARD")%></Excel:td>
			<Excel:td align="right"><%=rec.get("P8_NAME")%></Excel:td>
			<Excel:td align="right"><%=rec.get("P8_ID_CARD")%></Excel:td>
			<Excel:td align="right"><%=rec.get("P9_NAME")%></Excel:td>
			<Excel:td align="right"><%=rec.get("P9_ID_CARD")%></Excel:td>
		</Excel:tr>
		<%
			}
		%>
		<Excel:tr>
			<Excel:td colspan="24" align="left">制表人：<%= username%></Excel:td>
			<Excel:td colspan="25" align="right">制表时间：<%= date2%></Excel:td>
		</Excel:tr>
	</Excel:table>
</Excel:tablelist>

