<%@ page language="java" contentType="text/html;charset=utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@page import="org.loushang.next.skin.SkinUtils"%>
<html>
<head>
<title>社会团体办事机构备案</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="groupOfficeEdit.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js") %>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams/sorgUpload.js")%>'></script>
<script type="text/javascript">
	var method='<%=request.getParameter("method")%>';
	var sorgId = '<%=request.getParameter("sorgId")%>';
	var cnName=decodeURIComponent('<%=request.getParameter("cnName")%>');
	var sorgCode='<%=request.getParameter("sorgCode")%>';
	var id='<%=request.getParameter("id")%>';
	var applyType = "019";
	var taskCode='<%=request.getParameter("taskCode")%>';
	var searchCnName=decodeURIComponent('<%=request.getParameter("searchCnName")%>');
	var searchSorgCode='<%=request.getParameter("searchSorgCode")%>';	
</script>
</head>
<body>
<model:datasets>
	<model:dataset id="somOfficeDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomOfficeQueryCmd">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomOffice"/>
	</model:dataset>
	<%--电子档案--%>
	<model:dataset id="somElectronicDataSet" cmd="com.inspur.cams.sorg.upload.cmd.SomElectronicQueryCmd" global="true" method="queryCatalog">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomElectronic"></model:record>
	</model:dataset>
	<%--下载窗口--%>
	<model:dataset id="downloadDataSet" cmd="com.inspur.cams.sorg.upload.cmd.SomElectronicQueryCmd" method="queryElectronic">
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
</model:datasets>

<next:Panel width="100%" autoScroll="true">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="return" text="返回" handler="returnBackHistory"></next:ToolBarItem>
	</next:TopBar>
	<next:TabPanel width="100%" height="100%" id="tab">
		<next:Tabs>
			<next:Panel title="社会团体办事机构备案" width="100%" >
				<next:Panel width="100%" height="100%" autoScroll="true">
					<next:Html>
						<form id="officeForm" method="post" dataset="somOfficeDataSet" onsubmit="return false" class="L5form">
							<fieldset>
							<legend>社会团体办事机构备案</legend>
							<input type="hidden" field="id" name="办事机构ID"/>
							<input type="hidden" id="sorgId" field="sorgId" name="sorgId" />
							<input type="hidden" id="sorgType" field="sorgType" name="社会组织类型"/>
							<table width="100%">
								<tr>
									<td class="FieldLabel">社团名称：</td>
									<td class="FieldInput" colspan="3"><label id="cnName"/></td>
									<td class="FieldLabel">登记证号：</td>
									<td class="FieldInput"><label id="sorgCode"/></td>
								</tr>
								<tr>
									<td class="FieldLabel">办事机构名称：</td>
									<td class="FieldInput"><label field="name"/></td>
									<td class="FieldLabel">场所：</td>
									<td class="FieldInput" colspan="3"><label field="place"/></td>
								</tr>
								<tr>
									<td class="FieldLabel" style="width:17%">电话：</td>
									<td class="FieldInput" style="width:17%"><label field="phone"/></td>
									<td class="FieldLabel" style="width:17%">邮编：</td>
									<td class="FieldInput" style="width:15%"><label field="postCode"/></td>
									<td class="FieldLabel" style="width:17%">机构负责人：</td>
									<td class="FieldInput" style="width:17%"><label field="officeChief"/></td>
								</tr>
								<tr>
									<td class="FieldLabel">工作职责：</td>
									<td class="FieldInput" colspan="5"><textArea name="dutiesDesc" id="dutiesDesc" field="dutiesDesc" cols="65" rows="6" readonly="readonly" style="width:95%"></textArea></td>
								</tr>
								<tr>
									<td class="FieldLabel">设立理由：</td>
									<td class="FieldInput" colspan="5"><textArea name="reason" id="reason" field="reason" cols="65" rows="5" readonly="readonly" style="width:95%"></textArea></td>
								</tr>
								<tr>
									<td class="FieldLabel">社团履行内部程序：</td>
									<td class="FieldInput" colspan="5"><textArea name="process" id="process" field="process" cols="65" rows="3" readonly="readonly" style="width:95%"></textArea></td>
								</tr>
								<tr>
									<td class="FieldLabel">备案承办人：</td>
									<td class="FieldInput" colspan="3"><label field="regPeople"/></td>
									<td class="FieldLabel">备案日期：</td>
									<td class="FieldInput"><label field="regDate"/></td>
								</tr>
								<tr>
									<td class="FieldLabel">登记管理机关名称：</td>
									<td class="FieldInput" colspan="3"><label field="morgName"/></td>
									<td class="FieldLabel">登记管理机关行政区划：</td>
									<td class="FieldInput"><label field="morgArea"/></td>
								</tr>
							</table>
							</fieldset>
						</form>
					</next:Html>
				</next:Panel>
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
<jsp:include page="../../comm/upload/uploadWindow.jsp" flush="true"/>
</body>
</html>