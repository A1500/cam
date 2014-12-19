function init() {
	L5.QuickTips.init();
};

function getParam(ElementId){
	var value=document.getElementById(ElementId).value;
	if(value=="") value=undefined;
	return value;
}

function query(){
	var NonCompulsoryDataset=L5.DatasetMgr.lookup("NonCompulsoryDataset");
	var shouldTimeStart =document.getElementById("shouldTimeStart").value;
	if(shouldTimeStart==''){
	   L5.Msg.alert('提示',"应发日期(起)不能为空!");
	   return false;
	}
	if(shouldTimeStart!=''&&!validateDateFormat(shouldTimeStart+'-01')){
		L5.Msg.alert("提示","应发日期(起)格式不正确！");
		return false;
	}
	var shouldTimeEnd =document.getElementById("shouldTimeEnd").value;
	if(shouldTimeEnd==''){
	   L5.Msg.alert('提示',"应发日期(止)不能为空!");
	   return false;
	}
	if(shouldTimeEnd!=''&&!validateDateFormat(shouldTimeEnd+'-01')){
		L5.Msg.alert("提示","应发日期(止)格式不正确！");
		return false;
	}
	
	if(shouldTimeStart>shouldTimeEnd){
	  L5.Msg.alert('提示',"应发日期(止)不能早于应发日期(起)!");
	   return false;
	}		
	
 	var command=new L5.Command("com.inspur.cams.bpt.manage.cmd.BptCompulsoryDetailsCommand");
 	command.setParameter("xzqh",organCode);	
	command.setParameter("ffsj_q",document.getElementById("shouldTimeStart").value);
	command.setParameter("ffsj_z",document.getElementById("shouldTimeEnd").value);
 	command.execute("queryNonCompulsoryGenerateData");
 	var mcid = command.getReturn("mcid");
 	NonCompulsoryDataset.setParameter("registerId",mcid);
 	NonCompulsoryDataset.load();
 	/*NonCompulsoryDataset.on("load", function getCountsOfDs(){
 		var x = NonCompulsoryDataset.getAllRecords();
 		if(x.length==0){
 			L5.Msg.alert("提示","发放期间不存在标准！");
 			return false;
 		}
 	});*/
}
	

function save(){
	var generateDate = document.getElementById("generateDate").value
	if(generateDate==""){
	  L5.Msg.alert('提示',"生成日期不能为空!");
	   return false;
	}
    var records = NonCompulsoryDataset.getAllRecords();
	if(records.length<1){
		L5.Msg.alert('提示','没有需要保存的数据!');
		return false;
	}
	var command = new L5.Command("com.inspur.cams.bpt.manage.cmd.BptCompulsoryDetailsCommand");
	command.setParameter("records", records);
	command.execute("updateNonCompul");
	if (!command.error) {
		NonCompulsoryDataset.commitChanges();
		L5.Msg.alert('提示',"数据保存成功!");
	}else{
		L5.Msg.alert('提示',"保存时出现错误！"+command.error);
	}
}

function fun_close(){
    window.close();
}