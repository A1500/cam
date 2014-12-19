<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.comm.util.StrUtil"%>
<%@page import="com.inspur.cams.sorg.util.SomIdHelp"%>
<html>
<head>
<title>社会团体换届审批</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="groupElectionEdit.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js") %>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js") %>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams/sorgUpload.js")%>'></script>
<script type="text/javascript">var rootPath='<%=SkinUtils.getRootUrl(request)%>';</script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"My97DatePicker/WdatePicker.js") %>'></script>
<%
	String taskCode = request.getParameter("taskCode");
	String method=request.getParameter("method");
	if("insert".equals(method)){
		taskCode = StrUtil.n2b(SomIdHelp.getGroupTaskCode());
	}
%>
<script type="text/javascript">
	var method='<%=method%>';
	var sorgId='<%=request.getParameter("sorgId")%>';
	var cnName=decodeURIComponent('<%=request.getParameter("cnName")%>');
	var sorgCode='<%=request.getParameter("sorgCode")%>';
	var electionId='<%=request.getParameter("electionId")%>';
	var applyType="009";
	var taskCode = '<%=taskCode%>';//生成业务编号
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
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomAspchief"></model:record>
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
			<model:param name="filterSql" value="CODE IN (00004,00007,00008,00009)"></model:param>
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
		<next:ToolBarItem iconCls="print" text="打印《社会组织筹建党组织告知书》" handler="printParty"></next:ToolBarItem>
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
									<td class="FieldLabel" style="width:18%">社团名称：</td>
									<td class="FieldInput" style="width:36%"><label id="cnName"/></td>
									<td class="FieldLabel" style="width:16%">登记证号：</td>
									<td class="FieldInput" style="width:30%"><label id="sorgCode"/></td>
								</tr>
								<tr>
									<td class="FieldLabel">联系人：</td>
									<td class="FieldInput"><input type="text" name="联系人" field="linkPeople" maxlength="36" style="width:90%"></td>
									<td class="FieldLabel">联系电话：</td>
									<td class="FieldInput"><input type="text" name="联系电话" field="linkPhone" maxlength="30" style="width:90%"></td>
								</tr>
								<tr>
									<td class="FieldLabel">会议名称：</td>
									<td class="FieldInput" colspan="3"><input type="text" name="会议名称" field="meetingName" maxlength="50" style="width:97%"></td>
								</tr>
								<tr>
									<td class="FieldLabel">召开时间：</td>
									<td class="FieldInput"><input type="text" field="meetingDate" style="width:90%" format="Y-m-d" onclick="WdatePicker()"/></td>
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
									<td class="FieldInput"><input type="text" field="lastDate" style="width:90%" format="Y-m-d" onclick="WdatePicker()"/></td>
									<td class="FieldLabel">应到届时间：</td>
									<td class="FieldInput"><input type="text" field="nextDate" style="width:90%" format="Y-m-d" onclick="WdatePicker()"/></td>
								</tr>
								<tr>
									<td class="FieldLabel">是否制定或修改会费标准：</td>
									<td class="FieldInput">
										<select id="ifMakeFee" field="ifMakeFee" name='"是否制定或修改会费标准"' style="width:90%">
											<option dataset="yesornoDataSet"></option>
										</select>
									</td>
									<td class="FieldLabel">候选人人数：</td>
									<td class="FieldInput"><input type="text" name="候选人人数" field="chiefNum" maxlength="6" style="width:90%"></td>
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
						<next:Column header="性别" field="sex" width="10%" editable="true"><next:ComboBox dataset="sexDataSet"/></next:Column>
						<next:Column header="出生年月" field="birthday" width="10%" editable="true"><next:TextField /></next:Column>
						<next:Column header="政治面貌" field="politics" width="15%" editable="true"><next:ComboBox dataset="politicsSelect"/></next:Column>
						<next:Column header="户口所在地" field="populace" width="10%" editable="true"><next:TextField/></next:Column>
						<next:Column header="拟任社团职务" field="sorgDuties" width="10%" editable="true"><next:ComboBox dataset="sorgDutiesDataSet"/></next:Column>
						<next:Column header="人事关系所在单位" field="workName" width="19%" editable="true"><next:TextField/></next:Column>
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
									<td class="FieldLabel">业务主管单位审查意见：</td>
									<td class="FieldInput" colspan="5"><textarea field="borgOpinion" cols="65" rows="2" style="width:97%"></textarea></td>
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

									<td class="FieldLabel" style="width:17%">业务主管单位审查日期：</td>
									<td class="FieldInput" style="width:15%"><input type="text" field="borgCheckDate" format="Y-m-d" onclick="WdatePicker();" style="width:90%"></td>
									<td class="FieldInput" style="width:34%"></td>
								</tr>
								<tr>
									<td class="FieldLabel">承办人：</td>
									<td class="FieldInput"><input type="text" field="acceptPeopleName" maxlength="6" style="width:90%"></td>
									<td class="FieldLabel">承办日期：</td>
									<td class="FieldInput"><input type="text"  field="acceptTime" format="Y-m-d" onclick=";" style="width:90%"></td>
									<td class="FieldInput"></td>
								</tr>
								<tr>
									<td class="FieldLabel">初审意见：</td>
									<td class="FieldInput" colspan="5"><textarea field="examinOpinion" cols="65" rows="2" style="width:97%"></textarea></td>
								</tr>
								<tr>
									<td class="FieldLabel">初审人：</td>
									<td class="FieldInput"><input type="text" field="examinPeopleName" maxlength="6" style="width:90%"></td>
									<td class="FieldLabel">初审日期：</td>
									<td class="FieldInput"><input type="text" field="examinTime" format="Y-m-d" onclick="WdatePicker();" style="width:90%"></td>
									<td class="FieldInput"></td>
								</tr>
								<tr>
									<td class="FieldLabel">核准意见：</td>
									<td class="FieldInput" colspan="5"><textarea field="checkOpinion" cols="65" rows="2" style="width:97%"></textarea></td>
								</tr>
								<tr>
									<td class="FieldLabel">核准人：</td>
									<td class="FieldInput"><input type="text" field="checkPeopleName" maxlength="6" style="width:90%"></td>
									<td class="FieldLabel">核准日期：</td>
									<td class="FieldInput"><input type="text" field="checkTime" format="Y-m-d" onclick="WdatePicker();" style="width:90%"></td>
									<td class="FieldInput"></td>
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
<jsp:include page="../../../comm/upload/uploadWindow.jsp" flush="true"/>
<jsp:include page="../../../comm/borg/borgSelectWindow.jsp" flush="true"/>
</body>
</html>