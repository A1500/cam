function init() {
	var ds=L5.DatasetMgr.lookup("ds");
	ds.setParameter("CEME_ID",unitId);
	ds.load();
}		
function reset(){
	window.close();
}