<%@ page contentType="charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ taglib uri="/tags/next-excel" prefix="excel"%>
<%@page import="org.loushang.next.data.DataSet"%>
<%@page import="org.loushang.next.data.Record"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date" %>
<%!

	SimpleDateFormat sdf=new SimpleDateFormat("yyyy年MM月dd日HH时mm分");
	String date=sdf.format(new Date());

String getTypeName(String type) {
	if("yl".equals(type)) {
		return "医疗救助困难户指数";
	} else if("cj".equals(type)) {
		return "残疾救助困难户指数";
	} else if("dq".equals(type)) {
		return "单亲救助困难户指数";
	} else if("jy".equals(type)) {
		return "教育救助困难户指数";
	} else if("jye".equals(type)) {
		return "就业救助困难户指数";
	} else if("sg".equals(type)) {
		return "事故救助困难户指数";
	} else if("ylao".equals(type)) {
		return "养老救助困难户指数";
	} else if("zhf".equals(type)) {
		return "住房救助困难户指数";
	} else if("zrzh".equals(type)) {
		return "自然灾害救助困难户指数";
	} else if("zh".equals(type)) {
		return "综合救助困难户指数";
	}
	return "";
}
String getColName(String type) {
	if("yl".equals(type)) {
		return "患病类型";
	} else if("cj".equals(type)) {
		return "残疾类型";
	} else if("dq".equals(type)) {
		return "";
	} else if("jy".equals(type)) {
		return "教育阶段";
	} else if("jye".equals(type)) {
		return "失业率";
	} else if("sg".equals(type)) {
		return "事故种类";
	} else if("ylao".equals(type)) {
		return "老人年龄";
	} else if("zhf".equals(type)) {
		return "住房类型";
	} else if("zrzh".equals(type)) {
		return "灾害种类";
	}
	return type;
}
String getJzfx(String type) {
	if("yl".equals(type)) {
		return "医疗";
	} else if("cj".equals(type)) {
		return "残疾";
	} else if("dq".equals(type)) {
		return "单亲";
	} else if("jy".equals(type)) {
		return "教育";
	} else if("jye".equals(type)) {
		return "失业";
	} else if("sg".equals(type)) {
		return "事故";
	} else if("ylao".equals(type)) {
		return "养老";
	} else if("zhf".equals(type)) {
		return "住房";
	} else if("zrzh".equals(type)) {
		return "自然灾害";
	}
	return type;

}
String n2b(String code) {
	return code==null?"":code;
}
String getContentByCode(Record record, String type) {
	if(type==null||"".equals(type)) return "";
	String code = "";
	String content = "";
	if("jzlx".equals(type)) {
		code = n2b((String)record.get("JZLX"));
		String[] codeArr = code.split(",");
		for(int i=0;i<codeArr.length;i++)
		content += (getContent("DIC_ASSITANCE_TYPE_EXT",codeArr[i])+";");
	} else if("yl".equals(type)) {
		code = n2b((String)record.get("CJXX"));
		content = getYlContent(code);
	} else if("cj".equals(type)) {
		code = n2b((String)record.get("CJXX"));
		content = getCjContent(code);
	} else if("dq".equals(type)) {
	} else if("jy".equals(type)) {
		code = n2b((String)record.get("JYXX"));
		content = getJyContent(code);
	} else if("jye".equals(type)) {
		code = n2b((String)record.get("JYZH"));
		content = getJyeContent(code);
	} else if("sg".equals(type)) {
		code = n2b((String)record.get("SGXX"));
		content = getSgContent(code);
	} else if("ylao".equals(type)) {
		code = n2b((String)record.get("HBXX"));
		content = getYlaoContent(code);
	} else if("zhf".equals(type)) {
		code = n2b((String)record.get("HOUSE_QUALITY"));
		content = getZhfContent(code);
	} else if("zrzh".equals(type)) {
		code = n2b((String)record.get("ZRZH"));
		content = getZrzhContent(code);
	}

	return content;
}
String getZrzhContent(String code) {
	if("".equals(code)) return "";
	String reContent = "";
	if("01".equals(code)) {
		reContent = "干旱；";
	} else if("02".equals(code)) {
		reContent = "暴雨洪涝；";
	} else if("03".equals(code)) {
		reContent = "飓风；";
	} else if("04".equals(code)) {
		reContent = "冰冻；";
	} else if("05".equals(code)) {
		reContent = "大雪；";
	} else if("06".equals(code)) {
		reContent = "冰雹；";
	} else if("07".equals(code)) {
		reContent = "地震；";
	} else if("08".equals(code)) {
		reContent = "泥石流；";
	} else if("09".equals(code)) {
		reContent = "病虫害；";
	} else if("10".equals(code)) {
		reContent = "火灾事故；";
	} else if("11".equals(code)) {
		reContent = "其他；";
	} else {
		reContent += code;
	}
	return reContent;
}
String getZhfContent(String code) {
	if("".equals(code)) return "";
	String reContent = "";
	String[] codeArr = code.split(",");
	
	for(int i=0;i<codeArr.length;i++) {
		if("100".equals(codeArr[i])) {
			reContent += "自有;";
		} else if("110".equals(codeArr[i])) {
			reContent += "商品房;";
		} else if("120".equals(codeArr[i])) {
			reContent += "经济适用房;";
		} else if("130".equals(codeArr[i])) {
			reContent += "单位福利房;";
		} else if("140".equals(codeArr[i])) {
			reContent += "拆迁安置房;";
		} else if("150".equals(codeArr[i])) {
			reContent += "自建住房;";
		} else if("160".equals(codeArr[i])) {
			reContent += "其他自有;";
		} else if("170".equals(codeArr[i])) {
			reContent += "房改房;";
		} else if("180".equals(codeArr[i])) {
			reContent += "帮建房;";
		} else if("200".equals(codeArr[i])) {
			reContent += "租赁;";
		} else if("210".equals(codeArr[i])) {
			reContent += "租赁私有;";
		} else if("220".equals(codeArr[i])) {
			reContent += "租赁公有;";
		} else if("221".equals(codeArr[i])) {
			reContent += "廉租房;";
		} else if("222".equals(codeArr[i])) {
			reContent += "其他租赁公有;";
		} else if("300".equals(codeArr[i])) {
			reContent += "借住;";
		} else if("900".equals(codeArr[i])) {
			reContent += "其他;";
		}else {
			reContent += code;
		}
	}
	return "".equals(reContent)?code:reContent;
}
String getYlaoContent(String code) {
	if("".equals(code)) return "";
	String reContent = "";
	return "".equals(reContent)?code:reContent;
}
String getSgContent(String code) {
	if("".equals(code)) return "";
	String reContent = "";
	String[] codeArr = code.split(",");
	for(int i=0;i<codeArr.length;i++) {
		if("1".equals(codeArr[i])) {
			reContent += "火灾事故;";
		} else if("2".equals(codeArr[i])) {
			reContent += "交通事故;";
		} else if("3".equals(codeArr[i])) {
			reContent += "生成事故;";
		} else if("4".equals(codeArr[i])) {
			reContent += "其他;";
		} else {
			reContent += code;
		}
	}
	return "".equals(reContent)?code:reContent;
}

String getJyeContent(String code) {
	if("".equals(code)) return "";
	String reContent = "";
	String[] codeArr = code.split(",");
	for(int i=0;i<codeArr.length;i++) {
		if("0".equals(codeArr[i])) {
			reContent += "0;";
		} else if("0.1".equals(codeArr[i])) {
			reContent += "10%;";
		} else if("0.2".equals(codeArr[i])) {
			reContent += "20%;";
		} else if("0.3".equals(codeArr[i])) {
			reContent += "30%;";
		} else if("0.4".equals(codeArr[i])) {
			reContent += "40%;";
		} else if("0.5".equals(codeArr[i])) {
			reContent += "50%;";
		} else if("0.6".equals(codeArr[i])) {
			reContent += "60%;";
		} else if("0.7".equals(codeArr[i])) {
			reContent += "70%;";
		} else if("0.8".equals(codeArr[i])) {
			reContent += "80%;";
		} else if("0.9".equals(codeArr[i])) {
			reContent += "90%;";
		} else if("1".equals(codeArr[i])) {
			reContent += "100%;";
		} else {
			reContent += code;
		}
	}
	return "".equals(reContent)?code:reContent;
}

String getJyContent(String code) {
	if("".equals(code)) return "";
	String reContent = "";
	String[] codeArr = code.split(",");
	for(int i=0;i<codeArr.length;i++) {
		if("1".equals(codeArr[i])) {
			reContent += "小学;";
		} else if("2".equals(codeArr[i])) {
			reContent += "初中;";
		} else if("3".equals(codeArr[i])) {
			reContent += "高中;";
		} else if("4".equals(codeArr[i])) {
			reContent += "大学专科;";
		} else if("5".equals(codeArr[i])) {
			reContent += "大学本科;";
		} else if("6".equals(codeArr[i])) {
			reContent += "研究生（及以上）;";
		} else if("7".equals(codeArr[i])) {
			reContent += "其他;";
		} else {
			reContent += code;
		}
	}
	return "".equals(reContent)?code:reContent;
}
String getCjContent(String code) {
	if("".equals(code)) return "";
	String reContent = "";
	String[] codeArr = code.split(",");
	for(int i=0;i<codeArr.length;i++) {
		if("1".equals(codeArr[i])) {
			reContent += "视力;";
		} else if("2".equals(codeArr[i])) {
			reContent += "听力;";
		} else if("3".equals(codeArr[i])) {
			reContent += "言语;";
		} else if("4".equals(codeArr[i])) {
			reContent += "智力;";
		} else if("5".equals(codeArr[i])) {
			reContent += "肢体;";
		} else if("6".equals(codeArr[i])) {
			reContent += "精神;";
		} else {
			reContent += code;
		}
	}
	return "".equals(reContent)?code:reContent;
}
String getYlContent(String code) {
	if("".equals(code)) return "";
	String reContent = "";
	String[] codeArr = code.split(",");
	for(int i=0;i<codeArr.length;i++) {
		if("01".equals(codeArr[i])) {
			reContent += "传染病;";
		} else if("02".equals(codeArr[i])) {
			reContent += "肿瘤;";
		} else if("03".equals(codeArr[i])) {
			reContent += "血液病;";
		} else if("04".equals(codeArr[i])) {
			reContent += "呼吸/消化系统疾病;";
		} else if("05".equals(codeArr[i])) {
			reContent += "皮肤病;";
		} else if("06".equals(codeArr[i])) {
			reContent += "神经病;";
		} else if("07".equals(codeArr[i])) {
			reContent += "心脑血管疾病;";
		} else if("08".equals(codeArr[i])) {
			reContent += "骨骼/肌肉系统疾病;";
		} else if("09".equals(codeArr[i])) {
			reContent += "免疫系统疾病;";
		} else if("10".equals(codeArr[i])) {
			reContent += "泌尿生殖系统疾病;";
		} else if("11".equals(codeArr[i])) {
			reContent += "其他;";
		} else {
			reContent += code;
		}
	}
	return "".equals(reContent)?code:reContent;
}
String getContent(String dmTable, String code) {
	if("".equals(code)) return "";
	String reContent = "";
	if("01".equals(code)) {
		reContent = "城市低保";
	} else if("02".equals(code)) {
		reContent = "农村低保";
	} else if("03".equals(code)) {
		reContent = "集中供养五保户";
	} else if("04".equals(code)) {
		reContent = "分散供养五保户";
	} else if("05".equals(code)) {
		reContent = "抚恤定补优抚对象";
	} else if("06".equals(code)) {
		reContent = "残疾人";
	} else if("07".equals(code)) {
		reContent = "单亲特困母亲";
	} else if("08".equals(code)) {
		reContent = "困难学生";
	} else if("09".equals(code)) {
		reContent = "城市“三无”对象";
	} else if("10".equals(code)) {
		reContent = "特困职工";
	} else if("11".equals(code)) {
		reContent = "其他";
	} else {
		reContent += code;
	}
	return reContent;
}
%>
<%
	String type = (String)request.getParameter("type");
	if(type==null) type="";
	String fileName = getTypeName(type);
	int colspan = "dq,zh".indexOf(type)==-1?9:8;
%>
<html>
	<head>
		<title>导出Excel</title>
		<next:ScriptManager/>
	</head>
	<excel:tablelist filename="<%=fileName+date %>">
		<excel:table sheetname="<%=fileName %>">
			<excel:tr>
				<excel:td colspan="<%=colspan %>" border="3" align="center"><excel:font size="15" bold="true"><%=fileName %></excel:font></excel:td>
			</excel:tr>
			<excel:tr bgcolor="grey">
				<excel:td border="3" width="64" align="center">户主姓名</excel:td>
				<excel:td border="3" width="112" align="center">身份证号</excel:td>
				<excel:td border="3" width="64" align="center">救助方向</excel:td>
				<excel:td border="3" width="64" align="right">人口数量</excel:td>
				<excel:td border="3" width="96" align="center">家庭成员</excel:td>
				<excel:td border="3" width="198" align="center">家庭地址</excel:td>
				<excel:td border="3" width="144" align="center">救助类型</excel:td>
				<%if("dq,zh".indexOf(type)==-1) { %>
				<excel:td border="3" width="96" align="center"><%=getColName(type) %></excel:td>
				<%} %>
				<excel:td border="3" width="64" align="right">救助指数</excel:td>
				<excel:td border="3" width="112" align="right">一年内受助情况(元/次)</excel:td>
			</excel:tr>
			<%
				DataSet dataset=(DataSet)request.getAttribute("dataset");
				for(int i=0;i<dataset.getCount();i++){
					Record record=dataset.getRecord(i);
			%>
			<excel:tr>
				<excel:td><%=record.get("HZXM")%></excel:td>
				<excel:td><%=record.get("SFZH")%></excel:td>
				<excel:td><%=getJzfx(type)%></excel:td>
				<excel:td><%=record.get("RK_SL")%></excel:td>
				<excel:td><%=record.get("JTCY")%></excel:td>
				<excel:td><%=record.get("JTDZ")%></excel:td>
	 			<excel:td><%=getContentByCode(record,"jzlx")%></excel:td>
				<%if("dq,zh".indexOf(type)==-1) { %>
	 			<excel:td><%=getContentByCode(record,type)%></excel:td>
				<%} %>
	 			<excel:td><%=record.get("JZZS_YL")%></excel:td>
	 			<excel:td><%=record.get("JZQK")%></excel:td>
			</excel:tr>
			<%
				}
			%>
		</excel:table>
	</excel:tablelist>
</html>