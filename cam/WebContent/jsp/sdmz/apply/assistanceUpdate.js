/**
	 * 初始化
	 * @param 
	 * @return
	 */
function init() {
	var applyDataset = L5.DatasetMgr.lookup("applyDataset");
	
	applyDataset.load();
	
}

/**
	 * 确定保存按钮
	 * @param 
	 * @return
	 */
function Evt_butsave_onclick(){
	var applyDataset = L5.DatasetMgr.lookup("applyDataset");
	var applyRecord=applyDataset.getCurrent();
	
	var valid = applyDataset.isValidate();
	if(valid !== true){
		if(valid.indexOf("applyPeople")!=-1){
			valid=valid.replace("applyPeople","申请人");
		}
		if(valid.indexOf("applyIdcard")!=-1){
			valid=valid.replace("applyIdcard","身份证号");
		}
		if(valid.indexOf("applyTel")!=-1){
			valid=valid.replace("applyTel","联系电话");
		}
		if(valid.indexOf("applyPeopleNum")!=-1){
			valid=valid.replace("applyPeopleNum","家庭人口");
		}
		if(valid.indexOf("applyWay")!=-1){
			valid=valid.replace("applyWay","申请方式");
		}
		if(valid.indexOf("handleResult")!=-1){
			valid=valid.replace("handleResult","受理结果");
		}
	
		L5.Msg.alert("提示","校验未通过，不能保存！"+valid);
		return false;
	}
	var command = new L5.Command("com.inspur.sdmz.apply.cmd.SamApplySaveCmd");
	command.setParameter("samapplyRecord", applyRecord.toBean("com.inspur.sdmz.apply.data.SamApply"));
	command.execute("samapplybgUpdate");
	if (!command.error) {
			var url='jsp/sdmz/apply/assistanceHandleList.jsp';
   		var text = '困难户信息查询';
   		L5.Msg.alert("提示","保存成功！",function(){L5.forward(url,text);});
	}else{
		L5.Msg.alert("错误",command.error);
	}
}
/**
	 * 返回按钮
	 * @param 
	 * @return
	 */
function Evt_butreturn_onclick(){
	var url='jsp/sdmz/apply/assistanceHandleList.jsp';
    var text = '困难户信息查询';
    L5.forward(url,text);
}
