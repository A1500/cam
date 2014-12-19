function init(){
	var hisDs = L5.DatasetMgr.lookup("hisDs");
	hisDs.setParameter("cemeApplyId",cemeApplyId);
	hisDs.load();
}

//单击返回按钮
function returnClick(){
	history.go(-1);
}