<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next" %>
<%@ taglib uri="/tags/next-model" prefix="model" %>
<%@ page import="com.inspur.cams.comm.util.StrUtil,org.loushang.next.skin.SkinUtils"%>
<html>
<head>
<title>社团分支/代表信息修改</title>
<next:ScriptManager></next:ScriptManager>
<script type="text/javascript" src="somGroupBranchUpdate.js"></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"My97DatePicker/WdatePicker.js") %>'></script>
<script type="text/javascript">
	var sorgId = '<%=StrUtil.n2b(request.getParameter("sorgId"))%>';
</script>
</head>
<body>

<%--定义dataset--%>
<model:datasets>
	<%--基本信息--%>
	<model:dataset id="somMainOrganDataSet" cmd="com.inspur.cams.sorg.base.cmd.SomOrganQueryCmd" method="queryMain">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomOrgan"></model:record>
	</model:dataset>
	<model:dataset id="somOrganDataSet" cmd="com.inspur.cams.sorg.manage.cmd.SomGroupOrganQueryCmd" method="queryBranch">
		<model:record fromBean="com.inspur.cams.sorg.base.data.SomOrgan">
			<model:field name="mainSorgCode" type="string" rule="require" />
			<model:field name="sorgCode" type="string" rule="require|length{20}" />
			<model:field name="cnName" type="string" rule="require|length{100}" />
			<model:field name="residence" type="string" rule="require|length{100}" />
			<model:field name="sorgPost" type="string" rule="require" />
			<model:field name="sorgKind" type="string" rule="require" />
			<model:field name="sorgPhone" type="string" rule="require|length{30}" />
			<model:field name="business" type="string" rule="require|length{1000}" />
			<%--<model:field name="busScope" type="string" rule="require" />所属行（事）业--%>
			<model:field name="appReason" type="string" rule="require|length{500}" />
			<model:field name="borgName" type="string" rule="require|length{100}" />
			<model:field name="buildDate" type="string" rule="require" />
		</model:record>
	</model:dataset>

	<model:dataset id="busScopeSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_BUS_SCOPE'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<model:dataset id="sorgKindSelect" cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true" autoLoad="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_FUND_BRANCH_KIND'></model:param>
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
		</model:params>
	</model:dataset>
	<model:dataset id="sexSelect" enumName="COMM.SEX" autoLoad="true" global="true"></model:dataset>

</model:datasets>

<%--定义界面--%>
<next:Panel width="100%" height="100%">
	<next:TopBar>
		<next:ToolBarItem symbol="分支/代表信息修改"></next:ToolBarItem>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="save" text="更新" handler="updateAll"></next:ToolBarItem>
		<next:ToolBarItem iconCls="return" text="返回" handler="back"></next:ToolBarItem>
	</next:TopBar>
	<next:TabPanel id="tab" width="100%" height="100%" >
		<next:Tabs>
			<next:Panel title="分支/代表信息修改" width="100%" height="100%" autoScroll="true">
				<next:Html>
					<form method="post" dataset="somOrganDataSet" onsubmit="return false"
						class="L5form">
						<table width="100%">
							<tr>
								<td class="FieldLabel"><label>社团主体登记证号：</label></td>
								<td class="FieldInput" colspan="5"><input type="text"  id="mainSorgCode" name='"社团登记证号"' field="mainSorgCode" onchange="validateSorgCode()" style="width:98%"/><label style="color:red">*</label></td>
							</tr>
							<tr>
								<td class="FieldLabel"><label>社团名称：</label></td>
								<td class="FieldInput" colspan="5"><label id="name" style="width:98%"></label></td>
							</tr>
							<tr>
								<td class="FieldLabel"><label>分支/代表机构登记证号：</label></td>
								<td class="FieldInput" colspan="5"><input type="text"  id="sorgCode" name='"分支/代表机构登记证号"' field="sorgCode" onchange="sorgCodeUK()" style="width:98%"/><label style="color:red">*</label></td>
							</tr>
							<tr>
								<td class="FieldLabel"><label>分支/代表机构名称：</label></td>
								<td class="FieldInput" colspan="5"><input type="text" id="cnName" name='"分支/代表机构名称"' field="cnName" onchange="cnNameUK()" style="width:98%"/><label style="color:red">*</label></td>
							</tr>
							<tr>
								<td class="FieldLabel"><label>办公场所：</label></td>
								<td class="FieldInput" colspan="5"><input type="text" name='"办公场所"' field="residence" style="width:98%"/><label style="color:red">*</label></td>
							</tr>
							<tr>
								<td class="FieldLabel" style="width:15%"><label>社团法定代表人：</label></td>
								<td class="FieldInput" style="width:17%"><label id="legalPeople" style="width:90%"/></td>
								<td class="FieldLabel" style="width:15%"><label>机构邮编：</label></td>
								<td class="FieldInput" style="width:17%"><input type="text" id="sorgPost" name='"机构邮编"' field="sorgPost" style="width:90%"/><label style="color:red">*</label></td>
								<td class="FieldLabel" style="width:15%"><label>机构类型：</label></td>
								<td class="FieldInput" style="width:17%">
									<select name='"机构类型"' field="sorgKind" style="width:90%">
										<option dataset="sorgKindSelect"></option>
									</select><label style="color:red">*</label>
								</td>
							</tr>
							<tr>
								<td class="FieldLabel"><label>机构电话：</label></td>
								<td class="FieldInput" colspan="5"><input type="text" id="sorgPhone" name='"机构电话"' field="sorgPhone" style="width:59%"/><label style="color:red">*说明：多个电话，中间用英文分号隔开</label></td>
							</tr>
							<tr>
								<td class="FieldLabel"><label>业务范围：</label></td>
								<td class="FieldInput" colspan="5"><textarea rows="10" name='"业务范围"' field="business" style="width:98%"/></textarea><label style="color:red">*</label></td>
							</tr>
							<tr>
								<td class="FieldLabel"><label>设立理由：</label></td>
								<td class="FieldInput" colspan="5"><textarea rows="5" name='"设立理由"' field="appReason" style="width:98%"></textarea><label style="color:red">*</label></td>
							</tr>
							<tr>
								<td class="FieldLabel"><label>业务主管单位：</label></td>
								<td class="FieldInput" colspan="3">
									<select name='"业务主管单位"' field="borgName" style="width:97%">
										<option dataset="businessOrganSelect"></option>
									</select><label style="color:red">*</label>
								</td>
								<td class="FieldLabel"><label>主管单位审查日期：</label></td>
								<td class="FieldInput"><input type="text" field="borgCheckDate" format="Y-m-d" onclick="WdatePicker()" style="width:90%"/></td>
							</tr>
							<tr>
								<td class="FieldLabel"><label>成立日期：</label></td>
								<td class="FieldInput"><input type="text" name='"成立日期"' field="buildDate" format="Y-m-d" onclick="WdatePicker()" style="width:90%"/><span style="color:red">*</span></td>
								<td class="FieldLabel"><label>所属行（事）业：</label></td>
								<td class="FieldInput" colspan="3">
									<select field="busScope" name='"所属行（事）业"' style="width:30%">
										<option dataset="busScopeSelect"></option>
									</select>
								</td>
							</tr>
						</table>
					</form>
					<div id="mainSorgId" title="隐藏：主体组织ID" style="display:none"></div>
				</next:Html>
			</next:Panel>
			<next:Panel title="电子档案上传" width="100%" >
				<next:Html>
				  <iframe id="uploadInfo" src="../upload/somUploadComm.jsp?sorgId=<%=request.getParameter("sorgId") %>&applyType=005"
						frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes" width="100%" height="100%">
		  				</iframe>
				</next:Html>
			</next:Panel>
		</next:Tabs>
	</next:TabPanel>
</next:Panel>
</body>
</html>