function init(){
	var samCheckDetailDataSet=L5.DatasetMgr.lookup("samCheckDetailDataSet");
	samCheckDetailDataSet.setParameter("gerocomiumId",gerocomiumId);
	samCheckDetailDataSet.setParameter("checkDate",checkDate);
	samCheckDetailDataSet.load();
}
function query(){
	var samCheckDetailDataSet=L5.DatasetMgr.lookup("samCheckDetailDataSet");
	samCheckDetailDataSet.setParameter("gerocomiumId",gerocomiumId);
	samCheckDetailDataSet.setParameter("checkDate",checkDate);
	samCheckDetailDataSet.setParameter("personName",document.getElementById("personNameQuery").value);
	samCheckDetailDataSet.setParameter("idCard",document.getElementById("idCardQuery").value);
	samCheckDetailDataSet.setParameter("inRoom",document.getElementById("inRoomQuery").value);
	samCheckDetailDataSet.setParameter("inBed",document.getElementById("inBedQuery").value);
	samCheckDetailDataSet.load();
}
function returnBack(){
	window.close();
}