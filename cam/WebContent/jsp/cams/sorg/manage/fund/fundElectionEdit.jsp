<%@ page language="java" contentType="text/html;charset=utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.*"%>
<%@page import="com.inspur.cams.sorg.util.SomIdHelp"%>
<html>
<head>
<title>基金会换届审批</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="fundElectionEdit.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js") %>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js") %>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams/sorgUpload.js")%>'></script>
<script type="text/javascript">var rootPath='<%=SkinUtils.getRootUrl(request)%>';</script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"My97DatePicker/WdatePicker.js") %>'></script>
<%
	String taskCode = request.getParameter("taskCode");
	String method = request.getParameter("method");
	if ("insert".equals(method)) {
		taskCode = StrUtil.n2b(SomIdHelp.getFundTaskCode());
	}
%>

<script type="text/javascript">
	var method='<%=method%>';
	var sorgId='<%=request.getParameter("sorgId")%>';
	var cnName=decodeURIComponent('<%=request.getParameter("cnName")%>');
	var sorgCode='<%=request.getParameter("sorgCode")%>';
	var borgName='<%=request.getParameter("borgName")%>';
	var electionId='<%=request.getParameter("electionId")%>';
	var applyType="209";
	var taskCode = '<%=taskCode%>';//生成业务编号
	var searchCnName=decodeURIComponent('<%=request.getParameter("searchCnName")%>');
	var searchSorgCode='<%=request.getParameter("searchSorgCode")%>';
</script>
</head>
<body>
<model:datasets>
	<model:dataset id="somElectionDataSet"cmd="com.inspur.cams.sorg.base.cmd.SomElectionQueryCmd"method="queryElection">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomElection">
			<model:field name="linkPeople" type="string" rule="length{72}" />
			<model:field name="linkPhone" type="string" rule="length{30}" />
			<model:field name="meetingName" type="string" rule="length{100}" />
			<model:field name="meetingDate" type="string" rule="length{10}" />
			<model:field name="meetingPlace" type="string" rule="length{100}" />
			<model:field name="mainPeople" type="string" rule="length{500}" />
			<model:field name="lastDate" type="string" rule="length{10}" />
			<model:field name="nextDate" type="string" rule="length{10}" />
			<model:field name="chiefNum" type="string" rule="length{6}" />
			<model:field name="councilNum" type="string" rule="length{6}" />
			<model:field name="supervisorNum" type="string" rule="length{6}" />
		</model:record>
	</model:dataset>
	<!-- 监事备案 -->
	<model:dataset id="aspForJianShi"
		cmd="com.inspur.cams.sorg.base.cmd.SomAspchiefQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomAspchief">
			<model:field name="name" type="string" rule="require|length{72}" />
			<model:field name="phone" type="string" rule="length{30}" />
			<model:field name="sorgDuties" type="string" rule="require" />
			<model:field name="populace" type="string" rule="length{100}" />
			<model:field name="workOpinion" type="string" rule="length{200}" />
			<model:field name="citizenship" type="string" rule="length{10}" />
		</model:record>
	</model:dataset>
	<!-- 理事备案 -->
	<model:dataset id="aspForLiShi"
		cmd="com.inspur.cams.sorg.base.cmd.SomAspchiefQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomAspchief">
			<model:field name="name" type="string" rule="require|length{72}" />
			<model:field name="phone" type="string" rule="length{30}" />
			<model:field name="sorgDuties" type="string" rule="require" />
			<model:field name="populace" type="string" rule="length{100}" />
			<model:field name="workOpinion" type="string" rule="length{200}" />
			<model:field name="citizenship" type="string" rule="length{10}" />
		</model:record>
	</model:dataset>
	<!-- 新增人员 -->
	<model:dataset id="peopleInsertDataset"
		cmd="com.inspur.cams.sorg.base.cmd.SomAspchiefQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomAspchief">
			<model:field name="name" type="string" rule="require" />
			<model:field name="workName" type="string" rule="length{100}" />
			<model:field name="workName" type="string" rule="length{100}" />
			<model:field name="workDuties" type="string" rule="length{10}" />
			<model:field name="age" type="string" rule="length{2}" />
			<model:field name="sorgDuties" type="string" rule="require" />
			<model:field name="relative" type="string" rule="length{100}" />
			<model:field name="otherDuties" type="string" rule="length{500}" />
		</model:record>
	</model:dataset>
	<!-- 负责人 -->
	<model:dataset id="CurrentDataset"
		cmd="com.inspur.cams.sorg.base.cmd.SomAspchiefQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomAspchief">
			<model:field name="name" type="string" rule="require" />
		</model:record>
	</model:dataset>
	<!-- 业务 -->
	<model:dataset id="somApplyDataSet"cmd="com.inspur.cams.sorg.base.cmd.SomApplyQueryCmd">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomApply">
			<model:field name="borgOpinion" type="string" rule="length{100}" />
			<model:field name="examinOpinion" type="string" rule="length{200}" />
			<model:field name="checkOpinion" type="string" rule="length{200}" />
		</model:record>
	</model:dataset>
	<!-- 人员简历 -->
	<model:dataset id="somResumeInsertDataSet"
		cmd="com.inspur.cams.sorg.base.cmd.SomPeopleResumeQueryCommand"
		global="true">
		<model:record
			fromBean="com.inspur.cams.sorg.base.data.SomPeopleResume"></model:record>
	</model:dataset>
	<model:dataset id="somPartyMemberDataSet" cmd="com.inspur.cams.sorg.manage.cmd.SomPartyMemberQueryCmd" >
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomPartyMember"></model:record>
	</model:dataset>
	<%--电子档案--%>
	<model:dataset id="somElectronicDataSet"
		cmd="com.inspur.cams.sorg.upload.cmd.SomElectronicQueryCmd"
		global="true" method="queryCatalog">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomElectronic"></model:record>
	</model:dataset>
	<%--电子档案上传窗口--%>
	<model:dataset id="winElectronicDataSet"
		cmd="com.inspur.cams.sorg.upload.cmd.SomElectronicQueryCmd"
		global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomElectronic"></model:record>
	</model:dataset>
	<%--下载窗口--%>
	<model:dataset id="downloadDataSet" cmd="com.inspur.cams.sorg.upload.cmd.SomElectronicQueryCmd" method="queryElectronic">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomElectronic"></model:record>
	</model:dataset>
	<%--定义字典表--%>
	<model:dataset id="cataLogCodeSelect"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='SOM_CATALOG'></model:param>
			<model:param name="value" value='CATALOG_CODE'></model:param>
			<model:param name="text" value='CATALOG_NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="sorgDutiesSelect"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_SOM_DUTY'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 社会组织职务 -->
	<model:dataset id="sorgDutiesDataSet"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_SOM_DUTY'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 社会组织种类 -->
	<model:dataset id="sorgKindSelect"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_FUND_KIND'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 业务主管单位 -->
	<model:dataset id="businessOrganSelect"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true" sortField="ORDER_NUMBER">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='SOM_BUSINESS_ORGAN'></model:param>
			<model:param name="value" value='BORG_CODE'></model:param>
			<model:param name="text" value='BORG_NAME'></model:param>
			<model:param name="filterSql" value='<%="MORG_CODE ="+BspUtil.getOrganCode().substring(0,6)%>'></model:param>
			</model:params>
	</model:dataset>
	<!-- 性别 -->
	<model:dataset id="sexSelect"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_SEX'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 政治面貌 -->
	<model:dataset id="politicsDataSet"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_POLITICAL'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 专兼职 -->
	<model:dataset id="ifFulltimeDataSet"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_IF_FULLTIME'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 民族 -->
	<model:dataset id="folkDataSet"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_NATION'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 证件类型 -->
	<model:dataset id="cardTypeDS"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true"
		autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_CARD_TYPE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="comm_yesorno" enumName="COMM.YESORNO"
		autoLoad="true" global="true"></model:dataset>
	<model:dataset id="opinionSelect" enumName="WORKFLOW.OPINION"
		autoLoad="true" global="true"></model:dataset>
	<model:dataset id="hisOpinionDataSet" enumName="WORKFLOW.OPINION"
		autoLoad="true" global="true"></model:dataset>
	<model:dataset id="yesornoDataSet" enumName="COMM.YESORNO"
		autoLoad="true" global="true"></model:dataset>
</model:datasets>
<next:Panel width="100%" autoScroll="true">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="print" text="打印《社会组织筹建党组织告知书》" handler="printParty"></next:ToolBarItem>
		<next:ToolBarItem iconCls="save" text="保存" handler="save"></next:ToolBarItem>
		<next:ToolBarItem iconCls="return" text="返回" handler="returnBack"></next:ToolBarItem>
	</next:TopBar>
	<next:TabPanel id="tabSomOrgan" width="100%" height="100%">
		<next:Tabs>
			<next:Panel id="panelSomOrgan" title="基金会换届（成立）选举报批表" width="100%"
				height="100%" autoScroll="true">
				<next:Html>
					<form id="ElectionForm" method="post" dataset="somElectionDataSet" onsubmit="return false" class="L5form"><input type="hidden" id="sorgId" field="sorgId" value="基金会ID">
					<fieldset><legend>基金会换届（成立）选举报批表</legend>
					<table width="100%">
						<tr>
							<td class="FieldLabel" style="width: 17%">基金会名称：</td>
							<td class="FieldInput"><label id="cnName" /></td>
							<td class="FieldLabel" style="width: 17%">登记证号：</td>
							<td class="FieldInput" colspan="3"><label id="sorgCode" /></td>
						</tr>
						<tr>
							<td class="FieldLabel">联系人：</td>
							<td class="FieldInput"><input type="text" name="联系人"
								field="linkPeople" maxlength="36" style="width: 90%"></td>
							<td class="FieldLabel">联系电话：</td>
							<td class="FieldInput" colspan="3"><input type="text"
								name="联系电话" field="linkPhone" maxlength="30"></td>
						</tr>
						<tr>
							<td class="FieldLabel">会议名称：</td>
							<td class="FieldInput" colspan="5"><input type="text"
								name="会议名称" field="meetingName" maxlength="50"
								style="width: 97%"></td>
						</tr>
						<tr>
							<td class="FieldLabel">召开时间：</td>
							<td class="FieldInput"><input type="text"
								field="meetingDate" style="width: 90%"
								format="Y-m-d" onclick="WdatePicker()" /></td>
							<td class="FieldLabel">召开地点：</td>
							<td class="FieldInput" colspan="3"><input type="text"
								name="召开地点" field="meetingPlace" maxlength="50"
								style="width: 90%"></td>
						</tr>
						<tr>
							<td class="FieldLabel">参会主要人员：</td>
							<td class="FieldInput" colspan="5"><textarea
								field="mainPeople" cols="65" rows="3" style="width: 97%"></textarea>
							</td>
						</tr>
						<tr>
							<td class="FieldLabel">上次换届时间：</td>
							<td class="FieldInput"><input type="text" field="lastDate"
								style="width: 90%" format="Y-m-d"
								onclick="WdatePicker()" /></td>
							<td class="FieldLabel">应到届时间：</td>
							<td class="FieldInput" colspan="3"><input type="text"
								field="nextDate" format="Y-m-d"
								onclick="WdatePicker()" /></td>
						</tr>
						<tr>
							<td class="FieldLabel" style="width: 17%">理事会候选人人数：</td>
							<td class="FieldInput" style="width: 17%">
								<label id="councilNum"/></td>
							<td class="FieldLabel" style="width: 17%">监事人数：</td>
							<td class="FieldInput" style="width: 17%"><label id="supervisorNum"/><</td>
							<td class="FieldLabel" style="width: 17%">负责人候选人人数：</td>
							<td class="FieldInput" style="width: 17%"><label id="chiefNum"/></td>
						</tr>
					</table>
					</form>
					<form id="form2" method="post" dataset="somApplyDataSet" onsubmit="return false" class="L5form">
					<fieldset><legend>业务主管单位意见</legend>
					<table width="100%">
						<tr>
							<td class="FieldLabel">业务主管单位审查意见：</td>
							<td class="FieldInput" colspan="5"><textarea
								field="borgOpinion" cols="65" rows="2" style="width: 97%"></textarea></td>
						</tr>
						<tr>
							<td class="FieldLabel" style="width: 17%">业务主管单位：</td>
							<td class="FieldInput" colspan="3"><select field="borgName" style="width: 80%" disabled="disabled"><option dataset="businessOrganSelect"></option></select></td>
							<td class="FieldLabel" style="width: 17%">业务主管单位审查日期：</td>
							<td class="FieldInput" style="width: 17%"><input type="text" field="borgCheckDate" format="Y-m-d" onclick="WdatePicker();" style="width: 90%"></td>
						</tr>
					</table>
					</fieldset>
					<fieldset><legend>登记管理机关意见</legend>
					<table width="100%">
						<tr>
							<td class="FieldLabel" style="width: 17%">承办人：</td>
							<td class="FieldInput" style="width: 17%"><input type="text"
								field="acceptPeopleName" maxlength="6" style="width: 90%"></td>
							<td class="FieldLabel" style="width: 17%">承办日期：</td>
							<td class="FieldInput" style="width: 15%"><input type="text"
								field="acceptTime" format="Y-m-d"
								onclick="WdatePicker();" style="width: 90%"></td>
							<td class="FieldInput" style="width: 34%"></td>
						</tr>
						<tr>
							<td class="FieldLabel">初审意见：</td>
							<td class="FieldInput" colspan="5"><textarea
								field="examinOpinion" cols="65" rows="2" style="width: 97%"></textarea></td>
						</tr>
						<tr>
							<td class="FieldLabel">初审人：</td>
							<td class="FieldInput"><input type="text"
								field="examinPeopleName" maxlength="6" style="width: 90%"></td>
							<td class="FieldLabel">初审日期：</td>
							<td class="FieldInput"><input type="text" field="examinTime"
								format="Y-m-d" onclick="WdatePicker();"
								style="width: 90%"></td>
							<td class="FieldInput"></td>
						</tr>
						<tr>
							<td class="FieldLabel">核准意见：</td>
							<td class="FieldInput" colspan="5"><textarea
								field="checkOpinion" cols="65" rows="2" style="width: 97%"></textarea></td>
						</tr>
						<tr>
							<td class="FieldLabel">核准人：</td>
							<td class="FieldInput"><input type="text"
								field="checkPeopleName" maxlength="6" style="width: 90%"></td>
							<td class="FieldLabel">核准日期：</td>
							<td class="FieldInput"><input type="text" field="checkTime"
								format="Y-m-d" onclick="WdatePicker();"
								style="width: 90%"></td>
							<td class="FieldInput"></td>
						</tr>
					</table>
					</fieldset>
					</form>
				</next:Html>
			</next:Panel>
			<next:Panel title="基金会人员基本情况" width="100%" height="100%"
				autoScroll="true">
				<next:EditGridPanel id="peopleGrid" dataset="aspForLiShi"
					 stripeRows="true" height="300" hasSum="true"
					title="基金会理事会候选人基本情况">
					<next:TopBar>
						<next:ToolBarItem symbol="->"></next:ToolBarItem>
						<next:ToolBarItem iconCls="add" text="新增" handler="addL"></next:ToolBarItem>
						<next:ToolBarItem iconCls="edit" text="修改" handler="updateL"></next:ToolBarItem>
						<next:ToolBarItem iconCls="delete" text="删除" handler="delL"></next:ToolBarItem>
					</next:TopBar>
					<next:Columns>
						<next:RowNumberColumn />
						<next:RadioBoxColumn></next:RadioBoxColumn>
						<next:Column header="姓名" field="name" width="15%" editable="false" summaryType="count">
							<next:ExtendConfig>
								summaryRenderer : countRender
							</next:ExtendConfig>
							<next:TextField />
						</next:Column>
						<next:Column header="性别" field="sex" width="6%" editable="false">
							<next:ComboBox dataset="sexSelect" />
						</next:Column>
						<next:Column header="年龄" field="age" width="8%"
							editable="false">
							<next:TextField />
						</next:Column>
						<next:Column header="拟任职务" field="sorgDuties" width="10%"
							editable="false">
							<next:ComboBox dataset="sorgDutiesSelect" />
						</next:Column>
						<next:Column header="是否是拟任法定代表人" field="ifLegal" width="15%" editable="true"><next:ComboBox dataset="yesornoDataSet"></next:ComboBox></next:Column>
						<next:Column header="人事关系所在单位" field="workName" width="10%"
							editable="false">
							<next:TextField />
						</next:Column>
						<next:Column header="人事关系所在单位职务" field="workDuties" width="15%"
							editable="false">
							<next:TextField />
						</next:Column>
						<next:Column header="专职/兼职" field="ifFulltime" width="10%"
							editable="false">
							<next:ComboBox dataset="ifFulltimeDataSet" />
						</next:Column>
						<next:Column header="是否退休" field="ifRetire" width="10%"
							editable="false">
							<next:ComboBox dataset="yesornoDataSet" />
						</next:Column>
						<next:Column header="亲属关系情况" field="relative" width="13%"
							editable="false">
							<next:TextField />
						</next:Column>
					</next:Columns>
				</next:EditGridPanel>
				<next:EditGridPanel id="peopleGrid1" dataset="aspForJianShi"
					 stripeRows="true" hasSum="true" height="250"
					title="基金会监事基本情况">
					<next:TopBar>
						<next:ToolBarItem symbol="->"></next:ToolBarItem>
						<next:ToolBarItem iconCls="add" text="新增" handler="addS"></next:ToolBarItem>
						<next:ToolBarItem iconCls="edit" text="修改" handler="updateS"></next:ToolBarItem>
						<next:ToolBarItem iconCls="delete" text="删除" handler="delS"></next:ToolBarItem>
					</next:TopBar>
					<next:Columns>
						<next:RowNumberColumn />
						<next:RadioBoxColumn></next:RadioBoxColumn>
						<next:Column header="姓名" field="name" width="15%" editable="false" summaryType="count">
							<next:ExtendConfig>
								summaryRenderer : countRenderS
							</next:ExtendConfig>
							<next:TextField />
						</next:Column>
						<next:Column header="性别" field="sex" width="10%" editable="false">
							<next:ComboBox dataset="sexSelect" />
						</next:Column>
						<next:Column header="年龄" field="age" width="10%"
							editable="false">
							<next:TextField />
						</next:Column>
						<next:Column header="人事关系所在单位" field="workName" width="10%"
							editable="false">
							<next:TextField />
						</next:Column>
						<next:Column header="人事关系所在单位职务" field="workDuties" width="15%"
							editable="false">
							<next:TextField />
						</next:Column>
						<next:Column header="专职/兼职" field="ifFulltime" width="10%"
							editable="false">
							<next:ComboBox dataset="ifFulltimeDataSet" />
						</next:Column>
						<next:Column header="是否退休" field="ifRetire" width="10%"
							editable="false">
							<next:ComboBox dataset="yesornoDataSet" />
						</next:Column>
					</next:Columns>
				</next:EditGridPanel>
				<next:EditGridPanel id="peopleGrid2" dataset="CurrentDataset"
					 stripeRows="true" hasSum="true" height="250"
					title="基金会负责人候选人基本情况">
					<next:TopBar>
						<next:ToolBarItem symbol="->"></next:ToolBarItem>
					</next:TopBar>
					<next:Columns>
						<next:RowNumberColumn />
						<next:RadioBoxColumn></next:RadioBoxColumn>
						<next:Column header="拟任职务" field="sorgDuties" width="15%"
							editable="false" summaryType="count">
							<next:ExtendConfig>
				summaryRenderer : countRenderF
			</next:ExtendConfig>
							<next:ComboBox dataset="sorgDutiesSelect" />
						</next:Column>
						<next:Column header="姓名" field="name" width="10%" editable="false">
							<next:TextField />
						</next:Column>
						<next:Column header="性别" field="sex" width="10%" editable="false">
							<next:ComboBox dataset="sexSelect" />
						</next:Column>
						<next:Column header="年龄" field="age" width="10%"
							editable="false">
							<next:TextField />
						</next:Column>
						<next:Column header="人事关系所在单位" field="workName" width="10%"
							editable="false">
							<next:TextField />
						</next:Column>
						<next:Column header="人事关系所在单位职务" field="workDuties" width="15%"
							editable="false">
							<next:TextField />
						</next:Column>
						<next:Column header="专职/兼职" field="ifFulltime" width="10%"
							editable="false">
							<next:ComboBox dataset="ifFulltimeDataSet" />
						</next:Column>
						<next:Column header="是否退休" field="ifRetire" width="10%"
							editable="false">
							<next:ComboBox dataset="yesornoDataSet" />
						</next:Column>
					</next:Columns>
				</next:EditGridPanel>
			</next:Panel>
			<next:Panel title="法律要件" >
				<next:EditGridPanel id="uploadGrid" width="100%" stripeRows="true" height="100%" dataset="somElectronicDataSet">
					<next:TopBar>
						<next:ToolBarItem symbol="附件列表"></next:ToolBarItem>
						<next:ToolBarItem symbol="->"></next:ToolBarItem>
						<next:ToolBarItem iconCls="add" text="增加上传附件" handler="clickUploadFile"></next:ToolBarItem>
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
			</next:Panel>
		</next:Tabs>
	</next:TabPanel>
</next:Panel>
<!-- 人员window -->
<next:Window id="peopleWin" title="人员基本情况" resizable="false" width="800" modal="true" closeAction="hide" autoScroll="true">
	<next:TopBar>
		<next:ToolBarItem text='' id="displayItem" />
		<next:ToolBarItem symbol="人员基本情况"></next:ToolBarItem>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="确定" iconCls="add" handler="confirm"></next:ToolBarItem>
		<next:ToolBarItem text="取消" iconCls="return" handler="closeWin"></next:ToolBarItem>
	</next:TopBar>
	<next:Panel id="peoplePanel">
		<next:Html>
			<form id="peopleFrom" method="post" dataset="peopleInsertDataset"
				onsubmit="return false" class="L5form">

			<table width="100%">
				<tr>
					<td class="FieldLabel" style="width: 15%">姓名：</td>
					<td class="FieldInput" style="width: 15%"><input type="text"
						field="name" name='"姓名"' style="width: 90%" /><span style="color: red">*</span></td>
					<td class="FieldLabel" style="width: 15%">性别：</td>
					<td class="FieldInput" style="width: 15%"><select id="sex"
						field="sex" name='"性别"' style="width: 90%">
						<option dataset="sexSelect"></option>
					</select></td>
					<td class="FieldLabel" style="width: 15%">年龄：</td>
					<td class="FieldInput" style="width: 15%"><input type="text"
						name='年龄'field="age" style="width: 90%" maxlength="2"/></td>
				</tr>
				<tr>

					<td class="FieldLabel" style="width: 15%">人事关系所在单位</td>
					<td class="FieldInput" style="width: 15%"><input type="text"
						field="workName" name='"人事关系所在单位"' style="width: 90%" /></td>
					<td class="FieldLabel" style="width: 15%">人事关系所在单位职务</td>
					<td class="FieldInput" style="width: 15%"><input type="text"
						field="workDuties" name='人事关系所在单位职务' style="width: 90%" /></td>
					<td class="FieldLabel" style="width: 15%">是否退休</td>
					<td class="FieldInput" style="width: 15%"><select field="ifRetire" name='是否退休' style="width: 90%">
						<option dataset="yesornoDataSet"></option>
					</select></td>

				</tr>
				<tr>
					<td class="FieldLabel">拟任职务：</td>
					<td class="FieldInput"><select id="sorgDuties" onchange="loadLegal();"
						field="sorgDuties" name='拟任职务' style="width: 90%">
						<option dataset="sorgDutiesDataSet"></option>
					</select><span style="color: red">*</span></td>
					<td class="FieldLabel" id="ifLegalLabel">是否是拟任法定代表人：</td>
						<td class="FieldInput" id="ifLegalInput">
							<select field="ifLegal" name='是否是拟任法定代表人'>
								<option dataset="comm_yesorno"></option>
							</select>
						</td>
					<td class="FieldLabel">专职/兼职：</td>
					<td class="FieldInput" id="ifFulltime"><select field="ifFulltime" name='专职/兼职'
						style="width: 90%">
						<option dataset="ifFulltimeDataSet"></option>
					</select></td>
				</tr>
				<tr>
					<td class="FieldLabel">亲属关系情况:</td>
					<td class="FieldInput" colspan="5"><input type="text"
						field="relative" name='亲属关系情况' style="width: 90%" /></td>
				</tr>
				<tr id="legal" style="display:none">
					<td class="FieldLabel" colspan="2">理事长担任其他组织法定代表人情况:</td>
					<td class="FieldInput" colspan="4"><input type="text"
						field="otherDuties" name='理事长担任其他组织法定代表人情况' style="width: 90%" /></td>
				</tr>
			</table>
			</form>
		</next:Html>
	</next:Panel>
</next:Window>
<next:Window id="printPartyWin" closeAction="hide" title="社会组织筹建党组织告知书" width="600"  autoScroll="true" modal="true">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem text="确定" iconCls="detail" handler="confirmPrint"></next:ToolBarItem>
		<next:ToolBarItem text="关闭" iconCls="return" handler="closePrintWin"></next:ToolBarItem>
	</next:TopBar>
	<next:Html>
		<form method="post" onsubmit="return false" class="L5form">
			<table width="100%">
				<tr>
					<td class="FieldLabel" style="width:10%"><label>联系人：</label></td>
					<td class="FieldInput" style="width:15%"><input id="linkmanName" style="width:90%"/></td>
					<td class="FieldLabel" style="width:10%"><label>联系电话：</label></td>
					<td class="FieldInput" style="width:15%"><input id="linkmanPhone" style="width:90%"/></td>
				</tr>
			</table>
		</form>
	</next:Html>
</next:Window>
<jsp:include page="../../comm/upload/uploadWindow.jsp" flush="true"/>
</body>
</html>