<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="com.inspur.cams.sorg.util.SomIdHelp"%>
<%@ page import="org.loushang.bsp.security.context.GetBspInfo"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="com.inspur.cams.comm.util.BspUtil"%>
<%@page import="com.inspur.cams.sorg.util.ApplyType"%>
<html>
<head>
<title>社会团体分支/代表机构注销登记录入</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="groupBranchCancelPre.js"></script>
<script type="text/javascript" src="<%=SkinUtils.getJS(request,"bpm/bpm.js")%>"></script>
<script type="text/javascript" src="<%=SkinUtils.getJS(request,"cams.js") %>"></script>
<script type="text/javascript" src="<%=SkinUtils.getJS(request,"camsCheck.js") %>"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams/sorgUpload.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"My97DatePicker/WdatePicker.js") %>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams/sorgOnline.js")%>'></script>
<script type="text/javascript">
	<%
		String applyType=ApplyType.SOM_GROUP_BRANCH_CANCEL;
	%>
	var taskCode='<%=request.getParameter("taskCode")%>'
	var applyType='<%=applyType%>';//业务类型
	var sorgId="";
	var mainSorgId="";
	var rootPath="<%=SkinUtils.getRootUrl(request)%>";
	var currentUserName = '<%= GetBspInfo.getBspInfo().getUserName()%>';
	var morgArea='<%=BspUtil.getOrganCode()%>';
</script>
</head>
<body>

<model:datasets>
	<!-- 退回所用dataset -->
	<model:dataset id="undoDataSet" cmd="com.inspur.cams.sorg.online.base.cmd.SomApplyOnlineQueryCommand" method="queryHasAcceptStatus"  global="true" sortField="createTime" sortDirection="DESC">
		<model:record fromBean="com.inspur.cams.sorg.online.base.data.SomApplyOnline"></model:record>
	</model:dataset>
	<!-- 更改业务状态所用dataset -->
	<model:dataset id="updateStatusDataSet" cmd="com.inspur.cams.sorg.online.base.cmd.SomApplyOnlineQueryCommand"  global="true" sortField="createTime" sortDirection="DESC">
		<model:record fromBean="com.inspur.cams.sorg.online.base.data.SomApplyOnline"></model:record>
	</model:dataset>
	<model:dataset id="somApplyDataSet" cmd="com.inspur.cams.sorg.online.base.cmd.SomApplyOnlineQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomApply">	
			<model:field name="process" type="string" rule="require|length{300}"/>		
			<model:field name="curOpinionId" type="string" rule="require"/>
			<model:field name="curOpinion" type="string" rule="length{200}"/>
		</model:record>
	</model:dataset>
	<model:dataset id="somOrganDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomOrganQueryCmd" method="queryBranch" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomOrgan">
			<model:field name="sorgCode" type="string" rule="require"/>
			<model:field name="cancelDate" type="string" rule="require"/>
			<model:field name="cancelReasonDesc" type="string" rule="require|length{500}"/>
		</model:record>
	</model:dataset>
	<model:dataset id="somOrganQueryDataSet" cmd="com.inspur.cams.sorg.online.base.cmd.SomOrganOnlineQueryCommand" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomOrgan">
		</model:record>
	</model:dataset>
	<model:dataset id="somElectronicDataSet" cmd="com.inspur.cams.sorg.upload.cmd.SomElectronicQueryCmd" method="queryCatalog" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomElectronic"></model:record>
	</model:dataset>
	<model:dataset id="winElectronicDataSet" cmd="com.inspur.cams.sorg.upload.cmd.SomElectronicQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomElectronic">
			<model:field name="fileName" type="string" rule="require|length{500}"/>
			<model:field name="fileMess" type="string" rule="require|length{100}"/>
		</model:record>
	</model:dataset>
	<model:dataset id="winElectronicDataSet2" cmd="com.inspur.cams.sorg.upload.cmd.SomElectronicQueryCmd" method="queryCatalog" global="true">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomElectronic">
			<model:field name="fileMess" type="string" rule="require|length{500}"/>
			<model:field name="files" type="string" rule="require"/>				
		</model:record>
	</model:dataset>	
	<model:dataset id="sorgKindSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value="DIC_GROUP_KIND"></model:param>
			<model:param name="value" value="CODE"></model:param>
			<model:param name="text" value="NAME"></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="businessOrganSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
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
			<model:param name="dic" value="SOM_CATALOG"></model:param>
			<model:param name="value" value="CATALOG_CODE"></model:param>
			<model:param name="text" value="CATALOG_NAME"></model:param>
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
	<model:dataset id="opinionSelect" enumName="WORKFLOW.OPINION" autoLoad="true" global="true"></model:dataset>
	<model:dataset id="hisOpinionDataSet" enumName="WORKFLOW.OPINION" autoLoad="true" global="true"></model:dataset>
</model:datasets>

<next:ViewPort>
	<next:Panel width="100%" height="100%">
		<next:TopBar>
			<next:ToolBarItem symbol="社会团体分支（代表）机构注销登记"></next:ToolBarItem>
			<next:ToolBarItem symbol="->"></next:ToolBarItem>
			<next:ToolBarItem iconCls="undo" text="退回" handler="updateOnlineStatusAndSeason"></next:ToolBarItem>
			<next:ToolBarItem iconCls="print" text="打印受理通知书" handler="printAccept"></next:ToolBarItem>
			<next:ToolBarItem iconCls="print" text="打印不予受理通知书" handler="printNoAccept"></next:ToolBarItem>
			<next:ToolBarItem iconCls="save" text="保存" handler="save" />	
			<next:ToolBarItem iconCls="select" text="提交" handler="submit" />
			<next:ToolBarItem iconCls="return" text="返回" handler="goBack"></next:ToolBarItem>
		</next:TopBar>
		<next:TabPanel id="tabSomOrgan" width="100%" height="100%">	
			<next:Tabs>
				<next:Panel id="panelSomOrgan" title="社会团体分支（代表）机构注销登记表" width="100%" height="100%" autoScroll="true">
					<next:Html>
						<fieldset>	
						<form id="cbForm" method="post" dataset="somOrganDataSet" onsubmit="return false" class="L5form">
						<table width="100%">
							<tr>
								<td class="FieldLabel" width="20%"><label>分支/代表机构登记证号：</label></td>
								<td class="FieldInput" width="30%"><input id="sorgCode" field="sorgCode" name='"分支/代表机构登记证号"' onblur="checkSorgCode()" style="width:80%"/><span style="color:red">*</span></td>
								<td class="FieldLabel" width="20%"><label>分支负责人：</label></td>
								<td class="FieldInput" width="30%"><label id="branchCharger" field="branchCharger" name='"分支负责人"' /></td>
							</tr>
							<tr>
								<td class="FieldLabel"><label>分支/代表机构名称：</label></td>
								<td class="FieldInput"><label field="cnName" name='"分支/代表机构名称"'/></td>
								<td class="FieldLabel"><label>成立日期：</label></td>
								<td class="FieldInput"><label field="buildDate" name='"成立日期"'/></td>
							</tr>
							<tr>
								<td class="FieldLabel"><label>社会团体名称：</label></td>
								<td class="FieldInput"><label id='name'field="name" name='"社团名称"'/></td>
								<td class="FieldLabel"><label>社会团体登记证号：</label></td>
								<td class="FieldInput"><label field="mainSorgCode" name='"登记证号"'/></td>
							</tr>							
							<tr>							
								<td class="FieldLabel"><label>住所：</label></td>
								<td class="FieldInput"><label field="residence" name='"住所"'/></td>
								<td class="FieldLabel"><label>社团电话：</label></td>
								<td class="FieldInput"><label field="sorgPhone" name='"社团电话"'/></td>
							</tr>
							<tr>
								<td class="FieldLabel"><label>注销日期：</label></td>
								<td class="FieldInput"><input id="cancelDate" field="cancelDate" name='"注销日期"' onclick="WdatePicker()" style="width:80%"/><span style="color:red">*</span></td>
								<td class="FieldLabel"><label>业务主管单位：</label></td>
								<td class="FieldInput">
									<select id="borgName" field="borgName" name='"业务主管单位"' style="width:80%" disabled="disabled">
										<option dataset="businessOrganSelect" ></option>
									</select>	
								</td>
							</tr>
							<tr>
								<td class="FieldLabel"><label>注销社团原因：</label></td>
								<td class="FieldInput" >
									<select id="cancelReason" field="cancelReason" name='"注销原因"' onblur="loadCancelReasonDesc()" >
										<option dataset="cancelReasonSelect"></option>
									</select><span style="color:red">*</span>
								</td>
								<td class="FieldLabel"><label>社会团体类别：</label></td>
								<td class="FieldInput">
									<select id="sorgKind" field="sorgKind" name='"社团类别"' style="width:80%" disabled="disabled">
										<option dataset="sorgKindSelect" ></option>
									</select>
								</td>
							</tr>
							<tr id="cancelReasonDescTr" style="display:none">
								<td class="FieldLabel"><label>注销原因说明：</label></td>
								<td class="FieldInput" colspan="3"><textarea rows="3" id="cancelReasonDesc" field="cancelReasonDesc" name='"注销原因说明"' style="width:93%"></textarea><span style="color:red">*</span></td>
							</tr>
						</table>
						</form>
						</fieldset>	
						<fieldset>
							<legend>社团内部履行程序</legend>
							<form method="post" dataset="somApplyDataSet" onsubmit="return false" class="L5form" >
							<table width="100%">
								<tr>
									<td class="FieldLabel" width="20%"><label>社团内部履行程序：</label></td>
									<td class="FieldInput" colspan="3"><textarea rows="3" id="process" field="process" name='"社团内部履行程序"' style="width:93%"></textarea></td>
								</tr>
							</table>
							</form>
						</fieldset>		
					</next:Html>
				</next:Panel>
	
				<next:EditGridPanel id="uploadGrid" dataset="somElectronicDataSet" title="法律要件" width="100%" height="100%">
					<next:TopBar>
						<next:ToolBarItem symbol="附件列表"></next:ToolBarItem>
						<next:ToolBarItem symbol="->"></next:ToolBarItem>
						<next:ToolBarItem iconCls="upload" text="增加上传附件" handler="uploadFile"></next:ToolBarItem>
					</next:TopBar>
					<next:Columns>
						<next:RowNumberColumn />
						<next:RadioBoxColumn></next:RadioBoxColumn>
						<next:Column header="档案目录名" field="catalogCode" width="38%" editable="false" dataset="cataLogCodeSelect"></next:Column>
						<next:Column header="附件名称" field="fileName" width="30%" editable="false"></next:Column>
						<next:Column header="附件描述" field="fileMess" width="20%" editable="false"></next:Column>
						<next:Column header="下载附件"    field="" width="10%" editable="false" renderer="clickDownloadHref"><next:TextField /></next:Column>
					</next:Columns>
					<next:BottomBar>
						<next:PagingToolBar dataset="somElectronicDataSet" />
					</next:BottomBar>
				</next:EditGridPanel>
	
				<next:Panel title="处理意见" width="100%" height="100%">
					<next:Html>
						<form method="post" dataset="somApplyDataSet" onsubmit="return false" class="L5form">						
							<table width="100%">
								<tr>
									<td class="FieldLabel" width="15%"><label>处理意见：</label></td>
									<td class="FieldInput" width="85%">
										<select field="curOpinionId" name='"处理意见"'>
											<option dataset="opinionSelect"></option>
										</select><span style="color:red">*</span>
									</td>									
								</tr>
								<tr>
									<td class="FieldLabel"><label>处理补充意见：</label></td>
									<td class="FieldInput">
										<textarea rows="8" field="curOpinion" name='"处理补充意见"' style="width:90%"></textarea>
									</td>
								</tr>
							</table>
						</form>					
					</next:Html>
				</next:Panel>			
			</next:Tabs>
		</next:TabPanel>
	</next:Panel>
</next:ViewPort>
<next:Window id="undoWin" closeAction="hide" title="回退原因窗口" width="500"  autoScroll="true" modal="true">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="save" text="确定" handler="confirmUndo"></next:ToolBarItem>
		<next:ToolBarItem iconCls="return" text="关闭" handler="closeUndo"></next:ToolBarItem>		
	</next:TopBar>
	<next:Html>
		<form method="post"  onsubmit="return false" class="L5form" >
			<table width="100%">
				<tr>
					<td class="FieldLabel" style="width: 20%">回退原因：</td>
					<td class="FieldInput" style="width: 80%"><textarea id="undoSeason" rows="3" style="width: 98%" name='回退原因' ></textarea></td>
				</tr>
			</table>
		</form>
	</next:Html>
</next:Window>
<jsp:include page="../../../../comm/upload/uploadWindow.jsp" flush="true"/>
</body>
</html>