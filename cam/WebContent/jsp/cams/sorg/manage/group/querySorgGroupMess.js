function querySorgGroupMess(){
	$("sorgId").value="";
	$("cnName").innerHTML="";
	var sorgCode=_$("sorgCode").trim();
	if(sorgCode!=""){
	var organDataSet=L5.DatasetMgr.lookup("organDataSet");
	organDataSet.setParameter("SOM_ORGAN.SORG_TYPE@=","S");
	organDataSet.setParameter("SOM_ORGAN.SORG_CODE@=",sorgCode);
	organDataSet.load();
	organDataSet.on('load',queryGroup);
    }
}	
function queryGroup(organDataSet){
	if(organDataSet.getCount()==0){
		L5.Msg.alert("提示","此登记证号不存在,请重新填写！");
		$("sorgCode").value="";
		return;
	}else if("32"==organDataSet.getCurrent().get("sorgStatus") || "62"==organDataSet.getCurrent().get("sorgStatus")){
		L5.Msg.alert("提示","此社团已注销，不可以进行备案！");
		return;
	}else if("52"==organDataSet.getCurrent().get("sorgStatus")){
		L5.Msg.alert("提示","此社团已撤销，不可以进行备案！");
		return;
	}else if("22"==organDataSet.getCurrent().get("sorgStatus")){
		record=organDataSet.getCurrent();
		$("sorgCode").value=record.get("sorgCode");
		$("sorgId").value=record.get("sorgId");
		$("cnName").innerHTML=record.get("cnName");
	}else{
		L5.Msg.alert("提示","此社团未正式成立，不可以进行备案！");
		return;
	}
}