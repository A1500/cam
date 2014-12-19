//初始化
function init() {
	var ds=L5.DatasetMgr.lookup("jzfamxDataset");
	ds.setParameter("SAM_PLAN_DETAIL.ASSISTED_ID@=",szdxId);
	ds.load();
}
//返回按钮
function undo(){
var url='jsp/ext/esurey/jzfa/jzfafxAnalyze.jsp?jzfaids='+jzfaids;
	var text = '救助方案明细';
	L5.forward(url,text);
}