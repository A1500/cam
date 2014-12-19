function querySorgOrganMess(){
	$("sorgId").value="";
	$("sorgName").innerHTML="";
	$("sorgType").innerHTML="";
	var sorgCode=_$("sorgCode").trim();
	if(sorgCode!=""){
	var organDataSet=L5.DatasetMgr.lookup("organDataSet");
	organDataSet.setParameter("SOM_ORGAN.SORG_CODE@=",sorgCode);
	organDataSet.load();
	organDataSet.on('load',queryOrgan);
	}
}	
function queryOrgan(organDataSet){
	if(organDataSet.getCount()==0){
		L5.Msg.alert("提示","此登记证号不存在,请重新填写！");
		$("sorgCode").value="";
		return;
	}else if("32"==organDataSet.getCurrent().get("sorgStatus") || "62"==organDataSet.getCurrent().get("sorgStatus")){
		L5.Msg.alert("提示","此社会组织已注销！");
		return;
	}else if("52"==organDataSet.getCurrent().get("sorgStatus")){
		L5.Msg.alert("提示","此社会组织已撤销！");
		return;
	}else if("22"==organDataSet.getCurrent().get("sorgStatus")){
		record=organDataSet.getCurrent();
		$("sorgCode").value=record.get("sorgCode");
		$("sorgId").value=record.get("sorgId");
		$("sorgName").innerHTML=record.get("cnName");
		$("sorgType").innerHTML=record.get("sorgType");
	}else{
		L5.Msg.alert("提示","此社会组织未正式成立！");
		return;
	}
}