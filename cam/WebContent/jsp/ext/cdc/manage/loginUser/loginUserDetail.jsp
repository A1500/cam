<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/tags/next-web" prefix="next"%>
<%@ taglib uri="/tags/next-model" prefix="model"%>
<html>
<head>
<title>登录单位信息</title>
<next:ScriptManager/>
<script type="text/javascript">
	userStatus="loginUserDetail.jsp";
</script>
<jsp:include page="../util/cdcOrgan.jsp" flush="true"/>
</head>
<body>
<model:datasets>
	<model:dataset id="cdcComExtUserDataSet" cmd="com.inspur.cams.comm.extuser.cmd.ComExtUserQueryCmd" pageSize="20">
		<model:record fromBean="com.inspur.cams.comm.extuser.data.ComExtUser"/>
	</model:dataset>
	<model:dataset id="communityTypeDataSet" enumName="CDC.COMMUNITY_TYPE" autoLoad="true" global="true" />
	<model:dataset id="YorN" enumName="COMM.YESORNO" autoLoad="true" global="true" />
</model:datasets>
<next:Panel width="100%" autoScroll="true">
<next:TopBar>
	<next:ToolBarItem symbol="->"/>
	<next:ToolBarItem iconCls="edit" text="修改密码" handler="password"/>
	<next:ToolBarItem iconCls="view" text="修改" handler="update"/>
	<next:ToolBarItem iconCls="return" text="返回" handler="returnBack"/>
</next:TopBar>
<next:Html>
<form id="form1" method="post" dataset="cdcComExtUserDataSet" onsubmit="return false" class="L5form">
<fieldset>
<legend>登录单位信息</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel" style="width:18%">登录账号：</td>
			<td class="FieldInput" style="width:30%"><label field="userId"/></td>
			<td class="FieldLabel" style="width:18%">登录用户：</td>
			<td class="FieldInput" style="width:30%"><label field="userName" /></td>
		</tr>
		<tr>
			<td class="FieldLabel">办公电话：</td>
			<td class="FieldInput"><label field="phone"/></td>
			<td class="FieldLabel">电子邮箱：</td>
			<td class="FieldInput"><label field="email"/></td>
		</tr>
		<tr>
			<td class="FieldLabel">通讯地址：</td>
			<td class="FieldInput" colspan="3"><label field="adds"/></td>
		</tr>
		<tr>
			<td class="FieldLabel">社区类型：</td>
			<td class="FieldInput"><label field="communityType" dataset = "communityTypeDataSet"/></td>
			<td class="FieldLabel">是否为自然村：</td>
			<td class="FieldInput"><label field="ifVillage" dataset = "YorN"/></td>
		</tr>
	</table>
</fieldset>
</form>
</next:Html>
</next:Panel>
<next:Window id="passwordWin" title="修改密码" resizable="false" width="500" height="210" modal="true" closable="true"  closeAction="hide" autoScroll="true">
<next:Panel>
<next:Html>
<form id="form2" name = "form2" method="post" dataset="cdcComExtUserDataSet" onsubmit="return false"  class="L5form">
<fieldset id="cdcFieldset">
<legend>密码信息</legend>
	<table width="100%">
		<tr>
			<td class="FieldLabel" style="width: 50%">原密码：</td>
			<td class="FieldInput" ><input type="password" id = "oldpsd" onblur="checkOldPsd()"/> </td>
		</tr>
		<tr>
			<td class="FieldLabel" >请输入新密码：</td>
			<td class="FieldInput" ><input type="password" id = "newpsd" /> </td>
		</tr>
		<tr>
			<td class="FieldLabel" >请确认新密码：</td>
			<td class="FieldInput" ><input type="password" id = "conformpsd" onblur="checkPsd()"/> </td>
		</tr>
		<tr>
			<td class="FieldInput" style = "text-align: center;" colspan="2" ><button onclick="conform()">确定</button>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <button onclick="cancle()">取消</button> </td>
		</tr>
	</table>
</fieldset>
</form>
</next:Html>
</next:Panel>
</next:Window>
</body>
</html>
<script language="javascript">
function init(){
	var ds=L5.DatasetMgr.lookup("cdcComExtUserDataSet");
	ds.setParameter("USER_ID@=",organCode);
	ds.load();
}
function returnBack(){
	history.go(-1);
}
function password(){
	L5.getCmp("passwordWin").setVisible(true);	
}
function checkOldPsd(){
	var ds=L5.DatasetMgr.lookup("cdcComExtUserDataSet");
	var oldpsd = document.getElementById("oldpsd");
	if(oldpsd.value==""){
		L5.Msg.alert("提示","请输入原密码!");
		return false;
	}else if(oldpsd.value !=ds.get("pwd")){
		L5.Msg.alert("提示","请输入正确的原密码!");
		//,function(){ oldpsd.focus();}
		return false;
	}
	 return true;
}
function checkPsd(){
	var newpsd = document.getElementById("newpsd");
	var conformpsd = document.getElementById("conformpsd");
	if(newpsd.value!=conformpsd.value){
		L5.Msg.alert("提示","两次输入的密码不一致，请修改!");
		return false;
	}
	return true;
}

function conform(){
	if(checkOldPsd()&&checkPsd()){
		var ds=L5.DatasetMgr.lookup("cdcComExtUserDataSet");
		var command=new L5.Command("com.inspur.cams.comm.extuser.cmd.ComExtUserCmd");
		command.setParameter("userId",ds.get("userId"));
		command.setParameter("passWord",document.getElementById("conformpsd").value);
		command.execute("updatePassWord");
		if (!command.error){
			L5.Msg.alert("提示","保存成功！",function(){
				returnBack();
			});
		}else{
			L5.Msg.alert("提示","保存出错！");
		}
	}
}
function cancle(){
	document.all.form2.reset();
	L5.getCmp("passwordWin").setVisible(false);
}
function update(){
	var data=new L5.Map();
	data.put("method","update");
	data.put("userId",organCode);
	var url="jsp/ext/cdc/manage/loginUser/loginUserEdit.jsp";
	L5.forward(url,'',data);
}
</script>