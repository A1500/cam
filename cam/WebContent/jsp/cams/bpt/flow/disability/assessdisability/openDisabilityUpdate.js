function init(){
	var BptDisabilityOpenDataSet= L5.DatasetMgr.lookup("BptDisabilityOpenDataSet");
	BptDisabilityOpenDataSet.setParameter("peopleId",peopleId);
	BptDisabilityOpenDataSet.setParameter("applyId",applyId);
	BptDisabilityOpenDataSet.setParameter("organId",organId);
	BptDisabilityOpenDataSet.load();
	L5.QuickTips.init();
	
	if(adjust == "adjust") {
		document.getElementById("docpath").value = "jsp/cams/bpt/flow/disability/assessdisability/table/open_disability_apptable_adjust.doc";
	}
}

function save(){
	var BptDisabilityOpenDataSet = L5.DatasetMgr.lookup("BptDisabilityOpenDataSet");
	var BptDisabilityOpenRecord=BptDisabilityOpenDataSet.getCurrent();
	BptDisabilityOpenRecord.set("peopleId", peopleId);
	BptDisabilityOpenRecord.set("applyId", applyId);
	BptDisabilityOpenRecord.set("organId", document.getElementById("organId").value);
	var isValidate = BptDisabilityOpenDataSet.isValidate();
	if(isValidate != true){
		L5.Msg.alert("提示",isValidate);
		return false;
	}
	var openstartDate = BptDisabilityOpenDataSet.get("openstartDate");
	if(openstartDate!=''&&!validateDateFormat(openstartDate)){
		L5.Msg.alert("提示","公示时间(起)格式不正确！");
		return false;
	}
	
	var openendDate = BptDisabilityOpenDataSet.get("openendDate");
	if(openendDate!=''&&!validateDateFormat(openendDate)){
		L5.Msg.alert("提示","公示时间(止)格式不正确！");
		return false;
	}
	
	var disabilityDate = BptDisabilityOpenDataSet.get("disabilityDate");
	if(disabilityDate!=''&&!validateDateFormat(disabilityDate)){
		L5.Msg.alert("提示","致残时间格式不正确！");
		return false;
	}
	
	var openDate = BptDisabilityOpenDataSet.get("openDate");
	if(openDate!=''&&!validateDateFormat(openDate)){
		L5.Msg.alert("提示","公示书出具时间格式不正确！");
		return false;
	}
	
	
	
	var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptDisabilityOpenCommand");
	
	command.setParameter("BptPeopleDisabilityRecord", BptDisabilityOpenRecord);
	command.execute("updateOpen");
	
	if (!command.error) {
		BptDisabilityOpenDataSet.getCurrent().state = L5.model.Record.STATE_MODIFIED;
		L5.Msg.alert('提示','保存成功！');
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}
function print() { // 跳转打印页面
	var url="../../../../comm/print/jspcommonprint.jsp?";
	var width = 1024;
	var height = 768;
    window.showModalDialog(url,window,"scroll:yes;status:no;dialogWidth:"+width+"px;dialogHeight:"+height+"px;resizable:1");
}
