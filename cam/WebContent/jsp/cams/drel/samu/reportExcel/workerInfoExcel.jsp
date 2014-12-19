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
	String name="工作人员情况统计表";
	String username = GetBspInfo.getBspInfo(request).getUserName();
	out.clear();//清空缓存的内容
	out = pageContext.pushBody(); 
%>
</head>
<Excel:tablelist filename="<%=name %>">
	<Excel:table sheetname="工作人员情况统计表">
		<Excel:tr>
			<Excel:td colspan="19" align="center" ><Excel:font size="15"  bold="true"><%=name %></Excel:font></Excel:td>
		</Excel:tr>
		<Excel:tr>
			<Excel:td colspan="9" align="left">统计单位：<%= BspUtil.getOrganName()%></Excel:td>
			<Excel:td colspan="10" align="right">统计时间:<%= date2%></Excel:td>
		</Excel:tr>
		<Excel:tr height="30" bgcolor="grey" border="1">
			<Excel:td  align="center" width="100" rowspan="2" bordercolor="black">单位</Excel:td>
			<Excel:td  align="center" width="100" rowspan="2" bordercolor="black">总数</Excel:td>			
			<Excel:td  align="center" width="100" colspan="5" bordercolor="black">岗位性质</Excel:td>
			<Excel:td  align="center" width="100" colspan="2" bordercolor="black">性别</Excel:td>
			<Excel:td  align="center" width="100" colspan="2" bordercolor="black">年龄</Excel:td>
			<Excel:td  align="center" width="100" colspan="4" bordercolor="black">工种</Excel:td>
			<Excel:td  align="center" width="100" colspan="4" bordercolor="black">工资</Excel:td>
		</Excel:tr>
		<Excel:tr height="20" bgcolor="grey" border="1">	
			<Excel:td  align="center" bordercolor="black" width="100">正式</Excel:td>
			<Excel:td  align="center" bordercolor="black" width="100">合同</Excel:td>
			<Excel:td  align="center" bordercolor="black" width="100">临时</Excel:td>
			<Excel:td  align="center" bordercolor="black" width="100">聘用五保</Excel:td>
			<Excel:td  align="center" bordercolor="black" width="100">其他</Excel:td>
			<Excel:td  align="center" bordercolor="black" width="100">男</Excel:td>
			<Excel:td  align="center" bordercolor="black" width="100">女</Excel:td>
			<Excel:td  align="center" bordercolor="black" width="100">平均</Excel:td>
			<Excel:td  align="center" bordercolor="black" width="100">35岁以下</Excel:td>
			<Excel:td  align="center" bordercolor="black" width="100">服务管理员</Excel:td>
			<Excel:td  align="center" bordercolor="black" width="100">炊事员</Excel:td>
			<Excel:td  align="center" bordercolor="black" width="100">卫生服务员</Excel:td>
			<Excel:td  align="center" bordercolor="black" width="100">其他</Excel:td>
			<Excel:td  align="center" bordercolor="black" width="100">1000元以下</Excel:td>
			<Excel:td  align="center" bordercolor="black" width="100">1000-2000元</Excel:td>
			<Excel:td  align="center" bordercolor="black" width="100">2000-3000元</Excel:td>
			<Excel:td  align="center" bordercolor="black" width="100">3000元以上</Excel:td>
		</Excel:tr>
		<%
			DataSet ds = (DataSet)request.getAttribute("dataset");
		
		%>
		<Excel:tr border="1">
			<Excel:td align="center">合计</Excel:td>
			<Excel:td align="right"><%=ds.sum("NUM_SUM")==null?"0":ds.sum("NUM_SUM")%></Excel:td>			
			<Excel:td align="right"><%=ds.sum("POST_ZS")==null?"0":ds.sum("POST_ZS")%></Excel:td>
			<Excel:td align="right"><%=ds.sum("POST_HT")==null?"0":ds.sum("POST_HT")%></Excel:td>
			<Excel:td align="right"><%=ds.sum("POST_LS")==null?"0":ds.sum("POST_LS")%></Excel:td>
			<Excel:td align="right"><%=ds.sum("POST_WB")==null?"0":ds.sum("POST_WB")%></Excel:td>
			<Excel:td align="right"><%=ds.sum("POST_QT")==null?"0":ds.sum("POST_QT")%></Excel:td>
			<Excel:td align="right"><%=ds.sum("SEX_MALE")==null?"0":ds.sum("SEX_MALE")%></Excel:td>	
			<Excel:td align="right"><%=ds.sum("SEX_FEMALE")==null?"0":ds.sum("SEX_FEMALE")%></Excel:td>
			<Excel:td align="right"><%=ds.sum("AVG_AGE")==null?"0":ds.sum("AVG_AGE")%></Excel:td>
			<Excel:td align="right"><%=ds.sum("LOW_AGE_NUM")==null?"0":ds.sum("LOW_AGE_NUM")%></Excel:td>
			<Excel:td align="right"><%=ds.sum("WORK_GL")==null?"0":ds.sum("WORK_GL")%></Excel:td>
			<Excel:td align="right"><%=ds.sum("WORK_CS")==null?"0":ds.sum("WORK_CS")%></Excel:td>
			<Excel:td align="right"><%=ds.sum("WORK_WS")==null?"0":ds.sum("WORK_WS")%></Excel:td>
			<Excel:td align="right"><%=ds.sum("WORK_QT")==null?"0":ds.sum("WORK_QT")%></Excel:td>
			<Excel:td align="right"><%=ds.sum("SALARY_ONE")==null?"0":ds.sum("SALARY_ONE")%></Excel:td>
			<Excel:td align="right"><%=ds.sum("SALARY_TWO")==null?"0":ds.sum("SALARY_TWO")%></Excel:td>
			<Excel:td align="right"><%=ds.sum("SALARY_THREE")==null?"0":ds.sum("SALARY_THREE")%></Excel:td>
			<Excel:td align="right"><%=ds.sum("SALARY_FOUR")==null?"0":ds.sum("SALARY_FOUR")%></Excel:td>				
		</Excel:tr>
		
		<%
				for(int i=0; i<ds.getCount(); i++) {
					Record rec = ds.getRecord(i);
		%>
		<Excel:tr border="1">
			<Excel:td align="center"><%=rec.get("NAME")%></Excel:td>
			<Excel:td align="right"><%=rec.get("NUM_SUM")==null?"0":rec.get("NUM_SUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("POST_ZS")==null?"0":rec.get("POST_ZS")%></Excel:td>			
			<Excel:td align="right"><%=rec.get("POST_HT")==null?"0":rec.get("POST_HT")%></Excel:td>
			<Excel:td align="right"><%=rec.get("POST_LS")==null?"0":rec.get("POST_LS")%></Excel:td>
			<Excel:td align="right"><%=rec.get("POST_WB")==null?"0":rec.get("POST_WB")%></Excel:td>
			<Excel:td align="right"><%=rec.get("POST_QT")==null?"0":rec.get("POST_QT")%></Excel:td>
			<Excel:td align="right"><%=rec.get("SEX_MALE")==null?"0":rec.get("SEX_MALE")%></Excel:td>
			<Excel:td align="right"><%=rec.get("SEX_FEMALE")==null?"0":rec.get("SEX_FEMALE")%></Excel:td>			
			<Excel:td align="right"><%=rec.get("AVG_AGE")==null?"0":rec.get("AVG_AGE")%></Excel:td>
			<Excel:td align="right"><%=rec.get("LOW_AGE_NUM")==null?"0":rec.get("LOW_AGE_NUM")%></Excel:td>
			<Excel:td align="right"><%=rec.get("WORK_GL")==null?"0":rec.get("WORK_GL")%></Excel:td>
			<Excel:td align="right"><%=rec.get("WORK_CS")==null?"0":rec.get("WORK_CS")%></Excel:td>
			<Excel:td align="right"><%=rec.get("WORK_WS")==null?"0":rec.get("WORK_WS")%></Excel:td>
			<Excel:td align="right"><%=rec.get("WORK_QT")==null?"0":rec.get("WORK_QT")%></Excel:td>
			<Excel:td align="right"><%=rec.get("SALARY_ONE")==null?"0":rec.get("SALARY_ONE")%></Excel:td>
			<Excel:td align="right"><%=rec.get("SALARY_TWO")==null?"0":rec.get("SALARY_TWO")%></Excel:td>
			<Excel:td align="right"><%=rec.get("SALARY_THREE")==null?"0":rec.get("SALARY_THREE")%></Excel:td>
			<Excel:td align="right"><%=rec.get("SALARY_FOUR")==null?"0":rec.get("SALARY_FOUR")%></Excel:td>
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

