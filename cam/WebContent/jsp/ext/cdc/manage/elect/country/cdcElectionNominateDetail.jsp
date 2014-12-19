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
	<model:dataset id="electionNominateDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcElectionNominateQueryCmd" pageSize="20">
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcElectionNominate"/>
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
	<model:dataset id="YorN" enumName="COMM.YESORNO" autoLoad="true" global="true" />
	<model:dataset id="sexDataSet" enumName="COMM.SEX" autoLoad="true" global="true"/>
	<model:dataset id="politicalDataSet" enumName="CDC.POLITICAL" autoLoad="true" global="true"/>
	<model:dataset id="educationDataSet" enumName="CDC.EDUCATION" autoLoad="true" global="true"/>
	<model:dataset id="statusDataSet" enumName="CDC.STATUS" autoLoad="true" global="true"/>
	<model:dataset id="candidateMannerDs" enumName="CDC.CANDIDATE_MANNER" autoLoad="true" global="true"/>
	<model:dataset id="nomMannerDs" enumName="CDC.NOM_MANNER" autoLoad="true" global="true"/>
	<model:dataset id="nomSourceDs" enumName="CDC.NOM_SOURCE" autoLoad="true" global="true"/>
</model:datasets>
<next:Panel width="99%" autoScroll="true">
<next:TopBar>
	<next:ToolBarItem symbol="->"/>
</next:TopBar>
<next:Html>
<form id="form1" method="post" dataset="electionNominateDataSet" onsubmit="return false" class="L5form">
<fieldset id="cdcFieldset">
<legend>候选人的产生</legend>
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
<legend>产生方式</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel" style="width:18%">产生方式：</td>
			<td class="FieldInput" colspan="5"><label field="candidateManner" dataset="candidateMannerDs"/></td>
		</tr>
		<tr id="tm" style="display:none">
			<td class="FieldLabel" style="width:18%">村民委员会候选人应选职数：</td>
			<td class="FieldInput" style="width:14%"><label field="nomNum" renderer="rRender"/></td>
			<td class="FieldLabel" style="width:18%">差额数：</td>
			<td class="FieldInput" style="width:14%"><label field="nomDiffNum" renderer="rRender"/></td>
			<td class="FieldLabel" style="width:18%">参加提名的登记参加选举的村民数：</td>
			<td class="FieldInput" style="width:14%"><label field="nomJoinNum" renderer="rRender"/></td>
		</tr>
		<tr id="tmyx1" style="display:none">
			<td class="FieldLabel" style="width:18%">村民委员会应选职数：</td>
			<td class="FieldInput" style="width:14%"><label field="prenomNum" renderer="rRender"/></td>
			<td class="FieldLabel" style="width:18%">参加村民委员会成员<br>候选人预选（提名）投票的村民数：</td>
			<td class="FieldInput" style="width:14%"><label field="prenomJoinNum" renderer="rRender"/></td>
			<td class="FieldLabel" style="width:18%">>候选人确定人数：</td>
			<td class="FieldInput" style="width:14%"><label field="prenomCanNum" renderer="rRender"/></td>
		</tr>
		<tr id="tmyx2" style="display:none">
			<td class="FieldLabel">差额数：</td>
			<td class="FieldInput" colspan="5"><label field="prenomCanDiffNum" renderer="rRender"/></td>
		</tr>
		<tr id="yx1" style="display:none">
			<td class="FieldLabel" style="width:18%">村民委员会应选职数：</td>
			<td class="FieldInput" style="width:14%"><label field="preNum" renderer="rRender"/></td>
			<td class="FieldLabel" style="width:18%">候选人数：</td>
			<td class="FieldInput" style="width:14%"><label field="preCanNum" renderer="rRender"/></td>
			<td class="FieldLabel" style="width:18%">参加村民委员会成员<br>候选人预选投票的村民数：</td>
			<td class="FieldInput" style="width:14%"><label field="preJoinNum" renderer="rRender"/></td>
		</tr>
	</table>
</fieldset>
</form>
</next:Html>
</next:Panel>

<next:EditGridPanel id="grid1" title="候选人信息" dataset="peopleDs" hidden="true"  width="100%" stripeRows="true" height="99.9%">
	<next:Columns>
		<next:RowNumberColumn></next:RowNumberColumn>
		<next:RadioBoxColumn></next:RadioBoxColumn>
		<next:Column field="name" header="姓名" width="90" sortable="false"/>
		<next:Column field="sex" header="性别" dataset="sexDataSet" width="90" sortable="false"/>
		<next:Column field="age" header="年龄" width="90" sortable="false"/>
		<next:Column field="folk" header="民族" dataset="NationDataset" width="90" sortable="false"/>
		<next:Column field="political" header="政治面貌" dataset="politicalDataSet" width="90" sortable="false"/>
		<next:Column field="education" header="文化程度" dataset="educationDataSet" width="90" sortable="false"/>
		<next:Column field="nomManner" header="提名形式" dataset="nomMannerDs" width="90" sortable="false"/>
		<next:Column field="nomNum" header="提名人数" width="90" sortable="false"/>
		<next:Column field="voteNum" header="得票数" width="90" sortable="false" hidden="true"/>
		<next:Column field="ifReduty" header="是否连选连任" dataset="YorN" width="90" sortable="false" hidden="true"/>
		<next:Column field="peopleSource" header="来源" dataset="nomSourceDs" width="90" sortable="false"/>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="peopleDs"/>
	</next:BottomBar>
</next:EditGridPanel>

<next:EditGridPanel id="grid2" title="候选人信息" dataset="peopleDs" hidden="true"  width="100%" stripeRows="true" height="99.9%">
	<next:Columns>
		<next:RowNumberColumn></next:RowNumberColumn>
		<next:RadioBoxColumn></next:RadioBoxColumn>
		<next:Column field="name" header="姓名" width="90" sortable="false"/>
		<next:Column field="sex" header="性别" dataset="sexDataSet" width="90" sortable="false"/>
		<next:Column field="age" header="年龄" width="90" sortable="false"/>
		<next:Column field="folk" header="民族" dataset="NationDataset" width="90" sortable="false"/>
		<next:Column field="political" header="政治面貌" dataset="politicalDataSet" width="90" sortable="false"/>
		<next:Column field="education" header="文化程度" dataset="educationDataSet" width="90" sortable="false"/>
		<next:Column field="voteNum" header="得票数" width="90" sortable="false"/>
		<next:Column field="ifReduty" header="是否连选连任" dataset="YorN" width="90" sortable="false"/>
		<next:Column field="peopleSource" header="来源" dataset="nomSourceDs" width="90" sortable="false"/>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="peopleDs"/>
	</next:BottomBar>
</next:EditGridPanel>

<next:EditGridPanel id="grid3" title="候选人信息" dataset="peopleDs" hidden="true" width="100%" stripeRows="true" height="99.9%">
	<next:Columns>
		<next:RowNumberColumn></next:RowNumberColumn>
		<next:RadioBoxColumn></next:RadioBoxColumn>
		<next:Column field="name" header="姓名" width="90" sortable="false"/>
		<next:Column field="sex" header="性别" dataset="sexDataSet" width="90" sortable="false"/>
		<next:Column field="age" header="年龄" width="90" sortable="false"/>
		<next:Column field="folk" header="民族" dataset="NationDataset" width="90" sortable="false"/>
		<next:Column field="political" header="政治面貌" dataset="politicalDataSet" width="90" sortable="false"/>
		<next:Column field="education" header="文化程度" dataset="educationDataSet" width="90" sortable="false"/>
		<next:Column field="voteNum" header="得票数" width="90" sortable="false"/>
		<next:Column field="peopleSource" header="来源" dataset="nomSourceDs" width="90" sortable="false"/>
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
		electionNominateDataSet.newRecord({"organCode":organ_Code,"organName":orgName,"parentCode":parentCode,
			"reportType":"N","recordId":recordId});
	});
	var electionNominateDataSet=L5.DatasetMgr.lookup("electionNominateDataSet");
	var peopleDs=L5.DatasetMgr.lookup("peopleDs");
	var reportWorkDataSet=L5.DatasetMgr.lookup("reportWorkDataSet");
	reportWorkDataSet.load();
	electionNominateDataSet.setParameter("RECORD_ID@=",'<%=request.getParameter("recordId")%>');
	electionNominateDataSet.on("load",function(){
		var nominate = electionNominateDataSet.getCurrent();
		if(nominate==null){
			OrgNameDataset.setParameter("filterSql","USER_ID='"+organ_Code+"'");
			OrgNameDataset.load();
		}
		getManner();
	});
	
	electionNominateDataSet.load();
	reportWorkDataSet.load();
	peopleDs.setParameter("RECORD_ID@=",recordId);
	peopleDs.setParameter("TYPE@=","H");
	peopleDs.load();
}
function returnBack(){
	history.go(-1);
}
function getManner(){
	var electionNominateDataSet=L5.DatasetMgr.lookup("electionNominateDataSet");
	var rec=electionNominateDataSet.getCurrent();
	var grid1=L5.getCmp("grid1");
	var grid2=L5.getCmp("grid2");
	var grid3=L5.getCmp("grid3");
	if(rec.get("candidateManner")=="1"){
		$("tm").style.display="";
		$("tmyx1").style.display="none";
		$("tmyx2").style.display="none";
		$("yx1").style.display="none";
		grid1.show();
		grid2.hide();
		grid3.hide();
	}else if(rec.get("candidateManner")=="2"){
		$("tm").style.display="none";
		$("tmyx1").style.display="";
		$("tmyx2").style.display="";
		$("yx1").style.display="none";
		grid1.hide();
		grid2.show();
		grid3.hide();
	}else if(rec.get("candidateManner")=="3"){
		$("tm").style.display="none";
		$("tmyx1").style.display="none";
		$("tmyx2").style.display="none";
		$("yx1").style.display="";
		grid1.hide();
		grid2.hide();
		grid3.show();
	}else{
		$("tm").style.display="none";
		$("tmyx1").style.display="none";
		$("tmyx2").style.display="none";
		$("yx1").style.display="none";
		grid1.hide();
		grid2.hide();
		grid3.hide();
	}
}
function rRender(val){
	if(val!=""){
		return val+" 人";
	}
}
</script>