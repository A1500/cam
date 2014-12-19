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
	var reportDate='<%=request.getParameter("reportDate")%>';
	var organC='<%=request.getParameter("organC")%>';
</script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<jsp:include page="../../util/cdcOrgan.jsp" flush="true"/>
</head>
<body>
<model:datasets>
	<model:dataset id="supDs" cmd="com.inspur.cams.cdc.base.cmd.CdcElectionSumQueryCmd" method="query" pageSize="20">
		<model:record>
			<model:field name="recallPer" type="string"/>
			<model:field name="rePer" type="string"/>
			<model:field name="reSovietPer" type="string"/>
		</model:record>
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
			<td class="FieldInput"  style="width:14%"><label field="ORGAN_NAME"/></td>
			<td class="FieldLabel"  style="width:21%">填报日期：</td>
			<td class="FieldInput" ><label id="reportDate" field="REPORT_DATE" dataset="reportWorkDataSet"/></td>
		</tr>
	</table>
</fieldset>
<fieldset id="cdcFieldset">
<legend>村务监督委员会情况</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel">村务监督委员会成员数：</td>
			<td class="FieldInput"><label field="SUP_MB_NUM" renderer="rRender"/></td>
			<td class="FieldLabel">村民会议推选村数：</td>
			<td class="FieldInput"><label field="SUP_MANNER1" renderer="gRender"/></td>
			<td class="FieldLabel">村民代表会议推选村数：</td>
			<td class="FieldInput"><label field="SUP_MANNER2" renderer="gRender"/></td>
		</tr>
		<tr>
			<td class="FieldLabel">登记参加选举的村民（户代表）总数：</td>
			<td class="FieldInput"><label field="MEETING_NUM" renderer="rRender"></td>
			<td class="FieldLabel">实际参加推选人数：</td>
			<td class="FieldInput" colspan="3"><label field="MEETING_ACT_NUM" renderer="rRender"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">同意人数：</td>
			<td class="FieldInput" style="width:14%"><label field="MEETING_AGREE_NUM" renderer="rRender"/></td>
			<td class="FieldLabel" style="width:18%">不同意人数：</td>
			<td class="FieldInput" style="width:14%"><label field="MEETING_UNAGREE_NUM" renderer="rRender"/></td>
			<td class="FieldLabel" style="width:18%">弃权人数：</td>
			<td class="FieldInput" style="width:14%"><label field="MEETING_GIVEUP_NUM" renderer="rRender"/></td>
		</tr>
		<tr>
			<td class="FieldLabel">村民代表会议总数：</td>
			<td class="FieldInput"><label field="SOVIET_NUM" renderer="rRender"/></td>
			<td class="FieldLabel">实际参加推选人数：</td>
			<td class="FieldInput" colspan="3"><label field="SOVIET_ACT_NUM" renderer="rRender"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">同意人数：</td>
			<td class="FieldInput" style="width:14%"><label field="SOVIET_AGREE_NUM" renderer="rRender"/></td>
			<td class="FieldLabel" style="width:18%">不同意人数：</td>
			<td class="FieldInput" style="width:14%"><label field="SOVIET_UNAGREE_NUM" renderer="rRender"/></td>
			<td class="FieldLabel" style="width:18%">弃权人数：</td>
			<td class="FieldInput" style="width:14%"><label field="SOVIET_GIVEUP_NUM" renderer="rRender"/></td>
		</tr>
	</table>
</fieldset>

<fieldset id="cdcFieldset">
<legend>罢免村委会成员情况</legend>

<fieldset id="cdcFieldset">
<legend>村民代表或村民联名情况</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel">被罢免人职务（主任数）：</td>
			<td class="FieldInput"><label field="RECALL_DUTY1" renderer="rRender"/></td>
			<td class="FieldLabel">被罢免人职务（副主任数）：</td>
			<td class="FieldInput"><label field="RECALL_DUTY2" renderer="rRender"/></td>
			<td class="FieldLabel">被罢免人职务（委员数）：</td>
			<td class="FieldInput"><label field="RECALL_DUTY3" renderer="rRender"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">登记参加选举张榜公布的村民总数：</td>
			<td class="FieldInput" style="width:14%"><label field="RECALL_VOTE_NUM" renderer="rRender"/></td>
			<td class="FieldLabel" style="width:18%">女性人数：</td>
			<td class="FieldInput" style="width:14%"><label field="RECALL_FEMALE_NUM" renderer="rRender"/></td>
			<td class="FieldLabel" style="width:18%">少数民族人数：</td>
			<td class="FieldInput" style="width:14%"><label field="RECALL_FOLK_NUM" renderer="rRender"/></td>
		</tr>
		<tr>
			<td class="FieldLabel">委托投票人数：</td>
			<td class="FieldInput"><label field="RECALL_ENTRUST_NUM" renderer="rRender"/></td>
			<td class="FieldLabel">使用流动票箱投票人数：</td>
			<td class="FieldInput"><label field="RECALL_FLOW_NUM" renderer="rRender"/></td>
			<td class="FieldLabel">代写选票人数：</td>
			<td class="FieldInput"><label field="RECALL_REPLACE_NUM" renderer="rRender"/></td>
		</tr>
		<tr>
			<td class="FieldLabel">参加罢免大会投票的选民数：</td>
			<td class="FieldInput"><label field="RECALL_NUM" renderer="rRender"/></td>
			<td class="FieldLabel">占张榜公布选民总数的百分比：</td>
			<td class="FieldInput" colspan="3"><label field="recallPer" renderer="pRender"/></td>
		</tr>
	</table>
</fieldset>

<fieldset id="cdcFieldset">
<legend>罢免表决情况</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel" style="width:18%">中心会场投票箱数：</td>
			<td class="FieldInput" style="width:14%"><label field="RECALL_CEN_BOX_NUM" renderer="gRender"/></td>
			<td class="FieldLabel" style="width:18%">设立分会场数：</td>
			<td class="FieldInput" style="width:14%"><label field="RECALL_SUB_NUM" renderer="gRender"/></td>
			<td class="FieldLabel" style="width:18%">分会场投票箱数：</td>
			<td class="FieldInput" style="width:14%"><label field="RECALL_SUB_BOX_NUM" renderer="gRender"/></td>
		</tr>
		<tr>
			<td class="FieldLabel">投票箱总数：</td>
			<td class="FieldInput"><label field="RECALL_BOX_NUM" renderer="gRender"/></td>
			<td class="FieldLabel">实际参加投票罢免会议的村民总数：</td>
			<td class="FieldInput" colspan="3"><label field="RECALL_MEETING_NUM" renderer="rRender"/></td>
		</tr>
		<tr>
			<td class="FieldLabel">同意罢免村民数：</td>
			<td class="FieldInput"><label field="RECALL_AGREE_NUM" renderer="rRender"/></td>
			<td class="FieldLabel">不同意罢免村民数：</td>
			<td class="FieldInput" colspan="3"><label field="RECALL_UNAGREE_NUM" renderer="rRender"/></td>
		</tr>
		<tr>
			<td class="FieldLabel">罢免成功数：</td>
			<td class="FieldInput"><label field="RECALL_SUCCESS" renderer="rRender"/></td>
			<td class="FieldLabel">罢免失败数：</td>
			<td class="FieldInput" colspan="3"><label field="RECALL_FAILURE" renderer="rRender"/></td>
		</tr>
	</table>
</fieldset>

<fieldset id="cdcFieldset">
<legend>补选情况</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel">补选原因（辞职数）：</td>
			<td class="FieldInput"><label field="RE_REASON1" renderer="gRender"/></td>
			<td class="FieldLabel">补选原因（职务终止数）：</td>
			<td class="FieldInput"><label field="RE_REASON2" renderer="gRender"/></td>
			<td class="FieldLabel">补选原因（被罢免数）：</td>
			<td class="FieldInput"><label field="RE_REASON3" renderer="gRender"/></td>
		</tr>
		<tr>
			<td class="FieldLabel">补选原因（死亡数）：</td>
			<td class="FieldInput"><label field="RE_REASON4" renderer="gRender"/></td>
			<td class="FieldLabel">补选原因（被人民法院<br>宣告失踪、死亡数）：</td>
			<td class="FieldInput"><label field="RE_REASON5" renderer="gRender"/></td>
			<td class="FieldLabel">补选原因（丧失中华<br>人民共和国国籍）：</td>
			<td class="FieldInput"><label field="RE_REASON6" renderer="gRender"/></td>
		</tr>
		<tr>
			<td class="FieldLabel">村民会议补选村数：</td>
			<td class="FieldInput"><label field="RE_SITUATION1" renderer="gRender"/></td>
			<td class="FieldLabel">村民代表会议补选村数：</td>
			<td class="FieldInput"><label field="RE_SITUATION2" renderer="gRender"/></td>
		</tr>
		<tr>
			<td class="FieldLabel">补选的村委会成员职务<br>（主任、副主任）职数：</td>
			<td class="FieldInput"><label field="RE_DIR_NUM" renderer="rRender"/></td>
			<td class="FieldLabel">补选的村委会成员职务<br>（委员）职数：</td>
			<td class="FieldInput"><label field="RE_COM_NUM" renderer="rRender"/></td>
			<td class="FieldLabel">差额数：</td>
			<td class="FieldInput"><label field="RE_RED_NUM" renderer="rRender"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">登记参加选举的村民<br>总数：</td>
			<td class="FieldInput" style="width:14%"><label field="RE_MEETING_NUM" renderer="rRender"/></td>
			<td class="FieldLabel" style="width:18%">女性人数：</td>
			<td class="FieldInput" style="width:14%"><label field="RE_MEETING_FEMALE_NUM" renderer="rRender"/></td>
			<td class="FieldLabel" style="width:18%">少数民族人数：</td>
			<td class="FieldInput" style="width:14%"><label field="RE_MEETING_FOLK_NUM" renderer="rRender"/></td>
		</tr>
		<tr>
			<td class="FieldLabel">委托投票人数：</td>
			<td class="FieldInput"><label field="RE_ENTRUST_NUM" renderer="rRender"/></td>
			<td class="FieldLabel">使用流动票箱投票人数：</td>
			<td class="FieldInput"><label field="RE_FLOW_NUM" renderer="rRender"/></td>
			<td class="FieldLabel">代写选票人数：</td>
			<td class="FieldInput"><label field="RE_REPLACE_NUM" renderer="rRender"/></td>
		</tr>
		<tr>
			<td class="FieldLabel">实际参加投票的<br>村民总数：</td>
			<td class="FieldInput"><label field="RE_ACT_NUM" renderer="rRender"/></td>
			<td class="FieldLabel">占张榜公布选民<br>总数的百分比：</td>
			<td class="FieldInput" colspan="3"><label field="rePer" renderer="pRender"/></td>
		</tr>
		<tr>
			<td class="FieldLabel">村民代表总数：</td>
			<td class="FieldInput"><label field="RE_SOVIET_NUM" renderer="rRender"/></td>
			<td class="FieldLabel">女性人数：</td>
			<td class="FieldInput"><label field="RE_SOVIET_FEMALE_NUM" renderer="rRender"/></td>
			<td class="FieldLabel">少数民族人数：</td>
			<td class="FieldInput"><label field="RE_SOVIET_FOLK_NUM" renderer="rRender"/></td>
		</tr>
		<tr id="recmdb2" style="display:none">
			<td class="FieldLabel">参加村民代表会议<br>的村民代表人数：</td>
			<td class="FieldInput"><label field="RE_SOVIET_JOIN_NUM" renderer="rRender"/></td>
			<td class="FieldLabel">占村民代表会议组成<br>人员的百分比：</td>
			<td class="FieldInput" colspan="3"><label field="reSovietPer" renderer="pRender"/></td>
		</tr>
	</table>
</fieldset>
</fieldset>
</form>
</next:Html>
</next:Panel>

</body>
</html>
<script language="javascript">
function init(){
	var supDs=L5.DatasetMgr.lookup("supDs");
	var reportWorkDataSet=L5.DatasetMgr.lookup("reportWorkDataSet");
	reportWorkDataSet.load();
	supDs.setParameter("tableName","CDC_ELECTION_SUP_SUM");
	supDs.setParameter("organCode",organC);
	supDs.setParameter("reportDate",reportDate);
	supDs.on("load",function(){
		var nominate = supDs.getCurrent();
		if(nominate==null){
			supDs.newRecord({"ORGAN_NAME":organC,"REPORT_DATE":reportDate});
		}
		getPer();
	});
	supDs.load();
	reportWorkDataSet.load();
}
function returnBack(){
	history.go(-1);
}
function getPer(){
	var supDs=L5.DatasetMgr.lookup("supDs");
	var rec=supDs.getCurrent();
	if(rec.get("RECALL_VOTE_NUM")=="0"||rec.get("RECALL_VOTE_NUM")==""){
		rec.set("recallPer", "--");
	}else{
		rec.set("recallPer", Math.round((rec.get("RECALL_NUM")/rec.get("RECALL_VOTE_NUM"))*10000)/100);
	}
	if(rec.get("RE_MEETING_NUM")=="0"||rec.get("RE_MEETING_NUM")==""){
		rec.set("rePer", "--");
	}else{
		rec.set("rePer", Math.round((rec.get("RE_ACT_NUM")/rec.get("RE_MEETING_NUM"))*10000)/100);
	}
	if(rec.get("RE_SOVIET_NUM")=="0"||rec.get("RE_SOVIET_NUM")==""){
		rec.set("reSovietPer", "--");
	}else{
		rec.set("reSovietPer", Math.round((rec.get("RE_SOVIET_JOIN_NUM")/rec.get("RE_SOVIET_NUM"))*10000)/100);
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
</script>