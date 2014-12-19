function init() {
	var ds=L5.DatasetMgr.lookup("ds");
	if(method=="insert"){
		ds.newRecord({"prop" : "1"});	
	}else{
		ds.setParameter("ORGAN_ID@",organID);
		ds.load();
	}
	L5.QuickTips.init();
}
	
function reset(){
	window.close();
}	
