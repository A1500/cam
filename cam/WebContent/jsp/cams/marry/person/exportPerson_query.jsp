<%@ page contentType="charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ taglib uri="/tags/next-excel" prefix="excel"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="org.loushang.next.data.Record"%>
<%@page import="org.loushang.next.data.*"%>
<%@page import="java.util.*"%>
<%@page import="java.text.SimpleDateFormat"%>
<html>
	<head>
		<title>婚姻登记员名册</title>
		<next:ScriptManager/>
	</head>
<%
	SimpleDateFormat sdf=new SimpleDateFormat("yyyy年MM月dd日HH时mm分");
	String date=sdf.format(new Date());
	String name="婚姻登记员名册_"+date;
%>	
<excel:tablelist filename="<%=name%>">
	<excel:table sheetname="婚姻登记员名册">
		<excel:tr>
			<excel:td colspan="5" align="center">婚姻登记员名册</excel:td>
		</excel:tr>
		<excel:tr bgcolor="grey">
			<excel:td  align="center" rowspan="2" width="100">姓名</excel:td>
			<excel:td  align="center" rowspan="2" width="100">性别</excel:td>
			<excel:td  align="center" rowspan="2" width="100">年龄</excel:td>
			<excel:td  align="center" rowspan="2" width="150">身份证号</excel:td>
			<excel:td  align="center" rowspan="2" width="100">学历</excel:td>
			<excel:td  align="center" rowspan="2" width="100">政治面貌</excel:td>
			<excel:td  align="center" rowspan="2" width="200">工作单位</excel:td>
			<excel:td  align="center" rowspan="2" width="100">编制性质</excel:td>
			<excel:td  align="center" rowspan="2" width="100">职务</excel:td>
			<excel:td  align="center" rowspan="2" width="100">从事本职工作时间</excel:td>
			<excel:td  align="center" rowspan="2" width="100">资格证编号</excel:td>
			<excel:td  align="center" colspan="8" width="800">资格考试情况</excel:td>
			<excel:td  align="center" rowspan="2" width="100">离岗时间</excel:td>
			<excel:td  align="center" rowspan="2" width="100">岗位状态</excel:td>
			<excel:td  align="center" rowspan="2" width="100">离岗原因</excel:td>
		</excel:tr>
		<excel:tr bgcolor="grey">
			<excel:td  align="center" width="100">首次参加考试时间</excel:td>
			<excel:td  align="center" width="100">考试结果</excel:td>
			<excel:td  align="center" width="100">补考结果</excel:td>
			<excel:td  align="center" width="100">最近一次复考时间</excel:td>
			<excel:td  align="center" width="100">复考结果</excel:td>
			<excel:td  align="center" width="100">补考结果</excel:td>
			<excel:td  align="center" width="100">超期未参加考试自动失效时间</excel:td>
			<excel:td  align="center" width="100">上级撤销资格证时间</excel:td>
		</excel:tr>
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
				String edu ="";
				if("10".equals(record.get("CULTURE"))){
					edu="研究生";
				}else if("20".equals(record.get("CULTURE"))){
					edu="大学本科";
				}else if("30".equals(record.get("CULTURE"))){
					edu="大学专科和专科学校";
				}else if("40".equals(record.get("CULTURE"))){
					edu="中等专业学校或中等技术学校";
				}else if("50".equals(record.get("CULTURE"))){
					edu="技工学校";
				}else if("60".equals(record.get("CULTURE"))){
					edu="高中";
				}else if("70".equals(record.get("CULTURE"))){
					edu="初中";
				}else if("80".equals(record.get("CULTURE"))){
					edu="小学";
				}else if("90".equals(record.get("CULTURE"))){
					edu="文盲或半文盲";
				}
				String politics="";
				if("01".equals(record.get("POLITICS"))){
					politics="中国共产党党员";
				}else if("02".equals(record.get("POLITICS"))){
					politics="中国共产党预备党员";
				}else if("03".equals(record.get("POLITICS"))){
					politics="中国国民党革命委员会会员";
				}else if("04".equals(record.get("POLITICS"))){
					politics="中国民主同盟盟员";
				}else if("05".equals(record.get("POLITICS"))){
					politics="中国民主建国会会员";
				}else if("06".equals(record.get("POLITICS"))){
					politics="中国民主促进会会员";
				}else if("07".equals(record.get("POLITICS"))){
					politics="中国农工民主党党员";
				}else if("08".equals(record.get("POLITICS"))){
					politics="中国致公党党员";
				}else if("09".equals(record.get("POLITICS"))){
					politics="九三学社社员";
				}else if("10".equals(record.get("POLITICS"))){
					politics="台湾民主自治同盟盟员";
				}else if("11".equals(record.get("POLITICS"))){
					politics="无党派民主人士";
				}else if("12".equals(record.get("POLITICS"))){
					politics="群众";
				}
				String org ="";
				if("01".equals(record.get("ORGANIZATION"))){
					org="行政单位";
				}else if("02".equals(record.get("ORGANIZATION"))){
					org="参公管理事业单位";
				}else if("03".equals(record.get("ORGANIZATION"))){
					org="全额拨款事业单位";
				}
				String technical="";
				if("01".equals(record.get("TECHNICAL"))){
					technical="主任";
				}else if("02".equals(record.get("TECHNICAL"))){
					technical="副主任";
				}else if("03".equals(record.get("TECHNICAL"))){
					technical="登记员";
				}else if("04".equals(record.get("TECHNICAL"))){
					technical="颁证员";
				}else if("05".equals(record.get("TECHNICAL"))){
					technical="聘用社工";
				}else if("06".equals(record.get("TECHNICAL"))){
					technical="其他人员";
				}
				String ksjg="";
				if("01".equals(record.get("FIRST_JG"))){
					ksjg="合格";
				}else if("02".equals(record.get("FIRST_JG"))){
					ksjg="补考";
				}
				String bkjg="";
				if("01".equals(record.get("FIRST_BKJG"))){
					bkjg="合格";
				}else if("02".equals(record.get("FIRST_BKJG"))){
					bkjg="不合格";
				}
				String fkjg="";
				if("01".equals(record.get("LAST_JG"))){
					fkjg="合格";
				}else if("02".equals(record.get("LAST_JG"))){
					fkjg="补考";
				}
				String fkbkjg="";
				if("01".equals(record.get("LAST_BKJG"))){
					fkbkjg="合格";
				}else if("02".equals(record.get("LAST_BKJG"))){
					fkbkjg="不合格";
				}
				String gwzt="";
				if("01".equals(record.get("WORKSTATE"))){
					gwzt="在岗";
				}else if("02".equals(record.get("WORKSTATE"))){
					gwzt="离岗";
				}else if("03".equals(record.get("WORKSTATE"))){
					gwzt="待岗";
				}
				
		%>
		<excel:tr>
			<excel:td><%=record.get("NAME")%></excel:td>
			<excel:td><%=sex%></excel:td>
			<excel:td><%=record.get("AGE")%></excel:td>
			<excel:td><%=record.get("CARD_NO")%></excel:td>
			<excel:td><%=edu%></excel:td>
 			<excel:td><%=politics%></excel:td>
 			<excel:td><%=record.get("DEPT")%></excel:td>
 			<excel:td><%=org%></excel:td>
			<excel:td><%=technical%></excel:td>
			<excel:td><%=record.get("MARRY_START_DATE")%></excel:td>
			<excel:td><%=record.get("CERTIFICATE_ID")%></excel:td>
			<excel:td><%=record.get("FIRST_TIME")%></excel:td>
 			<excel:td><%=ksjg%></excel:td>
 			<excel:td><%=bkjg%></excel:td>
 			<excel:td><%=record.get("LAST_TIME")%></excel:td>
 			<excel:td><%=fkjg%></excel:td>
 			<excel:td><%=fkbkjg%></excel:td>
 			<excel:td><%=record.get("AUTOMATIC_FAILURE_TIME")%></excel:td>
 			<excel:td><%=record.get("BACKOUT_TIME")%></excel:td>
 			<excel:td><%=record.get("DEPARTURE_TIME")%></excel:td>
 			<excel:td><%=gwzt%></excel:td>
 			<excel:td><%=record.get("DEPARTURE_REASON")%></excel:td>
		</excel:tr>
		<%
			}
		%>
	</excel:table>
</excel:tablelist>

</html>