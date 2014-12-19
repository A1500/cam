function init() {
	var ds = L5.DatasetMgr.lookup("ds");
	ds.setParameter("RECORD_ID", recordId);
	ds.load();
}
function goBack() {
	history.go(-1);
}

function print(){

}