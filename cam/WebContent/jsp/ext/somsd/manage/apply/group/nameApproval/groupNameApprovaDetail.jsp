<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@page import="com.inspur.cams.sorg.online.apply.util.SomIdHelpOnline"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<%@page import="com.inspur.cams.sorg.util.ApplyType"%>
<%@ page import="com.inspur.cams.comm.extuser.data.ComExtUser"%>
<%@ page import="com.inspur.cams.sorg.online.extuser.util.SomExtBspInfo"%>
<%
	ComExtUser comExtUser = (ComExtUser)SomExtBspInfo.getUserInfo(request).getComExtUser();
	String username = comExtUser.getUserName();
	String organArea = comExtUser.getAreaCode();//获取外部单位行政区划12位
	String userId = comExtUser.getUserId();
	String sorgId ="";
	String taskCode ="";
		sorgId = request.getParameter("sorgId");
		taskCode = request.getParameter("taskCode") ;
	
%>
<html>
<head>
<title>社会团体申请名称核准登记</title>
<next:ScriptManager></next:ScriptManager>
<script>
	var sorgType='<%=request.getParameter("sorgType")%>';
	var taskCode='<%=taskCode%>';
	var sorgId='<%=sorgId%>';
	var applyType="000";
	var rootPath="<%=SkinUtils.getRootUrl(request)%>";
	var morgArea='<%=organArea%>';
	var userId='<%=userId%>';
</script>
<script type="text/javascript" src="groupNameApprovaDetail.js"></script>
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
	<model:dataset id="somOrganDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomOrganQueryCmd" global="true" method="queryOrganOnline">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomOrgan">
			<model:field name="cnName" type="string" rule="require|length{100}" />
			<model:field name="purpose" type="string" rule="require|length{1000}" />
			<model:field name="business" type="string" rule="require|length{1000}" />
			<model:field name="buildStatus" type="string" rule="length{500}" />
			<model:field name="absorpMember" type="string" rule="length{500}" />
		</model:record>
	</model:dataset>
	<model:dataset id="OrganDataSetForQuery" cmd="com.inspur.cams.sorg.base.cmd.SomOrganQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomOrgan"></model:record>
	</model:dataset>
	<model:dataset id="somHeldPeopleDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomHeldPeopleQueryCmd" global="true" pageSize="100">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomHeldPeople">
			<model:field name="idCard" type="string"  />
			<model:field name="birthday" type="string"/>
			<model:field name="name" type="string" rule="require|length{30}" />
			<model:field name="populace" type="string" rule="length{100}" />
			<model:field name="workName" type="string" rule="length{100}" />
			<model:field name="workDuties" type="string" rule="length{100}" />
		</model:record>
	</model:dataset>
	<model:dataset id="somHeldOrganDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomHeldOrganQueryCmd" global="true" pageSize="100">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomHeldOrgan">
			<model:field name="name" type="string" rule="require" />
			<model:field name="heldorganPeople" type="string" rule="length{30}" />
		</model:record>
	</model:dataset>
	<%--电子档案--%>
	<model:dataset id="somElectronicDataSet" cmd="com.inspur.cams.sorg.upload.cmd.SomElectronicQueryCmd" global="true" method="queryCatalog">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomElectronic"></model:record>
	</model:dataset>
	<%--电子档案上传窗口--%>
	<model:dataset id="winElectronicDataSet" cmd="com.inspur.cams.sorg.upload.cmd.SomElectronicQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomElectronic"></model:record>
	</model:dataset>
	<model:dataset id="borgDataSet" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true"  sortField="ORDER_NUMBER">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='SOM_BUSINESS_ORGAN'></model:param>
			<model:param name="value" value='BORG_CODE'></model:param>
			<model:param name="text" value='BORG_NAME'></model:param>
			<model:param name="filterSql" value='<%="MORG_CODE ="+organArea%>'></model:param>

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
	<model:dataset id="sorgStatusSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_SORG_STATUS'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="yesornoDataSet" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="opinionDataSet" enumName="WORKFLOW.OPINION" autoLoad="true" global="true"></model:dataset>		
	<model:dataset id="hisOpinionDataSet" enumName="WORKFLOW.OPINION" autoLoad="true" global="true"></model:dataset>
</model:datasets>
<%--定义界面--%>
<next:Panel width="100%" height="100%">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>	
		
		<next:ToolBarItem iconCls="undo" text="返回" handler="returnClick"/>
	</next:TopBar>
	
	<next:TabPanel id="tab" width="100%" height="100%" activeTab="0">
		<next:Tabs>
			<next:Panel title="社会团体名称核准表" width="100%" autoScroll="true">
				<next:Html>
					<fieldset>
					<legend>社会团体名称核准表</legend>
					<form method="post" dataset="somOrganDataSet" onsubmit="return false" class="L5form">
					<input type="hidden" name="sorgId" field="sorgId"/>
					<table width="100%">
						<tr>
							<td class="FieldLabel" style="width:17%">申请立项社团名称：</td>
							<td class="FieldInput" colspan="5" id="nameTD" style="display:none">
							<label type="text" id="cnName" name='申请立项社团名称' field="cnName" style="width:55%"/>
							<span style="color:red">*</span>
							</td>
							
							<td class="FieldInput" colspan="5"  id="branchNameTD" style="display:none">
							<label type="text" id="branchName" name='申请立项社团（分支、代表机构）名称' field="cnName" style="width:55%"/>
							<span style="color:red">*</span>
							
							</td>
						</tr>
						<tr>
							<td class="FieldLabel">社团宗旨：</td>
							<td class="FieldInput" colspan="5"><textarea disabled rows="5" name='"社团宗旨"' field="purpose" style="width:98%"></textarea><span style="color:red">*</span></td>
						</tr>
						<tr>
							<td class="FieldLabel">业务范围：</td>
							<td class="FieldInput" colspan="5"><textarea disabled  rows="5" name='"业务范围"' field="business" style="width:98%"></textarea><span style="color:red">*</span></td>
						</tr>
						<tr>
							<td class="FieldLabel">拟确定业务主管单位：</td>
								<td class="FieldInput"  colspan="5">
								<label type="text" id="borgNameDispaly" name="borgNameDispaly"  title="拟确定业务主管单位" />
								<div id="popup" style="width:300px; height: 150px; display: none;position: absolute;background-color: #FFFFFF;" >  
 	        						<ul></ul> 
     							</div>
     							<input type="hidden" id="borgName" name="borgName" field="borgName" title="业务主管单位代码"/>
								<span style="color:red">*</span></td>
						</tr>
						<tr>
							<td class="FieldLabel">国家及其他省、市设立此类社团的情况：</td>
							<td class="FieldInput" colspan="5"><textarea disabled rows="3" field="buildStatus" name='"国家及其他省、市设立此类社团的情况"' style="width:98%"></textarea></td>
						</tr>
						<tr>
							<td class="FieldLabel">拟吸收会员的意向：</td>
							<td class="FieldInput" colspan="5"><textarea disabled rows="3" field="absorpMember" name='"拟吸收会员的意向"' style="width:98%"></textarea></td>
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
							<td class="FieldInput"  style="width:17%"><label type="text" name='"申请人"' field="appPeople" style="width:90%"/></td>
							<td class="FieldLabel" style="width:17%">联系人电话：</td>
							<td class="FieldInput" style="width:17%"><label type="text" id="sorgPhone" name='"申请人电话"' field="appPhone" style="width:90%"/></td>
							<td class="FieldLabel" style="width:17%">申请日期：</td>
							<td class="FieldInput" style="width:17%"><label type="text" name='申请日期' field="appDate"  readonly="readonly" style="width:90%"/></td>
						</tr>
					</table>
					</form>
					</fieldset>
				</next:Html>
			</next:Panel>
			
			<next:Panel title="筹备发起人（自然人）">
				<next:EditGridPanel id="heldPeopleGrid" dataset="somHeldPeopleDataSet" width="100%" stripeRows="true" height="100%">
					<next:TopBar>
						<next:ToolBarItem symbol="->"></next:ToolBarItem>
					</next:TopBar>
					<next:Columns>
						<next:RowNumberColumn/>
						<next:RadioBoxColumn></next:RadioBoxColumn>
						<next:Column header="内码" field="id" width="15%" editable="true" hidden="true"><next:TextField/></next:Column>
						<next:Column header="身份证号" field="idCard" width="20%" editable="false"><next:TextField/></next:Column>
						<next:Column header="姓名" field="name" width="10%" editable="false"><next:TextField/></next:Column>
						<next:Column header="性别" field="sex" width="10%" editable="false" ><next:ComboBox dataset="sexDataSet"></next:ComboBox></next:Column>
						<next:Column header="出生年月" field="birthday" width="10%" editable="false"><next:TextField /></next:Column>
						<next:Column header="工作单位" field="workName" width="25%" editable="false"><next:TextField/></next:Column>
						<next:Column header="工作单位职务" field="workDuties" width="15%" editable="false"><next:TextField/></next:Column>
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
					</next:TopBar>
					<next:Columns>
						<next:RowNumberColumn/>
						<next:RadioBoxColumn></next:RadioBoxColumn>
						<next:Column header="内码" field="id" width="15%" editable="true" hidden="true"><next:TextField/></next:Column>
						<next:Column header="发起单位名称" field="name" width="50%" editable="false"><next:TextField/></next:Column>
						<next:Column header="发起单位负责人" field="heldorganPeople" width="18%" editable="false"><next:TextField/></next:Column>
						<next:Column header="联系电话" field="phone" width="30%" editable="false"><next:TextField/></next:Column>
					</next:Columns>
					<next:BottomBar>
						<next:PagingToolBar dataset="somHeldOrganDataSet"/>
					</next:BottomBar>
				</next:EditGridPanel>
			</next:Panel>
			<next:Panel title="法律要件">
				<next:EditGridPanel id="uploadGrid" width="100%" stripeRows="true" height="100%" dataset="somElectronicDataSet">
					<next:TopBar>
						<next:ToolBarItem symbol="附件列表"></next:ToolBarItem>
						<next:ToolBarItem symbol="->"></next:ToolBarItem>
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

<next:Window id="winCheckCnName" closeAction="hide" title="社会团体列表" width="700"  autoScroll="true" modal="true">
	<next:EditGridPanel id="gridCheckCnName" width="686" stripeRows="true" height="300" dataset="OrganDataSetForQuery">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
	</next:TopBar>
			<next:Columns>
				<next:RowNumberColumn />
				<next:RadioBoxColumn></next:RadioBoxColumn>
				<next:Column header="社会组织名称" field="cnName" width="316" sortable="false" editable="false"><next:TextField /></next:Column>
				<next:Column header="登记证号" field="sorgCode" width="150" sortable="false" editable="false"><next:TextField /></next:Column>
				<next:Column header="社会组织状态" field="sorgStatus" width="150" sortable="false" editable="false"  dataset="sorgStatusSelect"><next:TextField /></next:Column>
			</next:Columns>
			<next:BottomBar>
				<next:PagingToolBar dataset="OrganDataSetForQuery" />
			</next:BottomBar>
	</next:EditGridPanel>
</next:Window>
<jsp:include page="../../../../../../cams/sorg/comm/upload/uploadWindow.jsp" flush="true"/>
<jsp:include page="../../../borg/borgSelectWindow.jsp" flush="true"/>  
</body>
</html>