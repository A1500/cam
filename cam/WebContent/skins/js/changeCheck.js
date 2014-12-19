//名称变更限制
function nameChangeCheck(){
	var nameAfter=document.getElementById('nameAfter').value;
	
	var nameReason=document.getElementById('nameReason').value;
	if(byteLength(nameAfter)>100){
		L5.Msg.alert("提示","社团名称长度不能超过100个字符(50个汉字)！");
		return false;
	}
	
	if(byteLength(nameReason)>500){
		L5.Msg.alert("提示","变更理由长度不能超过500个字符(250个汉字)！");
		return false;
	}
	return true;
}
//法定代表人变更限制
function leaPeopleChangeCheck(){
	var leaPeopleNameAfter=document.getElementById('leaPeopleNameAfter').value;
	
	var leaPeopleReason=document.getElementById('leaPeopleReason').value;
	if(byteLength(leaPeopleNameAfter)>72){
		L5.Msg.alert("提示","法定代表人姓名长度不能超过72个字符(36个汉字)！");
		return false;
	}
	
	if(byteLength(leaPeopleReason)>500){
		L5.Msg.alert("提示","变更理由长度不能超过500个字符(250个汉字)！");
		return false;
	}
	return true;
}
//住所变更限制
function houseChangeCheck(){
	var houseAreaAfter=document.getElementById('houseAreaAfter').value;//用房面积10.22
	var houseNameAfter=document.getElementById('houseNameAfter').value;
	var houseBorgAfter=document.getElementById('houseBorgAfter').value;
	var houseDateAfter=document.getElementById('houseDateAfter').value;
	
	var houseReason=document.getElementById('houseReason').value;
	
	var houseAreaAfterc = checkMoneyFix(houseAreaAfter,2);
	if(houseAreaAfterc == false && houseAreaAfter!=""){
		L5.Msg.alert("提示","用房面积格式不正确,整数最长不超过8位,小数2位！");
		return false;
	}
	if(houseAreaAfterc == "整数"){
		if(houseAreaAfter.length >8){
			L5.Msg.alert("提示","用房面积格式不正确,整数最长不超过8位！");
			return false;
		}
		return true;
	}
	if(byteLength(houseNameAfter)>100){
		L5.Msg.alert("提示","住所名称长度不能超过100个字符(50个汉字)！");
		return false;
	}
	if(byteLength(houseBorgAfter)>100){
		L5.Msg.alert("提示","产权单位长度不能超过100个字符(50个汉字)！");
		return false;
	}
	if(byteLength(houseDateAfter)>100){
		L5.Msg.alert("提示","租借期限长度不能超过100个字符(50个汉字)！");
		return false;
	}

	if(byteLength(houseReason)>500){
		L5.Msg.alert("提示","变更理由长度不能超过500个字符(250个汉字)！");
		return false;
	}
	return true;
}
//业务范围变更限制
function businessChangeCheck(){
	var businessNameAfter=document.getElementById('businessNameAfter').value;
	
	var businessReason=document.getElementById('businessReason').value;
	if(byteLength(businessNameAfter)>100){
		L5.Msg.alert("提示","业务范围长度不能超过100个字符(50个汉字)！");
		return false;
	}
	
	if(byteLength(businessReason)>500){
		L5.Msg.alert("提示","变更理由长度不能超过500个字符(250个汉字)！");
		return false;
	}
	return true;
}
//注册资金变更限制
function moneyChangeCheck(){
	var moneyAfter=document.getElementById('moneyAfter').value;
	var moneySourceAfter=document.getElementById('moneySourceAfter').value;
	
	
	var moneyReason=document.getElementById('moneyReason').value;
	//if(byteLength(moneyPeopleAfter)>72){
		//L5.Msg.alert("提示","增资出资人长度不能超过72个字符(36个汉字)！");
		//return false;
	//}
	//var moneyAfterc = checkMoneyFix(moneyAfter,2);
	if(byteLength(moneyAfter)>100){
		L5.Msg.alert("提示","金额长度不能超过100个字符(50个汉字)！");
		return false;
	}
	
	if(byteLength(moneySourceAfter)>500){
		L5.Msg.alert("提示","来源长度不能超过500个字符(250个汉字)！");
		return false;
	}
	
	if(byteLength(moneyReason)>500){
		L5.Msg.alert("提示","变更理由长度不能超过500个字符(250个汉字)！");
		return false;
	}
	return true;
}
//业务主管单位变更限制
function borgChangeCheck(){
	var borgNameAfter=document.getElementById('borgNameAfter').value;
	
	var borgReason=document.getElementById('borgReason').value;
	if(byteLength(borgNameAfter)>100){
		L5.Msg.alert("提示","业务主管单位长度不能超过100个字符(50个汉字)！");
		return false;
	}
	
	if(byteLength(borgReason)>500){
		L5.Msg.alert("提示","变更理由长度不能超过500个字符(250个汉字)！");
		return false;
	}
	return true;
}
//出资人变更限制
function monPeopleChangeCheck(){
	
	var monPeopleChangeAfter=document.getElementById('monPeopleChangeAfter').value;
	
	var monPeopleReason=document.getElementById('monPeopleReason').value;
	if(byteLength(monPeopleChangeAfter)>72){
		L5.Msg.alert("提示","出资人长度不能超过72个字符(36个汉字)！");
		return false;
	}
	
	if(byteLength(monPeopleReason)>500){
		L5.Msg.alert("提示","变更理由长度不能超过500个字符(250个汉字)！");
		return false;
	}
	return true;
}
//基金会住所变更
function fundHouseCheck(){
	var houseNameAfter=document.getElementById('houseNameAfter').value;

	var houseReason=document.getElementById('houseReason').value;
	if(houseNameAfter==''){
		L5.Msg.alert("提示","住所名称不能为空！");return false;
	}
	if(byteLength(houseNameAfter)>100){
		L5.Msg.alert("提示","住所名称长度不能超过100个字符(50个汉字)！");
		return false;
	}
	
	if(byteLength(houseReason)>500){
		L5.Msg.alert("提示","变更理由长度不能超过500个字符(250个汉字)！");
		return false;
	}
	return true;
}