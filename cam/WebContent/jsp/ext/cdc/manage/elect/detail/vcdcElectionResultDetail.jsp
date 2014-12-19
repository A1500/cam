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
	<model:dataset id="resultDs" cmd="com.inspur.cams.cdc.base.cmd.CdcElectionSumQueryCmd" method="query" pageSize="20">
		<model:record>
			<model:field name="otherPer" type="string"/>
			<model:field name="sovietFemalePer" type="string"/>
			<model:field name="sovietPartyPer" type="string"/>
			<model:field name="sovietFolkPer" type="string"/>
			<model:field name="groupFemalePer" type="string"/>
			<model:field name="groupPartyPer" type="string"/>
			<model:field name="groupFolkPer" type="string"/>
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
			<td class="FieldInput"  style="width:14%"><label field="ORGAN_NAME"/></td>
			<td class="FieldLabel"  style="width:21%">填报日期：</td>
			<td class="FieldInput" ><label id="reportDate" field="REPORT_DATE" dataset="reportWorkDataSet"/></td>
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
<legend>另行选举情况</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel">另行选举(村委会主任数)：</td>
			<td class="FieldInput"><label field="OTHER1" renderer="rRender"/></td>
			<td class="FieldLabel">另行选举(委员数)：</td>
			<td class="FieldInput"><label field="OTHER2" renderer="rRender"/></td>
			<td class="FieldLabel">另行选举(女性成员数)：</td>
			<td class="FieldInput"><label field="OTHER3" renderer="rRender"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" rowspan="4">四增：</td>
			<td class="FieldLabel" colspan="4">上次选举登记日至本次另行选举日新满18周岁的村民：</td>
			<td class="FieldInput"><label field="OTH_ADD_ONE" renderer="rRender"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" colspan="4">新迁入本村有选民资格的村民，包括城镇离退休人员、企事业单位下岗人员、本村退伍军人及其他人员：</td>
			<td class="FieldInput"><label field="OTH_ADD_TWO" renderer="rRender"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" colspan="4">因婚姻、家庭等关系迁入本村和具有选民资格的家庭收养人员：</td>
			<td class="FieldInput"><label field="OTH_ADD_THREE" renderer="rRender"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" colspan="4">被剥夺政治权利期满恢复政治权利的村民：</td>
			<td class="FieldInput"><label field="OTH_ADD_FOUR" renderer="rRender"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" rowspan="4">四减：</td>
			<td class="FieldLabel" colspan="4">上次选举登记日至本次另行选举日迁出的村民，其中包括入伍军人等：</td>
			<td class="FieldInput"><label field="OTH_RED_ONE" renderer="rRender"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" colspan="4">因婚姻、家庭迁出本村的村民：</td>
			<td class="FieldInput"><label field="OTH_RED_TWO" renderer="rRender"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" colspan="4">死亡的村民：</td>
			<td class="FieldInput"><label field="OTH_RED_THREE" renderer="rRender"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" colspan="4">被剥夺政治权利的村民：</td>
			<td class="FieldInput"><label field="OTH_RED_FOUR" renderer="rRender"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">参加另行选举投票的村民总数：</td>
			<td class="FieldInput" style="width:14%"><label field="VOTER_NUM" renderer="rRender"/></td>
			<td class="FieldLabel" style="width:18%">委托投票人数：</td>
			<td class="FieldInput" style="width:14%"><label field="ENTRUST_NUM" renderer="rRender"/></td>
			<td class="FieldLabel" style="width:18%">使用流动票箱投票人数：</td>
			<td class="FieldInput" style="width:14%"><label field="FLOW_NUM" renderer="rRender"/></td>
		</tr>
		<tr>
			<td class="FieldLabel">代写选票人数：</td>
			<td class="FieldInput"><label field="REPLACE_NUM" renderer="rRender"/></td>
			<td class="FieldLabel">设立分会场数：</td>
			<td class="FieldInput"><label field="SUB_NUM" renderer="gRender"/></td>
			<td class="FieldLabel">投票箱总数：</td>
			<td class="FieldInput"><label field="STATION_VOTE_NUM" renderer="gRender"/></td>
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

<next:Panel width="99%" autoScroll="true">
<next:Html>
<form id="form1" method="post" dataset="resultDs" onsubmit="return false" class="L5form">
<fieldset id="cdcFieldset">
<legend>重新选举</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel" style="width:18%" rowspan="4">四增：</td>
			<td class="FieldLabel" colspan="4">上次选举登记日至本次另行选举日新满18周岁的村民：</td>
			<td class="FieldInput" style="width:14%"><label field="RE_ADD_ONE" renderer="rRender"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" colspan="4">新迁入本村有选民资格的村民，包括城镇离退休人员、企事业单位下岗人员、本村退伍军人及其他人员：</td>
			<td class="FieldInput"><label field="RE_ADD_TWO" renderer="rRender"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" colspan="4">因婚姻、家庭等关系迁入本村和具有选民资格的家庭收养人员：</td>
			<td class="FieldInput"><label field="RE_ADD_THREE" renderer="rRender"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" colspan="4">被剥夺政治权利期满恢复政治权利的村民：</td>
			<td class="FieldInput"><label field="RE_ADD_FOUR" renderer="rRender"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" rowspan="4">四减：</td>
			<td class="FieldLabel" colspan="4">上次选举登记日至本次另行选举日迁出的村民，其中包括入伍军人等：</td>
			<td class="FieldInput"><label field="RE_RED_ONE" renderer="rRender"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" colspan="4">因婚姻、家庭迁出本村的村民：</td>
			<td class="FieldInput"><label field="RE_RED_TWO" renderer="rRender"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" colspan="4">死亡的村民：</td>
			<td class="FieldInput"><label field="RE_RED_THREE" renderer="rRender"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" colspan="4">被剥夺政治权利的村民：</td>
			<td class="FieldInput"><label field="RE_RED_FOUR" renderer="rRender"/></td>
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
			<td class="FieldInput"><label field="SOVIET_NUM" renderer="rRender"/></td>
			<td class="FieldLabel">五至十户推选数：</td>
			<td class="FieldInput"><label field="SOVIET_MANNER1" dataset="sovietMannerDs"/></td>
			<td class="FieldLabel">村民小组推选数：</td>
			<td class="FieldInput"><label field="SOVIET_MANNER2" dataset="sovietMannerDs"/></td>
		</tr>
		<tr>
			<td class="FieldLabel">五至十户推选：</td>
			<td class="FieldInput" colspan="5"><label field="SOVIET_ONE_NUM" renderer="rRender"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">女性成员数：</td>
			<td class="FieldInput" style="width:14%"><label field="SOVIET_FEMALE_NUM" renderer="rRender"/></td>
			<td class="FieldLabel" style="width:18%">党员人数：</td>
			<td class="FieldInput" style="width:14%"><label field="SOVIET_PARTY_NUM" renderer="rRender"/></td>
			<td class="FieldLabel" style="width:18%">少数民族成员：</td>
			<td class="FieldInput" style="width:14%"><label field="SOVIET_FOLK_NUM" renderer="rRender"/></td>
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
			<td class="FieldInput"><label field="GROUP_VOTER_NUM" renderer="rRender"/></td>
			<td class="FieldLabel">参加推选的本小组村民数：</td>
			<td class="FieldInput"><label field="GROUP_PEOPLE_NUM" renderer="rRender"/></td>
			<td class="FieldLabel">参加推选的本小组户数：</td>
			<td class="FieldInput"><label field="GROUP_NUM" renderer="hRender"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">女性成员数：</td>
			<td class="FieldInput" style="width:14%"><label field="GROUP_FEMALE_NUM" renderer="rRender"/></td>
			<td class="FieldLabel" style="width:18%">党员人数：</td>
			<td class="FieldInput" style="width:14%"><label field="GROUP_PARTY_NUM" renderer="rRender"/></td>
			<td class="FieldLabel" style="width:18%">少数民族成员：</td>
			<td class="FieldInput" style="width:14%"><label field="GROUP_FOLK_NUM" renderer="rRender"/></td>
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
			<td class="FieldLabel" style="width:18%">人民调解委员会个数：</td>
			<td class="FieldInput" style="width:14%"><label field="SUB_COM_NAME1" renderer="gRender"/></td>
			<td class="FieldLabel" style="width:18%">治安保卫委员会个数：</td>					
			<td class="FieldInput" style="width:14%"><label field="SUB_COM_NAME2" renderer="gRender"/></td>
			<td class="FieldLabel" style="width:18%">公共卫生与计划生育委员会个数：</td>
			<td class="FieldInput" style="width:14%"><label field="SUB_COM_NAME3" renderer="gRender"/></td>
		</tr>
		<tr>
			<td class="FieldLabel">民政事务委员会个数：</td>
			<td class="FieldInput" colspan="5"><label field="SUB_COM_NAME4" renderer="gRender"/></td>
		</tr>
		<tr>
			<td class="FieldLabel">下属委员会人员数：</td>
			<td class="FieldInput"><label field="SUB_COM_NUM" renderer="rRender"/></td>
			<td class="FieldLabel">下属委员会由村委会成员兼任主任数：</td>
			<td class="FieldInput" colspan="3"><label field="SUB_IF_SAME" renderer="gRender"/></td>
		</tr>
	</table>
</fieldset>
</form>
</next:Html>
</next:Panel>
</body>
</html>
<script language="javascript">
function init(){
	var resultDs=L5.DatasetMgr.lookup("resultDs");
	resultDs.setParameter("tableName","CDC_ELECTION_RESULT_SUM");
	resultDs.setParameter("organCode",organC);
	resultDs.setParameter("reportDate",reportDate);
	var reportWorkDataSet=L5.DatasetMgr.lookup("reportWorkDataSet");
	reportWorkDataSet.load();
	resultDs.on("load",function(){
		var nominate = resultDs.getCurrent();
		if(nominate==null){
			resultDs.newRecord({"ORGAN_NAME":organC,"REPORT_DATE":reportDate});
		}
		getPer();
	});
	resultDs.load();
	reportWorkDataSet.load();
}
function returnBack(){
	history.go(-1);
}
function getPer(){
	var resultDs=L5.DatasetMgr.lookup("resultDs");
	var rec=resultDs.getCurrent();
	if(rec.get("SOVIET_NUM")=="0"||rec.get("SOVIET_NUM")==""){
		rec.set("sovietFemalePer", "--");
		rec.set("sovietPartyPer", "--");
		rec.set("sovietFolkPer", "--");
	}else{
		rec.set("sovietFemalePer", Math.round((rec.get("SOVIET_FEMALE_NUM")/rec.get("SOVIET_NUM"))*10000)/100);
		rec.set("sovietPartyPer", Math.round((rec.get("SOVIET_PARTY_NUM")/rec.get("SOVIET_NUM"))*10000)/100);
		rec.set("sovietFolkPer", Math.round((rec.get("SOVIET_FOLK_NUM")/rec.get("SOVIET_NUM"))*10000)/100);
	}
	if(rec.get("GROUP_VOTER_NUM")=="0"||rec.get("GROUP_VOTER_NUM")==""){
		rec.set("groupFemalePer", "--");
		rec.set("groupPartyPer", "--");
		rec.set("groupFolkPer", "--");
	}else{
		rec.set("groupFemalePer", Math.round((rec.get("GROUP_FEMALE_NUM")/rec.get("GROUP_VOTER_NUM"))*10000)/100);
		rec.set("groupPartyPer", Math.round((rec.get("GROUP_PARTY_NUM")/rec.get("GROUP_VOTER_NUM"))*10000)/100);
		rec.set("groupFolkPer", Math.round((rec.get("GROUP_FOLK_NUM")/rec.get("GROUP_VOTER_NUM"))*10000)/100);
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
function vRender(val){
	if(val!=""){
		return val+" 票";
	}
}
</script>