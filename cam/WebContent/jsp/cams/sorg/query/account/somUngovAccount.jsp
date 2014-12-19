<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<%@ page import="org.loushang.bsp.security.context.GetBspInfo"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.*"%>
<%@page import="org.loushang.next.data.DataSet"%>
<%@page import="org.loushang.next.data.Record" %>
<%
	SimpleDateFormat sdf=new SimpleDateFormat("yyyy年MM月dd日");
	String date=sdf.format(new Date());
	String username= GetBspInfo.getBspInfo(request).getUserName();
%>
<%!
	//是否为空
	String ifNull(String val){
		return val!=null?val:"";
	}
%>
<script>
	var organCode = '<%=BspUtil.getOrganCode()%>';
</script>
<html>
<head>
<next:ScriptManager />
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js") %>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript" src="somUngovAccount.js"></script>

<script language="javascript">
 	 //查询条件打开合并函数
	 function collapse(element){
		var fieldsetParent=L5.get(element).findParent("fieldset");
		if(element.expand==null||element.expand==true){
			fieldsetParent.getElementsByTagName("div")[0].style.display="none";
			element.src = '<%=SkinUtils.getImage(request, "groupbox_expand.gif")%>';
			element.expand=false;
		}else{
			fieldsetParent.getElementsByTagName("div")[0].style.display="";
			element.src = "<%=SkinUtils.getImage(request, "groupbox_collapse.gif")%>";
			element.expand =true;
		}
	}
</script>
</head>
<body>
<model:datasets>
	<model:dataset id="ds" cmd="com.inspur.cams.sorg.query.cmd.SomAccountQueryCmd" global="true" method="queryUngovAccount" autoLoad="false"   pageSize="15">
		<model:record fromBean="com.inspur.cams.sorg.query.data.SomUngovAccountQuery"></model:record>
	</model:dataset>
	<!-- 行业分类 -->
	<model:dataset id="busScopeSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_BUS_SCOPE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 社会组织种类 -->
	<model:dataset id="sorgKindSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_UNGOV_KIND'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="comm_yesorno" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
</model:datasets>
<next:ViewPort>
	<next:GridPanel id="accountGrid" name="accountGrid" width="100%" height="100%" title="民办非企业单位台帐" dataset="ds" enableScollGridView="true">
		<next:TopBar>
			<next:ToolBarItem symbol="->"></next:ToolBarItem>
			<next:ToolBarItem iconCls="add" text="导出EXCEL" handler="forExcel"></next:ToolBarItem>
		</next:TopBar>

		<next:Columns>
			<next:RowNumberColumn />
			<next:Column header="id" field="id" width="130" hidden="true"/>
			<next:Column header="登记时间" field="REG_DATE" width="130" />
			<next:Column header="登记部门" field="MORG_NAME" width="130" />
			<next:Column header="部门登记证号" field="SORG_CODE" width="130" />
			<next:Column header="组织机构代码" field="ORGAN_CODE" width="130" />
			<next:Column header="部门交换码" field="T1" width="130" />
			<next:Column header="单位名称" field="CN_NAME" width="130" />
			<next:Column header="法定代表人" field="LEGAL_PEOPLE" width="130" />
			<next:Column header="地址" field="RESIDENCE" width="130" />
			<next:Column header="邮编" field="SORG_POST" width="130" />
			<next:Column header="电话" field="SORG_PHONE" width="130" />
			<next:Column header="行业分类代码" field="BUS_SCOPE" width="130" />
			<next:Column header="变动类型代码" field="T2" width="130" />
			<next:Column header="变动时间" field="T3" width="130" />
			<next:Column header="分支机构" field="BRANCH_COUNT" width="130" />
			<next:Column header="民间组织负责人数" field="DUTY_COUNT" width="130" />
			<next:Column header="民间组织负责人数女" field="DUTY_FEMALE_COUNT" width="130" />
			<next:Column header="年末从业人数" field="ENGAGED_NUM" width="130" />

			<next:Column header="其中：女" field="T4" width="130" />
			<next:Column header="中共党员人数" field="PARTY_PRACTITIONER_NUM" width="130" />
			<next:Column header="大学专科人数" field="T5" width="130" />
			<next:Column header="大学本科及以上人数" field="T6" width="130" />

			<next:Column header="助理社会工作师人数" field="T7" width="130" />
			<next:Column header="社会工作师人数" field="T8" width="130" />

			<next:Column header="35岁及以下人数" field="T9" width="130" />
			<next:Column header="36岁至45岁人数" field="T10" width="130" />
			<next:Column header="46岁至55岁人数" field="T11" width="130" />
			<next:Column header="56岁及以上人数" field="T12" width="130" />
			<next:Column header="执行会计制度" field="T13" width="130" />

			<next:Column header="固定资产原价" field="FA_PRIME_COST_E" width="130" />
			<next:Column header="上年结余" field="FA_NET_VALUE_S" width="130" />
			<next:Column header="本年折旧" field="FA_ACCUMULATED_DEPRECIATION" width="130" />
			<next:Column header="营业收入" field="INCOME_SUM_TY_SUM" width="130" />
			<next:Column header="营业成本" field="COST_SUM_TY_SUM" width="130" />
			<next:Column header="营业税金及附加" field="TAXES_TY_SUM" width="130" />
			<next:Column header="销售费用" field="T14" width="130" />
			<next:Column header="管理费用" field="MANAGE_COST_TY_SUM" width="130" />
			<next:Column header="税金" field="T15" width="130" />
			<next:Column header="差旅费" field="T16" width="130" />
			<next:Column header="财务费用" field="T17" width="130" />
			<next:Column header="利息支出" field="T18" width="130" />
			<next:Column header="公允价值变动收益" field="T19" width="130" />
			<next:Column header="投资收益" field="INV_INCOME_TY_SUM" width="130" />
			<next:Column header="营业利润" field="T20" width="130" />
			<next:Column header="应付职工薪酬" field="COMM_EXP_PER" width="130" />

			<next:Column header="本年收入合计" field="INCOME_SUM_TY_SUM" width="130" />
			<next:Column header="事业收入" field="GOV_GRANTS_TY_SUM" width="130" />
			<next:Column header="经营收入" field="T21" width="130" />
			<next:Column header="捐赠收入" field="DONATION_INCOME_TY_SUM" width="130" />
			<next:Column header="会费收入" field="DUES_INCOME_TY_SUM" width="130" />

			<next:Column header="本年支出合计" field="COST_SUM_TY_SUM" width="130" />
			<next:Column header="工资福利支出" field="COMM_EXP_PER" width="130" />
			<next:Column header="商品和服务支出" field="T22" width="130" />
			<next:Column header="福利费" field="T23" width="130" />
			<next:Column header="劳务费" field="T24" width="130" />
			<next:Column header="取暖费" field="T25" width="130" />
			<next:Column header="差旅费" field="T26" width="130" />
			<next:Column header="对个人和家庭补助支出" field="T27" width="130" />
			<next:Column header="助学金" field="T28" width="130" />
			<next:Column header="抚恤金" field="T29" width="130" />
			<next:Column header="生活补助" field="T30" width="130" />
			<next:Column header="收支结余" field="ASSETS_CHANGE_TY_SUM" width="130" />
			<next:Column header="经营税金" field="CL_TAS_PAYABLE_E" width="130" />
			<next:Column header="本年费用合计" field="COST_SUM_TY_SUM" width="130" />

			<next:Column header="业务活动成本" field="BUSINESS_COST_TY_SUM" width="130" />
			<next:Column header="人员费用" field="STAFF_COST_TY_SUM" width="130" />
			<next:Column header="日常费用" field="RUNNING_COST_TY_SUM" width="130" />
			<next:Column header="固定资产折旧" field="DEPRECIATION_ASSETS_TY_SUM" width="130" />
			<next:Column header="税费" field="TAXES_TY_SUM" width="130" />

			<next:Column header="管理费用" field="MANAGE_COST_TY_SUM" width="130" />
			<next:Column header="人员费用" field="T31" width="130" />
			<next:Column header="日常费用" field="T32" width="130" />
			<next:Column header="固定资产折旧" field="T33" width="130" />
			<next:Column header="税费" field="T34" width="130" />

			<next:Column header="净资产变动额" field="ASSETS_CHANGE_TY_SUM" width="130" />
			<next:Column header="本年捐赠现金收入" field="CURRENT_MONEY" width="130" />
			<next:Column header="本年捐赠实物折价" field="CURRENT_PRACTICALI" width="130" />
			<next:Column header="会费收入" field="DUES_INCOME_TY_SUM" width="130" />
			<next:Column header="业务主管部门" field="BORG_NAME" width="130" />
			<next:Column header="开办资金" field="REG_MON" width="130" />
			<next:Column header="性质" field="SORG_KIND" width="130" />
			<next:Column header="是否新成立" field="IF_NEW_BUILD" width="130" />
			<next:Column header="是否建立党组织" field="IF_BUILD_PARTY" width="130" />
			<next:Column header="年检时间" field="CHECK_TIME" width="130" />
		</next:Columns>
		<next:BottomBar>
			<next:PagingToolBar dataset="ds" />
		</next:BottomBar>
	</next:GridPanel>
</next:ViewPort>
</body>
</html>
