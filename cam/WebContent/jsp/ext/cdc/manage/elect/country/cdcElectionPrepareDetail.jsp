<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<script type="text/javascript">
</script>
<title>农村民主选举选举准备情况</title>
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
	<model:dataset id="electionPrepareDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcElectionPrepareQueryCmd" pageSize="20">
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcElectionPrepare"/>
	</model:dataset>
	<model:dataset id="reportWorkDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcReportWorkQueryCmd" method="getDic" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"/>
		<model:params>
			<model:param name="reportType" value='R11'/>
			<model:param name="organType" value='N'/>
		</model:params>
	</model:dataset>
	<model:dataset id="YorN" enumName="COMM.YESORNO" autoLoad="true" global="true" />
	<model:dataset id="statusDataSet" enumName="CDC.STATUS" autoLoad="true" global="true"/>
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
	<!-- 性别 -->
	<model:dataset id="sexDataSet" enumName="COMM.SEX" autoLoad="true" global="true"/>
	<model:dataset id="ecAuditDs" enumName="CDC.ELECTION_ECONOMY_AUDIT" autoLoad="true" global="true"/>
	<model:dataset id="electionMannerDs" enumName="CDC.ELECTION_MANNER" autoLoad="true" global="true"/>
</model:datasets>
<next:Panel width="99%" autoScroll="true">
<next:TopBar>
	<next:ToolBarItem symbol="->"/>
</next:TopBar>
<next:Html>
<form id="form1" method="post" dataset="electionPrepareDataSet" onsubmit="return false" class="L5form">
<fieldset id="cdcFieldset">
<legend>选举准备情况</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel" style="width:18%">填报单位：</td>
			<td class="FieldInput" style="width:14%"><label field="organName"/></td>
			<td class="FieldLabel" style="width:21%">填报日期：</td>
			<td class="FieldInput" ><label id="reportDate" field="reportDate"  dataset="reportWorkDataSet"/></td>
		</tr>
	</table>
</fieldset>
<fieldset id="cdcFieldset">
<legend>干部包村情况</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel" style="width:18%">村名：</td>
			<td class="FieldInput" style="width:14%"><label field="villageName"/></td>
			<td class="FieldLabel" style="width:18%">干部姓名：</td>
			<td class="FieldInput" style="width:14%"><label field="name"/></td>
			<td class="FieldLabel" style="width:18%">性别：</td>
			<td class="FieldInput" style="width:14%"><label field ="sex" dataset="sexDataSet"/></td>
		</tr>
		<tr>
			<td class="FieldLabel">县市区领导干部联系点村名：</td>
			<td class="FieldInput" colspan="5"><label field="linkVillageName"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">县市区领导姓名：</td>
			<td class="FieldInput" style="width:14%"><label field="leaderName"/></td>
			<td class="FieldLabel" style="width:18%">县市区领导性别：</td>
			<td class="FieldInput" style="width:14%"><label field ="leaderSex" dataset="sexDataSet"/></td>
			<td class="FieldLabel" style="width:18%">县市区领导职务：</td>
			<td class="FieldInput" style="width:14%"><label field="leaderDuty"/></td>
		</tr>
	</table>
</fieldset>
<fieldset id="cdcFieldset">
<legend>试点村情况</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel" style="width:18%">是否为试点村：</td>
			<td class="FieldInput" colspan="5"><label field ="ifTest" dataset="YorN"/></td>
		</tr>
	</table>
</fieldset>
<fieldset id="cdcFieldset">
<legend>离任经济责任审计情况</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel" style="width:18%">离任经济责任审计情况：</td>
			<td class="FieldInput" colspan="5"><label field ="economyAudit"/></td>
		</tr>
	</table>
</fieldset>
<fieldset id="cdcFieldset">
<legend>难点村情况</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel">是否难点村：</td>
			<td class="FieldInput" colspan="5"><label field="ifDiff" dataset="YorN"/></td>
		</tr>
		<tr id="ifDiffDiv" style="display:none">
			<td class="FieldLabel">难点原因：</td>
			<td class="FieldInput" colspan="5">
				<input type="checkbox" id="n0">未换届选举
				<input type="checkbox" id="n1">班子不健全
				<input type="checkbox" id="n2">班子软弱涣散
				<input type="checkbox" id="n3">干群关系紧张
				<input type="checkbox" id="n4">村务不公开管理混乱
				<input type="checkbox" id="n5">经济薄弱无人干
				<input type="checkbox" id="n6">经济发达竞争激烈
				<input type="checkbox" id="n7">干部驾驭能力差
				<input type="checkbox" id="n8">遗留问题未解决
				<input type="checkbox" id="n9">拆迁合并改制
				<input type="checkbox" id="n10">干部作风简单霸道
				<input type="checkbox" id="n11">群体上访不断
				<input type="checkbox" id="n12">宗族派性严重
				<input type="checkbox" id="n13">其他
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">换届时间：</td>
			<td class="FieldInput" style="width:14%"><label field="changeDate"/></td>
			<td class="FieldLabel" style="width:18%">责任人：</td>
			<td class="FieldInput" colspan="3"><label field="peopleName"/></td>
		</tr>
	</table>
</fieldset>
<fieldset id="cdcFieldset">
<legend>村民选举委员会基本情况</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel">村民选举委员会产生方式：</td>
			<td class="FieldInput" colspan="5"><label field ="electionManner" dataset="electionMannerDs"/></td>
		</tr>
		<tr id="cm" style="display:none">
			<td class="FieldLabel">村民（户代表）总数：</td>
			<td class="FieldInput"><label field="villagerNum" renderer="rRender"/></td>
			<td class="FieldLabel">参加推选的村民（户代表）数：</td>
			<td class="FieldInput" colspan="3"><label field="joinVillagerNum" renderer="rRender"/></td>
		</tr>
		<tr id="cmdb" style="display:none">
			<td class="FieldLabel">代表会议组成人员总数：</td>
			<td class="FieldInput"><label field="sovietNum" renderer="rRender"/></td>
			<td class="FieldLabel">参加推选的村民代表人数：</td>
			<td class="FieldInput" colspan="3"><label field="joinSovietNum" renderer="rRender"/></td>
		</tr>
		<tr id="cmxz" style="display:none">
			<td class="FieldLabel">本小组总人（户）数：</td>
			<td class="FieldInput"><label field="groupNum" renderer="hRender"/></td>
			<td class="FieldLabel">参加推选的村民(户代表）人数：</td>
			<td class="FieldInput" colspan="3"><label field="joinGroupNum" renderer="hRender"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">村民选举委员会职数：</td>
			<td class="FieldInput" style="width:14%"><label field="eleComNum" renderer="rRender"/></td>
			<td class="FieldLabel" style="width:18%">党员人数：</td>
			<td class="FieldInput" style="width:14%"><label field="eleComPartyNum" renderer="rRender"/></td>
			<td class="FieldLabel" style="width:18%">妇女成员人数：</td>
			<td class="FieldInput" style="width:14%"><label field="eleComFemaleNum" renderer="rRender"/></td>
		</tr>
	</table>
</fieldset>
<fieldset id="cdcFieldset">
<legend>登记参加选举的村民情况</legend>
	<table width="100%">
	<tr>
		<td class="FieldLabel" style="width:20%">是否召开村民会议或村民代表会议，对村委会职数及大学生村官、在本村居住一年以上、国家企事业离退休干部是否具有选民资格进行讨论</td>
		<td class="FieldInput" style="width:24%"><label   id="ifDiscuss" field ="ifDiscuss"  dataset="YorN" /></td>
	</tr>
	</table>
</fieldset>
<fieldset id="cdcFieldset">
<legend>登记参加选举的村民情况</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel">张榜公布登记参加选举的村民总数：</td>
			<td class="FieldInput" colspan="5"><label field="elePeopleNum" renderer="rRender"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">党员人数：</td>
			<td class="FieldInput" style="width:14%"><label field="elePartyNum" renderer="rRender"/></td>
			<td class="FieldLabel" style="width:18%">女性人数：</td>
			<td class="FieldInput" style="width:14%"><label field="eleFemaleNum" renderer="rRender"/></td>
			<td class="FieldLabel" style="width:18%">少数民族人数：</td>
			<td class="FieldInput" style="width:14%"><label field="eleFolkNum" renderer="rRender"/></td>
		</tr>
	</table>
</fieldset>
<fieldset id="cdcFieldset">
<legend>村民委员会组成人员职数</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel" style="width:18%">村民委员会组成人员职数：</td>
			<td class="FieldInput" style="width:14%"><label field="comPositionNum" renderer="rRender"/></td>
			<td class="FieldLabel" style="width:18%">副主任职数：</td>
			<td class="FieldInput" style="width:14%"><label field="comDeputyNum" renderer="rRender"/></td>
			<td class="FieldLabel" style="width:18%">委员职数：</td>
			<td class="FieldInput" style="width:14%"><label field="comMbNum" renderer="rRender"/></td>
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
	var OrgNameDataset=L5.DatasetMgr.lookup("OrgNameDataset");
	OrgNameDataset.on("load",function() {
		orgName= OrgNameDataset.get("text");
		electionPrepareDataSet.newRecord({"organCode":organ_Code,"organName":orgName,"parentCode":parentCode,
			"reportType":"N","recordId":recordId});
	});
	var electionPrepareDataSet=L5.DatasetMgr.lookup("electionPrepareDataSet");
	var reportWorkDataSet=L5.DatasetMgr.lookup("reportWorkDataSet");
	reportWorkDataSet.load();
	electionPrepareDataSet.setParameter("RECORD_ID@=",recordId);
	electionPrepareDataSet.on("load",function(){
		var nominate = electionPrepareDataSet.getCurrent();
		if(nominate==null){
			OrgNameDataset.setParameter("filterSql","USER_ID='"+organ_Code+"'");
			OrgNameDataset.load();
		}
		setDiffChange();
		setDiffReason();
		setManner();
	});
	electionPrepareDataSet.load();
}
function setDiffReason(){
	var electionPrepareDataSet=L5.DatasetMgr.lookup("electionPrepareDataSet");
	var record=electionPrepareDataSet.getCurrent();
	var reason=record.get("diffReason");
	var arr=reason.split('');
	for(i=0;i<arr.length;i++){
		if(arr[i]=="1"){
			$("n"+i).checked=true;
		}
		$("n"+i).disabled=true;
	}
}
function setManner(){
	var electionPrepareDataSet=L5.DatasetMgr.lookup("electionPrepareDataSet");
	var prepare=electionPrepareDataSet.getCurrent();
	if(prepare.get("electionManner")=='1'){
		$("cm").style.display="";
		$("cmdb").style.display="none";
		$("cmxz").style.display="none";
	}else if(prepare.get("electionManner")=='2'){
		$("cm").style.display="none";
		$("cmdb").style.display="";
		$("cmxz").style.display="none";
	}else if(prepare.get("electionManner")=='3'){
		$("cm").style.display="none";
		$("cmdb").style.display="none";
		$("cmxz").style.display="";
	}else{
		$("cm").style.display="none";
		$("cmdb").style.display="none";
		$("cmxz").style.display="none";
	}
}
function rRender(val){
	if(val!=""){
		return val+" 人";
	}
}
function hRender(val){
	if(val!=""){
		return val+" 人(户)";
	}
}
function setDiffChange(){
	var ds=L5.DatasetMgr.lookup("electionPrepareDataSet");
	var prepare=ds.getCurrent();
	if(prepare.get("ifDiff")=='0'){
		$("ifDiffDiv").style.display="none";
	}else{
		$("ifDiffDiv").style.display="";
	}
}
</script>