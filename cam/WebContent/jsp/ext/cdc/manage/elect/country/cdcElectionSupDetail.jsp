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
	<model:dataset id="supDs" cmd="com.inspur.cams.cdc.base.cmd.CdcElectionSupQueryCmd" pageSize="1">
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcElectionSup">
			<model:field name="recallPer" type="string"/>
			<model:field name="rePer" type="string"/>
			<model:field name="reSovietPer" type="string"/>
		</model:record>
	</model:dataset>
	<model:dataset id="peopleDs" cmd="com.inspur.cams.cdc.base.cmd.CdcElectionMemberQueryCmd" pageSize="20">
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcElectionMember"/>
	</model:dataset>
	<model:dataset id="reportWorkDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcReportWorkQueryCmd" method="getDic" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"/>
		<model:params>
			<model:param name="reportType" value='R11'/>
			<model:param name="organType" value='N'/>
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
	<model:dataset id="statusDataSet" enumName="CDC.STATUS" autoLoad="true" global="true"/>
	<model:dataset id="YorN" enumName="COMM.YESORNO" autoLoad="true" global="true" />
	<model:dataset id="sexDataSet" enumName="COMM.SEX" autoLoad="true" global="true"/>
	<model:dataset id="politicalDataSet" enumName="CDC.POLITICAL" autoLoad="true" global="true"/>
	<model:dataset id="educationDataSet" enumName="CDC.EDUCATION" autoLoad="true" global="true"/>
	<model:dataset id="dutyDs" enumName="CDC.DUTY.TYPE" autoLoad="true" global="true"/>
	<model:dataset id="supMannerDs" enumName="CDC.SUP_MANNER" autoLoad="true" global="true"/>
	<model:dataset id="reReasonDs" enumName="CDC.RE_REASON" autoLoad="true" global="true"/>
	<model:dataset id="reSituationDs" enumName="CDC.RE_SITUATION" autoLoad="true" global="true"/>
</model:datasets>
<next:Panel width="99%" autoScroll="true">
<next:TopBar>
	<next:ToolBarItem symbol="->"/>
</next:TopBar>
<next:Html>
<form id="form1" method="post" dataset="supDs" onsubmit="return false" class="L5form">
<fieldset id="cdcFieldset">
<legend>村务监督委员会情况</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel"  style="width:18%">填报单位：</td>
			<td class="FieldInput"  style="width:14%"><label field="organName"/></td>
			<td class="FieldLabel"  style="width:21%">填报日期：</td>
			<td class="FieldInput" ><label id="reportDate" field="reportDate" dataset="reportWorkDataSet"/></td>
		</tr>
	</table>
</fieldset>
<fieldset id="cdcFieldset">
<legend>村务监督委员会情况</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel" style="width:18%">村务监督委员会成员数：</td>
			<td class="FieldInput" style="width:14%"><label field="supMbNum" renderer="rRender"/></td>
			<td class="FieldLabel" style="width:18%">产生方式：</td>
			<td class="FieldInput" colspan="3"><label field="supManner" dataset="supMannerDs"/></td>
		</tr>
		<tr id="cm1" style="display:none">
			<td class="FieldLabel">登记参加选举的村民（户代表）总数：</td>
			<td class="FieldInput"><label field="meetingNum" renderer="rRender"></td>
			<td class="FieldLabel">实际参加推选人数：</td>
			<td class="FieldInput" colspan="3"><label field="meetingActNum" renderer="rRender"/></td>
		</tr>
		<tr id="cm2" style="display:none">
			<td class="FieldLabel" style="width:18%">同意人数：</td>
			<td class="FieldInput" style="width:14%"><label field="meetingAgreeNum" renderer="rRender"/></td>
			<td class="FieldLabel" style="width:18%">不同意人数：</td>
			<td class="FieldInput" style="width:14%"><label field="meetingUnagreeNum" renderer="rRender"/></td>
			<td class="FieldLabel" style="width:18%">弃权人数：</td>
			<td class="FieldInput" style="width:14%"><label field="meetingGiveupNum" renderer="rRender"/></td>
		</tr>
		<tr id="cmdb1" style="display:none">
			<td class="FieldLabel">村民代表会议总数：</td>
			<td class="FieldInput"><label field="sovietNum" renderer="rRender"/></td>
			<td class="FieldLabel">实际参加推选人数：</td>
			<td class="FieldInput" colspan="3"><label field="sovietActNum" renderer="rRender"/></td>
		</tr>
		<tr id="cmdb2" style="display:none">
			<td class="FieldLabel" style="width:18%">同意人数：</td>
			<td class="FieldInput" style="width:14%"><label field="sovietAgreeNum" renderer="rRender"/></td>
			<td class="FieldLabel" style="width:18%">不同意人数：</td>
			<td class="FieldInput" style="width:14%"><label field="sovietUnagreeNum" renderer="rRender"/></td>
			<td class="FieldLabel" style="width:18%">弃权人数：</td>
			<td class="FieldInput" style="width:14%"><label field="sovietGiveupNum" renderer="rRender"/></td>
		</tr>
	</table>
</fieldset>

<fieldset id="cdcFieldset">
<legend>罢免村委会成员情况</legend>

<fieldset id="cdcFieldset">
<legend>村民代表或村民联名情况</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel">被罢免人职务：</td>
			<td class="FieldInput" colspan="5"><label field="recallDuty" dataset="dutyDs"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">登记参加选举张榜公布的村民总数：</td>
			<td class="FieldInput" style="width:14%"><label field="recallVoteNum" renderer="rRender"/></td>
			<td class="FieldLabel" style="width:18%">女性人数：</td>
			<td class="FieldInput" style="width:14%"><label field="recallFemaleNum" renderer="rRender"/></td>
			<td class="FieldLabel" style="width:18%">少数民族人数：</td>
			<td class="FieldInput" style="width:14%"><label field="recallFolkNum" renderer="rRender"/></td>
		</tr>
		<tr>
			<td class="FieldLabel">委托投票人数：</td>
			<td class="FieldInput"><label field="recallEntrustNum" renderer="rRender"/></td>
			<td class="FieldLabel">使用流动票箱投票人数：</td>
			<td class="FieldInput"><label field="recallFlowNum" renderer="rRender"/></td>
			<td class="FieldLabel">代写选票人数：</td>
			<td class="FieldInput"><label field="recallReplaceNum" renderer="rRender"/></td>
		</tr>
		<tr>
			<td class="FieldLabel">参加罢免大会投票的选民数：</td>
			<td class="FieldInput"><label field="recallNum" renderer="rRender"/></td>
			<td class="FieldLabel">占张榜公布选民总数的百分比：</td>
			<td class="FieldInput" colspan="3"><label field="recallPer" renderer="pRender"/></td>
		</tr>
	</table>
</fieldset>

<fieldset id="cdcFieldset">
<legend>罢免表决情况</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel" style="width:18%">设立分会场数：</td>
			<td class="FieldInput" style="width:14%"><label field="recallSubNum" renderer="gRender"/></td>
			<td class="FieldLabel" style="width:18%">投票箱总数：</td>
			<td class="FieldInput" style="width:14%"><label field="recallBoxNum" renderer="gRender"/></td>
			<td class="FieldLabel" style="width:18%">实际参加投票罢免会议的村民总数：</td>
			<td class="FieldInput" style="width:14%"><label field="recallMeetingNum" renderer="rRender"/></td>
		</tr>
		<tr>
			<td class="FieldLabel">同意罢免村民数：</td>
			<td class="FieldInput"><label field="recallAgreeNum" renderer="rRender"/></td>
			<td class="FieldLabel">不同意罢免村民数：</td>
			<td class="FieldInput"><label field="recallUnagreeNum" renderer="rRender"/></td>
			<td class="FieldLabel">罢免是否成功：</td>
			<td class="FieldInput"><label field="recallSuccess" dataset="YorN"/></td>
		</tr>
	</table>
</fieldset>

<fieldset id="cdcFieldset">
<legend>补选情况</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel">补选原因：</td>
			<td class="FieldInput"><label field="reReason" dataset="reReasonDs"/></td>
			<td class="FieldLabel">补选方式：</td>
			<td class="FieldInput" colspan="3"><label field="reSituation" dataset="reSituationDs"/></td>
		</tr>
		<tr>
			<td class="FieldLabel">补选的村委会成员职务<br>（主任）职数：</td>
			<td class="FieldInput"><label field="reDirNum" renderer="rRender"/></td>
			<td class="FieldLabel">补选的村委会成员职务<br>（副主任）职数：</td>
			<td class="FieldInput"><label field="reComNum" renderer="rRender"/></td>
			<td class="FieldLabel">补选的村委会成员职务<br>（委员）职数：</td>
			<td class="FieldInput"><label field="reRedNum" renderer="rRender"/></td>
		</tr>
		<tr id="recm1" style="display:none">
			<td class="FieldLabel" style="width:18%">登记参加选举的村民<br>总数：</td>
			<td class="FieldInput" style="width:14%"><label field="reMeetingNum" renderer="rRender"/></td>
			<td class="FieldLabel" style="width:18%">女性人数：</td>
			<td class="FieldInput" style="width:14%"><label field="reMeetingFemaleNum" renderer="rRender"/></td>
			<td class="FieldLabel" style="width:18%">少数民族人数：</td>
			<td class="FieldInput" style="width:14%"><label field="reMeetingFolkNum" renderer="rRender"/></td>
		</tr>
		<tr id="recm2" style="display:none">
			<td class="FieldLabel">委托投票人数：</td>
			<td class="FieldInput"><label field="reEntrustNum" renderer="rRender"/></td>
			<td class="FieldLabel">使用流动票箱投票人数：</td>
			<td class="FieldInput"><label field="reFlowNum" renderer="rRender"/></td>
			<td class="FieldLabel">代写选票人数：</td>
			<td class="FieldInput"><label field="reReplaceNum" renderer="rRender"/></td>
		</tr>
		<tr id="recm3" style="display:none">
			<td class="FieldLabel">实际参加投票的<br>村民总数：</td>
			<td class="FieldInput"><label field="reActNum" renderer="rRender"/></td>
			<td class="FieldLabel">占登记参加选举的村民<br>总数的百分比：</td>
			<td class="FieldInput" colspan="3"><label field="rePer" renderer="pRender"/></td>
		</tr>
		<tr id="recmdb1" style="display:none">
			<td class="FieldLabel">村民代表总数：</td>
			<td class="FieldInput"><label field="reSovietNum" renderer="rRender"/></td>
			<td class="FieldLabel">女性人数：</td>
			<td class="FieldInput"><label field="reSovietFemaleNum" renderer="rRender"/></td>
			<td class="FieldLabel">少数民族人数：</td>
			<td class="FieldInput"><label field="reSovietFolkNum" renderer="rRender"/></td>
		</tr>
		<tr id="recmdb2" style="display:none">
			<td class="FieldLabel">参加村民代表会议<br>的村民代表人数：</td>
			<td class="FieldInput"><label field="reSovietJoinNum" renderer="rRender"/></td>
			<td class="FieldLabel">占村民代表会议组成<br>人员的百分比：</td>
			<td class="FieldInput" colspan="3"><label field="reSovietPer" renderer="pRender"/></td>
		</tr>
	</table>
</fieldset>
</fieldset>
</form>
</next:Html>
</next:Panel>

<next:EditGridPanel id="grid" title="补选成员情况" dataset="peopleDs" width="100%" stripeRows="true" height="300">
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
		<next:Column field="dutyVoteNum" header="当选票数" width="90" sortable="false"/>
		<next:Column field="age" header="总票数" width="90" sortable="false"/>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="peopleDs"/>
	</next:BottomBar>
</next:EditGridPanel>
</body>
</html>
<script language="javascript">
function init(){
	var OrgNameDataset=L5.DatasetMgr.lookup("OrgNameDataset");
	OrgNameDataset.on("load",function() {
		orgName= OrgNameDataset.get("text");
		supDs.newRecord({"organCode":organ_Code,"organName":orgName,"parentCode":parentCode,
			"reportType":"N","recordId":recordId});
	});
	var supDs=L5.DatasetMgr.lookup("supDs");
	var peopleDs=L5.DatasetMgr.lookup("peopleDs");
	var reportWorkDataSet=L5.DatasetMgr.lookup("reportWorkDataSet");
	reportWorkDataSet.load();
	supDs.setParameter("RECORD_ID@=",'<%=request.getParameter("recordId")%>');
	supDs.on("load",function(){
		var nominate = supDs.getCurrent();
		if(nominate==null){
			OrgNameDataset.setParameter("filterSql","USER_ID='"+organ_Code+"'");
			OrgNameDataset.load();
		}
		getPer();
		getSupManner();
		getResituation();
	});
	supDs.load();
	reportWorkDataSet.load();
	peopleDs.setParameter("RECORD_ID@=",recordId);
	peopleDs.setParameter("TYPE@=","B");
	peopleDs.load();
}
function returnBack(){
	history.go(-1);
}
function getPer(){
	var supDs=L5.DatasetMgr.lookup("supDs");
	var rec=supDs.getCurrent();
	if(rec.get("recallVoteNum")=="0"||rec.get("recallVoteNum")==""){
		rec.set("recallPer", "--");
	}else{
		rec.set("recallPer", Math.round((rec.get("recallNum")/rec.get("recallVoteNum"))*10000)/100);
	}
	if(rec.get("reMeetingNum")=="0"||rec.get("reMeetingNum")==""){
		rec.set("rePer", "--");
	}else{
		rec.set("rePer", Math.round((rec.get("reActNum")/rec.get("reMeetingNum"))*10000)/100);
	}
	if(rec.get("reSovietNum")=="0"||rec.get("reSovietNum")==""){
		rec.set("reSovietPer", "--");
	}else{
		rec.set("reSovietPer", Math.round((rec.get("reSovietJoinNum")/rec.get("reSovietNum"))*10000)/100);
	}
}
function pRender(val){
	if(val!=""){
		return val+" %";
	}
}
function getSupManner(){
	var supDs=L5.DatasetMgr.lookup("supDs");
	var rec=supDs.getCurrent();
	if(rec.get("supManner")=='1'){
		$("cm1").style.display="";
		$("cm2").style.display="";
		$("cmdb1").style.display="none";
		$("cmdb2").style.display="none";
	}else if(rec.get("supManner")=='2'){
		$("cm1").style.display="none";
		$("cm2").style.display="none";
		$("cmdb1").style.display="";
		$("cmdb2").style.display="";
	}else{
		$("cm1").style.display="none";
		$("cm2").style.display="none";
		$("cmdb1").style.display="none";
		$("cmdb2").style.display="none";
	}
}
function getResituation(){
	var supDs=L5.DatasetMgr.lookup("supDs");
	var rec=supDs.getCurrent();
	if(rec.get("reSituation")=='1'){
		$("recm1").style.display="";
		$("recm2").style.display="";
		$("recm3").style.display="";
		$("recmdb1").style.display="none";
		$("recmdb2").style.display="none";
	}else if(rec.get("reSituation")=='2'){
		$("recm1").style.display="none";
		$("recm2").style.display="none";
		$("recm3").style.display="none";
		$("recmdb1").style.display="";
		$("recmdb2").style.display="";
	}else{
		$("recm1").style.display="none";
		$("recm2").style.display="none";
		$("recm3").style.display="none";
		$("recmdb1").style.display="none";
		$("recmdb2").style.display="none";
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
</script>