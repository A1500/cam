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
<script type="text/javascript" src="PublicTimeControl.js"></script>
<script type="text/javascript" src="cdcVoluntaryInfoEdit.js"></script>
<script type="text/javascript"
	src='<%=SkinUtils.getJS(request,"cams.js")%>'></script>
<script type="text/javascript" src='<%=SkinUtils.getJS(request,"camsCheck.js")%>'></script>
<jsp:include page="../util/cdcOrgan.jsp" flush="true"/>
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
			<model:field name="voluntaryType" type="string" rule="require" />
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
		<next:ToolBarItem iconCls="save" text="保存" handler="saveBack" />
		<next:ToolBarItem iconCls="save" text="保存并继续" handler="saveAgain" id="btnAgain"/>
		<next:ToolBarItem iconCls="return" text="关闭" handler="back" />
	</next:TopBar>
	<next:Html>
		<form id="editForm2" method="post" dataset="cdcVoluntaryInfoDataSet"
			onsubmit="return false" class="L5form">
		<table width="100%">
			<tr>
				<td class="FieldLabel" style="width: 180px;">姓名</td>
				<td class="FieldInput"><input type="text" name="姓名"
					field="name" style="width: 150px" maxlength="36" /><font
					color="red">*</font></td>
				<td class="FieldInput" rowspan="4" colspan="2" align="center" valign="bottom">
					<div id="tt" style="position: relative;">
						<img id="img" src="../../../../../skins/images/default.jpg" align="middle" 
							width="85" height="120" />
						<input type="button" value="选择照片" onmouseover="floatFile()" style="width: 80px;">
						<div id="div1">
							<div id="file1text">
							</div>
							<input id="idFile" name="idFile" type="file"
								onchange="selectImg()"
								style="position: absolute; filter: alpha(opacity = 5); width: 30px;"
								hidefocus>
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<td class="FieldLabel">身份证件号</td>
				<td class="FieldInput"><input type="text" name="身份证件号"
					id="idCard" field="idCard" style="width: 150px" maxlength="18" onblur="backBirthDay(this.value)"/><font
					color="red">*</font></td>
			</tr>
			<tr>
				<td class="FieldLabel" style="width: 180px;">性别</td>
				<td class="FieldInput"><select id="sex" name="性别" field="sex"
					style="width: 150px">
					<option dataset="sexDs"></option>
				</select><font color="red">*</font></td>
			</tr>
			<tr>
				<td class="FieldLabel">出生日期</td>
				<td class="FieldInput"><input type="text" name="出生日期" id="birthday"
						field="birthday" onpropertychange="changeDateStyle(this)"
						onblur="check(this)" style="width: 120px" format="Y-m-d"
						maxlength="10" /><img
						src="../../../../../skins/images/default/rl.gif" align="middle"
						onclick="getDay(this);"><font color="red">*</font></td>
			</tr>
			<tr>
				<td class="FieldLabel">文化程度</td>
				<td class="FieldInput"><select name="文化程度" field="eduCode"
					style="width: 150px">
					<option dataset="educationDs"></option>
				</select><font color="red">*</font></td>
				<td class="FieldLabel">政治面貌</td>
				<td class="FieldInput"><select name="政治面貌"
					field="politicalCode" style="width: 150px">
					<option dataset="sorgPoliticsDS"></option>
				</select><font color="red">*</font></td>
			</tr>
			<tr>
				<td class="FieldLabel">联系电话</td>
				<td class="FieldInput"><input type="text" name="联系电话"
					field="tel" style="width: 150px" maxlength="30" /><font
					color="red">*</font></td>
				<td class="FieldLabel">邮箱</td>
				<td class="FieldInput"><input type="text" name="邮箱"
					field="email" style="width: 150px" /></td>
			</tr>
			<tr>
				<td class="FieldLabel">邮编</td>
				<td class="FieldInput"><input type="text" name="邮编"
					field="postCode" style="width: 150px" /></td>
				<td class="FieldLabel">工作单位</td>
				<td class="FieldInput"><input type="text" name="工作单位"
					field="workUnit" style="width: 150px" maxlength="100" /></td>
			</tr>
			<tr>
				<td class="FieldLabel">志愿服务分类</td>
				<td class="FieldInput" colspan="3"><select type="text" id="voluntaryType" name="志愿服务分类"
					field="voluntaryType" style="width: 150px">
						<option dataset="voluntary_type"></option>
					</select><font color="red">*</font></td>
				
			</tr>
			<tr>
				<td class="FieldLabel">家庭住址</td>
				<td class="FieldInput" colspan="3"><input type="text"
					name="家庭住址" field="address" style="width: 80%" maxlength="100" /></td>
			</tr>
			<tr>
				<td class="FieldLabel">特长</td>
				<td class="FieldInput" colspan="3"><input type="text" name="特长"
					field="forte" style="width: 80%" /></td>
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