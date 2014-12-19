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
	<model:dataset id="partyDs" cmd="com.inspur.cams.cdc.base.cmd.CdcElectionPartyQueryCmd" pageSize="1">
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcElectionParty"/>
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
	<model:dataset id="partySourceDs" enumName="CDC.PARTY_SOURCE" autoLoad="true" global="true"/>
</model:datasets>
<next:Panel width="99%" autoScroll="true">
<next:TopBar>
	<next:ToolBarItem symbol="->"/>
</next:TopBar>
<next:Html>
<form id="form1" method="post" dataset="partyDs" onsubmit="return false" class="L5form">
<fieldset id="cdcFieldset">
<legend>村党组织成员情况</legend>
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
<legend>村党组织情况</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel" style="width:18%">本村中共党员人数：</td>
			<td class="FieldInput" style="width:14%"><label field="partyNum" renderer="rRender"/></td>
			<td class="FieldLabel" style="width:18%">其中妇女党员人数：</td>
			<td class="FieldInput" style="width:14%"><label field="femaleNum" renderer="rRender"/></td>
			<td class="FieldLabel" style="width:18%">其中少数民族党员人数：</td>
			<td class="FieldInput" style="width:14%"><label field="folkNum" renderer="rRender"/></td>
		</tr>
	</table>
</fieldset>
</form>
</next:Html>
</next:Panel>

<next:EditGridPanel id="grid" title="党组织成员个人情况" dataset="peopleDs" width="100%" stripeRows="true" height="99.9%">
	<next:Columns>
		<next:RowNumberColumn></next:RowNumberColumn>
		<next:RadioBoxColumn></next:RadioBoxColumn>
		<next:Column field="name" header="姓名" width="90" sortable="false"/>
		<next:Column field="sex" header="性别" dataset="sexDataSet" width="90" sortable="false"/>
		<next:Column field="age" header="年龄" width="90" sortable="false"/>
		<next:Column field="folk" header="民族" dataset="NationDataset" width="90" sortable="false"/>
		<next:Column field="political" header="政治面貌" dataset="politicalDataSet" width="90" sortable="false"/>
		<next:Column field="education" header="文化程度" dataset="educationDataSet" width="90" sortable="false"/>
		<next:Column field="ifFirst" header="是否初次当选" dataset="YorN" width="90" sortable="false"/>
		<next:Column field="ifReduty" header="是否连选连任" dataset="YorN" width="90" sortable="false"/>
		<next:Column field="duty" header="兼任村委会职务" dataset="YorN" width="90" sortable="false"/>
		<next:Column field="peopleSource" header="党组织成员来源" dataset="YorN" width="90" sortable="false"/>
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
		partyDs.newRecord({"organCode":organ_Code,"organName":orgName,"parentCode":parentCode,
			"reportType":"N","recordId":recordId});
	});
	var partyDs=L5.DatasetMgr.lookup("partyDs");
	var peopleDs=L5.DatasetMgr.lookup("peopleDs");
	var reportWorkDataSet=L5.DatasetMgr.lookup("reportWorkDataSet");
	reportWorkDataSet.load();
	partyDs.setParameter("RECORD_ID@=",'<%=request.getParameter("recordId")%>');
	partyDs.on("load",function(){
		var nominate = partyDs.getCurrent();
		if(nominate==null){
			OrgNameDataset.setParameter("filterSql","USER_ID='"+organ_Code+"'");
			OrgNameDataset.load();
		}
	});
	partyDs.load();
	reportWorkDataSet.load();
	peopleDs.setParameter("RECORD_ID@=",recordId);
	peopleDs.setParameter("TYPE@=","D");
	peopleDs.load();
}
function returnBack(){
	history.go(-1);
}
function rRender(val){
	if(val!=""){
		return val+" 人";
	}
}
</script>