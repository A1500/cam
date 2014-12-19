//初始化dataset
function init() {
	var complaintDataset = L5.DatasetMgr.lookup("complaintDataset");
	complaintDataset.load();
}
/**
 * @title:
 * @description:点击确定按钮时触发函数
 * @author:
 * @since:2011-06-08
 * @param
*/
function Evt_butsave_onclick(){
	var complaintDataset = L5.DatasetMgr.lookup("complaintDataset");
	var complaintRecord=complaintDataset.getCurrent();
	
	var valid = complaintDataset.isValidate();
	if(valid !== true){
		if(valid.indexOf("applyPeople")!=-1){
			valid=valid.replace("applyPeople","投诉人");
		}
		if(valid.indexOf("applyIdcard")!=-1){
			valid=valid.replace("applyIdcard","证件号码");
		}
		if(valid.indexOf("applyTel")!=-1){
			valid=valid.replace("applyTel","联系电话");
		}
		if(valid.indexOf("applyWay")!=-1){
			valid=valid.replace("applyWay","投诉方式");
		}
		if(valid.indexOf("handleResult")!=-1){
			valid=valid.replace("handleResult","受理结果");
		}
		L5.Msg.alert("提示","校验未通过，不能保存！"+valid);
		return false;
	}
	var command = new L5.Command("com.inspur.sdmz.apply.cmd.SamApplySaveCmd");
	command.setParameter("samapplyRecord", complaintRecord.toBean("com.inspur.sdmz.apply.data.SamApply"));
	command.execute("samapplybgUpdate");
	if (!command.error) {
			var url='jsp/sdmz/apply/complaintHandleList.jsp';
   		var text = '困难户信息查询';
   		L5.Msg.alert("提示","保存成功！",function(){L5.forward(url,text);});
	}else{
		L5.Msg.alert("错误",command.error);
	}
}
//点击取消按钮时触发的函数：返回跳转页
function Evt_butreturn_onclick(){
	var url='jsp/sdmz/apply/complaintHandleList.jsp';
    var text = '困难户信息查询';
    L5.forward(url,text);
}


