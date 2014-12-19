function init(){
	var DisabilityApproveDataset = L5.DatasetMgr.lookup("DisabilityApproveDataset");
	DisabilityApproveDataset.setParameter("APPLY_ID",applyId);
	DisabilityApproveDataset.load();
	L5.QuickTips.init();
}

function save(){
	var DisabilityApproveDataset = L5.DatasetMgr.lookup("DisabilityApproveDataset");
	var DisabilityApproveRecord=DisabilityApproveDataset.getCurrent();
	
	//校验换证、补证原因是否为空
	var exchangeReason = _$("exchangeReason");
	if(exchangeReason==''){
		L5.Msg.alert('提示',"换证、补证原因不能为空!");
		return false;
	}
	
	var isValidate = DisabilityApproveDataset.isValidate();
	if(isValidate != true){
		L5.Msg.alert('提示',"校验未通过,不能保存!"+isValidate);
		return false;
	}
	var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptApplyDisabilityCommand");
	command.setParameter("record", DisabilityApproveRecord);
	command.execute("update");
	if (!command.error) {
		L5.Msg.alert('提示',"数据保存成功!");
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}

function func_Close(){
	window.close();
}

//查看人员详细链接
function detail(value){
	if(value!=''){
		var peopleId = DisabilityApproveDataset.getCurrent().get("peopleId");
		var familyId = DisabilityApproveDataset.getCurrent().get("familyId");
		var url='../assessdisability/disabilityDetailManage.jsp?peopleId='+peopleId+'&familyId='+familyId;
		return "<a href='#' style='color:blue' onclick='openWindow(\""+url+"\")'>"+value+"</a>";
	}
}

function openWindow(url){
        var width = 800;
		var height = 500;
		var win =window.showModalDialog (url,window,"scroll:yes;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:1");
		if (win == null) {
			return;
		}
}

function print() {
	var url="../../../../comm/print/jspcommonprint.jsp?";
	var text='鉴定介绍信打印';
	var width = 1024;
	var height = 768;
    window.showModalDialog(url,window,"scroll:yes;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:1");
}
