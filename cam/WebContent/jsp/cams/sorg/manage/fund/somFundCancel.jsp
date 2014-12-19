<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="com.inspur.cams.comm.util.StrUtil,org.loushang.next.skin.SkinUtils"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<title>基金会注销登记</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="somFundCancel.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js") %>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"My97DatePicker/WdatePicker.js") %>'></script>
<script type="text/javascript">
	var sorgId = '<%=StrUtil.n2b(request.getParameter("sorgId"))%>';
</script>
</head>
<body>

<%--定义dataset--%>
<model:datasets>
	<%--基本信息--%>
	<model:dataset id="somOrganDataSet" cmd="com.inspur.cams.sorg.manage.cmd.SomFundOrganQueryCmd" method="queryMain">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomOrgan">
			<model:field name="cancelDate" type="string" rule="require" />
			<model:field name="cancelReason" type="string" rule="require|length{500}" />
			<model:field name="liqResult" type="string" rule="require|length{200}" />
		</model:record>
	</model:dataset>
	<%--清算组织人员信息--%>
	<model:dataset id="somLiqpeopleDataSet" cmd="com.inspur.cams.sorg.manage.cmd.SomFundLiqpeopleQueryCmd">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomLiqpeople"></model:record>
	</model:dataset>
	<model:dataset id="winLiqpeopleDataSet" cmd="com.inspur.cams.sorg.manage.cmd.SomFundLiqpeopleQueryCmd">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomLiqpeople">
			<model:field name="name" type="string" rule="require|length{72}" />
			<model:field name="liqDuties" type="string" rule="require|length{50}" />
			<model:field name="workDuties" type="string" rule="length{50}" />
			<model:field name="workName" type="string" rule="length{100}" />
		</model:record>
	</model:dataset>

</model:datasets>

<%--定义界面--%>
<next:Panel width="100%" height="100%">
	<next:TopBar>
		<next:ToolBarItem symbol="注销申请"></next:ToolBarItem>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="save" text="保存" handler="saveAll"></next:ToolBarItem>
		<next:ToolBarItem iconCls="return" text="返回" handler="back"></next:ToolBarItem>
	</next:TopBar>

	<next:TabPanel id="tab" name="tabpanel-div" width="100%"  height="100%" activeTab="0">
		<next:Tabs>
			<next:Panel id="cbPanel" width="100%" title="基金会注销登记表">
				<next:Html>
					<form id="cbForm" method="post" dataset="somOrganDataSet" onsubmit="return false" class="L5form">
					<table width="100%">
						<tr>
							<td class="FieldLabel"><label>登记证号：</label></td>
							<td class="FieldInput" colspan="5"><label field="sorgCode" style="width:98%"/></td>
						</tr>
						<tr>
							<td class="FieldLabel"><label>基金会名称：</label></td>
							<td class="FieldInput" colspan="5"><label field="cnName" style="width:98%"/></td>
						</tr>
						<tr>
							<td class="FieldLabel"  style="width:15%"><label>注销日期：</label></td>
							<td class="FieldInput"  style="width:17%"><input type="text" name='"注销日期"' field="cancelDate" format="Y-m-d" onclick="WdatePicker()" style="width:90%"/><span style="color:red">*</span></td>
							<td class="FieldLabel"  style="width:15%"><label>成立日期：</label></td>
							<td class="FieldInput"  style="width:17%"><label field="buildDate" style="width:90%"/></td>
							<td class="FieldLabel"  style="width:15%"><label>法定代表人：</label></td>
							<td class="FieldInput"  style="width:17%"><label field="legalPeople" style="width:90%"/></td>
						</tr>
						<tr>
							<td class="FieldLabel"><label>基金会电话：</label></td>
							<td class="FieldInput" colspan="5"><label field="sorgPhone" style="width:90%"/></td>
						</tr>
						<tr>
							<td class="FieldLabel"><label>注销具体原因：</label></td>
							<td class="FieldInput" colspan="5"><textarea rows="5" name='"注销具体原因"' field="cancelReason" style="width:98%"></textarea><span style="color:red">*</span></td>
						</tr>
						<tr>
							<td class="FieldLabel"><label>清算结论：</label></td>
							<td class="FieldInput" colspan="5"><textarea rows="2" name='"清算结论"' field="liqResult" style="width:98%"></textarea><span style="color:red">*</span></td>
						</tr>
					</table>
					</form>
				</next:Html>
			</next:Panel>
			<next:Panel title="清算组织人员" width="100%">
				<next:EditGridPanel id="grid_1" stripeRows="true" width="100%" height="100%" dataset="somLiqpeopleDataSet">
					<next:TopBar>
						<next:ToolBarItem symbol="清算组织主要组成人员列表"></next:ToolBarItem>
						<next:ToolBarItem symbol="->"></next:ToolBarItem>
						<next:ToolBarItem iconCls="add" text="增加" handler="addItem"></next:ToolBarItem>
						<next:ToolBarItem iconCls="remove" text="删除" handler="delItem"></next:ToolBarItem>
						<next:ToolBarItem iconCls="undo" text="取消" handler="undoItem"></next:ToolBarItem>
					</next:TopBar>

					<next:Columns>
						<next:RowNumberColumn />
						<next:RadioBoxColumn></next:RadioBoxColumn>
						<next:Column header="姓名" field="name" width="17%" editable="false"><next:TextField /></next:Column>
						<next:Column header="清算职务" field="liqDuties" width="25%" editable="false"><next:TextField /></next:Column>
						<next:Column header="职务（职称）" field="workDuties" width="25%" editable="false"><next:TextField /></next:Column>
						<next:Column header="工作单位" field="workName" width="33%" editable="false"></next:Column>
						<next:Column header="清算人员ID" field="id" hidden="true" editable="false"><next:TextField /></next:Column>
					</next:Columns>
					<next:BottomBar>
						<next:PagingToolBar dataset="somLiqpeopleDataSet" />
					</next:BottomBar>
				</next:EditGridPanel>
			</next:Panel>
			<next:Panel title="电子档案上传" width="100%" >
				<next:Html>
				  <iframe id="uploadInfo" src="../upload/somUploadComm.jsp?sorgId=<%=request.getParameter("sorgId") %>&applyType=203"
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
	   				</iframe>
				</next:Html>
			</next:Panel>
		</next:Tabs>
	</next:TabPanel>
</next:Panel>
<next:Window id="win_1" title="添加清算组织成员" resizable="false" width="530" height="165" closeAction="hide">
	<next:Panel id="panel_win_1">
		<next:Html>
			<form id="form_win_1" method="post" dataset="winLiqpeopleDataSet" onsubmit="return false" class="L5form">
			<table width="100%">
				<tr>
					<td class="FieldLabel" style="width:15%"><label>姓名：</label></td>
					<td class="FieldInput" style="width:35%"><input type="text" name='"姓名"' field="name" style="width:90%"/><span style="color:red">*</span></td>
					<td class="FieldLabel" style="width:15%"><label>清算职务：</label></td>
					<td class="FieldInput" style="width:35%"><input type="text" name='"清算职务"' field="liqDuties" style="width:90%"/><span style="color:red">*</span></td>
				</tr>
				<tr>
					<td class="FieldLabel"><label>职务：</label></td>
					<td class="FieldInput" colspan="3"><input type="text" name='"职务（职称）"' field="workDuties" style="width:97%"/></td>
				</tr>
				<tr>
					<td class="FieldLabel"><label>工作单位：</label></td>
					<td class="FieldInput" colspan="3"><input type="text" name='"工作单位"' field="workName" style="width:97%"/></td>
				</tr>
			</table>
			</form>
		</next:Html>
	</next:Panel>
	<next:Buttons>
		<next:ToolButton text="确定" handler="saveWin_1"></next:ToolButton>
		<next:ToolButton text="关闭" handler="closeWin_1"></next:ToolButton>
	</next:Buttons>
</next:Window>
</body>
</html>