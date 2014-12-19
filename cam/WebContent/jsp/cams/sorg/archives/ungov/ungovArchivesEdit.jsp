<%@ page language="java" contentType="text/html;charset=utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<html>
<head>
<title>民办非企业归档页面</title> 
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="ungovArchivesEdit.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams/sorgUpload.js")%>'></script>
<script type="text/javascript">
	var sorgId='<%=request.getParameter("sorgId")%>';
</script>
</head>
<body>
<model:datasets>
	<model:dataset id="somOrganDataset" cmd="com.inspur.cams.sorg.base.cmd.SomOrganQueryCmd" method="queryOrgan" pageSize="15">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomOrgan"></model:record>
	</model:dataset>
	<%--电子档案--%>
	<model:dataset id="somElectronicDataSet" cmd="com.inspur.cams.sorg.upload.cmd.SomElectronicQueryCmd" global="true" method="queryArchiveCatalog" isGroup="true" groupField="taskCode" pageSize="500">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomElectronic"></model:record>
	</model:dataset>
	<%--电子档案上传窗口--%>
	<model:dataset id="winElectronicDataSet" cmd="com.inspur.cams.sorg.upload.cmd.SomElectronicQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomElectronic"></model:record>
	</model:dataset>
	<%--电子档案下载窗口--%>
	<model:dataset id="downloadDataSet" cmd="com.inspur.cams.sorg.upload.cmd.SomElectronicQueryCmd" method="queryElectronic">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomElectronic"></model:record>
	</model:dataset>
	<%--归档中关联人员（法定代表人、负责人）的电子档案上传窗口--%>
	<model:dataset id="dutyPeopleDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomDutyQueryCmd" method="queryPeople">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomDuty"></model:record>
	</model:dataset>
	<%--业务意见--%>
	<model:dataset id="somApplyDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomApplyQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomApply">
		</model:record>
	</model:dataset>
	<model:dataset id="cataLogCodeSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='SOM_CATALOG'></model:param>
			<model:param name="value" value='CATALOG_CODE'></model:param>
			<model:param name="text" value='CATALOG_NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 社会组织种类 -->
	<model:dataset id="sorgTypeSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_SORG_TYPE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 业务主管单位 -->
	<model:dataset id="businessOrganSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='SOM_BUSINESS_ORGAN'></model:param>
			<model:param name="value" value='BORG_CODE'></model:param>
			<model:param name="text" value='BORG_NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="comm_yesorno" enumName="COMM.YESORNO" autoLoad="true" global="true"></model:dataset>
</model:datasets>
<next:Panel width="100%" height="100%">
	<next:TabPanel>
		<next:Tabs>
			<next:Panel title="民办非企业单位档案管理" width="100%" height="100%" >
				<next:EditGridPanel id="uploadGrid" width="100%" stripeRows="true" height="100%" dataset="somElectronicDataSet">
					<next:GroupingView forceFit="true"></next:GroupingView>
					<next:TopBar>
						<next:ToolBarItem symbol="附件列表"></next:ToolBarItem>
						<next:ToolBarItem symbol="->"></next:ToolBarItem>
						<next:ToolBarItem iconCls="add" text="保存件号" handler="clickSavePieceNumber"></next:ToolBarItem>
						<next:ToolBarItem iconCls="add" text="增加上传附件" handler="clickUploadFile"></next:ToolBarItem>
					</next:TopBar>
				
					<next:Columns>
						<next:RowNumberColumn />
						<next:RadioBoxColumn></next:RadioBoxColumn>
						<next:Column header="档案目录名"  field="catalogCode" width="38%" editable="false" dataset="cataLogCodeSelect"><next:TextField /></next:Column>
						<next:Column header="件号"    field="pieceNumber" width="10%" editable="true"><next:TextField /></next:Column>
						<next:Column header="附件名称"    field="fileName" width="30%" editable="false"><next:TextField /></next:Column>
						<next:Column header="附件描述"    field="fileMess" width="20%" editable="false"><next:TextField /></next:Column>
						<next:Column header="下载附件"    field="" width="10%" editable="false" renderer="clickDownloadHrefForArchive"><next:TextField /></next:Column>
						<next:Column header="档案目录"    field="taskCode" hidden="true">
							<next:ExtendConfig>
								groupRenderer:grender
							</next:ExtendConfig>
						</next:Column>
						<next:Column header="业务类型"    field="applyType" hidden="true"></next:Column>
						<next:Column header="创建时间"    field="createTime" hidden="true"></next:Column>
					</next:Columns>
					<next:BottomBar>
						<next:PagingToolBar dataset="somElectronicDataSet"/>
					</next:BottomBar>
				</next:EditGridPanel>
			</next:Panel>
			<next:Panel title="民办非企业单位基本信息" width="100%" height="100%" autoScroll="true">
			<next:Html>
				<form method="post" onsubmit="return false" class="L5form" dataset="somOrganDataset">
					<table width="100%">
						<tr>
							<td class="FieldLabel"><label>社会组织名称：</label></td>
							<td class="FieldInput" colspan="3"><label field="cnName"  /></td>
							<td class="FieldLabel" style="width: 5%;"><label>登记证号：</label></td>
							<td class="FieldInput" style="width: 5%;"><label field="sorgCode"  /></td>
						</tr>
						<tr>
							<td class="FieldLabel" style="width:10%"><label>社会组织种类：</label></td>
							<td class="FieldInput" style="width:10%"><label field="sorgType" dataset="sorgTypeSelect"></label></td>
							<td class="FieldLabel"><label>是否为分支：</label></td>
							<td class="FieldInput"><label field="ifBranch" dataset="comm_yesorno"></label></td>
							<td class="FieldLabel" style="width: 5%;"><label>组织机构代码：</label></td>
							<td class="FieldInput" style="width: 5%;"><label field="organCode"  /></td>
						</tr>
						<tr>
							<td class="FieldLabel"><label>业务范围：</label></td>
							<td class="FieldInput" colspan="5"><textarea rows="5" field="business" name='"业务范围"' style="width:98%;background-color:#F5FAFA;border:0;overflow:auto;"  readonly></textarea></td>
						</tr>
						<tr>
							<td class="FieldLabel"><label>住所：</label></td>
							<td class="FieldInput" colspan="5"><label field="residence"  /></td>
						</tr>
						<tr>
							<td class="FieldLabel"><label>法定代表人：</label></td>
							<td class="FieldInput"><label field="legalPeople"  /></td>
							<td class="FieldLabel"><label>活动地域：</label></td>
							<td class="FieldInput"><label field="actArea"  /></td>
							<td class="FieldLabel"><label>注册资金(万元)：</label></td>
							<td class="FieldInput"><label field="regMon"  /></td>
						</tr>
						<tr>
							<td class="FieldLabel"><label>业务主管单位：</label></td>
							<td class="FieldInput" colspan="5"><label id="borgName"	field="borgName"  dataset='businessOrganSelect'/></td>
						</tr>
						<tr>
							<td class="FieldLabel" style="width:17%"><label>登记日期：</label></td>
							<td class="FieldInput" style="width:17%"><label id="regDate" field="regDate"  /></td>
							<td class="FieldLabel" style="width:17%"><label>有效期起：</label></td>
							<td class="FieldInput" style="width:17%"><label id="signBeginDate"  /></td>
							<td class="FieldLabel" style="width:17%"><label>有效期止：</label></td>
							<td class="FieldInput" style="width:17%"><label id="signEndDate"  /></td>
						</tr>
						<tr>
							<td class="FieldLabel"><label>发证机关：</label></td>
							<td class="FieldInput" colspan='3'><label field="morgName"  /></td>
							<td class="FieldLabel"><label>发证日期：</label></td>
							<td class="FieldInput"><label id="signDate"  /></td>
						</tr>
					</table>
					</form>
				</next:Html>
			</next:Panel>
		</next:Tabs>
	</next:TabPanel>
</next:Panel>
<jsp:include page="../../comm/upload/uploadWindow.jsp" flush="true"/>
</body>
</html>