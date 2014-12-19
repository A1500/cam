/*
 * 初始化操作
 */
function init(){
	var responseDataset = L5.DatasetMgr.lookup("responseDataset");
	responseDataset.baseParams["id@=@String"] =informId;
	responseDataset.load();
}
/*
 * 执行查询
 */
function search(){
	var receiveman=document.getElementById("filter").value.toUpperCase();
	var responseDataset = L5.DatasetMgr.lookup("responseDataset");
	responseDataset.baseParams["receiveman@like@String"] = receiveman;
	responseDataset.load();
}
/*
 * 点击【返回】
 */
function click_back(){
	parent.history.back();
	return;
}