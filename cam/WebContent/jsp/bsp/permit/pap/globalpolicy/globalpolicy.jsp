<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<%@ page import="org.loushang.next.skin.SkinUtils" %>
<%@ include file="/jsp/public/resources_jspdir.jsp" %>
<next:ScriptManager/>
<html>
<head>
<script type="text/javascript">
var RES_PROMOT='<%=res.get("MSG.PROMOT")%>';
var RES_UNKOWN_CMD='<%=res.get("MSG.UNKOWN_CMD")%>';
var RES_SAVE='<%=res.get("MSG.SAVE")%>';
 var res ;
 if(!res)res={};
 res.resetPolicy = '<%=res.get("PUB_GLOBAL_POLICY.RESET_POLICY")%>';
 res.pswdMinLeng ='<%=res.get("PUB_GLOBAL_POLICY.PWD_MIN_LENGTH")%>';
 res.pswdMaxLeng = '<%=res.get("PUB_GLOBAL_POLICY.PWD_MAX_LENGTH")%>';
 res.permitUpCase = '<%=res.get("PUB_GLOBAL_POLICY.IS_UPCASE")%>';
 res.permitLowCase = '<%=res.get("PUB_GLOBAL_POLICY.IS_LOWERCASE")%>';
 res.permitNum = '<%=res.get("PUB_GLOBAL_POLICY.IS_NUM")%>';
 res.permitSpecialChar = '<%=res.get("PUB_GLOBAL_POLICY.IS_SPECIALCHAR")%>';
 res.permitRepeat = '<%=res.get("PUB_GLOBAL_POLICY.IS_REPEAT")%>';
 res.pswdLifeTime = '<%=res.get("PUB_GLOBAL_POLICY.PWD_LIFE_TIME")%>';
 res.loginAttempTime = '<%=res.get("PUB_GLOBAL_POLICY.LOGIN_ATTEMPTS")%>';
 res.pswdLockTime = '<%=res.get("PUB_GLOBAL_POLICY.PWD_LOCK_TIME")%>';
 res.pswdGraceTime = '<%=res.get("PUB_GLOBAL_POLICY.PWD_GRACE_TIME")%>';

 res.longerThanLongest='<%=res.get("PUB_GLOBAL_POLICY.MSG_LONGER_THAN_LONGEST")%>';
 res.invalidedNumber = '<%=res.get("PUB_GLOBAL_POLICY.MSG_INVALIDED_NUMBER")%>';
 res.smallerThan0 = '<%=res.get("PUB_GLOBAL_POLICY.MSG_SMALLER_THAN_0")%>';
 res.equals0 = '<%=res.get("PUB_GLOBAL_POLICY.MSG_EQUALS_0")%>';
 res.noNeedSave = '<%=res.get("PUB_GLOBAL_POLICY.MSG_NO_NEED_SAVE")%>';
 res.doYouSave = '<%=res.get("PUB_GLOBAL_POLICY.MSG_DO_YOU_SAVE")%>';
</script>
<script type="text/javascript" src="globalpolicy.js"></script>

</head>
<body>
	<model:datasets>
		<model:dataset id="globalpolicyDataSet" cmd="org.loushang.bsp.permit.pap.user.cmd.GlobalPolicyQueryCmd" global="true">
			<model:record fromBean="org.loushang.bsp.permit.pap.user.data.GlobalPolicy"></model:record>
		</model:dataset>
</model:datasets>
<next:ViewPort>
<next:AnchorLayout>
<next:Panel  name="form" width="100%"   height="100%"  collapsible="true" autoScroll="true">
<next:TopBar>
	<next:ToolBarItem symbol="->" ></next:ToolBarItem>
	<next:ToolBarItem iconCls="undo" id="resetPolicyItem"  text='<%=res.get("PUB_GLOBAL_POLICY.RESET_POLICY")%>' handler="resetPolicy"/>
	<next:ToolBarItem iconCls="save" id="saveBtn"  text='<%=res.get("BUT.SAVE")%>' handler="save"/>
</next:TopBar>
	<next:Html>
		<form id="myform" onsubmit="return false" dataset="globalpolicyDataSet" class="L5form">

			    <fieldset style="overflow: visible;" class="GroupBox">
			    <legend class="GroupBoxTitle">密码强度	</legend>
			    <table border="0"  width="100%" >
		   		<tr>
					<td  class="FieldLabel" style="width:15%"><%=res.get("PUB_GLOBAL_POLICY.PWD_MIN_LENGTH")%></td>
					<td class="FieldInput" style="width:35%"><input id="pwdMinLengthId" type="text" name="pwdMinLength" field="pwdMinLength" /><font color="red">密码最小长度为1位，输入必须为正整数</font> </td>
				</tr>
				<tr>
					<td  class="FieldLabel" style="width:15%"><%=res.get("PUB_GLOBAL_POLICY.PWD_MAX_LENGTH")%></td>
					<td class="FieldInput" style="width:35%"><input id="pwdMaxLengthId" type="text" name="pwdMaxLength" field="pwdMaxLength" /><font color="red">输入必须为正整数，默认值为30</font> </td>
				</tr>
				<tr>
					<td  class="FieldLabel" style="width:15%"><%=res.get("PUB_GLOBAL_POLICY.IS_UPCASE")%></td>
					<td class="FieldInput" style="width:35%"><input id="isUPCaseId" type="checkbox" name="isUPCase" field="isUPCase"  value="1" /><font color="red"></font> </td>
				</tr>
				<tr>
					<td  class="FieldLabel" style="width:15%"><%=res.get("PUB_GLOBAL_POLICY.IS_LOWERCASE")%></td>
					<td class="FieldInput" style="width:35%"><input id="isLowerCaseId" type="checkbox" name="isLowerCase" field="isLowerCase"  value="1"/><font color="red"></font> </td>
				</tr>
				<tr>
					<td  class="FieldLabel" style="width:15%"><%=res.get("PUB_GLOBAL_POLICY.IS_NUM")%></td>
					<td class="FieldInput" style="width:35%"><input id="isNumId" type="checkbox" name="isNum" field="isNum"  value="1"/><font color="red"></font> </td>
				</tr>
				<tr>
					<td  class="FieldLabel" style="width:15%"><%=res.get("PUB_GLOBAL_POLICY.IS_SPECIALCHAR")%></td>
					<td class="FieldInput" style="width:35%"><input id="isSperialCharId" type="checkbox" name="isSperialChar"  field="isSperialChar"  value="1"/><font color="red">特殊符号，如$、*、%...</font> </td>
				</tr>
				</table>
                </fieldset>
                <fieldset style="overflow: visible;" class="GroupBox">
			    <legend class="GroupBoxTitle">其它</legend>
			    <table border="0"  width="100%" >
				<tr>
					<td  class="FieldLabel" style="width:15%"><%=res.get("PUB_GLOBAL_POLICY.LOGIN_ATTEMPTS")%></td>
					<td class="FieldInput" style="width:35%"><input id="loginAttemptsId" type="text" name="loginAttempts" field="loginAttempts"  /><font color="red">默认值为3</font> </td>
				</tr>
				<tr>
					<td  class="FieldLabel" style="width:15%"><%=res.get("PUB_GLOBAL_POLICY.PWD_LOCK_TIME")%></td>
					<td class="FieldInput" style="width:35%"><input id="pwdLockTimeId" type="text" name="pwdLockTime" field="pwdLockTime" /><font color="red">单位：分钟（负数表示永久，默认值为-1）</font> </td>
				</tr>
				<tr>
					<td  class="FieldLabel" style="width:15%"><%=res.get("PUB_GLOBAL_POLICY.PWD_LIFE_TIME")%></td>
					<td class="FieldInput" style="width:35%"><input id="pwdLifeTimeId" type="text" name="pwdLifeTime" field="pwdLifeTime" /><font color="red">单位：分钟（默认值为60天即86400分钟，负数表示永久）；表示密码需要修改的提示时间</font> </td>
				</tr>
				<tr>
					<td  class="FieldLabel" style="width:15%"><%=res.get("PUB_GLOBAL_POLICY.PWD_GRACE_TIME")%></td>
					<td class="FieldInput" style="width:35%"><input id="pwdGraceTimeId" type="text" name="pwdGraceTime" field="pwdGraceTime" /><font color="red">单位：分钟（负数表示永久，默认值为-1）；表示密码有效期后到密码失效用户锁定的时间</font> </td>
				</tr>
			</table>
			   </fieldset>
		</form>
	</next:Html>
</next:Panel>
</next:AnchorLayout>
</next:ViewPort>
</body>
</html>