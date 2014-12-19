<%@ page language="java" contentType="text/html;charset=utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<%@ page import="com.inspur.cams.comm.util.StrUtil"%>
<%@ page import="com.inspur.cams.sorg.util.SomIdHelp"%>
<html>
<head>
<title>基金会举办实体备案</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="fundEntityEdit.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams/sorgUpload.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"My97DatePicker/WdatePicker.js") %>'></script>
<%
	String taskCode = request.getParameter("taskCode");
	if (taskCode == null || "".equals(taskCode)) {
		taskCode = StrUtil.n2b(SomIdHelp.getFundTaskCode());
	}
%>
<script type="text/javascript">
	var method='<%=request.getParameter("method")%>';
	var sorgId='<%=request.getParameter("sorgId")%>';
	var cnName=decodeURIComponent('<%=request.getParameter("cnName")%>');
	var sorgCode='<%=request.getParameter("sorgCode")%>';
	var id='<%=request.getParameter("id")%>';
	var applyType='225';
	var taskCode = '<%=taskCode%>';//生成业务编号
	var searchCnName=decodeURIComponent('<%=request.getParameter("searchCnName")%>');
	var searchSorgCode='<%=request.getParameter("searchSorgCode")%>';
</script>
</head>
<body>
<model:datasets>
	<model:dataset id="somEntityDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomEntityQueryCmd">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomEntity">
			<model:field name="name" type="string" rule="length{100}"/>
			<model:field name="adds" type="string" rule="length{100}"/>
			<model:field name="recordFile" type="string" rule="length{500}"/>
			<model:field name="note" type="string" rule="length{200}"/>
			<model:field name="registCardCode" type="string" rule="length{30}"/>
			<model:field name="registOrgan" type="string" rule="length{100}"/>
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

<next:Panel width="100%" autoScroll="true">
	<next:TopBar>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="save" text="保存" handler="save"></next:ToolBarItem>
		<next:ToolBarItem iconCls="return" text="返回" handler="returnBack"></next:ToolBarItem>
	</next:TopBar>
	<next:TabPanel width="100%" height="100%" id="tab">
		<next:Tabs>
			<next:Panel title="基金会举办实体备案" width="100%" >
				<next:Panel width="100%" height="100%" autoScroll="true">
					<next:Html>
						<form id="entityForm" method="post" dataset="somEntityDataSet" onsubmit="return false" class="L5form">
						<fieldset>
						<legend>基金会举办实体备案</legend>
						<input type="hidden" id="sorgId" field="sorgId" value="基金会ID">
						<table width="100%">
							<tr>
								<td class="FieldLabel" style="width:18%">基金会名称：</td>
								<td class="FieldInput" style="width:36%"><label id="cnName"/></td>
								<td class="FieldLabel" style="width:16%">登记证号：</td>
								<td class="FieldInput" style="width:30%"><label id="sorgCode"/></td>
							</tr>
							<tr>
								<td class="FieldLabel">实体名称：</td>
								<td class="FieldInput" colspan="3"><input type="text" name="实体名称" id="name" field="name" maxlength="100" style="width:90%"/></td>
							</tr>
							<tr>
								<td class="FieldLabel">地 址：</td>
								<td class="FieldInput" colspan="3"><input type="text" name="地 址" id="adds" field="adds" maxlength="100" style="width:90%"/></td>
							</tr>
							<tr>
								<td class="FieldLabel">注册（或批准）日期：</td>
								<td class="FieldInput"><input type="text" name="registDate" id="registDate" field="registDate" format="Y-m-d" onclick="WdatePicker();" style="width:90%"/></td>
								<td class="FieldLabel">注册（或批准）证种类：</td>
								<td class="FieldInput">
									<input type="text" field="registCardType" name='"注册（或批准）证种类"' style="width:90%"/>
								</td>
							</tr>
							<tr>
								<td class="FieldLabel">注册（或批准）证号码：</td>
								<td class="FieldInput"><input type="text" name="注册（或批准）证号码" id="registCardCode" field="registCardCode" maxlength="30" style="width:90%"/></td>
								<td class="FieldLabel">注册（或批准）机关：</td>
								<td class="FieldInput"><input type="text" name="注册（或批准）机关" id="registOrgan" field="registOrgan" maxlength="50" style="width:90%"/></td>
							</tr>
							<tr>
								<td class="FieldLabel">备案的主要文件：</td>
								<td class="FieldInput" colspan="3"><textarea name="备案的主要文件" id="recordFile" field="recordFile" cols="75" rows="5" style="width:97%"></textarea>
							</tr>
							<tr>
								<td class="FieldLabel">备注：</td>
								<td class="FieldInput" colspan="3"><textarea name="备注" id="note" field="note" cols="75" rows="3" style="width:97%"></textarea>
							</tr>
							<tr>
								<td class="FieldLabel">备案承办人：</td>
								<td class="FieldInput"><input type="text" name="备案承办人" id="regPeople" field="regPeople" maxlength="30" style="width:90%"/></td>
								<td class="FieldLabel">备案日期：</td>
								<td class="FieldInput"><input type="text" name="备案日期" id="regDate" field="regDate" format="Y-m-d" onclick="WdatePicker();" style="width:90%"/></td>
							</tr>
							<tr>
								<td class="FieldInput" colspan="4">
									<font color="red">
										说明：<br/>
										&nbsp;&nbsp;&nbsp;&nbsp;1）备案的主要文件内容，必须在500字符之内。<br/>
										&nbsp;&nbsp;&nbsp;&nbsp;2)备注的内容，必须在200字符之内。
									</font>
								</td>
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