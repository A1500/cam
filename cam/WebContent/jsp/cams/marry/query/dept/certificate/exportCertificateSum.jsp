<%@ page contentType="charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/tags/next-excel" prefix="Excel"%>
<%@page import="org.loushang.next.data.DataSet"%>
<%@page import="org.loushang.next.data.Record"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<%@ page import="org.loushang.bsp.security.context.GetBspInfo"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.*"%>
<head>
<title>导出Excel</title>
<%
	SimpleDateFormat sdf=new SimpleDateFormat("yyyy年MM月dd日HH时mm分");
	SimpleDateFormat sdf2=new SimpleDateFormat("yyyy年MM月dd日");
	String date=sdf.format(new Date());
	String date2=sdf2.format(new Date());
	String name="特邀颁证师统计表_"+date;
	String username=GetBspInfo.getBspInfo(request).getUserName();
%>
</head>
<Excel:tablelist filename="<%=name %>">
	<Excel:table sheetname="特邀颁证师统计表">
		<Excel:tr>
			<Excel:td colspan="19" align="center" ><Excel:font size="15">特邀颁证师统计表</Excel:font></Excel:td>
		</Excel:tr>
		<Excel:tr>
			<Excel:td colspan="19" align="left">统计单位：<%= BspUtil.getOrganName()%></Excel:td>
		</Excel:tr>
		<Excel:tr height="30" bgcolor="grey" border="1">
			<Excel:td  align="center" width="140" rowspan="2" bordercolor="black">单位</Excel:td>
			<Excel:td  align="center" width="100" rowspan="2" bordercolor="black">总人数</Excel:td>			
			<Excel:td  align="center" width="100" colspan="2" bordercolor="black">性别</Excel:td>
			<Excel:td  align="center" width="100" colspan="2" bordercolor="black">政治面貌</Excel:td>
			<Excel:td  align="center" width="100" colspan="3" bordercolor="black">学历</Excel:td>
			<Excel:td  align="center" width="100" colspan="2" bordercolor="black">专业</Excel:td>
			<Excel:td  align="center" width="100" colspan="4" bordercolor="black">专业资格证</Excel:td>
			<Excel:td  align="center" width="100" colspan="4" bordercolor="black">人员来源</Excel:td>
		</Excel:tr>
		<Excel:tr height="20" bgcolor="grey" border="1">
			<Excel:td  align="center" bordercolor="black" >男</Excel:td>
			<Excel:td  align="center" bordercolor="black" >女</Excel:td>
			<Excel:td  align="center" bordercolor="black" >党员</Excel:td>
			<Excel:td  align="center" bordercolor="black" >团员</Excel:td>
			<Excel:td  align="center" bordercolor="black" >研究生</Excel:td>
			<Excel:td  align="center" bordercolor="black" >大学本科</Excel:td>
			<Excel:td  align="center" bordercolor="black" >专科</Excel:td>
			<Excel:td  align="center" bordercolor="black" >心理咨询</Excel:td>
			<Excel:td  align="center" bordercolor="black" >法律</Excel:td>
			<Excel:td  align="center" bordercolor="black" >社工</Excel:td>
			<Excel:td  align="center" bordercolor="black" >心理咨询师</Excel:td>
			<Excel:td  align="center" width="100" bordercolor="black" >婚姻家庭咨询师</Excel:td>
			<Excel:td  align="center" bordercolor="black" >律师</Excel:td>
			<Excel:td  align="center" bordercolor="black" >政府购买服务</Excel:td>
			<Excel:td  align="center" bordercolor="black" >公开招募</Excel:td>
			<Excel:td  align="center" bordercolor="black" >志愿者</Excel:td>
			<Excel:td  align="center" bordercolor="black" >其他</Excel:td>	
		</Excel:tr>
		<%
			DataSet ds = (DataSet)request.getAttribute("dataset");
				for(int i=0; i<ds.getCount(); i++) {
					Record rec = ds.getRecord(i);
		%>
		<Excel:tr border="1">
			<Excel:td><%=rec.get("ORGAN_NAME")%></Excel:td>
			<Excel:td><%=rec.get("TOTALNUM")%></Excel:td>
			<Excel:td><%=rec.get("NAN_NUM")%></Excel:td>			
			<Excel:td><%=rec.get("NV_NUM")%></Excel:td>
			<Excel:td><%=rec.get("DY_NUM")%></Excel:td>
			<Excel:td><%=rec.get("TY_NUM")%></Excel:td>
			<Excel:td><%=rec.get("YJS_NUM")%></Excel:td>			
			<Excel:td><%=rec.get("DXBK_NUM")%></Excel:td>
			<Excel:td><%=rec.get("ZK_NUM")%></Excel:td>
			<Excel:td><%=rec.get("XLZX_NUM")%></Excel:td>
			<Excel:td><%=rec.get("FL_NUM")%></Excel:td>
			<Excel:td><%=rec.get("SG_NUM")%></Excel:td>
			<Excel:td><%=rec.get("XLZXS_NUM")%></Excel:td>			
			<Excel:td><%=rec.get("HYJTZXS_NUM")%></Excel:td>
			<Excel:td><%=rec.get("LS_NUM")%></Excel:td>
			<Excel:td><%=rec.get("ZFGMFW_NUM")%></Excel:td>
			<Excel:td><%=rec.get("GKZM_NUM")%></Excel:td>			
			<Excel:td><%=rec.get("ZYZ_NUM")%></Excel:td>
			<Excel:td><%=rec.get("QT_NUM")%></Excel:td>
		</Excel:tr>
		<%
			}
		%>
		<Excel:tr>
			<Excel:td colspan="9" align="left">制表人：<%= username%></Excel:td>
			<Excel:td colspan="10" align="right">制表时间：<%= date2%></Excel:td>
		</Excel:tr>
	</Excel:table>
</Excel:tablelist>

