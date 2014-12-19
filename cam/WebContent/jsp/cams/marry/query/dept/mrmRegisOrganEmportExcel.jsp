<%@ page contentType="charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/tags/next-excel" prefix="Excel"%>
<%@page import="org.loushang.next.data.DataSet"%>
<%@page import="org.loushang.next.data.Record"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.inspur.cams.comm.util.EnumUtil"%>
<%@page import="java.util.*"%>
<head>
<title>登记机关导出</title>
<%
	SimpleDateFormat sdf=new SimpleDateFormat("yyyy年MM月dd日HH时mm分");
	String date=sdf.format(new Date());
	String name="登记机关名册_"+date;
%>
</head>
<Excel:tablelist filename="<%=name%>">
	<Excel:table sheetname="登记机关名册">
		<Excel:tr >
			<Excel:td  align="center" rowspan="2" width="150">名称</Excel:td>
			<Excel:td  align="center" rowspan="2" width="150">地址</Excel:td>
			<Excel:td  align="center" rowspan="2" width="100">服务电话</Excel:td>
			<Excel:td  align="center" rowspan="2" width="100">负责人</Excel:td>
			<Excel:td  align="center" rowspan="2" width="100">手机</Excel:td>
			<Excel:td  align="center" rowspan="2" width="100">电子邮箱</Excel:td>
			<Excel:td  align="center" rowspan="2" width="100">编制性质</Excel:td>
			<Excel:td  align="center" rowspan="2" width="100">级别</Excel:td>
			<Excel:td  align="center" rowspan="2" width="100">机关代码</Excel:td>
			<Excel:td  align="center" rowspan="2" width="80">成立时间</Excel:td>
			<Excel:td  align="center" rowspan="2" width="100">辖区人口</Excel:td>
			<Excel:td  align="center" rowspan="2" width="100">拟定编制人数</Excel:td>
			<Excel:td  align="center" rowspan="2" width="100">实有人数</Excel:td>
			<Excel:td  align="center" rowspan="2" width="100">辖区人口</Excel:td>
			<Excel:td  align="center" colspan="9" >登记机关面积</Excel:td>
			<Excel:td  align="center" colspan="3" >窗口</Excel:td>
			<Excel:td  align="center" colspan="3" >计算机</Excel:td>
			<Excel:td  align="center" colspan="4" >座椅</Excel:td>
			<Excel:td  align="center" rowspan="2" width="100">等级</Excel:td>
		</Excel:tr>
		<Excel:tr >
			<Excel:td  align="center" width="100" >合计</Excel:td>
			<Excel:td  align="center" width="100" >候登区</Excel:td>
			<Excel:td  align="center" width="100" >结婚登记区</Excel:td>
			<Excel:td  align="center" width="100" >离婚登记区</Excel:td>
			<Excel:td  align="center" width="100" >颁证区</Excel:td>
			<Excel:td  align="center" width="100" >咨询辅导区</Excel:td>
			<Excel:td  align="center" width="100" >档案区</Excel:td>
			<Excel:td  align="center" width="100" >主任室</Excel:td>
			<Excel:td  align="center" width="100" >其他</Excel:td>
			<Excel:td  align="center" width="100" >合计</Excel:td>
			<Excel:td  align="center" width="100" >结婚登记区</Excel:td>
			<Excel:td  align="center" width="100" >离婚登记区</Excel:td>
			<Excel:td  align="center" width="100" >合计</Excel:td>
			<Excel:td  align="center" width="100" >结婚登记区</Excel:td>
			<Excel:td  align="center" width="100" >离婚登记区</Excel:td>
			<Excel:td  align="center" width="100" >合计</Excel:td>
			<Excel:td  align="center" width="100" >等候</Excel:td>
			<Excel:td  align="center" width="100" >填表</Excel:td>
			<Excel:td  align="center" width="100" >颁证</Excel:td>
		</Excel:tr>
		<%
			DataSet ds = (DataSet)request.getAttribute("dataset");
			for(int i=0; i<ds.getCount(); i++) {
				Record rec = ds.getRecord(i);
		%>
		<Excel:tr>
			<Excel:td ><%=rec.get("DEPTNAME")%></Excel:td>
			<Excel:td><%=rec.get("ADDRESS")%></Excel:td>
			<Excel:td><%=rec.get("DEPTPOST")%></Excel:td>
			<Excel:td><%=rec.get("DEPTTEL")%></Excel:td>
			<Excel:td><%=rec.get("MODIFY_ID")%></Excel:td>
			<Excel:td><%=rec.get("COMPLAIN_TEL")%></Excel:td>
			<Excel:td><%=rec.get("OFFICE_EMAIL")%></Excel:td>
			<Excel:td><%=EnumUtil.findTextFromEnum((String)rec.get("TYPES"),"MRM.FORMATION.NATURE")%></Excel:td>
			<Excel:td><%=EnumUtil.findTextFromEnum((String)rec.get("SSLEVEL"),"MRM.LEVEL.TYPE")%></Excel:td>
			<Excel:td><%=rec.get("DEPT_CODE")%></Excel:td>
			<Excel:td><%=rec.get("CREAT_DATE")%></Excel:td>
			<Excel:td><%=rec.get("DEPT_NUM_RY")%></Excel:td>
			<Excel:td><%=rec.get("DEPT_NUM_RDBZ")%></Excel:td>
			<Excel:td><%=rec.get("DEPT_NUM_SJ")%></Excel:td>
			<Excel:td><%=rec.get("TOTALAREA")%></Excel:td>
			<Excel:td><%=rec.get("HDAREA")%></Excel:td>
			<Excel:td><%=rec.get("JHAREA")%></Excel:td>
			<Excel:td><%=rec.get("LHAREA")%></Excel:td>
			<Excel:td><%=rec.get("BZAREA")%></Excel:td>
			<Excel:td><%=rec.get("ZXFDAREA")%></Excel:td>
			<Excel:td><%=rec.get("DASAREA")%></Excel:td>
			<Excel:td><%=rec.get("ZRSAREA")%></Excel:td>
			<Excel:td><%=rec.get("QTAREA")%></Excel:td>
			<Excel:td><%=rec.get("TOTALWIN")%></Excel:td>
			<Excel:td><%=rec.get("JHWIN")%></Excel:td>
			<Excel:td><%=rec.get("LHWIN")%></Excel:td>
			<Excel:td><%=rec.get("TOTALCOM")%></Excel:td>
			<Excel:td><%=rec.get("JHCOM")%></Excel:td>
			<Excel:td><%=rec.get("LHCOM")%></Excel:td>
			<Excel:td><%=rec.get("TOTALCHAIR")%></Excel:td>
			<Excel:td><%=rec.get("DHCHAIR")%></Excel:td>
			<Excel:td><%=rec.get("TBCHAIR")%></Excel:td>
			<Excel:td><%=rec.get("BZCHAIR")%></Excel:td>
			<Excel:td><%=EnumUtil.findTextFromEnum((String)rec.get("SKIN_VALUE"),"MRM.EVALULEVEL.TYPE")%></Excel:td>
		</Excel:tr>
		<%
			}
		%>
	</Excel:table>
</Excel:tablelist>
