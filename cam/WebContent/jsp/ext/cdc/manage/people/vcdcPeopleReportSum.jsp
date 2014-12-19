<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<title>农村民主决策汇总</title>
<next:ScriptManager/>
<script type="text/javascript" src="vcdcPeopleReportSum.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript">
	var method='<%=request.getParameter("method")%>';
	var recordId='<%=request.getParameter("recordId")%>';
</script>
<jsp:include page="../util/cdcOrgan.jsp" flush="true"/>
<jsp:include page="../util/cdcSum.jsp" flush="true"/>
</head>
<body>
<model:datasets>
	<model:dataset id="sumDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcPeopleReportQueryCmd" pageSize="10">
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcPeopleReport"/>
	</model:dataset>
	<model:dataset id="detailDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcPeopleReportQueryCmd" pageSize="200">
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcPeopleReport"/>
		<model:params>
			<model:param name="REPORT_TYPE" value='N'/>
		</model:params>
	</model:dataset>
	<model:dataset id="cityDataSet" cmd="com.inspur.cams.comm.extuser.cmd.ComExtUserQueryCmd" method="getNongCunUser" pageSize="200">
		<model:record fromBean="com.inspur.cams.comm.extuser.data.ComExtUser"/>
	</model:dataset>
	<model:dataset id="reportWorkDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcReportWorkQueryCmd" method="getDic" global="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"/>
		<model:params>
			<model:param name="reportType" value='R08'/>
			<model:param name="organType" value='N'/>
		</model:params>
	</model:dataset>
	<model:dataset id="statusDataSet" enumName="CDC.STATUS" autoLoad="true" global="true"></model:dataset>
</model:datasets>
<next:Panel width="100%" border="0">
<next:TopBar>
	<next:ToolBarItem symbol="->"></next:ToolBarItem>
	<next:ToolBarItem id="sumButton" iconCls="save" text="汇总" handler="save"></next:ToolBarItem>
	<next:ToolBarItem iconCls="return" text="返回" handler="returnBack"></next:ToolBarItem>
</next:TopBar>
<next:Html>
	<fieldset style="overflow:visible;" class="GroupBox">
	<legend class="GroupBoxTitle">汇总情况</legend>
		<form id="form1" method="post" dataset="sumDataSet" onsubmit="return false" class="L5form">
			<table width="100%">
				<tr>
					<td class="FieldLabel" style="width:18%">填报单位：</td>
					<td class="FieldInput" style="width:36%"><label field="organName"/></td>
					<td class="FieldLabel" style="width:16%">填报日期：</td>
					<td class="FieldInput" style="width:30%"><select id="reportDate" field="reportDate" onchange="getData()"><option dataset="reportWorkDataSet"/></select><font color="red">*</font></td>
				</tr>
			</table>
		</form>
	</fieldset>
</next:Html>
</next:Panel>
<next:EditGridPanel id="grid" dataset="detailDataSet" width="100%" stripeRows="true" height="99.9%" hasSum="true">
	<next:TopBar>
		<next:ToolBarItem iconCls="return" text="返回上级" handler="getUp"/>
		<next:ToolBarItem symbol="->"/>
		<next:ToolBarItem iconCls="detail" text="明细" handler="detail"/>
		<next:ToolBarItem id="auditButton" iconCls="delete" text="驳回" handler="audit"/>
	</next:TopBar>
	<next:Columns>
		<next:RadioBoxColumn/>
	<next:Column id="organName" header="填报单位名称" field="organName" width="90" renderer="statusRender"/>
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
		<next:Column id="reportDate" header="填报日期" field="reportDate" width="90" align="center" editable="false" sortable="false" ><next:ComboBox dataset="reportWorkDataSet"/></next:Column>
		<next:Column id="status" header="上报状态" field="status" width="90" align="center" editable="false" sortable="false"><next:ComboBox dataset="statusDataSet"/></next:Column>
		<next:Column id="submitDate" header="上报日期" field="submitDate" width="100" align="center" />
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="detailDataSet"/>
	</next:BottomBar>
	<next:ExtendConfig>
	   		plugins:new L5.ux.grid.ColumnHeaderGroup({
        		rows: [
        			  [{header:'',start:0,colspan:3},{header:'经选举产生的社区村民委员会成员',start:3,colspan:24},{header:'其他社区工作者情况',start:25,colspan:28},{header:'',start:52,colspan:3}]
    		]})
	</next:ExtendConfig>
</next:EditGridPanel>

<next:Window id="detailWin" title="明细" resizable="false" width="800" height="400" modal="true" closeAction="hide" autoScroll="true">
	<next:Panel height="860">
		<next:Html>
			<form id="form1" method="post" dataset="detailDataSet" onsubmit="return false" class="L5form">
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
				<td class="FieldInput"><label name="mbPeopleNum" field="mbPeopleNum" renderer="peRender"  />  </td>
				<td class="FieldLabel">女性人数:</td>
				<td class="FieldInput" colspan="3"><label name="mbFemaleNum" field="mbFemaleNum" renderer="peRender"  />  </td>
		   </tr>
		   <tr>
				<td class="FieldLabel" style="width:18%">30岁以下人数:</td>
				<td class="FieldInput" style="width:12%"><label name="mbThirtyNum" field="mbThirtyNum" renderer="peRender"  />  </td>
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
				<td class="FieldInput" colspan="3"><label name="mbCrossNum" field="mbCrossNum" renderer="peRender"  />  </td>
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
		   		<td class="FieldLabel">具备社会工作职业资格人数:</td>
				<td class="FieldInput"><label name="mbWorkerNum" field="mbWorkerNum" renderer="peRender" /></td>
				<td class="FieldLabel">大学生村官人数:</td>
				<td class="FieldInput"><label name="mbOfficalNum" field="mbOfficalNum"renderer="peRender" /></td>
				<td class="FieldLabel">人均月报酬:</td>
				<td class="FieldInput"><label name="mbSubsidyAvgMon" field="mbSubsidyAvgMon" renderer="mRender" /></td>
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
				<td class="FieldInput"><label name="wkCorporationNum" field="wkCorporationNum" renderer="peRender"  />  </td>
				<td class="FieldLabel">社区居民人数:</td>
				<td class="FieldInput"><label name="wkResideNum" field="wkResideNum" renderer="peRender" />  </td>
				<td class="FieldLabel">其他身份人数:</td>
				<td class="FieldInput"><label name="wkProOtherNum" field="wkProOtherNum" renderer="peRender" />  </td>
		   </tr>
		   <tr>
				<td class="FieldLabel">参加养老保险人数:</td>
				<td class="FieldInput"><label name="wkAgedInNum" field="wkAgedInNum" renderer="peRender" />  </td>
				<td class="FieldLabel">参加医疗保险人数:</td>
				<td class="FieldInput"><label name="wkMedicalInNum" field="wkMedicalInNum" renderer="peRender"  />  </td>
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
				<td class="FieldInput"><label name="mbWorkerNum" field="mbWorkerNum" renderer="peRender" /></td>
				<td class="FieldLabel">人均月报酬:</td>
				<td class="FieldInput" colspan="3"><label name="wkSubsidyAvgMon" field="wkSubsidyAvgMon" renderer="mRender" /></td>
		   </tr>
		</table>
			</fieldset>
			</form>
		</next:Html>
	</next:Panel>
</next:Window>
</body>
</html>