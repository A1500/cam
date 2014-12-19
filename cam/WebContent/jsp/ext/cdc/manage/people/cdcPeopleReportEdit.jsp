<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<html>
<head>
<title>社区人员信息填报</title>
<next:ScriptManager/>
<script type="text/javascript" src="cdcPeopleReportEdit.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript">
	var method='<%=request.getParameter("method")%>';
	var recordId='<%=request.getParameter("recordId")%>';
</script>
<jsp:include page="../util/cdcOrgan.jsp" flush="true"/>
</head>
<body>
<model:datasets>
	<model:dataset id="peopleReportDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcPeopleReportQueryCmd" >
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcPeopleReport"/>
	</model:dataset>
	<model:dataset id="seasonDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcPeopleInfoQueryCmd" method="getSeasons" autoLoad="true" >
		<model:record>
			<model:field name="SEASON" type="string"/>
		</model:record>
	</model:dataset>
	<model:dataset id="committeeDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcPeopleInfoQueryCmd" pageSize="-1">
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcPeopleInfo"/>
	</model:dataset>
	<model:dataset id="workerDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcPeopleInfoQueryCmd" pageSize="-1">
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcPeopleInfo"/>
	</model:dataset>
	<model:dataset id="reportWorkDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcReportWorkQueryCmd" method="getDic" global="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"/>
		<model:params>
			<model:param name="reportType" value='R08'/>
			<model:param name="organType" value='C'/>
		</model:params>
	</model:dataset>
	<!-- 人员类型 -->
	<model:dataset id="peopleTypeDataSet" enumName="CDC.PEOPLE_TYPE" autoLoad="true" global="true"/>
	<!-- 职务类型 -->
	<model:dataset id="dutyTypeDataSet" enumName="CDC.DUTY.TYPE" autoLoad="true" global="true"/>
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
<next:Panel width="99%" autoScroll="true">
<next:TopBar>
	<next:ToolBarItem symbol="->"/>
	<next:ToolBarItem iconCls="add" text="提取数据" id="backInsert" handler="forInsert"/>
	<next:ToolBarItem iconCls="save" text="保存" handler="save"/>
	<next:ToolBarItem iconCls="return" text="返回" handler="returnBack"/>
</next:TopBar>
<next:Html>
<form id="form1" method="post" dataset="peopleReportDataSet" onsubmit="return false" class="L5form">
<fieldset id="cdcFieldset">
<legend>填报情况</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel" style="width:12%">填报单位：</td>
			<td class="FieldInput" style="width:27%"><label field="organName"/></td>
			<td class="FieldLabel" style="width:13%">填报日期：</td>
			<td class="FieldInput" style="width:42%"><select id="reportDate" field="reportDate"><option dataset="reportWorkDataSet"/></select><font color="red">*</font></td>
		</tr>
	</table>
</fieldset>
<fieldset id="cdcFieldset">
<legend>经选举产生的社区居民委员会成员</legend>
	<table border="0"  width="100%" >
		   <tr>
				<td class="FieldLabel">总人数:</td>
				<td class="FieldInput"><label name="mbPeopleNum" field="mbPeopleNum"/></td>
				<td class="FieldLabel">女性人数:</td>
				<td class="FieldInput" colspan="3"><label name="mbFemaleNum" field="mbFemaleNum"/></td>
		   </tr>
		   <tr>
				<td class="FieldLabel" style="width:18%">30岁以下人数:</td>
				<td class="FieldInput" style="width:12%"><label name="mbThirtyNum" field="mbThirtyNum"/></td>
				<td class="FieldLabel" style="width:18%">31~40岁人数:</td>
				<td class="FieldInput" style="width:12%"><label name="mbFourtyNum" field="mbFourtyNum"  />  </td>
				<td class="FieldLabel" style="width:18%">41~50岁人数:</td>
				<td class="FieldInput" style="width:12%"><label name="mbFiftyNum" field="mbFiftyNum"  />  </td>
		   </tr>
		   <tr>
				<td class="FieldLabel">50岁以上人数:</td>
				<td class="FieldInput" colspan="5"><label name="mbSixtyNum" field="mbSixtyNum"  />  </td>
		   </tr>
		   <tr>
				<td class="FieldLabel">少数民族人数:</td>
				<td class="FieldInput"><label name="mbFolkNum" field="mbFolkNum"  />  </td>
				<td class="FieldLabel">交叉任职人数:</td>
				<td class="FieldInput" colspan="3"><label name="mbCrossNum" field="mbCrossNum"  />  </td>
		   </tr>
		   <tr>
		   		<td class="FieldLabel">党员人数:</td>
				<td class="FieldInput"><label name="mbPartyNum" field="mbPartyNum"  />  </td>
				<td class="FieldLabel">共青团员人数:</td>
				<td class="FieldInput"><label name="mbLeagueNum" field="mbLeagueNum"  />  </td>
				<td class="FieldLabel">其他政治面貌人数:</td>
				<td class="FieldInput"><label name="mbOtherNum" field="mbOtherNum"  />  </td>
		   </tr>
		   <tr>
				<td class="FieldLabel">初中及以下人数:</td>
				<td class="FieldInput"><label name="mbJuniorNum" field="mbJuniorNum"  />  </td>
				<td class="FieldLabel">高中及中专人数:</td>
				<td class="FieldInput"><label name="mbSeniorNum" field="mbSeniorNum"  />  </td>
				<td class="FieldLabel">大学专科人数:</td>
				<td class="FieldInput"><label name="mbSpecialtyNum" field="mbSpecialtyNum"  />  </td>
		   </tr>
		   <tr>		   
				<td class="FieldLabel">大学本科人数:</td>
				<td class="FieldInput"><label name="mbCollegeNum" field="mbCollegeNum"  />  </td>
				<td class="FieldLabel">研究生及以上人数:</td>
				<td class="FieldInput" colspan="3"><label name="mbGraduateNum" field="mbGraduateNum"  />  </td>
		   </tr>
		   <tr>
				<td class="FieldLabel">参加养老保险人数:</td>
				<td class="FieldInput"><label name="mbAgedInNum" field="mbAgedInNum"  />  </td>
				<td class="FieldLabel">参加医疗保险人数:</td>
				<td class="FieldInput"><label name="mbMedicalInNum" field="mbMedicalInNum"  />  </td>
				<td class="FieldLabel">参加失业保险人数:</td>
				<td class="FieldInput"><label name="mbUnemployInNum" field="mbUnemployInNum"  />  </td>
			</tr>
			<tr>
				<td class="FieldLabel">参加工伤保险人数:</td>
				<td class="FieldInput"><label name="mbInjuryInNum" field="mbInjuryInNum"  />  </td>
				<td class="FieldLabel">参加生育保险人数:</td>
				<td class="FieldInput"><label name="mbBirthInNum" field="mbBirthInNum"  />  </td>
				<td class="FieldLabel">参加住房公积金人数:</td>
				<td class="FieldInput"><label name="mbHousingReNum" field="mbHousingReNum"  />  </td>
			</tr>
		   	<tr>
				<td class="FieldLabel">人均月报酬:</td>
				<td class="FieldInput" colspan="5"><label name="mbSubsidyAvgMon" field="mbSubsidyAvgMon"  />&nbsp;元</td>
			</tr>
	 </table>
	   </fieldset>
	   <fieldset id="cdcFieldset">
	     <legend>其他社区工作者情况</legend>
		   <table width="100%">
		   <tr>
				<td class="FieldLabel">总人数:</td>
				<td class="FieldInput"><label name="wkPeopleNum" field="wkPeopleNum"  />  </td>
				<td class="FieldLabel">女性人数:</td>
				<td class="FieldInput" colspan="3"><label name="wkFemaleNum" field="wkFemaleNum"  />  </td>
			</tr>
		   <tr>
				<td class="FieldLabel" style="width:18%">30岁以下人数:</td>
				<td class="FieldInput" style="width:12%"><label name="wkThirtyNum" field="wkThirtyNum"  />  </td>
				<td class="FieldLabel" style="width:18%">31岁~40岁人数:</td>
				<td class="FieldInput" style="width:12%"><label name="wkFourtyNum" field="wkFourtyNum"  />  </td>
				<td class="FieldLabel" style="width:18%">41岁~50岁人数:</td>
				<td class="FieldInput" style="width:12%"><label name="wkFiftyNum" field="wkFiftyNum"  />  </td>
		   </tr>
		   <tr>
				<td class="FieldLabel">50岁以上人数:</td>
				<td class="FieldInput" colspan="5"><label name="wkSixtyNum" field="wkSixtyNum"  />  </td>
		   </tr>
		   <tr>
				<td class="FieldLabel">少数民族人数:</td>
				<td class="FieldInput" colspan="5"><label name="wkFolkNum" field="wkFolkNum"  />  </td>
		   </tr>
		   <tr>
				<td class="FieldLabel">党员人数:</td>
				<td class="FieldInput"><label name="wkPartyNum" field="wkPartyNum"  />  </td>
				<td class="FieldLabel">共青团员人数:</td>
				<td class="FieldInput"><label name="wkLeagueNum" field="wkLeagueNum"  />  </td>
				<td class="FieldLabel">其他政治面貌人数:</td>
				<td class="FieldInput"><label name="wkOtherNum" field="wkOtherNum"  />  </td>
		   </tr>
		   <tr>
				<td class="FieldLabel">初中及以下人数:</td>
				<td class="FieldInput"><label name="wkJuniorNum" field="wkJuniorNum"  />  </td>
				<td class="FieldLabel">高中及中专人数:</td>
				<td class="FieldInput"><label name="wkSeniorNum" field="wkSeniorNum"  />  </td>
				<td class="FieldLabel">大学专科人数:</td>
				<td class="FieldInput"><label name="wkSpecialtyNum" field="wkSpecialtyNum"  />  </td>
		   </tr>
		   <tr>
				<td class="FieldLabel">大学本科人数:</td>
				<td class="FieldInput"><label name="wkCollegeNum" field="wkCollegeNum"  />  </td>
				<td class="FieldLabel">研究生及以上人数:</td>
				<td class="FieldInput" colspan="3"><label name="wkGraduateNum" field="wkGraduateNum"  />  </td>
		   </tr>
		   <tr>
				<td class="FieldLabel">公务员人数:</td>
				<td class="FieldInput"><label name="wkOfficialNum" field="wkOfficialNum"  />  </td>
				<td class="FieldLabel">事业编人数:</td>
				<td class="FieldInput"><label name="wkEnterpriseNum" field="wkEnterpriseNum"  />  </td>
				<td class="FieldLabel">招聘人员数:</td>
				<td class="FieldInput"><label name="wkRequiredNum" field="wkRequiredNum"  />  </td>
		   </tr>
		   <tr>
				<td class="FieldLabel">企业职工人数:</td>
				<td class="FieldInput"><label name="wkCorporationNum" field="wkCorporationNum"  />  </td>
				<td class="FieldLabel">社区居民人数:</td>
				<td class="FieldInput"><label name="wkResideNum" field="wkResideNum"  />  </td>
				<td class="FieldLabel">其他身份人数:</td>
				<td class="FieldInput"><label name="wkProOtherNum" field="wkProOtherNum"  />  </td>
		   </tr>
		   <tr>
				<td class="FieldLabel">参加养老保险人数:</td>
				<td class="FieldInput"><label name="wkAgedInNum" field="wkAgedInNum"  />  </td>
				<td class="FieldLabel">参加医疗保险人数:</td>
				<td class="FieldInput"><label name="wkMedicalInNum" field="wkMedicalInNum"  />  </td>
				<td class="FieldLabel">参加失业保险人数:</td>
				<td class="FieldInput"><label name="wkUnemployInNum" field="wkUnemployInNum"  />  </td>
			</tr>
			<tr>
				<td class="FieldLabel">参加工伤保险人数:</td>
				<td class="FieldInput"><label name="wkInjuryInNum" field="wkInjuryInNum"  />  </td>
				<td class="FieldLabel">参加生育保险人数:</td>
				<td class="FieldInput"><label name="wkBirthInNum" field="wkBirthInNum"  />  </td>
				<td class="FieldLabel">参加住房公积金人数:</td>
				<td class="FieldInput"><label name="wkHousingReNum" field="wkHousingReNum"  />  </td>
			</tr>
		   <tr>
				<td class="FieldLabel">具备社会工作职业资格人数:</td>
				<td class="FieldInput"><label name="wkWorkerNum" field="wkWorkerNum"/>  </td>
				<td class="FieldLabel">人均月报酬:</td>
				<td class="FieldInput" colspan="3"><label name="wkSubsidyAvgMon" field="wkSubsidyAvgMon"  />&nbsp;元</td>
		   </tr>
		</table>
</form>
</next:Html>
</next:Panel>
<next:Window id="detailWin" title="选举届期" resizable="false" width="400" height="140" modal="true" closable="false" closeAction="hide" autoScroll="true">
<next:Panel>
<next:TopBar>
	<next:ToolBarItem symbol="->"/>
	<next:ToolBarItem iconCls="save" text="确定" handler="confirm"/>
</next:TopBar>
<next:Html>
<form id="form2" method="post"onsubmit="return false" class="L5form">
	<fieldset id="cdcFieldset">
		<legend>选举届期</legend>
		<table width="100%">
			<tr><td class="FieldLabel" style="width:16%">选举届期：</td>
			<td class="FieldInput" style="width:22%">
			<select id="season" ></select>
			</td></tr>
		</table>
	</fieldset>
</form>
</next:Html>
</next:Panel>

</next:Window>
</body>
</html>