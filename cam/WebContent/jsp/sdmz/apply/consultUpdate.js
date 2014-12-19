//初始化

function init() {
	var consultDataset = L5.DatasetMgr.lookup("consultDataset");
	
	consultDataset.load();
	
}
//点击确定按钮处理函数。
function Evt_butsave_onclick(){
	var consultDataset = L5.DatasetMgr.lookup("consultDataset");
	var consultRecord=consultDataset.getCurrent();
	
	var valid = consultDataset.isValidate();
	if(valid !== true){
		if(valid.indexOf("applyPeople")!=-1){
			valid=valid.replace("applyPeople","咨询人");
		}
		if(valid.indexOf("applyIdcard")!=-1){
			valid=valid.replace("applyIdcard","身份证号");
		}
		if(valid.indexOf("applyWay")!=-1){
			valid=valid.replace("applyWay","咨询方式");
		}
		if(valid.indexOf("applyTel")!=-1){
			valid=valid.replace("applyTel","联系电话");
		}
		if(valid.indexOf("handleResult")!=-1){
			valid=valid.replace("handleResult","受理结果");
		}
		L5.Msg.alert("提示","校验未通过，不能保存！"+valid);
		return false;
	}
	var command = new L5.Command("com.inspur.sdmz.apply.cmd.SamApplySaveCmd");
	command.setParameter("samapplyRecord", consultRecord.toBean("com.inspur.sdmz.apply.data.SamApply"));
	command.execute("samapplybgUpdate");
	if (!command.error) {
			var url='jsp/sdmz/apply/consultHandleList.jsp';
   		var text = '困难户信息查询';
   		L5.Msg.alert("提示","保存成功！",function(){L5.forward(url,text);});
	}else{
		L5.Msg.alert("错误",command.error);
	}
}
//点击返回按钮处理函数
function Evt_butreturn_onclick(){
	var url='jsp/sdmz/apply/consultHandleList.jsp';
    var text = '困难户信息查询';
    L5.forward(url,text);
}


