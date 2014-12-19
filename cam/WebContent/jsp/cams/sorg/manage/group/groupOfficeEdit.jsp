<%@ page language="java" contentType="text/html;charset=utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="com.inspur.cams.comm.util.StrUtil"%>
<%@ page import="com.inspur.cams.sorg.util.SomIdHelp"%>
<html>
<head>
<title>社会团体办事机构备案</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="groupOfficeEdit.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams/sorgUpload.js")%>'></script>
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
	var applyType = "019";
	var taskCode = '<%=taskCode%>';//生成业务编号
	var searchCnName=decodeURIComponent('<%=request.getParameter("searchCnName")%>');
	var searchSorgCode='<%=request.getParameter("searchSorgCode")%>';
</script>
</head>
<body>
<model:datasets>
	<model:dataset id="somOfficeDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomOfficeQueryCmd">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomOffice">
			<model:field name="name" type="string" rule="length{100}"/>
			<model:field name="place" type="string" rule="length{100}"/>
			<model:field name="officeChief" type="string" rule="length{72}"/>
			<model:field name="dutiesDesc" type="string" rule="length{500}"/>
 			<model:field name="reason" type="string" rule="length{500}"/>
			<model:field name="process" type="string" rule="length{500}"/>
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

<next:Panel  width="100%" autoScroll="true">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="save" text="保存" handler="save"></next:ToolBarItem>
		<next:ToolBarItem iconCls="return" text="返回" handler="returnBack"></next:ToolBarItem>
	</next:TopBar>
	<next:TabPanel width="100%" height="100%" id="tab">
		<next:Tabs>
			<next:Panel title="社会团体办事机构备案" width="100%" >
				<next:Panel width="100%" height="100%" autoScroll="true">
					<next:Html>
						<form id="officeForm" method="post" dataset="somOfficeDataSet" onsubmit="return false" class="L5form">
							<fieldset>
							<legend>社会团体办事机构备案</legend>
							<input type="hidden" id="sorgId" field="sorgId" value="社团ID">
							<table width="100%">
								<tr>
									<td class="FieldLabel">社团名称：</td>
									<td class="FieldInput" colspan="3"><label id="cnName"/></td>
									<td class="FieldLabel">登记证号：</td>
									<td class="FieldInput"><label id="sorgCode"/></td>
								</tr>
								<tr>
									<td class="FieldLabel">办事机构名称：</td>
									<td class="FieldInput"><input type="text" name="办事机构名称" id="name" field="name" maxlength="100" style="width:90%"/></td>
									<td class="FieldLabel">场所：</td>
									<td class="FieldInput" colspan="3"><input type="text" name="场所" id="place" field="place" maxlength="100" style="width:90%"/></td>
								</tr>
								<tr>
									<td class="FieldLabel" style="width:17%">电话：</td>
									<td class="FieldInput" style="width:17%"><input type="text" name="phone" id="phone" field="phone" style="width:90%"/></td>
									<td class="FieldLabel" style="width:17%">邮编：</td>
									<td class="FieldInput" style="width:15%"><input type="text" name="postCode" id="postCode" field="postCode" style="width:90%"/></td>
									<td class="FieldLabel" style="width:17%">机构负责人：</td>
									<td class="FieldInput" style="width:17%"><input type="text" name="机构负责人" id="officeChief" field="officeChief" maxlength="72" style="width:90%"/></td>
								</tr>
								<tr>
									<td class="FieldLabel">工作职责：</td>
									<td class="FieldInput" colspan="5"><textarea type="text" name="工作职责" id="dutiesDesc" field="dutiesDesc" cols="75" rows="5" style="width:97%"></textarea></td>
								</tr>
								<tr>
									<td class="FieldLabel">设立理由：</td>
									<td class="FieldInput" colspan="5"><textarea type="text" name="设立理由" id="reason" field="reason" cols="75" rows="4" style="width:97%"></textarea></td>
								</tr>
								<tr>
									<td class="FieldLabel">社团履行内部程序：</td>
									<td class="FieldInput" colspan="5"><textarea type="text" name="社团履行内部程序" id="process" field="process" cols="75" rows="2" style="width:97%"></textarea></td>
								</tr>
								<tr>
									<td class="FieldLabel">备案承办人：</td>
									<td class="FieldInput"><input type="text" name="备案承办人" id="regPeople" field="regPeople" maxlength="30" style="width:90%"/></td>
									<td class="FieldLabel">备案日期：</td>
									<td class="FieldInput"><input type="text" name="备案日期" id="regDate" field="regDate" format="Y-m-d" onclick="WdatePicker();" style="width:100%"/></td>
									<td class="FieldLabel"></td>
									<td class="FieldInput"></td>
								</tr>
								<tr>
									<td  class="FieldInput" colspan="6"><font color="red">
									说明：<br/>
										&nbsp;&nbsp;&nbsp;&nbsp;1)工作职责的内容，必须在500字符之内！<br/>
										&nbsp;&nbsp;&nbsp;&nbsp;2)设立理由的内容，必须在500字符之内！<br/>
										&nbsp;&nbsp;&nbsp;&nbsp;3)社团履行内部程序的内容，必须在500字符之内！
									</font></td>
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