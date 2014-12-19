<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<script type="text/javascript">
</script>
<title>农村民主选举提名方式信息</title>
<next:ScriptManager/>
<script type="text/javascript">
	var recordId='<%=request.getParameter("recordId")%>';
	var organ_Code='<%=request.getParameter("organ_Code")%>';
</script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<jsp:include page="../../util/cdcOrgan.jsp" flush="true"/>
</head>
<body>
<model:datasets>
	<model:dataset id="resultDs" cmd="com.inspur.cams.cdc.base.cmd.CdcElectionResultQueryCmd" pageSize="1">
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcElectionResult">
			<model:field name="otherPer" type="string"/>
			<model:field name="sovietFemalePer" type="string"/>
			<model:field name="sovietPartyPer" type="string"/>
			<model:field name="sovietFolkPer" type="string"/>
			<model:field name="groupFemalePer" type="string"/>
			<model:field name="groupPartyPer" type="string"/>
			<model:field name="groupFolkPer" type="string"/>
		</model:record>
	</model:dataset>
	<model:dataset id="peopleMDs" cmd="com.inspur.cams.cdc.base.cmd.CdcElectionMemberQueryCmd" pageSize="20">
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcElectionMember"/>
	</model:dataset>
	<model:dataset id="peopleODs" cmd="com.inspur.cams.cdc.base.cmd.CdcElectionMemberQueryCmd" pageSize="20">
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcElectionMember"/>
	</model:dataset>
	<model:dataset id="peopleSDs" cmd="com.inspur.cams.cdc.base.cmd.CdcElectionMemberQueryCmd" pageSize="20">
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcElectionMember"/>
	</model:dataset>
	<model:dataset id="peopleFDs" cmd="com.inspur.cams.cdc.base.cmd.CdcElectionMemberQueryCmd" pageSize="20">
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcElectionMember"/>
	</model:dataset>
	<model:dataset id="reportWorkDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcReportWorkQueryCmd" method="getDic" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"/>
		<model:params>
			<model:param name="reportType" value='R11'/>
			<model:param name="organType" value='N'/>
		</model:params>
	</model:dataset>
	<model:dataset id="OrgNameDataset"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="false">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='COM_EXT_USER'></model:param>
			<model:param name="value" value='USER_ID'></model:param>
			<model:param name="text" value='USER_NAME'></model:param>
		</model:params>
	</model:dataset>
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
	<model:dataset id="statusDataSet" enumName="CDC.STATUS" autoLoad="true" global="true"/>
	<model:dataset id="YorN" enumName="COMM.YESORNO" autoLoad="true" global="true" />
	<model:dataset id="sexDataSet" enumName="COMM.SEX" autoLoad="true" global="true"/>
	<model:dataset id="politicalDataSet" enumName="CDC.POLITICAL" autoLoad="true" global="true"/>
	<model:dataset id="educationDataSet" enumName="CDC.EDUCATION" autoLoad="true" global="true"/>
	<model:dataset id="dutyDs" enumName="CDC.DUTY.TYPE" autoLoad="true" global="true"/>
	<model:dataset id="resultOtherDs" enumName="CDC.RESULT_OTHER" autoLoad="true" global="true"/>
	<model:dataset id="sovietMannerDs" enumName="CDC.SOVIET_MANNER" autoLoad="true" global="true"/>
	<model:dataset id="subNameDs" enumName="CDC.SUB_NAME" autoLoad="true" global="true"/>
</model:datasets>
<next:Panel width="99%" autoScroll="true">
<next:TopBar>
	<next:ToolBarItem symbol="->"/>
</next:TopBar>
<next:Html>
<form id="form1" method="post" dataset="resultDs" onsubmit="return false" class="L5form">
<fieldset id="cdcFieldset">
<legend>选举结果</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel"  style="width:18%">填报单位：</td>
			<td class="FieldInput"  style="width:14%"><label field="organName"/></td>
			<td class="FieldLabel"  style="width:21%">填报日期：</td>
			<td class="FieldInput" ><label id="reportDate" field="reportDate" dataset="reportWorkDataSet"/></td>
		</tr>
	</table>
</fieldset>
</form>
</next:Html>
</next:Panel>

<next:EditGridPanel id="gridM" dataset="peopleMDs" width="100%" stripeRows="true" height="200">
	<next:TopBar>
		<next:ToolBarItem symbol="村委会成员基本信息"/>
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn></next:RowNumberColumn>
		<next:RadioBoxColumn></next:RadioBoxColumn>
		<next:Column field="name" header="姓名" width="90" sortable="false"/>
		<next:Column field="sex" header="性别" dataset="sexDataSet" width="90" sortable="false"/>
		<next:Column field="age" header="年龄" width="90" sortable="false"/>
		<next:Column field="folk" header="民族" dataset="NationDataset" width="90" sortable="false"/>
		<next:Column field="political" header="政治面貌" dataset="politicalDataSet" width="90" sortable="false"/>
		<next:Column field="education" header="文化程度" dataset="educationDataSet" width="90" sortable="false"/>
		<next:Column field="duty" header="当选职务" dataset="dutyDs" width="90" sortable="false"/>
		<next:Column field="dutyVoteNum" header="当选职务票数" width="90" sortable="false"/>
		<next:Column field="voteNum" header="总票数" width="90" sortable="false"/>
		<next:Column field="ifFirst" header="是否初次当选" dataset="YorN" width="90" sortable="false"/>
		<next:Column field="ifReduty" header="是否连选连任" dataset="YorN" width="90" sortable="false"/>
	</next:Columns>
</next:EditGridPanel>

<next:Panel width="99%" autoScroll="true">
<next:Html>
<form id="form1" method="post" dataset="resultDs" onsubmit="return false" class="L5form">
<fieldset id="cdcFieldset">
<legend>另行选举情况</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel">另行选举：</td>
			<td class="FieldInput" colspan="5"><label field="other" dataset="resultOtherDs"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" rowspan="4">四增：</td>
			<td class="FieldLabel" colspan="4">上次选举登记日至本次另行选举日新满18周岁的村民：</td>
			<td class="FieldInput"><label field="othAddOne" renderer="rRender"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" colspan="4">新迁入本村有选民资格的村民，包括城镇离退休人员、企事业单位下岗人员、本村退伍军人及其他人员：</td>
			<td class="FieldInput"><label field="othAddTwo" renderer="rRender"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" colspan="4">因婚姻、家庭等关系迁入本村和具有选民资格的家庭收养人员：</td>
			<td class="FieldInput"><label field="othAddThree" renderer="rRender"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" colspan="4">被剥夺政治权利期满恢复政治权利的村民：</td>
			<td class="FieldInput"><label field="othAddFour" renderer="rRender"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" rowspan="4">四减：</td>
			<td class="FieldLabel" colspan="4">上次选举登记日至本次另行选举日迁出的村民，其中包括入伍军人等：</td>
			<td class="FieldInput"><label field="othRedOne" renderer="rRender"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" colspan="4">因婚姻、家庭迁出本村的村民：</td>
			<td class="FieldInput"><label field="othRedTwo" renderer="rRender"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" colspan="4">死亡的村民：</td>
			<td class="FieldInput"><label field="othRedThree" renderer="rRender"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" colspan="4">被剥夺政治权利的村民：</td>
			<td class="FieldInput"><label field="othRedFour" renderer="rRender"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">参加另行选举投票的村民总数：</td>
			<td class="FieldInput" style="width:14%"><label field="voterNum" renderer="rRender"/></td>
			<td class="FieldLabel" style="width:18%">委托投票人数：</td>
			<td class="FieldInput" style="width:14%"><label field="entrustNum" renderer="rRender"/></td>
			<td class="FieldLabel" style="width:18%">使用流动票箱投票人数：</td>
			<td class="FieldInput" style="width:14%"><label field="flowNum" renderer="rRender"/></td>
		</tr>
		<tr>
			<td class="FieldLabel">代写选票人数：</td>
			<td class="FieldInput"><label field="replaceNum" renderer="rRender"/></td>
			<td class="FieldLabel">设立分会场数：</td>
			<td class="FieldInput"><label field="subNum" renderer="gRender"/></td>
			<td class="FieldLabel">投票箱总数：</td>
			<td class="FieldInput"><label field="boxNum" renderer="gRender"/></td>
		</tr>
		<!-- 
		<tr>
			<td class="FieldLabel">参加投票选民占村民总数的百分比：</td>
			<td class="FieldInput" colspan="5"><label field="otherPer" renderer="pRender"/></td>
		</tr>
		-->
	</table>
</fieldset>
</form>
</next:Html>
</next:Panel>

<next:EditGridPanel id="gridO" dataset="peopleODs" width="100%" stripeRows="true" height="200">
	<next:TopBar>
		<next:ToolBarItem symbol="另行选举结果"/>
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn></next:RowNumberColumn>
		<next:RadioBoxColumn></next:RadioBoxColumn>
		<next:Column field="name" header="姓名" width="90" sortable="false"/>
		<next:Column field="sex" header="性别" dataset="sexDataSet" width="90" sortable="false"/>
		<next:Column field="age" header="年龄" width="90" sortable="false"/>
		<next:Column field="folk" header="民族" dataset="NationDataset" width="90" sortable="false"/>
		<next:Column field="political" header="政治面貌" dataset="politicalDataSet" width="90" sortable="false"/>
		<next:Column field="education" header="文化程度" dataset="educationDataSet" width="90" sortable="false"/>
		<next:Column field="duty" header="当选职务" dataset="dutyDs" width="90" sortable="false"/>
		<next:Column field="dutyVoteNum" header="当选职务票数" width="90" sortable="false"/>
		<next:Column field="voteNum" header="总票数" width="90" sortable="false"/>
		<next:Column field="ifFirst" header="是否初次当选" dataset="YorN" width="90" sortable="false"/>
		<next:Column field="ifReduty" header="是否连选连任" dataset="YorN" width="90" sortable="false"/>
	</next:Columns>
</next:EditGridPanel>

<next:Panel width="99%" autoScroll="true">
<next:Html>
<form id="form1" method="post" dataset="resultDs" onsubmit="return false" class="L5form">
<fieldset id="cdcFieldset">
<legend>重新选举</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel" style="width:18%" rowspan="4">四增：</td>
			<td class="FieldLabel" colspan="4">上次选举登记日至本次重新选举日新满18周岁的村民：</td>
			<td class="FieldInput" style="width:14%"><label field="reAddOne" renderer="rRender"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" colspan="4">新迁入本村有选民资格的村民，包括城镇离退休人员、企事业单位下岗人员、本村退伍军人及其他人员：</td>
			<td class="FieldInput"><label field="reAddTwo" renderer="rRender"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" colspan="4">因婚姻、家庭等关系迁入本村和具有选民资格的家庭收养人员：</td>
			<td class="FieldInput"><label field="reAddThree" renderer="rRender"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" colspan="4">被剥夺政治权利期满恢复政治权利的村民：</td>
			<td class="FieldInput"><label field="reAddFour" renderer="rRender"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" rowspan="4">四减：</td>
			<td class="FieldLabel" colspan="4">上次选举登记日至本次另行选举日迁出的村民，其中包括入伍军人等：</td>
			<td class="FieldInput"><label field="reRedOne" renderer="rRender"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" colspan="4">因婚姻、家庭迁出本村的村民：</td>
			<td class="FieldInput"><label field="reRedTwo" renderer="rRender"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" colspan="4">死亡的村民：</td>
			<td class="FieldInput"><label field="reRedThree" renderer="rRender"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" colspan="4">被剥夺政治权利的村民：</td>
			<td class="FieldInput"><label field="reRedFour" renderer="rRender"/></td>
		</tr>
	</table>
</fieldset>
</form>
</next:Html>
</next:Panel>

<next:Panel width="99%" autoScroll="true">
<next:Html>
<form id="form1" method="post" dataset="resultDs" onsubmit="return false" class="L5form">
<fieldset id="cdcFieldset">
<legend>村民代表、村民小组长情况</legend>

<fieldset id="cdcFieldset">
<legend>村民代表推选情况</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel">村民代表总数：</td>
			<td class="FieldInput"><label field="sovietNum" renderer="rRender"/></td>
			<td class="FieldLabel">村民代表推选方式：</td>
			<td class="FieldInput" colspan="3"><label field="sovietManner" dataset="sovietMannerDs"/></td>
		</tr>
		<tr id="sovietManner1" style="display:none">
			<td class="FieldLabel"></td>
			<td class="FieldInput" colspan="5"><label field="sovietOneNum" renderer="mRender"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">女性成员数：</td>
			<td class="FieldInput" style="width:14%"><label field="sovietFemaleNum" renderer="rRender"/></td>
			<td class="FieldLabel" style="width:18%">党员人数：</td>
			<td class="FieldInput" style="width:14%"><label field="sovietPartyNum" renderer="rRender"/></td>
			<td class="FieldLabel" style="width:18%">少数民族成员：</td>
			<td class="FieldInput" style="width:14%"><label field="sovietFolkNum" renderer="rRender"/></td>
		</tr>
		<tr>
			<td class="FieldLabel">女性成员比率：</td>
			<td class="FieldInput"><label field="sovietFemalePer" renderer="pRender"/></td>
			<td class="FieldLabel">党员比率：</td>
			<td class="FieldInput"><label field="sovietPartyPer" renderer="pRender"/></td>
			<td class="FieldLabel">少数民族比率：</td>
			<td class="FieldInput"><label field="sovietFolkPer" renderer="pRender"/></td>
		</tr>
	</table>
</fieldset>

<fieldset id="cdcFieldset">
<legend>村民小组长情况</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel">本小组有登记参加选举的村民总数：</td>
			<td class="FieldInput"><label field="groupVoterNum" renderer="rRender"/></td>
			<td class="FieldLabel">参加推选的本小组村民数：</td>
			<td class="FieldInput"><label field="groupPeopleNum" renderer="rRender"/></td>
			<td class="FieldLabel">参加推选的本小组户数：</td>
			<td class="FieldInput"><label field="groupNum" renderer="hRender"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">女性成员数：</td>
			<td class="FieldInput" style="width:14%"><label field="groupFemaleNum" renderer="rRender"/></td>
			<td class="FieldLabel" style="width:18%">党员人数：</td>
			<td class="FieldInput" style="width:14%"><label field="groupPartyNum" renderer="rRender"/></td>
			<td class="FieldLabel" style="width:18%">少数民族成员：</td>
			<td class="FieldInput" style="width:14%"><label field="groupFolkNum" renderer="rRender"/></td>
		</tr>
		<tr>
			<td class="FieldLabel">女性成员比率：</td>
			<td class="FieldInput"><label field="groupFemalePer" renderer="pRender"/></td>
			<td class="FieldLabel">党员比率：</td>
			<td class="FieldInput"><label field="groupPartyPer" renderer="pRender"/></td>
			<td class="FieldLabel">少数民族比率：</td>
			<td class="FieldInput"><label field="groupFolkPer" renderer="pRender"/></td>
		</tr>
	</table>
</fieldset>
</fieldset>

<fieldset id="cdcFieldset">
<legend>村委会下属委员会情况</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel" style="width:32%">人民调解委员会：</td>
			<td class="FieldLabel" style="width:18%">组成人员数：</td>					
			<td class="FieldInput" style="width:14%"><label field="tjNum" renderer="rRender"/></td>
			<td class="FieldLabel" style="width:18%">是否村委会成员兼任主任：</td>
			<td class="FieldInput" style="width:14%"><label field="tjIfSame" dataset="YorN"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:32%">治安保卫委员会：</td>
			<td class="FieldLabel" style="width:18%">组成人员数：</td>					
			<td class="FieldInput" style="width:14%"><label field="zaNum" renderer="rRender"/></td>
			<td class="FieldLabel" style="width:18%">是否村委会成员兼任主任：</td>
			<td class="FieldInput" style="width:14%"><label field="zaIfSame" dataset="YorN"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:32%">公共卫生与计划生育委员会：</td>
			<td class="FieldLabel" style="width:18%">组成人员数：</td>					
			<td class="FieldInput" style="width:14%"><label field="wsNum" renderer="rRender"/></td>
			<td class="FieldLabel" style="width:18%">是否村委会成员兼任主任：</td>
			<td class="FieldInput" style="width:14%"><label field="wsIfSame" dataset="YorN"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:32%">民政事务委员会：</td>
			<td class="FieldLabel" style="width:18%">组成人员数：</td>					
			<td class="FieldInput" style="width:14%"><label field="mzswNum" renderer="rRender"/></td>
			<td class="FieldLabel" style="width:18%">是否村委会成员兼任主任：</td>
			<td class="FieldInput" style="width:14%"><label field="mzswIfSame" dataset="YorN"/></td>
		</tr>
	</table>
</fieldset>
</form>
</next:Html>
</next:Panel>

<next:EditGridPanel id="gridS" dataset="peopleSDs" width="100%" stripeRows="true" height="200">
	<next:TopBar>
		<next:ToolBarItem symbol="下属委员会成员情况"/>
		<next:ToolBarItem symbol="->"/>
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn></next:RowNumberColumn>
		<next:RadioBoxColumn></next:RadioBoxColumn>
		<next:Column field="name" header="姓名" width="90" sortable="false"/>
		<next:Column field="sex" header="性别" dataset="sexDataSet" width="90" sortable="false"/>
		<next:Column field="age" header="年龄" width="90" sortable="false"/>
		<next:Column field="folk" header="民族" dataset="NationDataset" width="90" sortable="false"/>
		<next:Column field="political" header="政治面貌" dataset="politicalDataSet" width="90" sortable="false"/>
		<next:Column field="education" header="文化程度" dataset="educationDataSet" width="90" sortable="false"/>
		<next:Column field="ifFirst" header="是否新当选" dataset="YorN" width="90" sortable="false"/>
		<next:Column field="ifReduty" header="是否连选连任" dataset="YorN" width="90" sortable="false"/>
	</next:Columns>
</next:EditGridPanel>

<next:EditGridPanel id="gridF" dataset="peopleFDs" width="100%" stripeRows="true" height="200">
	<next:TopBar>
		<next:ToolBarItem symbol="村财会人员情况"/>
		<next:ToolBarItem symbol="->"/>
	</next:TopBar>
	<next:Columns>
		<next:RowNumberColumn></next:RowNumberColumn>
		<next:RadioBoxColumn></next:RadioBoxColumn>
		<next:Column field="name" header="姓名" width="90" sortable="false"/>
		<next:Column field="sex" header="性别" dataset="sexDataSet" width="90" sortable="false"/>
		<next:Column field="age" header="年龄" width="90" sortable="false"/>
		<next:Column field="folk" header="民族" dataset="NationDataset" width="90" sortable="false"/>
		<next:Column field="political" header="政治面貌" dataset="politicalDataSet" width="90" sortable="false"/>
		<next:Column field="education" header="文化程度" dataset="educationDataSet" width="90" sortable="false"/>
		<next:Column field="ifCert" header="是否有从业资格证书" dataset="YorN" width="90" sortable="false"/>
	</next:Columns>
</next:EditGridPanel>

</body>
</html>
<script language="javascript">
function init(){
	var OrgNameDataset=L5.DatasetMgr.lookup("OrgNameDataset");
	OrgNameDataset.on("load",function() {
		orgName= OrgNameDataset.get("text");
		resultDs.newRecord({"organCode":organ_Code,"organName":orgName,"parentCode":parentCode,
			"reportType":"N","recordId":recordId});
	});
	var resultDs=L5.DatasetMgr.lookup("resultDs");
	var peopleMDs=L5.DatasetMgr.lookup("peopleMDs");
	var peopleODs=L5.DatasetMgr.lookup("peopleODs");
	var peopleSDs=L5.DatasetMgr.lookup("peopleSDs");
	var peopleODs=L5.DatasetMgr.lookup("peopleODs");
	var peopleFDs=L5.DatasetMgr.lookup("peopleFDs");
	var reportWorkDataSet=L5.DatasetMgr.lookup("reportWorkDataSet");
	reportWorkDataSet.load();
	resultDs.setParameter("RECORD_ID@=",'<%=request.getParameter("recordId")%>');
	resultDs.on("load",function(){
		var nominate = resultDs.getCurrent();
		if(nominate==null){
			OrgNameDataset.setParameter("filterSql","USER_ID='"+organ_Code+"'");
			OrgNameDataset.load();
		}
		getSovietManner();
		getPer();
	});
	resultDs.load();
	reportWorkDataSet.load();
	peopleMDs.setParameter("RECORD_ID@=",recordId);
	peopleMDs.setParameter("TYPE@=","M");
	peopleMDs.load();
	peopleODs.setParameter("RECORD_ID@=",recordId);
	peopleODs.setParameter("TYPE@=","O");
	peopleODs.load();
	peopleSDs.setParameter("RECORD_ID@=",recordId);
	peopleSDs.setParameter("TYPE@=","S");
	peopleSDs.load();
	peopleFDs.setParameter("RECORD_ID@=",recordId);
	peopleFDs.setParameter("TYPE@=","F");
	peopleFDs.load();
}
function returnBack(){
	history.go(-1);
}
function getSovietManner(){
	var resultDs=L5.DatasetMgr.lookup("resultDs");
	var rec=resultDs.getCurrent();
	if(rec.get("sovietManner")=='1'){
		$("sovietManner1").style.display="";
	}else if(rec.get("sovietManner")=='2'){
		$("sovietManner1").style.display="none";
	}else{
		$("sovietManner1").style.display="none";
	}
}
function getPer(){
	var resultDs=L5.DatasetMgr.lookup("resultDs");
	var rec=resultDs.getCurrent();
	if(rec.get("sovietNum")=="0"||rec.get("sovietNum")==""){
		rec.set("sovietFemalePer", "--");
		rec.set("sovietPartyPer", "--");
		rec.set("sovietFolkPer", "--");
	}else{
		rec.set("sovietFemalePer", Math.round((rec.get("sovietFemaleNum")/rec.get("sovietNum"))*10000)/100);
		rec.set("sovietPartyPer", Math.round((rec.get("sovietPartyNum")/rec.get("sovietNum"))*10000)/100);
		rec.set("sovietFolkPer", Math.round((rec.get("sovietFolkNum")/rec.get("sovietNum"))*10000)/100);
	}
	if(rec.get("groupVoterNum")=="0"||rec.get("groupVoterNum")==""){
		rec.set("groupFemalePer", "--");
		rec.set("groupPartyPer", "--");
		rec.set("groupFolkPer", "--");
	}else{
		rec.set("groupFemalePer", Math.round((rec.get("groupFemaleNum")/rec.get("groupVoterNum"))*10000)/100);
		rec.set("groupPartyPer", Math.round((rec.get("groupPartyNum")/rec.get("groupVoterNum"))*10000)/100);
		rec.set("groupFolkPer", Math.round((rec.get("groupFolkNum")/rec.get("groupVoterNum"))*10000)/100);
	}
}
function pRender(val){
	if(val!=""){
		return val+" %";
	}
}
function rRender(val){
	if(val!=""){
		return val+" 人";
	}
}
function gRender(val){
	if(val!=""){
		return val+" 个";
	}
}
function hRender(val){
	if(val!=""){
		return val+" 户";
	}
}
function mRender(val){
	if(val!=""){
		return val+" 户推选一名代表";
	}
}
function vRender(val){
	if(val!=""){
		return val+" 票";
	}
}
</script>