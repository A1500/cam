<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<title>农村人员信息明细</title>
<next:ScriptManager/>
</head>
<body>
<model:datasets>
	<model:dataset id="peopleReportDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcPeopleReportQueryCmd" pageSize="20">
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcPeopleReport"/>
	</model:dataset>
	<model:dataset id="peopleInfoDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcPeopleInfoQueryCmd" pageSize="20">
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcPeopleInfo"/>
	</model:dataset>
	<model:dataset id="reportWorkDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcReportWorkQueryCmd" method="getDic" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"/>
		<model:params>
			<model:param name="reportType" value='R08'/>
			<model:param name="organType" value='N'/>
		</model:params>
	</model:dataset>
	<!-- 人员类型 -->
	<model:dataset id="peopleTypeDataSet" enumName="CDC.PEOPLE_TYPE" autoLoad="true" global="true"/>
	<!-- 民族 -->
	<model:dataset id="NationDataset"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_NATION'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 是否 -->
	<model:dataset id="YNDataSet" enumName="COMM.YESORNO" autoLoad="true" global="true"/>
	<!-- 政治面貌 -->
	<model:dataset id="politicalDataSet" enumName="CDC.POLITICAL" autoLoad="true" global="true"/>
	<!-- 文化程度 -->
	<model:dataset id="educationDataSet" enumName="CDC.EDUCATION" autoLoad="true" global="true"/>
	<!-- 身份 -->
	<model:dataset id="identityDataSet" enumName="CDC.IDENTITY" autoLoad="true" global="true"/>
	<!-- 性别 -->
	<model:dataset id="sexDataSet" enumName="COMM.SEX" autoLoad="true" global="true"/>
</model:datasets>
<next:Panel width="100%" autoScroll="true">
<next:TopBar>
	<next:ToolBarItem symbol="->"/>
	<next:ToolBarItem iconCls="return" text="返回" handler="returnBack"/>
</next:TopBar>
<next:Html>
<form id="form1" method="post" dataset="peopleReportDataSet" onsubmit="return false" class="L5form">
<fieldset id="cdcFieldset">
<legend>填报情况</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel">填报单位：</td>
			<td class="FieldInput" colspan="3"><label field="organName"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:20%">填报日期：</td>
			<td class="FieldInput" style="width:33%"><label field="reportDate" dataset="reportWorkDataSet"/></td>
			<td class="FieldLabel" style="width:20%">上报日期：</td>
			<td class="FieldInput" ><label field="submitDate"/></td>
		</tr>
	</table>
</fieldset>
<fieldset id="cdcFieldset">
<legend>经选举产生的社区村民委员会成员</legend>
	<table border="0"  width="100%" >
		   <tr>
				<td class="FieldLabel">总人数:</td>
				<td class="FieldInput"><label name="mbPeopleNum" field="mbPeopleNum" renderer="peRender" />  </td>
				<td class="FieldLabel">女性人数:</td>
				<td class="FieldInput" colspan="3"><label name="mbFemaleNum" field="mbFemaleNum" renderer="peRender" />  </td>
		   </tr>
		   <tr>
				<td class="FieldLabel" style="width:18%">30岁以下人数:</td>
				<td class="FieldInput" style="width:12%"><label name="mbThirtyNum" field="mbThirtyNum" renderer="peRender" />  </td>
				<td class="FieldLabel" style="width:18%">31~40岁人数:</td>
				<td class="FieldInput" style="width:12%"><label name="mbFourtyNum" field="mbFourtyNum" renderer="peRender" />  </td>
				<td class="FieldLabel" style="width:18%">41~50岁人数:</td>
				<td class="FieldInput" style="width:12%"><label name="mbFiftyNum" field="mbFiftyNum" renderer="peRender" />  </td>
		   </tr>
		   <tr>
				<td class="FieldLabel">50岁以上人数:</td>
				<td class="FieldInput" colspan="5"><label name="mbSixtyNum" field="mbSixtyNum" renderer="peRender" />  </td>
		   </tr>
		   <tr>
				<td class="FieldLabel">少数民族人数:</td>
				<td class="FieldInput"><label name="mbFolkNum" field="mbFolkNum" renderer="peRender" />  </td>
				<td class="FieldLabel">交叉任职人数:</td>
				<td class="FieldInput" colspan="3"><label name="mbCrossNum" field="mbCrossNum" renderer="peRender" />  </td>
		  	</tr>
		   	<tr>
				<td class="FieldLabel">党员人数:</td>
				<td class="FieldInput"><label name="mbPartyNum" field="mbPartyNum" renderer="peRender" />  </td>
				<td class="FieldLabel">共青团员人数:</td>
				<td class="FieldInput"><label name="mbLeagueNum" field="mbLeagueNum" renderer="peRender" />  </td>
				<td class="FieldLabel">其他政治面貌人数:</td>
				<td class="FieldInput"><label name="mbOtherNum" field="mbOtherNum" renderer="peRender" />  </td>
		   </tr>
		   <tr>
				<td class="FieldLabel">初中及以下人数:</td>
				<td class="FieldInput"><label name="mbJuniorNum" field="mbJuniorNum" renderer="peRender" />  </td>
				<td class="FieldLabel">高中及中专人数:</td>
				<td class="FieldInput"><label name="mbSeniorNum" field="mbSeniorNum" renderer="peRender" />  </td>
				<td class="FieldLabel">大学专科人数:</td>
				<td class="FieldInput"><label name="mbSpecialtyNum" field="mbSpecialtyNum" renderer="peRender" />  </td>
		   </tr>
		   <tr>
				<td class="FieldLabel">大学本科人数:</td>
				<td class="FieldInput"><label name="mbCollegeNum" field="mbCollegeNum" renderer="peRender" />  </td>
				<td class="FieldLabel">研究生及以上人数:</td>
				<td class="FieldInput" colspan="3"><label name="mbGraduateNum" field="mbGraduateNum" renderer="peRender" />  </td>
		   </tr>
		   <tr>
				<td class="FieldLabel">参加养老保险人数:</td>
				<td class="FieldInput"><label name="mbAgedInNum" field="mbAgedInNum" renderer="peRender" />  </td>
				<td class="FieldLabel">参加医疗保险人数:</td>
				<td class="FieldInput"><label name="mbMedicalInNum" field="mbMedicalInNum" renderer="peRender" />  </td>
				<td class="FieldLabel">参加失业保险人数:</td>
				<td class="FieldInput"><label name="mbUnemployInNum" field="mbUnemployInNum" renderer="peRender" />  </td>
			</tr>
			<tr>
				<td class="FieldLabel">参加工伤保险人数:</td>
				<td class="FieldInput"><label name="mbInjuryInNum" field="mbInjuryInNum" renderer="peRender" />  </td>
				<td class="FieldLabel">参加生育保险人数:</td>
				<td class="FieldInput"><label name="mbBirthInNum" field="mbBirthInNum" renderer="peRender" />  </td>
				<td class="FieldLabel">参加住房公积金人数:</td>
				<td class="FieldInput"><label name="mbHousingReNum" field="mbHousingReNum" renderer="peRender" />  </td>
			</tr>
		   	<tr>
				<td class="FieldLabel">大学生村官人数:</td>
				<td class="FieldInput"><label name="mbOfficalNum" field="mbOfficalNum" renderer="peRender" /></td>
				<td class="FieldLabel">人均月报酬:</td>
				<td class="FieldInput" colspan="3"><label name="mbSubsidyAvgMon" field="mbSubsidyAvgMon" renderer="mRender" /></td>
			</tr>
		   </table>
	   </fieldset>
	   <fieldset id="cdcFieldset">
	     <legend>其他社区工作者情况</legend>
		   <table width="100%">
		   <tr>
				<td class="FieldLabel">总人数:</td>
				<td class="FieldInput"><label name="wkPeopleNum" field="wkPeopleNum" renderer="peRender" />  </td>
				<td class="FieldLabel">女性人数:</td>
				<td class="FieldInput" colspan="3"><label name="wkFemaleNum" field="wkFemaleNum" renderer="peRender" />  </td>
			</tr>
		   <tr>
				<td class="FieldLabel" style="width:18%">30岁以下人数:</td>
				<td class="FieldInput" style="width:12%"><label name="wkThirtyNum" field="wkThirtyNum" renderer="peRender" />  </td>
				<td class="FieldLabel" style="width:18%">31岁~40岁人数:</td>
				<td class="FieldInput" style="width:12%"><label name="wkFourtyNum" field="wkFourtyNum" renderer="peRender" />  </td>
				<td class="FieldLabel" style="width:18%">41岁~50岁人数:</td>
				<td class="FieldInput" style="width:12%"><label name="wkFiftyNum" field="wkFiftyNum" renderer="peRender" />  </td>
		   </tr>
		   <tr>
				<td class="FieldLabel">50岁以上人数:</td>
				<td class="FieldInput" colspan="5"><label name="wkSixtyNum" field="wkSixtyNum" renderer="peRender" />  </td>
		   </tr>
		   <tr>
				<td class="FieldLabel">少数民族人数:</td>
				<td class="FieldInput" colspan="5"><label name="wkFolkNum" field="wkFolkNum" renderer="peRender" />  </td>
		   </tr>
		   <tr>
				<td class="FieldLabel">党员人数:</td>
				<td class="FieldInput"><label name="wkPartyNum" field="wkPartyNum" renderer="peRender" />  </td>
				<td class="FieldLabel">共青团员人数:</td>
				<td class="FieldInput"><label name="wkLeagueNum" field="wkLeagueNum" renderer="peRender" />  </td>
				<td class="FieldLabel">其他政治面貌人数:</td>
				<td class="FieldInput"><label name="wkOtherNum" field="wkOtherNum" renderer="peRender" />  </td>
		   </tr>
		   <tr>
				<td class="FieldLabel">初中及以下人数:</td>
				<td class="FieldInput"><label name="wkJuniorNum" field="wkJuniorNum" renderer="peRender" />  </td>
				<td class="FieldLabel">高中及中专人数:</td>
				<td class="FieldInput"><label name="wkSeniorNum" field="wkSeniorNum" renderer="peRender" />  </td>
				<td class="FieldLabel">大学专科人数:</td>
				<td class="FieldInput"><label name="wkSpecialtyNum" field="wkSpecialtyNum" renderer="peRender" />  </td>
		   </tr>
		   <tr>
				<td class="FieldLabel">大学本科人数:</td>
				<td class="FieldInput"><label name="wkCollegeNum" field="wkCollegeNum" renderer="peRender" />  </td>
				<td class="FieldLabel">研究生及以上人数:</td>
				<td class="FieldInput" colspan="3"><label name="wkGraduateNum" field="wkGraduateNum" renderer="peRender" />  </td>
		   </tr>
		   <tr>
				<td class="FieldLabel">公务员人数:</td>
				<td class="FieldInput"><label name="wkOfficialNum" field="wkOfficialNum" renderer="peRender" />  </td>
				<td class="FieldLabel">事业编人数:</td>
				<td class="FieldInput"><label name="wkEnterpriseNum" field="wkEnterpriseNum" renderer="peRender" />  </td>
				<td class="FieldLabel">招聘人员数:</td>
				<td class="FieldInput"><label name="wkRequiredNum" field="wkRequiredNum" renderer="peRender" />  </td>
		   </tr>
		   <tr>
				<td class="FieldLabel">企业职工人数:</td>
				<td class="FieldInput"><label name="wkCorporationNum" field="wkCorporationNum" renderer="peRender" />  </td>
				<td class="FieldLabel">社区居民人数:</td>
				<td class="FieldInput"><label name="wkResideNum" field="wkResideNum" renderer="peRender" />  </td>
				<td class="FieldLabel">其他身份人数:</td>
				<td class="FieldInput"><label name="wkProOtherNum" field="wkProOtherNum" renderer="peRender" />  </td>
		   </tr>
		   <tr>
				<td class="FieldLabel">参加养老保险人数:</td>
				<td class="FieldInput"><label name="wkAgedInNum" field="wkAgedInNum" renderer="peRender" />  </td>
				<td class="FieldLabel">参加医疗保险人数:</td>
				<td class="FieldInput"><label name="wkMedicalInNum" field="wkMedicalInNum" renderer="peRender" />  </td>
				<td class="FieldLabel">参加失业保险人数:</td>
				<td class="FieldInput"><label name="wkUnemployInNum" field="wkUnemployInNum" renderer="peRender" />  </td>
			</tr>
			<tr>
				<td class="FieldLabel">参加工伤保险人数:</td>
				<td class="FieldInput"><label name="wkInjuryInNum" field="wkInjuryInNum" renderer="peRender" />  </td>
				<td class="FieldLabel">参加生育保险人数:</td>
				<td class="FieldInput"><label name="wkBirthInNum" field="wkBirthInNum" renderer="peRender" />  </td>
				<td class="FieldLabel">参加住房公积金人数:</td>
				<td class="FieldInput"><label name="wkHousingReNum" field="wkHousingReNum" renderer="peRender" />  </td>
			</tr>
		   <tr>
				<td class="FieldLabel">具备社会工作职业资格人数:</td>
				<td class="FieldInput"><label name="wkWorkerNum" field="wkWorkerNum" renderer="peRender" /></td>
				<td class="FieldLabel">人均月报酬:</td>
				<td class="FieldInput" colspan="3"><label name="wkSubsidyAvgMon" field="wkSubsidyAvgMon" renderer="mRender" /></td>
		   </tr>
		</table>
</form>
</next:Html>
</next:Panel>
</body>
</html>
<script language="javascript">
function init(){
	var ds=L5.DatasetMgr.lookup("peopleReportDataSet");
	var peopleInfoDataSet=L5.DatasetMgr.lookup("peopleInfoDataSet");
	ds.setParameter("RECORD_ID@=",'<%=request.getParameter("recordId")%>');
	ds.load();
}
function returnBack(){
	history.go(-1);
}
function peRender(val){
	if(val!="")
	return val+" 人";
}
function mRender(val){
	if(val==''){
	return "0 元";
	}
	return val+" 元";
}
</script>