<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="com.inspur.cams.comm.util.StrUtil,org.loushang.next.skin.SkinUtils"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<title>分支(代表)机构注销登记</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="somGroupBranchCancel.js"></script>
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
	<model:dataset id="somOrganDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomOrganQueryCmd" method="queryBranch">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomOrgan">
			<model:field name="cancelDate" type="string" rule="require" />
			<model:field name="cancelReason" type="string" rule="require|length{500}" />
		</model:record>
	</model:dataset>

</model:datasets>

<%--定义界面--%>
<next:Panel width="100%" height="100%">
	<next:TopBar>
		<next:ToolBarItem symbol="分支(代表)机构注销申请"></next:ToolBarItem>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="save" text="保存" handler="saveAll"></next:ToolBarItem>
		<next:ToolBarItem iconCls="return" text="返回" handler="back"></next:ToolBarItem>
	</next:TopBar>
	<next:TabPanel id="tab" width="100%" height="100%" >
		<next:Tabs>
			<next:Panel id="panel" title="分支(代表)机构注销申请" width="100%" height="100%">
				<next:Html>
					<form id="form" method="post" dataset="somOrganDataSet" onsubmit="return false" class="L5form">
						<table width="100%">
							<tr>
								<td class="FieldLabel"><label>登记证号：</label></td>
								<td class="FieldInput" colspan="5"><label field="mainSorgCode" style="width:98%"/></td>
							</tr>
							<tr>
								<td class="FieldLabel"><label>社团名称：</label></td>
								<td class="FieldInput" colspan="5"><label field="name" style="width:98%"/></td>
							</tr>
							<tr>
								<td class="FieldLabel"><label>机构登记证号：</label></td>
								<td class="FieldInput" colspan="5"><label field="sorgCode" style="width:98%"/></td>
							</tr>
							<tr>
								<td class="FieldLabel"><label>机构名称：</label></td>
								<td class="FieldInput" colspan="5"><label field="cnName" style="width:98%"/></td>
							</tr>
							<tr>
								<td class="FieldLabel" style="width:15%"><label>注销日期：</label></td>
								<td class="FieldInput" style="width:17%"><input type="text" name='"注销日期"' field="cancelDate" format="Y-m-d" onclick="WdatePicker()" style="width:90%"/><label style="color:red">*</label></td>
								<td class="FieldLabel" style="width:17%"><label>成立日期：</label></td>
								<td class="FieldInput" style="width:17%"><label field="buildDate" style="width:90%"/></td>
								<td class="FieldLabel" style="width:17%"><label>法定代表人：</label></td>
								<td class="FieldInput" style="width:17%"><label field="legalPeople" style="width:90%"/></td>
							</tr>
							<tr>
								<td class="FieldLabel"><label>注销理由：</label></td>
								<td class="FieldInput" colspan="5"><textarea rows="5" name='"注销理由"' field="cancelReason" style="width:98%"></textarea><label style="color:red">*</label></td>
							</tr>
						</table>
					</form>
				</next:Html>
			</next:Panel>
			<next:Panel title="电子档案上传" width="100%" >
				<next:Html>
				  <iframe id="uploadInfo" src="../upload/somUploadComm.jsp?sorgId=<%=request.getParameter("sorgId") %>&applyType=007"
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
		  				</iframe>
				</next:Html>
			</next:Panel>
		</next:Tabs>
	</next:TabPanel>
</next:Panel>
</body>
</html>