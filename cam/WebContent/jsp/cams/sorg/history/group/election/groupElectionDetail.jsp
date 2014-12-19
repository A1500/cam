<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<html>
<head>
<title>社会团体换届审批</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="groupElectionEdit.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js") %>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js") %>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams/sorgUpload.js")%>'></script>
<script type="text/javascript">var rootPath='<%=SkinUtils.getRootUrl(request)%>';</script>
<script type="text/javascript">
	var method='<%=request.getParameter("method")%>';
	var sorgId='<%=request.getParameter("sorgId")%>';
	var cnName=decodeURIComponent('<%=request.getParameter("cnName")%>');
	var sorgCode='<%=request.getParameter("sorgCode")%>';
	var electionId='<%=request.getParameter("electionId")%>';
	var applyType='009';
	var taskCode='<%=request.getParameter("taskCode")%>';
	var searchCnName=decodeURIComponent('<%=request.getParameter("searchCnName")%>');
	var searchSorgCode='<%=request.getParameter("searchSorgCode")%>';
</script>
</head>
<body>
<model:datasets>
    <model:dataset id="somElectionDataSet" cmd="com.inspur.cams.sorg.history.election.cmd.SomElectionQueryCmd" method="queryElection">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomElection"/>
	</model:dataset>
	<model:dataset id="somAspchiefDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomAspchiefQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomAspchief"/>
	</model:dataset>
	<model:dataset id="somApplyDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomApplyQueryCmd">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomApply"/>
	</model:dataset>
	<%--电子档案--%>
	<model:dataset id="somElectronicDataSet" cmd="com.inspur.cams.sorg.upload.cmd.SomElectronicQueryCmd" global="true" method="queryCatalog">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomElectronic"></model:record>
	</model:dataset>
	<%--下载窗口--%>
	<model:dataset id="downloadDataSet" cmd="com.inspur.cams.sorg.upload.cmd.SomElectronicQueryCmd" method="queryElectronic">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomElectronic"></model:record>
	</model:dataset>
	<%--定义字典表--%>
	<model:dataset id="cataLogCodeSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='SOM_CATALOG'></model:param>
			<model:param name="value" value='CATALOG_CODE'></model:param>
			<model:param name="text" value='CATALOG_NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="sorgDutiesDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_SOM_DUTY'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 政治面貌 -->
	<model:dataset id="politicsSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_POLITICAL'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="sexDataSet" enumName="COMM.SEX" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="yesornoDataSet" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
</model:datasets>
<next:Panel width="100%" >
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="return" text="返回" handler="returnBack"></next:ToolBarItem>
	</next:TopBar>
	<next:TabPanel id="tabSomOrgan" width="100%" height="100%">
		<next:Tabs>
			<next:Panel id="panelSomOrgan" title="社会团体换届审批" width="100%" height="100%" autoScroll="true">
				<next:Panel>
					<next:Html>
						<form id="ElectionForm" method="post" dataset="somElectionDataSet" onsubmit="return false" class="L5form">
							<input type="hidden" id="sorgId" field="sorgId" value="社会团体ID">
							<fieldset>
							<legend>社会团体换届（成立）事先报批表</legend>
							<table width="100%">
								<tr>
									<td class="FieldLabel" style="width:18%">社团名称：</td>
									<td class="FieldInput" style="width:36%"><label id="cnName"/></td>
									<td class="FieldLabel" style="width:16%">登记证号：</td>
									<td class="FieldInput" style="width:30%"><label id="sorgCode"/></td>
								</tr>
								<tr>
									<td class="FieldLabel">联系人：</td>
									<td class="FieldInput"><label field="linkPeople"></td>
									<td class="FieldLabel">联系电话：</td>
									<td class="FieldInput"><label field="linkPhone"></td>
								</tr>
								<tr>
									<td class="FieldLabel">会议名称：</td>
									<td class="FieldInput" colspan="3"><label field="meetingName"></td>
								</tr>
								<tr>
									<td class="FieldLabel">召开时间：</td>
									<td class="FieldInput"><label field="meetingDate"/></td>
									<td class="FieldLabel">召开地点：</td>
									<td class="FieldInput"><label field="meetingPlace"></td>
								</tr>
								<tr>
									<td class="FieldLabel">参会主要人员：</td>
									<td class="FieldInput"><label field="mainPeople"></td>
									<td class="FieldLabel">参会人数：</td>
									<td class="FieldInput"><label field="shouldNum"></td>
								</tr>
								<tr>
									<td class="FieldLabel">上次换届时间：</td>
									<td class="FieldInput"><label field="lastDate"/></td>
									<td class="FieldLabel">应到届时间：</td>
									<td class="FieldInput"><label field="nextDate"/></td>
								</tr>
								<tr>
									<td class="FieldLabel">是否制定或修改会费标准：</td>
									<td class="FieldInput"><label field="ifMakeFee" dataset="yesornoDataSet"/></td>
									<td class="FieldLabel">候选人人数：</td>
									<td class="FieldInput"><label field="chiefNum"></td>
								</tr>
							</table>
						</form>
					</next:Html>
				</next:Panel>
				<next:EditGridPanel id="aspchiefGrid" dataset="somAspchiefDataSet" height="100%" width="98.5%" stripeRows="true">
					<next:TopBar>
						<next:ToolBarItem symbol="领导职务候选人基本情况"></next:ToolBarItem>
						<next:ToolBarItem symbol="->"></next:ToolBarItem>
					</next:TopBar>
					<next:Columns>
						<next:RowNumberColumn/>
						<next:RadioBoxColumn></next:RadioBoxColumn>
						<next:Column header="身份证号" field="idCard" width="15%"></next:Column>
						<next:Column header="姓名" field="name" width="10%"></next:Column>
						<next:Column header="性别" field="sex" width="10%" editable="false"><next:ComboBox dataset="sexDataSet"/></next:Column>
						<next:Column header="出生年月" field="birthday" width="10%"></next:Column>
						<next:Column header="政治面貌" field="politics" width="15%" editable="false"><next:ComboBox dataset="politicsSelect"/></next:Column>
						<next:Column header="户口所在地" field="populace" width="10%"></next:Column>
						<next:Column header="拟任社团职务" field="sorgDuties" width="10%" editable="false"><next:ComboBox dataset="sorgDutiesDataSet"/></next:Column>
						<next:Column header="人事关系所在单位" field="workName" width="19%"></next:Column>
						<next:Column header="职务" field="workDuties" width="10%"></next:Column>
						<next:Column header="批准兼职组织人事部门" field="promiseOrgan" width="15%"></next:Column>
						<next:Column header="文号" field="promiseCode" width="10%"></next:Column>
						<next:Column header="担任其他社团职务" field="otherDuties" width="15%"></next:Column>
						<next:Column header="刑事处罚情况" field="penal" width="15%"></next:Column>
					</next:Columns>
				</next:EditGridPanel>
				<next:Panel width="98.5%" autoScroll="true">
					<next:Html>
						<form id="form2" method="post" dataset="somApplyDataSet" onsubmit="return false" class="L5form">
							<fieldset>
							<legend>审查意见</legend>
							<table width="100%">
								<tr>
									<td class="FieldLabel">业务主管单位审查意见：</td>
									<td class="FieldInput" colspan="5"><textarea field="borgOpinion" cols="65" rows="2" readonly="readonly" style="width:97%"></textarea></td>
								</tr>
								<tr>
									<td class="FieldLabel" style="width:17%">业务主管单位：</td>
									<td class="FieldInput" style="width:17%"><label field="borgName"></td>
									<td class="FieldLabel" style="width:17%">业务主管单位审查日期：</td>
									<td class="FieldInput" style="width:49%"><label field="borgCheckDate"></td>
								</tr>
								<tr>
									<td class="FieldLabel">承办人：</td>
									<td class="FieldInput"><label field="acceptPeopleName"></td>
									<td class="FieldLabel">承办日期：</td>
									<td class="FieldInput"><label field="acceptTime"></td>
								</tr>
								<tr>
									<td class="FieldLabel">初审意见：</td>
									<td class="FieldInput" colspan="5"><textarea field="examinOpinion" cols="65" rows="2" readonly="readonly" style="width:97%"></textarea></td>
								</tr>
								<tr>
									<td class="FieldLabel">初审人：</td>
									<td class="FieldInput"><label field="examinPeopleName"></td>
									<td class="FieldLabel">初审日期：</td>
									<td class="FieldInput"><label field="examinTime"></td>
								</tr>
								<tr>
									<td class="FieldLabel">核准意见：</td>
									<td class="FieldInput" colspan="5"><textarea field="checkOpinion" cols="65" rows="2" readonly="readonly" style="width:97%"></textarea></td>
								</tr>
								<tr>
									<td class="FieldLabel">核准人：</td>
									<td class="FieldInput"><label field="checkPeopleName"></td>
									<td class="FieldLabel">核准日期：</td>
									<td class="FieldInput"><label field="checkTime"></td>
								</tr>
							</table>
							</fieldset>
						</form>
					</next:Html>
				</next:Panel>
			</next:Panel>
			<next:EditGridPanel id="uploadGrid" title="法律要件" width="100%" stripeRows="true" height="100%" dataset="somElectronicDataSet">
				<next:TopBar>
					<next:ToolBarItem symbol="附件列表"></next:ToolBarItem>
					<next:ToolBarItem symbol="->"></next:ToolBarItem>
				</next:TopBar>
				<next:Columns>
					<next:RowNumberColumn />
					<next:RadioBoxColumn></next:RadioBoxColumn>
					<next:Column header="档案目录名"  field="catalogCode" width="38%" editable="false" dataset="cataLogCodeSelect" ><next:TextField /></next:Column>
					<next:Column header="附件名称"    field="fileName" width="30%" editable="false"><next:TextField /></next:Column>
					<next:Column header="附件描述"    field="fileMess" width="20%" editable="false"><next:TextField /></next:Column>
					<next:Column header="下载附件"    field="" width="10%" editable="false" renderer="clickDownloadHref"><next:TextField /></next:Column>
				</next:Columns>
				<next:BottomBar>
					<next:PagingToolBar dataset="somElectronicDataSet" />
				</next:BottomBar>
			</next:EditGridPanel>
		</next:Tabs>
	</next:TabPanel>
</next:Panel>
<jsp:include page="../../../comm/upload/uploadWindow.jsp" flush="true"/>
</body>
</html>