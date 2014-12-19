<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<title>农村民主决策情况填报</title>
<next:ScriptManager/>
<script type="text/javascript">
	var recordId='<%=request.getParameter("recordId")%>';
</script>
<script language="javascript">
function init(){
	var ds=L5.DatasetMgr.lookup("decisionDataSet");
	ds.setParameter("RECORD_ID@=",recordId);
	ds.load();
	ds.on("load",function(){
		getPer();
	});
	var infoDataSet=L5.DatasetMgr.lookup("infoDataSet"); 
	infoDataSet.setParameter("RECORD_ID@=",recordId);
	infoDataSet.load();
}
function returnBack(){
	history.go(-1);
}
function getPer(){var decisionDataSet=L5.DatasetMgr.lookup("decisionDataSet");
	var rec=decisionDataSet.getCurrent();
	if(rec.get("meetingShouldNum")=="0"){
		rec.set("meetingRealPer", "--");
	}else{
		rec.set("meetingRealPer", Math.round((rec.get("meetingRealNum")/rec.get("meetingShouldNum"))*10000)/100);
	}
	if(rec.get("meetingRealNum")=="0"){
		rec.set("meetingAgreePer", "--");
		rec.set("meetingUnagreePer", "--");
		rec.set("meetingGiveupPer", "--");
	}else{
		rec.set("meetingAgreePer", Math.round((rec.get("meetingAgreeNum")/rec.get("meetingRealNum"))*10000)/100);
		rec.set("meetingUnagreePer", Math.round((rec.get("meetingUnagreeNum")/rec.get("meetingRealNum"))*10000)/100);
		rec.set("meetingGiveupPer", Math.round((rec.get("meetingGiveupNum")/rec.get("meetingRealNum"))*10000)/100);
	}
	if(rec.get("sovietShouldNum")=="0"){
		rec.set("sovietRealPer", "--");
	}else{
		rec.set("sovietRealPer", Math.round((rec.get("sovietRealNum")/rec.get("sovietShouldNum"))*10000)/100);
	}
	if(rec.get("sovietRealNum")=="0"){
		rec.set("sovietAgreePer", "--");
		rec.set("sovietUnagreePer", "--");
		rec.set("sovietGiveupPer", "--");
		rec.set("sovietFemalePer", "--");
	}else{
		rec.set("sovietAgreePer",Math.round((rec.get("sovietAgreeNum")/rec.get("sovietRealNum"))*10000)/100);
		rec.set("sovietUnagreePer",Math.round((rec.get("sovietUnagreeNum")/rec.get("sovietRealNum"))*10000)/100);
		rec.set("sovietGiveupPer",Math.round((rec.get("sovietGiveupNum")/rec.get("sovietRealNum"))*10000)/100);
		rec.set("sovietFemalePer",Math.round((rec.get("sovietFemaleNum")/rec.get("sovietRealNum"))*10000)/100);
	}
	if(rec.get("refShouldNum")=="0"){
		rec.set("refRealPer", "--");
	}else{
		rec.set("refRealPer",Math.round((rec.get("refRealNum")/rec.get("refShouldNum"))*10000)/100);
	}
	if(rec.get("refRealNum")=="0"){
		rec.set("refAgreePer", "--");
		rec.set("refUnagreePer", "--");
		rec.set("refGiveupPer", "--");
	}else{
		rec.set("refAgreePer",Math.round((rec.get("refAgreeNum")/rec.get("refRealNum"))*10000)/100);
		rec.set("refUnagreePer",Math.round((rec.get("refUnagreeNum")/rec.get("refRealNum"))*10000)/100);
		rec.set("refGiveupPer",Math.round((rec.get("refGiveupNum")/rec.get("refRealNum"))*10000)/100);
	}
}
function cRender(val){
	if(val!=""){
		return val+" 次";
	}
}
function rRender(val){
	if(val!=""){
		return val+" 人";
	}
}
function hRender(val){
	if(val!=""){
		return val+" 户";
	}
}
function bRender(val){
	if(val!=""){
		return val+" %";
	}
}
</script>
</head>
<body>
<model:datasets>
	<model:dataset id="decisionDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcDecisionReportQueryCmd" pageSize="20">
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcDecisionReport">
			<model:field name="meetingRealPer" type="string"/>
			<model:field name="meetingAgreePer" type="string"/>
			<model:field name="meetingUnagreePer" type="string"/>
			<model:field name="meetingGiveupPer" type="string"/>
			<model:field name="sovietRealPer" type="string"/>
			<model:field name="sovietAgreePer" type="string"/>
			<model:field name="sovietUnagreePer" type="string"/>
			<model:field name="sovietGiveupPer" type="string"/>
			<model:field name="sovietFemalePer" type="string"/>
			<model:field name="refRealPer" type="string"/>
			<model:field name="refAgreePer" type="string"/>
			<model:field name="refUnagreePer" type="string"/>
			<model:field name="refGiveupPer" type="string"/>
		</model:record>
	</model:dataset>
		<model:dataset id="infoDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcDecisionInfoQueryCmd" >
		<model:record fromBean="com.inspur.cams.cdc.base.data.CdcDecisionInfo"/>
	</model:dataset>
	<model:dataset id="reportWorkDataSet" cmd="com.inspur.cams.cdc.base.cmd.CdcReportWorkQueryCmd" method="getDic" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"/>
		<model:params>
			<model:param name="reportType" value='R13'/>
			<model:param name="organType" value='N'/>
		</model:params>
	</model:dataset>
	<model:dataset id="meetingTypeDs" enumName="CDC.MEETING.TYPE" autoLoad="true" global="true"/>
</model:datasets>
<next:Panel width="99%" autoScroll="true">
<next:TopBar>
	<next:ToolBarItem symbol="->"/>
	<next:ToolBarItem iconCls="return" text="返回" handler="returnBack"/>
</next:TopBar>
<next:Html>
<form id="form1" method="post" dataset="decisionDataSet" onsubmit="return false" class="L5form">
<fieldset id="cdcFieldset">
<legend>填报情况</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel">填报单位：</td>
			<td class="FieldInput" colspan="3"><label field="organName"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">填报日期：</td>
			<td class="FieldInput" style="width:36%"><label field="reportDate" dataset="reportWorkDataSet"/></td>
			<td class="FieldLabel" style="width:16%">上报日期：</td>
			<td class="FieldInput" style="width:30%"><label field="submitDate"/></td>
		</tr>
	</table>
</fieldset>
<fieldset id="cdcFieldset">
<legend>民主决策情况</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel" style="width:8%" rowspan="4">村民会议：</td>
			<td class="FieldLabel" style="width:18%">村民会议次数：</td>
			<td class="FieldInput" style="width:16%" colspan="5"><label id="meetingNum" field="meetingNum" renderer="cRender"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">应到村民（户代表）人数：</td>
			<td class="FieldInput" style="width:16%"><label field="meetingShouldNum" renderer="rRender"/></td>
			<td class="FieldLabel" style="width:18%">实到村民（户代表）人数：</td>
			<td class="FieldInput" style="width:16%"><label field="meetingRealNum" renderer="rRender"/></td>
			<td class="FieldLabel" style="width:18%">实到人数占比：</td>
			<td class="FieldInput" style="width:16%"><label field="meetingRealPer" renderer="bRender"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">同意人数：</td>
			<td class="FieldInput" style="width:16%"><label field="meetingAgreeNum" renderer="rRender"/></td>
			<td class="FieldLabel" style="width:18%">不同意人数：</td>
			<td class="FieldInput" style="width:16%"><label field="meetingUnagreeNum" renderer="rRender"/></td>
			<td class="FieldLabel" style="width:18%">弃权人数：</td>
			<td class="FieldInput" style="width:16%"><label field="meetingGiveupNum" renderer="rRender"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">同意人数占比：</td>
			<td class="FieldInput" style="width:16%"><label field="meetingAgreePer" renderer="bRender"/></td>
			<td class="FieldLabel" style="width:18%">不同意人数占比：</td>
			<td class="FieldInput" style="width:16%"><label field="meetingUnagreePer" renderer="bRender"/></td>
			<td class="FieldLabel" style="width:18%">弃权人数占比：</td>
			<td class="FieldInput" style="width:16%"><label field="meetingGiveupPer" renderer="bRender"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:8%" rowspan="5">村民代表会议：</td>
			<td class="FieldLabel" style="width:18%">村民代表会议次数：</td>
			<td class="FieldInput" style="width:16%" colspan="5"><label field="sovietNum" renderer="cRender"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">应到村民代表组成人员人数：</td>
			<td class="FieldInput" style="width:16%"><label field="sovietShouldNum" renderer="rRender"/></td>
			<td class="FieldLabel" style="width:18%">实到村民代表组成人员人数：</td>
			<td class="FieldInput" style="width:16%"><label field="sovietRealNum" renderer="rRender"/></td>
			<td class="FieldLabel" style="width:18%">实到人数占比：</td>
			<td class="FieldInput" style="width:16%"><label field="sovietRealPer" renderer="bRender"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">同意人数：</td>
			<td class="FieldInput" style="width:16%"><label field="sovietAgreeNum" renderer="rRender"/></td>
			<td class="FieldLabel" style="width:18%">不同意人数：</td>
			<td class="FieldInput" style="width:16%"><label field="sovietUnagreeNum" renderer="rRender"/></td>
			<td class="FieldLabel" style="width:18%">弃权人数：</td>
			<td class="FieldInput" style="width:16%"><label field="sovietGiveupNum" renderer="rRender"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">同意人数占比：</td>
			<td class="FieldInput" style="width:16%"><label field="sovietAgreePer" renderer="bRender"/></td>
			<td class="FieldLabel" style="width:18%">不同意人数占比：</td>
			<td class="FieldInput" style="width:16%"><label field="sovietUnagreePer" renderer="bRender"/></td>
			<td class="FieldLabel" style="width:18%">弃权人数占比：</td>
			<td class="FieldInput" style="width:16%"><label field="sovietGiveupPer" renderer="bRender"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">妇女参加人数：</td>
			<td class="FieldInput"><label field="sovietFemaleNum" renderer="rRender"/></td>
			<td class="FieldLabel" style="width:18%">妇女参加人数占比：</td>
			<td class="FieldInput" colspan="3"><label field="sovietFemalePer" renderer="bRender"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:8%" rowspan="4">村民公决：</td>
			<td class="FieldLabel" style="width:18%">村民公决次数：</td>
			<td class="FieldInput" style="width:16%" colspan="5"><label field="refNum" renderer="cRender"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">实际户数：</td>
			<td class="FieldInput" style="width:16%"><label field="refShouldNum" renderer="hRender"/></td>
			<td class="FieldLabel" style="width:18%">参加表决的户数：</td>
			<td class="FieldInput" style="width:16%"><label field="refRealNum" renderer="hRender"/></td>
			<td class="FieldLabel" style="width:18%">参加表决的户数占比：</td>
			<td class="FieldInput" style="width:16%"><label field="refRealPer" renderer="bRender"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">同意户数：</td>
			<td class="FieldInput" style="width:16%"><label field="refAgreeNum" renderer="hRender"/></td>
			<td class="FieldLabel" style="width:18%">不同意户数：</td>
			<td class="FieldInput" style="width:16%"><label field="refUnagreeNum" renderer="hRender"/></td>
			<td class="FieldLabel" style="width:18%">弃权户数：</td>
			<td class="FieldInput" style="width:16%"><label field="refGiveupNum" renderer="hRender"/></td>
		</tr>
		<tr>
			<td class="FieldLabel" style="width:18%">同意户数占比：</td>
			<td class="FieldInput" style="width:16%"><label field="refAgreePer" renderer="bRender"/></td>
			<td class="FieldLabel" style="width:18%">不同意户数占比：</td>
			<td class="FieldInput" style="width:16%"><label field="refUnagreePer" renderer="bRender"/></td>
			<td class="FieldLabel" style="width:18%">弃权户数占比：</td>
			<td class="FieldInput" style="width:16%"><label field="refGiveupPer" renderer="bRender"/></td>
		</tr>
	</table>
</fieldset>
</form>
</next:Html>
</next:Panel>
<next:EditGridPanel id="grid" dataset="infoDataSet" width="99%" stripeRows="true" height="300">
	<next:Columns>
		<next:RowNumberColumn></next:RowNumberColumn>
		<next:Column field="meetingType" header="类型" dataset= "meetingTypeDs" width="10%" sortable="false" align="right"/>
		<next:Column field="meetingContent" header="主题内容" width="15%" sortable="false" align="right"/>
		<next:Column field="shouldNum" header="应到人数" width="10%" editable="false" sortable="false" align="center"></next:Column>
		<next:Column field="realNum" header="实到人数" width="10%" sortable="false"  align="center"></next:Column>
		<next:Column field="femaleNum" header="妇女人数" width="10%" sortable="false" align="center"/>
		<next:Column field="agreeNum" header="同意人数" width="10%" sortable="false" align="right"/>
		<next:Column field="unagreeNum" header="不同意人数" width="10%" sortable="false" align="right"/>
		<next:Column field="giveupNum" header="弃权人数" width="10%" sortable="false" align="right"/>
		<next:Column field="meetingDate" header="会议时间" width="10%" sortable="false" align="right"/>
	</next:Columns>
	<next:BottomBar>
		<next:PagingToolBar dataset="infoDataSet"/>
	</next:BottomBar>
</next:EditGridPanel>
</body>
</html>
