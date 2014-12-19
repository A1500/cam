<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.StrUtil"%>
<%@page import="com.inspur.cams.sorg.util.SomIdHelp"%>
<%@page import="com.inspur.cams.sorg.util.ApplyType"%>
<%@ page import="com.inspur.cams.comm.extuser.data.ComExtUser"%>
<%@ page import="com.inspur.cams.sorg.online.extuser.util.SomExtBspInfo"%>
<%@page import="com.inspur.cams.sorg.online.apply.util.SomIdHelpOnline"%>
<html>
<head>
<title>社会团体换届审批</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="groupElectionEdit.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js") %>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js") %>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams/sorgUpload.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"My97DatePicker/WdatePicker.js") %>'></script>
<script type="text/javascript">var rootPath='<%=SkinUtils.getRootUrl(request)%>';</script>
<script type="text/javascript">
	<%
		ComExtUser comExtUser = (ComExtUser)SomExtBspInfo.getUserInfo(request).getComExtUser();
		String username = comExtUser.getUserName();
		String organArea = comExtUser.getAreaCode();//获取外部单位行政区划12位
		String userId = comExtUser.getUserId();
		String method=request.getParameter("method");
		String sorgId ="";
		String taskCode ="";
		if(method.equals("INSERT")){
			sorgId = SomIdHelpOnline.getGroupSorgId(organArea);
			taskCode = SomIdHelpOnline.getGroupTaskCode(organArea);
		}else{
			sorgId = request.getParameter("sorgId");
			taskCode = request.getParameter("taskCode") ;
		}
		String sorgCode = SomExtBspInfo.getUserInfo(request).getSorgCode();
		if(sorgCode == null){
			sorgCode ="";
		}
	%>
	var applyType='<%=ApplyType.SOM_GROUP_ELECTION_CHECK%>';//业务类型
	var method='<%=request.getParameter("method")%>';
	var sorgType='<%=request.getParameter("sorgType")%>';
	var taskCode='<%=taskCode%>';
	var sorgId='<%=sorgId%>';
	var rootPath="<%=SkinUtils.getRootUrl(request)%>";
	var morgArea='<%=organArea%>';
	var userId='<%=userId%>';
	var cnName=decodeURIComponent('<%=request.getParameter("cnName")%>');
	var ruleId='<%=request.getParameter("ruleId")%>';
	var sorgCode='<%=sorgCode%>';
</script>
</head>
<body>
<model:datasets>
	<model:dataset id="somElectionDataSet" cmd="com.inspur.cams.sorg.history.election.cmd.SomElectionQueryCmd" method="queryElection">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomElection">
			<model:field name="meetingName" type="string" rule="require|length{100}"/>
			<model:field name="meetingFormat" type="string" rule="length{30}"/>
			<model:field name="shouldNum" type="string" rule="number|length{6}" />
			<model:field name="chiefNum" type="string" rule="number|length{6}" />
			<model:field name="cnName" type="string"/>
			<model:field name="sorgCode" type="string"/>
		</model:record>
	</model:dataset>
	<model:dataset id="somAspchiefDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomAspchiefQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomAspchief">
			<model:field name="idCard" type="string" rule="require|length{18}"/>
			<model:field name="name" type="string" rule="require|length{32}"/>
			<model:field name="sex" type="string" rule="require"/>
			<model:field name="birthday" type="string" rule="require"/>
			<model:field name="politics" type="string" rule="require|length{10}"/>
			<model:field name="populace" type="string" rule="require|length{100}"/>
			<model:field name="sorgDuties" type="string" rule="require"/>
			<model:field name="ifLegal" type="string" rule="require"/>
			<model:field name="workName" type="string" rule="require|length{100}"/>
			<model:field name="workDuties" type="string" rule="require|length{50}"/>
			<model:field name="promiseOrgan" type="string" rule="require|length{100}"/>
			<model:field name="promiseCode" type="string" rule="require|length{100}"/>
			<model:field name="otherDuties" type="string" rule="require|length{500}"/>
			<model:field name="penal" type="string" rule="require|length{500}"/>
		</model:record>
	</model:dataset>
	<model:dataset id="somOrganDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomOrganQueryCmd"  method="queryOrganOnline" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomOrgan">
		</model:record>
	</model:dataset>
	<model:dataset id="somApplyDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomApplyQueryCmd">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomApply"/>
	</model:dataset>
	<model:dataset id="somPartyMemberDataSet" cmd="com.inspur.cams.sorg.manage.cmd.SomPartyMemberQueryCmd" >
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomPartyMember"></model:record>
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
	</model:dataset>	<model:dataset id="sexDataSet" enumName="COMM.SEX" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="yesornoDataSet" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
</model:datasets>
<next:Panel width="100%" autoScroll="true">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="save" text="保存" handler="save"></next:ToolBarItem>
		<next:ToolBarItem iconCls="return" text="返回" handler="returnBack"></next:ToolBarItem>
	</next:TopBar>
	<next:TabPanel id="tabSomOrgan" width="100%" height="100%">
		<next:Tabs>
			<next:Panel title="社会团体换届审批" width="100%" height="100%" autoScroll="true">
				<next:Panel>
					<next:Html>
						<form id="ElectionForm" method="post" dataset="somElectionDataSet" onsubmit="return false" class="L5form">
							<input type="hidden" id="sorgId" field="sorgId" value="社会团体ID">
							<fieldset>
							<legend>社会团体换届（成立）事先报批表</legend>
							<table width="100%">
								<tr>
									<td class="FieldLabel" style="width:16%">登记证号或批准筹备文号：</td>
									<td id="choubeiTd"  class="FieldInput" style="width:30%"  style="display:none">
									<input type="text" name="登记证号或批准筹备文号" id="sorgCode" field="sorgCode" maxlength="32" style="width:90%"  >
									</td>
									<td id="sorgCodeTd" class="FieldInput" style="width:30%" style="display:none">
									<label type="text" id="sorgCode" name='登记证号或批准筹备文号' field="sorgCode"  onkeyup="value=value.replace(/[^\\w\.\/]/ig,'').toUpperCase()"  style="width:55%"/>
									</td>
									<td class="FieldLabel" style="width:18%">社团名称：</td>
									<td class="FieldInput" style="width:36%">
									<label type="text" id="sorgName" name='社会团体名称' field="sorgName" style="width:55%"/>
									</td>
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
									<td class="FieldInput" colspan="3">第<input type="text" name="会议名称" id="meetingName" field="meetingName" maxlength="50" style="width:5%" onchange="ifNumber(this);">次
									<select id="meetingNameSelect" field="electionType">
									  <option value ="0">会员代表大会</option>
									  <option value ="1">会员大会</option>
									</select>
									<span style="color:red">*</span></td>
								<%}else{ %>
									<td class="FieldLabel">会议名称：</td>
									<td class="FieldInput" colspan="3"><input type="text" name="会议名称" id="meetingName" field="meetingName" maxlength="50" style="width:50%">
									<span style="color:red">*</span></td>
								<%} %>
								</tr>
								<tr>
									<td class="FieldLabel">召开时间：</td>
									<td class="FieldInput"><input type="text" field="meetingDate" style="width:90%" readonly="readonly" onclick="WdatePicker()"/></td>
									<td class="FieldLabel">召开地点：</td>
									<td class="FieldInput"><input type="text" name="召开地点" field="meetingPlace" maxlength="50" style="width:90%"></td>
								</tr>
								<tr>
									<td class="FieldLabel">参会主要人员：</td>
									<td class="FieldInput"><input type="text" name="参会主要人员" field="mainPeople" maxlength="500" style="width:90%"></td>
									<td class="FieldLabel">参会人数：</td>
									<td class="FieldInput"><input type="text" name="参会人数" field="shouldNum"  maxlength="6" style="width:90%"></td>
								</tr>
								<tr>
									<td class="FieldLabel">上次换届时间：</td>
									<td class="FieldInput"><input type="text" field="lastDate" style="width:90%" readonly="readonly" onclick="WdatePicker()"/></td>
									<td class="FieldLabel">应到届时间：</td>
									<td class="FieldInput"><input type="text" field="nextDate" style="width:90%" readonly="readonly" onclick="WdatePicker()"/></td>
								</tr>
								<tr>
									<td class="FieldLabel">是否制定或修改会费标准：</td>
									<td class="FieldInput">
										<select id="ifMakeFee" field="ifMakeFee" name='"是否制定或修改会费标准"' style="width:90%">
											<option dataset="yesornoDataSet"></option>
										</select>
									</td>
									<td class="FieldLabel">候选人人数：</td>
									<td class="FieldInput"><label id="chiefNum" field="chiefNum"/></td>
								</tr>
							</table>
						</form>
					</next:Html>
				</next:Panel>
				<next:EditGridPanel id="aspchiefGrid" dataset="somAspchiefDataSet" height="300" width="98.5%" stripeRows="true">
					<next:TopBar>
						<next:ToolBarItem symbol="领导职务候选人基本情况"></next:ToolBarItem>
						<next:ToolBarItem symbol="->"></next:ToolBarItem>
						<next:ToolBarItem iconCls="add" text="增加" handler="addAspchief"></next:ToolBarItem>
						<next:ToolBarItem iconCls="delete" text="删除" handler="delAspchief"></next:ToolBarItem>
					</next:TopBar>
					<next:Columns>
						<next:RowNumberColumn/>
						<next:RadioBoxColumn></next:RadioBoxColumn>
						<next:Column header="身份证号" field="idCard" width="15%" editable="true"><next:TextField/></next:Column>
						<next:Column header="姓名" field="name" width="10%" editable="true"><next:TextField/></next:Column>
						<next:Column header="性别" field="sex" width="4%" editable="true"><next:ComboBox dataset="sexDataSet"/></next:Column>
						<next:Column header="出生年月" field="birthday" width="10%" editable="true"><next:TextField /></next:Column>
						<next:Column header="政治面貌" field="politics" width="15%" editable="true"><next:ComboBox dataset="politicsSelect"/></next:Column>
						<next:Column header="户口所在地" field="populace" width="10%" editable="true"><next:TextField/></next:Column>
						<next:Column header="拟任社团职务" field="sorgDuties" width="10%" editable="true"><next:ComboBox dataset="sorgDutiesDataSet"/></next:Column>
						<next:Column header="是否是拟任法定代表人" field="ifLegal" width="12%" editable="true"><next:ComboBox dataset="yesornoDataSet"></next:ComboBox></next:Column>
						<next:Column header="人事关系所在单位" field="workName" width="20%" editable="true"><next:TextField/></next:Column>
						<next:Column header="职务" field="workDuties" width="10%" editable="true"><next:TextField/></next:Column>
						<next:Column header="批准兼职组织人事部门" field="promiseOrgan" width="15%" editable="true"><next:TextField/></next:Column>
						<next:Column header="文号" field="promiseCode" width="10%" editable="true"><next:TextField/></next:Column>
						<next:Column header="担任其他社团职务" field="otherDuties" width="15%" editable="true"><next:TextField/></next:Column>
						<next:Column header="刑事处罚情况" field="penal" width="15%" editable="true"><next:TextField/></next:Column>
					</next:Columns>
				</next:EditGridPanel>
				<next:Panel width="98.5%" autoScroll="true">
					<next:Html>
						<form id="form2" method="post" dataset="somApplyDataSet" onsubmit="return false" class="L5form">
							<fieldset>
							<legend>审查意见</legend>
							<table width="100%">
								<tr>
									<td class="FieldLabel" style="width:20%">业务主管单位审查意见：</td>
									<td class="FieldInput" colspan="5"><textarea field="borgOpinion" cols="65" rows="2" style="width:97%"></textarea></td>
								</tr>
								<tr>
									<td class="FieldLabel" style="width:20%">业务主管单位：</td>
									<td class="FieldInput" colspan="3" style="width:40%">
										<input type="text" id="borgNameDispaly" name="borgNameDispaly" style="width:50%"  title="业务主管单位"  onkeyup="findDiv(this,'borgName','popup','','businessOrganAuto','BORG_NAME@like','borgCode','borgName','35')" onblur="clearDiv()" onchange="clearBorg(this)"/><img src="<%=SkinUtils.getImage(request,"l5/help.gif")%>" style="cursor:hand" onclick="showBorgWin()"/>
										<div id="popup" style="width:300px; height: 150px; display: none;position: absolute;background-color: #FFFFFF;" >
	        								<ul></ul>
	   									</div>
	   									<input type="hidden" id="borgName" name="borgName" field="borgName" title="业务主管单位代码"/>
										<span style="color:red">*</span>
									</td>
									<td class="FieldLabel"  style="width:20%">业务主管单位审查日期：</td>
									<td class="FieldInput"  style="width:20%"><input type="text" field="borgCheckDate" format="Y-m-d" onclick="WdatePicker();" style="width:90%"></td>
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
<jsp:include page="../../../../../../cams/sorg/comm/upload/uploadWindow.jsp" flush="true"/>
<jsp:include page="../../../borg/borgSelectWindow.jsp" flush="true"/>
</body>
</html>