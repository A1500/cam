<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<title>农村民主决策列表</title>
<next:ScriptManager/>
<script type="text/javascript" src="vcdcPeopleReportList.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<jsp:include page="../util/cdcOrgan.jsp" flush="true"/>
<jsp:include page="../util/cdcReportNotice.jsp" flush="true"/>
</head>
<body>
<model:datasets>
	<model:dataset id="peopleReportDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcPeopleReportQueryCmd" pageSize="20">
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcPeopleReport"/>
	</model:dataset>
	
	<model:dataset id="queryDs" cmd="com.inspur.cams.cdc.base.cmd.CdcPeopleReportQueryCmd" pageSize="-1">
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcPeopleReport"/>
	</model:dataset>
	<model:dataset id="insertDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcReportWorkQueryCmd" method="getDic" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"/>
		<model:params>
			<model:param name="reportType" value='R08'/>
			<model:param name="organType" value='N'/>
		</model:params>
	</model:dataset>
	<model:dataset id="reportWorkDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcReportWorkQueryCmd" method="getDic" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"/>
		<model:params>
			<model:param name="reportType" value='R08'/>
		</model:params>
	</model:dataset>
	<model:dataset id="OrgCodeDataset"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="false">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='COM_EXT_USER'></model:param>
			<model:param name="value" value='USER_ID'></model:param>
			<model:param name="text" value='AREA_CODE'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="statusDataSet" enumName="CDC.STATUS" autoLoad="true" global="true"/>
</model:datasets>
<next:Panel width="100%" border="0">
	<next:Html>
	<fieldset style="overflow:visible;" class="GroupBox">
	<legend class="GroupBoxTitle">查询条件</legend>
		<form class="L5form">
			<table border="1" width="100%">
				<tr>
					<td class="FieldLabel" style="width:10%">填报日期：</td>
					<td class="FieldInput" style="width:12%"><select id="reportDate"  ><option dataset="reportWorkDataSet"/></select></td>
					<td class="FieldLabel" style="width:10%">填报状态：</td>
					<td class="FieldInput" style="width:12%"><select id="status" field="status"><option dataset="statusDataSet"/></select></td>
					<td class="FieldInput" style="width:37%"><button onclick="query()">查询</button>&nbsp;&nbsp;&nbsp;&nbsp;<button type="reset">重置</button></td>
				</tr>
			</table>
		</form>
	</fieldset>
	</next:Html>
</next:Panel>
<next:EditGridPanel id="grid" dataset="peopleReportDataSet" width="100%" stripeRows="true" height="99.9%">
	<next:TopBar>
		<next:ToolBarItem symbol="->"/>
		<next:ToolBarItem id="sum1" iconCls="add" text="汇总" handler="sumInsert"/>
		<next:ToolBarItem id="sum2" iconCls="undo" text="重新汇总" handler="sumRedo"/>
		<next:ToolBarItem id="sum3" iconCls="detail" text="明细" handler="sumDetail"/>
		<next:ToolBarItem id="detail1" iconCls="add" text="填报" handler="insert"/>
		<next:ToolBarItem id="detail2" iconCls="edit" text="修改" handler="update"/>
		<next:ToolBarItem id="detail3" iconCls="detail" text="明细" handler="detail"/>
		<next:ToolBarItem id="export" iconCls="export" text="导出Excel" handler="exportExcel"/>
		<next:ToolBarItem iconCls="upload" text="上报" handler="report"/>
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn/>
		<next:RadioBoxColumn/>
		<next:Column id="organName" header="填报单位名称" field="organName" width="90" renderer="statusListRender"/>
		<next:Column id="mbPeopleNum" header="总人数" field="mbPeopleNum" width="90" />
		<next:Column id="mbFemaleNum" header="女性人数" field="mbFemaleNum" width="90" />
		<next:Column id="mbThirtyNum" header="30岁以下人数" field="mbThirtyNum" width="90" />
		<next:Column id="mbFourtyNum" header="31岁~40岁人数" field="mbFourtyNum" width="90" />
		<next:Column id="mbFiftyNum" header="41岁~50岁人数" field="mbFiftyNum" width="90" />
		<next:Column id="mbSixtyNum" header="50岁以上人数" field="mbSixtyNum" width="90" />
		<next:Column id="mbFolkNum" header="少数民族人数" field="mbFolkNum" width="90" />
		<next:Column id="mbCrossNum" header="交叉任职人数" field="mbCrossNum" width="90" />
		<next:Column id="mbPartyNum" header="党员人数" field="mbPartyNum" width="90" />
		<next:Column id="mbLeagueNum" header="共青团员人数" field="mbLeagueNum" width="90" />
		<next:Column id="mbOtherNum" header="其他政治面貌人数" field="mbOtherNum" width="110" />
		<next:Column id="mbJuniorNum" header="初中及以下人数" field="mbJuniorNum" width="90" />
		<next:Column id="mbSeniorNum" header="高中及中专人数" field="mbSeniorNum" width="90" />
		<next:Column id="mbSpecialtyNum" header="大学专科人数" field="mbSpecialtyNum" width="90" />
		<next:Column id="mbCollegeNum" header="大学本科人数" field="mbCollegeNum" width="90" />
		<next:Column id="mbGraduateNum" header="研究生及以上人数" field="mbGraduateNum" width="110" />
		<next:Column id="mbAgedInNum" header="养老保险人数" field="mbAgedInNum" width="90" />
		<next:Column id="mbMedicalInNum" header="医疗保险人数" field="mbMedicalInNum" width="90" />
		<next:Column id="mbUnemployInNum" header="失业保险人数" field="mbUnemployInNum" width="90" />
		<next:Column id="mbInjuryInNum" header="工伤保险人数" field="mbInjuryInNum" width="90" />
		<next:Column id="mbBirthInNum" header="生育保险人数" field="mbBirthInNum" width="90" />
		<next:Column id="mbHousingReNum" header="住房公积金人数" field="mbHousingReNum" width="90" />
		<next:Column id="mbOfficalNum" header="大学生村官人数" field="mbOfficalNum" width="90" />
		<next:Column id="mbSubsidyAvgMon" header="人均月报酬" field="mbSubsidyAvgMon" width="90" />
		<next:Column id="wkPeopleNum" header="总人数" field="wkPeopleNum" width="90" />
		<next:Column id="wkFemaleNum" header="女性人数" field="wkFemaleNum" width="90" />
		<next:Column id="wkThirtyNum" header="30岁以下人数" field="wkThirtyNum" width="90" />
		<next:Column id="wkFourtyNum" header="31岁~40岁人数" field="wkFourtyNum" width="90" />
		<next:Column id="wkFiftyNum" header="41岁~50岁人数" field="wkFiftyNum" width="90" />
		<next:Column id="wkSixtyNum" header="50岁以上人数" field="wkSixtyNum" width="90" />
		<next:Column id="wkFolkNum" header="少数民族人数" field="wkFolkNum" width="90" />
		<next:Column id="wkPartyNum" header="党员人数" field="wkPartyNum" width="90" />
		<next:Column id="wkLeagueNum" header="共青团员人数" field="wkLeagueNum" width="90" />
		<next:Column id="wkOtherNum" header="其他政治面貌人数" field="wkOtherNum" width="110" />
		<next:Column id="wkJuniorNum" header="初中及以下人数" field="wkJuniorNum" width="90" />
		<next:Column id="wkSeniorNum" header="高中及中专人数" field="wkSeniorNum" width="90" />
		<next:Column id="wkSpecialtyNum" header="大学专科人数" field="wkSpecialtyNum" width="90" />
		<next:Column id="wkCollegeNum" header="大学本科人数" field="wkCollegeNum" width="90" />
		<next:Column id="wkGraduateNum" header="研究生及以上人数" field="wkGraduateNum" width="110" />
		<next:Column id="wkOfficialNum" header="公务员人数" field="wkOfficialNum" width="90" />
		<next:Column id="wkEnterpriseNum" header="事业编人数" field="wkEnterpriseNum" width="90" />
		<next:Column id="wkRequiredNum" header="招聘人员数" field="wkRequiredNum" width="90" />
		<next:Column id="wkCorporationNum" header="企业职工人数" field="wkCorporationNum" width="90" />
		<next:Column id="wkResideNum" header="社区居民人数" field="wkResideNum" width="90" />
		<next:Column id="wkProOtherNum" header="其他身份人数" field="wkProOtherNum" width="90" />
		<next:Column id="wkAgedInNum" header="养老保险人数" field="wkAgedInNum" width="90" />
		<next:Column id="wkMedicalInNum" header="医疗保险人数" field="wkMedicalInNum" width="90" />
		<next:Column id="wkUnemployInNum" header="失业保险人数" field="wkUnemployInNum" width="90" />
		<next:Column id="wkInjuryInNum" header="工伤保险人数" field="wkInjuryInNum" width="90" />
		<next:Column id="wkBirthInNum" header="生育保险人数" field="wkBirthInNum" width="90" />
		<next:Column id="wkHousingReNum" header="住房公积金人数" field="wkHousingReNum" width="90" />
		<next:Column id="wkWorkerNum" header="具备社会工作职业资格人数" field="wkWorkerNum" width="90" />
		<next:Column id="wkSubsidyAvgMon" header="人均月报酬" field="wkSubsidyAvgMon" width="90" />
		<next:Column id="reportDate" header="填报日期" field="reportDate" width="90" align="center" editable="false" sortable="true" ><next:ComboBox dataset="reportWorkDataSet"/></next:Column>
		<next:Column id="status" header="上报状态" field="status" width="90" align="center" editable="false" sortable="true"><next:ComboBox dataset="statusDataSet"/></next:Column>
		<next:Column id="submitDate" header="上报日期" field="submitDate" width="100" sortable="true" align="center" />
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="peopleReportDataSet"/>
	</next:BottomBar>
	<next:ExtendConfig>
	   		plugins:new L5.ux.grid.ColumnHeaderGroup({
        		rows: [
        			  [{header:'',start:0,colspan:3},{header:'经选举产生的社区村民委员会成员',start:3,colspan:24},{header:'其他社区工作者情况',start:25,colspan:29},{header:'',start:52,colspan:3}]
    		]})
	</next:ExtendConfig>
</next:EditGridPanel>
</body>
</html>