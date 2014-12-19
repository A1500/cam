<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="com.inspur.cams.sorg.util.SomIdHelp"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<%@page import="com.inspur.cams.sorg.online.apply.util.SomIdHelpOnline"%>
<%@ page import="com.inspur.cams.comm.extuser.data.ComExtUser"%>
<%@ page import="com.inspur.cams.sorg.online.extuser.util.SomExtBspInfo"%>
<%@page import="com.inspur.cams.sorg.util.ApplyType"%>
<html>
<head>
<title>民非注销登记录入</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="ungovCancelDetail.js"></script>
<script type="text/javascript" src="<%=SkinUtils.getJS(request,"cams.js") %>"></script>
<script type="text/javascript" src="<%=SkinUtils.getJS(request,"camsCheck.js") %>"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams/sorgUpload.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"My97DatePicker/WdatePicker.js") %>'></script>
<script type="text/javascript">
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
	var taskCode='<%=taskCode%>';
	var sorgId='<%=sorgId%>';
	var rootPath="<%=SkinUtils.getRootUrl(request)%>";
	var morgArea='<%=organArea%>';
	var userId='<%=userId%>';
	var applyType='<%=ApplyType.SOM_UNGOV_CANCEL%>';//业务类型
</script>
</head>
<body>

<model:datasets>
	<model:dataset id="somApplyDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomApplyQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomApply">	
			<model:field name="borgCheckDate" type="string" rule="require" />	
			<model:field name="borgOpinion" type="string" rule="require|length{300}" />
		</model:record>
	</model:dataset>
	<model:dataset id="somOrganDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomOrganQueryCmd" method="queryOrganOnline" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomOrgan">
			<model:field name="sorgCode" type="string" rule="require"/>
			<model:field name="organCode" type="string" rule="require|length{10}"/>
			<model:field name="cnName" type="string" rule="require|length{100}"/>
			<model:field name="buildDate" type="string" rule="require|length{10}"/>
			<model:field name="sorgKind" type="string" rule="require"/>
			<model:field name="busScope" type="string" rule="require"/>
			<model:field name="residence" type="string" rule="require|length{50}"/>
			<model:field name="sorgPhone" type="string" rule="require|length{30}"/>
			<model:field name="legalPeople" type="string" rule="require|length{30}"/>
			<model:field name="borgName" type="string" rule="require|length{100}"/>
			<model:field name="cancelDate" type="string" rule="require"/>
			<model:field name="cancelReason" type="string" rule="require|length{500}"/>
			<model:field name="liqResult" type="string" rule="require|length{200}"/>
		</model:record>
	</model:dataset>
	<model:dataset id="somLiqpeopleDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomLiqpeopleQueryCmd" global="true" sortField="IF_CHIEF" sortDirection="DESC">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomLiqpeople"></model:record>
	</model:dataset>
	<model:dataset id="winLiqpeopleDataSet" cmd="com.inspur.cams.sorg.manage.cmd.SomUngovLiqpeopleQueryCmd">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomLiqpeople">
			<model:field name="name" type="string" rule="require|length{72}"/>
			<model:field name="liqDuties" type="string" rule="require|length{50}"/>
			<model:field name="ifChief" type="string" rule="require"/>
			<model:field name="workName" type="string" rule="length{100}"/>
			<model:field name="workDuties" type="string" rule="length{50}"/>			
		</model:record>
	</model:dataset>
	<%--电子档案--%>
	<model:dataset id="somElectronicDataSet" cmd="com.inspur.cams.sorg.upload.cmd.SomElectronicQueryCmd" method="queryCatalog" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomElectronic"></model:record>
	</model:dataset>
	<%--电子档案上传窗口--%>
	<model:dataset id="winElectronicDataSet" cmd="com.inspur.cams.sorg.upload.cmd.SomElectronicQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomElectronic"></model:record>
	</model:dataset>
	<%--下载窗口--%>
	<model:dataset id="downloadDataSet" cmd="com.inspur.cams.sorg.upload.cmd.SomElectronicQueryCmd" method="queryElectronic">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomElectronic"></model:record>
	</model:dataset>	
	<model:dataset id="somOrganQueryDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomOrganQueryCmd" method="queryMain">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomOrgan">
		</model:record>
	</model:dataset>	
	<model:dataset id="sorgKindSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value="DIC_UNGOV_KIND"></model:param>
			<model:param name="value" value="CODE"></model:param>
			<model:param name="text" value="NAME"></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="busScopeSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_BUS_SCOPE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>	
	<model:dataset id="businessOrganSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='SOM_BUSINESS_ORGAN'></model:param>
			<model:param name="value" value='BORG_CODE'></model:param>
			<model:param name="text" value='BORG_NAME'></model:param>
			<model:param name="filterSql" value='<%="MORG_CODE ="+organArea.substring(0,6)%>'></model:param>

		</model:params>
	</model:dataset>
	<model:dataset id="cancelReasonSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_CANCEL_REASON'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>		
	<model:dataset id="cataLogCodeSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value="SOM_CATALOG"></model:param>
			<model:param name="value" value="CATALOG_CODE"></model:param>
			<model:param name="text" value="CATALOG_NAME"></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="yesornoDataSet" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="opinionSelect" enumName="WORKFLOW.OPINION" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="ifChiefSelect" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
</model:datasets>

<next:ViewPort>
	<next:Panel width="100%" height="100%">
		<next:TopBar>
			<next:ToolBarItem symbol="->"></next:ToolBarItem>
			<next:ToolBarItem iconCls="return" text="返回" handler="goBack"></next:ToolBarItem>
		</next:TopBar>
		<next:TabPanel id="tabSomOrgan" width="100%" height="100%">	
			<next:Tabs>
				<next:Panel id="panelSomOrgan" title="民办非企业单位注销登记表" width="100%" height="100%" autoScroll="true">
					<next:Html>
						<fieldset>
						<form id="cbForm" method="post" dataset="somOrganDataSet" onsubmit="return false" class="L5form">
						<table width="100%">
							<tr>
								<td class="FieldLabel" width="20%"><label>登记证号：</label></td>
								<td class="FieldInput" width="30%"><label id="sorgCode" field="sorgCode" name='"登记证号"' style="width:80%" maxlength="20"/></td>
								<td class="FieldLabel" width="20%"><label>组织机构代码：</label></td>
								<td class="FieldInput" width="30%"><label field="organCode" name='"组织机构代码"' style="width:80%" maxlength="9"/></td>
							</tr>
							<tr>
								<td class="FieldLabel"><label>单位名称：</label></td>
								<td class="FieldInput"><label id='cnName'field="cnName" name='"单位名称"' style="width:80%" maxlength="50"/></td>
								<td class="FieldLabel"><label>成立日期：</label></td>
								<td class="FieldInput"><label field="buildDate" name='"成立日期"' style="width:80%"/></td>
							</tr>
							<tr>	
								<td class="FieldLabel"><label>民办非企业单位类型：</label></td>
								<td class="FieldInput">
									<label id="sorgKind" field="sorgKind" dataset="sorgKindSelect" name='"民办非企业单位类型"' style="width:80%">
									</label>
								</td>																					
								<td class="FieldLabel"><label>所属行（事）业：</label></td>
								<td class="FieldInput">
									<label id="busScope" field="busScope" dataset="busScopeSelect" name='"所属行（事）业"' style="width:80%">
									</label>
								</td>
							</tr>
							<tr>							
								<td class="FieldLabel"><label>住所：</label></td>
								<td class="FieldInput"><label field="residence" name='"住所"' style="width:80%" maxlength="50"/></td>
								<td class="FieldLabel"><label>电话：</label></td>
								<td class="FieldInput"><label field="sorgPhone" name='"电话"' style="width:80%" maxlength="15"/></td>
							</tr>
							<tr>
								<td class="FieldLabel"><label>法定代表人：</label></td>
								<td class="FieldInput"><label field="legalPeople" name='"法定代表人"' style="width:80%" maxlength="30"/></td>
								<td class="FieldLabel"><label>业务主管单位：</label></td>
								<td class="FieldInput">
									<label id="borgName"  dataset="businessOrganSelect" field="borgName" name='"业务主管单位"' style="width:80%">
									</label>									
								</td>
							</tr>
							<tr>
								<td class="FieldLabel"><label>注销日期：</label></td>
								<td class="FieldInput"><label id="cancelDate" field="cancelDate" name='"注销日期"' style="width:80%"/></td>
								<td class="FieldLabel"></td>
								<td class="FieldInput"></td>
							</tr>
							<tr>
								<td class="FieldLabel"><label>申请注销理由：</label></td>
								<td class="FieldInput" colspan="3" ><textarea disabled rows="3" id="cancelReason" name='"申请注销理由"' field="cancelReason" style="width:93%"></textarea></td>
							</tr>
							<tr>
								<td class="FieldLabel"><label>清算结论：</label></td>
								<td class="FieldInput" colspan="3" ><textarea disabled rows="3" id="liqResult" name='"清算结论"' field="liqResult" style="width:93%"></textarea></td>
							</tr>
						</table>
						</form>
						</fieldset>
						<fieldset>
							<legend>业务主管单位意见</legend>
							<form method="post" dataset="somApplyDataSet" onsubmit="return false" class="L5form" >
							<table width="100%">
								<tr>
									<td class="FieldLabel" style="width:20%">审查日期：</td>
									<td class="FieldInput" style="width:30%"><label type="text" name='审查日期' field="borgCheckDate" readonly="readonly" style="width:80%"/></td>
									<td class="FieldLabel" style="width:20%"></td>
									<td class="FieldInput" style="width:30%"></td>
								</tr>
								<tr>
									<td class="FieldLabel">业务主管单位意见：</td>
									<td class="FieldInput" colspan="3"><textarea disabled rows="3" name='业务主管单位意见' field="borgOpinion" style="width:93%;"></textarea>
									</td>
								</tr>
							</table>
							</form>
						</fieldset>	
					</next:Html>
				</next:Panel>
	
				<next:GridPanel id="gridLiqpeople" dataset="somLiqpeopleDataSet" title="清算组织人员" width="100%" height="100%">
					<next:TopBar>
						<next:ToolBarItem symbol="清算组织主要组成人员列表"></next:ToolBarItem>
						<next:ToolBarItem symbol="->"></next:ToolBarItem>
					</next:TopBar>
					<next:Columns>
						<next:RowNumberColumn />
						<next:RadioBoxColumn></next:RadioBoxColumn>
						<next:Column header="内码" field="id" hidden="true" />
						<next:Column header="姓名" field="name" width="10%" />
						<next:Column header="在清算组织中职务" field="liqDuties" width="25%" />
						<next:Column header="清算组织负责人" field="ifChief" dataset="yesornoDataSet" width="15%" />
						<next:Column header="工作单位" field="workName" width="18%" />
						<next:Column header="职务（职称）" field="workDuties" width="18%" />		
					</next:Columns>
					<next:BottomBar>
						<next:PagingToolBar dataset="somLiqpeopleDataSet"/>
					</next:BottomBar>
				</next:GridPanel>

				<next:Panel title="法律要件" >
					<next:EditGridPanel id="uploadGrid" width="100%" stripeRows="true" height="100%" dataset="somElectronicDataSet">
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
				</next:Panel>
			</next:Tabs>
		</next:TabPanel>
	</next:Panel>
</next:ViewPort>
<jsp:include page="../../../../../../cams/sorg/comm/upload/uploadWindow.jsp" flush="true"/>
</body>
</html>