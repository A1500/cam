<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="/tags/next-excel" prefix="Excel"%>
<%@page import="org.loushang.next.data.DataSet"%>
<%@page import="org.loushang.next.data.Record"%>
<%@page import="java.text.SimpleDateFormat"%>
<Excel:tablelist filename="一站式结算医院报表">
	<Excel:table>
	<%--标题栏 --%>
		<Excel:tr>
			<Excel:td colspan="23" align="center">一站式结算医院报表</Excel:td>
		</Excel:tr>
		<%
			SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
		%>
	<%--时间栏 --%>
		<Excel:tr>
			<Excel:td colspan="23" align="left">日期：<%=sdf.format(new java.util.Date())%></Excel:td>
		</Excel:tr>
	<%--列标题 --%>
		<Excel:tr bgcolor="grey">
			<Excel:td  align="center">住院号</Excel:td>
			<Excel:td  align="center">姓名</Excel:td>
			<Excel:td  align="center">性别</Excel:td>
			<Excel:td  align="center">年龄</Excel:td>
			<Excel:td  align="center">身份证号</Excel:td>
			<Excel:td  align="center">医疗救助类型</Excel:td>
			<Excel:td  align="center">医疗救助证书编号</Excel:td>
			<Excel:td  align="center">救助对象属地</Excel:td>
			<Excel:td  align="center">优抚证书类型</Excel:td>
			<Excel:td  align="center">优抚证书编号</Excel:td>
			<Excel:td  align="center">入住医院</Excel:td>
			<Excel:td  align="center">病种</Excel:td>
			<Excel:td  align="center">住院总费用(元)</Excel:td>
			<Excel:td  align="center">纳入保险报销费用(元)</Excel:td>
			<Excel:td  align="center">保险支付金额(元)</Excel:td>
			<Excel:td  align="center">优抚医院减免(元)</Excel:td>
			<Excel:td  align="center">优抚补助基数(元)</Excel:td>
			<Excel:td  align="center">优抚补助金额(元)</Excel:td>
			<Excel:td  align="center">救助基数(元)</Excel:td>
			<Excel:td  align="center">救助金额(元)</Excel:td>
			<Excel:td  align="center">其他救助金额(元)</Excel:td>
			<Excel:td  align="center">救助日期</Excel:td>
			<Excel:td  align="center">自付费用(元)</Excel:td>
		</Excel:tr>
	<%--数据区 --%>
		<%
			DataSet dataset=(DataSet)request.getAttribute("dataset");
			
			for(int i=0;i<dataset.getCount();i++){
				Record record=dataset.getRecord(i);
				String sex="";
				if("1".equals(record.get("SEX"))){
					sex="男";
				}else if("2".equals(record.get("SEX"))){
					sex="女";
				}
				String insuranceType="";
				if("2".equals(record.get("INSURANCE_TYPE"))){
					insuranceType="城镇职工基本医疗保险";
				}else if("3".equals(record.get("INSURANCE_TYPE"))){
					insuranceType="城镇居民基本医疗保险";	
				}else if("4".equals(record.get("INSURANCE_TYPE"))){
					insuranceType="新型农村合作医疗";	
				}else if("1".equals(record.get("INSURANCE_TYPE"))){
					insuranceType="公费医疗";	
				}else if("5".equals(record.get("INSURANCE_TYPE"))){
					insuranceType="其他";	
				}
				String assitanceType="";
				if("01".equals(record.get("ASSITANCE_TYPE"))){
					assitanceType="城市低保";
				}else if("02".equals(record.get("ASSITANCE_TYPE"))){
					assitanceType="农村低保";	
				}else if("03".equals(record.get("ASSITANCE_TYPE"))){
					assitanceType="五保";	
				}
				String bptType="";
				if("0".equals(record.get("BPT_TYPE"))){
					if("01".equals(record.get("DISABILITY_LEVEL_CODE"))){
						bptType="一级伤残";
					}else if("02".equals(record.get("DISABILITY_LEVEL_CODE"))){
						bptType="二级伤残";
					}else if("03".equals(record.get("DISABILITY_LEVEL_CODE"))){
						bptType="三级伤残";
					}else if("04".equals(record.get("DISABILITY_LEVEL_CODE"))){
						bptType="四级伤残";
					}else if("05".equals(record.get("DISABILITY_LEVEL_CODE"))){
						bptType="五级伤残";
					}else if("06".equals(record.get("DISABILITY_LEVEL_CODE"))){
						bptType="六级伤残";
					}else if("07".equals(record.get("DISABILITY_LEVEL_CODE"))){
						bptType="七级伤残";
					}else if("08".equals(record.get("DISABILITY_LEVEL_CODE"))){
						bptType="八级伤残";
					}else if("09".equals(record.get("DISABILITY_LEVEL_CODE"))){
						bptType="九级伤残";
					}else if("10".equals(record.get("DISABILITY_LEVEL_CODE"))){
						bptType="十级伤残";
					}
				}else if("1".equals(record.get("BPT_TYPE"))){
					bptType="三属";	
				}else if("2".equals(record.get("BPT_TYPE"))){
					bptType="在乡复员军人";	
				}else if("3".equals(record.get("BPT_TYPE"))){
					bptType="带病回乡";	
				}else if("4".equals(record.get("BPT_TYPE"))){
					bptType="参战";	
				}
		%>
		<Excel:tr>
			<Excel:td><%=record.get("HOSPITAL_RECORD_ID")%></Excel:td>
			<Excel:td><%=record.get("NAME")%></Excel:td>
			<Excel:td><%= sex %></Excel:td>
			<Excel:td width="50"><%=record.get("AGE")%></Excel:td>
			<Excel:td width="180"><%=record.get("ID_CARD")%></Excel:td>
			<Excel:td width="100"><%=assitanceType%></Excel:td>
			<Excel:td width="100"><%=record.get("SAM_CARD_NO")%></Excel:td>
			<Excel:td width="100"><%=record.get("CITY_NAME")%></Excel:td>
			<Excel:td width="100"><%=record.get("bptName")%></Excel:td>
			<Excel:td width="100"><%=record.get("BPT_CARD_NO")%></Excel:td>
			<Excel:td width="100"><%=record.get("ORGAN_NAME")%></Excel:td>
			<Excel:td width="180"><%=record.get("DISEASE")%></Excel:td>
			<Excel:td width="100"><%=record.get("TOTAL_EXPENSE")%></Excel:td>
			<Excel:td width="100"><%=record.get("INSURANCE_EXPENSE")%></Excel:td>
			<Excel:td width="100"><%=record.get("INSURANCE_PAY")%></Excel:td>
			<Excel:td width="100"><%=record.get("HOSPITAL_PAY")%></Excel:td>
			<Excel:td width="100"><%=record.get("BPT_BASE")%></Excel:td>
			<Excel:td width="100"><%=record.get("SPECIAL_PAY")%></Excel:td>
			<Excel:td width="100"><%=record.get("INSURANCE_BASE")%></Excel:td>
			<Excel:td width="100"><%=record.get("ASSITANCE_PAY")%></Excel:td>
			<Excel:td width="100"><%=record.get("OTHER_PAY")%></Excel:td>
			<Excel:td width="100"><%=record.get("BALANCE_TIME")%></Excel:td>
			<Excel:td width="100"><%=record.get("PERSONAL_PAY")%></Excel:td>
		</Excel:tr>
		<%
			}
		%>
	</Excel:table>
</Excel:tablelist>