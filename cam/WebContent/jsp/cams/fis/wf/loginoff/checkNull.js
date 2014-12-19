function check(record){
	var code = record.get("code")
	if(organType=="14"){
		if(code.substring(1,3)>"10"){
			L5.Msg.alert('提示',"您的行政等级不符合当前操作");
			return false;
		}
	}else if(organType=="13"){
		if(code.substring(1,3)>"20"||code.substring(1,3)<"11"){
			L5.Msg.alert('提示',"您的行政等级不符合当前操作");
			return false;
		}
	}else if(organType=="12"){
		if(code.substring(1,3)>"30"||code.substring(1,3)<"21"){
			L5.Msg.alert('提示',"您的行政等级不符合当前操作");
			return false;
		}
	}else if(organType=="11"){
		if(code.substring(1,3)>"40"||code.substring(1,3)<"31"){
			L5.Msg.alert('提示',"您的行政等级不符合当前操作");
			return false;
		}
	}
	return true;
}

function checkValidate(){
	var fisCemeDataSet = L5.DatasetMgr.lookup("fisCemeDataSet");
	var isValidate2 = fisCemeDataSet.isValidate();
	if (isValidate2 != true) {
		L5.Msg.alert("错误", "无法通过校验！" + isValidate2);
		return false;
	}
	var fisCemeLogoffDs = L5.DatasetMgr.lookup("fisCemeLogoffDs");
	var isValidate3 = fisCemeLogoffDs.isValidate();
	if (isValidate3 != true) {
		L5.Msg.alert("错误", "无法通过校验！" + isValidate3);
		return false;
	}
	var cemeLogoffOpinionDs = L5.DatasetMgr.lookup("cemeLogoffOpinionDs");
	var isValidate1 = cemeLogoffOpinionDs.isValidate();
	if (isValidate1 != true) {
		L5.Msg.alert("错误", "无法通过校验！" + isValidate1);
		return false;
	}
	var fisCemeApplyInfoDs = L5.DatasetMgr.lookup("fisCemeApplyInfoDs");
	var isValidate0 = fisCemeApplyInfoDs.isValidate();
	if (isValidate0 != true) {
		L5.Msg.alert("错误", "无法通过校验！" + isValidate0);
		return false;
	}
	return true;
}
function checkValidate2(){
	var fisCemeApplyInfoDs = L5.DatasetMgr.lookup("fisCemeApplyInfoDs");
	var isValidate0 = fisCemeApplyInfoDs.isValidate();
	if (isValidate0 != true) {
		L5.Msg.alert("错误", "无法通过校验！" + isValidate0);
		return false;
	}
	return true;
}