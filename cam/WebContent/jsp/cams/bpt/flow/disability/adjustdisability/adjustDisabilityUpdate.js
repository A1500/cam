function init(){
	var DisabilityApproveDataset = L5.DatasetMgr.lookup("DisabilityApproveDataset");
	DisabilityApproveDataset.setParameter("APPLY_ID",applyId);
	DisabilityApproveDataset.load();
	L5.QuickTips.init();
	L5.getCmp("openTabPanel").on("activate",function(){
		var src = document.getElementById("openIframe").src;
		document.getElementById("openIframe").src=src;
	});
	L5.getCmp("adjustPanel").on("activate",function(){
		var src = document.getElementById("adjustIframe").src;
		document.getElementById("adjustIframe").src=src;
	});
}

function save(){
	var DisabilityApproveDataset = L5.DatasetMgr.lookup("DisabilityApproveDataset");
	var DisabilityApproveRecord=DisabilityApproveDataset.getCurrent();
	DisabilityApproveRecord.set("peopleId",peopleId);
	

	
	var isValidate = DisabilityApproveDataset.isValidate();
	if(isValidate != true){
		L5.Msg.alert('提示',"校验未通过,不能保存!"+isValidate);
		return false;
	}
	var  disabilityDate = DisabilityApproveRecord.get("disabilityDate");
	if(disabilityDate!=''&&!validateDateFormat(disabilityDate)){
		L5.Msg.alert('提示',"致残时间格式不正确!");
		return false;
	}
	var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptApplyDisabilityCommand");
	command.setParameter("record", DisabilityApproveRecord);
	command.execute("update");
	if (!command.error) {
		DisabilityApproveDataset.reload();
		L5.Msg.alert('提示',"数据保存成功!");
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}

function func_Close(){
	window.close();
}

function detail(value){
	if(value!=''){
		var peopleId = DisabilityApproveDataset.getCurrent().get("peopleId");
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
	var DisabilityApproveDataset = L5.DatasetMgr.lookup("DisabilityApproveDataset");
	var DisabilityApproveRecords=DisabilityApproveDataset.getAllChangedRecords();
	if(DisabilityApproveRecords.length==0){
		var url="../../../../comm/print/jspcommonprint.jsp?";
		var text='调整伤残等级审批表';
		var width = 1024;
		var height = 768;
	    window.showModalDialog(url,window,"scroll:yes;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:1");
	}else{
		L5.Msg.alert('提示',"请先保存数据!");
	}
}