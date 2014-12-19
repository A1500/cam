function init() {
	var decisionLetterDataset = L5.DatasetMgr.lookup("decisionLetterDataset");
	decisionLetterDataset.setParameter("PEOPLE_ID",peopleId);
	decisionLetterDataset.setParameter("APPLY_ID",applyId);
	decisionLetterDataset.setParameter("organId",organId);
	decisionLetterDataset.load();
	decisionLetterDataset.on("load",function setService () {
	if(serviceType=='11'){
		decisionLetterDataset.set("serviceType",'0');
	}else if(serviceType=='12'){
		decisionLetterDataset.set("serviceType",'1');
	}else{
		decisionLetterDataset.set("serviceType",serviceType);
	}
	});
	L5.QuickTips.init();
}



function saveClick() {
	var decisionLetterDataset = L5.DatasetMgr.lookup("decisionLetterDataset");
	var decisionLetterRecord = decisionLetterDataset.getCurrent();
	decisionLetterDataset.set("peopleId",peopleId);
	decisionLetterDataset.set("applyId",applyId);
	decisionLetterDataset.set("organId",organId);
	var isValidate = decisionLetterDataset.isValidate();
	var s = document.getElementById("foundation");
	var c = document.getElementById("clause");
	
	if (isValidate != true) {
		L5.Msg.alert('提示',isValidate);
		return false;
	}
	
	var decisionDate = decisionLetterDataset.get("decisionDate");
	if(decisionDate!=''&&!validateDateFormat(decisionDate)){
		L5.Msg.alert('提示',"出具时间格式不正确！");
		return false;
	}
	
	var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptDecisionLetterCommand");
	command.setParameter("record", decisionLetterRecord);
	command.execute("updateDecisionLetter");
	if (!command.error) {
		L5.Msg.alert('提示', "数据保存成功!");
		falg=1;
	} else {
		L5.Msg.alert('提示', "保存时出现错误！" + command.error);
	}
}

function func_Close(){	
	window.close();
}
function change(s){
	 if(s.options[4].selected||s.options[5].selected){
	 var decisionLetterDataset = L5.DatasetMgr.lookup("decisionLetterDataset");
	 decisionLetterDataset.set("clause","");
	 document.getElementById("clause").value = "";
     document.getElementById("clause").disabled = "disabled";
	}else{
		document.getElementById("clause").disabled = false;
	}
}



function print() {
	var decisionLetterDataset = L5.DatasetMgr.lookup("decisionLetterDataset");
	var decisionLetterRecord=decisionLetterDataset.getCurrent();
	
	if(decisionLetterRecord.get("serviceType")==0){
		document.getElementById("docpath").value="jsp/cams/bpt/flow/disability/assessdisability/print/appraiseDecisionLetter.doc"
	}else if(decisionLetterRecord.get("serviceType")==1){
		document.getElementById("docpath").value="jsp/cams/bpt/flow/disability/assessdisability/print/adjustDecisionLetter.doc"
	}
	var url="../../../../comm/print/jspcommonprint.jsp?";
	var width = 1024;
	var height = 768;
    window.showModalDialog(url,window,"scroll:yes;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:1");
}