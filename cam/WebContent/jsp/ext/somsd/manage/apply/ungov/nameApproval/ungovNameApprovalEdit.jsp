<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.sorg.online.apply.util.SomIdHelpOnline"%>
<%@page import="com.inspur.cams.sorg.util.ApplyType"%>
<%@ page import="com.inspur.cams.comm.extuser.data.ComExtUser"%>
<%@ page import="com.inspur.cams.sorg.online.extuser.util.SomExtBspInfo"%>
<html>
<head>
<title>民办非企业单位名称核准</title>
<next:ScriptManager></next:ScriptManager>
<%
	ComExtUser comExtUser = (ComExtUser)SomExtBspInfo.getUserInfo(request).getComExtUser();
	String username = comExtUser.getUserName();
	String organArea = comExtUser.getAreaCode();//获取外部单位行政区划12位
	String userId = comExtUser.getUserId();
	String method=request.getParameter("method");
	String sorgId ="";
	String taskCode ="";
	if(method.equals("INSERT")){
		sorgId = SomIdHelpOnline.getUngovSorgId(organArea);
		taskCode = SomIdHelpOnline.getUngovTaskCode(organArea);
	}else{
		sorgId = request.getParameter("sorgId");
		taskCode = request.getParameter("taskCode") ;
	}
%>
<script>
	var method='<%=request.getParameter("method")%>';
	var sorgType='<%=request.getParameter("sorgType")%>';
	var taskCode='<%=taskCode%>';
	var sorgId='<%=sorgId%>';
	var applyType="100";
	var rootPath="<%=SkinUtils.getRootUrl(request)%>";
	var morgArea='<%=organArea%>';
	var userId='<%=userId%>';
</script>
<script type="text/javascript" src="ungovNameApprovalEdit.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams/sorgUpload.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"My97DatePicker/WdatePicker.js") %>'></script>
</head>
<body>
<model:datasets>
	<model:dataset id="somApplyDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomApplyQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomApply">
			<model:field name="appPeople" type="string" rule="length{30}"/>
			<model:field name="curOpinionId" type="string" rule="require"/>
			<model:field name="curOpinion" type="string" rule="length{200}"/>
		</model:record>
	</model:dataset>
	<model:dataset id="somOrganDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomOrganQueryCmd" global="true" method="queryOrganOnline">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomOrgan">
			<model:field name="cnName" type="string" rule="require|length{100}" />
			<model:field name="purpose" type="string" rule="require|length{1000}" />
			<model:field name="business" type="string" rule="require|length{1000}" />
			<model:field name="currency" type="string" rule="length{50}" />
			<model:field name="regMon" type="string" rule="double|length{14}" />
			<model:field name="fundingPeople" type="string" rule="length{500}" />
			<model:field name="moneySource" type="string" rule="length{500}" />
			<model:field name="residence" type="string" rule="require|length{100}" />
		</model:record>
	</model:dataset>
	<model:dataset id="OrganDataSetForQuery" cmd="com.inspur.cams.sorg.base.cmd.SomOrganQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomOrgan"></model:record>
	</model:dataset>
	<model:dataset id="somHeldPeopleDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomHeldPeopleQueryCmd" global="true" pageSize="100">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomHeldPeople">
			<model:field name="idCard" type="string" rule="custom{fn:validIDCard,min:2}" />
			<model:field name="birthday" type="string" rule="custom{fn:validDate,min:2}"/>
			<model:field name="name" type="string" rule="require|length{30}" />
			<model:field name="populace" type="string" rule="length{100}" />
			<model:field name="workName" type="string" rule="length{100}" />
			<model:field name="workDuties" type="string" rule="length{100}" />
		</model:record>
	</model:dataset>
	<model:dataset id="aspChiefDataset" cmd="com.inspur.cams.sorg.base.cmd.SomAspchiefQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomAspchief">
			<model:field name="name" type="string" rule="require|length{72}" />
			<model:field name="workDuties" type="string" rule="length{50}" />
			<model:field name="workName" type="string" rule="length{100}" />
			<model:field name="populace" type="string" rule="length{50}" />
			<model:field name="idCard" type="string" rule="length{18}" />
			<model:field name="sex" type="string" rule="length{1}" />
		</model:record>
	</model:dataset>
	<model:dataset id="somHeldOrganDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomHeldOrganQueryCmd" global="true" pageSize="100">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomHeldOrgan">
			<model:field name="name" type="string" rule="require" />
			<model:field name="heldorganPeople" type="string" rule="length{30}" />
		</model:record>
	</model:dataset>
	<model:dataset id="SomFlowDataSet" cmd="com.inspur.cams.sorg.workflow.cmd.SomFlowCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomFlow"></model:record>
	</model:dataset>
	<%--电子档案--%>
	<model:dataset id="somElectronicDataSet" cmd="com.inspur.cams.sorg.upload.cmd.SomElectronicQueryCmd" global="true" method="queryCatalog">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomElectronic"></model:record>
	</model:dataset>
	<%--电子档案上传窗口--%>
	<model:dataset id="winElectronicDataSet" cmd="com.inspur.cams.sorg.upload.cmd.SomElectronicQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomElectronic"></model:record>
	</model:dataset>
	<model:dataset id="sorgKindSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value="DIC_UNGOV_KIND"></model:param>
			<model:param name="value" value="CODE"></model:param>
			<model:param name="text" value="NAME"></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="borgDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true"  sortField="ORDER_NUMBER">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='SOM_BUSINESS_ORGAN'></model:param>
			<model:param name="value" value='BORG_CODE'></model:param>
			<model:param name="text" value='BORG_NAME'></model:param>
			<model:param name="filterSql" value='<%="MORG_CODE ="+organArea.substring(0,6)%>'></model:param>
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
	<model:dataset id="sexDataSet" enumName="COMM.SEX" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="yesornoDataSet" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="opinionDataSet" enumName="WORKFLOW.OPINION" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="hisOpinionDataSet" enumName="WORKFLOW.OPINION" autoLoad="true" global="true"></model:dataset>
</model:datasets>
<%--定义界面--%>
<next:Panel width="100%" height="100%">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="save" text="保存" handler="save"/>
		<next:ToolBarItem iconCls="undo" text="返回" handler="returnClick"/>
	</next:TopBar>

	<next:TabPanel id="tab" width="100%" height="100%" activeTab="0">
		<next:Tabs>
			<next:Panel title="民办非企业单位名称预先核准申请表" width="100%" autoScroll="true">
				<next:Html>
					<fieldset>
					<form method="post" dataset="somOrganDataSet" onsubmit="return false" class="L5form">
					<input type="hidden" name="sorgId" field="sorgId"/>
					<table width="100%">
						<tr>
							<td class="FieldLabel" style="width:20%">申请设立民办非企业单位名称：</td>
							<td class="FieldInput" colspan="5">
							<label type="text" id="cnName" name='申请设立民办非企业单位名称' field="cnName" style="width:55%"/>
							</td>
						</tr>
						<tr>
							<td class="FieldLabel">单位宗旨：</td>
							<td class="FieldInput" colspan="5"><textarea rows="5" name='"单位宗旨"' field="purpose" style="width:98%"></textarea><span style="color:red">*</span></td>
						</tr>
						<tr>
							<td class="FieldLabel">业务范围：</td>
							<td class="FieldInput" colspan="5"><textarea rows="5" name='"业务范围"' field="business" style="width:98%"></textarea><span style="color:red">*</span></td>
						</tr>
						<tr>
							<td class="FieldLabel">拟定业务主管单位：</td>
							<td class="FieldInput">
							<input type="text" id="borgNameDispaly" name="borgNameDispaly"  title="拟定业务主管单位"  onkeyup="findDiv(this,'borgName','popup','','businessOrganAuto','BORG_NAME@like','borgCode','borgName','35')" onblur="clearDiv()" onchange="clearBorg(this)"/><img src="<%=SkinUtils.getImage(request,"l5/help.gif")%>" style="cursor:hand" onclick="showBorgWin()"/>
							<div id="popup" style="width:300px; height: 150px; display: none;position: absolute;background-color: #FFFFFF;" >
 	        					<ul></ul>
     						</div>
     						<input type="hidden" id="borgName" name="borgName" field="borgName" title="业务主管单位代码"/>
							<span style="color:red">*</span></td>
						</tr>
						<tr>
							<td class="FieldLabel"><label>拟定开办资金币种：</label></td>
							<td class="FieldInput" colspan="5"><input type="text" field="currency" name='"拟定开办资金币种"' readonly/></td>
						</tr>
						<tr>
							<td class="FieldLabel">拟定开办资金数额（万元）：</td>
							<td class="FieldInput" colspan="5"><textarea rows="3" field="regMon" name='"拟定开办资金数额（万元）"' style="width:98%"></textarea></td>
						</tr>
						<tr>
							<td class="FieldLabel">出资人：</td>
							<td class="FieldInput" colspan="5"><textarea name='出资人' field="fundingPeople" style="width:98%" ></textarea></td>
						</tr>
						<tr>
							<td class="FieldLabel">资金来源：</td>
							<td class="FieldInput" colspan="5"><textarea rows="3" field="moneySource" name='"资金来源"' style="width:98%"></textarea></td>
						</tr>
						<tr>
							<td class="FieldLabel">办公地点：</td>
							<td class="FieldInput" colspan="5"><input type="text" name='办公地点' field="residence" style="width:98%"/><span style="color:red">*</span></td>
						</tr>
					</table>
					</form>
					</fieldset>
					<fieldset>
					<legend>拟任负责人情况</legend>
					<form method="post" dataset="aspChiefDataset" onsubmit="return false" class="L5form" style="border-width:0px">
					<table width="100%">
						<tr>
							<td class="FieldLabel" style="width:17%">身份证号：</td>
							<td class="FieldInput" style="width:17%"><input type="text" name='"身份证号"' field="idCard" onchange="checkIdCardAndFillOther(this)" style="width:90%"/></td>
							<td class="FieldLabel" style="width:17%">姓名：</td>
							<td class="FieldInput" style="width:17%"><input type="text" name='"姓名"' field="name" style="width:90%"/><span style="color:red">*</span></td>
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
							<td class="FieldLabel" >户口所在地：</td>
							<td class="FieldInput" colspan="3"><input type="text" name='"户口所在地"'id='populace' field="populace" style="width:90%"/></td>
							<td class="FieldLabel" >联系电话：</td>
							<td class="FieldInput"><input type="text" name='"联系电话"'id='phone' field="phone" style="width:90%"/></td>

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
							<td class="FieldInput" style="width:17%"><input type="text" name='"申请人电话"'id='appPhone' field="appPhone" style="width:90%"/></td>
							<td class="FieldLabel" style="width:17%">申请日期：</td>
							<td class="FieldInput" style="width:17%"><input type="text" name='申请日期' field="appDate" onclick="WdatePicker()" readonly="readonly" style="width:90%"/></td>
						</tr>
					</table>
					</form>
					</fieldset>
				</next:Html>
			</next:Panel>

			<next:Panel title="举办者情况">
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
						<next:Column header="户口所在地" field="populace" width="15%" editable="true"><next:TextField/></next:Column>
						<next:Column header="工作单位" field="workName" width="25%" editable="true"><next:TextField/></next:Column>
						<next:Column header="工作单位职务" field="workDuties" width="20%" editable="true"><next:TextField/></next:Column>
						<next:Column header="联系电话" field="phone" width="15%" editable="true"><next:TextField/></next:Column>
					</next:Columns>
				</next:EditGridPanel>
			</next:Panel>

			<next:Panel title="举办单位情况">
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
						<next:Column header="举办单位名称" field="name" width="40%" editable="true"><next:TextField/></next:Column>
						<next:Column header="举办单位主要负责人" field="heldorganPeople" width="15%" editable="true"><next:TextField/></next:Column>
						<next:Column header="联系电话" field="phone" width="20%" editable="true"><next:TextField/></next:Column>
					</next:Columns>
				</next:EditGridPanel>
			</next:Panel>

			<next:Panel title="法律要件">
				<next:EditGridPanel id="uploadGrid" width="100%" stripeRows="true" height="100%" dataset="somElectronicDataSet">
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
			</next:Panel>

		</next:Tabs>
	</next:TabPanel>
</next:Panel>
<jsp:include page="../../../../../../cams/sorg/comm/upload/uploadWindow.jsp" flush="true"/>
<jsp:include page="../../../borg/borgSelectWindow.jsp" flush="true"/>
</body>
</html>