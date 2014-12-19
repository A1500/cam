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
	String name="业务流程统计表_"+date;
	String username=GetBspInfo.getBspInfo(request).getUserName();
	DataSet ds = (DataSet)request.getAttribute("dataset");
%>
</head>
<Excel:tablelist filename="<%=name %>">
	<Excel:table sheetname="业务流程统计表">
		<Excel:tr>
			<Excel:td colspan="16" align="center" ><Excel:font size="15">业务流程统计表</Excel:font></Excel:td>
		</Excel:tr>
		<Excel:tr>
			<Excel:td colspan="8" align="left">统计人员：<%= BspUtil.getOrganName()%></Excel:td>
			<Excel:td colspan="8" align="right">统计时间:<%=request.getParameter("statisticsTime")%></Excel:td>
		</Excel:tr>
		<Excel:tr height="30" bgcolor="grey" border="1">
			<Excel:td  align="center" width="100" bordercolor="black" colspan="4">业务类型：<%=ds.getRecord(0).get("PROC_DEF_NAME") %></Excel:td>
			<%if("null".equals(ds.getRecord(0).get("ACTIVE_ACT_DEF_NAMES"))){ %>
			<Excel:td  align="center" width="100" bordercolor="black" colspan="4">流程是否完结：是</Excel:td>			
			<%}else{ %>
			<Excel:td  align="center" width="100" bordercolor="black" colspan="4">流程是否完结：否</Excel:td>	
			<%
			  }
			%>
			<Excel:td  align="center" width="100" bordercolor="black" colspan="4">流程创建时间：<%=ds.getRecord(0).get("PROC_CREATE_TIME") %></Excel:td>
			<%if("null".equals(ds.getRecord(0).get("ACTIVE_ACT_DEF_NAMES"))){ %>
			<Excel:td  align="center" width="100" bordercolor="black" colspan="4">流程结束时间：<%=ds.getRecord(0).get("PROC_END_TIME") %></Excel:td>			
			<%}else{ %>
			<Excel:td  align="center" width="100" bordercolor="black" colspan="4">当前处理环节：<%=ds.getRecord(0).get("ACTIVE_ACT_DEF_NAMES") %></Excel:td>	
			<%
			  }
			%>
		</Excel:tr>
		<Excel:tr height="30" bgcolor="grey" border="1">
			<Excel:td  align="center" width="100" bordercolor="black" colspan="2">环节</Excel:td>
			<Excel:td  align="center" width="100" bordercolor="black" colspan="2">环节创建时间</Excel:td>
			<Excel:td  align="center" width="100" bordercolor="black" colspan="2">环节结束时间</Excel:td>
			<Excel:td  align="center" width="100" bordercolor="black" colspan="2">处理人</Excel:td>
			<Excel:td  align="center" width="100" bordercolor="black" colspan="2">处理意见</Excel:td>
			<Excel:td  align="center" width="100" bordercolor="black" colspan="2">补充意见</Excel:td>
			<Excel:td  align="center" width="100" bordercolor="black" colspan="2">处理人所在单位</Excel:td>
			<Excel:td  align="center" width="100" bordercolor="black" colspan="2">处理人所在部门</Excel:td>
		</Excel:tr>
		<%
			for(int i=0; i<ds.getCount(); i++) {
				Record rec = ds.getRecord(i);
		%>
		<Excel:tr border="1">
			<Excel:td align="center" colspan="2"><%=rec.get("ACT_DEF_NAME")%></Excel:td>
			<Excel:td align="center" colspan="2"><%=rec.get("CREATE_TIME")%></Excel:td>
			<Excel:td align="center" colspan="2"><%=rec.get("END_TIME")%></Excel:td>		
			<Excel:td align="center" colspan="2"><%=rec.get("ACTOR_NAME")%></Excel:td>
			<% String opinionId = (String) rec.get("OPINION_ID");
			if("0".equals(opinionId)){
				opinionId = "不同意";
			}else if("1".equals(opinionId)){
				opinionId = "同意";
			}else if("2".equals(opinionId)){
				opinionId = "补齐补正";
			}
			%>
			<Excel:td align="center" colspan="2"><%=opinionId%></Excel:td>
			<Excel:td align="center" colspan="2"><%=rec.get("OPINION")%></Excel:td>
			<Excel:td align="center" colspan="2"><%=rec.get("ORGAN_NAME")%></Excel:td>
			<Excel:td align="center" colspan="2"><%=rec.get("DEPT_NAME")%></Excel:td>
		</Excel:tr>
		<%
			}
		%>
		<Excel:tr>
			<Excel:td colspan="8" align="left">制表人：<%= username%></Excel:td>
			<Excel:td colspan="8" align="right">制表时间：<%= date2%></Excel:td>
		</Excel:tr>
	</Excel:table>
</Excel:tablelist>

