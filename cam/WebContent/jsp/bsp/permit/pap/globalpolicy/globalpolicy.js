var page;
if(!page) page = {};
page.editMode2command={add:'add',update:'update'};
page.editMode;
page.errorMsg = [
     res.longerThanLongest,
     res.invalidedNumber,
     res.smallerThan0,
     res.equals0
 ];
 //记录需要验证的字段的业务上的名称
 page.field = [res.pswdMinLeng,res.pswdMaxLeng,
 				res.loginAttempTime,res.pswdLifeTime,
 				res.pswdLockTime,res.pswdGraceTime];
page.validingNumberField = [
			'pwdMinLength','pwdMaxLength',
			'loginAttempts','pwdLifeTime',
			'pwdLockTime','pwdGraceTime'];
page.validingDomId = [
	'pwdMinLengthId','pwdMaxLengthId',
	'loginAttemptsId','pwdLifeTimeId',
	'pwdLockTimeId','pwdGraceTimeId'
];
/**
 * 验证一个record的合法性，找到一个非法信息就返回。
 */
page.validInput=function(rcd){
	var msg;
	var validingFields  = [];//要验证的条目
	var leng = page.validingNumberField.length;
	var rcd = globalpolicyDataSet.getCurrent();
	for(var i=0;i<leng; i++){
		var field = document.getElementById(page.validingDomId[i]).value;
		if(field === "" || field ===null){
			field = 0;
		}
		validingFields.push(field-0);
	}
	msg = page.validNumber(validingFields);
	if(msg){
		return page.field[msg.index]+msg.info;
	}
	//msg = page.specialValid(validingFields);
	//if(msg){
		//return page.field[msg.index]+msg.info;
	//}
	//验证业务信息的合法性
	if(rcd.get(page.validingNumberField[0]) && rcd.get(page.validingNumberField[1])){

		if( validingFields[0]> validingFields[1]){
			return page.errorMsg[0];
		}
	}
};
//验证数字格式的合法性
page.validNumber=function(nums){
	var leng = nums.length;
	for(var i =0; i<leng; i++){
		if(parseInt(nums[i]) != nums[i]){
			var msg = {};
			msg.index = i;
			msg.info = page.errorMsg[1];
			return msg;
		}
	}

};
//特殊的验证(现在检查负数）
page.specialValid = function(nums){
	var leng = nums.length;
	leng=2;//只有密码长度和重试次数进行正负数校验
	for(var i =0; i<leng; i++){
		if(nums[i] <= 0){
			var msg = {};
			msg.index = i;
			msg.info = page.errorMsg[2];
			return msg;
		}
	}
};
page.resetPolicy = function(rcd){
	rcd.set('pwdMinLength',1);
	rcd.set('pwdMaxLength',30);
	rcd.set('isUPCase',"");
	rcd.set('isLowerCase',"");
	rcd.set('isNum',"");
	rcd.set('isSperialChar',"");
	rcd.set('isPepeat',"");
	rcd.set('pwdLifeTime',86400);
	rcd.set('loginAttempts',3);
	rcd.set('pwdLockTime',-1);
	rcd.set('pwdGraceTime',-1);
};
page.save0 = function(rcd){
	var command = new L5.Command("org.loushang.bsp.permit.pap.user.cmd.GlobalPolicyCmd");
	change_checkbox(rcd);
	 if(rcd.get("pwdMinLength")==""){
	     rcd.set("pwdMinLength",1);
	  }
	 if(rcd.get("pwdMaxLength")==""){
	    rcd.set('pwdMaxLength',30);
	 }
	 if(rcd.get("pwdLifeTime")==""){
	    rcd.set('pwdLifeTime',86400);
	 }
	 if(rcd.get("loginAttempts")==""){
	   rcd.set('loginAttempts',3);
	 }
	 if(rcd.get("pwdLockTime")==""){
	   rcd.set('pwdLockTime',-1);
	 }
	 if(rcd.get("pwdGraceTime")==""){
	   rcd.set('pwdGraceTime',-1);
	 }
	command.setParameter("record",rcd);
	//command.execute(page.editMode2command[page.editMode]);
	command.execute(page.editMode);
	return command.error;
};

/*
 * 初始化
 */
function init(){

	globalpolicyDataSet.on('load',function(){
		if(globalpolicyDataSet.getCount()<1){//no globalPolicy
			globalpolicyDataSet.newRecord();
			page.editMode = 'add';
		}else{
			page.editMode = 'update';
		}
	});
	globalpolicyDataSet.load();
	L5.QuickTips.init();
}

/*
 * 点击checkbox
 */
function checkbox_onclick(src){
	var record = globalpolicyDataSet.getCurrent();
	var field = src.getAttribute("field");
	if(src.checked){
		record.set(field,"1");
	}else{
		record.set(field,"0");
	}
}

function change_checkbox(record){
	var inputs = document.getElementsByTagName("input");
	var num = 0;
	for(var i=0;i<inputs.length;i++){
		var type = inputs[i].getAttribute("type");
		if(type=='checkbox'){
			var field = inputs[i].getAttribute("field");
			if(inputs[i].checked){
				record.set(field,"1");
			}else{
				record.set(field,"0");
			}
		}
	}
}
function resetPolicy(){
		L5.MessageBox.confirm(RES_PROMOT,"将清除原有策略，设为默认的策略，确定吗？",function(state){
		if(state == 'yes'){
			var rcd = globalpolicyDataSet.getCurrent();
			page.resetPolicy(rcd);//清空record的记录值
			save();
		}
	});

}
/*
 * 修改
 */
function save(){

	var rcds = globalpolicyDataSet.getAllChangedRecords();
	var rcd = globalpolicyDataSet.getCurrent();
	if(rcds.length < 1){
		L5.MessageBox.alert(RES_PROMOT,res.noNeedSave);
		return;
	}
	var msg = page.validInput(rcds[0]);
	if(msg){
		L5.MessageBox.alert(RES_PROMOT,msg);
		return;
	}
	//逻辑校验
	var logicVaildmsg=logicVaild();
	if(logicVaildmsg!=""){
		L5.MessageBox.alert('提示',logicVaildmsg);
		return;
	}
	L5.MessageBox.confirm(RES_PROMOT,res.doYouSave,function(state){
		if(state == 'yes'){
			var msg = page.save0(rcds[0]);
			if(!msg){
				globalpolicyDataSet.commitChanges();
				page.editMode = 'update';
				L5.MessageBox.alert(RES_PROMOT,"保存成功！")
			}else{
				L5.MessageBox.alert(RES_PROMOT,msg)
			}
		}
	});
}

//逻辑校验
function logicVaild(){

	var rcd = globalpolicyDataSet.getCurrent();
	if(rcd.get("pwdMinLength")!==""&&rcd.get("pwdMinLength")<=0){
		return "密码最小长度必须大于零！";
	}
	if(rcd.get("pwdMaxLength")!==""&&rcd.get("pwdMaxLength")<=0){
		return "密码最大长度必须大于零！";
	}
		if(rcd.get("pwdMinLength")!="" && rcd.get("pwdMaxLength")==""){
		return "密码最小长度和最大长度必须同时赋值！";
	}
	if(rcd.get("pwdMaxLength")!="" && rcd.get("pwdMinLength")==""){
		return "密码最小长度和最大长度必须同时赋值！";
	}
	if(rcd.get("loginAttempts")!==""){
	if(rcd.get("loginAttempts")<0||rcd.get("loginAttempts")===0){
	    return "用户登录失败次数只能为大于零的数!";
       }
	}
	if(rcd.get("pwdLockTime")!==""){
	if((rcd.get("pwdLockTime")<0&&rcd.get("pwdLockTime")!=-1)||rcd.get("pwdLockTime")===0){
        return "密码锁定时间只能为-1或者大于0的正整数!";
	 }
	}
	if(rcd.get("pwdLifeTime")!==""&&rcd.get("pwdLifeTime")===0){
        return "密码有效时间不能为0！";
	}
	if(rcd.get("pwdGraceTime")!==""&&rcd.get("pwdGraceTime")===0){
        return "密码失效后必须修改密码的时间不能为0！";
    }
	return "";
}
