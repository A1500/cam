function init() {
	var decisionLetterDataset = L5.DatasetMgr.lookup("decisionLetterDataset");
	decisionLetterDataset.setParameter("PEOPLE_ID",peopleId);
	decisionLetterDataset.setParameter("APPLY_ID",applyId);
	decisionLetterDataset.setParameter("organId",organId);
	decisionLetterDataset.load();
	L5.QuickTips.init();
}



function saveClick() {
	var decisionLetterDataset = L5.DatasetMgr.lookup("decisionLetterDataset");
	var decisionLetterRecord = decisionLetterDataset.getCurrent();
	decisionLetterDataset.set("peopleId",peopleId);
	decisionLetterDataset.set("applyId",applyId);
	decisionLetterDataset.set("organId",organId);
	var isValidate = decisionLetterDataset.isValidate();
	if (isValidate != true) {
		L5.Msg.alert('提示',isValidate);
		return false;
	}
	var decisionDate = decisionLetterRecord.get("decisionDate");
	if(decisionDate!=''&&!validateDateFormat(decisionDate)){
		L5.Msg.alert("提示","出具时间格式不正确！");
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




function print() {
	var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptDecisionLetterCommand");
	command.setParameter("applyId", applyId);
	command.execute("ifHave");
	var num = command.getReturn("ifhave");
	
	if(num){
		var url="../../../../comm/print/jspcommonprint.jsp?";
		var width = 1024;
		var height = 768;
	    window.showModalDialog(url,window,"scroll:yes;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:1");
	}else{
		L5.Msg.alert('提示', "请先保存认定信息！");
	}
}