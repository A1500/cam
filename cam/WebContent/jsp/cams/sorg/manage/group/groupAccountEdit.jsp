<%@ page language="java" contentType="text/html;charset=utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="com.inspur.cams.comm.util.StrUtil"%>
<%@ page import="com.inspur.cams.sorg.util.SomIdHelp"%>
<html>
<head>
<title>社会团体账户备案</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="groupAccountEdit.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams/sorgUpload.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"My97DatePicker/WdatePicker.js") %>'></script>
<%
	String taskCode = request.getParameter("taskCode");
	if (taskCode == null || "".equals(taskCode)) {
		taskCode = StrUtil.n2b(SomIdHelp.getGroupTaskCode());
	}
%>
<script type="text/javascript">
	var method='<%=request.getParameter("method")%>';
	var sorgId='<%=request.getParameter("sorgId")%>';
	var cnName=decodeURIComponent('<%=request.getParameter("cnName")%>');
	var sorgCode='<%=request.getParameter("sorgCode")%>';
	var id='<%=request.getParameter("id")%>';
	var applyType = "015";
	var taskCode = '<%=taskCode%>';//生成业务编号
	var searchCnName=decodeURIComponent('<%=request.getParameter("searchCnName")%>');
	var searchSorgCode='<%=request.getParameter("searchSorgCode")%>';
</script>
</head>
<body>
<model:datasets>
	<model:dataset id="somAccountDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomAccountQueryCmd">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomAccount"/>
	</model:dataset>
	<model:dataset id="organDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomOrganQueryCmd">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomOrgan"></model:record>
	</model:dataset>
	<%--电子档案--%>
	<model:dataset id="somElectronicDataSet" cmd="com.inspur.cams.sorg.upload.cmd.SomElectronicQueryCmd" global="true" method="queryCatalog">
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
		<next:ToolBarItem iconCls="save" text="保存" handler="save"></next:ToolBarItem>
		<next:ToolBarItem iconCls="return" text="返回" handler="returnBack"></next:ToolBarItem>
	</next:TopBar>
	<next:TabPanel width="100%" height="100%" id="tab">
		<next:Tabs>
			<next:Panel title="社会团体帐户备案" width="100%" >
				<next:Panel width="100%" height="100%" autoScroll="true">
					<next:Html>
						<form id="accountForm" method="post" dataset="somAccountDataSet" onsubmit="return false" class="L5form">
							<input type="hidden" id="sorgId" field="sorgId" value="社团ID">
							<fieldset>
								<legend>社会团体帐户备案</legend>
								<table width="100%">
									<tr>
										<td class="FieldLabel" style="width:18%">社团名称：</td>
										<td class="FieldInput" style="width:36%"><label id="cnName"/></td>
										<td class="FieldLabel" style="width:16%">登记证号：</td>
										<td class="FieldInput" style="width:30%"><label id="sorgCode"/></td>
									</tr>
									<tr>
										<td class="FieldLabel">账户名称：</td>
										<td class="FieldInput"><input type="text" name="name" id="name" field="name" maxlength="50" style="width:90%"/></td>
										<td class="FieldLabel">开户银行：</td>
										<td class="FieldInput"><input type="text" name="bank" id="bank" field="bank" maxlength="50" style="width:100%"/></td>
									</tr>
									<tr>
										<td class="FieldLabel">开户银行地址：</td>
										<td class="FieldInput" colspan="3"><input type="text" name="开户银行地址" id="bankAdds" field="bankAdds" maxlength="100" style="width:100%"/></td>
									</tr>
									<tr>
										<td class="FieldLabel">账号：</td>
										<td class="FieldInput"><input type="text" name="银行账号" id="accountCode" field="accountCode" maxlength="30" style="width:90%"/><font color="red">*</font></td>
										<td class="FieldLabel">开户时间：</td>
										<td class="FieldInput"><input type="text" name="accountDate" id="accountDate" field="accountDate" format="Y-m-d" onclick="WdatePicker();" style="width:100%"/></td>
									</tr>
									<tr>
										<td class="FieldLabel">设立银行账号理由：</td>
										<td class="FieldInput" colspan="3"><textarea name="设立银行账号理由" id="reason" field="reason" cols="75" rows="15" style="width:95%"></textarea></td>
									</tr>
									<tr>
										<td class="FieldLabel">备案承办人：</td>
										<td class="FieldInput"><input type="text" name="备案承办人" id="regPeople" field="regPeople" maxlength="30" style="width:90%"/></td>
										<td class="FieldLabel">备案日期：</td>
										<td class="FieldInput"><input type="text" name="备案日期" id="regDate" field="regDate" format="Y-m-d" onclick="WdatePicker();" style="width:100%"/></td>
									</tr>
									<tr>
										<td class="FieldInput" colspan="4"><font color="red">说明：设立银行账号理由的内容，必须在500字符之内！</font></td>
									</tr>
								</table>
							</fieldset>
						</form>
					</next:Html>
				</next:Panel>
			</next:Panel>
			<next:Panel title="法律要件" >
				<next:EditGridPanel id="uploadGrid" width="100%" stripeRows="true" height="100%" dataset="somElectronicDataSet">
					<next:TopBar>
						<next:ToolBarItem symbol="附件列表"></next:ToolBarItem>
						<next:ToolBarItem symbol="->"></next:ToolBarItem>
						<next:ToolBarItem iconCls="add" text="增加上传附件" handler="clickUploadFile"></next:ToolBarItem>
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