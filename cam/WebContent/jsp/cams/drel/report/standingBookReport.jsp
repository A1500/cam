<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="com.inspur.cams.comm.util.BspUtil"%>
<%@page import="com.inspur.cams.comm.util.DicUtil"%>
<html>
<head>
<title>台账表列表</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="standingBookReport.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<%	
	String organCode=BspUtil.getCorpOrgan().getOrganCode();
	String organName=DicUtil.getTextValueFromDic("DIC_CITY","ID",organCode,"NAME");
%>
<script type="text/javascript">
	var organCode='<%=organCode%>';
	var organName='<%=organName%>';
</script>
</head>
<body>
<model:datasets> 
	<model:dataset id="ds" cmd="com.inspur.cams.drel.base.cmd.DrelStandingbookQueryCmd" method="queryInfo" global="true" pageSize="15">
	</model:dataset>

	<model:dataset id="dsprint" cmd="com.inspur.cams.drel.base.cmd.DrelStandingbookQueryCmd" global="true" pageSize="15">
	</model:dataset>
<!-- 是否-->
<model:dataset id="comm_yesorno" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
<!-- 性别 -->
<model:dataset id="sex" enumName="COMM.SEX"
	autoLoad="true" global="true"></model:dataset>
<!--民族 -->
<model:dataset id="dic_nation" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
	<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
	<model:params>
		<model:param name="dic" value='DIC_NATION'></model:param>
	</model:params>
</model:dataset>
<!--民族 -->
<model:dataset id="dic_bank" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
	<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
	<model:params>
		<model:param name="dic" value='DIC_BANK'></model:param>
	</model:params>
</model:dataset>
<!--享受保障类别 -->
<model:dataset id="dic_assistanceType" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
	<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
	<model:params>
		<model:param name="dic" value='DIC_ASSITANCE_TYPE'></model:param>
	</model:params>
</model:dataset>
</model:datasets>
<next:Panel width="100%" border="0">
	<next:Html>
	<fieldset style="overflow:visible;" class="GroupBox">
	<legend class="GroupBoxTitle">查询条件</legend>
		<form class="L5form">
			<table border="1" width="100%">
				<tr>
					<td class="FieldLabel" nowrap="nowrap" width="8%">地区</td>
						<td class="FieldInput" width="25%"><input type="text"
							id="domicileName" name="domicileName" readonly="readonly"
							style="width: 180px" /><img
							src="<%=SkinUtils.getImage(request, "l5/help.gif")%>"
							style="cursor: hand" onclick="func_ForDomicileSelect()" /> <input
							type="text" id="domicileCode" name="domicileCode"
							style="display: none" /></td>
					<td class="FieldButton" style="width:20%"><button onclick="query()">查询</button>&nbsp;&nbsp;&nbsp;&nbsp;<button type="reset">重置</button></td>
				</tr>
			</table>
		</form>
	</fieldset>
	</next:Html>
</next:Panel>
<next:GridPanel id="grid" dataset="ds" width="100%" stripeRows="true" height="99.9%">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="导出Excel" iconCls="chart"
					handler="exportExcel" id="exportExcel"></next:ToolBarItem>
	</next:TopBar>
	<next:Columns>
		<next:Column field="DOMICILE_CODE" header="地区" width="10%" hidden="true" sortable="false"/>
		<next:Column field="BEGIN_DATE" header="登记时间" width="10%" sortable="false"/>
		<next:Column field="CARD_NO" header="证件号码" width="10%" sortable="false"/>
		<next:Column field="FAMILY_NAME" header="户主姓名" width="10%" sortable="false"/>
		<next:Column field="FAMILY_CARD_NO" header="身份证号码" width="13%" sortable="false"/>
		<next:Column field="SEX" header="性别" width="10%" sortable="false" dataset="sex"/>
		<next:Column field="NATION" header="民族" width="10%" sortable="false" dataset="dic_nation"/>
		<next:Column field="ADDRESS" header="家庭住址" width="25%" sortable="false"/>
		<next:Column field="FAMILY_POSTCODE" header="邮编" width="10%" sortable="false"/>
		<next:Column field="FAMILY_PHONE" header="家庭电话" width="10%" sortable="false"/>
		<next:Column field="ASSISTANCE_TYPE" header="享受保障类别" width="10%" sortable="false" dataset="dic_assistanceType"/>
		<next:Column field="ASSISTANCE_PEOPLE_NUM" header="享受保障人数" width="10%" sortable="false"/>
		<next:Column field="WOMEN_NO" header="女性人数" width="10%" sortable="false"/>
		<next:Column field="DISABILITY_NO" header="残疾人数" width="10%" sortable="false"/>
		<next:Column field="ISTHREENO" header="三无人员" width="10%" sortable="false"/>
		<next:Column field="OLD_NO" header="老年人" width="10%" sortable="false"/>
		<next:Column field="INCUMBENCY_NO" header="在职人员" width="10%" sortable="false"/>
		<next:Column field="FLEXIBLE_NO" header="灵活就业" width="10%" sortable="false"/>
		<next:Column field="UNEMPLOYED_NO" header="登记失业" width="10%" sortable="false"/>
		<next:Column field="NOT_UNEMPLOYED_NO" header="未登记失业" width="10%" sortable="false"/>
		<next:Column field="STUDENT_NO" header="在校生" width="10%" sortable="false"/>
		<next:Column field="OTHER_NO" header="其他" width="10%" sortable="false"/>
		<next:Column field="ASSISTANCE_MONEY" header="户月保障金" width="10%" sortable="false"  renderer="formatNum"/>
		<next:Column field="MONTH_INCOME" header="月收入" width="10%" sortable="false" renderer="formatNum" />
		<next:Column field="LOW_STANDARDS" header="最低生活标准" width="10%" sortable="false" renderer="formatNum"/>
		<next:Column field="OTHERMONEY" header="金额二" width="10%" sortable="false" renderer="formatNum"/>
		<next:Column field="ASSISTANCE_CLASS_MONEY" header="金额三" width="10%" sortable="false" renderer="formatNum"/>
		<next:Column field="BANK" header="开户行" width="15%" sortable="false" dataset="dic_bank"/>
		<next:Column field="ACCOUNT_NUMBER" header="开户行账号" width="15%" sortable="false"/>
		<next:Column field="CHANGE_TYPE" header="变动种类" width="10%" sortable="false"/>
		<next:Column field="CHANGE_DATE" header="变动时间" width="10%" sortable="false"/>
		<next:Column field="IS_ENJOY" header="户主是否享受" width="10%" sortable="false" dataset="comm_yesorno"/>
		<next:Column field="P1_NAME" header="成员一姓名" width="10%" sortable="false"/>
		<next:Column field="P1_ID_CARD" header="成员一身份证号码" width="13%" sortable="false"/>
		<next:Column field="P2_NAME" header="成员二姓名" width="10%" sortable="false"/>
		<next:Column field="P2_ID_CARD" header="成员二身份证号码" width="13%" sortable="false"/>
		<next:Column field="P3_NAME" header="成员三姓名" width="10%" sortable="false"/>
		<next:Column field="P3_ID_CARD" header="成员三身份证号码" width="13%" sortable="false"/>
		<next:Column field="P4_NAME" header="成员四姓名" width="10%" sortable="false"/>
		<next:Column field="P4_ID_CARD" header="成员四身份证号码" width="13%" sortable="false"/>
		<next:Column field="P5_NAME" header="成员五姓名" width="10%" sortable="false"/>
		<next:Column field="P5_ID_CARD" header="成员五身份证号码" width="13%" sortable="false"/>
		<next:Column field="P6_NAME" header="成员六姓名" width="10%" sortable="false"/>
		<next:Column field="P6_ID_CARD" header="成员六身份证号码" width="13%" sortable="false"/>
		<next:Column field="P7_NAME" header="成员七姓名" width="10%" sortable="false"/>
		<next:Column field="P7_ID_CARD" header="成员七身份证号码" width="13%" sortable="false"/>
		<next:Column field="P8_NAME" header="成员八姓名" width="10%" sortable="false"/>
		<next:Column field="P8_ID_CARD" header="成员八身份证号码" width="13%" sortable="false"/>
		<next:Column field="P9_NAME" header="成员九姓名" width="10%" sortable="false"/>
		<next:Column field="P9_ID_CARD" header="成员九身份证号码" width="13%" sortable="false"/>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="ds"/>
	</next:BottomBar>
</next:GridPanel>
</body>
</html>