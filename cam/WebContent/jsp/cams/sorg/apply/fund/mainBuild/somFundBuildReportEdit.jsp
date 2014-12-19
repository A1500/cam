<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="com.inspur.cams.sorg.util.SomIdHelp"%>
<%@ page import="com.inspur.cams.comm.util.*"%>
<%
	String taskCode = SomIdHelp.getFundTaskCode();
	String sorgId =SomIdHelp.getFundSorgId();
%>
<html>
<head>
<title>申请名称核准</title>
<next:ScriptManager></next:ScriptManager>
<script>
	var processId='<%=request.getParameter("processId")%>';
	var actDefUniqueId='<%=request.getParameter("actDefUniqueId")%>';
	var assignmentId='<%=request.getParameter("assignmentId")%>';
	var method='<%=request.getParameter("method")%>';
	var taskCode='<%=taskCode%>';
	var sorgId='<%=sorgId%>';
	var somApplyType="201";
	var applyType="219";
	var morgArea='<%=BspUtil.getOrganCode()%>';
</script>
<script type="text/javascript" src="somFundBuildReportEdit.js"></script>
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
			<model:field name="appPeople" type="string" rule="length{72}" />
			<model:field name="curOpinion" type="string" rule="length{200}" />
			<model:field name="curOpinionId" type="string" rule="require" />
		</model:record>
	</model:dataset>
	<model:dataset id="somOrganDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomOrganQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomOrgan">
			<model:field name="cnName" type="string" rule="require|length{100}" />
			<model:field name="residence" type="string" rule="require|length{100}" />
			<model:field name="purpose" type="string" rule="require|length{1000}" />
			<model:field name="business" type="string" rule="require|length{1000}" />
			<model:field name="sorgKind" type="string" rule="require" />
			<model:field name="currency" type="string" rule="length{50}" />
			<model:field name="regMon" type="string" rule="double|require|length{14}" />
			<model:field name="moneySource" type="string" rule="length{500}" />
			<model:field name="borgName" type="string" rule="require" />
		</model:record>
	</model:dataset>
	<model:dataset id="OrganDataSetForQuery" cmd="com.inspur.cams.sorg.base.cmd.SomOrganQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomOrgan"></model:record>
	</model:dataset>
	<model:dataset id="somHeldPeopleDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomHeldPeopleQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomHeldPeople">
			<model:field name="ifChief" type="string" rule="" />
			<model:field name="name" type="string" rule="require|length{72}" />
			<model:field name="birthday" type="string" rule="length{10}" />
			<model:field name="workName" type="string" rule="length{100}" />
			<model:field name="workDuties" type="string" rule="length{100}" />
		</model:record>
	</model:dataset>
	<model:dataset id="somHeldOrganDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomHeldOrganQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomHeldOrgan">
			<model:field name="name" type="string" rule="require|length{100}" />
			<model:field name="heldorganPeople" type="string" rule="length{72}" />
		</model:record>
	</model:dataset>
	<model:dataset id="aspChiefDataset" cmd="com.inspur.cams.sorg.base.cmd.SomAspchiefQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomAspchief">
			<model:field name="name" type="string" rule="require|length{72}" />
			<model:field name="workDuties" type="string" rule="length{50}" />
			<model:field name="workName" type="string" rule="length{100}" />
			<model:field name="otherDuties" type="string" rule="length{500}" />
		</model:record>
	</model:dataset>
	<model:dataset id="SomFlowDataSet" cmd="com.inspur.cams.sorg.workflow.cmd.SomFlowCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomFlow"></model:record>
	</model:dataset>
	<%--电子档案--%>
	<model:dataset id="somElectronicDataSet" cmd="com.inspur.cams.sorg.upload.cmd.SomElectronicQueryCmd" global="true" method="queryCatalog" isGroup="true" groupField="applyType" pageSize="50">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomElectronic"></model:record>
	</model:dataset>
	<%--获取社会组织名称前缀--%>
	<model:dataset id="sorgNamePrefixDataSet" cmd="com.inspur.cams.sorg.util.SorgNameAssembleUtil" global="true" method="getPrefix" autoLoad="true">
		<model:record>
			<model:field name="value" mapping="code" type="string" />
			<model:field name="text" mapping="content" type="string" />
		</model:record>
	</model:dataset>
	<%--电子档案上传窗口--%>
	<model:dataset id="winElectronicDataSet" cmd="com.inspur.cams.sorg.upload.cmd.SomElectronicQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomElectronic"></model:record>
	</model:dataset>
	<model:dataset id="sorgKindSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value="DIC_FUND_KIND"></model:param>
			<model:param name="value" value="CODE"></model:param>
			<model:param name="text" value="NAME"></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="borgDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='SOM_BUSINESS_ORGAN'></model:param>
			<model:param name="value" value='BORG_CODE'></model:param>
			<model:param name="text" value='BORG_NAME'></model:param>
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
	<model:dataset id="sorgStatusSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_SORG_STATUS'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="sexDataSet" enumName="COMM.SEX" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="yesornoDataSet" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="opinionDataSet" enumName="WORKFLOW.OPINION" autoLoad="true" global="true"></model:dataset>
</model:datasets>
<%--定义界面--%>
<next:Panel width="100%" height="100%">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="save" text="保存" handler="save"/>
		<next:ToolBarItem iconCls="select" text="提交" handler="submit"/>
		<next:ToolBarItem iconCls="undo" text="返回" handler="returnClick"/>
	</next:TopBar>
	<next:TabPanel id="tab" width="100%" height="100%" activeTab="0">
		<next:Tabs>
			<next:Panel title="申请设立基金会名称核准表" width="100%" autoScroll="true">
				<next:Html>
					<fieldset>
					<legend>申请设立基金会称核准表</legend>
					<form method="post" dataset="somOrganDataSet" onsubmit="return false" class="L5form">
					<input type="hidden" name="sorgId" field="sorgId"/>
					<table width="100%">
						<tr>
							<td class="FieldLabel" style="width:17%">申请设立基金会名称：</td>
							<td class="FieldInput" colspan="5">
							<select  id="cnNamePrefix" style="width:150px" default="1" onblur="checkSole();">
									<option dataset="sorgNamePrefixDataSet" ></option>
							</select>
							<input type="text" id="cnName" name='申请设立基金会名称' field="cnName" style="width:60%" onblur="checkSole();"/>
							<label id="cnNameSuffix" style="width:40px">基金会</label>
							<span style="color:red">*</span>

							</td>
						</tr>
						<tr>
							<td class="FieldLabel">住所：</td>
							<td class="FieldInput" colspan="5"><input type="text" name='住所' field="residence" style="width:98%"/><span style="color:red">*</span></td>
						</tr>
						<tr>
							<td class="FieldLabel">基金会类型：</td>
							<td class="FieldInput" colspan="5"><select id="sorgKind" field="sorgKind" name='基金会类型' style="width:90%"><option dataset="sorgKindSelect"></option></select><span style="color:red">*</span></td>
						</tr>
						<tr>
							<td class="FieldLabel">宗旨：</td>
							<td class="FieldInput" colspan="5"><textarea rows="5" name='"宗旨"' field="purpose" style="width:98%"></textarea><span style="color:red">*</span></td>
						</tr>
						<tr>
							<td class="FieldLabel">业务范围：</td>
							<td class="FieldInput" colspan="5"><textarea rows="5" name='"业务范围"' field="business" style="width:98%"></textarea><span style="color:red">*</span></td>
						</tr>
						<tr>
							<td class="FieldLabel">拟确定业务主管单位：</td>
							<td class="FieldInput" colspan="5">
								<select field="borgName" name='"拟确定业务主管单位"' style="width:30%">
									<option dataset="borgDataSet"></option>
								</select><span style="color:red">*</span></td>
						</tr>
						<tr>
							<td class="FieldLabel"><label>拟筹集原始基金币种：</label></td>
							<td class="FieldInput" colspan="5"><input type="text" field="currency" name='"拟筹集原始基金币种"' /></td>
						</tr>
						<tr>
							<td class="FieldLabel">拟筹集原始基金数额（大写数字）：</td>
							<td class="FieldInput" colspan="5"><textarea rows="3" field="regMon" name='"拟筹集原始基金数额（万元）"' style="width:85%"></textarea>万元<span style="color:red">*</span></td>
						</tr>
						<tr>
							<td class="FieldLabel">资金主要来源：</td>
							<td class="FieldInput" colspan="5"><textarea rows="3" field="moneySource" name='"资金主要来源"' style="width:98%"></textarea></td>
						</tr>
					</table>
					</form>
					</fieldset>
					<fieldset>
					<legend>拟任法定代表人情况</legend>
					<form method="post" dataset="aspChiefDataset" onsubmit="return false" class="L5form" style="border-width:0px">
					<table width="100%">
						<tr>
							<td class="FieldLabel" style="width:17%">姓名：</td>
							<td class="FieldInput" style="width:17%"><input type="text" name='"姓名"' field="name" style="width:90%"/><span style="color:red">*</span></td>
							<td class="FieldLabel" style="width:17%">性别：</td>
							<td class="FieldInput" style="width:17%"><select field="sex"><option dataset="sexDataSet"></option></select></td>
							<td class="FieldLabel" style="width:17%">出生年月：</td>
							<td class="FieldInput" style="width:17%"><input type="text" name='出生年月' field="birthday" format="Y-m" onclick="WdatePicker()" style="width:90%"/></td>
						</tr>
						<tr>
							<td class="FieldLabel" >工作单位：</td>
							<td class="FieldInput" colspan="3"><input type="text" name='"工作单位"' field="workName" style="width:90%"/></td>
							<td class="FieldLabel" >工作单位职务：</td>
							<td class="FieldInput" ><input type="text"  name='"工作单位职务"' field="workDuties" style="width:90%"/></td>
						</tr>
						<tr>
							<td class="FieldLabel" >联系电话：</td>
							<td class="FieldInput" colspan="3"><input type="text" name='"联系电话"'id='phone' field="phone" style="width:90%"/></td>
							<td class="FieldLabel" >有无担任其他组织法人：</td>
							<td class="FieldInput" ><input type="text" name='"有无担任其他组织法人"' field="otherDuties" style="width:90%"/></td>
						</tr>
					</table>
					</form>
					</fieldset>
					<fieldset>
					<legend>联系人信息</legend>
					<form method="post" dataset="somApplyDataSet" onsubmit="return false" class="L5form" style="border-width:0px">
					<table width="100%">
						<tr>
							<td class="FieldLabel" style="width:17%">联系人：</td>
							<td class="FieldInput" style="width:17%"><input type="text" name='"申请人"' field="appPeople" style="width:90%"/></td>
							<td class="FieldLabel" style="width:17%">联系人电话：</td>
							<td class="FieldInput" style="width:17%"><input type="text" id="appPhone" name='"申请人电话"' field="appPhone" style="width:90%"/></td>
							<td class="FieldLabel" style="width:17%">申请日期：</td>
							<td class="FieldInput" style="width:17%"><input type="text" name='申请日期' field="appDate" format="Y-m-d" onclick="WdatePicker()" style="width:90%"/></td>
						</tr>
					</form>
					</fieldset>
				</next:Html>
			</next:Panel>

			<next:Panel title="发起人">
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
						<next:Column header="出生年月" field="birthday" width="10%" editable="true"><next:TextField /></next:Column>
						<next:Column header="工作单位" field="workName" width="25%" editable="true"><next:TextField/></next:Column>
						<next:Column header="工作单位职务" field="workDuties" width="15%" editable="true"><next:TextField/></next:Column>
						<next:Column header="联系电话" field="phone" width="20%" editable="true"><next:TextField/></next:Column>
					</next:Columns>
					<next:BottomBar>
						<next:PagingToolBar dataset="somHeldPeopleDataSet"/>
					</next:BottomBar>
				</next:EditGridPanel>
			</next:Panel>

			<next:Panel title="发起组织">
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
						<next:Column header="发起组织名称" field="name" width="40%" editable="true"><next:TextField/></next:Column>
						<next:Column header="发起组织主要负责人" field="heldorganPeople" width="25%" editable="true"><next:TextField/></next:Column>
						<next:Column header="联系电话" field="phone" width="20%" editable="true"><next:TextField/></next:Column>
					</next:Columns>
					<next:BottomBar>
						<next:PagingToolBar dataset="somHeldOrganDataSet"/>
					</next:BottomBar>
				</next:EditGridPanel>
			</next:Panel>

			<next:Panel title="法律要件">
				<next:GridPanel id="uploadGrid" width="100%" stripeRows="true" height="100%" dataset="somElectronicDataSet">
				<next:GroupingView forceFit="true"></next:GroupingView>
					<next:TopBar>
						<next:ToolBarItem symbol="附件列表"></next:ToolBarItem>
						<next:ToolBarItem symbol="->"></next:ToolBarItem>
						<next:ToolBarItem iconCls="add" text="增加上传附件" handler="clickUploadFile"></next:ToolBarItem>
					</next:TopBar>

					<next:Columns>
						<next:RowNumberColumn />
						<next:RadioBoxColumn></next:RadioBoxColumn>
						<next:Column header="档案目录名"  field="catalogCode" width="38%" dataset="cataLogCodeSelect"></next:Column>
						<next:Column header="附件名称"    field="fileName" width="30%" ></next:Column>
						<next:Column header="附件描述"    field="fileMess" width="20%" ></next:Column>
						<next:Column header="下载附件"    field="" width="10%" editable="false" renderer="clickDownloadHref"><next:TextField /></next:Column>
						<next:Column header="业务类型"    field="applyType" hidden="true">
							<next:ExtendConfig>
								groupRenderer:grender,groupName:"法律要件目录"
							</next:ExtendConfig>
						</next:Column>
					</next:Columns>
					<next:BottomBar>
						<next:PagingToolBar dataset="somElectronicDataSet" />
					</next:BottomBar>
				</next:GridPanel>
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
<next:Window id="winCheckCnName" closeAction="hide" title="基金会列表" width="700"  autoScroll="true" modal="true">
	<next:EditGridPanel id="gridCheckCnName" width="686" stripeRows="true" height="300" dataset="OrganDataSetForQuery">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="return" text="关闭" handler="closeCheckCnName"></next:ToolBarItem>
	</next:TopBar>
			<next:Columns>
				<next:RowNumberColumn />
				<next:RadioBoxColumn></next:RadioBoxColumn>
				<next:Column header="社会组织名称" field="cnName" width="316" sortable="true" editable="false"><next:TextField /></next:Column>
				<next:Column header="登记证号" field="sorgCode" width="150" sortable="true" editable="false"><next:TextField /></next:Column>
				<next:Column header="社会组织状态" field="sorgStatus" width="150" sortable="true" editable="false"  dataset="sorgStatusSelect"><next:TextField /></next:Column>
			</next:Columns>
			<next:BottomBar>
				<next:PagingToolBar dataset="OrganDataSetForQuery" />
			</next:BottomBar>
	</next:EditGridPanel>
</next:Window>
<jsp:include page="../../../comm/upload/uploadWindow.jsp" flush="true"/>
</body>
</html>