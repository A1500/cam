function init(){
	var admNote1DataSet=L5.DatasetMgr.lookup("admNote1DataSet");
	admNote1DataSet.setParameter("organCode",organCode);
	admNote1DataSet.load(true);
	var admNote1D=L5.DatasetMgr.lookup("admNote1D");
	admNote1D.load(true);
	if(admNote1D.getCount()>0){
		var record  = admNote1D.getCurrent();
		document.getElementById("endTime").value=record.get("endTime");
	}
	
	
}
function query(){
	var admNote1DataSet=L5.DatasetMgr.lookup("admNote1DataSet");
	
	admNote1DataSet.load();
}
function saves(){

	if(document.getElementById("endTime").value==""){
		L5.Msg.alert("提示","请输入截至时间");
		return;
	}
	
	var notesRecords =[];
	var admNote1D = L5.DatasetMgr.lookup("admNote1D");
	var admNote1DataSet=L5.DatasetMgr.lookup("admNote1DataSet");
	//var records = admNote1DataSet.getAllChangedRecords();
	var records = admNote1DataSet.getAllRecords();
	for(var i=0;i<records.length; i++){
		if(records[i].get("CITY_NUM")){
			if(!_isNum(records[i].get("CITY_NUM"))){
				L5.Msg.alert("提示","列 '市' 请输入数字");
				return;
			}
		}
		
		if(records[i].get("COUNTRY_NUM")){
			if(!_isNum(records[i].get("COUNTRY_NUM"))){
				L5.Msg.alert("提示","列 '区县' 请输入数字");
				return;
			}
		}
		if(records[i].get("TOWN_NUM")){
			if(!_isNum(records[i].get("TOWN_NUM"))){
				L5.Msg.alert("提示","列 '乡镇' 请输入数字");
				return;
			}
		}
		/*else{
			L5.Msg.alert("提示","列 '乡镇' 不能为空");
			return;
		}
		*/
	}
	for(var i=0;i<records.length; i++) {
		var notes = admNote1D.newRecord();
		notes.set("code",records[i].get("CODE"));
		notes.set("name",records[i].get("NAME"));
		notes.set("cityNum",records[i].get("CITY_NUM"));
		notes.set("countryNum",records[i].get("COUNTRY_NUM"));
		notes.set("townNum",records[i].get("TOWN_NUM"));
		notes.set("villageNum",records[i].get("VILLAGE_NUM"));
		notes.set("endTime",getParam("endTime"));
		if(records[i].get("NAME").substring(2)=="省"){
			notes.set("note","截至"+getParam("endTime")+",辖"+records[i].get("CITY_NUM")+"个市,"+records[i].get("COUNTRY_NUM")+"个县(市、区),"+records[i].get("TOWN_NUM")+"个乡镇(街道)");
		}else if(records[i].get("NAME").substring(2)=="市"){
			notes.set("note","截至"+getParam("endTime")+",辖"+records[i].get("COUNTRY_NUM")+"个县(市、区),"+records[i].get("TOWN_NUM")+"个乡镇(街道)");
		}else if(records[i].get("CODE").substring(6)=="000000"){
			notes.set("note","截至"+getParam("endTime")+",辖"+records[i].get("TOWN_NUM")+"个乡镇(街道)");
		}
		notesRecords.push(notes);
	}
	
	var command=new L5.Command("com.inspur.cams.adm.note.base.cmd.AdmNoteCmd");
	command.setParameter("records",notesRecords);
	command.execute("save");
	if (!command.error){
		L5.Msg.alert("提示","保存成功！",function(){
			//returnBack();
			init();
		});
	}else{
		L5.Msg.alert("提示","保存出错！"+command.error);
	}
}
function del(){
	var grid=L5.getCmp("grid");
	var records=grid.getSelectionModel().getSelections();
	if(records.length!=1){
		L5.Msg.alert("提示","请先选中一行!");
		return;
	}
	L5.MessageBox.confirm("提示", "是否删除该数据？",function(sta){
		if(sta=="yes"){
			var command=new L5.Command("com.inspur.cams.adm.note.base.cmd.AdmNoteCmd");
			command.setParameter("code",records[0].get("CODE"));
			command.execute("delete");
			if (!command.error){
				var admNote1DataSet=L5.DatasetMgr.lookup("admNote1DataSet");
				admNote1DataSet.load();
			}else{
				L5.Msg.alert("提示","删除出错！");
			}
		}
	});
}
function CheckTxt(ObjNum, ChnName) {
	var regExp = /^\d+(\.\d+)?$/;
	var elementTxt = document.getElementById(ObjNum);
	if (regExp.test(elementTxt.value)) {
		return true;
	} else {
		L5.Msg.alert("提示","【"+ ChnName + "】请输入阿拉伯数字!");
		elementTxt.focus();
		elementTxt.value = "";
		return false;
	}
}
//校验数字
function checkNum(domId){
	if(document.getElementById(domId).value){
		if(!_isNum(document.getElementById(domId).value)){
			document.getElementById(domId).value="";
			L5.Msg.alert("提示","请输入数字");
			return;
		}
	}
}
function getParam(tag){
	return document.getElementById(tag).value;
}