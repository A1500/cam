<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils" %>
<html>
<head>
<title>党建撤销备案</title>
<next:ScriptManager />
<script type="text/javascript" src="somPartyCancel.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js") %>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js") %>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams/sorgUpload.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"My97DatePicker/WdatePicker.js") %>'></script>
<script type="text/javascript">
var partyId='<%=request.getParameter("partyId")%>';
var searchSorgName=decodeURIComponent('<%=request.getParameter("searchSorgName")%>');
var searchSorgCode=decodeURIComponent('<%=request.getParameter("searchSorgCode")%>');
var searchSorgType=decodeURIComponent('<%=request.getParameter("searchSorgType")%>');
var sorgId='';
var applyType="402";
var taskCode='';
</script>
</head>
<body>
<model:datasets>
	<model:dataset id="somPartyDS"  cmd="com.inspur.cams.sorg.manage.cmd.SomPartyQueryCmd" >
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomParty">
		</model:record>
	</model:dataset>
	<model:dataset id="organDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomOrganQueryCmd" method="queryOrgan"  >
      <model:record fromBean="com.inspur.cams.sorg.base.data.SomOrgan">
      		<model:field name="cancelReason" type="string" rule="length{500}"/>
      </model:record>
	</model:dataset>
	<model:dataset id="somElectronicDataSet" cmd="com.inspur.cams.sorg.upload.cmd.SomElectronicQueryCmd" global="true" method="queryCatalog">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomElectronic"></model:record>
	</model:dataset>
	<model:dataset id="sorgTypeDS" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_SORG_TYPE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="build_type" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_PARTY_BUILD_TYPE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
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
</model:datasets>
<next:Panel width="100%" height="100%" >
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="save" text="保存"  handler="saveParty"></next:ToolBarItem>
		<next:ToolBarItem iconCls="return" text="返回" handler="returnList"></next:ToolBarItem>
	</next:TopBar>
	<next:TabPanel id="tabParty">
		<next:Tabs>
			<next:Panel height='100%' autoScroll="true" title='基本信息'>
				<next:Html>
					<form id="somPartyBuildForm" method="post" onsubmit="return false" dataset="somPartyDS" class="L5form" >
					<fieldset>
					<legend>党建撤销备案</legend>
					<table width="100%">
							<input type="hidden" id="partyId" field="partyId"  value="党建ID">
						<tr>
							<td class="FieldLabel"><label>社会组织名称:</label></td>
							<td class="FieldInput" colspan="5"><label  id="sorgName" field="sorgName"></label></td>
						</tr>
						<tr>
							<td class="FieldLabel" width="14%"><label>社会组织类型:</label></td>
							<td class="FieldInput" width="19%"><select   id="sorgType" field="sorgType" style="width: 95%" disabled="disabled"><option dataset="sorgTypeDS" ></option></select></td>
							<td class="FieldLabel" width="14%"><label>党组织类别:</label></td>
							<td class="FieldInput" width="19%"><label name="党组织类别" id="buildType" field="buildType" dataset="build_type"></label></td>
							<td class="FieldLabel" width="14%"><label>撤销党组织日期:</label></td>
							<td class="FieldInput" width="19%"><input type="text" name='撤销党组织日期' id="cancelDate" format="Y-m-d"  field="cancelDate" onclick="WdatePicker();" style="width: 95%"/></td>
						</tr>
						<tr>
							<td class="FieldLabel"><label>撤销文件编号:</label></td>
							<td class="FieldInput"><input name='撤销文件编号' field='cancelFileNo' style="width: 95%"/></td>
							<td class="FieldLabel"><label>撤销审批党组织名称:</label></td>
							<td class="FieldInput"><input name='撤销审批党组织名称' field='cancelAuditParty' style="width: 95%"/></td>
							<td class="FieldLabel"></td>
							<td class="FieldInput"></td>
						</tr>
						<tr>
							<td class="FieldLabel"><label>撤销理由:</label></td>
							<td class="FieldInput" colspan="5"><textArea  name="撤销理由:" id="cancelReason" field="cancelReason" cols="75" rows="15" style="width:99%"></textArea></td>
						</tr>
					</table>
					</fieldset>
					</form>
				</next:Html>
			</next:Panel>
			<next:EditGridPanel title="法律要件" id="uploadGrid" dataset="somElectronicDataSet" width="100%" stripeRows="true" height="100%">
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
		</next:Tabs>
	</next:TabPanel>
</next:Panel>
<jsp:include page="../../comm/upload/uploadWindow.jsp" flush="true"/>
</body>
</html>