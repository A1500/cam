<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.StrUtil"%>
<%@page import="com.inspur.cams.sorg.util.SomIdHelp"%>
<%@page import="com.inspur.cams.comm.util.*"%>
<html>
<head>
<title>社会团体换届（成立）事先报批</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="somGroupElectionEdit.js"></script>
<script type="text/javascript" src="<%=SkinUtils.getJS(request, "bpm/bpm.js")%>"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js") %>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js") %>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams/sorgComm.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams/sorgUpload.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"My97DatePicker/WdatePicker.js") %>'></script>
<script type="text/javascript">var rootPath='<%=SkinUtils.getRootUrl(request)%>';</script>
<%
	String taskCode = request.getParameter("taskCode");
	String method=request.getParameter("method");
	if("INSERT".equals(method)){
		taskCode = StrUtil.n2b(SomIdHelp.getGroupTaskCode());
	}
%>
<script type="text/javascript">
	var processId='<%=request.getParameter("processId")%>';
	var actDefUniqueId='<%=request.getParameter("actDefUniqueId")%>';
	var assignmentId='<%=request.getParameter("assignmentId")%>';
	var method='<%=method%>';
	var sorgId='<%=request.getParameter("sorgId")%>';
	var applyType="009";
	var taskCode = '<%=taskCode%>';//生成业务编号
	var act ='<%=request.getParameter("act")%>';
</script>
</head>
<body>
<model:datasets>
	<model:dataset id="somOrganDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomOrganQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomOrgan"></model:record>
	</model:dataset>
	<model:dataset id="somElectionDataSet" cmd="com.inspur.cams.sorg.history.election.cmd.SomElectionQueryCmd" method="queryElection" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomElection">
			<model:field name="linkPeople" type="string" rule="length{72}" />
			<model:field name="linkPhone" type="string" rule="length{30}" />
			<model:field name="meetingName" type="string" rule="require|length{100}" />
			<model:field name="meetingDate" type="string" rule="length{10}" />
			<model:field name="meetingPlace" type="string" rule="length{100}" />
			<model:field name="mainPeople" type="string" rule="length{500}" />
			<model:field name="lastDate" type="string" rule="length{10}" />
			<model:field name="nextDate" type="string" rule="length{10}" />
			<model:field name="shouldNum" type="string" rule="number|length{6}" />
		</model:record>
	</model:dataset>
	<model:dataset id="somMeetingQueryDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomMeetingQueryCmd">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomMeeting"/>
	</model:dataset>
	<model:dataset id="somAspchiefDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomAspchiefQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomAspchief">
			<model:field name="name" type="string" rule="require|length{32}" />
			<model:field name="birthday" type="string" rule="length{10}" />
			<model:field name="workName" type="string" rule="length{100}" />
			<model:field name="populace" type="string" rule="length{100}" />
			<model:field name="promiseOrgan" type="string" rule="length{100}" />
			<model:field name="promiseCode" type="string" rule="length{100}" />
			<model:field name="otherDuties" type="string" rule="length{500}" />
			<model:field name="penal" type="string" rule="length{500}" />
		</model:record>
	</model:dataset>
	<!-- 业务 -->
	<model:dataset id="somApplyDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomApplyQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomApply">
			<model:field name="curOpinionId" type="string" rule="require" />
			<model:field name="curOpinion" type="string" rule="length{200}" />
		</model:record>
	</model:dataset>
	<model:dataset id="somRestrictPeopleDetailDataSet" cmd="com.inspur.cams.sorg.restrict.cmd.SomRestrictPeopleDetailQueryCmd" sortField="addTime">
		<model:record fromBean="com.inspur.cams.sorg.restrict.data.SomRestrictPeopleDetail"></model:record>
	</model:dataset>
	<model:dataset id="somPartyMemberDataSet" cmd="com.inspur.cams.sorg.manage.cmd.SomPartyMemberQueryCmd" >
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomPartyMember"></model:record>
	</model:dataset>
	<%--所有符合身份证号的人员列表--%>
	<model:dataset id="winPeopleDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomPeopleQueryCmd"  method="queryRestrict">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomPeople"></model:record>
	</model:dataset>
	<%--所有符合身份证号的人员列表--%>
	<model:dataset id="winDutyDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomDutyQueryCmd"  global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomDuty"></model:record>
	</model:dataset>
	<!-- 住所来源 -->
	<model:dataset id="sorgNameSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='SOM_ORGAN'></model:param>
			<model:param name="value" value='SORG_ID'></model:param>
			<model:param name="text" value='CN_NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 社会组织职务 -->
	<model:dataset id="sorgDutiesSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_SOM_DUTY'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="ifServeSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_DUTY_IF_SERVE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<%--电子档案--%>
	<model:dataset id="somElectronicDataSet" cmd="com.inspur.cams.sorg.upload.cmd.SomElectronicQueryCmd" global="true" method="queryCatalog">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomElectronic"></model:record>
	</model:dataset>
	<%--电子档案上传窗口--%>
	<model:dataset id="winElectronicDataSet" cmd="com.inspur.cams.sorg.upload.cmd.SomElectronicQueryCmd" global="true">
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
	<model:dataset id="opinionSelect" enumName="WORKFLOW.OPINION" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="hisOpinionDataSet" enumName="WORKFLOW.OPINION" autoLoad="true" global="true"></model:dataset>

</model:datasets>
<next:Panel width="100%" autoScroll="true">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<%
			if( !"supply".equals(request.getParameter("act")) ){	%>
				<next:ToolBarItem iconCls="print" text="打印《社会组织筹建党组织告知书》" handler="printParty"></next:ToolBarItem>
				<next:ToolBarItem iconCls="save" text="保存" handler="save"></next:ToolBarItem>
			<%

			}
		%>
		<next:ToolBarItem iconCls="select" text="提交" handler="submit"/>
		<next:ToolBarItem iconCls="return" text="返回" handler="returnBack"></next:ToolBarItem>
	</next:TopBar>
	<next:TabPanel id="tab" width="100%" height="100%" activeTab="3">
		<next:Tabs>
			<next:Panel title="社会团体换届审批" width="100%" height="100%" autoScroll="true">
					<next:Html>
						<form id="ElectionForm" method="post" dataset="somElectionDataSet" onsubmit="return false" class="L5form">
							<input type="hidden" id="sorgId" field="sorgId" value="社会团体ID">
							<fieldset>
							<legend>社会团体换届（成立）事先报批表</legend>
							<table width="100%">
								<tr>
									<td class="FieldLabel" style="width:16%">登记证号或批准筹备文号：</td>
									<td class="FieldInput" style="width:30%"><input type="text" name="登记证号或批准筹备文号" id="sorgCode"  field="sorgCode" maxlength="32" style="width:90%" onkeyup="value=value.replace(/[^\-\\w\.\/]/ig,'').toUpperCase()" onblur="fillSorgInfo();"></td>
									<td class="FieldLabel" style="width:18%">社团名称：</td>
									<td class="FieldInput" style="width:36%"><input name="社团名称" id="cnName" field="sorgName" maxlength="50" style="width:90%" onchange="fillOrganInfo(this.value);"/><font color="red">*</font></td>
								</tr>
								<tr>
									<td class="FieldLabel">联系人：</td>
									<td class="FieldInput"><input type="text" name="联系人" field="linkPeople" maxlength="36" style="width:90%"></td>
									<td class="FieldLabel">联系电话：</td>
									<td class="FieldInput"><input type="text" name="联系电话" field="linkPhone" maxlength="30" style="width:90%"></td>
								</tr>
								<tr>
									<%if(method.equals("INSERT")){ %>
									<td class="FieldLabel">会议名称：</td>
									<td class="FieldInput" colspan="3">第<input type="text" name="会议名称" field="meetingName" maxlength="50" style="width:5%" onchange="ifNumber(this);checkSessionIfExsist(this)">次
									<select id="meetingNameSelect" field="electionType">
									  <option value ="0">会员代表大会</option>
									  <option value ="1">会员大会</option>
									</select>
									<span style="color:red">*</span></td>
									<%} %>
									<%if(method.equals("UPDATE")){ %>
									<td class="FieldLabel">会议名称：</td>
									<td class="FieldInput" colspan="3"><input type="text" name="会议名称" field="meetingName" maxlength="50" style="width:90%" onchange="checkSessionIfExsistUpdate(this)">
									<span style="color:red">*</span></td>
									<%} %>
								</tr>
								<tr>
									<td class="FieldLabel">召开时间：</td>
									<td class="FieldInput"><input type="text" id="meetingDate" name='召开时间' field="meetingDate" onfocus="WdatePicker()" style="width:90%"/></td>
									<td class="FieldLabel">召开地点：</td>
									<td class="FieldInput"><input type="text" name="召开地点" field="meetingPlace" maxlength="50" style="width:90%"></td>
								</tr>
								<tr>
									<td class="FieldLabel">参会主要人员：</td>
									<td class="FieldInput"><input type="text" name="参会主要人员" field="mainPeople" style="width:90%"></td>
									<td class="FieldLabel">参会人数：</td>
									<td class="FieldInput"><input type="text" name="参会人数" field="shouldNum" style="width:90%"></td>
								</tr>
								<tr>
									<td class="FieldLabel">上次换届时间：</td>
									<td class="FieldInput"><input type="text" id="lastDate" name='上次换届时间' field="lastDate" onfocus="WdatePicker()" style="width:90%"/></td>
									<td class="FieldLabel">应到届时间：</td>
									<td class="FieldInput"><input type="text" id="nextDate" name='应到届时间' field="nextDate" onfocus="WdatePicker()" style="width:90%"/></td>
								</tr>
								<tr>
									<td class="FieldLabel">是否制定或修改会费标准：</td>
									<td class="FieldInput">
										<select id="ifMakeFee" field="ifMakeFee" name='"是否制定或修改会费标准"' style="width:90%">
											<option dataset="yesornoDataSet"></option>
										</select>
									</td>
									<td class="FieldLabel">候选人人数：</td>
									<td class="FieldInput"><label id="chiefNum" /></td>
								</tr>
							</table>
							</fieldset>
						</form>
						<fieldset>
							<legend>审查意见</legend>
						<form id="form2" method="post" dataset="somApplyDataSet" onsubmit="return false" class="L5form">

							<table width="100%">
								<tr>
									<td class="FieldLabel">业务主管单位：</td>
									<td class="FieldInput">
									<input type="text" id="borgNameDispaly" name="borgNameDispaly"  title="业务主管单位"  onkeyup="findDiv(this,'borgName','popup','','businessOrganAuto','BORG_NAME@like','borgCode','borgName','35')" onblur="clearDiv()" onchange="clearBorg(this)"/><img src="<%=SkinUtils.getImage(request,"l5/help.gif")%>" style="cursor:hand" onclick="showBorgWin()"/>
									<div id="popup" style="width:300px; height: 150px; display: none;position: absolute;background-color: #FFFFFF;" >
 	        							<ul></ul>
     								</div>
     								<input type="hidden" id="borgName" name="borgName" field="borgName" title="业务主管单位代码"/>
									<span style="color:red">*</span></td>

									<td class="FieldLabel" style="width:17%">业务主管单位审查日期：</td>
									<td class="FieldInput" style="width:17%"><input type="text" id="borgCheckDate" name='业务主管单位审查日期' field="borgCheckDate" onfocus="WdatePicker()" style="width:90%"/></td>
								</tr>
								<tr>
									<td class="FieldLabel">业务主管单位审查意见：</td>
									<td class="FieldInput" colspan="3"><textarea field="borgOpinion" cols="65" rows="2" style="width:97%"></textarea></td>
								</tr>
							</table>

						</form>
						</fieldset>
					<%
						if( "supply".equals(request.getParameter("act")) ){
					%>
					<fieldset>
					<legend>历史处理意见</legend>
					<form method="post" dataset="somApplyDataSet" onsubmit="return false" class="L5form" >
					<table width="100%">
						<tr>
							<td class="FieldLabel" style="width:17%">承办人意见：</td>
							<td class="FieldInput" style="width:17%">
								<label field="acceptOpinionId" name='"承办人意见"' style="width:90%" dataset="hisOpinionDataSet" default="0" />
							</td>
							<td class="FieldLabel" style="width:17%">承办人：</td>
							<td class="FieldInput" style="width:17%"><label type="text" field="acceptPeopleName" name='承办人'  style="width:90%" />
							</td>
							<td class="FieldLabel" style="width:17%">承办时间：</td>
							<td class="FieldInput" style="width:17%"><label type="text" name='承办时间' field="acceptTime" style="width:90%" />
							</td>
						</tr>
						<tr>
							<td class="FieldLabel">承办补充意见：</td>
							<td class="FieldInput" colspan="5"><textarea rows="3" name='承办补充意见' field="acceptOpinion" style="width:98%;background-color:#F5FAFA;border:0;overflow:auto;" readonly></textarea>
							</td>
						</tr>
						<tr>
							<td class="FieldLabel" style="width:17%">初审意见：</td>
							<td class="FieldInput" style="width:17%">
								<label type="text"  field="examinOpinionId" name='"初审意见"' style="width:90%" dataset="hisOpinionDataSet"  />
							</td>
							<td class="FieldLabel" style="width:17%">初审负责人：</td>
							<td class="FieldInput" style="width:17%"><label type="text" field="examinPeopleName" name='初审负责人'  style="width:90%" />
							</td>
							<td class="FieldLabel" style="width:17%">初审时间：</td>
							<td class="FieldInput" style="width:17%"><label type="text" name='初审时间' field="examinTime" style="width:90%" />
							</td>
						</tr>
						<tr>
							<td class="FieldLabel">初审补充意见：</td>
							<td class="FieldInput" colspan="5"><textarea rows="3" name='初审补充意见' field="examinOpinion" style="width:98%;background-color:#F5FAFA;border:0;overflow:auto;" readonly></textarea>
							</td>
						</tr>
						<tr>
							<td class="FieldLabel" style="width:17%">审核意见：</td>
							<td class="FieldInput" style="width:17%">
								<label type="text"  field="checkOpinionId" name='"审核意见"' style="width:90%" dataset="hisOpinionDataSet" />
							</td>
							<td class="FieldLabel" style="width:17%">审核人：</td>
							<td class="FieldInput" style="width:17%"><label type="text" field="checkPeopleName" name='审核人' style="width:90%" />
							</td>
							<td class="FieldLabel" style="width:17%">审核时间：</td>
							<td class="FieldInput" style="width:17%"><label type="text" name='审核时间' field="checkTime" style="width:90%" />
							</td>
						</tr>
						<tr>
							<td class="FieldLabel">审核补充意见：</td>
							<td class="FieldInput" colspan="5"><textarea rows="3" name='审核补充意见' field="checkOpinion" style="width:98%;background-color:#F5FAFA;border:0;overflow:auto;" readonly></textarea>
							</td>
						</tr>
						<tr>
							<td class="FieldLabel" style="width:17%">批准意见：</td>
							<td class="FieldInput" style="width:17%">
								<label type="text"  field="auditOpinionId" name='"批准意见"' style="width:90%" dataset="hisOpinionDataSet"  />
							</td>
							<td class="FieldLabel" style="width:17%">批准人：</td>
							<td class="FieldInput" style="width:17%"><label type="text" field="auditPeopleName" name='批准人' style="width:90%" />
							</td>
							<td class="FieldLabel" style="width:17%">批准时间：</td>
							<td class="FieldInput" style="width:17%"><label type="text" name='批准时间' field="auditTime" style="width:90%" />
							</td>
						</tr>
						<tr>
							<td class="FieldLabel">批准补充意见：</td>
							<td class="FieldInput" colspan="5"><textarea rows="3" name='批准补充意见' field="auditOpinion" style="width:98%;background-color:#F5FAFA;border:0;overflow:auto;" readonly></textarea>
							</td>
						</tr>
					</table>
					</form>
					</fieldset>
					<%
						}
					%>

					</next:Html>
				</next:Panel>
				<next:EditGridPanel id="aspchiefGrid" title="领导职务候选人基本情况" dataset="somAspchiefDataSet" height="300" width="98.5%" stripeRows="true">
					<next:TopBar>
						<next:ToolBarItem symbol="领导职务候选人基本情况"></next:ToolBarItem>
						<next:ToolBarItem symbol="->"></next:ToolBarItem>
						<next:ToolBarItem iconCls="add" text="增加" handler="addAspchief"></next:ToolBarItem>
						<next:ToolBarItem iconCls="delete" text="删除" handler="delAspchief"></next:ToolBarItem>
					</next:TopBar>
					<next:Columns>
						<next:RowNumberColumn/>
						<next:RadioBoxColumn></next:RadioBoxColumn>
						<next:Column header="身份证号" field="idCard" width="15%" editable="true" renderer="queryPeople" ><next:TextField/></next:Column>
						<next:Column header="姓名" field="name" width="10%" editable="true"><next:TextField/></next:Column>
						<next:Column header="性别" field="sex" width="10%" editable="true"><next:ComboBox dataset="sexDataSet"/></next:Column>
						<next:Column header="出生年月" field="birthday" width="10%" editable="true"><next:TextField /></next:Column>
						<next:Column header="政治面貌" field="politics" width="15%" editable="true"><next:ComboBox dataset="politicsSelect"/></next:Column>
						<next:Column header="户口所在地" field="populace" width="10%" editable="true"><next:TextField/></next:Column>
						<next:Column header="拟任社团职务" field="sorgDuties" width="10%" editable="true"><next:ComboBox dataset="sorgDutiesDataSet"/></next:Column>
						<next:Column header="是否是拟任法定代表人" field="ifLegal" width="15%" editable="true"><next:ComboBox dataset="yesornoDataSet"></next:ComboBox></next:Column>
						<next:Column header="人事关系所在单位" field="workName" width="19%" editable="true"><next:TextField/></next:Column>
						<next:Column header="职务" field="workDuties" width="10%" editable="true"><next:TextField/></next:Column>
						<next:Column header="批准兼职组织人事部门" field="promiseOrgan" width="15%" editable="true"><next:TextField/></next:Column>
						<next:Column header="文号" field="promiseCode" width="10%" editable="true"><next:TextField/></next:Column>
						<next:Column header="担任其他社团职务" field="otherDuties" width="15%" editable="true"><next:TextField/></next:Column>
						<next:Column header="刑事处罚情况" field="penal" width="15%" editable="true"><next:TextField/></next:Column>
					</next:Columns>
				</next:EditGridPanel>
			<next:EditGridPanel id="uploadGrid" title="法律要件" width="100%" stripeRows="true" height="100%" dataset="somElectronicDataSet">
				<next:TopBar>
					<next:ToolBarItem symbol="附件列表"></next:ToolBarItem>
					<next:ToolBarItem symbol="->"></next:ToolBarItem>
					<next:ToolBarItem iconCls="add" text="增加上传附件" handler="clickUploadFile"></next:ToolBarItem>
				</next:TopBar>
				<next:Columns>
					<next:RowNumberColumn />
					<next:RadioBoxColumn></next:RadioBoxColumn>
					<next:Column header="档案目录名"  field="catalogCode" width="38%" editable="false" dataset="cataLogCodeSelect"><next:TextField /></next:Column>
					<next:Column header="附件名称"    field="fileName" width="30%" editable="false"><next:TextField /></next:Column>
					<next:Column header="附件描述"    field="fileMess" width="20%" editable="false"><next:TextField /></next:Column>
					<next:Column header="下载附件"    field="" width="10%" editable="false" renderer="clickDownloadHref"><next:TextField /></next:Column>
				</next:Columns>
				<next:BottomBar>
					<next:PagingToolBar dataset="somElectronicDataSet" />
				</next:BottomBar>
			</next:EditGridPanel>
			<next:Panel title="处理意见" id="ipinionPanel" width="100%" height="100%" autoScroll="true" style="display:block;">
			<next:Html>
			<form method="post" onsubmit="return false" class="L5form" dataset="somApplyDataSet">
			<table width="100%">
				<tr>
					<td class="FieldLabel" style="width:13%"><label>处理意见：</label></td>
					<td class="FieldInput" colspan="5">
					<select field="curOpinionId" name='处理意见' style="width:150px">
						<option dataset="opinionSelect"></option>
					</select><span style="color:red">*</span>
					</td>

				</tr>
				<tr>
					<td class="FieldLabel"><label>处理补充意见：</label></td>
					<td class="FieldInput" colspan="5">
						<textarea rows="10" name='处理补充意见' field="curOpinion" style="width:98%"></textarea>
					</td>
				</tr>
			</table>
			</form>
			</next:Html>
			</next:Panel>
		</next:Tabs>
	</next:TabPanel>
</next:Panel>
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
<!-- 负责人身份验证 -->
<next:Window id="win_peopleValidate" title="人员身份验证"  resizable="false" width="650" height="403" closeAction="hide" modal="true">
		<next:EditGridPanel id="gridPeople" width="636" stripeRows="true" height="170" dataset="winPeopleDataSet">
			<next:TopBar>
				<next:ToolBarItem symbol="人员列表"></next:ToolBarItem>
				<next:ToolBarItem symbol="->"></next:ToolBarItem>
				<next:ToolBarItem iconCls="detail" text="确定（将选中的所在社会组织信息回填）" handler="fillBackOtherInfo"></next:ToolBarItem>
				<next:ToolBarItem iconCls="delete" text="关闭窗口" handler="closeItem"></next:ToolBarItem>
			</next:TopBar>
			<next:Columns>
				<next:RowNumberColumn />
				<next:RadioBoxColumn></next:RadioBoxColumn>
				<next:Column header="姓名" field="name" width="150" sortable="true" editable="false"><next:TextField /></next:Column>
				<next:Column header="出生年月" field="birthday" width="142" sortable="true" editable="false"><next:DateField format="Y-m-d" /></next:Column>
				<next:Column header="性别" field="sex" width="142" sortable="true" editable="false" dataset="sexDataSet" ><next:TextField /></next:Column>
				<next:Column header="是否受限人员" field="ifLimit" width="120" sortable="true" editable="false"  dataset="sexDataSet" renderer="getIfLimit"><next:TextField /></next:Column>
				<next:Column header="受限人员id" field="restrictPeopleId" width="142" sortable="true" editable="false"  hidden="true"><next:TextField /></next:Column>
			</next:Columns>
			<next:BottomBar>
				<next:PagingToolBar dataset="winPeopleDataSet" />
			</next:BottomBar>
		</next:EditGridPanel>
		<next:EditGridPanel id="gridDuty" width="636" stripeRows="true" height="202" dataset="winDutyDataSet">
			<next:TopBar>
				<next:ToolBarItem symbol="所在社会组织信息"></next:ToolBarItem>
				<next:ToolBarItem symbol="->"></next:ToolBarItem>
			</next:TopBar>
			<next:Columns>
				<next:RowNumberColumn />
				<next:Column header="组织名称" field="sorgId" width="165" dataset="sorgNameSelect" sortable="false" editable="false"><next:TextField /></next:Column>
				<next:Column header="职务" field="sorgDuties" width="120" dataset="sorgDutiesSelect" sortable="false" editable="false"><next:TextField /></next:Column>
				<next:Column header="状态" field="ifServe" width="80" dataset="ifServeSelect" sortable="false" editable="false"><next:TextField /></next:Column>
			</next:Columns>
			<next:BottomBar>
				<next:PagingToolBar dataset="winDutyDataSet" />
			</next:BottomBar>
		</next:EditGridPanel>
</next:Window>
<next:Window id="restrictWin" title="受限人员详情" resizable="false" width="800" height="400" modal="true" closable="false">
	<next:EditGridPanel id="restrictGrid" width="787" stripeRows="true" height="370" dataset="somRestrictPeopleDetailDataSet">
		<next:TopBar>
			<next:ToolBarItem symbol="->"></next:ToolBarItem>
			<next:ToolBarItem iconCls="delete" text="关闭" handler="closeRestrictWin"></next:ToolBarItem>
		</next:TopBar>
		<next:Columns>
			<next:RowNumberColumn/>
			<next:RadioBoxColumn></next:RadioBoxColumn>
			<next:Column header="添加原因" field="sourceType" width="150" sortable="false" editable="false" dataset="sourceTypeSelect"><next:TextField/></next:Column>
			<next:Column header="是否法定代表人" field="ifLegal" width="120" sortable="false" editable="false" dataset="comm_yesorno"><next:TextField/></next:Column>
			<next:Column header="社会组织名称" field="sorgCode" width="200" sortable="false" editable="false" dataset="sorgCodeSelect"><next:TextField/></next:Column>
			<next:Column header="登记证号" field="sorgCode" width="150" sortable="false" editable="false"><next:TextField/></next:Column>
			<next:Column header="添加单位" field="addOrganName" width="150" sortable="false" editable="false"><next:TextField/></next:Column>
			<next:Column header="添加人" field="addPersonName" width="150" sortable="false" editable="false"><next:TextField/></next:Column>
			<next:Column header="添加时间" field="addTime" width="150" sortable="false" editable="false"><next:TextField/></next:Column>
		</next:Columns>
		<next:BottomBar>
			<next:PagingToolBar dataset="somRestrictPeopleDetailDataSet"/>
		</next:BottomBar>
	</next:EditGridPanel>
</next:Window>
<jsp:include page="../../../comm/upload/uploadWindow.jsp" flush="true"/>
<jsp:include page="../../../comm/borg/borgSelectWindow.jsp" flush="true"/>
</body>
</html>
