/**
 * 初始化页面定义
 */
function init(){
	var ds = L5.DatasetMgr.lookup("ds");
	ds.setParameter("ID",ID);
	ds.load();
}
/**
 * 返回功能
 */
function reset() {
	window.history.go(-1);
}
