<%@ page contentType="charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/tags/next-excel" prefix="Excel"%>
<%@page import="org.loushang.next.data.DataSet"%>
<%@page import="org.loushang.next.data.Record"%>
<%!public static final int PAGE_COUNT=60000;%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.*"%>
<head>
<title>两参人员生活补助费导出</title>
<%
	SimpleDateFormat sdf=new SimpleDateFormat("yyyy年MM月dd日HH时mm分");
	String date=sdf.format(new Date());
	System.out.println(date);
	String name="两参人员生活补助费_"+date;
%>
</head>
<%
	//String size = request.getParameter("pageSize");
	//int pageSize = Integer.parseInt(size);
	String index = request.getParameter("pageIndex");
	int pageIndex = Integer.parseInt(index);
	//String cursor = request.getParameter("startCursor");
	//int startCursor = Integer.parseInt(cursor);
%>
<Excel:tablelist filename="<%=name%>">
	<Excel:table sheetname="两参人员生活补助费发放">
		<Excel:tr height="50" >
			<Excel:td  align="center" width="100">户籍地</Excel:td>
			<Excel:td  align="center" width="100">姓名</Excel:td>
			<Excel:td  align="center" width="100">身份证号</Excel:td>
			<Excel:td  align="center" width="100">优抚对象类别</Excel:td>
			<Excel:td  align="center" width="100">优抚证号</Excel:td>
			<Excel:td  align="center" width="100">户籍类别</Excel:td>
			<Excel:td  align="center" width="100">是否孤老</Excel:td>
			<Excel:td  align="center" width="100">银行帐号</Excel:td>
			<Excel:td  align="center" width="100">省标准</Excel:td>
			<Excel:td  align="center" width="100">发放月数</Excel:td>
			<Excel:td  align="center" width="100">发放金额</Excel:td>
			<Excel:td  align="center" width="100">地方补贴小计</Excel:td>
			<Excel:td  align="center" width="100">自然增长机制</Excel:td>
			<Excel:td  align="center" width="100">粮油补贴</Excel:td>
			<Excel:td  align="center" width="100">孤老增发</Excel:td>
			<Excel:td  align="center" width="100">补发金额</Excel:td>
			<Excel:td  align="center" width="100">其他补助1</Excel:td>
			<Excel:td  align="center" width="100">其他补助2</Excel:td>
			<Excel:td  align="center" width="100">其他补助3</Excel:td>
			<Excel:td  align="center" width="100">其他补助4</Excel:td>
			<Excel:td  align="center" width="100">其他补助5</Excel:td>
			<Excel:td  align="center" width="100">发放资金总额</Excel:td>
			<Excel:td  align="center" width="100">备注</Excel:td>
		</Excel:tr>
		<%
			DataSet ds = (DataSet)request.getAttribute("dataset");
		int count=ds.getCount()-PAGE_COUNT*(pageIndex-1);
		 if(count>=PAGE_COUNT){
			 count=PAGE_COUNT;
		 }else {
			 count=ds.getCount()-PAGE_COUNT*(pageIndex-1);
		 }
			for(int i=(pageIndex-1)*PAGE_COUNT; i<(pageIndex-1)*PAGE_COUNT+count; i++) {
				Record rec = ds.getRecord(i);
		%>
		<Excel:tr>
			<Excel:td><%=rec.get("DOMICILE_NAME")%></Excel:td>
			<Excel:td><%=rec.get("NAME")%></Excel:td>
			<Excel:td><%=rec.get("ID_CORD")%></Excel:td>
			<Excel:td><%=rec.get("OBJECT_TYPE")%></Excel:td>
			<Excel:td><%=rec.get("CREDENTIALS_NO")%></Excel:td>
			<Excel:td><%=rec.get("DOMICILE_TYPE")%></Excel:td>
			<Excel:td><%=rec.get("OLD_LONELY_FLAG")%></Excel:td>
			<Excel:td><%=rec.get("ACCOUNT_CODE")%></Excel:td>
			<Excel:td><%=rec.get("GRANT_STA_MON")%></Excel:td>
			<Excel:td><%=rec.get("GRANT_MONTHS")%></Excel:td>
			<Excel:td><%=rec.get("GRANT_MON")%></Excel:td>
			<Excel:td><%=rec.get("SUB_TOTAL")%></Excel:td>
			<Excel:td><%=rec.get("INCREASE_MECHANISM")%></Excel:td>
			<Excel:td><%=rec.get("GRAIN_OIL_MON")%></Excel:td>
			<Excel:td><%=rec.get("OLD_LONELY_MON")%></Excel:td>
			<Excel:td><%=rec.get("SUPPLY_MON")%></Excel:td>
			<Excel:td><%=rec.get("OTHER_SUBSIDY_ONE")%></Excel:td>
			<Excel:td><%=rec.get("OTHER_SUBSIDY_TWO")%></Excel:td>
			<Excel:td><%=rec.get("OTHER_SUBSIDY_THREE")%></Excel:td>
			<Excel:td><%=rec.get("OTHER_SUBSIDY_FOUR")%></Excel:td>
			<Excel:td><%=rec.get("OTHER_SUBSIDY_FIVE")%></Excel:td>
			<Excel:td><%=rec.get("GRANT_MON_SUM")%></Excel:td>
			<Excel:td><%=rec.get("NOTE")%></Excel:td>
		</Excel:tr>
		<%
			}
		%>
	</Excel:table>
</Excel:tablelist>
