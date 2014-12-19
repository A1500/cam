function init(){
	var BptOpenLetterDataSet= L5.DatasetMgr.lookup("BptOpenLetterDataSet");
	BptOpenLetterDataSet.setParameter("peopleId",peopleId);
	BptOpenLetterDataSet.setParameter("applyId",applyId);
	BptOpenLetterDataSet.setParameter("organId",organId);
	BptOpenLetterDataSet.load();
	L5.QuickTips.init();
	
}
function getDateDiff(date){
	var date2 = document.getElementById("openendDate").value;
	var date1 = document.getElementById("openstartDate").value;
     var arr1=date1.split('-');
	 var arr2=date2.split('-');
	 var d1=new Date(arr1[0],arr1[1],arr1[2]);
	 var d2=new Date(arr2[0],arr2[1],arr2[2]);
	 //alert((d2.getTime()-d1.getTime())/(1000*3600*24));
	 if((d2.getTime()-d1.getTime())/(1000*3600*24)<0){
	 	alert("公示时间错误!");
	 	date.value="";
	 	return ;
	 }
	 document.getElementById("openDays").value=(d2.getTime()-d1.getTime())/(1000*3600*24);
}
function save(){
	var BptOpenLetterDataSet = L5.DatasetMgr.lookup("BptOpenLetterDataSet");
	var BptOpenLetterRecord=BptOpenLetterDataSet.getCurrent();
	BptOpenLetterRecord.set("peopleId", peopleId);
	BptOpenLetterRecord.set("applyId", applyId);
	BptOpenLetterRecord.set("organId", document.getElementById("organId").value);
	var isValidate = BptOpenLetterDataSet.isValidate();
	if(isValidate != true){
		L5.Msg.alert("提示",isValidate);
		return false;
	}
	var openstartDate = BptOpenLetterDataSet.get("openstartDate");
	if(openstartDate!=''&&!validateDateFormat(openstartDate)){
		L5.Msg.alert("提示","公示时间(起)格式不正确！");
		return false;
	}
	
	var openendDate = BptOpenLetterDataSet.get("openendDate");
	if(openendDate!=''&&!validateDateFormat(openendDate)){
		L5.Msg.alert("提示","公示时间(止)格式不正确！");
		return false;
	}
	
	
	var openDate = BptOpenLetterDataSet.get("openDate");
	if(openDate!=''&&!validateDateFormat(openDate)){
		L5.Msg.alert("提示","公示书出具时间格式不正确！");
		return false;
	}
	
	
	
	var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptOpenLetterCommand");
	
	command.setParameter("BptOpenLetterRecord", BptOpenLetterRecord);
	command.execute("updateOpen");
	
	if (!command.error) {
		BptOpenLetterDataSet.getCurrent().state = L5.model.Record.STATE_MODIFIED;
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
