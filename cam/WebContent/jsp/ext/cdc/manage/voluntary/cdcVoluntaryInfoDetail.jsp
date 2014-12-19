<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils"%>
<html>
<head>
<title>志愿者信息维护</title>
<next:ScriptManager />
<script type="text/javascript">
	var method='<%=request.getParameter("method")%>';
	var voluntaryId='<%=request.getParameter("voluntaryId")%>';
</script>
<script type="text/javascript" src="cdcVoluntaryInfoDetail.js"></script>
<script type="text/javascript"
	src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
</head>
<body>
<model:datasets>
	<!-- 志愿者信息DS -->
	<model:dataset id="cdcVoluntaryInfoDataSet"
		cmd="com.inspur.cams.cdc.base.cmd.CdcVoluntaryInfoQueryCmd"
		global="true">
		<model:record
			fromBean="com.inspur.cams.cdc.base.data.CdcVoluntaryInfo">
			<model:field name="name" type="string" rule="require" />
			<model:field name="idCard" type="string" rule="require" />
			<model:field name="sex" type="string" rule="require" />
			<model:field name="birthday" type="string" rule="require" />
			<model:field name="eduCode" type="string" rule="require" />
			<model:field name="politicalCode" type="string" rule="require" />
			<model:field name="tel" type="string" rule="require" />
		</model:record>
	</model:dataset>

	<!-- 政治面貌-->
	<model:dataset id="sorgPoliticsDS" autoLoad="true"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_POLITICAL'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 性别 -->
	<model:dataset id="sexDs" enumName="COMM.SEX" autoLoad="true"
		global="true"></model:dataset>
	<!-- 文化程度 -->
	<model:dataset id="educationDs" autoLoad="true"
		cmd="com.inspur.cams.comm.dicm.DicQueryCmd" global="true">
		<model:record fromBean="com.inspur.cams.comm.dicm.DicBean"></model:record>
		<model:params>
			<model:param name="dic" value='DIC_EDUCATION'></model:param>
			<model:param name="value" value='CODE'></model:param>
			<model:param name="text" value='NAME'></model:param>
		</model:params>
	</model:dataset>
	<!-- 是否 -->
	<model:dataset id="yesOrNoDs" enumName="COMM.YESORNO" autoLoad="true"
		global="true"></model:dataset>
	<!-- 志愿服务分类 -->
	<model:dataset id="voluntary_type" enumName="CDC.VOLUNTARY_TYPE" autoLoad="true"
		global="true"></model:dataset>
</model:datasets>
<next:Panel width="100%" height="100%" autoScroll="false">
	<next:TopBar>
		<next:ToolBarItem symbol="志愿者信息"></next:ToolBarItem>
		<next:ToolBarItem symbol="->"></next:ToolBarItem>
		<next:ToolBarItem iconCls="return" text="关闭" handler="back" />
	</next:TopBar>
	<next:Html>
		<form id="editForm" method="post" dataset="cdcVoluntaryInfoDataSet"
			onsubmit="return false" class="L5form">
		<table width="100%">
			<tr>
				<td class="FieldLabel" style="width: 180px;">姓名</td>
				<td class="FieldInput"><label field="name"/></td>
				<td class="FieldInput" rowspan="4" colspan="2" align="center" valign="bottom">
					<img id="img" src="../../../../../skins/images/default.jpg" align="middle" 
						width="85" height="120" />
				</td>
			</tr>
			<tr>
				<td class="FieldLabel">身份证件号</td>
				<td class="FieldInput"><label field="idCard"/></td>
			</tr>
			<tr>
				<td class="FieldLabel" style="width: 180px;">性别</td>
				<td class="FieldInput"><label field="sex" dataset="sexDs"/></td>
			</tr>
			<tr>
				<td class="FieldLabel">出生日期</td>
				<td class="FieldInput"><label field="birthday"/></td>
			</tr>
			<tr>
				<td class="FieldLabel">文化程度</td>
				<td class="FieldInput"><label field="eduCode" dataset="educationDs"/></td>
				<td class="FieldLabel">政治面貌</td>
				<td class="FieldInput"><label field="politicalCode" dataset="sorgPoliticsDS"/></td>
			</tr>
			<tr>
				<td class="FieldLabel">联系电话</td>
				<td class="FieldInput"><label field="tel"/></td>
				<td class="FieldLabel">邮箱</td>
				<td class="FieldInput"><label field="email"/></td>
			</tr>
			<tr>
				<td class="FieldLabel">邮编</td>
				<td class="FieldInput"><label field="postCode"/></td>
				<td class="FieldLabel">工作单位</td>
				<td class="FieldInput"><label field="workUnit"/></td>
			</tr>
			<tr>
				<td class="FieldLabel">志愿服务分类</td>
				<td class="FieldInput" colspan="3"><label id="voluntaryType" name="志愿服务分类"
					field="voluntaryType" style="width: 150px" dataset="voluntary_type">
					</label></td>
			</tr>
			<tr>
				<td class="FieldLabel">家庭住址</td>
				<td class="FieldInput" colspan="3"><label field="address"/></td>
			</tr>
			<tr>
				<td class="FieldLabel">特长</td>
				<td class="FieldInput" colspan="3"><label field="forte"/></td>
			</tr>
			<tr id="updateTr">
				<td class="FieldLabel">志愿活动累计次数</td>
				<td class="FieldInput"><label field="caperNums" /></td>
				<td class="FieldLabel">志愿活动累计时间(分钟)</td>
				<td class="FieldInput"><label field="caperTimes" /></td>
			</tr>
			<tr id="updateTr2">
				<td class="FieldLabel">录入单位</td>
				<td class="FieldInput"><label field="organName" /></td>
				<td class="FieldLabel">录入时间</td>
				<td class="FieldInput"><label field="createTime" /></td>
			</tr>
		</table>
		</form>
	</next:Html>
</next:Panel>
</body>
</html>