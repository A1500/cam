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
	String name="基金会台帐_"+date;
	String username=GetBspInfo.getBspInfo(request).getUserName();
%>
</head>
<Excel:tablelist filename="<%=name %>">
	<Excel:table sheetname="基金会台帐">
		<Excel:tr>
			<Excel:td colspan="87" align="center" ><Excel:font size="15">基金会台帐</Excel:font></Excel:td>
		</Excel:tr>
		<Excel:tr>
			<Excel:td colspan="7" align="left">统计单位：<%= BspUtil.getOrganName()%></Excel:td>
		</Excel:tr>
		<Excel:tr height="30" bgcolor="grey" border="1">
			<Excel:td  align="center" width="50" rowspan="3" bordercolor="black">序号</Excel:td>
			<Excel:td  align="center" width="82" rowspan="3" bordercolor="black">登记时间</Excel:td>			
			<Excel:td  align="center" width="150" rowspan="3" bordercolor="black">登记部门</Excel:td>
			<Excel:td  align="center" width="100" rowspan="3" bordercolor="black">部门登记证号</Excel:td>
			<Excel:td  align="center" width="100" rowspan="3" bordercolor="black">组织机构代码</Excel:td>			
			<Excel:td  align="center" width="100" rowspan="3" bordercolor="black">部门交换码</Excel:td>		
			<Excel:td  align="center" width="150" rowspan="3" bordercolor="black">单位名称</Excel:td>			
			<Excel:td  align="center" width="82" rowspan="3" bordercolor="black">法定代表人</Excel:td>
			<Excel:td  align="center" width="150" rowspan="3" bordercolor="black">地址</Excel:td>
			<Excel:td  align="center" width="82" rowspan="3" bordercolor="black">邮编</Excel:td>			
			<Excel:td  align="center" width="150" rowspan="3" bordercolor="black">电话</Excel:td>
			<Excel:td  align="center" width="82" rowspan="3" bordercolor="black">行业分类代码</Excel:td>
			<Excel:td  align="center" width="82" rowspan="3" bordercolor="black">变动类型代码</Excel:td>			
			<Excel:td  align="center" width="82" rowspan="3" bordercolor="black">变动时间</Excel:td>		
			<Excel:td  align="center" width="82" rowspan="3" bordercolor="black">类型</Excel:td>			
			<Excel:td  align="center" width="82" rowspan="3" bordercolor="black">行业分类</Excel:td>
			<Excel:td  align="center" width="82" rowspan="3" bordercolor="black">分支机构</Excel:td>
			<Excel:td  align="center" width="103" rowspan="3" bordercolor="black">民间组织负责人数</Excel:td>			
			<Excel:td  align="center" width="82" bordercolor="black"></Excel:td>		
			<Excel:td  align="center" width="82" rowspan="3" bordercolor="black">年末从业人数</Excel:td>			
			<Excel:td  align="center" width="82" colspan="2" bordercolor="black"></Excel:td>
			<Excel:td  align="center" width="82" colspan="2" bordercolor="black">受教育程度</Excel:td>
			<Excel:td  align="center" width="82" colspan="2" bordercolor="black">职业资格水平</Excel:td>			
			<Excel:td  align="center" width="82" colspan="4" bordercolor="black">年龄结构</Excel:td>		
			<Excel:td  align="center" width="82" rowspan="3" bordercolor="black">执行会计制度</Excel:td>			
			<Excel:td  align="center" width="82" rowspan="3" bordercolor="black">固定资产原价</Excel:td>
			<Excel:td  align="center" width="82" rowspan="3" bordercolor="black">上年结余</Excel:td>
			<Excel:td  align="center" width="82" rowspan="3" bordercolor="black">本年折旧</Excel:td>			
			<Excel:td  align="center" width="82" rowspan="3" bordercolor="black">营业收入</Excel:td>			
			<Excel:td  align="center" width="82" rowspan="3" bordercolor="black">营业成本</Excel:td>
			<Excel:td  align="center" width="93" rowspan="3" bordercolor="black">营业税金及附加</Excel:td>
			<Excel:td  align="center" width="82" rowspan="3" bordercolor="black">销售费用</Excel:td>	
			<Excel:td  align="center" width="82" rowspan="3" bordercolor="black">管理费用</Excel:td>			
			<Excel:td  align="center" width="82" colspan="2" bordercolor="black"></Excel:td>
			<Excel:td  align="center" width="82" rowspan="3" bordercolor="black">财务费用</Excel:td>		
			<Excel:td  align="center" width="82" bordercolor="black"></Excel:td>
			<Excel:td  align="center" width="103" rowspan="3" bordercolor="black">公允价值变动收益</Excel:td>			
			<Excel:td  align="center" width="82" rowspan="3" bordercolor="black">投资收益</Excel:td>			
			<Excel:td  align="center" width="82" rowspan="3" bordercolor="black">营业利润</Excel:td>
			<Excel:td  align="center" width="82" rowspan="3" bordercolor="black">应付职工薪酬</Excel:td>
			<Excel:td  align="center" width="82" rowspan="3" bordercolor="black">本年收入合计</Excel:td>			
			<Excel:td  align="center" width="82" colspan="4" bordercolor="black"></Excel:td>
			<Excel:td  align="center" width="82" rowspan="3" bordercolor="black">本年支出合计</Excel:td>		
			<Excel:td  align="center" width="82" colspan="10" bordercolor="black"></Excel:td>
			<Excel:td  align="center" width="82" rowspan="3" bordercolor="black">收支结余</Excel:td>			
			<Excel:td  align="center" width="82" rowspan="3" bordercolor="black">经营税金</Excel:td>			
			<Excel:td  align="center" width="82" rowspan="3" bordercolor="black">本年费用合计</Excel:td>
			<Excel:td  align="center" width="82" colspan="10" bordercolor="black"></Excel:td>
			<Excel:td  align="center" width="82" rowspan="3" bordercolor="black">净资产变动额</Excel:td>	
			<Excel:td  align="center" width="150" rowspan="3" bordercolor="black">业务主管部门</Excel:td>			
			<Excel:td  align="center" width="82" rowspan="3" bordercolor="black">原始基金数额</Excel:td>			
			<Excel:td  align="center" width="93" rowspan="3" bordercolor="black">是否建立党组织</Excel:td>
			<Excel:td  align="center" width="93" rowspan="3" bordercolor="black">本年度募集资金</Excel:td>
			<Excel:td  align="center" width="93" rowspan="3" bordercolor="black">公益活动项目数</Excel:td>		
			<Excel:td  align="center" width="82" rowspan="3" bordercolor="black">年检时间</Excel:td>	
			<Excel:td  align="center" width="103" rowspan="3" bordercolor="black">本年捐赠现金收入</Excel:td>			
			<Excel:td  align="center" width="103" rowspan="3" bordercolor="black">本年捐赠实物折价</Excel:td>			
			<Excel:td  align="center" width="82" rowspan="3" bordercolor="black">会费收入</Excel:td>
			<Excel:td  align="center" width="150" rowspan="3" bordercolor="black">备注</Excel:td>
		</Excel:tr>
		<Excel:tr height="20" bgcolor="grey" border="1">
			<Excel:td  align="center" width="82" rowspan="2" bordercolor="black">女性</Excel:td>	
			<Excel:td  align="center" width="82" rowspan="2" bordercolor="black">其中：女</Excel:td>	
			<Excel:td  align="center" width="82" rowspan="2" bordercolor="black">中共党员人数</Excel:td>	
			<Excel:td  align="center" width="82" rowspan="2" bordercolor="black">大学专科人数</Excel:td>	
			<Excel:td  align="center" width="113" rowspan="2" bordercolor="black">大学本科及以上人数</Excel:td>	
			<Excel:td  align="center" width="113" rowspan="2" bordercolor="black">助理社会工作师人数</Excel:td>	
			<Excel:td  align="center" width="93" rowspan="2" bordercolor="black">社会工作师人数</Excel:td>	
			<Excel:td  align="center" width="93" rowspan="2" bordercolor="black">35岁及以下人数</Excel:td>	
			<Excel:td  align="center" width="93" rowspan="2" bordercolor="black">36岁至45岁人数</Excel:td>	
			<Excel:td  align="center" width="93" rowspan="2" bordercolor="black">46岁至55岁人数</Excel:td>	
			<Excel:td  align="center" width="93" rowspan="2" bordercolor="black">56岁及以上人数</Excel:td>	
			<Excel:td  align="center" width="82" rowspan="2" bordercolor="black">税金</Excel:td>	
			<Excel:td  align="center" width="82" rowspan="2" bordercolor="black">差旅费</Excel:td>	
			<Excel:td  align="center" width="82" rowspan="2" bordercolor="black">利息支出</Excel:td>	
			<Excel:td  align="center" width="82" rowspan="2" bordercolor="black">事业收入</Excel:td>	
			<Excel:td  align="center" width="82" rowspan="2" bordercolor="black">经营收入</Excel:td>	
			<Excel:td  align="center" width="82" rowspan="2" bordercolor="black">捐赠收入</Excel:td>	
			<Excel:td  align="center" width="82" rowspan="2" bordercolor="black">会费收入</Excel:td>	
			<Excel:td  align="center" width="82" rowspan="2" bordercolor="black">工资福利支出</Excel:td>	
			<Excel:td  align="center" width="93" rowspan="2" bordercolor="black">商品和服务支出</Excel:td>	
			<Excel:td  align="center" width="82" colspan="4" bordercolor="black"></Excel:td>	
			<Excel:td  align="center" width="123" rowspan="2" bordercolor="black">对个人和家庭补助支出</Excel:td>	
			<Excel:td  align="center" width="82" colspan="3" bordercolor="black"></Excel:td>	
			<Excel:td  align="center" width="82" rowspan="2" bordercolor="black">业务活动成本</Excel:td>	
			<Excel:td  align="center" width="82" colspan="4" bordercolor="black"></Excel:td>	
			<Excel:td  align="center" width="82" rowspan="2" bordercolor="black">管理费用</Excel:td>	
			<Excel:td  align="center" width="82" colspan="4" bordercolor="black"></Excel:td>	
		</Excel:tr>
		<Excel:tr height="20" bgcolor="grey" border="1">
			<Excel:td  align="center" width="82" bordercolor="black" >福利费</Excel:td>
			<Excel:td  align="center" width="82" bordercolor="black" >劳务费</Excel:td>			
			<Excel:td  align="center" width="82" bordercolor="black" >取暖费</Excel:td>
			<Excel:td  align="center" width="82" bordercolor="black" >差旅费</Excel:td>	
			<Excel:td  align="center" width="82" bordercolor="black" >助学金</Excel:td>
			<Excel:td  align="center" width="82" bordercolor="black" >抚恤金</Excel:td>	
			<Excel:td  align="center" width="82" bordercolor="black" >生活补助</Excel:td>
			<Excel:td  align="center" width="82" bordercolor="black" >人员费用</Excel:td>	
			<Excel:td  align="center" width="82" bordercolor="black" >日常费用</Excel:td>
			<Excel:td  align="center" width="82" bordercolor="black" >固定资产折旧</Excel:td>	
			<Excel:td  align="center" width="82" bordercolor="black" >税费</Excel:td>	
			<Excel:td  align="center" width="82" bordercolor="black" >人员费用</Excel:td>	
			<Excel:td  align="center" width="82" bordercolor="black" >日常费用</Excel:td>
			<Excel:td  align="center" width="82" bordercolor="black" >固定资产折旧</Excel:td>	
			<Excel:td  align="center" width="82" bordercolor="black" >税费</Excel:td>	
		</Excel:tr>
		<%
			DataSet ds = (DataSet)request.getAttribute("dataset");
				for(int i=0; i<ds.getCount(); i++) {
					Record rec = ds.getRecord(i);
					String busScope=(String)rec.get("BUS_SCOPE");
					if(busScope==null){
						busScope="";
					}
					if(busScope.equals("01")){
						busScope="工商";
					}else if(busScope.equals("02")){
						busScope="农业农村";
					}else if(busScope.equals("03")){
						busScope="自然科学";
					}else if(busScope.equals("04")){
						busScope="社会科学";
					}else if(busScope.equals("05")){
						busScope="教育";
					}else if(busScope.equals("06")){
						busScope="卫生";
					}else if(busScope.equals("07")){
						busScope="文化";
					}else if(busScope.equals("08")){
						busScope="体育";
					}else if(busScope.equals("09")){
						busScope="生态环境";
					}else if(busScope.equals("10")){
						busScope="慈善";
					}else if(busScope.equals("11")){
						busScope="法律";
					}else if(busScope.equals("12")){
						busScope="宗教";
					}else if(busScope.equals("13")){
						busScope="职业及从业";
					}else if(busScope.equals("14")){
						busScope="涉外";
					}else if(busScope.equals("15")){
						busScope="其他";
					}
		%>
		<Excel:tr border="1">
			<Excel:td align="center"><%=i+1%></Excel:td>
			<Excel:td align="center"><%=rec.get("REG_DATE")%></Excel:td>
			<Excel:td align="center"><%=rec.get("MORG_NAME")%></Excel:td>			
			<Excel:td align="center"><%=rec.get("SORG_CODE")%></Excel:td>
			<Excel:td align="center"><%=rec.get("ORGAN_CODE")%></Excel:td>
			<Excel:td align="center"><%=rec.get("")%></Excel:td>
			<Excel:td align="center"><%=rec.get("CN_NAME")%></Excel:td>
			<Excel:td align="center"><%=rec.get("LEGAL_PEOPLE")%></Excel:td>
			<Excel:td align="center"><%=rec.get("RESIDENCE")%></Excel:td>
			<Excel:td align="center"><%=rec.get("SORG_POST")%></Excel:td>
			<Excel:td align="center"><%=rec.get("SORG_PHONE")%></Excel:td>
			<Excel:td align="center"><%=rec.get("BUS_SCOPE")%></Excel:td>
			<Excel:td align="center"><%=rec.get("")%></Excel:td>
			<Excel:td align="center"><%=rec.get("")%></Excel:td>
			<Excel:td align="center"><%=rec.get("")%></Excel:td>
			<Excel:td align="center"><%=busScope%></Excel:td>
			<Excel:td align="center"><%=rec.get("BRANCH_COUNT")%></Excel:td>			
			<Excel:td align="center"><%=rec.get("DUTY_COUNT")%></Excel:td>
			<Excel:td align="center"><%=rec.get("DUTY_FEMALE_COUNT")%></Excel:td>
			<Excel:td align="center"><%=rec.get("ENGAGED_NUM")%></Excel:td>
			<Excel:td align="center"><%=rec.get("")%></Excel:td>
			<Excel:td align="center"><%=rec.get("PARTY_PRACTITIONER_NUM")%></Excel:td>
			<Excel:td align="center"><%=rec.get("")%></Excel:td>
			<Excel:td align="center"><%=rec.get("")%></Excel:td>
			<Excel:td align="center"><%=rec.get("")%></Excel:td>
			<Excel:td align="center"><%=rec.get("")%></Excel:td>
			<Excel:td align="center"><%=rec.get("")%></Excel:td>
			<Excel:td align="center"><%=rec.get("")%></Excel:td>
			<Excel:td align="center"><%=rec.get("")%></Excel:td>
			<Excel:td align="center"><%=rec.get("")%></Excel:td>
			<Excel:td align="center"><%=rec.get("")%></Excel:td>
			<Excel:td align="center"><%=rec.get("FA_PRIME_COST_E")%></Excel:td>
			<Excel:td align="center"><%=rec.get("FA_NET_VALUE_S")%></Excel:td>
			<Excel:td align="center"><%=rec.get("FA_ACCUMULATED_DEPRECIATION")%></Excel:td>
			<Excel:td align="center"><%=rec.get("INCOME_SUM_TY_SUM")%></Excel:td>
			<Excel:td align="center"><%=rec.get("COST_SUM_TY_SUM")%></Excel:td>
			<Excel:td align="center"><%=rec.get("TAXES_TY_SUM")%></Excel:td>
			<Excel:td align="center"><%=rec.get("")%></Excel:td>
			<Excel:td align="center"><%=rec.get("MANAGE_COST_TY_SUM")%></Excel:td>
			<Excel:td align="center"><%=rec.get("")%></Excel:td>
			<Excel:td align="center"><%=rec.get("")%></Excel:td>
			<Excel:td align="center"><%=rec.get("")%></Excel:td>
			<Excel:td align="center"><%=rec.get("")%></Excel:td>
			<Excel:td align="center"><%=rec.get("")%></Excel:td>
			<Excel:td align="center"><%=rec.get("INV_INCOME_TY_SUM")%></Excel:td>
			<Excel:td align="center"><%=rec.get("")%></Excel:td>
			<Excel:td align="center"><%=rec.get("COMM_EXP_PER")%></Excel:td>
			<Excel:td align="center"><%=rec.get("INCOME_SUM_TY_SUM")%></Excel:td>
			<Excel:td align="center"><%=rec.get("GOV_GRANTS_TY_SUM")%></Excel:td>
			<Excel:td align="center"><%=rec.get("")%></Excel:td>
			<Excel:td align="center"><%=rec.get("DONATION_INCOME_TY_SUM")%></Excel:td>
			<Excel:td align="center"><%=rec.get("DUES_INCOME_TY_SUM")%></Excel:td>
			<Excel:td align="center"><%=rec.get("COST_SUM_TY_SUM")%></Excel:td>
			<Excel:td align="center"><%=rec.get("COMM_EXP_PER")%></Excel:td>
			<Excel:td align="center"><%=rec.get("")%></Excel:td>
			<Excel:td align="center"><%=rec.get("")%></Excel:td>
			<Excel:td align="center"><%=rec.get("")%></Excel:td>
			<Excel:td align="center"><%=rec.get("")%></Excel:td>
			<Excel:td align="center"><%=rec.get("")%></Excel:td>
			<Excel:td align="center"><%=rec.get("")%></Excel:td>
			<Excel:td align="center"><%=rec.get("")%></Excel:td>
			<Excel:td align="center"><%=rec.get("")%></Excel:td>
			<Excel:td align="center"><%=rec.get("")%></Excel:td>
			<Excel:td align="center"><%=rec.get("ASSETS_CHANGE_TY_SUM")%></Excel:td>
			<Excel:td align="center"><%=rec.get("CL_TAS_PAYABLE_E")%></Excel:td>
			<Excel:td align="center"><%=rec.get("COST_SUM_TY_SUM")%></Excel:td>
			<Excel:td align="center"><%=rec.get("BUSINESS_COST_TY_SUM")%></Excel:td>
			<Excel:td align="center"><%=rec.get("STAFF_COST_TY_SUM")%></Excel:td>
			<Excel:td align="center"><%=rec.get("RUNNING_COST_TY_SUM")%></Excel:td>
			<Excel:td align="center"><%=rec.get("DEPRECIATION_ASSETS_TY_SUM")%></Excel:td>
			<Excel:td align="center"><%=rec.get("TAXES_TY_SUM")%></Excel:td>
			<Excel:td align="center"><%=rec.get("MANAGE_COST_TY_SUM")%></Excel:td>
			<Excel:td align="center"><%=rec.get("")%></Excel:td>
			<Excel:td align="center"><%=rec.get("")%></Excel:td>
			<Excel:td align="center"><%=rec.get("")%></Excel:td>
			<Excel:td align="center"><%=rec.get("")%></Excel:td>
			<Excel:td align="center"><%=rec.get("ASSETS_CHANGE_TY_SUM")%></Excel:td>
			<Excel:td align="center"><%=rec.get("BORG_NAME")%></Excel:td>
			<Excel:td align="center"><%=rec.get("REG_MON")%></Excel:td>
			<Excel:td align="center"><%=rec.get("IF_BUILD_PARTY")%></Excel:td>
			<Excel:td align="center"><%=rec.get("CURRENT_MONEY")%></Excel:td>
			<Excel:td align="center"><%=rec.get("ACTIVITY_NUM")%></Excel:td>
			<Excel:td align="center"><%=rec.get("CHECK_TIME")%></Excel:td>
			<Excel:td align="center"><%=rec.get("CURRENT_MONEY")%></Excel:td>
			<Excel:td align="center"><%=rec.get("CURRENT_PRACTICALI")%></Excel:td>
			<Excel:td align="center"><%=rec.get("DUES_INCOME_TY_SUM")%></Excel:td>
			<Excel:td align="center"></Excel:td>
		</Excel:tr>
		<%
			}
		%>
		<Excel:tr>
			<Excel:td colspan="7" align="left">制表人：<%= username%></Excel:td>
			<Excel:td colspan="80" align="right">制表时间：<%= date2%></Excel:td>
		</Excel:tr>
	</Excel:table>
</Excel:tablelist>

