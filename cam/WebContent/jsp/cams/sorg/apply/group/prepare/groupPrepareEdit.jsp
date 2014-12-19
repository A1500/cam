<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="org.loushang.bsp.security.context.GetBspInfo"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<%@page import="com.inspur.cams.sorg.util.SomIdHelp"%>
<html>
<head>
<title>社会团体申请筹备登记</title>
<next:ScriptManager></next:ScriptManager>
<script>
<%
	String taskCode = SomIdHelp.getGroupTaskCode();
%>
	var act='<%=request.getParameter("act")%>';
	var processId='<%=request.getParameter("processId")%>';
	var actDefUniqueId='<%=request.getParameter("actDefUniqueId")%>';
	var assignmentId='<%=request.getParameter("assignmentId")%>';
	var method='<%=request.getParameter("method")%>';
	var rootPath="<%=SkinUtils.getRootUrl(request)%>";
	var currentUserName = '<%= GetBspInfo.getBspInfo().getUserName()%>';
	var taskCode='<%=taskCode%>';
	var cnName='';
</script>
<script type="text/javascript" src="groupPrepare.js"></script>
<script type="text/javascript" src="<%=SkinUtils.getJS(request, "bpm/bpm.js")%>"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams/sorgUpload.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"My97DatePicker/WdatePicker.js") %>'></script>
</head>
<body>
<model:datasets>
	<model:dataset id="somApplyDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomApplyQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomApply">
			<model:field name="appPeople" type="string" rule="length{30}" />
			<model:field name="curOpinionId" type="string" rule="require" />
			<model:field name="curOpinion" type="string" rule="length{200}" />
		</model:record>
	</model:dataset>
	<model:dataset id="somOrganDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomOrganQueryCmd"   global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomOrgan">
		<model:field name="cnName" type="string" rule="require|length{100}" />
			<model:field name="enName" type="string" rule="regex{^[A-Za-z _]+$}|length{100}" />
			<model:field name="abName" type="string" rule="regex{^[A-Za-z _]+$}|length{50}" />
			<model:field name="residence" type="string" rule="length{100}" />
			<model:field name="regMon" type="string" rule="double|length{14}" />
			<model:field name="actArea" type="string" rule="length{50}" />
			<model:field name="peopleNum" type="string" rule="integer" />
			<model:field name="unitsNum" type="string" rule="integer" />
			<model:field name="borgPeople" type="string" rule="length{30}" />
			<model:field name="moneySource" type="string" rule="length{500}" />
			<model:field name="purpose" type="string" rule="require|length{1000}" />
			<model:field name="business" type="string" rule="require|length{1000}" />
			<model:field name="buildStatus" type="string" rule="length{500}" />
			<model:field name="absorpMember" type="string" rule="length{500}" />
		</model:record>
	</model:dataset>
	<model:dataset id="somOrganDataSetQuery" cmd="com.inspur.cams.sorg.base.cmd.SomOrganQueryCmd"  method="queryHis">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomOrgan"></model:record>
	</model:dataset>
	<model:dataset id="somHeldPeopleDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomHeldPeopleQueryCmd" global="true" pageSize="100">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomHeldPeople">
			<model:field name="name" type="string" rule="require|length{30}" />
			<model:field name="populace" type="string" rule="length{100}" />
			<model:field name="workName" type="string" rule="length{100}" />
			<model:field name="workDuties" type="string" rule="length{100}" />
			<model:field name="ifChief" type="string" rule="require" />
		</model:record>
	</model:dataset>
	<model:dataset id="somHeldOrganDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomHeldOrganQueryCmd" global="true" pageSize="100">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomHeldOrgan">
			<model:field name="name" type="string" rule="require" />
			<model:field name="heldorganPeople" type="string" rule="length{30}" />
		</model:record>
	</model:dataset>
	<model:dataset id="somAspchiefDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomAspchiefQueryCmd" global="true"  pageSize="100">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomAspchief">
			<model:field name="idCard" type="string" rule="length{18}" />
			<model:field name="name" type="string" rule="require" />
			<model:field name="workName" type="string" rule="length{100}" />
			<model:field name="workDuties" type="string" rule="length{50}" />
			<model:field name="sorgDuties" type="string" rule="length{50}" />
		</model:record>
	</model:dataset>
	<model:dataset id="somFlowDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomFlowQueryCmd" global="true" sortField="COMMIT_TIME" pageSize="100">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomFlow"></model:record>
	</model:dataset>
	<model:dataset id="somElectronicDataSet" cmd="com.inspur.cams.sorg.upload.cmd.SomElectronicQueryCmd" global="true" method="queryCatalog">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomElectronic"></model:record>
	</model:dataset>
	<%--下载窗口--%>
	<model:dataset id="downloadDataSet" cmd="com.inspur.cams.sorg.upload.cmd.SomElectronicQueryCmd" method="queryElectronic">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomElectronic"></model:record>
	</model:dataset>
	<%--电子档案上传窗口--%>
	<model:dataset id="winElectronicDataSet" cmd="com.inspur.cams.sorg.upload.cmd.SomElectronicQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomElectronic"></model:record>
	</model:dataset>
	<model:dataset id="borgDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true" sortField="ORDER_NUMBER">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='SOM_BUSINESS_ORGAN'></model:param>
			<model:param name="value" value='BORG_CODE'></model:param>
			<model:param name="text" value='BORG_NAME'></model:param>
			<model:param name="filterSql" value='<%="MORG_CODE ="+BspUtil.getOrganCode().substring(0,6)%>'></model:param>

		</model:params>
	</model:dataset>
	<model:dataset id="cataLogCodeSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='SOM_CATALOG'></model:param>
			<model:param name="value" value='CATALOG_CODE'></model:param>
			<model:param name="text" value='CATALOG_NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="pubOrganDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='PUB_ORGAN'></model:param>
			<model:param name="value" value='ORGAN_ID'></model:param>
			<model:param name="text" value='ORGAN_NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="sexDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_SEX'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="politicsDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_POLITICAL'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="yesornoDataSet" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="resideSourceDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_RESIDE_SOURCE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="opinionDataSet" enumName="WORKFLOW.OPINION" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="hisOpinionDataSet" enumName="WORKFLOW.OPINION" autoLoad="true" global="true"></model:dataset>
</model:datasets>
<%--定义界面--%>
<next:Panel width="100%" height="100%">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<%
			if( !"supply".equals(request.getParameter("act")) ){	%>
			<next:ToolBarItem iconCls="print" text="打印受理通知书" handler="printAccept"></next:ToolBarItem>
			<next:ToolBarItem iconCls="print" text="打印不予受理通知书" handler="printNoAccept"></next:ToolBarItem>
			<next:ToolBarItem iconCls="edit" text="名称变更" handler="changeName"></next:ToolBarItem>
			<next:ToolBarItem iconCls="save" text="保存" handler="save"/>

			<%

			}
		%>
		<next:ToolBarItem iconCls="select" text="提交" handler="submit"/>
		<next:ToolBarItem iconCls="undo" text="返回" handler="returnClick"/>
	</next:TopBar>

	<next:TabPanel id="tab" width="100%" height="100%" activeTab="5">
		<next:Tabs>
			<next:Panel title="社会团体筹备成立申请表" width="100%" autoScroll="true">
				<next:Html>
					<fieldset>
					<legend>社会团体筹备成立申请表</legend>
					<form method="post" dataset="somOrganDataSet" onsubmit="return false" class="L5form">
					<input type="hidden" name="sorgId" field="sorgId"/>
					<table width="100%">
						<tr>
							<td class="FieldLabel">申请筹备社团名称：</td>
							<td class="FieldInput" colspan="5"><input type="text"id='cnName' field="cnName" name='"申请筹备社团名称"' style="width:90%" onblur="fillOrganInfo(this.value);"/><span style="color:red">*</span></td>
						</tr>
						<tr>
							<td class="FieldLabel">英文名称：</td>
							<td class="FieldInput" colspan="3"><input type="text" name='"社团英文名称"' field="enName" style="width:98%"/></td>
							<td class="FieldLabel">英文名称缩写：</td>
							<td class="FieldInput"><input type="text" field="abName" name='"社团缩写名称"' style="width:90%"/></td>
						</tr>
						<tr>
							<td class="FieldLabel">住所：</td>
							<td class="FieldInput" colspan="3"><input type="text" name='"住所"' field="residence" style="width:98%"/></td>
							<td class="FieldLabel">住所来源：</td>
							<td class="FieldInput">
								<select field="resideSource" name='"住所来源"' style="width:90%">
									<option dataset="resideSourceDataSet"></option>
								</select>
							</td>
						</tr>
						<tr>
							<td class="FieldLabel">电话：</td>
							<td class="FieldInput"><input type="text" id="sorgPhone" name='"电话"' field="sorgPhone" style="width:90%"/></td>
							<td class="FieldLabel">邮编：</td>
							<td class="FieldInput"><input type="text" id="sorgPost" name='"邮编"' field="sorgPost" style="width:90%"/></td>
							<td class="FieldLabel">注册资金数额（万元）：</td>
							<td class="FieldInput"><input type="text" name='"资金数额"' field="regMon" maxlength="10" style="width:90%"/></td>
						</tr>
						<tr>
							<td class="FieldLabel" style="width:17%">活动地域：</td>
							<td class="FieldInput" style="width:17%"><input type="text" name='"活动地域"' field="actArea" style="width:90%"/></td>
							<td class="FieldLabel" style="width:17%">个人会员数：</td>
							<td class="FieldInput" style="width:15%"><input type="text" id="peopleNum" name='"个人会员数"' field="peopleNum" maxlength="6" style="width:90%"/></td>
							<td class="FieldLabel" style="width:17%">单位会员数：</td>
							<td class="FieldInput" style="width:17%"><input type="text" id="unitsNum" name='"单位会员数"' field="unitsNum" maxlength="6" style="width:90%"/></td>
						</tr>
						<tr>
							<td class="FieldLabel">业务主管单位：</td>
							<td class="FieldInput">
							<input type="text" id="borgNameDispaly" name="borgNameDispaly"  title="业务主管单位"  onkeyup="findDiv(this,'borgName','popup','','businessOrganAuto','BORG_NAME@like','borgCode','borgName','35')" onblur="clearDiv()" onchange="clearBorg(this)"/><img src="<%=SkinUtils.getImage(request,"l5/help.gif")%>" style="cursor:hand" onclick="showBorgWin()"/>
							<div id="popup" style="width:300px; height: 150px; display: none;position: absolute;background-color: #FFFFFF;" >
 	        					<ul></ul>
     						</div>
     						<input type="hidden" id="borgName" name="borgName" field="borgName" title="业务主管单位代码"/>
							<span style="color:red">*</span></td>

							<td class="FieldLabel">业务主管单位联系人：</td>
							<td class="FieldInput"><input type="text" name='业务主管单位联系人' field="borgPeople" style="width:90%" /></td>
							<td class="FieldLabel">业务主管单位电话：</td>
							<td class="FieldInput"><input type="text" name='业务主管单位电话'id='borgPhone' field="borgPhone" style="width:90%" /></td>
						</tr>
						<tr>
							<td class="FieldLabel">社团活动经费来源：</td>
							<td class="FieldInput" colspan="5"><input type="text" name='"资金来源"' field="moneySource" style="width:98%"/></td>
						</tr>
						<tr>
							<td class="FieldLabel">社团宗旨：</td>
							<td class="FieldInput" colspan="5"><textarea rows="5" name='"社团宗旨"' field="purpose" style="width:98%"></textarea><span style="color:red">*</span></td>
						</tr>
						<tr>
							<td class="FieldLabel">业务范围：</td>
							<td class="FieldInput" colspan="5"><textarea rows="5" name='"业务范围"' field="business" style="width:98%"></textarea><span style="color:red">*</span></td>
						</tr>
						<tr>
							<td class="FieldLabel">国家及其他省、市设立此类社团的情况：</td>
							<td class="FieldInput" colspan="5"><textarea rows="3" field="buildStatus" name='"国家及其他省、市设立此类社团的情况"' style="width:98%"></textarea></td>
						</tr>
						<tr>
							<td class="FieldLabel">拟吸收会员的意向：</td>
							<td class="FieldInput" colspan="5"><textarea rows="3" field="absorpMember" name='"拟吸收会员的意向"' style="width:98%"></textarea></td>
						</tr>
					</table>
					</form>
					</fieldset>

					<fieldset>
					<legend>申请信息</legend>
					<form method="post" dataset="somApplyDataSet" onsubmit="return false" class="L5form" style="border-width:0px">
					<table width="100%">
						<tr>
							<td class="FieldLabel" style="width:17%">联系人：</td>
							<td class="FieldInput" style="width:17%"><input type="text" name='"申请人"' field="appPeople" style="width:90%"/></td>
							<td class="FieldLabel" style="width:17%">联系人电话：</td>
							<td class="FieldInput" style="width:17%"><input type="text" id="appPhone" name='"申请人电话"' field="appPhone" style="width:90%"/></td>
							<td class="FieldLabel" style="width:17%">申请日期：</td>
							<td class="FieldInput" style="width:17%"><input type="text" name='"申请日期"' field="appDate" format="Y-m-d" onclick="WdatePicker()" style="width:90%"/></td>
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
							<td class="FieldLabel" style="width:17%">现场勘查意见：</td>
							<td class="FieldInput" style="width:17%">
								<label type="text"  field="prospectOpinionId" name='"现场勘查意见"' style="width:90%" dataset="hisOpinionDataSet"  />
							</td>
							<td class="FieldLabel" style="width:17%">现场勘查承办人：</td>
							<td class="FieldInput" style="width:17%"><label type="text" field="prospectPeopleName" name='现场勘查承办人'  style="width:90%" /></td>
							<td class="FieldLabel" style="width:17%">现场勘查日期：</td>
							<td class="FieldInput" style="width:17%"><label type="text" name='现场勘查日期' field="prospectDate" style="width:90%" /></td>
						</tr>
						<tr>
							<td class="FieldLabel" style="width:17%">现场勘查双方参加人员：</td>
							<td class="FieldInput" colspan="5">
								<label type="text"  field="prospectAttendPeople" name='"现场勘查双方参加人员"' style="width:90%"/>
							</td>
						</tr>
						<tr>
							<td class="FieldLabel" style="width:17%">现场勘查地点：</td>
							<td class="FieldInput" colspan="5"><label type="text" field="prospectPlace" name='现场勘查地点'  style="width:90%" /></td>
						</tr>
						<tr>
							<td class="FieldLabel">现场勘查补充意见：</td>
							<td class="FieldInput" colspan="5"><textarea rows="3" name='现场勘查补充意见' field="prospectOpinion" style="width:98%;background-color:#F5FAFA;border:0;overflow:auto;" readonly></textarea>
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

			<next:Panel title="筹备发起人（自然人）">
				<next:EditGridPanel id="heldPeopleGrid" dataset="somHeldPeopleDataSet" width="100%" stripeRows="true" height="100%">
					<next:TopBar>
						<next:ToolBarItem symbol="->"></next:ToolBarItem>
						<next:ToolBarItem iconCls="add" text="增加" handler="addHeldPeople"></next:ToolBarItem>
						<next:ToolBarItem iconCls="delete" text="删除" handler="delHelpPeople"></next:ToolBarItem>
					</next:TopBar>
					<next:Columns>
						<next:RowNumberColumn/>
						<next:RadioBoxColumn></next:RadioBoxColumn>
						<next:Column header="内码" field="id" width="15%" editable="true" hidden="true"><next:TextField/></next:Column>
						<next:Column header="身份证号" field="idCard" width="20%" editable="true"><next:TextField/></next:Column>
						<next:Column header="姓名" field="name" width="10%" editable="true"><next:TextField/></next:Column>
						<next:Column header="性别" field="sex" width="10%" editable="true"><next:ComboBox dataset="sexDataSet"></next:ComboBox></next:Column>
						<next:Column header="出生年月" field="birthday" width="10%" editable="true"><next:TextField /></next:Column>
						<next:Column header="政治面貌" field="politics" width="20%" editable="true"><next:ComboBox dataset="politicsDataSet"></next:ComboBox></next:Column>
						<next:Column header="工作单位" field="workName" width="25%" editable="true"><next:TextField/></next:Column>
						<next:Column header="工作单位职务" field="workDuties" width="15%" editable="true"><next:TextField/></next:Column>
						<next:Column header="是否筹备负责人" field="ifChief" width="15%" editable="true"><next:ComboBox dataset="yesornoDataSet"></next:ComboBox></next:Column>
					</next:Columns>
					<next:BottomBar>
						<next:PagingToolBar dataset="somHeldPeopleDataSet"/>
					</next:BottomBar>
				</next:EditGridPanel>
			</next:Panel>

			<next:Panel title="筹备发起人（单位）">
				<next:EditGridPanel id="heldOrganGrid" dataset="somHeldOrganDataSet" width="100%" stripeRows="true" height="100%">
					<next:TopBar>
						<next:ToolBarItem symbol="->"></next:ToolBarItem>
						<next:ToolBarItem iconCls="add" text="增加" handler="addHeldOrgan"></next:ToolBarItem>
						<next:ToolBarItem iconCls="delete" text="删除" handler="delHeldOrgan"></next:ToolBarItem>
					</next:TopBar>
					<next:Columns>
						<next:RowNumberColumn/>
						<next:RadioBoxColumn></next:RadioBoxColumn>
						<next:Column header="内码" field="id" width="15%" editable="true" hidden="true"><next:TextField/></next:Column>
						<next:Column header="发起单位名称" field="name" width="50%" editable="true"><next:TextField/></next:Column>
						<next:Column header="发起单位负责人" field="heldorganPeople" width="18%" editable="true"><next:TextField/></next:Column>
						<next:Column header="联系电话" field="phone" width="30%" editable="true"><next:TextField/></next:Column>
					</next:Columns>
					<next:BottomBar>
						<next:PagingToolBar dataset="somHeldOrganDataSet"/>
					</next:BottomBar>
				</next:EditGridPanel>
			</next:Panel>

			<next:Panel title="拟任负责人">
				<next:EditGridPanel id="aspchiefGrid" dataset="somAspchiefDataSet" width="100%" stripeRows="true" height="100%">
					<next:TopBar>
						<next:ToolBarItem symbol="->"></next:ToolBarItem>
						<next:ToolBarItem iconCls="add" text="增加" handler="addAspchief"></next:ToolBarItem>
						<next:ToolBarItem iconCls="delete" text="删除" handler="delAspchief"></next:ToolBarItem>
					</next:TopBar>
					<next:Columns>
						<next:RowNumberColumn/>
						<next:RadioBoxColumn></next:RadioBoxColumn>
						<next:Column header="内码" field="id" width="15%" editable="true" hidden="true"><next:TextField/></next:Column>
						<next:Column header="身份证号" field="idCard" width="20%" editable="true"><next:TextField/></next:Column>
						<next:Column header="姓名" field="name" width="10%" editable="true"><next:TextField/></next:Column>
						<next:Column header="性别" field="sex" width="10%" editable="true"><next:ComboBox dataset="sexDataSet"></next:ComboBox></next:Column>
						<next:Column header="出生年月" field="birthday" width="10%" editable="true"><next:TextField /></next:Column>
						<next:Column header="政治面貌" field="politics" width="20%" editable="true"><next:ComboBox dataset="politicsDataSet"></next:ComboBox></next:Column>
						<next:Column header="工作单位" field="workName" width="25%" editable="true"><next:TextField/></next:Column>
						<next:Column header="工作单位职务" field="workDuties" width="20%" editable="true"><next:TextField/></next:Column>
						<next:Column header="拟任社团职务" field="sorgDuties" width="20%" editable="true"><next:TextField/></next:Column>
						<next:Column header="是否是拟任法定代表人" field="ifLegal" width="10%" editable="true"><next:ComboBox dataset="yesornoDataSet"></next:ComboBox></next:Column>
					</next:Columns>
					<next:BottomBar>
						<next:PagingToolBar dataset="somAspchiefDataSet"/>
					</next:BottomBar>
				</next:EditGridPanel>
			</next:Panel>

			<next:Panel title="法律要件">
				<next:EditGridPanel id="uploadGrid" dataset="somElectronicDataSet" width="100%" stripeRows="true" height="100%">
					<next:TopBar>
						<next:ToolBarItem symbol="附件列表"></next:ToolBarItem>
						<next:ToolBarItem symbol="->"></next:ToolBarItem>
						<next:ToolBarItem iconCls="upload" text="增加上传附件" handler="clickUploadFile"></next:ToolBarItem>
					</next:TopBar>
					<next:Columns>
						<next:RowNumberColumn/>
						<next:RadioBoxColumn></next:RadioBoxColumn>
						<next:Column header="档案目录名" field="catalogCode" width="38%" editable="false" dataset="cataLogCodeSelect"><next:TextField /></next:Column>
						<next:Column header="附件名称" field="fileName" width="30%" editable="false"><next:TextField /></next:Column>
						<next:Column header="附件描述" field="fileMess" width="20%" editable="false"><next:TextField /></next:Column>
						<next:Column header="下载附件"    field="" width="10%" editable="false" renderer="clickDownloadHref"><next:TextField /></next:Column>
					</next:Columns>
					<next:BottomBar>
						<next:PagingToolBar dataset="somElectronicDataSet"/>
					</next:BottomBar>
				</next:EditGridPanel>
			</next:Panel>
			<next:Panel title="处理意见">
				<next:Html>
					<form method="post" dataset="somApplyDataSet" onsubmit="return false" class="L5form">
					<table width="100%">
						<tr>
							<td class="FieldLabel" style="width:13%">处理意见：</td>
							<td class="FieldInput" colspan="5">
								<select field="curOpinionId" name='"处理意见"' style="width:150px" default="0">
									<option dataset="opinionDataSet"></option>
								</select><span style="color:red">*</span>
							</td>
						</tr>
						<tr>
							<td class="FieldLabel">处理补充意见：</td>
							<td class="FieldInput" colspan="5"><textarea rows="10" name='"处理补充意见"' field="curOpinion" style="width:98%"></textarea></td>
						</tr>
					</table>
					</form>
				</next:Html>
			</next:Panel>
		</next:Tabs>
	</next:TabPanel>
</next:Panel>
<next:Window id="changeName" closeAction="hide" title="名称变更" height="160" width="450" modal="true">
	<next:TopBar>
		<next:ToolBarItem symbol="->" ></next:ToolBarItem>
		<next:ToolBarItem iconCls="save" text="确定" handler="confirmWin"></next:ToolBarItem>
		<next:ToolBarItem iconCls="return" text="关闭" handler="closeWin"></next:ToolBarItem>
	</next:TopBar>
	<next:Html>
		<form id="form_content2" onsubmit="return false" style="padding: 5px;" class="L5form">
		<table border="1"  width="100%" >
			<tr>
				<td class="FieldLabel" style="width:20%">变更前名称：</td>
				<td class="FieldInput" style="width:80%"><input type="text" id="oldName"  style="width:95%" disabled="disabled" readonly="readonly"/></td>
			</tr>
			<tr>
				<td class="FieldLabel" style="width:20%">变更后名称：</td>
				<td class="FieldInput" style="width:80%"><input type="text" id="newName"  style="width:95%"/></td>
    		</tr>

		</table>
		</form>
   </next:Html>
</next:Window>
<jsp:include page="../../../comm/upload/uploadWindow.jsp" flush="true"/>
<jsp:include page="../../../comm/borg/borgSelectWindow.jsp" flush="true"/>
</body>
</html>